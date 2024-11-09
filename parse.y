%{
#include<stdio.h>
#include<stdlib.h>
void yyerror(const char * e);
int yylex();

extern char * label;
extern char * value;

int loc = 0;
%}

%token SEC_DATA SEC_BSS SEC_TEXT LABEL VALUE DB_TYPE DW_TYPE DD_TYPE DQ_TYPE DT_TYPE  NEWLINE RESB_TYPE RESW_TYPE RESD_TYPE RESQ_TYPE REST_TYPE STRING COMMA


%start lines

%%

lines: lines line
	| line
	;

line: data_sec
	| bss_sec
	;

data_sec: SEC_DATA NEWLINE {puts("\t\t\t\tsection .data");loc=0;}data_lines
	;

data_lines: data_line NEWLINE data_lines
	| NEWLINE data_lines
	|
	;

data_line: LABEL DB_TYPE values {printf("%08X %02X\t\t\t\t%s db %s\n",loc,atoi(value),label,value); loc += 1;}
	|  LABEL DW_TYPE VALUE {printf("%08X %04X\t\t\t\t%s dw %s\n",loc,atoi(value),label,value); loc += 2;}
	|  LABEL DD_TYPE VALUE {printf("%08X %08X\t\t\t%s dd %s\n",loc,atoi(value),label,value); loc += 4;}
	|  LABEL DQ_TYPE VALUE {printf("%08X %016X\t\t%s dq %s\n",loc,atoi(value),label,value); loc += 8;}
	;

values: val
	| val COMMA values
	;

val:	VALUE
	| STRING
	;

bss_sec: SEC_BSS {puts("\t\t\t\tsection .bss"); loc =0;} NEWLINE bss_lines
	;	

bss_lines: bss_line NEWLINE bss_lines
	| NEWLINE bss_lines
	|
	;

bss_line: LABEL RESB_TYPE VALUE {printf("%08X <res %Xh>\t\t\t%s resb %s\n",loc,atoi(value),label,value); loc += atoi(value);}
	|  LABEL RESW_TYPE VALUE {printf("%08X <res %Xh>\t\t\t%s resw %s\n",loc,atoi(value),label,value); loc += 2 * atoi(value);}
	|  LABEL RESD_TYPE VALUE {printf("%08X <res %Xh>\t\t\t%s resd %s\n",loc,atoi(value),label,value); loc += 4* atoi(value);}
	|  LABEL RESQ_TYPE VALUE {printf("%08X <res %Xh>\t\t\t%s resq %s\n",loc,atoi(value),label,value); loc += 8 * atoi(value);}
	|  LABEL REST_TYPE VALUE {printf("%08X <res %Xh>\t\t\t%s rest %s\n",loc,atoi(value),label,value); loc += 10 * atoi(value);}
	;
%%

void yyerror(const char * e){
	printf("Abey: %s\n",e);
}

int main(){
	yyparse();
	return 0;
}
