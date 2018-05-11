%% MPC controller
%clc,clear all


Hp = 10; % Prediction horizon
Hu = 9;  % Control horizon
XHp = int8(2:Hp);
XHu = int8(2:Hu);
for n = 1:Hp %%% Lifted A matrix
    if n == 1
        Alifted = [lin_sys.A^n];
    else
        Alifted(end+1:end+length(lin_sys.A),:) = [lin_sys.A^n];
    end 
end

for n = 1:Hp %%% Lifted B matrix
    
    if n == 1
        Blifted = [lin_sys.B];
    else      
            Blifted(end+1:end+length(lin_sys.B),:) = [lin_sys.A^n*lin_sys.B];
    end
end


H = theta'*Q*theta;
f = x(k)'*psi'Q*theta

