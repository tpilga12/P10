

Hp = 10;
p = 0;

A = lin_sys.A;
B = lin_sys.B;
% A = [2 0;0 1];
% B = [1; 0];
bl = zeros(length(B)*Hp,Hp)
len = length(B);
nr_inputs = length(B(1,:));
for n = 1:Hp
    for m = 1:Hp
        if m-n < 0
            insert = zeros(len,12);
        else
            insert = A^(m-n)*B;
         bl((len*m-len+1):(len*m),(n*nr_inputs-nr_inputs+1):(n*nr_inputs)) = insert;
        end
    end
    p = p +1;
end
        