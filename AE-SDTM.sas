/*Change all variable names to update*/
options validvarname=upcase;

/*Import raw Adverse Events data.*/
data ae01;
   	set adverse;
run;

/*Import raw Demographics data.*/ 
data dm01;
   	set dm;
run;
 
/*Import raw Subject Elements data.*/
data se01;
   	set se;
run;

/*Add some formats permanently.*/
libname formproj '/home/u63567925/sasuser.v94/DimpleProj/nct0285/SDTM Data + Programs';

proc format lib=formproj;
	value $monnum "JAN"="1"
				  "FEB"="2"
				  "MAR"="3"
				  "APR"="4"
				  "MAY"="5"
				  "JUN"="6"
				  "JUL"="7"
				  "AUG"="8"
				  "SEP"="9"
				  "OCT"="10"
				  "NOV"="11"
				  "DEC"="12";
run;

/*Clean up the data so that it's CDISC-compliant.*/
data ae02;
   	length domain $2 studyid usubjid $20 aeacn $30;
   	set ae01;
   	domain="AE";
   	studyid=strip(study);
   	usubjid=catx("-",  strip(study), strip(pt));
   	aellt=strip(aellt);
   	aeterm=strip(aevt);
   	aedecod=strip(aedecod);
   	aecat=aecat;
   	/*Set Body, System, or Class AE Term as is.*/
   	aebodsys=aebodsys;
   	aesev=upcase(aesev);
   	/*Normalize 'Serious Event' variable.*/
   	if upcase(aeser)="YES" then
   	aeser="Y";
   	if upcase(aeser)="NO" then
	aeser="N";
	/*Normalize 'Action taken' variable.*/
	if upcase(aeacn)="NO ACTION TAKEN" then
	aeacn="DOSE NOT CHANGED";
	else aeacn=upcase(aeacn);
    /*Normalize 'Other Action taken' variable.*/
	aeacnoth=aeacnoth;
	/*Normalize 'Causality' variable.*/
	if upcase(aerel)="YES" then 
	aerel="Y";
	if upcase(aerel)="NO" then
	aerel="N";
	/*Uppercase 'Outcome of AE Event'*/
	aeout=upcase(aeout);
	/*Congenital Anomaly or Birth Defect*/
	if upcase(scong)="YES" then 
	aescong="Y";
	if upcase(scong)="NO" then
	aescong="N";
	/*Persist or Signif Disability/Incapacity*/
	if upcase(sdisab)="YES" then
	aesdisab="Y";
	if upcase(sdisab)="NO" then
	aesdisab="N";
	/*'Results in Death'*/
	if upcase(sdeath)="YES" then
	aesdth="Y";
	if upcase(sdeath)="NO" then
	aesdth="N";
	/*'Requires or Prolongs Hospitalization'*/
	if upcase(shosp)="YES" then
	aeshosp="Y";
	if upcase(shosp)="NO" then
	aeshosp="N";
	/*'Is Life Threatening'*/
	if upcase(slife)="YES" then
	aeslife="Y";
	if upcase(slife)="NO" then
	aeslife="N";	
	/*Other Medically Important Serious Event*/
	if upcase(smie)="YES" then
	aesmie="Y";
	if upcase(smie)="NO" then
	aesmie="N";	
	stdayn=input(scan(aestdt_raw, 1, '/'), best.);
	if ~cmiss(stdayn) then
	stday=put(stdayn, z2.);
	stmonthc=upcase(scan(aestdt_raw, 2, '/'));
	stmonth=put(stmonthc, $monnum.);
	styear=scan(aestdt_raw, 3, '/');
	if styear="UNK" then
	styear="";
	aestdtc=catx("-", styear, stmonth, stday);
	endayn=input(scan(aeendt_raw, 1, '/'), best.);
	if ~cmiss(endayn) then 
	enday=put(endayn, z2.);
	enmonthc=upcase(scan(aeendt_raw, 2, '/'));
	if enmonthc="JAN" then
	enmonth="01";
	enmonth=put(enmonthc, $monnum.);
	enyear=scan(aeendt_raw, 3, '/');
	if enyear="UNK" then
	enyear="";
	aeendtc=catx("-", enyear, enmonth, enday);
run;

proc sort data=dm01;
	by usubjid;
run;

proc sort data=ae02;
	by usubjid;
run;

data ae03;
	merge ae02(in=a) dm01(in=b keep=usubjid rfstdtc rfxendtc);
	by usubjid;
	if a;
	if length(rfstdtc)>=10 then
	rfstdt=input(rfstdtc, yymmdd10.);
	if length(aestdtc)>=10 then
	aestdt=input(aestdtc, yymmdd10.);
	if length(aeendtc)>=10 then
	aeendt=input(aeendtc, yymdd10.);
	if ~cmiss(rfxendtc) then 
	rfxendt=input(substrn(rfxendtc, 1, 10), yymmdd10.);
	*Treatment-emergeny adverse event calculation.;
	if ~cmiss(rfxendt) then 
	rfxen15dtc=put(rfxendt+15, yymmdd10.);
	if n(aestdt,rfstdt)=2 then 
	aestdy=aestdt-rfstdt+(aestdt>=rfstdt);
 	if ~cmiss(aeendt) and ~cmiss(rfstdt) then do;
    	if aeendt ge rfstdt then 
    	aeendy=aeendt-rfstdt+1;
      	else aeendy=aeendt-rfstdt;
   	end;
 	if prefdose="Y" then 
 	aetrtem="N";
   	else if "" lt substrn(rfstdtc, 1, 10) le aestdtc le rfxen15dtc 
   	then aetrtem="Y";
   	else if aestdtc ne "" then aetrtem="N";
 	format aestdt aeendt rfstdt rfxendt date9.;
run;

/*----------------------------------------------------------
Process SE dataset so that the start and  end dates transpose to a single horizontal record for each SUBJECT.
----------------------------------------------------------*/;
data se02;
	set se01;
	if epoch="FOLLOW-UP" then
	epoch="FOLLOWUP";
run;
 
proc sort data=se02;
   	by usubjid;
run;
 
proc transpose data=se02 out=epochstart(drop=_:) prefix=start_;
   	by usubjid;
   	id epoch;
   	var sestdtc;
run;
 
proc transpose data=se02 out=epochend(drop=_:) prefix=end_;
   	by usubjid;
   	id epoch;
   	var seendtc;
run;
 
data epochdates;
   	merge epochstart epochend;
   	by usubjid;
run;
 
/*Compare AESTDTC with each epoch's start and end dates and 
assign epoch value.*/
 data ae04;
	merge ae03(in=a) epochdates;
   	by usubjid;
   	if a;
run;
 
data epae;
	merge ae04(in=a) epochdates;
	by usubjid;
	length epoch $40;
	if ~cmiss(aestdtc) then do;
	if aestdtc le end_SCREENING and aestdtc ge start_SCREENING then
	epoch="SCREENING";
	if aestdtc le end_TREATMENT and aestdtc ge start_TREATMENT then
	epoch="TREATMENT";
	if aestdtc le end_FOLLOWUP and aestdtc ge start_FOLLOWUP then
	epoch="FOLLOW-UP";
	end;
run;


/*Create AESEQ variable*/
proc sort data=epae out=ae05;
	by usubjid aedecod aestdtc;
run;
 
data ae06;
	set ae05;
	by usubjid aedecod aestdtc;
   	if first.usubjid then aeseq=1;
   	else aeseq+1;
run;
 
/*Assign attributes and keep only required variables.*/
%let varlist=studyid domain usubjid aeseq aeterm aellt aedecod aecat
aebodsys aesev aeser aeacn aeacnoth aerel aeout aescong aesdisab aesdth
aeshosp aeslife aesmie epoch aestdtc aeendtc aestdy aeendy prefdose
aetrtem;
 
data ae07;
	attrib
   	studyid label='Study Identifier'
   	domain label='Domain Abbreviation'
   	usubjid label='Unique Subject Identifier'
   	aeseq label='Sequence Number'
   	aeterm label='Reported Term for the Adverse Event'
   	aellt label='Lowest Level Term'
   	aedecod label='Dictionary-Derived Term'
   	aecat label='Category for Adverse Event'
   	aebodsys label='Body System or Organ Class'
   	aesev label='Severity/Intensity'
   	aeser label='Serious Event'
   	aeacn label='Action Taken with Study Treatment'
   	aeacnoth label='Other Action Taken'
   	aerel label='Causality'
   	aeout label='Outcome of Adverse Event'
   	aescong label='Congenital Anomaly or Birth Defect'
   	aesdisab label='Persist or Signif Disability/Incapacity'
   	aesdth label='Results in Death'
   	aeshosp label='Requires or Prolongs Hospitalization'
   	aeslife label='Is Life Threatening'
   	aesmie label='Other Medically Important Serious Event'
   	epoch label='Epoch'
   	aestdtc label='Start Date/Time of Adverse Event'
   	aeendtc label='End Date/Time of Adverse Event'
   	aestdy label='Study Day of Start of Adverse Event'
   	aeendy label='Study Day of End of Adverse Event'
   	prefdose label='Prior to First Dose?'
   	aetrtem label='Treatment Emergent Flag';
   	set ae06;
   	keep &varlist.;
run;
 
/*=========================================================
Create supplementary domain
=========================================================*/
 
/*----------------------------------------------------------
Transpose the non-parent domain variables
----------------------------------------------------------*/
 %let suppvars=prefdose aetrtem;
proc sort data=ae07 out=suppae01;
   	by studyid domain usubjid aeseq;
run;
 
proc transpose data=suppae01 out=suppae02(rename=(col1=qval) 
where=(qval ne "")) name=qnam label=qlabel;
   	by studyid domain usubjid aeseq;
   	var &suppvars.;
run;
 
data suppae03;
	attrib  studyid label='Study Identifier'
      		rdomain label='Related Domain Abbreviation'
      		usubjid label='Unique Subject Identifier'
	      	idvar label='Identifying Variable'
	      	idvarval label='Identifying Variable Value'
	      	qnam label='Qualifier Variable Name'
	      	qlabel label='Qualifier Variable Label'
      		qval label='Data Value';
	retain studyid rdomain usubjid idvar idvarval qnam qlabel qval;
   	set suppae02;
   	idvar="AESEQ";
   	idvarval=cats(aeseq);
   	rdomain=domain;
   	drop domain aeseq;
run;
 
/*=========================================================
Save final copies of the datasets with dataset labels
=========================================================*/
options validvarname=v7;
proc sort data=ae07 out=ae(label="Adverse Events" drop=&suppvars.);
	by usubjid;
run;
 
proc sort data=suppae03 out=suppae(label="Supplemental Qualifiers for AE");
   	by usubjid idvar idvarval;
run;
 