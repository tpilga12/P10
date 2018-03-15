% BisectionRoot
function Xs = BisectionRoot(Fun,a,b,TolMax)

Fa = Fun(a);
Fb = Fun(b);

if Fa*Fb > 0
    Xs = ('Error');
else
    u = ceil((log10(b-a)-log10(TolMax))/log10(2));
    
    for i = 1:u
        Xs =abs( (a+b)/2);
        FXs=Fun(Xs);
        if FXs == 0
            break
        end

        if Fa*FXs <0
            b=abs(Xs);
        else
            a = Xs;
            Fa = FXs;
        end
    end
end