proc import out = work.trans
datafile = "/home/u49781046/Final Thesis/37938-0005-Data.tsv"
dbms = tab
replace;
run;

proc contents data = work.trans;
run;

proc freq data = work.trans;
tables race*gender_identity;
run;

proc freq data = work.trans;
where trans_cis = 1;
tables q62c;
run;

data conditions replace;
set work.trans;
length hypertension $8;
if q97_1 = . then hypertension = "No";
if q97_1 = 1 then hypertension = "Yes";
length cholesterol $8;
if q97_2 = . then cholesterol = "No";
if q97_2 = 2 then cholesterol = "Yes";
gender_id = put(gender_identity, $14.);
length surgery $12;
if q62a = 1 or q62b = 1 or q62c = 1 or q62d = 1 or q62e = 1
	or q63a = 1 or q63b = 1 or q63c = 1 or q63d = 1 or q63e = 1 or q63f = 1 or q63g = 1
	or q63h = 1 or q63i = 1 or q63j = 1
	then surgery = "Yes";
else surgery = "No";
run;

proc freq data = work.conditions;
tables gender_identity * cholesterol;
run;

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

hiiii Priyanka 
