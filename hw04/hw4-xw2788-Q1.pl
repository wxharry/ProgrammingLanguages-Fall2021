% cousult('hw4-xw2788-Q1.pl').
% trace, grandfather(tom,jennifer).
% grandfather(X,Y) :- male(X), parent(X,Z),parent(Z,Y).

% Q1: Reorder the facts above to provide faster execution time when querying grandfather(tom,jennifer).
% List the re-ordered facts and briefly explain what you changed.
male(tom).
male(brian).
male(kevin).
male(zhane).
male(fred).
male(jake).
male(bob).
male(stephen).
male(paul).

parent(tom,stephen).
parent(stephen,jennifer).
parent(melissa,brian).
parent(mary,sarah).
parent(bob,jane).
parent(paul,kevin).
parent(tom,mary).
parent(jake,bob).
parent(zhane,melissa).
parent(stephen,paul).
parent(emily,bob).
parent(zhane,mary).

grandfather(X,Y) :- male(X), parent(X,Z),parent(Z,Y).
% grandfather(tom,jennifer).

% Explain: I moved male(tom). parent(tom,stephen). and parent(stephen,jennifer). to the topest lines.

% Q2: Explain in your own words why the change above affects total execution time.
% Show evidence of the faster execution time (provide a trace for each).

% Because prolog will find facts according to the orders given and if it finds the facts in the query, it will stop. By putting the facts to the top, the program will quickly find the facts and quit.

% Call: (11) grandfather(tom, jennifer) ? creep
% Call: (12) male(tom) ? creep
% Exit: (12) male(tom) ? creep
% Call: (12) parent(tom, _8810) ? creep
% Exit: (12) parent(tom, stephen) ? creep
% Call: (12) parent(stephen, jennifer) ? creep
% Exit: (12) parent(stephen, jennifer) ? creep
% Exit: (11) grandfather(tom, jennifer) ? creep

% Q3: Can we define a new rule {\tt grandmother} that calls into the goals presented above to correctly arrive at an answer?  Why or why not?
% No. Because if we want to define a rule grandmother, we need to define a rule female, but the above code didn't define rule female and we cannot assume that not male is female. As a result, we cannot define a new rule grandmother.

% Q4: Define new rules {\tt aunt} and {\tt uncle} that work with the rules above.  If you need to define other rules (including facts) in order to correctly define these, go ahead.  Assume that the universe of facts is {\bf not} complete.  

:- discontiguous parent/2. 
:- discontiguous aunt/2. 
:- discontiguous uncle/2.
female(mary).
female(emily).
female(melissa).
female(jennifer).
female(foo).

parent(jennifer, foo).


sibling(X,Y) :- parent(Z,X), parent(Z,Y), X\==Y.

aunt(X,Y) :- female(X), sibling(X,Z), parent(Z,Y).
uncle(X,Y) :- male(X), sibling(X,Z), parent(Z,Y).

% aunt(melissa,sarah). % true.
% aunt(mary,brian).    % true.
% aunt(jennifer,kevin). % true.
% aunt(mary,sarah).    % false.

% uncle(stephen,sarah). %true.
% uncle(paul,foo).      %true.
% uncle(stephen,jennifer). %false.

