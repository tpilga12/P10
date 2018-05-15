% BisectionRoot
function Xs = BisectionRoot(Fun,a,b,tol)

% Fa = Fun(a);
% Fb = Fun(b);
% % 
% % if Fa*Fb > 0
% %     Xs = ('Error')
% % else
%     u = ceil((log10(b-a)-log10(TolMax))/log10(2));
%     
%     for i = 1:u
%         Xs =abs( (a+b)/2);
%         FXs=Fun(Xs);
%         if FXs == 0
%             break
%         end
% 
%         if Fa*FXs <0
%             b=abs(Xs);
%         else
%             a = Xs;
%             Fa = FXs;
%         end
%     end
% end

Fa = Fun(a);
Fb = Fun(b);
n = 1;
while n < 5000
c = (a+b)/2;
if Fun(c) == 0 || (b-a)< tol
    Xs = c;
elseif sign(Fun(c)) == sign(Fun(a))
    a = c;
else
    b = c;
end
n =n + 1;
end
fprintf('this crap take to long /n')

% it = 1;
% while abs(Fa-Fb)>tol
%     Xi =abs((Fa+Fb)/2);
%     if Fun(a)*Fun(b) < 0
%         Fb = abs(Xi);
%     else
%         Fa = abs(Xi);
%     end
%     it = it + 1;
%     if it == 200
%         fprintf('this crap take to long')
%         break
%     end
% end
% 
%         Xs = Xi;

end




