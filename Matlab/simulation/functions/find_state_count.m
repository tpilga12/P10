function [state_spec] = find_state_count(pipe_spec,sys_setup)

m = 1; 
v = 0;
pipe_number = 1;
state.sections = 0;
for g = 1:length(sys_setup)
    if strcmp(sys_setup(g),('Tank')) || strcmp(sys_setup(g),('tank'))
        v = v+1;
        state.type = 'Tank';
        state.component = 1;
        state.sections = 1;
        state_spec(v) = state;
        v = v+1;
        state.sections = 0;
        m = 1;
    else
        if v == 0
            v = 1;
        end
        state.type = 'Pipe';
        state.component = m;
        state.sections = pipe_spec(pipe_number).sections+state.sections;
        state_spec(v) = state;
        pipe_number = pipe_number + 1;
        m = m + 1;
    end
        
end
    state.type = 'Total';
    state.component = sum([state_spec.component]);
    state.sections = sum([state_spec.sections]);
    state_spec(v+1) = state;
   
end