data dm;
	infile datalines dlm='|' dsd missover;
	input studyid : $5. domain : $2. usubjid : $10. subjid: $4. rfstdtc:
	 $10. rfendtc : $10. sex : $1.;
	label studyid='STUDYID' domain='DOMAIN' usubjid='USUBJID' 
	subjid='SUBJID' rfstdtc='RFSTDTC' rfendtc='RFENDTC' sex='SEX';
	format;
datalines4;
NCT0285|DM|NCT0285-1001|1001|2010-01-15|2010-01-30|F
NCT0285|DM|NCT0285-2003|2003|2010-02-03|2010-02-10|F
NCT0285|DM|NCT0285-3010|3010|2010-01-15|2010-01-08|M
;;;;
run;

data se;
	infile datalines dlm='|' dsd missover;
	input studyid : $5. domain : $2. usubjid : $10. seseq : best. 
	etcd : $4. element : $9. taetord : best. epoch : $9. sestdtc : $10. 
	seendtc : $10. seupdes : $1.;
	label studyid='STUDYID' domain='DOMAIN' usubjid='USUBJID' 
	seseq='SESEQ' etcd ='ETCD' element='ELEMENT' taetord='TAETORD' 
	epoch='EPOCH' sestdtc='SESTDTC' seendtc='SEENDTC' 
	seupdes='SEUPDES';
format ;
datalines4;
NCT0285|SE|NCT0285-1001|1|SCRN|SCREENING|1|SCREENING|2010-01-03|2010-01-15|
NCT0285|SE|NCT0285-1001|2|ACT|ACTIVE|2|TREATMENT|2010-01-15|2010-01-25|
NCT0285|SE|NCT0285-1001|3|FU|FOLLOW-UP|3|FOLLOW-UP|2010-01-25|2010-01-30|
NCT0285|SE|NCT0285-2003|1|SCRN|SCREENING|1|SCREENING|2010-01-27|2010-02-03|
NCT0285|SE|NCT0285-2003|2|ACT|ACTIVE|2|TREATMENT|2010-02-03|2010-02-10|
;;;;
run;

data hosp;
	infile datalines dlm='|' dsd missover;
	input project: $5. subject: $4. folderseq: best. foldername: $15. 
	recordposition: best. hostdat: $11. hoendat: $11. horeas: $24. 
	hounit: $14.;
	label project ='project' subject ='subject' folderseq='folderseq' 
	foldername ='foldername' recordposition ='recordposition' 
	hostdat='HOSTDAT' hoendat='HOENDAT' horeas='HOREAS' hounit='HOUNIT';
	format;
datalines4;
NCT0285|1001|900|Hospitalization|0|20/JAN/2010|20/JAN/2010|Adverse Event|Emergency Room
NCT0285|1001|900|Hospitalization|1|20/JAN/2010|23/JAN/2010|Adverse Event|General Ward
NCT0285|2003|900|Hospitalization|0|10/FEB/2010||Normal Clinical Practice|General Ward
;;;;
run;
