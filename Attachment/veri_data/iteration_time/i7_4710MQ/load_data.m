clc
clear all

ite = {'400' '800' '2000'};
dt = {'15' '20'};
meth = {'func' 'lut'};
cmp = 1;
perc = 1;
for m = 1:length(ite)
    for n = 1:length(dt)
        for g = 1:length(meth)
            data{cmp} = load(strcat(ite{m},'_it_dt_', dt{n},'_',meth{g},'.mat'));
            info{cmp,1} = strcat(ite{m},'_it_dt_', dt{n},'_',meth{g},'.mat');
            cmp = cmp + 1;
        end
    end
end
for n = 1:length(data)
    info{n,2} = data{n}.sim_time;
end

for n = 2:2:length(info)
    comp(perc) = info{n-1,2}/info{n,2}-1;    
     perc = perc + 1;
end
comp = comp'.*100;

figure(111231)
plot(data{1, 1}.input.Q_in)
grid on
xlim([0 200])
ylim([0 0.6])
ylabel('Flow [m^3/s]')
xlabel('Iterations')

