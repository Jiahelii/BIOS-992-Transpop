/* Import clean data from exploring data file */
proc import out = work.trans
datafile = "/home/u49781046/Final Thesis/Clean_data.csv"
dbms = csv
replace;
run;

/* check contents */
proc contents data = work.trans;
run;

/* demographic variables */
proc freq data = work.trans;
tables race_id * gender_id race_id * trans_status / norow nocum;
run;

proc freq data = work.trans order=data;
tables education * gender_id education * trans_status / norow ;
run;

proc freq data = work.trans order=data;
tables hormone * gender_id hormone * trans_status / norow ;
run;

proc means data = work.trans n mean std maxdec = 2;
var age;
run;

proc means data = work.trans n mean std maxdec = 2;
class gender_id;
var age;
run;

proc means data = work.trans n mean std maxdec = 2;
class trans_status;
var age;
run;

/* health variables */
proc freq data = work.trans;
tables smoking * gender_id smoking * trans_status smoking / norow nocum ;
run;

proc freq data = work.trans;
tables (ulcer cancer diabetes pre_diabetes arthritis blood_clot) * trans_status
		(ulcer cancer diabetes pre_diabetes arthritis blood_clot) * gender_id / norow nocum;
run;

/* logistic regression for odds ratios */
proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model ulcer = age trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model cancer = age trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model diabetes = age trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model pre_diabetes = age trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model arthritis = age trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model blood_clot = age trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model osteoporosis = trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model thyroid = trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model liver_disease = trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model copd = trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model crohns = trans_status;
run;

/* Interactions */

/* Logistic Regresstion: Health Condition = transgender status + insurance + transgender status * insurance */
proc logistic data=work.trans descending;
  class trans_status(ref="No") insurance;
  model ulcer = trans_status insurance trans_status*insurance / clparm=wald;
run;

/* linear regression */

/* look at data distribution */
proc univariate data=work.trans;
	where health_not_good <= 30;
    var health_not_good;
    histogram health_not_good;
run;

/* look at data distribution by class */
proc sgplot data=work.trans;
	where health_not_good <= 30;
    vbox health_not_good / category=trans_status;
run;

/*linear regression with trans_status as predictor variable */
proc glm data = work.trans;
where health_not_good <= 30;
class trans_status(ref="No");
model health_not_good = age trans_status /solution clparm;
run;

proc means data = work.trans maxdec = 2;
where health_not_good <= 30;
class trans_status;
var health_not_good;
run;
