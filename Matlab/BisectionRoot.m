% BisectionRoot
function Xs = BisectionRoot(Fun,a,b,err)

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
while err > 0.001
    Xi =abs( (a+b)/2);
    
    if fun(a)*fun(b) < 0
        b=abs(Xi);
    else
        a = Xi;
        Fa = FXs;
    end
end
Xs = Xi;
end
    
    
    

