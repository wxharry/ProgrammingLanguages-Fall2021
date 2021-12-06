% ['hw4-xw2788-prules'].

% Q1: Write a rule remove_items(I,L,O) in which O is the output list obtained by removing every occurrence of the elements contained in List I from list L.  The items in O should appear in the same order as L, only without the elements present in I.

remove_items(_, [], []).
remove_items([], L, L).
remove_items(I, L, O) :- remove_items(I, L, [], O).
remove_items(I, [L|LS], Ans, O) :- member(L, I), remove_items(I, LS, Ans, O).
remove_items(I, [L|LS], Ans, O) :- append(Ans, [L], Anss), remove_items(I, LS, Anss, O).
remove_items(_, [], Ans, Ans).

% remove_items([1,3], [1,2,3,4], O).
% O = [2, 4].
% remove_items([1, 3], [2, 6, 7, 7, 8, 3, 1, 1, 4, 3], O).
% O = [2, 6, 7, 7, 8, 4]

% Q2: Write a rule intersection2(L1,L2,F) footnote{The rule {\tt intersection} is already defined by the Prolog standard library.} in which F is a \verb|set| containing only items that appear in both L1 and L2. You should not assume that L1 or L2 are sets\footnote{A \emph{set} is a collection of unique, unordered items.} and, therefore, may contain duplicate items.  Optional hint: first defining {\tt intersection/4} and then define {\tt intersection/3} in terms of that.

intersection2(L1, L2, F) :- intersection2(L1, L2, [], F).
intersection2([L|LS], L2, Ans, F) :- member(L, Ans), intersection2(LS, L2, Ans, F).
intersection2([L|LS], L2, Ans, F) :- member(L, L2), intersection2(LS, L2, [L|Ans], F).
intersection2([_|LS], L2, Ans, F) :- intersection2(LS, L2, Ans, F).
intersection2([], _, Ans, Ans).
% intersection2([1,2], [2, 3], O).
% O = [2] .
% intersection2([2,3,4,3,5,8,2],[9,3,2,4,4],O).
% O = [2,3,4].

%Q3: Write a rule disjunct_union(L1,L2,U) in which U is the disjunctive union of the items in L1 and L2. That is, items in L1 or L2 that are not in the intersection of L1 and L2. You should not assume that L1 or L2 are sets.

disjunct_union(L1, L2, O) :- intersection2(L1, L2, I), disjunct_union(L1, L2, I, [], O).
disjunct_union([L|LS], L2, I, Ans, O) :- \+ member(L, Ans), \+ member(L, I), disjunct_union(LS, L2, I, [L|Ans], O).
disjunct_union([_|LS], L2, I, Ans, O) :- disjunct_union(LS, L2, I, Ans, O).
disjunct_union([], [L|LS], I, Ans, O) :- \+ member(L, Ans), \+ member(L, I), disjunct_union([], LS, I, [L|Ans], O).
disjunct_union([], [_|LS], I, Ans, O) :- disjunct_union([], LS, I, Ans, O).
disjunct_union([], [], _, Ans, Ans).

% disjunct_union([1,2], [2, 3], O).
% O = [1, 3].
% disjunct_union([2,3,4,3,5,8,2],[9,3,2,4,4],O).
% O = [5,8,9].

% Q4: Write a rule my_flatten(L1,L2) which transforms the list L1, possibly holding lists as elements into a ``flat'' list L2 by replacing each list with its elements.

my_flatten([], []).
my_flatten([L], L2) :- my_flatten(L, L2).
my_flatten([L|LS], L2) :- append(L, LS, O),!, my_flatten(O, L2).
my_flatten([L|LS], L2) :- my_flatten(LS, L3), append([L], L3, L2).

my_flatten(L1, L2) :- my_flatten(L1, L2, []).
my_flatten([L|LS], L2, Ans) :- my_flatten(LS, L2, [L|Ans]).
my_flatten([], Ans, Ans).

% my_flatten([[c],e], X).
% X = [c, e] .
% my_flatten([a, [b, [c, d], e]], X).
% X = [a, b, c, d, e] .
% my_flatten([a, [b, [c, d], e, [f, g]], h], X).
% X = [a, b, c, d, e, f, g, h] .

%Q5: Write a rule {\tt compress(L1,L2)} where all the repeated consecutive elements of the list L1 should be replaced with a single copy of the element. The order of the elements should not be changed.
compress([], []).
compress(L1, L2) :- compress(L1, [], L2).
compress([L|LS], Ans, L2) :- member(L, Ans), compress(LS, Ans, L2).
compress([L|LS], Ans, L2) :- append(Ans, [L], O), compress(LS, O, L2).
compress(_, Ans, Ans).

% compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
% X = [a,b,c,a,d,e]

% Q6: Write a rule encode(L1,L2) where all the repeated consecutive duplicates of elements are encoded as terms [N,E] where N is the number of duplicates of the element E. The order of the elements should not be changed.

% the following comment is an incorrect answer to this question. I misunderstood Q6 and implemented a 'encode' rule which counts the frequncy of each element of an array, I don't want to delete it because I spent hours on it. You can just ignore this(line74-79)
% encode([], []).
% encode(L1, L2) :- encode(L1, [], L2).
% encode([X],[], [[1, X]]).
% encode([X], [[V, K]|Ans], [[M, K]|Ans]) :- X == K, M is V+1.
% encode([X], [[V, K]|Ans], [[V, K]|L3]) :- encode([X], Ans, L3).
% encode([X|XS], Ans, L2) :- encode([X], Ans, L3), encode(XS, L3, L2).

encode([], []).
encode(L1, L2) :- encode(L1, [], L2).
encode([L | LS], [], L2) :- encode([L|LS], [[1, L]], L2).
encode([X, Y|XS], Ans, L2) :- X \== Y, encode([Y|XS], [[1, Y]], L3), append(Ans, L3, L2).
encode([X, X|XS], [[N, X] | Ans], L2) :- M is N+1, encode([X|XS], [[M, X]|Ans], L2).
encode(_, Ans, Ans).

% ?- encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
% X = [[4,a],[1,b],[2,c],[2,a],[1,d][4,e]]

% Q7: Modify the result of previous problem in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as [N,E] terms. Name the rule as {\tt encode\_modified}.

encode_modified([], []).
encode_modified(L1, L2) :- encode_modified(L1, [], L2).
encode_modified([L|LS], [], L2) :- encode_modified([L|LS], [L], L2).
encode_modified([X, Y|XS], Ans, L2) :- X \== Y, encode_modified([Y|XS], [Y], L3), append(Ans, L3, L2).
encode_modified([X, X|XS], [[N, X]| Ans], L2) :- M is N+1, encode_modified([X|XS], [[M, X]|Ans], L2).
encode_modified([X, X|XS], [ X | Ans], L2) :- encode_modified([X|XS], [[2, X]], L3), append(Ans, L3, L2).
encode_modified(_, Ans, Ans).

%     Example:
%     ?- encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
%     X = [[4,a],b,[2,c],[2,a],d,[4,e]]

% Q8: Write a rule rotate(L1,N,L2) where the list L2 is the modified version of list L1, with the elements rotated as N places to the left if N is a positive number, otherwise rotated as N places to the right. You can assume that list L1 is never empty and $|N| < length(L1)$, where $|.|$ is the absolute value operator. 

length_of([], 0).
length_of([_|XS], N) :-length_of(XS, M), N is M + 1.

rotate(L1, 0, L1).
rotate([x], _, [x]).
rotate([X|XS], N, L2) :- N > 0, !, M is N-1, rotate(L1, M, L2), append(XS, [X], L1).
rotate(L1, N, L2) :- length_of(L1, Len), M is N + Len, rotate(L1, M, L2).

% Examples:
% ?- rotate([a,b,c,d,e,f,g,h],3,X).
% X = [d,e,f,g,h,a,b,c]

% ?- rotate([a,b,c,d,e,f,g,h],-2,X).
% X = [g,h,a,b,c,d,e,f]
