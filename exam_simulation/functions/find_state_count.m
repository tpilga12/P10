function [state_spec] = find_state_count(pipe_spec,sys_setup)

m = 1; % pipe counter
v = 0; % part counter
pipe_number = 1; % Global pipe counter
state.sections = 0;
prev_comp = 0;
for g = 1:length(sys_setup)
    if strcmp(sys_setup(g),('Tank')) || strcmp(sys_setup(g),('tank'))
        v = v +1;
        state.type = 'Tank';
        state.component = 1;
        state.sections = 1;
        state_spec(v) = orderfields(state,{'type','component','sections'});
        state.sections = 0; %clear for next part
        prev_comp = 0;
        m = 1;
    else
        if prev_comp == 0
            v = v +1;
        end
        prev_comp = 1;
        state.type = 'Pipe';
        state.component = m;
        state.sections = pipe_spec(pipe_number).sections+state.sections;
        state_spec(v) = orderfields(state,{'type','component','sections'});
        pipe_number = pipe_number + 1;
        m = m + 1; % increment component count


    end
        
end
    state.type = 'Total';
    state.component = sum([state_spec.component]);
    state.sections = sum([state_spec.sections]);
    state_spec(v+1) = orderfields(state,{'type','component','sections'});
   
end