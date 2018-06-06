function [extract] = fetch_data(data_in,type,row)
%FETCH_DATA Summary of this function goes here
%   Detailed explanation goes here

lngth = 1;
for n = 1:length(data_in.data)
    if type == 'Q'
        extract = data_in.data{n}.Q(row,:);
    elseif type == 'h'
        extract = data_in.data{n}.h(row,:);
    else
        fprintf('type need correct input ("h" for height and "Q" for flow)')
        break
    end
 lngth = lngth + length(data_in.data{n}.h);   
end
    

end

