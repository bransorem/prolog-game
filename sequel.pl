

:- [engine], [english-sequel].


% deadline(Hours, Minutes, Seconds) to complete the game
deadline(0, 10, 0).

file_extension('.dat').


/* =========================================================== */
/* =========================================================== */
/* =========================================================== */

intro :- 
        i_am_at(Place),
        describe(Place),
        H is 00,
        M is 23,
        d_intro(H, M).
        
        
start :-
        instructions,
        start_time_set,
        history_add(start),
        intro.
        % get(navigation('Navigation'), prompt, Name).


end_win :- end_win_text.

end_fail :- end_fail_text.

help :- instructions.



/* Starting Location */
i_am_at(manhole).



/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* ============ PATHS =============== */


path(manhole, e, sewer).

path(sewer, n, laboratory).
path(sewer, w, manhole).

path(laboratory, n, warehouse).
% path(laboratory, s, sewer).           % no backtracking

path(warehouse, s, laboratory).
path(warehouse, w, ally).

% path(ally, e, warehouse).             % no backtracking
path(ally, w, hotel).

path(hotel, n, roof).                   % to win
path(hotel, e, ally).
path(hotel, s, pool).                   % to loose

path(pool, n, hotel).                   % too late




/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* view(Location, North, East, South, West) */





/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* =========== OBJECTS ============== */

/* at(Object, Place) */


/* at(Object, Place, Direction) */



/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* ============ VISIBLES ============ */

/* visible(Place, Thing) */


/* visible(Place, Direction, Thing) */



/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* =========== ACTIONS ============== */

/* Actions on objects */



/* Actions on entering places */




/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* ====== OBJECT DESCRIPTIONS ======= */
/* object(Object, Place) text description for object */




/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* ============== HOLD ============== */
/* holds(Object, Thing) implies Object holds Thing */




/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* ============= BLOCKS ============= */
/* constrained_by(Thing, Constraint) implies Thing is constrained by Constraint */
/* unlocks(Thing, Constraint) implies Thing removes Constraint */


/* Location-based constrains */


/* Location-based unlocks */






/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* MERGE DEFINITIONS */
/* items that can be combined to make a new item */
/* merge(Object, Thing, NewThing) means merge Object and Thing to make NewThing */




