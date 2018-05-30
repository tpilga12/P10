function [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,theta,Q,delta_xstates, b_constraints,Alifted,Bulifted,u_output_tank_old,SUM_matrix_mpc,xstates,C_matrix_mpc,input,Dlifted,D_delta,b_constraints1,C_matrix_mpc2, b_constraints2,omega)





% 
% H = 2*gamma'*Q*gamma;
% f = 2*(delta_xstates*psi'*Q*gamma)+2*D_delta'*theta'*Q*gamma;

H = 2*omega'*Q*omega;
f = 2*(xstates*psi'*Q*omega)+2*[Dlifted(1,1) 0]*theta'*Q*omega+2*[u_output_tank_old 0]*gamma'*Q*omega;




%  options = optimoptions(@fmincon,'Algorithm','interior-point','Display','final');
options = optimoptions('quadprog','Display','final','Algorithm','interior-point-convex');


 
% [X,FVAL,EXITFLAG] = quadprog(H,f,[-Test_matrix; Test_matrix],[u_output_tank_old*ones(360,1)+input.u_init(1,1)-0.1 ; 1-input.u_init(1,1)-u_output_tank_old*ones(360,1)  ],[],[],[],[],[],options);
% [X,FVAL,EXITFLAG] = quadprog(H,f,[-SUM_matrix_mpc; SUM_matrix_mpc; C_matrix_mpc*Bulifted*SUM_matrix_mpc],[u_output_tank_old*ones(size(Bulifted,2),1)+input.u_init(1,1)-0.2 ;0.9-input.u_init(1,1)-u_output_tank_old*ones(size(Bulifted,2),1); C_matrix_mpc*b_constraints1(:,1)  ],[],[],[],[],[],options);

%  [X,FVAL,EXITFLAG] = quadprog(H,f,[-SUM_matrix_mpc; SUM_matrix_mpc; C_matrix_mpc*Bulifted*SUM_matrix_mpc;-C_matrix_mpc*Bulifted*SUM_matrix_mpc],[u_output_tank_old*ones(size(Bulifted,2),1)+input.u_init(1,1)-0.3;1-input.u_init(1,1)-u_output_tank_old*ones(size(Bulifted,2),1); b_constraints1(:,1);b_constraints1(:,2)  ],[],[],[],[],[],options);
%    [X,FVAL,EXITFLAG] = quadprog(H,f,[C_matrix_mpc*Bulifted*SUM_matrix_mpc;-C_matrix_mpc*Bulifted*SUM_matrix_mpc],[C_matrix_mpc*b_constraints1(:,1);C_matrix_mpc*b_constraints1(:,2)],[],[],[0],[],[],options);
% [X,FVAL,EXITFLAG] = quadprog(H,f,[-SUM_matrix_mpc; SUM_matrix_mpc],[u_output_tank_old*ones(size(Bulifted,2),1)+input.u_init(1,1)-0.1;1-input.u_init(1,1)-u_output_tank_old*ones(size(Bulifted,2),1)],[],[],[],[],[],options);
% [X,FVAL,EXITFLAG] = quadprog(H,f,[],[],[],[],[],[],[],options);

%  [X,FVAL,EXITFLAG] = quadprog(H,f,[SUM_matrix_mpc; -SUM_matrix_mpc;C_matrix_mpc*Bulifted*SUM_matrix_mpc;-C_matrix_mpc*Bulifted*SUM_matrix_mpc;C_matrix_mpc2*Bulifted*SUM_matrix_mpc;-C_matrix_mpc2*Bulifted*SUM_matrix_mpc],[ b_constraints2(:,1); b_constraints2(:,2)-0.1; b_constraints1(:,1);b_constraints1(:,2); b_constraints1(:,3);b_constraints1(:,4) ],[],[],[],[],[],options);
% [X,FVAL,EXITFLAG] = quadprog(H,f,[SUM_matrix_mpc; -SUM_matrix_mpc;C_matrix_mpc*Bulifted*SUM_matrix_mpc;-C_matrix_mpc*Bulifted*SUM_matrix_mpc;C_matrix_mpc2*Bulifted*SUM_matrix_mpc;-C_matrix_mpc2*Bulifted*SUM_matrix_mpc],[ b_constraints2(:,1); b_constraints2(:,2)-0.1; b_constraints1(:,1);b_constraints1(:,2); b_constraints1(:,3);b_constraints1(:,4) ],[],[],[],[],[],options);
% 


[X,FVAL,EXITFLAG] = quadprog(H,f,[SUM_matrix_mpc; -SUM_matrix_mpc;C_matrix_mpc*Bulifted;-C_matrix_mpc*Bulifted;C_matrix_mpc2*Bulifted;-C_matrix_mpc2*Bulifted],[ b_constraints2(:,1); b_constraints2(:,2)-0.1; b_constraints1(:,1);b_constraints1(:,2); b_constraints1(:,3);b_constraints1(:,4) ],[],[],[],[],[],options);

end