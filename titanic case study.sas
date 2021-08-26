/*----------------Q1 Load data on SAS--------------*/ 

proc import datafile='/home/u59059132/Dataset/Titanic.csv' out=titaic dbms=csv replace;
getnames=yes;

run;

proc print data=titanic;

run;

/*Q2 Print top 10 rows */

proc print data=titanic(obs=10);
run;


/*Q3 All Information & Summary of dataset*/

proc contents data=titanic;
run;

/*Q4.Count Survived & show Pie chart*/

proc sql;
	select COUNT(survived) from titanic where survived=1;
quit;

/*Q5.Count of survived on pie chart*/

PROC TEMPLATE;
	DEFINE STATGRAPH pie;
		BEGINGRAPH;
		LAYOUT REGION;
		PIECHART CATEGORY=survived / DATALABELLOCATION=OUTSIDE 
			CATEGORYDIRECTION=CLOCKWISE START=180 NAME='pie';
		DISCRETELEGEND 'pie' / TITLE=' Survived';
		ENDLAYOUT;
		ENDGRAPH;
	END;
RUN;

PROC SGRENDER DATA=titanic TEMPLATE=pie;
RUN;

/*Q6.How many female passengers travelled in 1st class & show on pie chart*/

proc sql;
	select count(survived) from titanic where survived=1 and sex='female' and 
		pclass=1;
quit;

/*pie chart*/

PROC TEMPLATE;
	DEFINE STATGRAPH pie;
		BEGINGRAPH;
		LAYOUT REGION;
		PIECHART CATEGORY=Sex / group=pclass DATALABELLOCATION=OUTSIDE 
			CATEGORYDIRECTION=CLOCKWISE START=180 NAME='pie';
		DISCRETELEGEND 'pie' / TITLE='female passenger survived ';
		ENDLAYOUT;
		ENDGRAPH;
	END;
RUN;

PROC SGRENDER DATA=titanic TEMPLATE=pie;
RUN;

/*7.Find out how many female passengers had survied & her age<30, show on pie & bar charts*/

proc sql;
	SELECT COUNT(survived) FROM titanic WHERE survived=1 and sex='female' and 
		age<30;
quit;
/*pie chart*/

PROC TEMPLATE;
	DEFINE STATGRAPH pie;
		BEGINGRAPH;
		LAYOUT REGION;
		PIECHART CATEGORY=survived / group=female DATALABELLOCATION=OUTSIDE 
			CATEGORYDIRECTION=CLOCKWISE START=180 NAME='pie';
		DISCRETELEGEND 'pie' / TITLE='female passenger survived ';
		ENDLAYOUT;
		ENDGRAPH;
	END;
RUN;

PROC SGRENDER DATA=titanic TEMPLATE=pie;
RUN;

/*Bar plot*/

proc SGPLOT data=work.titanic;
	vbar survived /group=sex;
	title 'count of survived female passengers';
run;

quit;

/*Q9.Find out how many male passengers had survied & his age>40, show on pie charts*/

proc sql;
	SELECT COUNT(survived) FROM titanic WHERE survived=1 and sex='male' and age>40;
quit;

PROC TEMPLATE;
	DEFINE STATGRAPH pie;
		BEGINGRAPH;
		LAYOUT REGION;
		PIECHART CATEGORY=survived / group=male DATALABELLOCATION=OUTSIDE 
			CATEGORYDIRECTION=CLOCKWISE START=180 NAME='pie';
		DISCRETELEGEND 'pie' / TITLE='male passenger survived ';
		ENDLAYOUT;
		ENDGRAPH;
	END;
RUN;

PROC SGRENDER DATA=titanic TEMPLATE=pie;
RUN;


/*Q10.Show age frequency with survived & not survived(Histogram*/)

PROC UNIVARIATE DATA=titanic;
	HISTOGRAM survived;
RUN;

/*Q11.Show bar graph for survived with male,female,class*/

PROC FREQ DATA=titanic;
	TABLES sex*survived*pclass /NOCOL nocum NOPERCENT 
		plots=freqplot(twoway=stacked type=barplot);
RUN;


/*Q12. How many passengers are travelled in different classes show in bar graph*/

proc SGPLOT data=work.titanic;
	vbar pclass;
	title 'count of survived passengers';
run;

quit;

/*Q13. how many passengers are survived with classwise & show bar graph*/

proc SGPLOT data=work.titanic;
	vbar survived /group=pclass;
	title 'count of survived passengers in each class';
run;

quit;


/*Q14.Show bar graph for survived with 3rd class male, 1st class female*/

proc freq data=titanic;
tables sex*survived*pclass/nocum nopercent plots=freqplot(twoway=stacked orient=horizontal);
where survived=1
and sex ="male"and pclass=3;
run;
proc freq data=titanic;
tables sex*survived*pclass /nocum nopercent plots=freqplot(twoway=stacked orient=horizontal);
where survived=1
and sex ="female"and pclass=1;
run;


