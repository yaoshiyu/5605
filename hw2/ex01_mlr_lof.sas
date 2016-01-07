
options ls=80;
title 'Example 1: Service Calls Data';
data repair;
 input X Y;
 X2=X*X;
datalines;
 1       23
 2       29
 3       49
 4       64
 4       74
 5       87
 6       96
 6       97
 7      109
 8      119
 9      149
 9      145
10      154
10      166
11      162
11      174
12      180
12      176
14      179
16      193
17      193
18      195
18      198
20      205
;
run;


ods rtf  file="C:\Documents and Settings\ESCHIFAN\My Documents\Stat5605_Sp2013\examples\example1\repair_mlr_lof.rtf";

*ods graphics on;
/* from ex01_servicecalls.sas */
proc reg data=repair corr;
 var Y X;
 model Y=X/R CLI CLM RMSE;
 output out=outfit predicted=yhat residual=e;
run;
*ods graphics off;

proc print data=outfit;
run;

goptions cback=white ftext=centb htext=0 htitle=1
         ctext=black;

axis1 label=(height=1.2  "Fitted Length of Service Call (in Minutes)")
      offset=(2);

axis2 label=(height=1.2  "Number of Repaired Units")
      offset=(2);

axis3 label=(height=1.2 angle=90 "Residuals (in Minutes)")
      offset=(2);

axis4 label=(height=1.2 angle=90 "Length of Service Call (in Minutes)")
      offset=(2);

axis5 label=none;

symbol1 v=dot height=0.6 color=blue;

proc gplot data=repair;
title 'Scatter Plot of Y versus X';
 plot Y*X/vaxis=axis4 haxis=axis2;
run;

proc univariate data=repair noprint;
 title 'Histogram of Y';
 histogram Y/cfill=cyan;
run;

proc univariate data=repair noprint;
 title 'Normal Probability Plot of Y';
 qqplot Y/normal;
run;

proc univariate data=outfit noprint;
 title 'Normal Probability Plot of Residuals';
 qqplot e/normal;
run;

data outfit;
 set outfit;
 length Res $10.;
 Res='Residual';
run;

proc boxplot data=outfit;
title 'Boxplot of Residuals';
 plot e*Res  / boxstyle=schematic
                boxwidth=8.0
                idsymbol=dot
                cboxes=black
                vaxis=axis3
                haxis=axis5;
run;


proc gplot data=outfit;
title 'Plot of Residual e versus Predicted Value yhat';
 plot e*yhat/vaxis=axis3 haxis=axis1;
run;

proc gplot data=outfit;
title 'Plot of Residual e versus X';
 plot e*X/vaxis=axis3 haxis=axis2;
run;

/* include X^2 term */
proc reg data=repair corr;
 var Y X;
 model Y=X X2/R CLI CLM RMSE;
 output out=outfit predicted=yhat residual=e;
run;

proc corr data=outfit;
 var Y yhat;
 run;


/* lack of fit */
proc rsreg data=repair;
 model y=X X2/covar=2 lackfit;
run;

ods rtf close;
