function axis = fetch_axis(sys_setup,pipe_spec,tank_spec)
section = 1;
comp_nr = 1;
add_prev = 0;
for n = 1:length(sys_setup)-1
    for m = 1:sys_setup(n).component
        if sys_setup(n).type == 'Tank'
%             axis(section:(section+pipe_spec(comp_nr).sections)) = add_prev;
%             section = section + 1;
        else
        axis(section:(section+pipe_spec(comp_nr).sections)) = ((1:pipe_spec(comp_nr).sections+1)*pipe_spec(comp_nr).Dx) - pipe_spec(comp_nr).Dx + add_prev;
        section = section + pipe_spec(comp_nr).sections+1;
        comp_nr = comp_nr + 1;
        add_prev = axis(1,end)
        end
    end
end

end