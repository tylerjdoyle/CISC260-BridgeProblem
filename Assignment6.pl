/*
 * Solution to Assignment 6.  Solves the "bridge problem" --
 * given a list of people and the times in which they can cross a bridge,
 * produces a set of moves that will get them across the bridge and the
 * amount of time it will take.
 * CISC 260, Winter 2016
 */

%family(original,[father/1,mother/2,child/5,granny/10]).
%family(two, [one/1, two/2]).


moveFamily(Name,MaxTime,Moves,Time):-
	family(Name,People),
	moveSouth(People,[],Moves,Time),
	Time =< MaxTime.

moveNorth([],_,[],0) :- !.
moveNorth(North,South,[PersonA|Moves],Time):-
	member(PersonA/TimeA,South),
	delete(South,PersonA,NewSouth),
	moveSouth([PersonA/TimeA|North],NewSouth,Moves,NewTime),
	Time is NewTime + TimeA.

moveSouth(North,South,[PersonA+PersonB|Moves],NewTime):-
	familyPair(North,PersonA/TimeA,PersonB/TimeB),
	delete(North,PersonA/TimeA,NewNorth),
	delete(NewNorth,PersonB/TimeB,NewerNorth),
	moveNorth(NewerNorth,[PersonA/TimeA,PersonB/TimeB|South],Moves,Time),
	MoveTime is max(TimeA,TimeB),
	NewTime is Time + MoveTime.


familyPair(Group,A,B):-
	member(A,Group),
	member(B,Group),
	A \= B,
	A @< B.
