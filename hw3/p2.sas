data p2;
input x y;
datalines;
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
2	3.5
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
1	9.3
;
run;
ods rtf file='1.rtf';
proc reg data=p2 corr;
 var Y X;
 model Y=X /R CLI CLM RMSE;
 output out=outfit predicted=p residual=r;
run;
ods rtf close;
