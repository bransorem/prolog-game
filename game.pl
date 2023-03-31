

:- [engine], [english].


% deadline(Hours, Minutes, Seconds) to complete the game
deadline(0, 30, 0).

file_extension('.dat').


/* =========================================================== */
/* =========================================================== */
/* =========================================================== */

intro :- 
        i_am_at(Place),
        describe(Place),
        H is 23,
        M is 37,
        d_intro(H, M).
        
        
start :-
        assert(i_am_at(museum)),
        start_time_set,
        history_add(start),
        intro.
        
        
end_game :- ((holding(card_reader); holding(new_card)), holding(hotel_key), end_win);
            end_fail.


end_win :-  end_win_text, completion_time.

end_fail :- end_fail_text.




help :- i_am_at(Place),
        instructions, nl,
        write('***** '),
        ((help(Place), !); d_nohelp),
        writeln(' *****').




save(File) :- save_game(File).
load(File) :- load_game(File).


/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* ============ PATHS =============== */

path(museum, e, museum_back_alley).
    path(museum, s, library).
path(library, n, museum).
path(museum_back_alley, n, washington_ave).
    path(museum_back_alley, w, museum).
path(washington_ave, n, park_s).
    % path(washington_ave, s, museum_back_alley).       % no backtracking
    path(washington_ave, w, stoplight).
path(stoplight, n, s_52nd_street).
    path(stoplight, e, washington_ave).
path(park_s, n, park_n).
    path(park_s, s, washington_ave).
    path(park_s, w, s_52nd_street).
path(s_52nd_street, n, n_52nd_street).
    path(s_52nd_street, e, park_s).
    path(s_52nd_street, s, stoplight).
path(park_n, n, manhole).
    path(park_n, s, park_s).
    path(park_n, w, n_52nd_street).
path(n_52nd_street, e, park_n).
    path(n_52nd_street, s, s_52nd_street).
    path(n_52nd_street, w, apartment).
path(apartment, e, n_52nd_street).
    path(apartment, s, office).
    path(apartment, w, bedroom).
path(bedroom, e, apartment).
path(office, n, apartment).


/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* view(Location, North, East, South, West) */


view(museum,            painting,           museum_exit,    library,        statue).
view(library,           museum,             ladder,         bookshelf,      desk).
view(museum_back_alley, washington_ave,     burns,          dark_alley,     museum).
view(washington_ave,    dark_park,          city,           museum_back_alley,  stoplight).
view(stoplight,         apartment,          washington_ave, museum_outside, capitol).
view(park_s,            fire,               oak_tree,       washington_ave, s_52nd_street).
view(park_n,            wreckage,           laboratory,     dark_park,      n_52nd_street).
view(s_52nd_street,     n_52nd_street,      dark_park,      stoplight,      apartment_18008).
view(n_52nd_street,     hotel,              dark_park,      s_52nd_street,  apartment_18084).
view(office,            apartment,          laboratory,     file_cabinet,   apartment_desk).
view(apartment,         apartment_wall,     apartment_door, office,         bedroom).
view(bedroom,           bed,                living_room,    bathroom,       capitol).



/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* =========== OBJECTS ============== */

/* at(Object, Place) */
at(wallet, museum).
at(broken_vile, museum_back_alley).
at(hotel_key, bedroom).
at(scribbled_note, library).

/* at(Object, Place, Direction) */
at(box, library, e).
at(card_reader, office, s).
at(paper, office, w).


/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* ============ VISIBLES ============ */

/* visible(Thing, Place) */
visible(dead_body, museum).
visible(book, library).

visible(bench, park_s).
visible(beer_bottle, apartment).
visible(night_stand, bedroom).



/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* =========== ACTIONS ============== */

/* Actions on objects */
action(id_card) :-      d_action_id_card.
action(door) :-         d_action_door.
action(front_door) :-   d_action_front_door.
action(ladder) :-       d_action_ladder.
action(key) :-          d_action_key.
action(new_card) :-     d_action_new_card.


/* Actions on entering places */
action(washington_ave) :-     N is random(5), d_action_washington_ave(N).
action(museum_back_alley) :-  d_action_museum_back_alley, autosave.
action(park_n) :-             autosave.
action(manhole) :-            d_action_manhole, end_game.




/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* ====== OBJECT DESCRIPTIONS ======= */
/* object(Object, Place) - Object at place */

object(dead_body, museum) :-    d_object_dead_body.
object(painting, museum) :-     d_object_painting.
object(id_card, museum) :-      d_object_id_card_museum.
object(book, library) :-        d_object_book.
object(beer_bottle, apartment) :- d_object_beer_bottle.
object(night_stand, bedroom) :- d_object_night_stand.


object(id_card, _) :-           d_object_id_card.
object(wallet, _) :-            d_object_wallet.
object(door, museum) :-         d_object_door.
object(front_door, n_52nd_street) :- d_object_front_door.
object(scribbled_note, _) :-    d_object_scribbled_note.
object(hotel_key, _) :-         d_object_hotel_key.
object(paper, _) :-             d_object_paper.
object(card_reader, _) :-       d_object_card_reader.
object(broken_vile, _) :-       d_object_broken_vile.
object(box, _) :-               d_object_box.



/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* ============== HOLD ============== */
/* holds(Object, Thing) implies Object holds Thing */

holds(wallet, id_card).


/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* ============= BLOCKS ============= */
/* constrained_by(Thing, Constraint) implies Thing is constrained by Constraint */
/* unlocks(Thing, Constraint) implies Thing removes Constraint */


/* Location-based constrains */
constrained_by(library, door).
constrained_by(apartment, front_door).

/* Location-based unlocks */
unlocks(id_card, door).
unlocks(key, front_door).





/* =========================================================== */
/* =========================================================== */
/* =========================================================== */
/* MERGE DEFINITIONS */
/* items that can be combined to make a new item */
/* merge(Object, Thing, NewThing) means merge Object and Thing to make NewThing */


merge(Number, box, key) :- (Num is -(163, 489 mod 5)), (Number == Num).
merge(id_card, card_reader, new_card).

