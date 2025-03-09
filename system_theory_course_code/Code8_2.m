clear; close all; clc


g=9.8;
L=5;
param=[g;L];

x0=[0.01; 0];  % Initial condition     or x0=[0; 0.01]
dt = 0.001;
tspan=dt:dt:5;

[t,x]=ode45(@(t,x) inverted_pen(t,x,param),tspan,x0);

figure
plot(t,x(:,1),'k',t,x(:,2),'r','LineWidth',2);
legend('\theta','\theta dot')
title('Nonlinear')

[t,x]=ode45(@(t,x) inverted_pen_linear_up(t,x,param),tspan,x0);
figure
plot(t,x(:,1),'k',t,x(:,2),'r','LineWidth',2);
legend('\theta','\theta dot')
title('Linearization (up)')

[t,x]=ode45(@(t,x) inverted_pen_linear_down(t,x,param),tspan,x0);
figure
plot(t,x(:,1),'k',t,x(:,2),'r','LineWidth',2);
legend('\theta','\theta dot')
title('Linearization (down)')

function dx=inverted_pen(t,x,param)
g=param(1);
L=param(2);
dx=[ x(2);                   
    -(g/L)*sin(x(1))];
end
function dx=inverted_pen_linear_up(t,x,param)
g=param(1);
L=param(2);
A=[0 1;g/L 0];
dx=A*x;
end
function dx=inverted_pen_linear_down(t,x,param)
g=param(1);
L=param(2);
A=[0 1;-g/L 0];
dx=A*x;
end
