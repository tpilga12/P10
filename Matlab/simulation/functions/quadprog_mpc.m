function [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,theta,Q,delta_xstates, b_constraints,Alifted,Bulifted,u_output_tank_old,SUM_matrix_mpc,xstates,C_matrix_mpc,input,Dlifted,D_delta,b_constraints1,C_matrix_mpc2, b_constraints2,omega,D_old)





% 
H = 2*gamma'*Q*gamma;
f = 2*(delta_xstates*psi'*Q*gamma)+2*D_delta'*theta'*Q*gamma;

% den der virker
% H = 2*omega'*Q*omega;
% f = 2*(xstates*psi'*Q*omega)+2*Dlifted'*theta'*Q*omega+2*[u_output_tank_old 0]*gamma'*Q*omega;

% H = 2*omega'*Q*omega;
% 
% f = 2*(xstates*psi'*Q*omega)+2*u_output_tank_old*ones(size(gamma,2),1)'*gamma'*Q*omega+2*D_old(1,1)*ones(size(gamma,2),1)'*gamma'*Q*omega+ ...
%     2*D_delta'*theta'*Q*omega;



options = optimoptions('quadprog','Display','final','Algorithm','interior-point-convex');


 

% [X,FVAL,EXITFLAG] = quadprog(H,f,[],[],[],[],[],[],[],options);

%  [X,FVAL,EXITFLAG] = quadprog(H,f,[SUM_matrix_mpc; -SUM_matrix_mpc;C_matrix_mpc*Bulifted*SUM_matrix_mpc;-C_matrix_mpc*Bulifted*SUM_matrix_mpc;C_matrix_mpc2*Bulifted*SUM_matrix_mpc;-C_matrix_mpc2*Bulifted*SUM_matrix_mpc],[ b_constraints2(:,1); b_constraints2(:,2)-0.1; b_constraints1(:,1);b_constraints1(:,2); b_constraints1(:,3);b_constraints1(:,4) ],[],[],[],[],[],options);
[X,FVAL,EXITFLAG] = quadprog(H,f,[SUM_matrix_mpc; -SUM_matrix_mpc;C_matrix_mpc*Bulifted*SUM_matrix_mpc;-C_matrix_mpc*Bulifted*SUM_matrix_mpc;C_matrix_mpc2*Bulifted*SUM_matrix_mpc;-C_matrix_mpc2*Bulifted*SUM_matrix_mpc],[ b_constraints2(:,1); b_constraints2(:,2)-0.1; b_constraints1(:,1);b_constraints1(:,2); b_constraints1(:,3);b_constraints1(:,4) ],[],[],[],[],[],options);



% [X,FVAL,EXITFLAG] = quadprog(H,f,[SUM_matrix_mpc; -SUM_matrix_mpc;C_matrix_mpc*Bulifted;-C_matrix_mpc*Bulifted;C_matrix_mpc2*Bulifted;-C_matrix_mpc2*Bulifted],[ b_constraints2(:,1); b_constraints2(:,2)-0.1; b_constraints1(:,1);b_constraints1(:,2); b_constraints1(:,3);b_constraints1(:,4) ],[],[],[],[],[],options);
% [X,FVAL,EXITFLAG] = quadprog(H,f,[SUM_matrix_mpc; -SUM_matrix_mpc;C_matrix_mpc*Bulifted;-C_matrix_mpc*Bulifted],[ b_constraints2(:,1); b_constraints2(:,2)-0.1; b_constraints1(:,1);b_constraints1(:,2) ],[],[],[],[],[],options);



end