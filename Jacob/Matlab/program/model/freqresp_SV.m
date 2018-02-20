function [x,y,g11,g12,g21,g22]=freqresp_SV(Q,L,B,Sb,K,m,yL,w,dx)

% function [x,y,g11,g12,g21,g22]=freqresp_SV(Q,L,B,Sb,K,m,yL,w,dx)
%
% Computation of the frequency response of linearized Saint-Venant equation 
% for a canal described by its physical parameters 
%        Q  = discharge
%        L  = canal length       
%        B  = bottom width
%        Sb = bottom slope
%        K  = Strickler coefficient (inverse of Manning)
%        m  = side slope
%        yL = downstream boundary condition
%        w  = frequency points
%        dx = discretization space step
%
% The function returns:
% - x: the abscissa vector
% - y: the water depth
% - gij(nw,nx): the distributed transfer function, with nw the number of frequency points
% and nx the number of space discretization points
%
% X. Litrico, 2001/2009

g=9.81;

x=0:dx:L;
% computation of the backwater curve
[x_c,y]=ode45('backwater',[L 0],yL,[],K,Sb,B,m,Q);
% interpolation 
yq=interp1(x_c,y,x);
y=yq;

%---------------------------------
% computation of the Saint Venant transfer matrix
%---------------------------------
% Physical characteristics of the flow
T=B+2*m*y;
A=y.*(B+m*y);
P=B+2*sqrt(1+m^2)*y;
R=A./P;
% square of the Froude number
Fr2=Q^2*T./(g*A.^3);
% friction slope
Sf=Q^2./(K^2*A.^2.*R.^(4/3));
%---------------------------------
% numerical estimation of dy/dx
nx=length(A);
dydx=(y(2:nx)-y(1:nx-1))./(x(2:nx)-x(1:nx-1));dydx(nx)=dydx(nx-1);
% dPdy
dPdy=2*sqrt(1+m^2); 
dTdx=2*m*dydx;
%------------------
V=Q./A;%velocity
C=sqrt(g*A./T);%celerity
%------------------
alpha=V+C;
beta=C-V;
kappa=7/3-4/3*A./P./T.*dPdy;
gamma=g*(kappa.*Sf+Sb-(1+2*Fr2).*dydx)+C.^2.*dTdx./T;
delta=2*g./V.*(Sf-Fr2.*dydx);
%-----

% computation of the delays for non uniform flow
[tau1,tau2,r1,r2]=delay_SV(x,alpha,beta,gamma,delta);

%%%%%%%%%%%%%%%%%%%%%%%
% numerical computation of the frequency response for each s=jw
for kw=1:length(w)
    s=sqrt(-1)*w(kw);
    % initialisation of Phi
    Phi=[1 0;0 1];
    phi11(kw,1)=Phi(1,1);phi12(kw,1)=Phi(1,2);phi21(kw,1)=Phi(2,1);phi22(kw,1)=Phi(2,2); 
    % computation of the eigenvalues
    d=(alpha+beta).^2*s^2+2*((alpha-beta).*gamma+2*alpha.*beta.*delta)*s+gamma.^2;
    lambda1=((alpha-beta)*s+gamma-sqrt(d))./(2*alpha.*beta);
    lambda2=((alpha-beta)*s+gamma+sqrt(d))./(2*alpha.*beta);
    for kx=2:length(x)
        % the solution is computed for each space step assuming a constant
        % matrix A(s)
        dx=x(kx)-x(kx-1);
        phi11c=(lambda1(kx)*exp(lambda1(kx)*dx)-lambda2(kx)*exp(lambda2(kx)*dx))/(lambda1(kx)-lambda2(kx));
        phi12c=lambda1(kx)*lambda2(kx)*(exp(lambda1(kx)*dx)-exp(lambda2(kx)*dx))/s/(lambda1(kx)-lambda2(kx));
        phi21c=s*(exp(lambda2(kx)*dx)-exp(lambda1(kx)*dx))/(lambda1(kx)-lambda2(kx));;
        phi22c=(lambda1(kx)*exp(lambda2(kx)*dx)-lambda2(kx)*exp(lambda1(kx)*dx))/(lambda1(kx)-lambda2(kx));
        % computation of the transition matrix Phi
        Phi=[phi11c phi12c;phi21c phi22c]*Phi;
        phi11(kw,kx)=Phi(1,1);
        phi12(kw,kx)=Phi(1,2);
        phi21(kw,kx)=Phi(2,1);
        phi22(kw,kx)=Phi(2,2);
    end
    % distributed transfer functions
    g11(kw,:)=(phi12(kw,:)-phi11(kw,:).*phi22(kw,nx)./phi21(kw,nx))./T;
    g12(kw,:)=phi11(kw,:)./phi21(kw,nx)./T;
    g21(kw,:)=phi22(kw,:)-phi21(kw,:).*phi22(kw,nx)./phi21(kw,nx);
    g22(kw,:)=phi21(kw,:)./phi21(kw,nx);
end    
