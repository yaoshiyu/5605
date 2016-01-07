data p120;
input Y X;
datalines;
   20     2
   60     4
   46     3
   41     2
   12     1
  137    10
   68     5
   89     5
    4     1
   32     2
  144     9
  156    10
   93     6
   36     3
   72     4
  100     8
  105     7
  131     8
  127    10
   57     4
   66     5
  101     7
  109     7
   74     5
  134     9
  112     7
   18     2
   73     5
  111     7
   96     6
  123     8
   90     5
   20     2
   28     2
    3     1
   57     4
   86     5
  132     9
  112     7
   27     1
  131     9
   34     2
   27     2
   61     4
   77     5
;
run;

ods rtf file='1.rtf';

proc reg data=p120 corr;
 var Y X;
 model Y=X /R CLI CLM RMSE;
 output out=outfit predicted=p residual=r;
run;

ods rtf close;
