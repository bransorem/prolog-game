

/* ================================================================= */
/* ===================== Controller ================================ 


:- [engine].

:- use_module(library(pce)).

:- pce_begin_class(navigation, dialog,
                   "Modal prompter for an item").

initialise(W, Label:[name]) :->
        "Initialise the window and fill it"::
        send_super(W, initialise(Label)),
        send(W, append(button(look_button))),
        send(W, append(button(north))),
        send(W, append(button(east))),
        send(W, append(button(south))),
        send(W, append(button(west))).
        %send(W, append(text_item(takeItem))),
        %send(W, append(button(take_item))),
        %send(W, append(text_item(dropItem))),
        %send(W, append(button(drop_item))).

north(W) :->
        "North"::
        n,
        send(W, return).
        
south(W) :->
        "South"::
        s,
        send(W, return).
        
        
east(W) :->
        "East"::
        e,
        send(W, return).
        
        
west(W) :->
        "West"::
        w,
        send(W, return).

look_button(W) :->
        "Look"::
        send(W, return(look)).
      

take_item(W) :->
        "Take"::
        get(W, member(takeItem), Item),
        get(Item, selection, Typed),
        send(W, take(Typed)).
        
        
drop_item(W) :->
        "Drop"::
        get(W, member(dropItem), Item),
        get(Item, selection, Typed),
        drop(Typed).

prompt(W, Value:name) :<-
        "Open it, destroy it and return the result"::
        get(W, confirm, Value).
        %free(W).

:- pce_end_class.

 =============================================================== */