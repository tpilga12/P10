function [extract] = fetch_data(data1,type)
%FETCH_DATA Summary of this function goes here
%   Detailed explanation goes here


data1 = load('init_fredericia_boundary.mat');
lngth = 1;
for n = 1:length(data1.data)
    if type == 'Q'
        extract(lngth:lngth+length(data1.data{n}.Q)-1) = data1.data{n}.Q;
    elseif type == 'h'
        extract(lngth:lngth+length(data1.data{n}.h)-1) = data1.data{n}.h;
    else
        fprintf('type need correct input ("h" for height and "Q" for flow)')
        break
    end
 lngth = lngth + length(data1.data{n}.h);   
end
    

end

