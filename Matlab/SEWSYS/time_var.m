%File time_var.m 
%Daily Sewage variataion values, loaded from file prep.m
%Stefan Ahlman
%2000-02-23

if sani==1 % U is used to load time-series [T,U]
   U=[% VA-kompendie
      0.45 %1.0 för att jämföra statisk modell
      0.4
      0.43
      0.55
      0.7
      0.9
      1.15
      1.3
      1.4
      1.5
      1.55
      1.59
      1.55
      1.5
      1.4
      1.3
      1.2
      1.05
      0.93
      0.8
      0.7
      0.6
      0.55
      0.5
   ];
   
   U_alt=[% VAV P38
      0.65
      0.43
      0.32
      0.29
      0.29
      0.32
      0.58
      1.77
      1.83
      1.6
      1.1
      0.93
      0.87
      0.84
      0.81
      0.82
      0.91
      1.1
      1.31
      1.5
      1.56
      1.58
      1.48
      1.12
   ];
   
   U=[U(1)*randh(sph) %randh-function gives random variation for one hour
      U(2)*randh(sph)  %sph is the samples per hour (from prep.m)
      U(3)*randh(sph)
      U(4)*randh(sph)
      U(5)*randh(sph)
      U(6)*randh(sph)
      U(7)*randh(sph)
      U(8)*randh(sph)
      U(9)*randh(sph)
      U(10)*randh(sph)
      U(11)*randh(sph)
      U(12)*randh(sph)
      U(13)*randh(sph)
      U(14)*randh(sph)
      U(15)*randh(sph)
      U(16)*randh(sph)
      U(17)*randh(sph)
      U(18)*randh(sph)
      U(19)*randh(sph)
      U(20)*randh(sph)
      U(21)*randh(sph)
      U(22)*randh(sph)
      U(23)*randh(sph)
      U(24)*randh(sph)
   ];
   
   if in_days==1
      U1=U;
   else 
      U1=U;
      for I = 1:in_days-1,
         U1=[U1;U];
      end
   end
else
   U1=zeros(size(T));
end
