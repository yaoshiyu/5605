data p8;
input Y X residual;
datalines;
0.9 0.0 0.027
5.9 4.1 0.188
6.2 5.1 -0.692
8.7 6.1 0.628
9.1 .   . 
;
run;

proc reg data=p8 outset=est tableout corr;
 var Y X;
 model Y=X /ADJRSQ R CLI CLM RMSE;
 output out=outfit predicted=p residual=r;
run;

