data p2;
input x n y;
datalines;
2.0  500.0   72.0
5.0  500.0  103.0
10.0  500.0  170.0
20.0  500.0  296.0
25.0  500.0  406.0
30.0  500.0  449.0
;
run;

data p2;
set p2;
p=y/n;
run;



proc gplot data=p2;
plot p*x;
run;
ods rtf file='2.rtf';
proc logistic data=p2;
model y/n=x/clparm=wald clodds=wald ;
run;
ods rtf close;
proc genmod data=p2;
model y/n=x;
run;

