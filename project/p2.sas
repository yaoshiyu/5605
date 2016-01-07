data p;
input Y x1 x2 x3 x4 x5 x6;
datalines;
-1.076822169	-1.244822708	-0.793841286	-1.963376206	-0.111811503	-1.232710886	-1.093523455
-1.052892787	-1.17238323	-0.790207086	-1.857362372	-0.020863159	-1.183478531	-1.056346799
-1.016998715	-1.058752677	-0.786000969	-1.694807827	-0.168922173	-1.110143943	-1.074935127
-0.993069333	-1.328625241	-0.783237499	-1.362631147	-0.555303469	-1.053301066	-1.019170143
-0.981104642	-1.682300337	-0.779832926	-1.065792412	-0.796160137	-0.997527276	-1.037758471
-0.957175261	-1.741956377	-0.774584905	-1.023386878	-1.157265092	-0.945637425	-1.019170143
-0.933245879	-1.716389503	-0.763829516	-0.980981344	-1.291737393	-0.869471112	-0.981993487
-0.921281189	-1.070115733	-0.748285023	-0.931508222	-1.306696906	-0.753688631	-0.963405159
-0.897351807	-0.82296928	-0.738213273	-0.776021265	-1.255721343	-0.673026975	-0.870463519
-0.837528353	-0.878364175	-0.723952427	-0.684142609	-1.24141694	-0.609431912	-0.814698534
-0.7777049	-0.653943832	-0.69975635	-0.599331542	-1.21280366	-0.540596171	-0.647403582
-0.753775518	-0.462192274	-0.685083929	-0.47918253	-1.014986028	-0.580786563	-0.517285286
-0.705916755	-0.584345119	-0.67309102	-0.34489834	-0.725385319	-0.619983513	-0.498696958
-0.670022683	-0.388332415	-0.649357182	-0.260087273	-0.683240482	-0.590066912	-0.442931974
-0.63412861	-0.124141379	-0.609370024	-0.182343795	-0.631835839	-0.532403202	-0.405755318
-0.598234538	0.213909516	-0.543674557	-0.125803083	-0.581379195	-0.374413047	-0.349990334
-0.538411084	0.333221597	-0.443723863	-0.083397549	-0.552764792	-0.268877848	-0.257048694
-0.454658249	0.273565556	-0.347970822	-0.019789249	-0.315708999	-0.185221138	-0.145518726
-0.335011341	-0.009090444	-0.271485389	0.093292174	-0.306527798	-0.111714476	-0.052577086
-0.299117269	0.006533757	-0.216589738	0.18517083	0.005952018	-0.044236115	0.021776226
-0.272963275	0.151412712	-0.18066297	0.241711542	0.913525508	0.018499824	0.003187898
0.138669269	0.245157918	-0.146015045	0.305319842	0.780032246	0.02366584	0.003187898
0.333549822	0.570425376	-0.079182298	0.616293755	1.732218859	0.109980533	0.003187898
1.108755135	0.668431728	-0.006150129	0.658699289	0.131891741	0.162699205	0.040364554
0.772229586	0.83319603	0.068059505	0.694037234	0.357303242	0.236920393	-0.10834207
0.679174499	1.047673699	0.177404299	0.821253834	0.272673852	0.201996332	0.17048285
1.004947502	0.919839326	0.348851693	0.891929724	-0.025082833	0.397211864	0.598014395
1.180695991	0.928361618	0.513058389	0.927267668	0.80305034	0.475839868	0.765309347
1.217021169	1.000801095	0.714877494	0.962605613	0.538055872	0.665218236	0.932604299
1.351067308	1.307603588	1.035991404	1.019146325	0.290803789	0.882608703	1.174252563
1.556450207	1.407030322	1.33937407	1.068619447	0.786301278	1.586841793	1.3973125
1.536546023	1.392826503	1.617492077	1.153430514	1.142972276	1.692736982	1.657549092
1.460549934	1.264992131	2.038798432	1.45026925	2.20276254	2.001447956	1.936374012
1.548557863	1.208176855	2.534206574	1.457336839	1.978540998	2.267612342	2.178022276
1.873657284	1.165565397	2.845984288	1.888459764	2.0195201	2.553441633	2.475435525
;
run;

PROC CORR DATA=p;
VAR x1-x6 y;
RUN;

proc sgscatter data=p;
matrix Y X1-X6;
run;

PROC REG DATA=p plots=diagnostics;
MODEL Y=X1 X2 X3 X4 X5 x6/R P INFLUENCE PARTIAL collin vif aic bic selection=rsquare adjrsq mse sse cp;
OUTPUT OUT=OUTFILE P=YPRED R=YRES STUDENT=STUDENT;
RUN;

PROC REG DATA=p ;
MODEL Y=X1 X2 X3 X4 X5 x6/selection=forward sle=0.05 ;
RUN;

PROC REG DATA=p ;
MODEL Y=X1 X2 X3 X4 X5 x6/selection=backward sls=0.05;
RUN;
ods rtf file='q.rtf';
PROC REG DATA=p ;
MODEL Y=X1 X2 X3 X4 X5 x6/selection=stepwise sle=0.05 sls=0.05;
RUN;
ods rtf close;
PROC REG DATA=p plots=diagnostics;
MODEL Y=X1 X2 X3 X5 x6/R P PARTIAL collin vif selection=rsquare adjrsq mse sse cp;
OUTPUT OUT=OUTFILE P=YPRED R=YRES STUDENT=STUDENT;
RUN;

PROC REG DATA=p plots=diagnostics;
MODEL Y=X1 X2 X3 X5 /R P PARTIAL collin vif selection=rsquare adjrsq mse sse cp;
OUTPUT OUT=OUTFILE P=YPRED R=YRES STUDENT=STUDENT;
RUN;

PROC REG DATA=p plots=diagnostics;
MODEL Y=X1 X2 X3 /R P PARTIAL collin vif selection=rsquare adjrsq mse sse cp;
OUTPUT OUT=OUTFILE P=YPRED R=YRES STUDENT=STUDENT;
RUN;

PROC REG DATA=p plots=diagnostics;
MODEL Y=X1 X2  /R P PARTIAL collin vif ;
OUTPUT OUT=OUTFILE P=YPRED R=YRES STUDENT=STUDENT;
RUN;

proc rsreg data=p plots=diagnostics;
model y=x1 x2 / lackfit;
run;

proc rsreg data=p plots=diagnostics;
model y=x1 x3 x5 / lackfit;
run;

proc rsreg data=p plots=diagnostics;
model y=x1 x2 x3 x4 x5 x6/ lackfit;
run;

data p;
set p;
x11=x1*x1;
x12=x1*x2;
x22=x2*x2;
run;

PROC REG DATA=p plots=diagnostics;
MODEL Y= X2 x11 x12 /R P collin vif selection=rsquare adjrsq mse sse cp;
OUTPUT OUT=OUTFILE P=YPRED R=YRES STUDENT=STUDENT;
RUN;
ods rtf close;