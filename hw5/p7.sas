data p7;
input y x;
datalines;
27.1   23.0
 22.1   19.0
 21.9   25.0
 10.7   12.0
  1.4    8.0
 18.8   12.0
 14.7   11.0
  5.7    8.0
 18.6   17.0
 20.4   18.0
  9.2    9.0
 23.4   21.0
 10.5   10.0
 19.7   25.0
 11.8    9.0
 24.6   17.0
  3.4    9.0
 22.8   23.0
 21.1   13.0
 24.0   14.0
 21.8   16.0
 23.5   17.0
 19.4   21.0
 25.6   24.0
 12.8   13.0
 20.8   14.0
 20.6   18.0
 ;
 run;
 
data p7;
set p7;
x2=x*x;
run;

ods rtf file='p8.rtf';

PROC rsREG DATA=p7 plots=diagnostics(unpack);
MODEL Y=X;
RUN;
ods rtf close;
