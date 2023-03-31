
/* ===== Actions ======================================================== */

d_action_id_card :-     writeln('There\'s an id_card inside.').
d_action_door :-        writeln('The door is unlocked.').
d_action_front_door :-  writeln('The front_door is unlocked.').
d_action_ladder :-      writeln('There\'s a box at the top.').
d_action_key :-         writeln('There was a key inside.').
d_action_new_card :-    writeln('You changed the id card into a new card.').


d_action_washington_ave(1) :-    writeln('The police have entered the museum.  There\'s no turning back now.').
d_action_washington_ave(2) :-    writeln('There is loud shouts coming from the museum.  The police must be there.'),
                                 writeln('There\'s no turning back now.').
d_action_washington_ave(3) :-    writeln('The police have entered the museum.  You barely made it out in time.'),
                                 writeln('There\'s no turning back now.').
d_action_washington_ave(4) :-    writeln('You can\'t go back to the museum.  The death is too overwhelming.'),
                                 writeln('There\'s no turning back now.').
d_action_museum_back_alley :-    writeln('You\'d better search everywhere before you leave the museum area.').

d_action_manhole :-              writeln('You fall down an open manhole.').

/* ===== Objects ======================================================== */

/* Stationary objects --------------------------- */
d_object_dead_body :-           write('He\'s completely mutilated.  '),
                                writeln('He has burns all over his body.'),
                                writeln('He hasn\'t been dead for more than 20 minutes.'),
                                writeln('There\'s a name tag next to him.  He works here.').
d_object_door :-                writeln('There\'s a card reader next to it.').
d_object_front_door :-          writeln('You need to find the key.').

d_object_painting :-            writeln('It looks like a Monet.').
d_object_book :-                writeln('It\'s authored by the dead man.  There\'s another name on it: John Vladic.').


d_object_night_stand :-         writeln('There\'s just a glass of water and an alarm clock.').
d_object_beer_bottle :-         writeln('The beer bottle is mostly empty - it must be from last night.').
d_object_bench :-               writeln('The bench is dedicated to Tom Morello.').


/* Obtainable objects ---------------------------- */
d_object_id_card_museum :-      writeln('There\'s a magnetic strip on the back.').
d_object_id_card :-             writeln('Carl Clodue'),
                                writeln('18084 52_street'),
                                writeln('You\'d better check it out.').
d_object_wallet :-              writeln('Maybe you should look inside.').
d_object_scribbled_note :-      writeln('There\'s a note here.  The handwriting is scribbled and frantic.'),
                                writeln('It says:'),
                                write('\t John, he did it.  Something went wrong, he\'s coming here now.  '), nl,
                                write('\t Don\'t let him'), nl,
                                writeln('The note trails off...').
d_object_paper :-               writeln('The paper is titled: Dark Matter Coupling Energies'),
                                writeln('There are three authors:'),
                                write('\tJohn Vladic'), nl,
                                write('\tCarl Clodue'), nl,
                                write('\tMikkel Karloff'), nl,
                                writeln('Carl is the dead guy at the museum.'),
                                writeln('Who is this John fellow and who is Mikkel Karloff?').
d_object_hotel_key :-           writeln('This is a key to the Grande Hotel.').
d_object_card_reader :-         writeln('This is a card writer too.  Maybe it\'ll be useful.').
d_object_broken_vile :-         writeln('It\'s steaming.  There was definitely something in here a minute ago.').
d_object_box :-                 writeln('There is a keypad on it.  Looks like it holds something.').



/* ===== Describe places ================================================ */

d_describe(museum) :-   
                        writeln('You are in a <museum>.  It\'s dark in here.'),
                        writeln('The air is fetid - like death.').
d_describe(library) :-  
                        writeln('You are in the <library> of the museum.'),
                        writeln('There are books all along the shelves.').
d_describe(museum_back_alley) :-
                        writeln('You are in the <museum_back_alley>.'),
                        writeln('You should look around for clues on where to go.').
d_describe(washington_ave) :-
                        writeln('You are on <washington_ave>.'),
                        writeln('The streets are almost empty.  It\'s pretty late.').
d_describe(stoplight) :- 
                        writeln('You are at a stoplight.  It is red, but there are no cars stopped here.'),
                        writeln('You\'d better head up the street.').
d_describe(park_s) :- 
                        writeln('You are in a dark park.  There aren\'t very many lights.').
                        
d_describe(park_n) :-   
                        writeln('You are in a dark park.  There are lots of trees, but not many lights.').
                        
d_describe(s_52nd_street) :-
                        writeln('You are on 52nd street, the south end.'),
                        writeln('There are a lot of apartments at this end of town.'). 
d_describe(n_52nd_street) :- 
                        writeln('You are on 52nd street, the north end.'),
                        writeln('There are a lot of apartments at this end of town.').
d_describe(office) :- 
                        writeln('You are in the office.  There are papers littered everywhere.'),
                        writeln('Many of them have advanced math.').
d_describe(apartment) :- 
                        writeln('You are in the apartment.  There\'s a beer bottle on the coffee table.'),
                        writeln('There aren\'t many windows in here.').
d_describe(bedroom) :- 
                        writeln('You are in the bedroom.  There\'s a nice view of the capitol.'),
                        writeln('The bed is neatly made.  He mustn\'t have come home yet.').

                        
d_describe(manhole) :-  writeln('Stay tuned for the sequel.').
                    
d_describe(_) :-        writeln('You are lost.').





/* ===== Describe Look Directions ======================================== */



d_look_place(museum) :-         writeln('Going back into the museum means withstanding that aweful smell.').
d_look_place(painting) :-       writeln('There is a painting.').
d_look_place(museum_exit) :-    writeln('The exit is open.  It\'s probably the best way to go to avoid the police.').
d_look_place(library) :-        writeln('That must be the museum library.').
d_look_place(statue) :-         writeln('There is a statue.  It\'s somehow familiar...').
d_look_place(ladder) :-         writeln('There is a ladder.  You should use it.').     
d_look_place(bookshelf) :-      writeln('There is a bookshelf.  One of the books is sticking out more than the others.').   
d_look_place(desk) :-           writeln('The desk has a scribbled_note on it.  You should look at it.').
d_look_place(museum_back_alley) :-  writeln('It\'s dark and cold out there.  There\'s nothing left that way.').
d_look_place(washington_ave) :- writeln('Washington ave.  Normally, it\'s a busy street.').  
d_look_place(burns) :-          writeln('There are burns everywhere.  It almost looks like something ignited here.').
d_look_place(dark_alley) :-     writeln('It\'s even darker that way.  You don\'t want to risk going that way.').   
d_look_place(dark_park) :-      writeln('The park is dark right now.  Maybe you should investigate anyway.').
d_look_place(city) :-           writeln('You can see the city from here.  There are so many lights there.'). 
d_look_place(stoplight) :-      writeln('There is no traffic up ahead.  That\'s strange even for this time of night.').
d_look_place(apartment) :-      writeln('You can see some apartments that way.  This might be the right way.').
d_look_place(museum_outside) :- writeln('The museum is beautiful.  But you\'ll never look at it the same after tonight.').
d_look_place(capitol) :-        writeln('You can see the capitol from here.  It\'s always well lit.').
d_look_place(fire) :-           writeln('There is a big fire up ahead.  It looks like some sort of wreckage.').
d_look_place(oak_tree) :-       writeln('There is a large oak tree.  It has small carvings on it:'),
                                write('\t163 - 489 mod 5'), nl,
                                writeln('Maybe that\'s the code for the box.').
d_look_place(s_52nd_street) :-  writeln('52nd street.  The street goes on for a ways.').
d_look_place(park_n) :-         writeln('The park is that way.  There is a fire up ahead.  You should investigate.').
d_look_place(wreckage) :-       writeln('A tree has fallen into the road and is blocking the way.  It is burning.'),
                                writeln('There might be a way through though.').
d_look_place(laboratory) :-     writeln('There is a huge laboratory that way.  The lights are off - probably no one there.').
d_look_place(n_52nd_street) :-  writeln('52nd street.  The street meets at the Grande Hotel.').
d_look_place(apartment_18008) :- writeln('The address is 18008.'),  
                                writeln('This isn\'t the right place.  It must be further.').
d_look_place(hotel) :-          writeln('The Grande hotel looks beautiful this time of night.'),
                                writeln('But, something is going on there.').
d_look_place(apartment_18084) :- writeln('The address is 18084.'),  
                                writeln('This is the place.  You should go inside.').
d_look_place(office) :-         writeln('That must be the office.  It looks quite tidy.').
d_look_place(file_cabinet) :-   writeln('The file cabinet has been opened.  It looks like a bunch of professional papers.'),
                                writeln('There is a card_reader in here.  You should take it.').
d_look_place(apartment_desk) :- writeln('There is a paper on top titled: Dark Matter Coupling Energies.'),
                                writeln('You should take it.').
d_look_place(apartment_wall) :- writeln('There isn\'t much here - just a picture of a sunset and a couch against the wall.').
d_look_place(apartment_door) :- writeln('It\'s locked.  I need the key.').
d_look_place(bedroom) :-        writeln('That must be the bedroom.').
d_look_place(bed) :-            writeln('The bed is still made - he probably stayed at work all day.').
d_look_place(bathroom) :-       writeln('You don\'t need to check the bathroom.').
d_look_place(livingroom) :-     writeln('That\'s the living room.').


d_look_place(See) :-      write('You are facing the '), write(See), write('.'), nl.




/* ===== Dialog Help ==================================================== */

help(museum) :-         write('Try looking at the wallet.').
help(library) :-         write('Make sure you look at everything.  Try to use the ladder.').
help(n_52nd_street) :-  write('Did you look in the box?').


d_nohelp :-             write('There is no help here.').


/* ====================================================================== */

d_intro(H, M) :-        writeln('You are standing over a dead_body.'),
                        write('Your watch reads '), write(H), write(' hours and '), 
                        write(M), write(' minutes.'), nl,
                        writeln('The cops will be here soon.'), nl,
                        writeln('Type instructions. to view possible commands.').
                        
end_win_text :- 
        nl,
        writeln('You win.  Thanks for playing.'), nl,
        writeln('The game is over.  Please enter the "halt." command.').
                                    
end_fail_text :-
        nl,
        writeln('A policeman calls your name.  As you turn around he shoots you in the chest.'),
        writeln('The game is over. Please enter the "halt." command.').
        % halt.

instructions :-
        nl,
        writeln('Enter commands using standard Prolog syntax.'),
        writeln('Available commands are:'),
        writeln('  start.                  -- to start the game.'),
        writeln('  help.                   -- to get a hint.'),
        writeln('  n.  s.  e.  w.          -- to go in that direction.'),
        writeln('  take(Object).           -- to pick up an object.'),
        writeln('  drop(Object).           -- to put down an object.'),
        writeln('  use(Object, Thing).     -- use an object on a thing.'),
        writeln('  look.                   -- to look around you again.'),
        writeln('  look(Object).           -- to examine an object.'),
        writeln('  look(Direction).        -- to look in a direction.'),
        writeln('  clock.                  -- how long you have left.'),
        writeln('  save(\'filename\')        -- save the game'),
        writeln('  load(\'filename\')        -- load a game'),
        writeln('  halt.                   -- to end the game and quit.'),
        nl.
        
        
        
        
        
        
        
        
        
        
        
        
        
        
/* ===== Dialog Use ===================================================== */

d_use_nothing :-        writeln('You can\'t use that here.').
d_lookb :-              writeln('There\'s nothing special here.').
d_look(Object) :-       write('There is a '), write(Object), write(' here.').
d_takea :-              writeln('You\'re already holding it!').
d_takeb(X) :-           write('You picked up the '), write(X), write('.'), nl.
d_takec(X) :-           write('You can\'t take the '), write(X), write('.'), nl.
d_taked(X) :-           write('You don\'t see '), write(X), write(' here.'), nl.
d_dropa :-              write(' dropped.').
d_dropb :-              writeln('You aren\'t holding it!').
d_go(Something) :-      write('A '), write(Something), write(' is blocking the ').
d_go_not :-                writeln('You can\'t go that way.').
d_notice(X) :-          write('There is a '), write(X), write(' here.').
d_clock(Time) :-        write('You have about '), write(Time), write(' minutes until the cops find you.').
d_complete(_, Min, Sec) :- 
                        write('You finished the game in '), write(Min), 
                        write(' minutes and '), write(Sec), write(' seconds.'), nl.
% d_describe(Place) :-    write('You are at the '), write(Place), write('.  '), nl.