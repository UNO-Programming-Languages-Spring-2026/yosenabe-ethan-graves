% Running Program:  clingo yosenabe2.lp instances/q2/instance01.lp 0
% Grade Program:    python autograder.py --question=2

% cell(X, Y).
% area(X, Y, A).
% number(X, Y, N).
% goal(A, G).

% =================================================================================
% Moving a Number
% ---------------
possible_move(X, Y, XX, YY) :- number(X, Y, _), area(XX, YY, _), X == XX, Y != YY.
possible_move(X, Y, XX, YY) :- number(X, Y, _), area(XX, YY, _), X != XX, Y == YY.
% achieved: Removed all instances in which the movement was not in a straight line

{ target(X, Y, XX, YY) : possible_move(X, Y, XX, YY) } = 1 :- number(X, Y, _).
% achieved: Picked exactly 1 possible move

% =================================================================================
% Ensuring Numbers Move into an Area
% ----------------------------------
:- area(_, _, A), { target(_, _, XX, YY) : area(XX, YY, A) } = 0.
% achieved: Removed all moved numbers that were not in an area


#show target/4.