clc;clear;close

%% 1
A=[1 0;0 2];B=[0;1];
Ctrl= [B A*B]
Ccal= ctrb(A,B)

%% 2
A=[1 0;0 2];B=[1 0;0 1];
Ctrl= [B A*B]
Ccal= ctrb(A,B)

%% 3
A=[1 1;0 2];B=[0;1];
Ctrl= [B A*B]
Ccal= ctrb(A,B)

%% 4
A=[1 0;0 2];B=[1;1];
Ctrl= [B A*B]
Ccal= ctrb(A,B)