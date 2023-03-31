
/* ===== Actions ===== */




/* ===== Objects ===== */





/* ===== Describe places ===== */



                        
d_describe(_) :-        write('You are lost.'), nl.








/* ===== Dialog Use ===== */
d_use_nothing :-        write('You can''t use that here.').
d_looka(See) :-         write('You are facing the '), write(See), write('.'), nl.
d_lookb :-              write('There''s nothing special here.').
d_look(Object) :-       write('There is a '), write(Object), write(' here.').
d_takea :-              write('You''re already holding it!'), nl.
d_takeb(X) :-           write('You picked up the '), write(X), write('.'), nl.
d_takec(X) :-           write('You can''t take '), write(X), write('.'), nl.
d_taked(X) :-           write('You don''t see '), write(X), write(' here.'), nl.
d_dropa :-              write(' dropped.').
d_dropb :-              write('You aren''t holding it!'), nl.
d_go(Something) :-      write('A '), write(Something), write(' is blocking the ').
d_go_not :-                write('You can''t go that way.').
d_notice(X) :-          write('There is a '), write(X), write(' here.').
d_clock(Time) :-        write('You have about '), write(Time), write(' minutes until the cops find you.').
d_complete(_, Min, Sec) :- 
                        write('You finished the game in '), write(Min), 
                        write(' minutes and '), write(Sec), write(' seconds.'), nl.
% d_describe(Place) :-    write('You are at the '), write(Place), write('.  '), nl.

/* ================ */

d_intro(H, M) :-        write('You are standing over a dead_body.'), nl,
                        write('Your watch reads '), write(H), write(' hours and '), 
                        write(M), write(' minutes.'), nl,
                        write('The cops will be here soon.'), nl.
                                    
end_fail_text :-
        nl,
        write('A policeman calls your name.  As you turn around he shoots you in the chest.'),
        nl,
        write('The game is over. Please enter the "halt." command.'),
        nl.
        

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('  start.              -- to start the game.'), nl,
        write('  help.               -- to see this message again.'), nl,
        write('  n.  s.  e.  w.      -- to go in that direction.'), nl,
        write('  take(Object).       -- to pick up an object.'), nl,
        write('  drop(Object).       -- to put down an object.'), nl,
        write('  use(Object, Thing). -- use an object on a thing.'), nl,
        write('  look.               -- to look around you again.'), nl,
        write('  look(Object).       -- to examine an object.'), nl,
        write('  look(Direction).    -- to look in a direction.'), nl,
        write('  clock.              -- how long you have left.'), nl,
        write('  save_game(''filename'') -- save the game'), nl,
        write('  load_game(''filename'') -- load a game'), nl,
        write('  halt.               -- to end the game and quit.'), nl,
        nl.