% Running Program:  clingo yosenabe4.lp instances/q4/instance01.lp 0
% Grade Program:    python autograder.py --question=4

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

% =================================================================================
% Goal Sums within Area
% ---------------------
area_nums(X, Y, N, A) :- target(X, Y, XX, YY), number(X, Y, N), area(XX, YY, A).
% achieved: Gets area_nums such that:
%   * The starting X and Y for target and number are the same, keeping track of number's N value
%   * The ending XX and YY for target and area are the same, keeping track of area's A value

:- goal(A, G), #sum{ N, X, Y : area_nums(X, Y, N, A) } != G.
% achieved: Removes all instances in which the numbers in a given area do not sum to the goal number G

#show target/4.