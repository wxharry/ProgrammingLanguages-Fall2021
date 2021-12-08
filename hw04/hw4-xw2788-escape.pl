% ['hw4-xw2788-escape'].

st(P, L) :- P==r,!, r(L).
st(_, L) :- l(L).

% Q1
time(tokyo, 5).
time(rio, 10).
time(berlin, 20).
time(denver, 25).

% Q2
team([tokyo, rio, berlin, denver]).

% Q3
max(A,B,B) :- A < B,!.
max(A,_,A).

cost([], 0).
cost([P|PS], C) :- cost(PS, O), time(P, PC), max(PC, O, C). 

% Q4
split(L,[X,Y],M) :-
    member(X,L),
    member(Y,L),
    compare(<,X,Y),
    subtract(L,[X,Y],M).

% we can assume that each time, only two people move from left to the right.
move(st(l, L1), st(r, L2), r(M), C) :- split(L1, M, L2), cost(M, C).
% Example: 
% move(st(l, [tokyo, rio, berlin, denver]), st(r, [berlin, denver]), X, C).

move(st(r, L1), st(l, [M|L1]), l(M), C) :- team(T), member(M, T), \+ member(M, L1), time(M, C).
% move(st(r, [rio, berlin]), st(l, [tokyo, rio, berlin]), l(M), C).

% Q5 trans(I, F, M, C).
trans(st(r, []), _, [], 0).
trans(I, F, M, DO) :- move(I, Mid, M1, C1), trans(Mid, F, M2, C2), append([M1], M2, M), DO is C1 + C2.

cross(M, D) :- team(T), trans(st(l, T), st(r, []), M, DO), DO=<D.
solution(M) :- cross(M, 60).

% solution(M).


