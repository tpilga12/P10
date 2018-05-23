function [extract] = fetch_data(data_in,type)
%FETCH_DATA Summary of this function goes here
%   Detailed explanation goes here

lngth = 1;
for n = 1:length(data_in.data)
    if type == 'Q'
        extract(lngth:lngth+length(data_in.data{n}.Q)-1) = data_in.data{n}.Q;
    elseif type == 'h'
        extract(lngth:lngth+length(data_in.data{n}.h)-1) = data_in.data{n}.h;
    else
        fprintf('type need correct input ("h" for height and "Q" for flow)')
        break
    end
 lngth = lngth + length(data_in.data{n}.h);   
end
    

end

