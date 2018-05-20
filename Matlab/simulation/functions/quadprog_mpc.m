function [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,Q,delta_x,A_constraints, b_constraints)


H = gamma'*Q*gamma;


f = 2*(delta_x*psi'*Q*gamma);%2*delta_Ud'Q*gamma
%+2*(u'*gamma'*Q*theta) - (2*(x1*psi' ...
    %*Q*theta))-(2*(u'*gamma'*Q*theta))-(2*(delta_u'*theta'*Q ...
   % *theta))


% options = optimoptions(@fmincon,'Algorithm','interior-point','Display','final');
options = optimoptions('quadprog','Display','off','Algorithm','interior-point-convex');

 [X,FVAL,EXITFLAG] = quadprog(H,f,[],[],[],[],b_constraints(2,:),b_constraints(1,:),[],options);%quadprog(H,f,A,b,Aeq,beq,LB,UB,X0)
%  [X,FVAL,EXITFLAG] = linprog(f,[],[]);%quadprog(H,f,A,b,Aeq,beq,LB,UB,X0)