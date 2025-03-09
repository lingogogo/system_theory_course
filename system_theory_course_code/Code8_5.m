clear; close all; clc

m = 1;
M = 5;
L = 2;
g = -10;
d = 1;

s = -1; % pendulum up (s=1)

A = [0 1 0 0;
    0 -d/M -m*g/M 0;
    0 0 0 1;
    0 -s*d/(M*L) -s*(m+M)*g/(M*L) 0];

B = [0; 1/M; 0; s*1/(M*L)];

C = [0 0 1 0];  % only observable if x measured... because x can't be reconstructed
% C = [0 1 0 0];
obsv(A,C)
det(obsv(A,C))

