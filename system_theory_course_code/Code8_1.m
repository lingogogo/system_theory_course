clc;clear;close

t=0:0.01:5;
r_ref=50*ones(size(t));
d_dis=5*sin(pi*t);

myModel=5;
myModel_true=6;

% open loop
u_oc=r_ref/myModel;  % can be specify in advance
y_oc=myModel_true*u_oc+d_dis;

% closed loop (values cannot be specified in advance; must be adjusted over time)
K=20;
y_cl=myModel_true*K/(1+myModel_true*K)*r_ref+d_dis/(1+myModel_true*K);

plot(t,r_ref,'k',t,y_oc,'r',t,y_cl,'b','Linewidth',2)
legend('ref', 'open loop', 'closed loop')



