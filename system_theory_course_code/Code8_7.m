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

C = [1 0 0 0];  % only observable if x measured... because x can't be reconstructed


C_cal=ctrb(A,B);
rank(C_cal)
O_cal=obsv(A,C);
O_cal=rank(obsv(A,C))

%% Design the controller and observer using separation principle

myeig=[-2+1i;-2-1i;-3+1i;-3-1i];
K=place(A,B,myeig);

myeig=[-3+1i;-3-1i;-4+1i;-4-1i];
L_ob=(place(A',C',myeig))';



param=[g;L; K'];
% 
x0=rand(8,1);  % Initial condition     or x0=[0; 0.01]
dt = 0.001;
tspan=dt:dt:10;

[t,x]=ode45(@(t,x) pendcart(x,m,M,L,g,d,K,L_ob,A,B,C),tspan,x0);


figure
plot(t,x(:,1),'k',t,x(:,5),'r','LineWidth',2);
legend('x','x est')
title('Observer')

figure
plot(t,x(:,2),'k',t,x(:,6),'r','LineWidth',2);
legend('v','v  est')
title('Observer')

figure
plot(t,x(:,3),'k',t,x(:,7),'r','LineWidth',2);
legend('\theta','\theta  est')
title('Observer')

figure
plot(t,x(:,4),'k',t,x(:,8),'r','LineWidth',2);
legend('w','w  est')
title('Observer')



figure
plot(t,x(:,3),'k',t,x(:,4),'r','LineWidth',2);
legend('\theta','\theta dot')
title('Controller')


function dx = pendcart(x,m,M,L,g,d,K,L_ob,A,B,C)
dx=zeros(8,1);
Sx = sin(x(3));
Cx = cos(x(3));
D = m*L*L*(M+m*(1-Cx^2));
u=-K*x(5:8);

dx(1) = x(2);
dx(2) = (1/D)*(-m^2*L^2*g*Cx*Sx + m*L^2*(m*L*x(4)^2*Sx - d*x(2))) + m*L*L*(1/D)*u;
dx(3) = x(4);
dx(4) = (1/D)*((m+M)*m*g*L*Sx - m*L*Cx*(m*L*x(4)^2*Sx - d*x(2))) - m*L*Cx*(1/D)*u;

dx(5:8)=A*x(5:8)+B*u+L_ob*C*(x(1:4)-x(5:8));



end


