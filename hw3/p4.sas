data p4;
input y x1 x2;
datalines;
   64.0    4.0    2.0
   73.0    4.0    4.0
   61.0    4.0    2.0
   76.0    4.0    4.0
   72.0    6.0    2.0
   80.0    6.0    4.0
   71.0    6.0    2.0
   83.0    6.0    4.0
   83.0    8.0    2.0
   89.0    8.0    4.0
   86.0    8.0    2.0
   93.0    8.0    4.0
   88.0   10.0    2.0
   95.0   10.0    4.0
   94.0   10.0    2.0
  100.0   10.0    4.0
;
run;

ods rtf file='p4.rtf';
proc sgscatter data=p4;
matrix y x1 x2;
run;

proc reg data=p4 corr;
model  y=x1 x2/r p influence;
run;

ods rtf file='p4.rtf';

proc glm data=p4 plots=diagnostics(unpack);
model y=x1 x2/p solution;
output out=new r=residuals p=predicted;
run;
ods rtf close;


ods rtf file='p4.rtf';
data new;
set new;
x=x1*x2;
group=1;
run;

proc gplot data=new;
plot residuals*x;
run;

proc boxplot data=new;
plot residuals*group/totpanels=1
             boxstyle=schematic;
run;

ods rtf close;
