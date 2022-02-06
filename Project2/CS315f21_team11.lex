/* fam_lexical_analyzer.l */
%{
#include <stdio.h>
void yyerror(char *);
%}
DIGIT [0-9]
INT_TYPE int
BOOLEAN_TYPE bool
STRING_TYPE string
DOUBLE_TYPE double
COMMENT \$\$[a-zA-Z0-9_\!\'\^\#\+\$\%\&\/\{\(\[\)\]\=\}\\\*\?\-\_\;\,\`\"\.\: ]*\$\$
STRING \"[a-zA-Z0-9_\!\'\^\#\+\$\%\&\/\{\(\[\)\]\=\}\\\*\?\-\_\;\,\`\.\: ]*\"
LETTER [a-zA-Z]
LP \(
RP \)
LB \{
RB \}
COMMA ,
IS is
WHILE while
FOR for
ASSGMNT_OP =
LOW_PRECEDENCE_OP \+|\-
HIGH_PRECEDENCE_OP \*|\/
BOOL_OP \&\&|\|\||==|>|<|<=|>=|!=
UNARY_POSTFIX_OP \+\+|\-\-|\*\*
UNARY_OP \+=|\-=|\*=|\/=|\%=|\^=
END_STMNT_OP \;
POWER_OP \^
FUNCTION_DEC fnc\:\:
QUESTION_MARKS \?\?
ENDWHILE endwhile
ENDFOR endfor
RETURN return
ENDIS endis
OR or
ENDOR endor
ELSE else
ENDELSE endelse
IN in
OUT out
VOID void
IDENTIFIER [a-zA-Z][a-zA-Z0-9_]*
RESERVED_RETURN_FNC getHeading|getAltitude|getTemperature|connect
RESERVED_VOID_FNC move_vertical|move_horizontal|turn|move|toggle_spray|timer
CHAR_TYPE char
CONST_TYPE final
WAY_VAR north|south|west|east|northeast|northwest|southeast|southwest
WAY way 
APOSTROPHE \'
ENDLINE \n 
START_MAIN start_main
END_MAIN end_main
BOOL_VAR true|false
PROGRAM_START start_program
PROGRAM_END end_program
INT [+-]?({DIGIT})+
DOUBLE [+-]?{DIGIT}*(\.)?{DIGIT}+
DOT \.
%%
{INT_TYPE} return(INT_TYPE);
{BOOLEAN_TYPE} return(BOOLEAN_TYPE);
{STRING_TYPE} return(STRING_TYPE);
{DOUBLE_TYPE} return(DOUBLE_TYPE);
{CHAR_TYPE} return(CHAR_TYPE);
{CONST_TYPE} return(CONST_TYPE);
{DOT} return(DOT);
{WAY_VAR} return(WAY_VAR);
{WAY} return(WAY);
{APOSTROPHE} return(APOSTROPHE);
{START_MAIN} return(START_MAIN);
{END_MAIN} return(END_MAIN);
{ASSGMNT_OP} return(ASSGMNT_OP);
{BOOL_OP} return(BOOL_OP);
{COMMENT} return(COMMENT);
{LP} return(LP);
{RP} return(RP);
{LB} return(LB);
{RB} return(RB);
{COMMA} return(COMMA);
{IS} return(IS);
{INT} return(INT);
{DOUBLE} return(DOUBLE);
{PROGRAM_START} return(PROGRAM_START);
{PROGRAM_END} return(PROGRAM_END);
{WHILE} return(WHILE);
{ENDWHILE} return(ENDWHILE);
{FOR} return(FOR);
{BOOL_VAR} return(BOOL_VAR);
{RETURN} return(RETURN);
{FUNCTION_DEC} return(FUNCTION_DEC);
{QUESTION_MARKS} return(QUESTION_MARKS);
{OR} return(OR);
{ELSE} return(ELSE);
{END_STMNT_OP} return(END_STMNT_OP);
{ENDIS} return(ENDIS);
{ENDOR} return(ENDOR);
{ENDELSE} return(ENDELSE);
{ENDFOR} return(ENDFOR);
{IN} return(IN);
{OUT} return(OUT);
{VOID} return(VOID);
{LOW_PRECEDENCE_OP} return(LOW_PRECEDENCE_OP);
{HIGH_PRECEDENCE_OP} return(HIGH_PRECEDENCE_OP);
{UNARY_POSTFIX_OP} return(UNARY_POSTFIX_OP);
{UNARY_OP} return(UNARY_OP);
{POWER_OP} return(POWER_OP);
{RESERVED_RETURN_FNC} return(RESERVED_RETURN_FNC);
{RESERVED_VOID_FNC} return(RESERVED_VOID_FNC);
{IDENTIFIER} return(IDENTIFIER);
{STRING} return(STRING);
[ \t] ;
{ENDLINE} {extern int lineno; lineno++;};
%%
int yywrap() { return 1; }