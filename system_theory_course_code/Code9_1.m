clc;clear;close
%% define the system
A = [-.75 1; -.3 -.75];
B = [2; 1];
C = [1 2];
D = 0;
sys = ss(A,B,C,D);
Wc = gram(sys,'c')  % Controllability Gramian
Wo = gram(sys,'o') % Observability Gramian

%% Balance the system
[sysb,g,Ti,T] = balreal(sys); 
BWc = gram(sysb,'c') % Balanced Gramians
BWo = gram(sysb,'o')

%% Plot Gramians
theta = 0:.01:2*pi;
xc = cos(theta);
yc = sin(theta);
CIRC = [xc; yc];
ELLIPb = Ti*sqrt(BWc)*T*CIRC;
ELLIPc = sqrt(Wc)*CIRC;
ELLIPo = sqrt(Wo)*CIRC;
plot(xc,yc,'k--','LineWidth',2)
hold on
% Draw controllability Gramian (unbalanced)
plot(ELLIPc(1,:),ELLIPc(2,:),'r','LineWidth',2)
patch(ELLIPc(1,:),ELLIPc(2,:),'r','FaceAlpha',.75)
% Draw observability Gramian (unbalanced)
plot(ELLIPo(1,:),ELLIPo(2,:),'b','LineWidth',2)
patch(ELLIPo(1,:),ELLIPo(2,:),'b','FaceAlpha',.75)
% Draw balanced Gramians
patch(ELLIPb(1,:),ELLIPb(2,:),'k','FaceColor',[.5 0 .5],'FaceAlpha',.25)
plot(ELLIPb(1,:),ELLIPb(2,:),'Color',[.35 0 .35],'LineWidth',2)