/*Make all variables upper case. Set library name to NCT0168.*/

options validvarname=upcase;
libname NCT0168 "/home/u63567925/sasuser.v94/DimpleProj/NCT0168";

/*Create SDTM program for Trial Arms (TA) Domain for Cabozantinib Effect on 
Prostate Cancer Trial*/

data NCT0168.ta;
    length studyid $10 domain $2 armcd $8 arm $40 taetord 8 etcd 
    $8 element $200 tabranch $200 tatrans $200 epoch $200;
 
/*Add Label Names to SDTM Variables.*/
    label studyid="Study Identifier" domain="Domain Abbreviation"
	armcd="Planned Arm Code" arm="Description of Planned Arm"
    taetord="Sequence of Element within Arm" etcd="Element Code"
    element="Description of Element" tabranch="Arm Branch Description"
    tatrans="Transition Rule" epoch="Epoch Associated with Element";

*------------------------------------------------------------------------------;
*Set variables for trial arm "CAB0168 300 mg Q2W" to denote Cabozantinib with;
*biweekly dosage of 300 mg for 2 weeks.;
*------------------------------------------------------------------------------;
    studyid="NCT0168";
    domain="TA";
    armcd="CAB300";
    arm="CAB0168 300 mg Q2W";
 
/*Create observation rows for element 1: Screening for 1st trial arm with armcd=CAB300.*/
    taetord=1;
    etcd="SCRN";
    element="Screening";
    tabranch="Randomized to CAB0168 300 mg Q2W";
    tatrans="";
    epoch="SCREENING";
    output;

/*Reset variable values to missing for next element.*/  
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
/*Create observation rows for element 2: Treatment for 1st trial arm with armcd=CAB300.*/
    taetord=2;
    etcd="CAB300";
    element="CAB0168 300 mg Q2W";
    tabranch="";
    tatrans="";
    epoch="TREATMENT";
    output;
    
/*Reset variable values to missing for next element.*/
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
/*Create observation rows for element 3: Follow-up for 1st trial arm with armcd=CAB300.*/
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
*Set variables for 2nd trial arm "CAB0168 600 mg Q2W" to denote Cabozantinib;
* to denote biweekly dosage of 600 mg for 2 weeks.;
*------------------------------------------------------------------------------;
    armcd="CAB600";
    arm="CAB0168 600 mg Q2W";
 
/*Create observation rows for element 1: Screening for 2nd trial arm with armcd=CAB600.*/
    taetord=1;
    etcd="SCRN";
    element="Screening";
    tabranch="Randomized to CAB0168 600 mg Q2W";
    tatrans="";
    epoch="SCREENING";
    output;
   
/*Reset variable values to missing for next element.*/  
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);

/*Create observation rows for element 2: Treatment for 2nd trial arm with armcd=CAB600.*/
    taetord=2;
    etcd="CAB600";
    element="CAB0168 600 mg Q2W";
    tabranch="";
    tatrans="";
    epoch="TREATMENT";
    output;
    
/*Reset variable values to missing for next element.*/  
    call missing(taetord, etcd, element, tabranch, tatrans, epoch);
 
/*Create observation rows for element 3: Follow-up for 2nd trial arm with armcd=CAB600.*/
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
*Set variables for 3rd trial arm "PBO" to denote Placebo;
*biweekly dosage of 600 mg for 2 weeks.;
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
 
 