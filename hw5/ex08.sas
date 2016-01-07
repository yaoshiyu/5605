OPTIONS LS=72;
TITLE 'EXAMPLE 8. WEIGHTED LEAST SQUARES: SUPERVISOR DATA';
DATA WORKERS;
INPUT X Y;
W=1/(X*X);
CARDS;
 294    30
 247    32
 267    37
 358    44
 423    47
 311    49
 450    56
 534    62
 438    68
 697    78
 688    80
 630    84
 709    88
 627    97
 615   100
 999   109
1022   114
1015   117
 700   106
 850   128
 980   130
1025   160
1021    97
1200   180
1250   112
1500   210
1650   135
;
ods rtf  file="C:\Documents and Settings\ESCHIFAN\My Documents\Stat5605_Sp2013\examples\example8\workers.rtf";

PROC REG DATA=WORKERS CORR;
MODEL Y=X/CLI ACOV;
OUTPUT OUT=OUT1 PREDICTED=YPRED RESIDUAL=YRES;
RUN;
PROC REG DATA=WORKERS CORR;
WEIGHT W;
MODEL Y=X/CLI ACOV;
OUTPUT OUT=OUT2 PREDICTED=YPRED RESIDUAL=YRES;
RUN;
ods rtf close;
