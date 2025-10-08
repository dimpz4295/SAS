/*Make all variables upper case. Set library name to nct0285.*/

options validvarname=upcase;
libname SDTMdata "/home/u63567925/sasuser.v94/DimpleProj/nct0285/SDTMdata";
libname nct0285 "/home/u63567925/sasuser.v94/DimpleProj/nct0285";

/*=========================================================
*Create SDTM program for Demographics (DM) Domain for Atezolizumab 
Effect on Non-small Cell Lung Cancer Trial;
=========================================================*/

/*Import raw data for enrollment, end of study, demography, & investigational product admin.*/
data demog01;
   set demog;
run;
 
/*IP administration raw data.*/ 
data ipadmin01;
   set ipadmin;
run;
 
/*End of Study raw data*/
data eos01;
   set eos;
run;
 
/*Enrollment raw data.*/
data enrl01;
   set enrlment;
run;
 
 
/*Create identifier variables like studyid, domain, subjid, siteid, usubjid.*/
data dm01;
   set demog(rename=(race=race0));
   length domain $2 studyid siteid usubjid subjid $20 race $50;
 
   studyid=study;
   domain="DM";
   subjid=pt;
   siteid=substrn(pt, 1, 2);
   usubjid=catx("-", study, pt);
 
/*Create record qualifier variables like ethnic, country, race, sex, & age.*/
   country=country;
   ethnic=upcase(ethnic);
 
   if cmiss(race0, race2, race3, race4) lt 3 then race="MULTIPLE";
   else race=upcase(coalescec(race0, race2, race3, race4));
 
   racesp=racesp;
   if race="MULTIPLE" then do;
      race1=upcase(race0);
      race2=upcase(race2);
      race3=upcase(race3);
      race4=upcase(race4);
   end;
 
   if not missing(age_raw) then age=input(age_raw, ??best.);

/*Create variable qualifier variable ageu.*/
   if not missing(age) then ageu=upcase(age_rawu);
 
   if sex="Female" then sex="F";
   else if sex="Male" then sex="M";
run;
 
/*=========================================================
Derive disposition related variables
=========================================================*/
 
/*Convert informed consent date, enrollment date, and randomization date, into ISO8601 format.*/
data rficdtc;
   set enrl01;
   length rficdtc enrldtc $20;
   if not missing(icdt_raw) then 
   rficdtc=put(input(icdt_raw, date11.), yymmdd10.);
   if not missing(enrldt_raw) then 
   enrldtc=put(input(enrldt_raw, date11.), yymmdd10.);
   if not missing(randdt_raw) then 
   randdtc=put(input(randdt_raw, date11.), yymmdd10.);
   keep study pt rficdtc enrldtc randdtc;
run;
 
/*----------------------------------------------------------
Reference End Date
----------------------------------------------------------*/

/*Create reference end date rfendtc based on date for end of study & convert to ISO8601 format.*/
data rfendtc;
   set eos01;
   where eoscat="End of Study";
   length rfendtc $20;
   if not missing(eostdt_raw) then 
   rfendtc=put(input(eostdt_raw, date11.), yymmdd10.);
   keep study pt rfendtc;
run;
 
/*----------------------------------------------------------
Death Date
----------------------------------------------------------*/

/*Create reference end date rfendtc based on end of study data where eoterm is "Death" & convert to ISO8601 format.*/
data dthdtc;
   set eos01;
   where eoscat="End of Study" and eoterm="Death";
   length dthdtc $20;
   if not missing(eostdt_raw) then 
   dthdtc=put(input(eostdt_raw, date11.), yymmdd10.);
   dthfl="Y";
   keep study pt dthdtc dthfl;
run;
 
/*=========================================================
Get Exposure Related Variables
=========================================================*/

/*Use investigational product administration raw data to determine drug
exposure time and day related data (and convert to ISO8601 format).*/
data exp01;
   set ipadmin01;
   if input(ipqty_raw,?? best.) gt 0;
   length tempdtc $20;
   if length(ipsttm_raw) ge 4 then time=input(ipsttm_raw, time5.);
   if time ne . then timec=put(time, tod6.);
   if not missing(ipstdt_raw) and not missing(timec) then 
   tempdtc=put(input(ipstdt_raw, date11.), yymmdd10.)||"T"||
   strip(timec);
   else if not missing(ipstdt_raw) then 
   tempdtc=put(input(ipstdt_raw, date11.), yymmdd10.);
   keep study pt tempdtc ipboxid;
run;
 
proc sort data=exp01;
   by study pt tempdtc;
run;
 
/*----------------------------------------------------------
Date/Time of First Study Treatment 
Date/Time of Last Study Treatment
----------------------------------------------------------*/

/*Divide the exposure-related data into 2 datasets: 1 with
the  reference start date as related to first drug exposure
for each patient, 2nd with the reference end date as related to the
last drug exposure date for each patient.*/
data rfxstdtc(rename=(tempdtc=rfxstdtc))
   rfxendtc(rename=(tempdtc=rfxendtc) drop=ipboxid);
   set exp01;
   by study pt tempdtc;
   if first.pt then output rfxstdtc;
   if last.pt then output rfxendtc;
run;
 
/*=========================================================
Derive Planned and Actual Arm related variables
=========================================================*/
 
/*----------------------------------------------------------
Planned Arm
----------------------------------------------------------*/
/*Keep all patients who were randomized to a planned treatment arm 
/*from the raw enrollment data.*/
data randno;
   set enrl01;
   where randno ne "";
   keep study pt randno;
run;
 
proc sort data=randno;
   by randno;
run;

/*Explicate treatment arm based on planned arm code, armcd.*/ 
data rand01;
   set rand;
   length randno $6 armcd arm $10;
   armcd=tx_cd;
   randno=rand_id;
   if armcd="ACTIVE" then arm="Active";
   else if armcd="PBO" then arm="Placebo";
   keep armcd arm randno;
run;
 
proc sort data=rand01;
   by randno;
run;

/*Merge back planned treatment arm dataset with randomization raw dataset.*/ 
data armcd;
   merge randno(in=a) rand01;
   by randno;
   if a;
   keep study pt armcd arm;
run;
 
proc sort data=armcd;
   by study pt;
run;

/*----------------------------------------------------------
Derive Actual Arm related variables
----------------------------------------------------------*/

/*Sort reference start date data set in relation to the first drug exposure
by ipboxid, a drug kit identifier.*/
proc sort data=rfxstdtc out=actarmcd01;
   by ipboxid;
run;

/*Based on ipboxid, investigational product box identifier, the actual
arms & actual arm codes for active vs placebo treatment are assigned.*/ 
data box01;
   set box;
   length ipboxid $8 actarmcd actarm $10;
   ipboxid=kitid;
   if content="ACTIVE" then do;
      actarmcd="ACTIVE";
      actarm="Active";
   end;
   else if content="PBO" then do;
      actarmcd="PBO";
      actarm="Placebo";
   end;
run;
 
proc sort data=box01;
   by ipboxid;
run;
 
/*Merge back actual treatment arm dataset with assigned investigational product box identifier dataset.*/ 
data actarmcd;
   merge actarmcd01(in=a) box01(in=b);
   by ipboxid;
   if a;
   keep study pt actarmcd actarm;
run;
 
proc sort data=actarmcd;
   by study pt;
run;
 
/*=========================================================
Derive RFPENDTC
=========================================================*/
 

/*Combine the raw datasets with atleast one date variable in it and rename the date variables to a common name, date.*/
data alldates01;
   length date $20;
   set adverse(rename=(aestdt_raw=date) keep=study pt aestdt_raw)
       adverse(rename=(aeendt_raw=date) keep=study pt aeendt_raw)
       adverse(rename=(hadmtdt_raw=date) keep=study pt hadmtdt_raw)
       adverse(rename=(hdsdt_raw=date) keep=study pt hdsdt_raw)
       conmeds(rename=(cmstdt_raw=date) keep=study pt cmstdt_raw)
       conmeds(rename=(cmendt_raw=date) keep=study pt cmendt_raw)
       ecg(rename=(egdt_raw=date) keep=study pt egdt_raw)
       enrlment(rename=(icdt_raw=date) keep=study pt icdt_raw)
       enrlment(rename=(enrldt_raw=date) keep=study pt enrldt_raw)
       enrlment(rename=(randdt_raw=date) keep=study pt randdt_raw)
       eos(rename=(eostdt_raw=date) keep=study pt eostdt_raw)
       eoip(rename=(eostdt_raw=date) keep=study pt eostdt_raw)
       eq5d3l(rename=(dt_raw=date) keep=study pt dt_raw)
       hosp(rename=(stdt_raw=date) keep=study pt stdt_raw)
       hosp(rename=(endt_raw=date) keep=study pt endt_raw)
       ipadmin(rename=(ipstdt_raw=date) keep=study pt ipstdt_raw)
       lab_chem(rename=(lbdt_raw=date) keep=study pt lbdt_raw)
       lab_hema(rename=(lbdt_raw=date) keep=study pt lbdt_raw)
       physmeas(rename=(pmdt_raw=date) keep=study pt pmdt_raw)
       surg(rename=(surgdt_raw=date) keep=study pt surgdt_raw)
       vitals(rename=(vsdt_raw=date) keep=study pt vsdt_raw);
run;
 

/*Convert all dates into ISO8601 format*/
data alldates02;
   set alldates01;
   length day month year datec $10;
   day=scan(date, 1, '/');
   month=upcase(scan(date, 2, '/'));
   year=scan(date, 3, '/');
   if month="JAN" then month="01";
   else if month="FEB" then month="02";
   else if month="MAR" then month="03";
   else if month="APR" then month="04";
   else if month="MAY" then month="05";
   else if month="JUN" then month="06";
   else if month="JUL" then month="07";
   else if month="AUG" then month="08";
   else if month="SEP" then month="09";
   else if month="OCT" then month="10";
   else if month="NOV" then month="11";
   else if month="DEC" then month="12";
   else month="-";

   dayn=input(day,??best.);
   yearn=input(year,??best.);
   if dayn ne . then dayc=put(dayn,z2.);
   else dayc="-";
   if yearn ne . then yearc=put(year,4.);
   else yearc="-";
   datec=strip(yearc)||"-"||strip(month)||"-"||strip(dayc);
   if compress(datec, "-")="" then datec="";
 
run;
 

/*Pick the latest non-missing date for each subject.*/
proc sort data=alldates02 out=alldates03;
   by study pt datec;
   where datec ne "";
run;

/*Assign the latest non-missing date for each subject as RFPENDTC, or date/time
/* participant ended participation in the trial.*/ 
data rfpendtc;
   set alldates03;
   by study pt datec;
   if last.pt;
   rfpendtc=datec;
   keep study pt rfpendtc;
run;
 

/*Merge horizontally 9 datasets by study and patient: dm01, rficdtc, dthdtc, rfendtc, rfxstdtc,
rfxendtc, armcd, actarmcd, rfpendtc, to gain all needed DM date and time variables.*/
data dm02;
   merge dm01(in=a)
         rficdtc
         dthdtc
         rfendtc
         rfxstdtc
         rfxendtc
         armcd
         actarmcd
         rfpendtc
         ;
   by study pt;
   if a;
run;
 

/*Derive additional actual/planned arm and arm code for "Screen Failure", "Not Assigned", "Not Treated".*/
data dm03;
   length arm actarm $20;
   set dm02;
   rfstdtc=substrn(rfxstdtc,1,10);
   if rfstdtc="" and randdtc ne "" then rfstdtc=randdtc;
   else if rfstdtc="" and randdtc="" then rfstdtc=rficdtc;
   if armcd="" and enrldtc="" then do;
      armcd="SCRNFAIL";
      arm="Screen Failure";
      actarmcd=armcd;
      actarm=arm;
   end;
   else if armcd="" and  enrldtc ne "" and randdtc="" then do;
      armcd="NOTASSGN";
      arm="Not Assigned";
      actarmcd=armcd;
      actarm=arm;
   end;
   else if armcd ne "" and randdtc ne "" and rfxstdtc="" then do;
      actarmcd="NOTTRT";
      actarm="Not Treated";
   end;
run;
 
%make_empty_dataset(dataset=DM);

data dm04;
	set empty_dm dm03;
run;
/*=========================================================
Write attributes and keep only required variables and in the required order for DM dataset.
=========================================================*/
 
/*%let varlist=studyid domain  usubjid subjid  rfstdtc rfendtc rfxstdtc 
rfxendtc rficdtc rfpendtc dthdtc dthfl siteid age ageu sex race ethnic
armcd arm actarmcd actarm country race1 race2 race3 race4 racesp;
data dm04;
attrib studyid label='Study Identifier'
         domain label='Domain Abbreviation'
         usubjid label='Unique Subject Identifier'
         subjid label='Subject Identifier for the Study'
         rfstdtc label='Subject Reference Start Date/Time'
         rfendtc label='Subject Reference End Date/Time'
         rfxstdtc label='Date/Time of First Study Treatment'
         rfxendtc label='Date/Time of Last Study Treatment'
         rficdtc label='Date/Time of Informed Consent'
         rfpendtc label='Date/Time of End of Participation'
         dthdc label='Date/Time of Death'
         dthfl label='Subject Death Flag'
         siteid label='Study Site Identifier'
         brthdtc label='Date/Time of Birth'
         age label='Age'
         ageu label='Age Units'
         sex label='Sex'
         race label='Race'
         ethnic label='Ethnicity'
         armcd label='Planned Arm Code'
         arm label='Description of Planned Arm'
         actarmcd label='Actual Arm Code'
         actarm label='Description of Actual Arm'
         country label='Country'
         race1 label='Race 1'
         race2 label='Race 2'
         race3 label='Race 3'
         race4 label='Race 4'
         racesp label='Race Other Specify';
   	set dm03;
	keep &varlist.;
run;
 
/*=========================================================
Create supplmentary domain
=========================================================*/
 

/* Transpose the DM dataset's non-parent domain variables in
macro variable &suppquallist. by studyid and usubjid. Rename
transposed columns as qal & new column is named qnam with qlabel label.*/
 
%let suppquallist=race1 race2 race3 race4 racesp;
proc sort data=dm04 out=suppdm01;
   by usubjid;
run;
 
proc transpose data=suppdm01 out=suppdm02(rename=(col1=qval) 
where=(qval ne "")) name=qnam label=qlabel;
   by studyid usubjid;
   var &suppquallist.;
run;
 
/*=========================================================
Write attributes and keep only required variables and in the required order for suppdm dataset.
=========================================================*/
data suppdm03;
   attrib studyid label='Study Identifier'
      rdomain label='Related Domain Abbreviation'
      usubjid label='Unique Subject Identifier'
      idvar label='Identifying Variable'
      idvarval label='Identifying Variable Value'
      qnam label='Qualifier Variable Name'
      qlabel label='Qualifier Variable Label'
      qval label='Data Value';
   retain studyid rdomain usubjid idvar idvarval qnam qlabel qval;
   set suppdm02;
   idvar="";
   idvarval="";
   rdomain="DM";
run;
 
/*=========================================================
Save final copies of the datasets with dataset labels
=========================================================*/
 
options validvarname=v7;
proc sort data=dm04 out=nct0285.DM(label="Demographics" 
drop=&suppquallist.);
   by usubjid;
run;
 
proc sort data=suppdm03 out=nct0285.SUPPDM(label="Supplemental Qualifiers for Demographics");
   by usubjid idvar idvarval;
run;
 
/*=========================================================
Create xpt files
=========================================================*/
 
/* %let xptpath=%sysfunc(pathname(osCSG001))\xpt\; */
/*   */
/* libname dm xport "&xptpath.\dm.xpt"; */
/*   */
/* proc copy in=osCSG001 out=dm; */
/*    select dm; */
/* run; */
/*   */
/* libname suppdm xport "&xptpath.\suppdm.xpt"; */
/*   */
/* proc copy in=osCSG001 out=suppdm; */
/*    select suppdm; */
/* run; */
/*   */
/* libname dm; */
/* libname suppdm; */
/*   */
/*   */