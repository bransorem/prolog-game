
/* =============================================================== */
/* ======================= Interaction =========================== */
:- dynamic i_am_at/1, at/2, at/3, holding/1, locked/1, history/1,
            visible/2, constrained_by/2, start_time/3, deadline/3.


%===================================
%===================================
% SAVE/LOAD
%===================================  
save_dat([], _).

save_dat(History, Stream) :-
        [H|T] = History,
        string_concat(H, '.', Val),
        write(Stream, Val),
        nl(Stream),
        save_dat(T, Stream).


save_game(File) :-  enoughtime,

        % store time elapsed for next run
        elapsed_time(H, M, S),
        string_concat('load_time(', H, T1), string_concat(T1, ',', T2), string_concat(T2, M, T3),
            string_concat(T3, ',', T4), string_concat(T4, S, T5), string_concat(T5, ')', Time),
        history_add(Time),
        
        
        history(History),               % get history for saving to file
        file_extension(EXT),
        string_concat('saves/', File, Dir),
        string_concat(Dir, EXT, Filename), % prepare file for writing
        
        open(Filename, write, Stream),
        save_dat(History, Stream),
        close(Stream), !.
%===================================  

/* BUG -- saves to file - creates multiple load_time() actions. */
/*autosave :-
        get_time(T),
        stamp_date_time(T, date(_,Mo,D, _, _, _, _,_,_), 'local'),
        string_concat('autosaves/autosave-', Mo, SM), string_concat(SM, '-', SMD),
        string_concat(SMD, D, SD), string_concat(SD, '-', SDD),
        i_am_at(Place),
        string_concat(SDD, Place, File),
        save_game(File).*/
autosave.
        
autosaves :-
        directory_files('saves/autosaves/', Saves),
        [_, _|T] = Saves,
        auto(T).
        
auto([]).
auto([H|T]) :-
        tab(4), write(H), nl,
        auto(T).


%===================================        
remove_holding(holding([])).

remove_holding(holding([H|T])) :-
        retract(holding(H)),
        remove_holding(T).
%===================================        




%===================================  
load_dat(Stream, []) :-
        at_end_of_stream(Stream).
        
load_dat(Stream, [H|T]) :-
        \+ at_end_of_stream(Stream),
        read(Stream,H),
        call((H; true)), nl,            % fails if history item fails, must include ;true
        load_dat(Stream,T).
        
        
load_time(LH, LM, LS) :-
        deadline(DH, DM, DS),
        
        Dead is +(*(DH, 3600), +(*(DM, 60), DS)),
        LoadTime is +(*(LH, 3600), +(*(LM, 60), LS)),
        
        Time is -(Dead, LoadTime),      % take off time already used
        
        H is floor( /( Time, 3600 ) ),
        M is floor( /( -(Time, *(H, 3600)), 60) ),
        S is floor( -(Time, +( *(H, 3600), *(M, 60)) )),
        
        retract(deadline(DH, DM, DS)),
        assert(deadline(H, M, S)).


load_game(File) :-
        i_am_at(Place), retract(i_am_at(Place)),
        retract(history(_)),            % flush history
        assert(history([])),
        retract(start_time(_, _, _)),   % if started before load, remove start time
        
        file_extension(EXT),
        string_concat('saves/', File, Dir),
        string_concat(Dir, EXT, Filename),
        
        open(Filename, read, Stream),
        load_dat(Stream, _),
        close(Stream), !.
%===================================  
%===================================
%===================================
%===================================



%===================================
%===================================
% HISTORY
%===================================  
history([]).
        
        
history_add(Item) :-
        start_time(_, _, _),            % make sure they've started the game, otherwise, no history added
        history(History),
        append(History, [Item], NewHistory),
        retract(history(History)),
        assert(history(NewHistory)).
%===================================  
        


/* =========================================================== */
/* =========================================================== */
/* =========================================================== */

/* use(Object, Thing) removes constraint from constrained object */
/* use Object on Thing */

use(Object, Thing) :- enoughtime,
        (string_concat('use(', Object, Obj), string_concat(Obj, ', ', 
                        Objct), string_concat(Objct, Thing, Ob),
                        string_concat(Ob, ')', Data),
         history_add(Data), 
         
        (unlocks(Object, Thing),                 % unlocks Thing
         i_am_at(Place), object(Thing, Place),
         retract(constrained_by(_, Thing)),
         action(Thing)), !;
         
        (holding(Object), holding(Thing),         % combine to objects
         merge(Object, Thing, NewThing),
         retract(holding(Object)),
         retract(holding(Thing)),
         assert(holding(NewThing)),
         action(NewThing)), !;
         
        (holding(Thing), Number is (Object mod 1), % test number (object) on Thing
         Number >= 0,
         merge(Object, Thing, NewThing),
         retract(holding(Thing)),
         assert(holding(NewThing)),
         action(NewThing))).
         
         
                
use(Object) :- enoughtime,
        (string_concat('use(', Object, Obj), string_concat(Obj, ')', Data),
         history_add(Data),
         (i_am_at(Place),                    % get location
         at(Thing, Place, Direction),
         action(Object),                    % call object's action
         retract(at(Thing, Place, Direction)),
         assert(at(Thing, Place))
        ), !;
        (d_use_nothing)).
        
        

/* User interactions */

/* Face a certain direction, tells user what exists in that direction */
face(Direction) :- enoughtime,
        ((Direction == n);         % make sure it is a valid direction
            (Direction == e);
         (Direction == s);
         (Direction == w)), !,
          
        look(Direction).
                    
            
/* look at thing or in direction */
look(Thing) :- enoughtime,
    (string_concat('look(', Thing, Obj), string_concat(Obj, ')', Data),
     history_add(Data),
        i_am_at(Place),                    % get place
        
        ((((Thing == n), view(Place, See, _, _, _)), !;        % look in a direction
         ((Thing == e), view(Place, _, See, _, _)), !;
         ((Thing == s), view(Place, _, _, See, _)), !;
         ((Thing == w), view(Place, _, _, _, See))), 
         d_look_place(See)
         % visible(Place, Thing, Object), 
         %object(Object, Place)
         ), !;
         
        (holding(Thing),                        % holding object?
            (holds(Thing, Object),            % does it contain another object?
                \+holding(Object), \+at(Object, Place),
                \+constrained_by(_, Thing),
                action(Object),
                assert(holding(Object)));
            (i_am_at(Place), object(Thing, Place))), !;         % just describe it then (at place)
            
        (at(Thing, Place),                    % is object here?
            object(Thing, Place)), !;
            
        (visible(Thing, Place),                % is object visible and here?
            object(Thing, Place)), !;
            
        (d_lookb, nl)).
        
        

/* Look in general, where are you and what's around you */

look :-  enoughtime,

    history_add(look),
        i_am_at(Place),
        describe(Place),
        nl,
        notice_objects_at(Place),
        nl,
        ((visible(Object, Place),
            d_look(Object), nl); nl), !.
            

/* =========================================================== */
/* =========================================================== */
/* =========================================================== */

/* Pick up an object */

take(X) :- enoughtime,
    (string_concat('take(', X, Obj), string_concat(Obj, ')', Data),
     history_add(Data),
      i_am_at(Place),
      
      (holding(X),                       % already holding the object
        d_takea), !;
        
      ((at(X, Place),                     % otherwise, take the object
        retract(at(X, Place)),
        assert(holding(X)),
        d_takeb(X)), !;
        
       (at(X, Direction, Place),         % take object from direction
        retract(at(X, Direction, Place)),
        assert(holding(X)),
        d_takeb(X)), !
      ), !;
        
      (visible(X, Place),                 % that object can't be taken
        d_takec(X)), !;
        
      (d_taked(X))). 
      


/* These rules describe how to put down an object. */

drop(X) :- enoughtime,
    (string_concat('drop(', X, Obj), string_concat(Obj, ')', Data),
     history_add(Data),
        holding(X),                       % holding the object
        i_am_at(Place),
        retract(holding(X)),
        assert(at(X, Place)),
        write(X), d_dropa,
        nl), !;
        
      (d_dropb).             % not holding the object
      
/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* These rules define the direction letters as calls to go/1. */

n :- go(n).
s :- go(s).
e :- go(e).
w :- go(w).


/* This rule tells how to move in a given direction. */

go(Direction) :-  enoughtime,

     (history_add(Direction),
      i_am_at(Here),                               % travel
      path(Here, Direction, There),
      
      ((\+constrained_by(There, Something),
            retract(i_am_at(Here)),
            assert(i_am_at(There)),
            % ((action(There), look); look)),
            (action(There), d_describe(There); d_describe(There))),
            !;
            
        (constrained_by(There, Something),
            d_go(Something),
            write(There), write('.')), !), !;
            
      d_go_not).           % path not acceptable


/* These rules set up a loop to mention all the objects
   in your vicinity. */

notice_objects_at(Place) :-
        at(X, Place),
        d_notice(X), nl,
        enoughtime,
        fail.

notice_objects_at(_).


/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(Place) :- i_am_at(Place), d_describe(Place), !.   


where :- i_am_at(Place), d_describe(Place), !.






/* This rule tells how to end the game. */

die :-  end_fail, !, fail.

win :-  end_win.
        
        
        
/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* This section deals with timeing in the game */


        
/* Tell user how much time remains before end */
        
clock :-
        time_left(_, M, _),
        M > 0,
        d_clock(M).
        
        
time_left(H, M, S) :-

        elapsed_time(CH, CM, CS),
        deadline(DH, DM, DS),
        
        TD is +(*(3600, DH), +(*(60, DM), DS)),
        TC is +(*(3600, CH), +(*(60, CM), CS)),
        
        Diff is -(TD, TC),
        
        H is floor( /( Diff, 3600 ) ),
        M is floor( /( -(Diff, *(H, 3600)), 60) ),
        S is floor( -(Diff, +( *(H, 3600), *(M, 60)) )).

        
        
/* Determine if the clock as ran out and the game is over */



enoughtime :-
        (time_left(H, M, S),
         Time is +(*(3600, H), +(*(60, M), S)),
         Time > 0, !);
        
        die.
        

        
start_time_set :- 
        current_time(H, M, S),
        assert(start_time(H, M, S)).

        
current_time(H, M, S) :-
        get_time(T),
        stamp_date_time(T, date(_,_,_, H, M, TS, _,_,_), 'local'),
        S is floor(TS).
        
        
end_time(H, M, S) :-
        start_time(SH, SM, SS),
        deadline(DH, DM, DS),
        
        NewStart is +( *(SH, 3600), +(*(SM, 60), SS)),
        NewDead is +( *(DH, 3600), +(*(DM, 60), DS)),
        
        End is +(NewDead, NewStart),
        
        ((End > 86399,                          % H*3600 + M*60 + S  (Number of seconds)
            H is 0,
            NT is -( End, 86400 ),
            M is floor( /(NT, 60) ),
            S is floor( -(NT, *(M, 60)) )
        );
        (
            H is floor( /( End, 3600 ) ),
            M is floor( /( -(End, *(H, 3600)), 60) ),
            S is floor( -(End, +( *(H, 3600), *(M, 60)) ))
        )), !.
        

/* Describe completion time when user finishes the game */
completion_time :-
        elapsed_time(Hr, Min, Sec),
        d_complete(Hr, Min, Sec).
        

% =============  UPDATE HOURS FOR NEW DAY
elapsed_time(H, M, S) :-
        current_time(CH, CM, CS),
        start_time(SH, SM, SS),
        
        
        NewStart is +( *(SH, 3600), +(*(SM, 60), SS)),
        NewCurrent is +( *(CH, 3600), +(*(CM, 60), CS)),
        
        End is -(NewCurrent, NewStart),
        
        ((End < 0,                          % H*3600 + M*60 + S  (Number of seconds)
            H is 0,
            NT is +( End, 86400 ),
            M is floor( /(NT, 60) ),
            S is floor( -(NT, *(M, 60)) )
        );
        (
            H is floor( /( End, 3600 ) ),
            M is floor( /( -(End, *(H, 3600)), 60) ),
            S is floor( -(End, +( *(H, 3600), *(M, 60)) ))
        )), !.
        
       




/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* This section deals with cheats in the game */


cheat(infinite_time) :-
        deadline(H, M, S),
        retract(deadline(H, M, S)),
        assert(deadline(99999, 0, 0)).
