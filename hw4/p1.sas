data p1;
input y x1 x2 x3 @@; 
datalines;
20	2	20	4
60	4	19	5
46	3	27	4
41	2	32	1
12	1	24	4
137	10	26	4
68	5	24	3
89	5	28	6
4	1	22	6
32	2	18	6
144	9	25	4
156	10	25	4
93	6	32	6
36	3	16	3
72	4	35	6
100	8	16	3
105	7	19	4
131	8	36	4
127	10	9	5
57	4	25	7
66	5	17	3
101	7	24	2
109	7	30	3
74	5	27	5
134	9	23	5
112	7	32	3
18	2	16	3
73	5	25	3
111	7	28	4
96	6	25	5
123	8	21	3
90	5	35	4
20	2	20	3
28	2	14	4
3	1	21	3
57	4	21	2
86	5	34	6
132	9	24	5
112	7	30	4
27	1	30	3
131	9	24	3
34	2	23	2
27	2	28	3
61	4	26	3
77	5	33	6
;
run;
ods rtf file='p1.rtf';

proc reg data=p1 plots=diagnostics(unpack);
model y=x1/R P SS1 SS2 PARTIAL;
output out=out p=p r=r;
run;

proc univariate data=out PLOT FREQ NORMAL;
var r;
run;

ods rtf close;
