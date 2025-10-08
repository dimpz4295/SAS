data adverse;
	infile datalines dlm='|' dsd missover;
	input study: $7. pt: $4. aecat: $21. aevt: $19. prefdose: $1. aestdt_raw: $11. 
	aeendt_raw: $11. aesev: $8. aerel: $3. aeacn: $15. aeacnoth: $21. aeser: $3. 
	sdeath: $3. slife: $1. shosp: $3. sdisab: $1. scong: $1. smie: $1. aeout: $26. 
	hadmtdt_raw: $11. hadmttm_raw: $1. hdsdt_raw: $11. hdstm_raw: $1. aellt: $15. 
	aedecod: $20. aehlt: $1. aehlgt: $1. aebodsys: $47.;
	label study='Study Number' pt='Subject Identifier' aecat='Category' 
	aevt ='Verbatim Name' prefdose='Prior to First Dose?' aestdt_raw='Start Date'
	aeendt_raw ='End Date' aesev='Severity' aerel='Relationshitp to Study Drug?' 
	aeacn ='Action Taken with Study Drug' aeacnoth='Other Action Taken' 
	aeser='Serious Event?' sdeath='Event lead to Death?' slife='Life Threatening?' 
	shosp='Requires or Prolongs Hospitalization' sdisab='Disability?' 
	scong='Congenital Abnormality?' smie='Other Medically Important Event' 
	aeout='Outcome of Event' hadmtdt_raw='Admission Date' 
	hadmttm_raw='Admission Time' 	hdsdt_raw='Discharge Date' 
	hdstm_raw='Discharge Time' aellt='Lowest Level Term' aedecod='Dictionary-derived Term' 
	aehlt='High Level Term' aehlgt='High Level Group Term' aebodsys='Body System or Organ Class';
	format;
datalines4;
NCT0285|1001|General Adverse Event|nausea|Y|01/JAN/2010|01/JAN/2010|Mild|No|No action taken||No|||||||Recovered/Resolved|||||||||
NCT0285|1003|General Adverse Event|CARDIAC ARREST|Y|05/JAN/2010|05/JAN/2010|Severe|No|No action taken||Yes|Yes||||||FATAL|5/JAN/2010||5/JAN/2010||Cardiac arrest|Cardiac arrest|||Cardiac disorders
NCT0285|1004|General Adverse Event|nausea|Y|01/JAN/2010|01/JAN/2010|Mild|No|No action taken||No|||||||Recovered/Resolved|||||Nausea|Nausea|||Gastrointestinal disorders
NCT0285|1004|General Adverse Event|PAIN ABDOMINAL|Y|03/JAN/2010|07/JAN/2010|Mild|No|No action taken||No|||||||Recovered/Resolved|||||Pain abdominal|Abdominal pain|||Gastrointestinal disorders
NCT0285|1004|General Adverse Event|PAIN ABDOMINAL|N|08/JAN/2010|09/JAN/2010|Moderate|Yes|No action taken||No|||||||Recovered/Resolved|||||Pain abdominal|Abdominal pain|||Gastrointestinal disorders
NCT0285|1004|General Adverse Event|Neuropathy|N|10/JAN/2010||Severe|No|No action taken|||||||||Not Recovered/Not Resolved|||||Neuropathy|Neuropaty peripheral|||Nervous system disorders
NCT0285|1005|General Adverse Event|GALLSTONES|N|18/FEB/2010|21/FEB/2010|Mild|No|No action taken|Surgical Intervention|Yes|||Yes||||Recovered/Resolved|20/FEB/2020||20/FEB/2020||Gallstones|Cholelithiasis|||Hepatobiliary disorders
NCT0285|1006|General Adverse Event|MID LOWER BACK PAIN|N|UN/MAR/2010|25/MAR/2010|Mild|No|No action taken|||||||||Recovered/Resolved|||||Lower Back Pain|Back pain|||Musculoskeletal and connective tissue disorders
NCT0285|1007|General Adverse Event|DIARRHEA|N|9/MAY/2010|12/MAY/2010|Moderate|No|No action taken|||||||||Recovered/Resolved|||||Diarrhea|Diarrhea|||Gastrointestinal disorders
;;;;
run;

data dm;
	infile datalines dlm='|' dsd missover;
	input studyid : $20. domain: $2. usubjid: $20. subjid : $20. rfstdtc: $20. 
	rfendtc: $20. rfxstdtc:$20. rfxendtc: $20. rficdtc: $20. rfpendtc: $10. dthdtc: $20. 
	dthfl: $1. siteid: $20. age: best32. ageu: $5. sex: $6. race: $50. ethnic: $22. 
	armcd: $10. arm: $20. actarmcd: $10. actarm : $20. country:$3.;
	label studyid='Study Identifier' domain='Domain Abbreviation' 
	usubjid='Unique Subject Identifier' subjid='Subject Identifier for the Study' 
	rfstdtc='Subject Reference Start Date/Time' rfendtc=
	'Subject Reference End Date/Time' rfxstdtc='Date/Time of First Study Treatment' 
	rfxendtc='Date/Time of Last Study Treatment' rficdtc=
	'Date/Time of Informed Consent' rfpendtc='Date/Time of End of Participation' 
	dthdtc='Date/Time of Death' dthfl='Subject Death Flag' siteid=
	'Study Site Identifier' age='Age' ageu='Age Units' sex='Sex' race='Race' 
	ethnic='Ethnicity' armcd='Planned Arm Code' arm='Description of Planned Arm' 
	actarmcd='Actual Arm Code' actarm='Description of Actual Arm' country='Country';
	format;
datalines4;
NCT0285|DM|NCT0285-1001|1001|2010-01-01||||2010-01-01|2010-01-01|||10|35|YEARS|M|WHITE|HISPANIC OR LATINO|SCRNFAIL|Screen Failure|SCRNFAIL|Screen Failure|USA
NCT0285|DM|NCT0285-1002|1002|2010-01-01|2010-01-05|||2010-01-01|2010-01-05|||10|40|YEARS|F|MULTIPLE|NOT HISPANIC OR LATINO|NOTASSGN|Not Assigned|NOTASSGN|Not Assigned|USA
NCT0285|DM|NCT0285-1003|1003|2010-01-03|2010-01-05|||2010-01-01|2010-01-05|2010-01-05|Y|10|40|YEARS|M|OTHER|HISPANIC OR LATINO|PBO|Placebo|NOTTRT|Not Treated|USA
NCT0285|DM|NCT0285-1004|1004|2010-01-05|2010-02-28|2010-01-05T08:35|2010-01-25T08:45|2010-01-01|2010-02-28|||10|38|YEARS|M|WHITE|HISPANIC OR LATINO|ACTIVE|Active|ACTIVE|Active|USA
NCT0285|DM|NCT0285-1005|1005|2010-02-05||2010-02-05T08:46|2010-02-12T08:30|2010-01-15|2020-02-20|||10|64|YEARS|M|AMERICAN INDIAN OR ALASKA NATIVE|NOT HISPANIC OR LATINO|ACTIVE|Active|PBO|Placebo|USA
NCT0285|DM|NCT0285-1006|1006|2010-03-02|2010-03-25|2010-03-02T08:30|2010-03-10T08:30|2010-02-18|2010-03-25|||10|75|YEARS|F|NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER|NOT HISPANIC OR LATINO|PBO|Placebo|PBO|Placebo|USA
NCT0285|DM|NCT0285-1007|1007|2010-04-15|2010-06-12|2010-04-15T08:23|2010-05-06T08:12|2010-04-04|2010-06-12|||10|32|YEARS|M|UNKNOWN|NOT HISPANIC OR LATINO|PBO|Placebo|PBO|Placebo|USA
NCT0285|DM|NCT0285-1008|1008|2010-06-27|2010-08-18|2010-06-27T08:45|2010-07-11T09:20|2010-06-20|2010-08-18|||10|83|YEARS|F|NOT REPORTED|NOT HISPANIC OR LATINO|ACTIVE|Active|ACTIVE|Active|USA
;;;;
run;

data se;
	infile datalines dlm='|' dsd missover;
	input studyid : $20. domain: $2. usubjid: $20. seseq: best32. etcd: $10. 
	element: $40. taetord: best32. epoch: $40. sestdtc: $10. seendtc: $10. 
	sestdy: best32. seendy: best32.;
	label studyid='Study Identifier' domain='Domain Abbreviation' 
	usubjid='Unique Subject Identifier' seseq='Sequence Number' etcd='Element Code'
 	element='Description of Element' taetord='Planned Order of Element within Arm'
	epoch='Epoch' sestdtc='Start Date/Time of Element' 
	seendtc='End Date/Time of Element' sestdy='Study Day of Start of Element' 
	seendy='Study Day of End of Element';
	format;
datalines4;
NCT0285|SE|NCT0285-1001|1|SCR|Screening|1|SCREENING|2010-01-01|2010-01-01|1|1
NCT0285|SE|NCT0285-1002|1|SCR|Screening|1|SCREENING|2010-01-01|2010-01-05|1|5
NCT0285|SE|NCT0285-1003|1|SCR|Screening|1|SCREENING|2010-01-01|2010-01-05|-2|3
NCT0285|SE|NCT0285-1004|1|SCR|Screening|1|SCREENING|2010-01-01|2010-01-05|-4|1
NCT0285|SE|NCT0285-1004|2|ACTIVE|Active|2|TREATMENT|2010-01-05|2010-01-25|1|21
NCT0285|SE|NCT0285-1005|1|SCR|Screening|1|SCREENING|2010-01-15|2010-02-05|-21|1
NCT0285|SE|NCT0285-1005|2|ACTIVE|Active|2|TREATMENT|2010-02-05|2010-02-24|1|20
NCT0285|SE|NCT0285-1006|1|SCR|Screening|1|SCREENING|2010-02-18|2010-03-02|-12|1
NCT0285|SE|NCT0285-1006|2|PBO|Placebo|2|TREATMENT|2010-03-02|2010-03-25|1|24
NCT0285|SE|NCT0285-1007|1|SCR|Screening|1|SCREENING|2010-04-04|2010-04-15|-11|1
NCT0285|SE|NCT0285-1007|2|PBO|Placebo|2|TREATMENT|2010-04-15|2010-05-06|1|22
NCT0285|SE|NCT0285-1007|3|FUP|Follow-up|2|FOLLOW-UP|2010-05-06|2010-06-12|22|59
NCT0285|SE|NCT0285-1008|1|SCR|Screening|1|SCREENING|2010-06-20|2010-06-27|-7|1
NCT0285|SE|NCT0285-1008|2|ACTIVE|Active|2|TREATMENT|2010-06-27|2010-07-15|1|19
;;;;
run;
