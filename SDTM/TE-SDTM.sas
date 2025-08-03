/*Make all variables upper case. Set library name to NCT0168.*/

options validvarname=upcase;
libname nct0168 "/home/u63567925/sasuser.v94/DimpleProj/NCT0168";

*==============================================================================;
*Create SDTM program for Trial Arms (TA) Domain for Cabozantinib Effect on; 
*Prostate Cancer Trial;
*==============================================================================;
 
data NCT0168.te;

/*Add Label Names to SDTM Variables.*/
    length tudyid $10 domain $2 etcd $8 element $200 testrl  $200 teenrl 
    $200 tedur $10; 

/*Add Label Names to SDTM Variables.*/
    label studyid="Study Identifier" domain="Domain Abbreviation" etcd="Element Code" 
    element="Description of Element" testrl="Start Rule for Element" teenrl="End Rule for Element"
    tedur="Planned Duration of Element";
 
*------------------------------------------------------------------------------;
*Set variables for studyid & domain.
*------------------------------------------------------------------------------;
    studyid="NCT0168";
    domain="TE";
 
*------------------------------------------------------------------------------;
*Set variables for trial element: screening.
*------------------------------------------------------------------------------;
    etcd="SCRN";
    element="Screening";
    testrl="Informed consent";
    teenrl="Screening assessments are complete; up to 4 Weeks after start of the element";
    tedur="P4W";
    output;

/*Reset variable values to missing for next element.*/      
    call missing(etcd, element, testrl, teenrl, tedur);

*------------------------------------------------------------------------------;
*Set variables for trial element: CAB0168 300 mg Q2W.
*------------------------------------------------------------------------------;
    etcd="CAB300";
    element="CAB0168 300 mg Q2W";
    testrl="First dose of CAB0168, where dose is 300 mg";
    teenrl="12 Weeks after start of the element";
    tedur="P12W";
    output;

/*Reset variable values to missing for next element.*/  
    call missing(etcd, element, testrl, teenrl, tedur);
 
*------------------------------------------------------------------------------;
*Set variables for trial element: CAB0168 600 mg Q2W.
*------------------------------------------------------------------------------;
    etcd="cab600";
    element="CAB0168 600 mg Q2W";
    testrl="First dose of CAB0168, where dose is 600 mg";
    teenrl="12 Weeks after start of the element";
    tedur="P12W";
    output;

/*Reset variable values to missing for next element.*/  
    call missing(etcd, element, testrl, teenrl, tedur);
 
*------------------------------------------------------------------------------;
*Set variables for trial element: Placebo Q2W
*------------------------------------------------------------------------------;
    etcd="PBO";
    element="Placebo Q2W";
    testrl="First dose of placebo";
    teenrl="12 Weeks after start of the element";
    tedur="P12W";
    output;
    
/*Reset variable values to missing for next element.*/   
    call missing(etcd, element, testrl, teenrl, tedur);
 
*------------------------------------------------------------------------------;
*Set variables for trial element: Follow-up.
*------------------------------------------------------------------------------;
    etcd="FU";
    element="Follow-up";
    testrl="One day after last dose of study drug";
    teenrl="3 Weeks after start of the element";
    tedur="P3W";
    output;
    
/*Reset variable values to missing for next element.*/  
    call missing(etcd, element, testrl, teenrl, tedur);
 
run;