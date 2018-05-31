    
d = 1.2;
h = 1.1;
R=hy_perimeter(h,d)
ie = 0.003;
n = 0.013;
v = 1/n * R^(2/3) * ie^(1/2);



function f = Area_fun(h)
    f = d^2/4 * acos(((d/2)-h)/(d/2))-sqrt(h*(d-h))*((d/2)-h);
end


function f=hy_perimeter(h,d)
    f = acos(1-(h/(d/2)))*d;
end
