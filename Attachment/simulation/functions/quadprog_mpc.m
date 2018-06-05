function [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,theta,Q,delta_xstates,Bulifted,SUM_matrix_mpc,C_matrix_mpc,D_delta,b_constraints1,C_matrix_mpc2, b_constraints2)





H = 2*gamma'*Q*gamma;
f = 2*(delta_xstates*psi'*Q*gamma)+2*D_delta'*theta'*Q*gamma;


options = optimoptions('quadprog','Display','final','Algorithm','interior-point-convex');


 

% [X,FVAL,EXITFLAG] = quadprog(H,f,[],[],[],[],[],[],[],options);
[X,FVAL,EXITFLAG] = quadprog(H,f,[SUM_matrix_mpc; -SUM_matrix_mpc;C_matrix_mpc*Bulifted;-C_matrix_mpc*Bulifted;C_matrix_mpc2*Bulifted;-C_matrix_mpc2*Bulifted],[ b_constraints2(:,1); b_constraints2(:,2)-0.1; b_constraints1(:,1);b_constraints1(:,2); b_constraints1(:,3);b_constraints1(:,4) ],[],[],[],[],[],options);



end