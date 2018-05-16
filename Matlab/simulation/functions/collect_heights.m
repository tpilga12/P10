

for m = 1:length(data)
    if m == 1
        xstates = [data{1,1}.h(1,:)]
    else
        xstates = [xstates data{1,m}.h(1,:)]
    end
end