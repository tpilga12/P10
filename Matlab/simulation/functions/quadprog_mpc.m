function [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,theta,Q,delta_xstates, b_constraints,Alifted,Bulifted,u_output_tank_old,SUM_matrix_mpc,xstates,C_matrix_mpc,input,Dlifted,D_delta)




%  b_constraints1(:,1) = b_constraints(:,1)-(Alifted*(xstates')-Bulifted*u_output_tank_old);
 b_constraints1(:,1) = b_constraints(:,1)-Alifted*(xstates')-Bulifted*ones(size(Bulifted,2),1)*u_output_tank_old-Bulifted*D_delta;
 b_constraints1(:,2) = -b_constraints(:,2)+Alifted*(xstates')+Bulifted*ones(size(Bulifted,2),1)*u_output_tank_old+Bulifted*D_delta;


H = 2*gamma'*Q*gamma;





f = 2*(delta_xstates*psi'*Q*gamma)+2*Dlifted'*theta'*Q*gamma;
%+2*(u'*gamma'*Q*theta) - (2*(x1*psi' ...
    %*Q*theta))-(2*(u'*gamma'*Q*theta))-(2*(delta_u'*theta'*Q ...
   % *theta))



% options = optimoptions(@fmincon,'Algorithm','interior-point','Display','final');
options = optimoptions('quadprog','Display','final','Algorithm','interior-point-convex');


 
% [X,FVAL,EXITFLAG] = quadprog(H,f,[-Test_matrix; Test_matrix],[u_output_tank_old*ones(360,1)+input.u_init(1,1)-0.1 ; 1-input.u_init(1,1)-u_output_tank_old*ones(360,1)  ],[],[],[],[],[],options);
% [X,FVAL,EXITFLAG] = quadprog(H,f,[-SUM_matrix_mpc; SUM_matrix_mpc; C_matrix_mpc*Bulifted*SUM_matrix_mpc],[u_output_tank_old*ones(size(Bulifted,2),1)+input.u_init(1,1)-0.2 ;0.9-input.u_init(1,1)-u_output_tank_old*ones(size(Bulifted,2),1); C_matrix_mpc*b_constraints1(:,1)  ],[],[],[],[],[],options);
 [X,FVAL,EXITFLAG] = quadprog(H,f,[-SUM_matrix_mpc; SUM_matrix_mpc; C_matrix_mpc*Bulifted*SUM_matrix_mpc;-C_matrix_mpc*Bulifted*SUM_matrix_mpc],[u_output_tank_old*ones(size(Bulifted,2),1)+input.u_init(1,1)-0.2 ;0.9-input.u_init(1,1)-u_output_tank_old*ones(size(Bulifted,2),1); C_matrix_mpc*b_constraints1(:,1);C_matrix_mpc*b_constraints1(:,2)  ],[],[],[],[],[],options);
 

end