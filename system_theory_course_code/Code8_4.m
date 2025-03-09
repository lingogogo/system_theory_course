clear; close all; clc



g=9.8;
L=5;

%% linearized model (pendulum-up configuration) and controllability
A=[0 1;g/L 0];B=[0;1];
rank_C=rank(ctrb(A,B))   % check 

%%  design the controller and apply it to nonlinear sytem 
myeig=[-2;-3];
K=place(A,B,myeig);
param=[g;L; K'];

x0=[0.01; 0.1];  % Initial condition     or x0=[0; 0.01]
dt = 0.001;
tspan=dt:dt:5;

[t,x]=ode45(@(t,x) inverted_pen(t,x,param),tspan,x0);

figure
plot(t,x(:,1),'k',t,x(:,2),'r','LineWidth',2);
legend('\theta','\theta dot')
title('Nonlinear')

function dx=inverted_pen(t,x,param)
g=param(1);
L=param(2);
K=param(3:4)';
u=-K*x;
dx=[ x(2);                   
    -(g/L)*sin(x(1))+u  ];
end

