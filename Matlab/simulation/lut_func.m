function look_func = lut_func(input,look)
[~, indx] = min(abs(input-look.Q));
look_func = look.h(1,indx);

if input > look.limit
    fprintf('height limit in pipe crossed \n')
end

end
