%Stefan Ahlman
%2004-10-04
%loads the simulation results from Simulink into MATLAB Workspace (MAT-files are
%stored in sub-directory \results
%write loadresults at MATLAB prompt

load results\storm
load results\storm1
load results\s_wetdep
load results\s_road
load results\s_roof
load results\s_other
load results\sewer
load results\storm2
load results\storm_exceed
load results\settled
load results\non_settled
load results\inSewageplant
%load results\outCSO
load results\outRecipient
load results\out_WWTP_Recipient
load results\outLandfill
load results\outSludge
load results\outAir

global storm %s_wetdep
storm=storm(2:22,:)';
storm1=storm1(2:22,:)';
s_wetdep=s_wetdep(2:22,:)';
s_road=s_road(2:21,:)';
s_roof=s_roof(2:21,:)';
s_other=s_other(2:21,:)';
sewer=sewer(2:22,:)';
storm2=storm2(2:22,:)';
storm_exceed=storm_exceed(2:22,:)';
settled=settled(2:22,:)';
non_settled=non_settled(2:22,:)';
inSewageplant=inSewageplant(2:22,:)';
%outCSO=outCSO(2:22,:)';
outRecipient=outRecipient(2:22,:)';
out_WWTP_Recipient=out_WWTP_Recipient(2:22,:)';
outLandfill=outLandfill(2:22,:)';
outSludge=outSludge(2:22,:)';
outAir=outAir(2:22,:)';