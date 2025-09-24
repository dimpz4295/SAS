/*Make all variables upper case. Set library name to nct0285.*/
libname nct0285 "/home/u63567925/sasuser.v94/0mycsg/nct0285"; 
options validvarname=upcase;

*==============================================================================;
*Create SDTM program for Trial Summary (TS) Domain for  
Effect on Non-small Cell Lung Cancer Trial;
*==============================================================================;
 
data ts; 
	length studyid $10 domain $2 tsseq 8 tsparmcd $8 tsparm $200 tsval $200 tsvcdref $100 tsvcdver $20;
	label studyid="Study Identifier" domain="Domain Abbreviation" tsseq="Sequence Number" 
	tsparmcd="Trial Summary Parameter Short Name" tsparm="Trial Summary Parameter" 
	tsval="Parameter Value" tsvcdref="Value Reference" tsvcdver="Version of the Value Reference";
	
*------------------------------------------------------------------------------;
*Set variables for studyid & domain.
*------------------------------------------------------------------------------;
	studyid="NCT0285"; 
	domain="TS"; 

*------------------------------------------------------------------------------;
*Set variables for Trial summary parameter denoting Placebo.
*------------------------------------------------------------------------------;	
	tsseq=1; 
	tsparmcd="TCNTRL"; 
	tsparm="Control Type"; 
	tsval="Placebo"; 
	tsvalcd="C49648";
	tsvcdref="CDISC CT"; 
	tsvcdver="2025-03-28";
	output;
/*Reset variable values to missing for next trial summary parameter.*/  
	call missing(tsseq, tsparmcd, tsparm, tsval, tsvcdef, tsvcdver);

*------------------------------------------------------------------------------;
*Set variables for Trial summary parameter denoting Investigational Therapy/Treatment.
*------------------------------------------------------------------------------;	
	tsseq=1; 
	tsparmcd="TRT"; 
	tsparm="Investigational Therapy or Treatment"; 
	tsval="Atezolizumb"; 
	tsvalcd="52CMI0WC3Y";
	tsvcdref="UNII"; 
	tsvcdver="";
	output;
/*Reset variable values to missing for next trial summary parameter.*/  
	call missing(tsseq, tsparmcd, tsparm, tsval, tsvcdef, tsvcdver);
		
*------------------------------------------------------------------------------;
*Set variables for Trial summary parameter denoting Sponsor.
*------------------------------------------------------------------------------;	
	tsseq=1; 
	tsparmcd="SPONSOR"; 
	tsparm="Clinical Study Sponsor"; 
	tsval="Genentech, Inc."; 
	tsvalcd="0801290006";
	tsvcdref="D-U-N-S NUMBER"; 
	tsvcdver="";
	output;
/*Reset variable values to missing for next trial summary parameter.*/  
	call missing(tsseq, tsparmcd, tsparm, tsval, tsvcdef, tsvcdver);
	
*------------------------------------------------------------------------------;
*Set variables for Trial summary parameter denoting Study Title.
*------------------------------------------------------------------------------;		
	tsseq=1; 
	tsparmcd="TITLE"; 
	tsparm="Trial Title"; 
	tsval="A Phase II Single-Arm Study Of Atezolizumabmonotherapy In Locally Advanced Or 
	Metastatic non-Small Cell Lung Cancer: Clinical Evaluation Ofnovel Blood-Based Diagnostics"; 
	tsvalcd="";
	tsvcdref=""; 
	tsvcdver="";
	output;
/*Reset variable values to missing for next trial summary parameter.*/  
	call missing(tsseq, tsparmcd, tsparm, tsval, tsvcdef, tsvcdver);
	
*------------------------------------------------------------------------------;
*Set variables for Trial summary parameter denoting Trial Disease.
*------------------------------------------------------------------------------;		
	tsseq=1; 
	tsparmcd="INDIC"; 
	tsparm="Trial Disease/Condition Indication"; 
	tsval="Non-Small Cell Lung Cancer"; 
	tsvalcd="254637007"
	tsvcdref="SNOMED"; 
	tsvcdver="2025-08-31"
	output;
/*Reset variable values to missing for next trial summary parameter.*/  
	call missing(tsseq, tsparmcd, tsparm, tsval, tsvcdef, tsvcdver);
	
*------------------------------------------------------------------------------;
*Set variables for Trial summary parameter denoting Trial Phase.
*------------------------------------------------------------------------------;		
	tsseq=1; 
	tsparmcd="TPHASE"; 
	tsparm="Trial Phase Classification"; 
	tsval="Phase II Trial"; 
	tsvalcd="C15601"
	tsvcdref="CDISC CT"; 
	tsvcdver="2025-03-28";
	output;
/*Reset variable values to missing for next trial summary parameter.*/  
	call missing(tsseq, tsparmcd, tsparm, tsval, tsvcdef, tsvcdver);

run;


