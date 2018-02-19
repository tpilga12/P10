for i=2:21
   i
   sum(storm(:,i))*sec_per_ts %after runoff-module, before overflow
   sum(storm2(:,i))*sec_per_ts %to dam
   sum(non_settled(:,i))*sec_per_ts % from dam
   sum(storm_exceed(:,i))*sec_per_ts %bypass
end