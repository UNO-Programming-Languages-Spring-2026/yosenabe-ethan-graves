% Running Program: clingo yosenabe1.lp instances/q1/instance01.lp 0

% cell(X, Y).
% area(X, Y, A).
% number(X, Y, N).
% goal(A, G).

possible_move(X, Y, XX, YY) :- number(X, Y, _), area(XX, YY, _), X == XX, Y != YY.
possible_move(X, Y, XX, YY) :- number(X, Y, _), area(XX, YY, _), X != XX, Y == YY.
% achieved: Removed all instances in which the movement was not in a straight line

{ target(X, Y, XX, YY) : possible_move(X, Y, XX, YY) } = 1 :- number(X, Y, _).
% achieved: Picked exactly 1 possible move

#show target/4.