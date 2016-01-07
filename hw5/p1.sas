OPTIONS LS=72;
TITLE 'EXAMPLE 7. INFLUENCE DIAGNOSTICS: SOLID WASTED DATA';
DATA WASTE;
INPUT X1 X2 X3 X4 X5 Y;
CARDS;
 102     69    133   125    36  0.3574
1120    723   2616   953   132  1.9673
 139    138     46    35     6  0.1862
 221    637    153   115    16  0.3816
  12      0      1     9     1  0.1512
   1     50      3    25     2  0.1449
1046    127    313   392    56  0.4711
2032     44    409   540    98  0.6512
 895     54    168   117    32  0.6624
   0      0      2     0     1  0.3457
  25      2     24    78    15  0.3355
  97     12     91   135    24  0.3982
   1      0     15    46    11  0.2044
   4      1     18    23     8  0.2969
  42      4     78    41    61  1.1515
  87    162    599    11     3  0.5609
   2      0     26    24     6  0.1104
   2      9     29    11     2  0.0863
  48     18    101    25     4  0.1952
 131    126    387     6     0  0.1688
   4      0    103    49     9  0.0786
   1      4     46    16     2  0.0955
   0      0    468    56     2  0.0486
   7      0     52    37     5  0.0867
   5      1      6    95    11  0.1403
 174    113    285    69    18  0.3786
   0      0      6    35     4  0.0761
 233    153    682   404    85  0.8927
 155     56     94    75    17  0.3621
 120     74     55   120     8  0.1758
8983     37    236    77    38  0.2699
  59     54    138    55    11  0.2762
  72    112    169   228    39  0.3240
 571     78     25   162    43  0.3737
 853   1002   1017   418    57  0.9114
   5      0     17    14    13  0.2594
  11     34      3    20     4  0.4284
 258      1     33    48    13  0.1905
  69     14    126   108    20  0.2341
4790   2046   3719    31     7  0.7759
;
ods rtf file='p1.rtf';

DATA WASTE;
SET WASTE;
LY=LOG(Y);
W=2*(sqrt(y)-1);
RUN;

PROC REG DATA=WASTE CORR;
MODEL Y=X1 X2 X3 X4 X5/R P INFLUENCE PARTIAL;
OUTPUT OUT=OUTFILE P=YPRED R=YRES STUDENT=STUDENT;
RUN;

PROC REG DATA=WASTE CORR;
MODEL LY=X1 X2 X3 X4 X5/R P INFLUENCE PARTIAL;
OUTPUT OUT=OUTFILE2 P=YPRED2 R=YRES2 STUDENT=STUDENT2;
RUN;

PROC REG DATA=WASTE CORR;
MODEL W=X1 X2 X3 X4 X5/R P INFLUENCE PARTIAL;
OUTPUT OUT=OUTFILE3 P=YPRED3 R=YRES3 STUDENT=STUDENT3;
RUN;

ods rtf close;

ods rtf file='p11.rtf';
proc transreg data=waste;
model box(y)=lin(X1 X2 X3 X4 X5)/test ss2;
output;
run;

%adxgen;
%adxtrans(waste,boxcox,y,x1,x2,x3,x4,x5);
run;
proc print data=boxcox;
run;

ods rtf close;
