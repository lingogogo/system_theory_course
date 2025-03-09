clc;clear;close all
q = 2;   % Number of inputs
p = 2;   % Number of outputs
n = 150; % State dimension
% sysFull = drss(n,p,q); % Discrete random system
load data9_2.mat

%% Plot Hankel singular values
hsvs = hsvd(sysFull); % Hankel singular values


r = 20;  % Reduced model order
figure
subplot(1,2,1)
semilogy(hsvs,'k','LineWidth',2)
hold on, grid on
semilogy(r,hsvs(r),'ro','LineWidth',2)
subplot(1,2,2)
plot(0:length(hsvs),[0; cumsum(hsvs)/sum(hsvs)],'k','LineWidth',2)
hold on, grid on
plot(r,sum(hsvs(1:r))/sum(hsvs),'ro','LineWidth',2)

%% Exact balanced truncation
sysBT = balred(sysFull,r);  % Balanced truncation

%% Plot impulse responses for all methods
figure
Tend=50;
impulse(sysFull,0:1:Tend), hold on;
impulse(sysBT,0:1:Tend)
legend('Full model, n=150','Balanced truncation, r=20')
