data p3;
input y x @@;
datalines;
 98.0    0.0
  135.0    1.0
  162.0    2.0
  178.0    3.0
  221.0    4.0
  232.0    5.0
  283.0    6.0
  300.0    7.0
  374.0    8.0
  395.0    9.0
 ;
 run;

data p3;
set p3;
sy=sqrt(y);
run;

ods rtf file='p3.rtf';
PROC REG DATA=p3;
VAR Y X;
MODEL Y=X;
PLOT Y*X;
RUN;

ods rtf file='p3.rtf';
PROC REG DATA=p3 plots=diagnostics(unpack);
VAR sY X;
MODEL sY=X;
PLOT sY*X;
RUN;
ods rtf close;
