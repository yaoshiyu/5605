data p10;
input x1 x2 y;
datalines;
0   0 0.9
4.1 0 5.9
5.1 0 6.2
6.1 0 8.7
7.1 0 9.1
0   1 0.2
4.8 1 21.0
3.8 1 16.7
2.8 1 12.4
1.8 1 9.3
;
run;

data p10;
set p10;
x3=x1*x2;
run;

ods rtf file='p10.rtf';

PROC REG DATA=p10 CORR plots=diagnostics(unpack);
MODEL Y=X1 X2 X3/R P ;
OUTPUT OUT=OUTFILE P=YPRED R=YRES STUDENT=STUDENT;
RUN;
ods rtf close;
