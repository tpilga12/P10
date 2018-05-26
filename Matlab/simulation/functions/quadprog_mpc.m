function [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,theta,Q,delta_xstates,A_constraints, b_constraints,Alifted,Bulifted,xstates_old,u_output_tank_old,Test_matrix,xstates,C_matrix_mpc,input,Dlifted,D_delta)




%  b_constraints1(:,1) = b_constraints(:,1)-(Alifted*(xstates')-Bulifted*u_output_tank_old);
 b_constraints1(:,1) = b_constraints(:,1)-Alifted*(xstates')-Bulifted*ones(360,1)*u_output_tank_old-Bulifted*D_delta;



H = gamma'*Q*gamma;





f = 2*(delta_xstates*psi'*Q*gamma)+2*Dlifted'*theta'*Q*gamma;
%+2*(u'*gamma'*Q*theta) - (2*(x1*psi' ...
    %*Q*theta))-(2*(u'*gamma'*Q*theta))-(2*(delta_u'*theta'*Q ...
   % *theta))



% options = optimoptions(@fmincon,'Algorithm','interior-point','Display','final');
options = optimoptions('quadprog','Display','final','Algorithm','interior-point-convex');


 
% [X,FVAL,EXITFLAG] = quadprog(H,f,[-Test_matrix; Test_matrix],[u_output_tank_old*ones(360,1)+input.u_init(1,1)-0.1 ; 1-input.u_init(1,1)-u_output_tank_old*ones(360,1)  ],[],[],[],[],[],options);
[X,FVAL,EXITFLAG] = quadprog(H,f,[-Test_matrix; Test_matrix; C_matrix_mpc*Bulifted*Test_matrix],[u_output_tank_old*ones(360,1)+input.u_init(1,1)-0.2 ; 1-input.u_init(1,1)-u_output_tank_old*ones(360,1); C_matrix_mpc*b_constraints1(:,1)  ],[],[],[],[],[],options);

 
 

end