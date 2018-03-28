
trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

for i=1:21
    if i==1
        i
        out1=[sum(outSoil(:,i))]*trans*1000;
        out2=[sum(non_settled(:,i))]*trans*1000;
        out3=[sum(out_WWTP_Recipient(:,i))]*trans*1000;
        out4=[sum(outRecipient(:,i))]*trans*1000;
        out5=[sum(settled(:,i))]*trans*1000;
        out6=[sum(outLandfill_WWTP(:,i))]*trans*1000;
        out7=[sum(outSludge(:,i))]*trans*1000;
        out8=[sum(outAir(:,i))]*trans*1000;
        out9=[sum(inSewageplant(:,i))]*trans*1000;
        out_bar=[out1, out2, out3, out4, out5, out6, out7, out8, out9]'
    else
        i
        out1=[sum(outSoil(:,i))]*trans;
        out2=[sum(non_settled(:,i))]*trans;
        out3=[sum(out_WWTP_Recipient(:,i))]*trans;
        out4=[sum(outRecipient(:,i))]*trans;
        out5=[sum(settled(:,i))]*trans;
        out6=[sum(outLandfill_WWTP(:,i))]*trans;
        out7=[sum(outSludge(:,i))]*trans;
        out8=[sum(outAir(:,i))]*trans;
        out9=[sum(inSewageplant(:,i))]*trans;
        out_bar=[out1, out2, out3, out4, out5, out6, out7, out8, out9]'
    end
end
