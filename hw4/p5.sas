data q5;
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
ods rtf file='p5.rtf';
proc reg data=q5;
var y x1;
model y=x1;
output out=out1 r=eyx2;
run;
proc reg data=q5;
var x1 x2;
model x2=x1;
output out=out2 r=ex2x2;
run;
proc reg data=q5;
var y x2;
model y=x2;
output out=out3 r=eyx1;
run;
proc reg data=q5;
var x1 x2;
model x1=x2;
output out=out4 r=ex1x1;
run;
data out5;
set out1;
set out2;
run;
data out6;
set out3;
set out4;
run;
proc sgplot data=out5;
scatter x=ex2x2 y=eyx2;
run;
proc sgplot data=out6;
scatter x=ex1x1 y=eyx1;
run;

ods rtf close;

