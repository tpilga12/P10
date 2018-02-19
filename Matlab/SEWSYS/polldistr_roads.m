%This file gives the relative contribution of sources for pollution from
%roads
trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

%disp('-------------------------')
%disp('Road pollution')
%disp('Dry dep')
for i=11:14
    if i==11
        %disp('Cu')
    else
        if i==12
            %disp('Zn')
        else
            if i==13
                %disp('Pb')
            else %disp('Cd')
            end
        end
    end
    a=[poll_DrydepRoad(1,i)
        poll_BrakeRoad(1,i)
        poll_RoadwearRoad(1,i)
        poll_TyrewearRoad(1,i)
        poll_ExhaustRoad(1,i)
        poll_OilRoad(1,i)
        poll_ZncorrRoad(1,i)];
    if i==11
        Cu=a;
    else
        if i==12
            Zn=a;
        else 
            if i==13
                Pb=a;
            else Cd=a;
            end
        end
    end
end

for i=1:2
    if i==1
        %disp('P')
    else
        %disp('N')
    end
    a=[poll_DrydepRoad(1,i)
        poll_BrakeRoad(1,i)
        poll_RoadwearRoad(1,i)
        poll_TyrewearRoad(1,i)
        poll_ExhaustRoad(1,i)
        poll_OilRoad(1,i)
        poll_ZncorrRoad(1,i)];
    if i==1
        P=a;
    else N=a;
    end
end

%disp('PAH')
PAH=[poll_DrydepRoad(1,20)
   poll_BrakeRoad(1,20)
   poll_RoadwearRoad(1,20)
   poll_TyrewearRoad(1,20)
   poll_ExhaustRoad(1,20)
   poll_OilRoad(1,20)
   poll_ZncorrRoad(1,20)];

%disp('BOD')
BOD=[poll_DrydepRoad(1,7)
   poll_BrakeRoad(1,7)
   poll_RoadwearRoad(1,7)
   poll_TyrewearRoad(1,7)
   poll_ExhaustRoad(1,7)
   poll_OilRoad(1,7)
   poll_ZncorrRoad(1,7)];

figure
set(gcf,'position',w_size)
%Cu
idx=find(~Cu); %new code to fix non-positive problem in MATLAB ver 7
Cu(idx)=eps; %new code to fix non-positive problem in MATLAB ver 7
explode = zeros(size(Cu));
[c,offset] = max(Cu);
explode(offset) = 1;
subplot(2,2,1), pie1=pie(Cu,explode); colormap summer %resulterar i Warning: Ignoring non-positive data in pie chart.
title('Cu', 'fontsize', 14)
textObjs = findobj(pie1,'Type','text');
oldStr = get(textObjs,{'String'});
val = get(textObjs,{'Extent'});
oldExt = cat(1,val{:});
Names = {'Dry Dep: ';'Brake Wear: ';'Road Wear: ';'Tyre Wear: ';'Exhausts: ';'Oil Spillage: ';'Zn Corr: '};
newStr = strcat(Names,oldStr); %fel här!!!
set(textObjs,{'String'},newStr)
val1 = get(textObjs, {'Extent'});
newExt = cat(1, val1{:});
offset = sign(oldExt(:,1)).*(newExt(:,3)-oldExt(:,3))/2;
pos = get(textObjs, {'Position'});
textPos =  cat(1, pos{:});
textPos(:,1) = textPos(:,1)+offset;
set(textObjs,{'Position'},num2cell(textPos,[3,2]))

%Zn
idx=find(~Zn); %new code to fix non-positive problem in MATLAB ver 7
Zn(idx)=eps; %new code to fix non-positive problem in MATLAB ver 7
explode = zeros(size(Zn));
[c,offset] = max(Zn);
explode(offset) = 1;
subplot(2,2,2), pie2=pie(Zn,explode); colormap summer
title('Zn', 'fontsize', 14)
textObjs = findobj(pie2,'Type','text');
oldStr = get(textObjs,{'String'});
val = get(textObjs,{'Extent'});
oldExt = cat(1,val{:});
Names = {'Dry Dep: ';'Brake Wear: ';'Road Wear: ';'Tyre Wear: ';'Exhausts: ';'Oil Spillage: ';'Zn Corr: '};
newStr = strcat(Names,oldStr);
set(textObjs,{'String'},newStr)
val1 = get(textObjs, {'Extent'});
newExt = cat(1, val1{:});
offset = sign(oldExt(:,1)).*(newExt(:,3)-oldExt(:,3))/2;
pos = get(textObjs, {'Position'});
textPos =  cat(1, pos{:});
textPos(:,1) = textPos(:,1)+offset;
set(textObjs,{'Position'},num2cell(textPos,[3,2]))

%Pb
idx=find(~Pb); %new code to fix non-positive problem in MATLAB ver 7
Pb(idx)=eps; %new code to fix non-positive problem in MATLAB ver 7
explode = zeros(size(Pb));
[c,offset] = max(Pb);
explode(offset) = 1;
subplot(2,2,3), pie3=pie(Pb, explode); colormap summer
title('Pb', 'fontsize', 14)
textObjs = findobj(pie3,'Type','text');
oldStr = get(textObjs,{'String'});
val = get(textObjs,{'Extent'});
oldExt = cat(1,val{:});
Names = {'Dry Dep: ';'Brake Wear: ';'Road Wear: ';'Tyre Wear: ';'Exhausts: ';'Oil Spillage: ';'Zn Corr: '};
newStr = strcat(Names,oldStr);
set(textObjs,{'String'},newStr)
val1 = get(textObjs, {'Extent'});
newExt = cat(1, val1{:});
offset = sign(oldExt(:,1)).*(newExt(:,3)-oldExt(:,3))/2;
pos = get(textObjs, {'Position'});
textPos =  cat(1, pos{:});
textPos(:,1) = textPos(:,1)+offset;
set(textObjs,{'Position'},num2cell(textPos,[3,2]))

%Cd
idx=find(~Cd); %new code to fix non-positive problem in MATLAB ver 7
Cd(idx)=eps; %new code to fix non-positive problem in MATLAB ver 7
explode = zeros(size(Cd));
[c,offset] = max(Cd);
explode(offset) = 1;
subplot(2,2,4), pie4=pie(Cd, explode); colormap summer
title('Cd', 'fontsize', 14)
textObjs = findobj(pie4,'Type','text');
oldStr = get(textObjs,{'String'});
val = get(textObjs,{'Extent'});
oldExt = cat(1,val{:});
Names = {'Dry Dep: ';'Brake Wear: ';'Road Wear: ';'Tyre Wear: ';'Exhausts: ';'Oil Spillage: ';'Zn Corr: '};
newStr = strcat(Names,oldStr);
set(textObjs,{'String'},newStr)
val1 = get(textObjs, {'Extent'});
newExt = cat(1, val1{:});
offset = sign(oldExt(:,1)).*(newExt(:,3)-oldExt(:,3))/2;
pos = get(textObjs, {'Position'});
textPos =  cat(1, pos{:});
textPos(:,1) = textPos(:,1)+offset;
set(textObjs,{'Position'},num2cell(textPos,[3,2]))

set(gcf,'numbertitle','off')
set(gcf,'name','Sources for Road Pollution 1')

figure
set(gcf,'position',w_size)
%P
idx=find(~P); %new code to fix non-positive problem in MATLAB ver 7
P(idx)=eps; %new code to fix non-positive problem in MATLAB ver 7
explode = zeros(size(P));
[c,offset] = max(P);
explode(offset) = 1;
subplot(2,2,1), pie5=pie(P,explode); colormap summer
title('P', 'fontsize', 14)
textObjs = findobj(pie5,'Type','text');
oldStr = get(textObjs,{'String'});
val = get(textObjs,{'Extent'});
oldExt = cat(1,val{:});
Names = {'Dry Dep: ';'Brake Wear: ';'Road Wear: ';'Tyre Wear: ';'Exhausts: ';'Oil Spillage: ';'Zn Corr: '};
newStr = strcat(Names,oldStr);
set(textObjs,{'String'},newStr)
val1 = get(textObjs, {'Extent'});
newExt = cat(1, val1{:});
offset = sign(oldExt(:,1)).*(newExt(:,3)-oldExt(:,3))/2;
pos = get(textObjs, {'Position'});
textPos =  cat(1, pos{:});
textPos(:,1) = textPos(:,1)+offset;
set(textObjs,{'Position'},num2cell(textPos,[3,2]))

%N
idx=find(~N); %new code to fix non-positive problem in MATLAB ver 7
N(idx)=eps; %new code to fix non-positive problem in MATLAB ver 7
explode = zeros(size(N));
[c,offset] = max(N);
explode(offset) = 1;
subplot(2,2,2), pie6=pie(N,explode); colormap summer
title('N', 'fontsize', 14)
textObjs = findobj(pie6,'Type','text');
oldStr = get(textObjs,{'String'});
val = get(textObjs,{'Extent'});
oldExt = cat(1,val{:});
Names = {'Dry Dep: ';'Brake Wear: ';'Road Wear: ';'Tyre Wear: ';'Exhausts: ';'Oil Spillage: ';'Zn Corr: '};
newStr = strcat(Names,oldStr);
set(textObjs,{'String'},newStr)
val1 = get(textObjs, {'Extent'});
newExt = cat(1, val1{:});
offset = sign(oldExt(:,1)).*(newExt(:,3)-oldExt(:,3))/2;
pos = get(textObjs, {'Position'});
textPos =  cat(1, pos{:});
textPos(:,1) = textPos(:,1)+offset;
set(textObjs,{'Position'},num2cell(textPos,[3,2]))

%PAH
idx=find(~PAH); %new code to fix non-positive problem in MATLAB ver 7
PAH(idx)=eps; %new code to fix non-positive problem in MATLAB ver 7
explode = zeros(size(PAH));
[c,offset] = max(PAH);
explode(offset) = 1;
subplot(2,2,3), pie7=pie(PAH,explode); colormap summer
title('PAH', 'fontsize', 14)
textObjs = findobj(pie7,'Type','text');
oldStr = get(textObjs,{'String'});
val = get(textObjs,{'Extent'});
oldExt = cat(1,val{:});
Names = {'Dry Dep: ';'Brake Wear: ';'Road Wear: ';'Tyre Wear: ';'Exhausts: ';'Oil Spillage: ';'Zn Corr: '};
newStr = strcat(Names,oldStr);
set(textObjs,{'String'},newStr)
val1 = get(textObjs, {'Extent'});
newExt = cat(1, val1{:});
offset = sign(oldExt(:,1)).*(newExt(:,3)-oldExt(:,3))/2;
pos = get(textObjs, {'Position'});
textPos =  cat(1, pos{:});
textPos(:,1) = textPos(:,1)+offset;
set(textObjs,{'Position'},num2cell(textPos,[3,2]))

%BOD
idx=find(~BOD); %new code to fix non-positive problem in MATLAB ver 7
BOD(idx)=eps; %new code to fix non-positive problem in MATLAB ver 7
explode = zeros(size(BOD));
[c,offset] = max(BOD);
explode(offset) = 1;
subplot(2,2,4), pie8=pie(BOD,explode); colormap summer
title('BOD', 'fontsize', 14)
textObjs = findobj(pie8,'Type','text');
oldStr = get(textObjs,{'String'});
val = get(textObjs,{'Extent'});
oldExt = cat(1,val{:});
Names = {'Dry Dep: ';'Brake Wear: ';'Road Wear: ';'Tyre Wear: ';'Exhausts: ';'Oil Spillage: ';'Zn Corr: '};
newStr = strcat(Names,oldStr);
set(textObjs,{'String'},newStr)
val1 = get(textObjs, {'Extent'});
newExt = cat(1, val1{:});
offset = sign(oldExt(:,1)).*(newExt(:,3)-oldExt(:,3))/2;
pos = get(textObjs, {'Position'});
textPos =  cat(1, pos{:});
textPos(:,1) = textPos(:,1)+offset;
set(textObjs,{'Position'},num2cell(textPos,[3,2]))


set(gcf,'numbertitle','off')
set(gcf,'name','Sources for Road Pollution 2')

swroaddistr=[Cu Zn Pb Cd P N PAH BOD];
open swroaddistr