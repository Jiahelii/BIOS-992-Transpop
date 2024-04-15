/* Import clean data from exploring data file */
proc import out = work.trans
datafile = "/home/u49781046/Final Thesis/Clean_data.csv"
dbms = csv
replace;
run;

/* check contents */
proc contents data = work.trans;
run;

/* recoding race */
proc freq data = work.trans;
tables race_id;
run;

data work.trans2;
set work.trans;
length race_new $10;
if race_id = "White" then race_new = "White";
else if race_id = "Black/AA" then race_new = "Black";
else if race_id = "Multirace" then race_new = "Multirace";
else race_new = "Other";
length race_dicot $10;
if race_id = "White" then race_dicot = "White";
else race_dicot = "Non-White";
run;

proc freq data = work.trans2;
tables race_new * race_id race_dicot * race_id;
run;


/*trans vs cis */
proc freq data = work.trans2;
where trans_status = "No";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_new /nocum norow nocol nopercent;
run;

proc freq data = work.trans2;
where trans_status = "Yes";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_new /nocum norow nocol nopercent;
run;

proc freq data = work.trans2;
where trans_status = "No";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_dicot /nocum norow nocol nopercent;
run;


proc freq data = work.trans2;
where trans_status = "Yes";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_dicot /nocum norow nocol nopercent;
run;


/*hormones */
proc freq data = work.trans2;
where trans_status = "Yes";
where hormone = "Yes";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_new /nocum norow nocol nopercent;
run;

proc freq data = work.trans2;
where trans_status = "Yes";
where hormone = "No";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_new /nocum norow nocol nopercent;
run;


proc freq data = work.trans2;
where trans_status = "Yes";
where hormone = "Yes";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_dicot /nocum norow nocol nopercent;
run;

proc freq data = work.trans2;
where trans_status = "Yes";
where hormone = "No";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_dicot /nocum norow nocol nopercent;
run;

/*surgery */
proc freq data = work.trans2;
where trans_status = "Yes";
where surgery = "Yes";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_new /nocum norow nocol nopercent;
run;

proc freq data = work.trans2;
where trans_status = "Yes";
where surgery = "No";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_new /nocum norow nocol nopercent;
run;


proc freq data = work.trans2;
where trans_status = "Yes";
where surgery = "Yes";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_dicot /nocum norow nocol nopercent;
run;

proc freq data = work.trans2;
where trans_status = "Yes";
where surgery = "No";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_dicot /nocum norow nocol nopercent;
run;

/*provider */
proc freq data = work.trans2;
where trans_status = "Yes";
where provider = "Yes";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_new /nocum norow nocol nopercent;
run;

proc freq data = work.trans2;
where trans_status = "Yes";
where provider = "No";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_new /nocum norow nocol nopercent;
run;


proc freq data = work.trans2;
where trans_status = "Yes";
where provider = "Yes";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_dicot /nocum norow nocol nopercent;
run;

proc freq data = work.trans2;
where trans_status = "Yes";
where provider = "No";
tables (hypertension cholesterol heart_condition 
		heart_attack emphysema athsma ulcer cancer diabetes
		pre_diabetes arthritis blood_clot osteoporosis 
		thyroid liver_disease copd crohns) * race_dicot /nocum norow nocol nopercent;
run;