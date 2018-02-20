% this file computes the Hinfinity controller and compares it with the PI one
% A simulator is also provided see file model_bf_true_simulation.mdl 

% model initialisation 

% Dimensionless ID model :  y =1/s[ e^-s u1 - u2 - p]
% 1 output
% y : dimensionless water level (downstream) (deviation)
% 3 inputs 
% u1: dimensionless upstream discharge (deviation)
% u2: dimensionless downstream discharge (deviation)
% p: dimensionless water withdrawal (deviation)


[num_pade,den_pade]=pade(1,10); % state space approximation of the delay by a pade approximation
sys_bo_ss=ss(tf(1,[1 0]))*[ss(tf(num_pade,den_pade)),  -1  ,  -1];

 
% frequency for frequency plot
omega=logspace(-5,5,100);
close all
%
% see model_po.mdl  for augmented plant
%

%%%%%%%%%%%%%%%%%%%%%%%
%
%            W11  weighting transfer function 
%
%%%%%%%%%%%%%%%%%%%%%%%
G0=100000;
DG=10;
w180=pi/2;
wc=w180*10^(-DG/20)*10;
Ginfi=0.01;

numW11=[Ginfi*sqrt(abs(G0^2-1)),G0*wc*sqrt(abs(Ginfi^2-1))];
denW11=[sqrt(abs(G0^2-1)),wc*sqrt(abs(Ginfi^2-1))];
W11=balreal(ss(tf(numW11,denW11)));
Wpe1=ss([],[],[],0.1);

%%%%%%%%%%%%%%%%%%%%%%%
%
%            W12  weighting transfer function 
%
%%%%%%%%%%%%%%%%%%%%%%%

G0=100000;
DG=10;
w180=pi/2;
wc=w180*10^(-DG/20);
Ginfi=0.01;
numW12=[Ginfi*sqrt(abs(G0^2-1)),G0*wc*sqrt(abs(Ginfi^2-1))];
denW12=[sqrt(abs(G0^2-1)),wc*sqrt(abs(Ginfi^2-1))];
W12=balreal(ss(tf(numW12,denW12)));
Wpe2=ss([],[],[],0.1);
  
%%%%%%%%%%%%%%%%%%%%%%%
%
%            W21 weighting transfer function 
%
%%%%%%%%%%%%%%%%%%%%%%%

G0=0.7;
Ginfi=3000;
wc=w180*10^(-DG/20);
wc=wc*20;
numW2=[Ginfi*sqrt(abs(G0^2-1)),G0*wc*sqrt(abs(Ginfi^2-1))];
denW2=[sqrt(abs(G0^2-1)),wc*sqrt(abs(Ginfi^2-1))];
W21=balreal(ss(tf(numW2,denW2)));


%%%%%%%%%%%%%%%%%%%%%%%
%
%            W22 weighting transfer function 
%
%%%%%%%%%%%%%%%%%%%%%%%

G0=0.9;
Ginfi=3000;
wc=w180*10^(-DG/20);
wc=wc*200;
numW2=[Ginfi*sqrt(abs(G0^2-1)),G0*wc*sqrt(abs(Ginfi^2-1))];
denW2=[sqrt(abs(G0^2-1)),wc*sqrt(abs(Ginfi^2-1))];
W22=balreal(ss(tf(numW2,denW2)));

 
%%%%%%%%%%%%%%%%%%%%%%%
%
%            Wp1 weighting transfer function 
%
%%%%%%%%%%%%%%%%%%%%%%%

Wp1=ss([],[],[],0.6);

%%%%%%%%%%%%%%%%%%%%%%%
%
%            Wp2 weighting transfer function 
%
%%%%%%%%%%%%%%%%%%%%%%%

Wp2=ss([],[],[],0.6);


% In order to reduce the order of the final controller, the order of the 
% rational approximation of the plant has to be kept as small as possible
% here we choose a first order approximation of a delay through Pade approximation 
%
[num_pade,den_pade]=pade(1,1); % the synthesis model is of order 1
sys_synt_ss=ss(tf(1,[1 0]))*[ss(tf(num_pade,den_pade)),  -1  ,  -1];

[A,B,C,D]=linmod('model_po');
sys_aug=ss(A,B,C,D);  % corresponds to the augmented plan (without the controller)
sys_aug=minreal(sys_aug);  % 
%
% synthesis of the Hinfinity controller 
%
[K_hinf_ss,CL,gamma] = hinfsyn(sys_aug,2,2,'GMAX',3, 'GMIN',0,'TOLGAM',0.01,'METHOD','ric','DISPLAY','on');

%Due to specific structure of the design sheme, that leads to an algebraic loop for simulation and that can be easily avoided
% by computing the  appropriate controller. 
%
K_simul=feedback(K_hinf_ss,ss([],[],[],[0 0 ;0 1]));


% the maximal singular value  of the augmented system + controller   as a function of the frequency 
% is necessarily  less than or equal to gamma 
%

[A,B,C,D]=linmod('model_bf_po');  %augmented  system with the controller 

sys_bf_p=ss(A,B,C,D);
figure(1)
out=sigma(sys_bf_p,omega);
semilogx(omega,out(1,:));
grid on
text_title=['Hinfini norm vs omega \gamma =', num2str(gamma)];
title(text_title) 


%%%%%%%%%%%%%%%%%%%%%%%
%
%    DESIGN ANALYSIS 
%
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CLOSED LOOP ANALYSIS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%

 
%
% Singular value and associated constraints on each block
%
figure(2)
[A,B,C,D]=linmod('model_bf');
sys_bf=ss(A,B,C,D);

sys_p_inv=[inv(W11)*inv(Wpe1),inv(W12)*inv(Wpe1),inv(W21)*inv(Wpe1),inv(W22) *inv(Wpe1); 
              inv(W11)*inv(Wpe2),inv(W12)*inv(Wpe2), inv(W21)*inv(Wpe2),inv(W22)*inv(Wpe2) ; 
               inv(Wp1) *inv(W11),inv(Wp1)*inv(W12), inv(Wp1) *inv(W21),inv(Wp1)*inv(W22) ; 
               inv(Wp2) *inv(W11),inv(Wp2)*inv(W12), inv(Wp2) *inv(W21),inv(Wp2)*inv(W22)  ];
       
k=0;
    for i=1:4
        for j=1:4
            k=k+1;
            subplot(4,4,k)
            sigma(sys_p_inv(j,i),sys_bf(i,j),omega);
            xlabel('rad/s')
            ylabel('gain')
            grid
            title(['m_{',num2str(i),num2str(j),'}'])
        end 
    end
 
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input margin considering a full complex block (Se and Te) 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


omega_mu=logspace(-2,2,500);
% 
% We use herafter the true plant and not the one use for the synthesis 
%

[A,B,C,D]=linmod('model_bf_margin');
sys_margin=ss(A,B,C,D);

%Computation of the infinity norm of Te=KG(I+KG)

norm_hinf_Te= norm(sys_margin([1,2],[1 2]),inf);
alpha=1/norm_hinf_Te;

% and since the system remains stable for   
% \| delta\|< alpha 
% which could be interpreted as the stability with respect to additive block
%  I+ delta  =  k => 1-1/beta  < Dk <1+1/beta
% where DK is an adititive perturbation

marge_max=1+alpha;
marge_min=1-alpha;

%Computation of the infinity norm of Se=(I+KG)

norm_hinf_Se=norm(sys_margin([3,4],[1 2]),inf);
alpha=1/norm_hinf_Se;

disp('Complex margin obtained assuming a full  complex block at the system input (in dB)')
margin_max=log10(max(marge_max,1/(1-alpha)))*20
margin_min=log10(min(marge_min,1/(1+alpha)))*20


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input margin with diagonal uncertianties =>  mu analysis 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We could also consider the margin for 2 complex diagonal blocks  !! 
% by taking  
% blk=[1 0;1 0;] which allows to compute the margin with respect to a
% diagonal uncertainty acting at the system input 
% In this case, the system remains stable despite the action of any LTI dynamical uncertaities 
% with a norm less than the margin ....
%
% by taking 
% blk=[2 2]  the mu computation leads to the same result obtained when we
% have  considered a full complex block acting at the input (the margin
% compute on the basis of the infinity norms of Se and Te see above)
% 
%

%
%Mu computation 2 real diagonal blocks  !! 
%we then obtain the possible scaling of the input gain with two gains acting
% respectively on each input: whatever is the value of each of this parameter, if
% its norm remains less than the margin, the system remains stable !
%

blk=[-1 0;-1 0];
%
% dont forget to compute the mu value at w=0 !!! 
%
outSe=freqresp(sys_margin([3,4],[1 2]),[0,omega_mu]);
ubnd=mussv(outSe,blk,'U');

ub=squeeze(ubnd);
%max of mu
data=max(ub(1,:));

figure(3)
subplot(1,2,1)
semilogx(omega_mu,ub(1,[2:end]))
grid on 
title_text=['Real \mu associated to S_e: ' num2str((data))];
title(title_text)  
xlabel('rad/s')
ylabel('Gain')

alpha=1/(data);
%
% \| delta\|<1/beta
% I+delta=k =>  1-1/beta< Dk <1+1/beta
%
marge_max=1+alpha;
marge_min=1-alpha;
 


outTe=freqresp(sys_margin([1,2],[1 2]),[0,omega_mu]);
ubnd=mussv(outTe,blk,'U');
ub=squeeze(ubnd);
data=max(ub(1,:));
subplot(1,2,2)
semilogx(omega_mu,ub(1,[2:end]))
grid
title_text=['Real \mu associated to T_e: ' num2str((data))];
title(title_text)  
xlabel('rad/s')
ylabel('Gain')

 
alpha=1/max(data);
disp('Real diagonal margin (in dB)')
margin_max=log10(max(marge_max,1/(1-alpha)))*20
margin_min=log10(min(marge_min,1/(1+alpha)))*20





