OPTIONS LS=72;
TITLE 'EXAMPLE 2. SIMPLE LINEAR REGRESSION: TV RATINGS DATA';
DATA RATINGS;
INPUT X Y;
datalines;
2.50    3.80
2.70    4.10
2.90    5.80
3.10    4.80
3.30    5.70
3.50    4.40
3.70    4.80
3.90    3.60
4.10    5.50
4.30    4.15
4.50    5.80
4.70    3.80
4.90    4.75
5.10    3.90
5.30    6.20
5.50    4.35
5.70    4.15
5.90    4.85
6.10    6.20
6.30    3.80
6.50    7.00
6.70    5.40
6.90    6.10
7.10    6.50
7.30    6.10
7.50    4.75
2.50    1.00
2.70    1.20
7.30    9.50
7.50    9.00
;
run;

ods rtf file='1.rtf';
proc gplot data=ratings;
plot y*x;
title 'Scatter plot for X & Y';
run;

data r1(keep=x) r2(keep=y);
set ratings;
run;

proc sort data=r1;
by x;
run;

proc sort data=r2;
by y;
run;

data r12;
merge r1 r2;
run;


proc gplot data=r12;
plot y*x;
title 'Empirical Q-Q plot for X & Y';
run;

ods rtf close;


ods rtf  file="C:\Documents and Settings\ESCHIFAN\My Documents\Stat5605_Sp2013\sas\ratings.rtf";

PROC REG DATA=RATINGS;
VAR Y X;
MODEL Y=X/ADJRSQ R CLI CLM RMSE;
OUTPUT OUT=OUTFILE PREDICTED=YPRED RESIDUAL=YRES;
PLOT Y*X;
PLOT RESIDUAL.*PREDICTED.;
PLOT RESIDUAL.*X;
RUN;

/* Univariate residual Analysis */
PROC UNIVARIATE DATA=OUTFILE PLOT FREQ NORMAL;
VAR YRES;
RUN;

/* Alternate way to get Normal Probability Plot of Residuals */
PROC RANK NORMAL=BLOM;
VAR YRES;
RANKS NSCORE;
RUN;
PROC PLOT;
PLOT YRES*NSCORE;


ods rtf close;
