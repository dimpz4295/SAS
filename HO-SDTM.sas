/*Make all variables upper case. Set library name to nct0285.*/

options validvarname=upcase;
libname SDTMdata "/home/u63567925/sasuser.v94/DimpleProj/nct0285/SDTMdata";
libname nct0285 "/home/u63567925/sasuser.v94/DimpleProj/nct0285";

/*=========================================================
*Create SDTM program for Hospitalizations Domain for Atezolizumab 
Effect on Non-small Cell Lung Cancer Trial;
=========================================================*/
/*Import raw data for hospitalizations.*/
data hosp2;
	set hosp;
run;

/*Create identifier variables like studyid, domain, subjid, siteid, usubjid.*/
data hosp3;	
	set hosp;
	studyid="NCT0285";
	domain="HO";
	usubjid=catx("-", project, subject);
	if ~cmiss(recordposition) then 
	hospid=put(recordposition, z3.);
	hoterm=hounit;
	if ~cmiss(hostdat) then do;
		hostdtc=put(input(hostdat, date11.), yymmdd10.);
	end;
	if ~cmiss(hoendat) then do;
		hoendtc=put(input(hoendat, date11.), yymmdd10.);
	end;
	if cmiss(hoendat) then do;
		hoenrtpt="ONGOING";
	end;
	if hoenrtpt="ONGOING" then
	hoentpt="END OF STUDY";
	horeas=horeas;
run;

/*Merge with DM dataset to get RFSTDTC and RFENDTC and corresponding study days.*/
proc sort data=hosp3 out=hosp4;
	by usubjid;
run;

proc sort data=dm out=dm2;
	by usubjid;
run;

data hosp5;
	merge hosp4(in=a) dm2;
	by usubjid;
	if a;
	rfstdt=input(rfstdtc, yymmdd10.);
	hostdt=input(hostdtc, yymmdd10.);
	hoendt=input(hoendtc, yymmdd10.);
	hostdy=hostdt-rfstdt+(hostdt>=rfstdt);
	hoendy=hoendt-rfstdt+(hoendt>=rfstdt);
run;

/*Process SE dataset to get the start and end dates of each epoch.*/
data se2;
	set se;
	if epoch="FOLLOW-UP" then epoch="FOLLOWUP";
run;

proc transpose data=se2 out=epochstart prefix=start_;
	by usubjid;
	id epoch;
	var sestdtc;
run;

proc transpose data=se2 out=epochend prefix=end_;
	by usubjid;
	id epoch;
	var seendtc;
run;

data epochdates;
	merge epochstart epochend;
	by usubjid;
run;

/*Compare each HOSTDTC date with the start and end dates for each EPOCH values to get epoch.*/
proc sort data=hosp5 out=hosp6;
	by usubjid;
run;

data ephosp;
	merge hosp6(in=a) epochdates;
	by usubjid;
	length epoch $40;
	if ~cmiss(hostdtc) and hostdtc le end_SCREENING and hostdtc ge start_SCREENING then
	epoch="SCREENING";
	else if hostdtc le end_TREATMENT and hostdtc ge start_TREATMENT then
	epoch="TREATMENT";
	else if hostdtc le end_FOLLOWUP and hostdtc ge start_FOLLOWUP then
	epoch="FOLLOW-UP";
run;

/*Derive HOSEQ by first sorting by unique sequence.*/
proc sort data=ephosp out=hosp7;
	by usubjid hoterm hostdtc hoendtc hospid;
run;

data hosp8;
	set hosp7;
	by usubjid hoterm hostdtc hoendtc hospid;
	if first.usubjid then hoseq=1;
	else hoseq+1;
run;

/*Invoke make_empty_Shell macro.*/
%make_empty_dataset(dataset=HO);


%let hovarlist=STUDYID DOMAIN USUBJID HOSEQ HOSPID HOTERM EPOCH HOSTDTC HOENDTC
HOSTDY HOENDY HOENRTPT HOENTPT HOREAS;
 
data HO(label='Healthcare Encounters');
   retain &hovarlist.;
   set empty_ho hosp8;
   keep &hovarlist.;
run;




