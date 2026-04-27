% Running Program:  clingo yosenabe1.lp instances/q3/instance01.lp 0
% Grade Program:    python autograder.py --question=3

% cell(X, Y).
% area(X, Y, A).
% number(X, Y, N).
% goal(A, G).

% =================================================================================
% Moving a Number
% ---------------
possible_move(X, Y, XX, YY) :- number(X, Y, _), area(XX, YY, _), X == XX, Y != YY.
possible_move(X, Y, XX, YY) :- number(X, Y, _), area(XX, YY, _), X != XX, Y == YY.
% achieved: Removed all instances in which the movement was not in a straight line and did not land in an area

{ target(X, Y, XX, YY) : possible_move(X, Y, XX, YY) } = 1 :- number(X, Y, _).
% achieved: Picked exactly 1 possible move

% =================================================================================
% Ensuring Numbers Move into an Area
% ----------------------------------
:- area(_, _, A), { target(_, _, XX, YY) : area(XX, YY, A) } = 0.
% achieved: Removed all empty areas

% =================================================================================
% Ensuring Paths Do Not Cross
% ---------------------------
path(X, Y, PathX, Y) :- target(X, Y, XX, Y), X < XX, PathX = X..XX.
% achieved: Gets cells traveled for a number moving positively along the X-axis

path(X, Y, PathX, Y) :- target(X, Y, XX, Y), X > XX, PathX = XX..X.
% achieved: Gets cells traveled for a number moving negatively along the X-axis

path(X, Y, X, PathY) :- target(X, Y, X, YY), Y < YY, PathY = Y..YY.
% achieved: Gets cells traveled for a number moving positively along the Y-axis

path(X, Y, X, PathY) :- target(X, Y, X, YY), Y > YY, PathY = YY..Y.
% achieved: Gets cells traveled for a number moving negatively along the Y-axis


:- path(X1, Y1, PathX, PathY), path(X2, Y2, PathX, PathY), X1 != X2.
:- path(X1, Y1, PathX, PathY), path(X2, Y2, PathX, PathY), Y1 != Y2.
% achieved: Removes all instances in which two paths cross

#show target/4.