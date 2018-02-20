
% In this file, we compute the Hinfinity controller and compare it with the PI one
 % A simulink simulator  is also associated :  model_bf_true_simulation.mdl 

%  model initialisation 

% Dimensionless ID model :  y =1/s[ e^-s u1 - u2 - p]
% Output
% y : dimensionless water level (downstream) (deviation)
% 3 inputs 
% u1: dimensionless upstream discharge (deviation)
% u2: dimensionless downstream discharge (deviation)
% p: dimensionless water withdrawal (deviation)

%
% state space approximation of the delay by a pade approximation of an high order  (that allows us  to easily handle delay through its rational approximation)
%
[num_pade,den_pade]=pade(1,10);

% State space realization  of the open loop system
sys_bo_ss=ss(tf(1,[1 0]))*[ss(tf(num_pade,den_pade)),  -1];
% Obtained a balanced realization  (allows to avoid some numerical problems)
sys_bo_ss=balreal(sys_bo_ss);

% Initialize PI  controller for DG=10 db and Delta Phi /Delta Phi_max =0.7

    DG=10;
    w180=pi/2;
    wc=w180 *10^(-DG/20);
    MPmax= 90-180/pi*wc;
    alpha=0.7;
    MP= alpha * MPmax;
    Ti=1/wc*tan(pi/180*MP + wc);
    kp=Ti*wc^2/sqrt(1+Ti^2*wc^2);
    K_PI_ss=kp*(ss(tf(1,[Ti 0]))+1);

close all
%
% see model_po.mdl  for augmented plant
%

%%%%%%%%%%%%%%%%%%%%%%%
%
%            W1 weighting transfer function 
%
%%%%%%%%%%%%%%%%%%%%%%%
G0=100000;
DG=10;
w180=pi/2;
wc=w180*10^(-DG/20)*0.9/0.8;
Ginfi=0.6;

numW1=[Ginfi*sqrt(abs(G0^2-1)),G0*wc*sqrt(abs(Ginfi^2-1))];
denW1=[sqrt(abs(G0^2-1)),wc*sqrt(abs(Ginfi^2-1))];
W1=ss(tf(numW1,denW1));

%%%%%%%%%%%%%%%%%%%%%%%
%
%            W2 weighting transfer function 
%
%%%%%%%%%%%%%%%%%%%%%%%
G0=0.2;
Ginfi=3000;
wc=wc*15;
numW2=[Ginfi*sqrt(abs(G0^2-1)),G0*wc*sqrt(abs(Ginfi^2-1))];
denW2=[sqrt(abs(G0^2-1)),wc*sqrt(abs(Ginfi^2-1))];
W2=ss(tf(numW2,denW2));

%%%%%%%%%%%%%%%%%%%%%%%
%
%            Wp weighting transfer function 
%
%%%%%%%%%%%%%%%%%%%%%%%

Wp=ss([],[],[],0.2);

%%%%%%%%%%%%%%%%%%%%%%%
%
%            Plot of the weigting functions
%
%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
omega=logspace(-8,6,300);
out=sigma([W1],omega);
semilogx(omega,20*log10(out))
hold on
out=sigma([W2],omega);
semilogx(omega,20*log10(out))
xlabel('rad/s')
ylabel('dB')
legend('W_1','W_2')
grid on
title('Weighting functions (gain)')


% In order to reduce the order of the final controller, the order of the 
% rational approximation of the plant has to keep as small as is possible
% here we choose a first order approximation of the delay 
%

% Pade approximation of order 1

[num_pade,den_pade]=pade(1,1); % the synthesis model is of order 1

sys_synt_ss=ss(tf(1,[1 0]))*[ss(tf(num_pade,den_pade))];
sys_synt_ss=minreal(sys_synt_ss);

warning('off','MATLAB:dispatcher:InexactMatch')

[A,B,C,D]=linmod('model_po');
sys_aug=ss(A,B,C,D);  % corresponds to the augmented plan (without the controller)
sys_aug=minreal(sys_aug);
 
% 
%
% synthesis of the Hinfinity controller 
%

[K_hinf_ss,CL,gamma] = hinfsyn(sys_aug,1,1,'GMAX',3, 'GMIN',0,'TOLGAM',0.001,'METHOD','ric','DISPLAY','on');



%%%%%%%%%%%%%%%%%%%%%%%
%
%    DESIGN ANALYSIS 
%
%%%%%%%%%%%%%%%%%%%%%%%


%
% The maximal singular value  of the augmented system + controller  as a function of the frequency 
% is necessarily  less than or equal to the optimal 'gamma' 
%
% This plot is necessary in order to detect some numerical problems
% associated to the computation of the H infinity controller.
% 

warning('off','MATLAB:dispatcher:InexactMatch')
[A,B,C,D]=linmod('model_bf_po');  %augmented  system with the controller 
sys_bf_p=ss(A,B,C,D);
figure(2)
clf
omega=logspace(-6,2,300);
out=sigma(sys_bf_p,omega);
semilogx(omega,out(1,:));
grid on
text_title=['Maximal singular value as a function of \omega    (\gamma =', num2str(gamma),')'];
xlabel('rad/s')
title(text_title) 



%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CLOSED LOOP ANALYSIS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% frequency for computing singular value of each block.
%
omega=logspace(-2,2,300);
 
%
% Singular value and associated constraints on each block
%
figure(3)
[A,B,C,D]=linmod('model_bf');
sys_bf=ss(A,B,C,D);
omega=logspace(-6,2,1000);
sys_p_inv=[inv(W1),inv(W1*Wp);inv(W2),inv(W2*Wp)];
legend_figure={'|S(j\omega)|','|G(j\omega)S(j\omega)|','|K(j\omega)S(j\omega)|','|T(j\omega)|'};
k=0;
    for i=1:2
        for j=1:2
            k=k+1;
            subplot(2,2,k)
            SV =sigma(sys_bf(i,j),omega);
            semilogx(omega,20*log(SV)/log(10))
            %title(['m_{',num2str(i),num2str(j),'}'])
            hold on
            SV=sigma(sys_p_inv(i,j),omega) ;    
            semilogx(omega,20*log(SV)/log(10),'--')
            grid on     
            xlabel('Frequency (rad/s)')
            ylabel('Singular values (dB)')
            grid on
            legend(legend_figure(k),'Associated weighting constraint');
        end 
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%           OPEN LOOP ANALYSIS  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Bode plot  of the Hinfty controller and the PI one
%
figure(4)
omega=logspace(-3,3,500);

[mag,phase,omega]=bode(K_hinf_ss,omega);
phase = reshape(phase,[1*1 size(phase,3)]);
mag= reshape(mag,[1*1 size(mag,3)]);
subplot(2,1,1)
semilogx(omega,20*log(mag)/log(10))
title('Bode Diagram')
hold on
subplot(2,1,2) 
semilogx(omega,phase)
hold on 

[mag,phase,omega]=bode(K_PI_ss,omega);
phase = reshape(phase,[1*1 size(phase,3)]);
mag= reshape(mag,[1*1 size(mag,3)]);
subplot(2,1,1)
semilogx(omega,20*log(mag)/log(10),'--')
grid
legend('K_\infty','K_{PI}')
xlabel('Frequency (rad/s)')
ylabel('Magnitude (dB)')
subplot(2,1,2) 
semilogx(omega,phase,'--')
grid
xlabel('Frequency (rad/s)')
ylabel('Phase (deg)')
 

figure(5) 

%
% Compute margin obtained with the 'real plant'  
%
[G,P]=bode(K_hinf_ss*sys_bo_ss(1),omega);
[DG,DP]=margin(G(1,:),P(1,:),omega);
P= reshape(P,[1*1 size(P,3)]);
G= reshape(G,[1*1 size(G,3)]);

subplot(2,1,1)
semilogx(omega,20*log(G)/log(10))
hold on
subplot(2,1,2) 
semilogx(omega,P)
hold on

%
% Open loop with the PI  
% 
[G,P]=bode(K_PI_ss*sys_synt_ss(1),omega);
P= reshape(P,[1*1 size(P,3)]);
G= reshape(G,[1*1 size(G,3)]);
subplot(2,1,1)
semilogx(omega,20*log(G)/log(10),'--')
subplot(2,1,2) 
semilogx(omega,P,'--')

%
% Open loop with the model for synthesis 
%
[G,P]=bode(K_PI_ss*sys_bo_ss(1),omega);
P= reshape(P,[1*1 size(P,3)]);
G= reshape(G,[1*1 size(G,3)]);
subplot(2,1,1)
semilogx(omega,20*log(G)/log(10),'-.')
grid on
xlabel('Frequency (rad/s)')
ylabel('Magnitude (dB)')
legend('Open loop of the H_\infty controller and integrator+delay model','Open loop  of the H_\infty controller and integrator + pade approximation','Open loop  of the PI controller and integrator + delay')
title({'Bode Diagram'; ['Gain margin= ',num2str(fix(10*20*log10(DG))/10),'dB   Phase margin = ',num2str(fix(1*DP)/1),'deg']})
subplot(2,1,2) 
semilogx(omega,P,'--')
grid on
xlabel('Frequency (rad/s)')
ylabel('Phase (deg)')
grid on


