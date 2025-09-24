/*Make all variables upper case. Set library name to nct0285.*/

options validvarname=upcase;
libname nct0285 "/home/u63567925/sasuser.v94/DimpleProj/nct0285";

*==============================================================================;
*Create SDTM program for Trial Arms (TA) Domain for Atezolizumb 
Effect on Non-small Cell Lung Cancer Trial;
*==============================================================================;
 
data ta;
    length studyid $10 domain $2 armcd $8 arm $40 taetord 8 etcd 
    $8 element $200 tabranch $200 tatrans $200 epoch $200;
 
/*Add Label Names to SDTM Variables.*/
    label studyid="Study Identifier" domain="Domain Abbreviation"
	armcd="Planned Arm Code" arm="Description of Planned Arm"
    taetord="Sequence of Element within Arm" etcd="Element Code"
    element="Description of Element" tabranch="Arm Branch Description"
    tatrans="Transition Rule" epoch="Epoch Associated with Element";

*------------------------------------------------------------------------------;
*Set variables for trial arm "AZB0168 300 mg Q2W" to denote Atezolizumab with a
biweekly dosage of 300 mg for 2 weeks.;
*------------------------------------------------------------------------------;
    studyid="NCT0285";
    domain="TA";
    armcd="AZB300";
    arm="AZB0168 300 mg Q2W";
 
/*Create observation rows for element 1: Screening for 1st trial arm with armcd=AZB300.*/
    taetord=1;
    etcd="SCRN";
    element="Screening";
    tabranch="Randomized to AZB0285 300 mg Q2W";
    tatrans="";
    epoch="SCREENING";
    output;

/*Reset variable values to missing for next element.*/  
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
/*Create observation rows for element 2: Treatment for 1st trial arm with armcd=AZB300.*/
    taetord=2;
    etcd="AZB300";
    element="AZB0285 300 mg Q2W";
    tabranch="";
    tatrans="";
    epoch="TREATMENT";
    output;
    
/*Reset variable values to missing for next element.*/
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
/*Create observation rows for element 3: Follow-up for 1st trial arm with armcd=AZB300.*/
    taetord=3;
    etcd="FU";
    element="Follow-up";
    tabranch="";
    tatrans="";
    epoch="FOLLOW-UP";
    output;
    
/*Reset variable values to missing for next element.*/  
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
*------------------------------------------------------------------------------;
*Set variables for 2nd trial arm "AZB0285 600 mg Q2W" to denote Cabozantinib;
* to denote biweekly dosage of 600 mg for 2 weeks.;
*------------------------------------------------------------------------------;
    armcd="AZB600";
    arm="AZB0285 600 mg Q2W";
 
/*Create observation rows for element 1: Screening for 2nd trial arm with armcd=AZB600.*/
    taetord=1;
    etcd="SCRN";
    element="Screening";
    tabranch="Randomized to AZB0285 600 mg Q2W";
    tatrans="";
    epoch="SCREENING";
    output;
   
/*Reset variable values to missing for next element.*/  
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);

/*Create observation rows for element 2: Treatment for 2nd trial arm with armcd=AZB600.*/
    taetord=2;
    etcd="AZB600";
    element="AZB0285 600 mg Q2W";
    tabranch="";
    tatrans="";
    epoch="TREATMENT";
    output;
    
/*Reset variable values to missing for next element.*/  
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
/*Create observation rows for element 3: Follow-up for 2nd trial arm with armcd=AZB600.*/
    taetord=3;
    etcd="FU";
    element="Follow-up";
    tabranch="";
    tatrans="";
    epoch="FOLLOW-UP";
    output;
    
/*Reset variable values to missing for next element.*/  
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
*------------------------------------------------------------------------------;
*Set variables for 3rd trial arm "PBO" to denote Placebo biweekly dosage of 600 mg 
for 2 weeks.;
*------------------------------------------------------------------------------;
    armcd="PBO";
    arm="Placebo Q2W";
 
/*Create observation rows for element 1: Screening for 3rd trial arm with armcd=PBO.*/
    taetord=1;
    etcd="SCRN";
    element="Screening";
    tabranch="Randomized to Placebo Q2W";
    tatrans="";
    epoch="SCREENING";
    output;
    
/*Reset variable values to missing for next element.*/     
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
/*Create observation rows for element 2: Treatment for 3rd trial arm with armcd=PBO.*/
    taetord=2;
    etcd="PBO";
    element="Placebo Q2W";
    tabranch="";
    tatrans="";
    epoch="TREATMENT";
    output;
    
/*Reset variable values to missing for next element.*/  
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
/*Create observation rows for element 3: Follow-up for 3rd trial arm with armcd=PBO.*/
    taetord=3;
    etcd="FU";
    element="Follow-up";
    tabranch="";
    tatrans="";
    epoch="FOLLOW-UP";
    output;
    
/*Reset variable values to missing for next element.*/  
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
run;
 
 