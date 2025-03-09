clc;clear;close;

A = [-.75 1; -.3 -.75];
B = [2; 1];
C = [1 2];
D = 0;
A_r = [-.7 1; -.3 -.7];
sys_r = ss(A_r,B,C,D);
sys = ss(A,B,C,D);
Ts = 0.2;
% Make the system become discrete sample
sysd = c2d(sys,Ts);
% sysd = setmpcsignals(sysd,MV=1);
%%
mpcobj = mpc(sysd);
%%
Tstop = 50;
num_sim_steps = round(Tstop/Ts);
r = [zeros(num_sim_steps/5,1);ones(num_sim_steps/5,1);
    zeros(num_sim_steps/5,1);ones(2*num_sim_steps/5,1)];
mpcobj.Model.Plant = sys_r;
sim(mpcobj,num_sim_steps,r)
% [y,t,u] = sim(mpcobj,num_sim_steps,r);
% figure(1)
% plot(t,u)
% figure(2)
% plot(t,y)
% hold on
% [y,t] = lsim(sys,u,t);
% plot(t,y)

