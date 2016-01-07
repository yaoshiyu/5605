OPTIONS LS=72;
TITLE 'EXAMPLE 4. MULTIPLE LINEAR REGRESSION: STEAM DATA';
DATA STEAM;
INPUT OBS Y X1-X9;
CARDS;
 1  10.98   5.20   0.61    7.4   31   20   22   35.3   54.8    4
 2  11.13   5.12   0.64    8.0   29   20   25   29.7   64.0    5
 3  12.51   6.19   0.78    7.4   31   23   17   30.8   54.8    4
 4   8.40   3.89   0.49    7.5   30   20   22   58.8   56.3    4
 5   9.27   6.28   0.84    5.5   31   21    0   61.4   30.3    5
 6   8.73   5.76   0.74    8.9   30   22    0   71.3   79.2    4
 7   6.36   3.45   0.42    4.1   31   11    0   74.4   16.8    2
 8   8.50   6.57   0.87    4.1   31   23    0   76.7   16.8    5
 9   7.82   5.69   0.75    4.1   30   21    0   70.7   16.8    4
10   9.14   6.14   0.76    4.5   31   20    0   57.5   20.3    5
11   8.24   4.84   0.65   10.3   30   20   11   46.4  106.1    4
12  12.19   4.88   0.62    6.9   31   21   12   28.9   47.6    4
13  11.88   6.03   0.79    6.6   31   21   25   28.1   43.6    5
14   9.57   4.55   0.60    7.3   28   19   18   39.1   53.3    5
15  10.94   5.71   0.70    8.1   31   23    5   46.8   65.6    4
16   9.58   5.67   0.74    8.4   30   20    7   48.5   70.6    4
17  10.09   6.72   0.85    6.1   31   22    0   59.3   37.2    6
18   8.11   4.95   0.67    4.9   30   22    0   70.0   24.0    4
19   6.83   4.62   0.45    4.6   31   11    0   70.0   21.2    3
20   8.88   6.60   0.95    3.7   31   23    0   74.5   13.7    4
21   7.68   5.01   0.64    4.7   30   20    0   72.1   22.1    4
22   8.47   5.68   0.75    5.3   31   21    1   58.1   28.1    6
23   8.86   5.28   0.70    6.2   30   20   14   44.6   38.4    4
24  10.36   5.36   0.67    6.8   31   20   22   33.4   46.2    4
25  11.08   5.87   0.70    7.5   31   22   28   28.6   56.3    5
;

ods rtf  file="C:\Documents and Settings\ESCHIFAN\My Documents\Stat5605_Sp2013\examples\example4\ex4steam.rtf";

/* COMPUTES CORRELATIONS BETWEEN VARIABLES */
PROC CORR DATA=STEAM;
VAR X1-X9 Y;
RUN;

/* FITS A MULTIPLE REGRESSION: gives residual analysis, predictions, 
	sequential sum of squares or Type I SS (SS1), partial sum of squares 
	or Type II SS (SS2), and Partial Regression (leverage) Plots (added Variable Plots)*/
PROC REG DATA=STEAM;
MODEL Y=X1-X9/R P SS1 SS2 PARTIAL;
OUTPUT OUT=OUTFILE PREDICTED=YPRED RESIDUAL=YRES;

/* TEST HYPOTHESES ON CERTAIN SUBSETS OF PARAMETER VECTOR */
TEST1: TEST X1=0;
TEST2: TEST X1=0, X2=0;
TEST3: TEST X1-X2=0;
RUN;

/* EXCLUDE CERTAIN X VARIABLES FROM THE FULL MODEL */
/* PRINT ONLY THE BASIC REGRESSION OUTPUT */
DELETE X2 X3;
PRINT ANOVA;
RUN;

/* INCLUDE A PREVIOUSLY EXCLUDED VARIABLE */
ADD X2;
PRINT ANOVA;
RUN;

/* Multivariate Scatterplot Matrix */
proc sgscatter data=STEAM;
matrix Y X1-X9;
run;

/* RESIDUAL ANALYSES */
/* Basic Residual Plots */
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



/* Partial Residual Plot (Residual plus component plot) for X4*/

	/* Regression of Y on all variables but X4; residuals in YRES1 */
PROC REG DATA=STEAM;
MODEL Y=X1-X3 X5-X9;
OUTPUT OUT=OUTFILE1 PREDICTED=YPRED1 RESIDUAL=YRES1;
RUN;
	/* Plot YRES1 vs X4 */
DATA PARTRES;
MERGE STEAM OUTFILE1;
RUN;

PROC PLOT DATA=PARTRES;
PLOT YRES1*X4;
RUN;

/*Partial Regression (leverage) Plot (added Variable Plot) for X4 */
	
	/* Regression of X4 on X1-X3 X5-X9; residuals in YRES2 */
PROC REG DATA=STEAM;
MODEL X4=X1-X3 X5-X9;
OUTPUT OUT=OUTFILE2 PREDICTED=YPRED2 RESIDUAL=YRES2;
RUN;
	/* Plot YRES1*YRES2 */
DATA PARTREG;
MERGE OUTFILE1 OUTFILE2;
RUN;

PROC PLOT DATA=PARTREG;
PLOT YRES1*YRES2;
RUN;

ods rtf close;





