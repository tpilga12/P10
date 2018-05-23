function [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,Q,delta_xstates,A_constraints, b_constraints,Alifted,Bulifted,xstates_old,u_output_tank_old,Test_matrix,xstates)

% b_constraints1(:,1) = b_constraints(:,2)-(Alifted*(delta_xstates'-xstates_old')-Bulifted*ones(120,1)*u_output_tank_old);
b_constraints1(:,1) = b_constraints(:,2)+(Alifted*(xstates')+Bulifted*ones(120,1)*u_output_tank_old);
% b_constraints2 = b_constraints(2,:)-Alifted*delta_xstates';
H = gamma'*Q*gamma;


f = 2*(delta_xstates*psi'*Q*gamma);%2*delta_Ud'Q*gamma
%+2*(u'*gamma'*Q*theta) - (2*(x1*psi' ...
    %*Q*theta))-(2*(u'*gamma'*Q*theta))-(2*(delta_u'*theta'*Q ...
   % *theta))



% options = optimoptions(@fmincon,'Algorithm','interior-point','Display','final');
options = optimoptions('quadprog','Display','final','Algorithm','interior-point-convex');
LowerBound = zeros(120,1);
UpperBound = ones(120,1);
%  [X,FVAL,EXITFLAG] = quadprog(H,f,[],[],[],[],[],[],[],options);
 [X,FVAL,EXITFLAG] = quadprog(H,f,Bulifted*Test_matrix,b_constraints1',[],[],[],[],[],options);%quadprog(H,f,A,b,Aeq,beq,LB,UB,X0)
%  [X,FVAL,EXITFLAG] = linprog(f,[],[]);%quadprog(H,f,A,b,Aeq,beq,LB,UB,X0)
% disp(size(X))
end