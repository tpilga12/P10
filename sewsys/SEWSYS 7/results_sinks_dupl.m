
trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

%Cu, Zn, Pb, Cd
for i=12:15
    out1=[sum(storm(:,i))]*trans;
        out2=[sum(out_WWTP_Recipient(:,i))]*trans;
        out3=[sum(outRecipient(:,i))]*trans;
        out4=[sum(outLandfill(:,i))]*trans;
        out5=[sum(outSludge(:,i))]*trans;
        out6=[sum(outAir(:,i))]*trans;
        out7=[sum(inSewageplant(:,i))]*trans;
        out_bar=[out1, out2, out3, out4, out5, out6, out7]';
    if i==12
        Cu=out_bar;
    else
        if i==13
            Zn=out_bar;
        else 
            if i==14
                Pb=out_bar;
            else Cd=out_bar;
            end
        end
    end
end

%P och N
for i=2:3
    out1=[sum(storm(:,i))]*trans;
        out2=[sum(out_WWTP_Recipient(:,i))]*trans;
        out3=[sum(outRecipient(:,i))]*trans;
        out4=[sum(outLandfill(:,i))]*trans;
        out5=[sum(outSludge(:,i))]*trans;
        out6=[sum(outAir(:,i))]*trans;
        out7=[sum(inSewageplant(:,i))]*trans;
        out_bar=[out1, out2, out3, out4, out5, out6, out7]';
    if i==2
        P=out_bar;
    else N=out_bar;
    end
end

%PAH
out1=[sum(storm(:,21))]*trans;
        out2=[sum(out_WWTP_Recipient(:,21))]*trans;
        out3=[sum(outRecipient(:,21))]*trans;
        out4=[sum(outLandfill(:,21))]*trans;
        out5=[sum(outSludge(:,21))]*trans;
        out6=[sum(outAir(:,21))]*trans;
        out7=[sum(inSewageplant(:,21))]*trans;
        PAH=[out1, out2, out3, out4, out5, out6, out7]';

%BOD
out1=[sum(storm(:,8))]*trans;
        out2=[sum(out_WWTP_Recipient(:,8))]*trans;
        out3=[sum(outRecipient(:,8))]*trans;
        out4=[sum(outLandfill(:,8))]*trans;
        out5=[sum(outSludge(:,8))]*trans;
        out6=[sum(outAir(:,8))]*trans;
        out7=[sum(inSewageplant(:,8))]*trans;
        BOD=[out1, out2, out3, out4, out5, out6, out7]';

%Water
out1=[sum(storm(:,1))]*trans*1000;
        out2=[sum(out_WWTP_Recipient(:,1))]*trans*1000;
        out3=[sum(outRecipient(:,1))]*trans*1000;
        out4=[sum(outLandfill(:,1))]*trans*1000;
        out5=[sum(outSludge(:,1))]*trans*1000;
        out6=[sum(outAir(:,1))]*trans*1000;
        out7=[sum(inSewageplant(:,1))]*trans*1000;
        Water=[out1, out2, out3, out4, out5, out6, out7]';


results_vasa_dupl_sinks=[Cu Zn Pb Cd P N PAH BOD Water];
open results_vasa_dupl_sinks
