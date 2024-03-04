/*import data*/
proc import out = work.trans
datafile = "/home/u49781046/Final Thesis/37938-0005-Data.tsv"
dbms = tab
replace;
run;

/*check contents for variable names*/
proc contents data = work.trans;
run;

/*look at gender identity distribution*/
proc freq data = work.trans;
tables race*gender_identity;
run;

/*look at specific health variable*/
proc freq data = work.trans;
tables q97_19 q97_20;
run;

/* recode variables */
data conditions replace;
set work.trans;
length trans_status $8;
if trans_cis = 1 then trans_status = "Yes";
if trans_cis = 2 then trans_status = "No";
length gender_id $8;
if gender_identity = 1 then gender_id = "Cis Male";
if gender_identity = 2 then gender_id = "Cis Female";
if gender_identity = 3 then gender_id = "Trans Man";
if gender_identity = 4 then gender_id = "Trans Woman";
if gender_identity = 5 then gender_id = "Non-binary";
length race_id $20;
if race = 1 then race_id = "Asian";
if race = 2 then race_id = "Black/AA";
if race = 3 then race_id = "Hispanic/Latino";
if race = 4 then race_id = "Middle Eastern";
if race = 5 then race_id = "Native Hawaiian/Pacific Islander";
if race = 6 then race_id = "White";
if race = 7 then race_id = "American Indian";
if race = 8 then race_id = "Multirace";
if race = 9 then race_id = "Other";
length sexual_minority $25;
if sexminid = 0 then sexual_minority = "Heterosexual";
if sexminid = 1 then sexual_minority = "Sexual minority identity";
length poverty_recode $20;
if poverty_i = 0 then poverty_recode = "Not in poverty";
if poverty_i = 1 then poverty_recode = "Yes in poverty";
length education $30;
if geducation = 1 then education = "Less than high school diploma";
if geducation = 2 then education = "High school degree or diploma";
if geducation = 3 then education = "technical/vocational school";
if geducation = 4 then education = "Some college";
if geducation = 5 then education = "College graduate";
if geducation = 6 then education = "Post graduate work or degree";
length hypertension $8;
if q97_1 = . then hypertension = "No";
if q97_1 = 1 then hypertension = "Yes";
length cholesterol $8;
if q97_2 = . then cholesterol = "No";
if q97_2 = 2 then cholesterol = "Yes";
length heart_condition $8;
if q97_3 = . then heart_condition = "No";
if q97_3 = 3 then heart_condition = "Yes";
length angina $8;
if q97_4 = . then angina = "No";
if q97_4 = 4 then angina = "Yes";
length heart_attack $8;
if q97_5 = . then heart_attack = "No";
if q97_5 = 5 then heart_attack = "Yes";
length stroke $8;
if q97_6 = . then stroke = "No";
if q97_6 = 6 then stroke = "Yes";
length emphysema $8;
if q97_7 = . then emphysema = "No";
if q97_7 = 7 then emphysema = "Yes";
length asthma $8;
if q97_8 = . then athsma = "No";
if q97_8 = 8 then athsma = "Yes";
length ulcer $8;
if q97_9 = . then ulcer = "No";
if q97_9 = 9 then ulcer = "Yes";
length cancer $8;
if q97_10 = . then cancer = "No";
if q97_10 = 10 then cancer = "Yes";
length diabetes $8;
if q97_11 = . then diabetes = "No";
if q97_11 = 11 then diabetes = "Yes";
length pre_diabetes $8;
if q97_12 = . then pre_diabetes = "No";
if q97_12 = 12 then pre_diabetes = "Yes";
length arthritis $8;
if q97_13 = . then arthritis = "No";
if q97_13 = 13 then arthritis = "Yes";
length blood_clot $8;
if q97_14 = . then blood_clot = "No";
if q97_14 = 14 then blood_clot = "Yes";
length osteoporosis $8;
if q97_15 = . then osteoporosis = "No";
if q97_15 = 15 then osteoporosis = "Yes";
length thyroid $8;
if q97_16 = . then thyroid = "No";
if q97_16 = 16 then thyroid = "Yes";
length liver_disease $8;
if q97_17 = . then liver_disease = "No";
if q97_17 = 17 then liver_disease = "Yes";
length copd $8;
if q97_18 = . then copd = "No";
if q97_18 = 18 then copd = "Yes";
length crohns $8;
if q97_19 = . then crohns = "No";
if q97_19 = 1 then crohns = "Yes";
length kidney_disease $8;
if q97_20 = . then kidney_disease = "No";
if q97_20 = 2 then kidney_disease = "Yes";
length health_not_good 5;
health_not_good = q94;
length surgery $12;
if q62a = 1 or q62b = 1 or q62c = 1 or q62d = 1 or q62e = 1
	or q63a = 1 or q63b = 1 or q63c = 1 or q63d = 1 or q63e = 1 or q63f = 1 or q63g = 1
	or q63h = 1 or q63i = 1 or q63j = 1
	then surgery = "Yes";
else surgery = "No";
length hormone $8;
if q65 = 1 then hormone = "Yes";
if q65 = 2 then hormone = "No";
length insurance $12;
if q81_1 = 1 then insurance = "No";
if q81_1 = . then insurance = "Yes";
length trans_provider $60;
if q87 = 1 then trans_provider = "I don't have a transgender-related healthcare provider";
if q87 = 2 then trans_provider = "They know almost everything about transgender care";
if q87 = 3 then trans_provider = "They know most things about transgender care";
if q87 = 4 then trans_provider = "They know some things about transgender care";
if q87 = 5 then trans_provider = "They know almost nothing about transgender care";
if q87 = 6 then trans_provider = "I am not sure how much they know about transgender care";
length smoking $30;
if q116 = 1 then smoking = "Every day";
if q116 = 2 then smoking = "Some Days";
if q116 = 3 then smoking = "Not at all";
if q116 = . then smoking = "Missing";
if q116 = 7 then smoking = "Non-smoker";
run;

/* check recoding */
proc freq data = work.conditions;
tables q97_1 * hypertension q97_2 * cholesterol q97_3 * heart_condition
	   q97_4 * angina q97_5 * heart_attack q97_6 * stroke
	   q97_7 * emphysema q97_8 * asthma q97_9 * ulcer
	   q97_10 * cancer q97_11 * diabetes q97_12 * pre_diabetes
	   q97_13 * arthritis q97_14 * blood_clot q97_15 * osteoporosis
	   q97_16 * thyroid q97_17 * liver_disease q97_18 * copd
	   q97_19 * crohns q97_20 * kidney_disease
	   ;
run;

/*checking assumptions for hypertension */
proc freq data = work.conditions;
tables gender_id * hypertension trans_status * hypertension;
run;

/*checking assumptions for cholesterol */
proc freq data = work.conditions;
tables gender_id * cholesterol trans_status * cholesterol;
run;

/*checking assumptions for heart condition */
proc freq data = work.conditions;
tables gender_id * heart_condition trans_status * heart_condition;
run;

/*checking assumptions for angina */
proc freq data = work.conditions;
tables gender_id * angina trans_status * angina;
run;

/*checking assumptions for heart attack */
proc freq data = work.conditions;
tables gender_id * heart_attack trans_status * heart_attack;
run;

/*checking assumptions for stroke */
proc freq data = work.conditions;
tables gender_id * stroke trans_status * stroke;
run;

/*checking assumptions for emphysema */
proc freq data = work.conditions;
tables gender_id * emphysema trans_status * emphysema;
run;

/*checking assumptions for asthma */
proc freq data = work.conditions;
tables gender_id * asthma trans_status * asthma;
run;

/*checking assumptions for ulcer */
proc freq data = work.conditions;
tables gender_id * ulcer trans_status * ulcer;
run;

/*checking assumptions for cancer */
proc freq data = work.conditions;
tables gender_id * cancer trans_status * cancer;
run;

/*checking assumptions for diabetes */
proc freq data = work.conditions;
tables gender_id * diabetes trans_status * diabetes;
run;

/*checking assumptions for pre_diabetes */
proc freq data = work.conditions;
tables gender_id * pre_diabetes trans_status * pre_diabetes;
run;

/*checking assumptions for arthritis */
proc freq data = work.conditions;
tables gender_id * arthritis trans_status * arthritis;
run;

/*checking assumptions for blood_clot */
proc freq data = work.conditions;
tables gender_id * blood_clot trans_status * blood_clot;
run;

/*checking assumptions for osteoporosis */
proc freq data = work.conditions;
tables gender_id * osteoporosis trans_status * osteoporosis;
run;

/*checking assumptions for thyroid */
proc freq data = work.conditions;
tables gender_id * thyroid trans_status * thyroid;
run;

/*checking assumptions for liver_disease */
proc freq data = work.conditions;
tables gender_id * liver_disease trans_status * liver_disease;
run;

/*checking assumptions for copd */
proc freq data = work.conditions;
tables gender_id * copd trans_status * copd;
run;

/*checking assumptions for crohns */
proc freq data = work.conditions;
tables gender_id * crohns trans_status * crohns;
run;

/*checking assumptions for kidney_disease */
proc freq data = work.conditions;
tables gender_id * kidney_disease trans_status * kidney_disease;
run;


/* logistic for sample tables */
proc logistic data=work.conditions descending;
  class trans_cis(ref = "2");
  model hypertension = trans_cis;
run;


proc logistic data=work.conditions descending plots=all;
  class trans_cis(ref = "2");
  model cholesterol = trans_cis;
run;


proc logistic data = work.conditions descending plots=all;
	where trans_cis = 1;
	class gender_identity(ref = "3") surgery(ref = "Yes");
	/*oddsratio gender_identity / at(surgery = "No");
	oddsratio gender_identity / at(surgery = "Yes");*/
	oddsratio surgery / at(gender_identity = "3");
	oddsratio surgery / at(gender_identity = "4");
	oddsratio surgery / at(gender_identity = "5");
	model hypertension = gender_identity surgery gender_identity*surgery / clodds=wald;
run;

proc logistic data = work.conditions descending;
	where trans_cis = 1;
	class surgery(ref = "Yes");
	model hypertension = surgery ;
run;

proc logistic data = work.conditions descending;
	where trans_cis = 1;
	class gender_identity(ref = "3") surgery(ref = "Yes");
	/*oddsratio gender_identity / at(surgery = "No");
	oddsratio gender_identity / at(surgery = "Yes");*/
	oddsratio surgery / at(gender_identity = "3");
	oddsratio surgery / at(gender_identity = "4");
	oddsratio surgery / at(gender_identity = "5");
	model cholesterol = gender_identity surgery gender_identity*surgery / clodds=wald;
run;

proc logistic data = work.conditions descending;
	where trans_cis = 1;
	class surgery(ref = "Yes");
	model cholesterol = surgery ;
run;

/* export data */
proc export data = work.conditions
outfile = "/home/u49781046/Final Thesis/graph.csv"
dbms = csv replace;
run;

