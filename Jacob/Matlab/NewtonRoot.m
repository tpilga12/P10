function Xs = NewtonRoot(Fun,FunDer,Xest,Err,imax)
% NewtonRoot finds the root of fun = 0 near the point Xest using newton's
% method.  Xs = NewtonRoot(Fun,FunDer,Xest,Err,imax)
% Input variables
% Fun       Name (string) of a function file that calculates Fin for a given x.
% FunDur    Name (string of a function that calculates the derivative of
% Fun for a given x
% Xest      Initial estimate of the solution
% Err       Maximum Error
% imax      Maximum number of iterations
% Output    Variable
% Xs        Solution
for i = 1:imax
    Xi = Xest - feval(Fun,Xest)/feval(FunDer,Xest);
    if abs((Xi-Xest)/Xest) < Err
        Xs = Xi;
        break
    end
    Xest = Xi;
end 
if i == imax
    fprintf('solution was not observed in %i iterations .\n',imax)
    Xs = ('no answer');
end