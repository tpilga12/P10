function [X,FVAL,EXITFLAG]=quadprog(gamma,psi,Q,delta_x)


H = gamma'*Q*gamma;


f = 2*(x1*psi'*Q*gamma);%2*delta_Ud'Q*gamma
%+2*(u'*gamma'*Q*theta) - (2*(x1*psi' ...
    %*Q*theta))-(2*(u'*gamma'*Q*theta))-(2*(delta_u'*theta'*Q ...
   % *theta))


% options = optimoptions(@fmincon,'Algorithm','interior-point','Display','final');
options = optimoptions('quadprog','Display','off','Algorithm','interior-point-convex');

 [X,FVAL,EXITFLAG] = quadprog(H,f,[],[],[],[],[],[],[],options);%quadprog(H,f,A,b,Aeq,beq,LB,UB,X0)