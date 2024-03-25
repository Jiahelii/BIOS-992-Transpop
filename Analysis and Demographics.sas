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
  model ulcer = trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model cancer = trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model diabetes = trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model pre_diabetes = trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model arthritis = trans_status;
run;

proc logistic data=work.trans descending;
  class trans_status(ref = "No");
  model blood_clot = trans_status;
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
