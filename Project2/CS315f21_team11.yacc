/*famyacc.y */
%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
%}

%token INT_TYPE 
%token BOOLEAN_TYPE 
%token STRING_TYPE 
%token DOUBLE_TYPE 
%token COMMENT 
%token STRING 
%left LETTER 
%token LP 
%token RP 
%token LB 
%token RB 
%token COMMA 
%token IS 
%token WHILE 
%token FOR 
%token ASSGMNT_OP 
%left LOW_PRECEDENCE_OP 
%token HIGH_PRECEDENCE_OP 
%token BOOL_OP 
%token UNARY_POSTFIX_OP  
%token UNARY_OP 
%token END_STMNT_OP 
%token DOUBLE 
%token POWER_OP  
%token FUNCTION_DEC  
%token QUESTION_MARKS 
%token ENDWHILE 
%token RETURN 
%token ENDIS 
%token OR 
%token ENDOR 
%token ELSE 
%token ENDELSE 
%token IN 
%token OUT 
%token VOID 
%token IDENTIFIER 
%token RESERVED_RETURN_FNC 
%token RESERVED_VOID_FNC
%token PROGRAM_START
%token PROGRAM_END
%token WAY_VAR
%token WAY
%token CHAR
%token CHAR_TYPE
%token APOSTROPHE
%token START_MAIN
%token END_MAIN
%token CONST_TYPE
%token ENDFOR
%token BOOL_VAR
%token INT
%token DOT

%start program
%%

// PROGRAM
program: PROGRAM_START fnc_decs stmts PROGRAM_END | PROGRAM_START fnc_decs main_fnc PROGRAM_END

stmts: stmt stmts | 
stmt: assgmnt_stmt | loop_stmt | if_stmt | fnc_stmt END_STMNT_OP | in_stmt END_STMNT_OP | out_stmt END_STMNT_OP | COMMENT 
fnc_decs: fnc_dec fnc_decs | 

// ASSIGNMENT STATEMENTS
assgmnt_stmt: declaration_stmt | stmt_with_operand

declaration_stmt:
	var_type IDENTIFIER ASSGMNT_OP variadic_right_side END_STMNT_OP
   | var_type IDENTIFIER END_STMNT_OP 
   | CONST_TYPE var_type IDENTIFIER ASSGMNT_OP variadic_right_side END_STMNT_OP

stmt_with_operand: unary_stmt | variadic_stmt

unary_stmt: IDENTIFIER UNARY_POSTFIX_OP END_STMNT_OP | IDENTIFIER UNARY_OP const END_STMNT_OP | RESERVED_VOID_FNC

variadic_stmt: IDENTIFIER ASSGMNT_OP variadic_right_side END_STMNT_OP

// CONDITIONAL STATEMENTS
if_stmt: IS condition QUESTION_MARKS stmts ENDIS | IS condition QUESTION_MARKS stmts ENDIS else_stmt | IS condition QUESTION_MARKS stmts ENDIS or_stmt | IS condition QUESTION_MARKS stmts ENDIS or_stmt else_stmt

or_stmt: OR condition QUESTION_MARKS stmts ENDOR

else_stmt: ELSE QUESTION_MARKS stmts ENDELSE

// LOOP STATEMENTS
loop_stmt: for_stmt | while_stmt
while_stmt: WHILE condition QUESTION_MARKS stmts ENDWHILE
for_stmt: FOR declaration_stmt condition END_STMNT_OP stmt_with_operand QUESTION_MARKS stmts ENDFOR

// FUNCTION DEFINITIONS AND FUNCTION CALLS
fnc_dec: FUNCTION_DEC var_type IDENTIFIER LP fnc_params RP LB stmts RETURN variadic_right_side END_STMNT_OP RB 
	     | FUNCTION_DEC VOID IDENTIFIER LP fnc_params RP LB stmts RB
		 
fnc_params: var_type IDENTIFIER | var_type IDENTIFIER COMMA fnc_params | 

fnc_stmt: IDENTIFIER LP list RP | RESERVED_RETURN_FNC LP list RP | RESERVED_VOID_FNC LP list RP 
		| IDENTIFIER DOT IDENTIFIER LP list RP 
		| IDENTIFIER DOT RESERVED_VOID_FNC LP list RP 
		| IDENTIFIER DOT RESERVED_RETURN_FNC LP list RP 

main_fnc: START_MAIN stmts END_MAIN

// INPUT/OUTPUT STATEMENTS
in_stmt: IN LP RP
out_stmt: OUT LP variadic_right_side RP

// VARIABLES
var_type: INT_TYPE | DOUBLE_TYPE | STRING_TYPE | BOOLEAN_TYPE | WAY | CHAR_TYPE

list: IDENTIFIER COMMA list | IDENTIFIER | const COMMA list | const |
const: INT | BOOL_VAR | STRING | DOUBLE | WAY_VAR | char_var
char_var: APOSTROPHE LETTER APOSTROPHE  
condition: variadic_right_side BOOL_OP variadic_right_side | variadic_right_side BOOL_OP variadic_right_side BOOL_OP condition | variadic_right_side
variadic_right_side: variadic_right_side LOW_PRECEDENCE_OP term | term | fnc_stmt | in_stmt
term: term HIGH_PRECEDENCE_OP factor | factor
factor: exp POWER_OP factor | exp
exp: const | IDENTIFIER | LP variadic_right_side RP
%%
#include "lex.yy.c"
int lineno = 1;
void yyerror(char* s) {
	printf("%s at line %d\n", s, lineno);
}
int main(void){
	yyparse();
	if(yynerrs < 1){
		printf("Parsing is successful\n");
	}
 return 0;
}

