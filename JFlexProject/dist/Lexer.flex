package jflexproject;

%%
%class Lexer
%type String
L = [a-zA-Z_]
D = [0-9]
Dd = [1-9]

Variable = {L}({L}|{D})*
Number ={D} |({Dd}{D}*)

WHITE=[ \t\r]
%{
public String lexeme;
public static int symbolNum=-1;
public static int lineNum=0;
%}
%%
{WHITE} {symbolNum+=yylength();}
"\n" {symbolNum= (-1); lineNum+=1;}

"+" {symbolNum+=yylength(); return ("Op(Plus,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"-" {symbolNum+=yylength(); return ("Op(Minus,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"*" {symbolNum+=yylength(); return ("Op(Multiply,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"/" {symbolNum+=yylength(); return ("Op(Devision,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"%" {symbolNum+=yylength(); return ("Op(Remainder,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"==" {symbolNum+=yylength(); return ("Op(Equal,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"!=" {symbolNum+=yylength(); return ("Op(NotEqual,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
">=" {symbolNum+=yylength(); return ("Op(GreaterOrEqual,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
">" {symbolNum+=yylength(); return ("Op(Greater,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"<=" {symbolNum+=yylength(); return ("Op(LessOrEqual,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"<" {symbolNum+=yylength(); return ("Op(Less,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"&&" {symbolNum+=yylength(); return ("Op(And,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"||" {symbolNum+=yylength(); return ("Op(Or,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}

"skip" {symbolNum+=yylength(); return ("Kw_Skip("+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"write" {symbolNum+=yylength(); return ("Kw_Write("+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"read" {symbolNum+=yylength(); return ("Kw_Read("+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"while" {symbolNum+=yylength(); return ("Kw_While("+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"do" {symbolNum+=yylength(); return ("Kw_Do("+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"if" {symbolNum+=yylength(); return ("Kw_If("+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"then" {symbolNum+=yylength(); return ("Kw_Then("+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"else" {symbolNum+=yylength(); return ("Kw_Else("+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}

":=" {symbolNum+=yylength(); return ("Assign("+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"(" {symbolNum+=yylength(); return ("Parenthesis(Open,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
")" {symbolNum+=yylength(); return ("Parenthesis(Close,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
";" {symbolNum+=yylength(); return ("Colon("+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}


 {Number} {symbolNum+=yylength(); return ("Num("+yytext()+","+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
{Variable} {symbolNum+=yylength(); return ("Var(\""+yytext()+"\","+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
. {return("");}