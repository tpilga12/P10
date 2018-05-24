function [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,Q,delta_xstates,A_constraints, b_constraints,Alifted,Bulifted,xstates_old,u_output_tank_old,Test_matrix,xstates,C_matrix_mpc)

% b_constraints1(:,1) = b_constraints(:,2)-(Alifted*(delta_xstates'-xstates_old')-Bulifted*ones(120,1)*u_output_tank_old);
% b_constraints1(:,1) = b_constraints(:,1)-(Alifted*(xstates')-Bulifted*ones(1200,1)*u_output_tank_old);
% b_constraints1(:,2) = -b_constraints(:,2)+(Alifted*(xstates')+Bulifted*ones(1200,1)*u_output_tank_old);
% b_constraints2 = b_constraints(2,:)-Alifted*delta_xstates';


 b_constraints1(:,1) = b_constraints(:,1)-(Alifted*(xstates')-Bulifted*u_output_tank_old);


% dummy_matrix= zeros(26500,1200);
% dummy_matrix(37,37)= 1;

H = gamma'*Q*gamma;





f = 2*(delta_xstates*psi'*Q*gamma);%2*delta_Ud'Q*gamma
%+2*(u'*gamma'*Q*theta) - (2*(x1*psi' ...
    %*Q*theta))-(2*(u'*gamma'*Q*theta))-(2*(delta_u'*theta'*Q ...
   % *theta))



% options = optimoptions(@fmincon,'Algorithm','interior-point','Display','final');
options = optimoptions('quadprog','Display','final','Algorithm','interior-point-convex');

%  [X,FVAL,EXITFLAG] = quadprog(H,f,[],[],[],[],[],[],[],options);
%  [X,FVAL,EXITFLAG] = quadprog(H,f,[-Test_matrix; Test_matrix],[u_output_tank_old+0.1542 1-0.1542-u_output_tank_old],[],[],[],[],[],options);
%  [X,FVAL,EXITFLAG] = quadprog(H,f,[Bulifted*Test_matrix],[ b_constraints1(:,1)],[],[],[],[],[],options);
 [X,FVAL,EXITFLAG] = quadprog(H,f,[-Test_matrix; Test_matrix; C_matrix_mpc*Bulifted*Test_matrix],[u_output_tank_old+0.1542 ; 1-0.1542-u_output_tank_old; C_matrix_mpc*b_constraints1(:,1)  ],[],[],[],[],[],options);
%  [X,FVAL,EXITFLAG] = quadprog(H,f,[Bulifted*Test_matrix; -Bulifted*Test_matrix],[b_constraints1(:,1)' ; b_constraints1(:,2)'],[],[],[],[],[],options);%quadprog(H,f,A,b,Aeq,beq,LB,UB,X0)
%  [X,FVAL,EXITFLAG] = linprog(f,[],[]);%quadprog(H,f,A,b,Aeq,beq,LB,UB,X0)
% disp(size(X))
end