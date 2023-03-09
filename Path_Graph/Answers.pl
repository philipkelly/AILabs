% --------------------  Question 1 ------------------------

% edge(LocA, LocB, Cost).
edge(1,2).
edge(1,4).
edge(1,3).
edge(2,3).
edge(2,5).
edge(3,4).
edge(3,5).
edge(4,5).

connected(X,Y) :- 
	edge(X,Y).
connected(X,Y) :- 
	edge(Y,X).

/* Alternatively, you could write one rule with an or (;) in the body:
connected(X,Y) :- edge(X,Y) ; edge(Y,X).
*/

% --------------------  Question 2 ------------------------
path(A,B,Path):-
       find(A,B,[A],W), 
       reverse(W,Path).

find(A,B,P,[B|P]) :- 
       connected(A,B).
find(A,B,Visited,Way) :-
       connected(A,C),           
       C \== B,
       \+member(C,Visited),
       find(C,B,[C|Visited],Way).

% --------------------  Question 3 ------------------------
edge(1,2,1).
edge(1,4,3.5).
edge(1,3,2.5).
edge(2,3,1).
edge(2,5,2.5).
edge(3,4,1).
edge(3,5,2.2).
edge(4,5,1).

connected(X,Y,L) :- 
	edge(X,Y,L).
connected(X,Y,L) :- 
	edge(Y,X,L).

path(A,B,Path,Len) :-
       find(A,B,[A],Q,Len), 
       reverse(Q,Path).

find(A,B,P,[B|P],L) :- 
       connected(A,B,L).
find(A,B,Visited,Path,L) :-
       connected(A,C,D),           
       C \== B,
       \+member(C,Visited),
       find(C,B,[C|Visited],Path,L1),
       L is D+L1.  


% --------------------  Question 4 ------------------------
/*we will reuse the predicates from question 3*/
shortest(A,B,Path,Length) :-
   setof([P,L],path(A,B,P,L),Set),
   Set = [_|_], %requires at least on element i.e. fails if empty
   minimal(Set,[Path,Length]).

minimal([F|R],M) :- min(R,F,M).

% minimal path
min([],M,M).
min([[P,L]|R],[_,M],Min) :- L < M, !, min(R,[P,L],Min). 
min([_|R],M,Min) :- min(R,M,Min).