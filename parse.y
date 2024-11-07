%{
#include<stdio.h>
#include<stdlib.h>
void yyerror(const char * e);
int yylex();

extern char * label;
extern char * value;

int loc = 0;
%}

%token SEC_DATA SEC_BSS SEC_TEXT LABEL VALUE DB_TYPE DW_TYPE DD_TYPE DQ_TYPE DT_TYPE  NEWLINE RESB_TYPE RESW_TYPE RESD_TYPE RESQ_TYPE REST_TYPE


%start lines

%%

lines: line
	|
	;

line: data_sec line 
	| bss_sec line
	|
	;

data_sec: SEC_DATA NEWLINE {puts("section .data");loc=0;}data_lines
	;

data_lines: data_line NEWLINE data_lines
	| NEWLINE data_lines
	|
	;

data_line: LABEL DB_TYPE VALUE {printf("%08X\t %s db %s\n",loc,label,value); loc += 1;}
	|  LABEL DW_TYPE VALUE {printf("%08x\t %s dw %s\n",loc,label,value); loc += 2;}
	|  LABEL DD_TYPE VALUE {printf("%08x\t %s dd %s\n",loc,label,value); loc += 4;}
	|  LABEL DQ_TYPE VALUE {printf("%08x\t %s dq %s\n",loc,label,value); loc += 8;}
	|  LABEL DT_TYPE VALUE {printf("%08x\t %s dt %s\n",loc,label,value); loc += 10;}
	;
bss_sec: SEC_BSS {puts("section .bss"); loc =0;} NEWLINE bss_lines
	;	
bss_lines: bss_line NEWLINE bss_lines
	| NEWLINE bss_lines
	|
	;

bss_line: LABEL RESB_TYPE VALUE {printf("%08X <res %Xh>\t%s resb %s\n",loc,atoi(value),label,value); loc += atoi(value);}
	|  LABEL RESW_TYPE VALUE {printf("%08X <res %Xh>\t%s resw %s\n",loc,atoi(value),label,value); loc += 2 * atoi(value);}
	|  LABEL RESD_TYPE VALUE {printf("%08x <res %Xh>\t%s resd %s\n",loc,atoi(value),label,value); loc += 4* atoi(value);}
	|  LABEL RESQ_TYPE VALUE {printf("%08x <res %Xh>\t%s resq %s\n",loc,atoi(value),label,value); loc += 8 * atoi(value);}
	|  LABEL REST_TYPE VALUE {printf("%08x <res %Xh>\t%s rest %s\n",loc,atoi(value),label,value); loc += 10 * atoi(value);}
	;
%%

void yyerror(const char * e){
	printf("Abey: %s\n",e);
}

int main(){
	yyparse();
	return 0;
}
