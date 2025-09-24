/*Make all variables upper case. Set library name to nct0285.*/

libname nct0285 "/home/u63567925/sasuser.v94/0mycsg/nct0285"; 
options validvarname=upcase;

*==============================================================================;
*Create SDTM program for Trial Summary (TS) Domain for Atezolizumb 
Effect on Non-small Cell Lung Cancer Trial;
*==============================================================================;
 
data tv;
    length studyid $10 domain $2 visitnum 8 visit $50 visitdy 8 
    armcd $8 arm $40 tvstrl tvenrl $200;
    label studyid="Study Identifier" domain="Domain Abbreviation" visitnum="Visit Number" 
    visit="Visit Name" visitdy="Planned Study Day of Visit" armcd="Planned Arm Code" 
    arm="Planned Arm Description" tvstrl="Visit Start Rule" tvenrl="Visit End Rule";
    armcd="";
    arm="";

/*Set TV variables for visit number 1 during screening epoch.*/
    visitnum=1;
    visit="Visit 1";
    visitdy=-14;
    tvstrl="Start of screening epoch";
    tvenrl="End of all screening procedures";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(visitnum, visit, visitdy, tvstrl, tvenrl);

/*Set TV variables for visit number 2 during treatment epoch.*/ 
    visitnum=2;
    visit="Visit 2";
    visitdy=1;
    tvstrl="Start of treatment epoch";
    tvenrl="";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(visitnum, visit, visitdy, tvstrl, tvenrl);

/*Set TV variables for visit number 3 for 2 weeks after start of treatment epoch.*/  
    visitnum=3;
    visit="Visit 2";
    visitdy=15;
    tvstrl="2 Weeks after start of treatment";
    tvenrl="";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(visitnum, visit, visitdy, tvstrl, tvenrl);

/*Set TV variables for visit number 4 for 4 weeks after start of treatment epoch.*/   
    visitnum=4;
    visit="Visit 4";
    visitdy=29;
    tvstrl="4 Weeks after start of treatment";
    tvenrl="";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(visitnum, visit, visitdy, tvstrl, tvenrl);

/*Set TV variables for visit number 5 for 6 weeks after start of treatment epoch.*/    
    visitnum=5;
    visit="Visit 5";
    visitdy=43;
    tvstrl="6 Weeks after start of treatment";
    tvenrl="";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(visitnum, visit, visitdy, tvstrl, tvenrl);

/*Set TV variables for visit number 6 for 8 weeks after start of treatment epoch.*/     
    visitnum=6;
    visit="Visit 6";
    visitdy=57;
    tvstrl="8 Weeks after start of treatment";
    tvenrl="";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(visitnum, visit, visitdy, tvstrl, tvenrl);

/*Set TV variables for visit number 7 for 10 weeks after start of treatment epoch.*/      
    visitnum=7;
    visit="Visit 7";
    visitdy=71;
    tvstrl="10 Weeks after start of treatment";
    tvenrl="";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
	call missing(visitnum, visit, visitdy, tvstrl, tvenrl);

/*Set TV variables for visit number 8 for 12 weeks after start of treatment epoch.*/      
    visitnum=8;
    visit="Visit 8";
    visitdy=85;
    tvstrl="12 Weeks after start of treatment";
    tvenrl="";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(visitnum, visit, visitdy, tvstrl, tvenrl);

/*Set TV variables for visit number 9 for 3 weeks after end of treatment epoch.*/       
    visitnum=9;
    visit="Visit 9";
    visitdy=106;
    tvstrl="3 Weeks after end of treatment";
    tvenrl="";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(visitnum, visit, visitdy, tvstrl, tvenrl);
run;
 
 