/*Make all variables upper case. Set library name to nct0285.*/

options validvarname=upcase;
libname nct0285 "/home/u63567925/sasuser.v94/DimpleProj/nct0285";

*==============================================================================;
*Create SDTM program for Trial Inclusion/Exclusion Criteria (TI) Domain for Atezolizumb 
Effect on Non-small Cell Lung Cancer Trial;
*==============================================================================;
 
data ti;
    length studyid $10 domain $2 ietestcd $8 ietest $200 iecat $10
    tivers $10;
    label studyid  ="Study Identifier" domain="Domain Abbreviation" 
    ietestcd="IE Test Short Name" ietest="IE Test Description" iecat="IE Category" 
    tivers="Protocol Criteria Versions";
     
*------------------------------------------------------------------------------;
*Set identifier variables.;
*------------------------------------------------------------------------------;    
    studyid="nct0285";
    domain="TI";
    tivers="Version 1";
 
*------------------------------------------------------------------------------;
*Set IE test short name & IE test description & IE category for Inclusion criteria;
*------------------------------------------------------------------------------;
 
    iecat="INCLUSION";
 
    ietestcd="INCL01";
    ietest="Female and male patients 18-70 (inclusive) years of age";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(ietestcd, ietest);
 
    ietestcd="INCL02";
    ietest="Histologically or cytologically confirmed Stage III/IV NSCLC";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(ietestcd, ietest);
 
    ietestcd="INCL03";
    ietest="The patient is able and willing to comply with the requirements 
    of this trial protocol";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(ietestcd, ietest);
 
*------------------------------------------------------------------------------;
*Set IE test short name & IE test description & IE category for Inclusion criteria;
*------------------------------------------------------------------------------;
 
    iecat="EXCLUSION";
 
    ietestcd="EXCL01";
    ietest="Pregnant or breastfeeding women";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(ietestcd, ietest);
 
    ietestcd="EXCL02";
    ietest="Prior treatment with immunotherapy for any stage NSCLC";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(ietestcd, ietest);
 
    ietestcd="EXCL03";
    ietest="Allergies to any component of NCT0285";
    output;
/*Reset variable values to missing for next inclusion/exclusion criteria.*/  
    call missing(ietestcd, ietest);
 
run;
 
 