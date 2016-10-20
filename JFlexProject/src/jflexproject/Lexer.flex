package jflexproject;

%%
%class Lexer
%type String
L = [a-zA-Z_]
RL = [à-ÿÀ-ß] 
D = [0-9]
Dd = [1-9]

Variable = {L}({L}|{D})*
WrongVariable = {D}{D}*{L}({L}|{D})*
RussianString = {RL}({RL})*
Number ={D} |({Dd}{D}*)

 LineTerminator = \r|\n|\r\n
    InputCharacter = [^\r\n]
   EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?

TraditionalComment   = "(*" [^*] ~"*)" | "(*" "*"+ ")"
UnclosedTraditionalComment = "(*" [^*] ~"*"|"(*" [^*]*  | "(*" "*"+ | "(*"

WHITE=[ \t\r]
%{
public String lexeme;
public static int symbolNum=-1;
public static int lineNum=0;
public static int symbolNum2=-1;
public static int lineNum2=0;
%}
%%
{WHITE} {symbolNum+=yylength();}
"\n" {symbolNum= (-1); lineNum+=1; }

{EndOfLineComment} {symbolNum+=yylength();symbolNum2=symbolNum;
 lineNum2=lineNum;symbolNum= (-1); lineNum+=1;
 return ("EndOfLineComment("+lineNum2+","+(symbolNum2-yylength()+1)+","+symbolNum2+");");}

{TraditionalComment} { String s=yytext();
                        String sArr[]=s.split("\n");
                        lineNum+=(sArr.length -1);
                        if(sArr.length>1){symbolNum=(sArr[sArr.length -1]).length();}
                        else{symbolNum+=(sArr[sArr.length -1]).length();}
                        return ("TraditionalComment("+lineNum+");");}
{UnclosedTraditionalComment} { String s=yytext();
                        String sArr[]=s.split("\n");
                        lineNum+=(sArr.length -1);
                        if(sArr.length>1){symbolNum=(sArr[sArr.length -1]).length();}
                        else{symbolNum+=(sArr[sArr.length -1]).length();}
                        return ("ERROR: UNCLOSED TraditionalComment("+lineNum+");");}

"+" {symbolNum+=yylength(); return ("Op(Plus,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"-" {symbolNum+=yylength(); return ("Op(Minus,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
"**" {symbolNum+=yylength(); return ("Op(Exponentiation,"+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
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

  {WrongVariable} {symbolNum+=yylength(); return ("ERROR:VARIABLE CAN'T BEGIN WITH NUMBER(\""+yytext()+"\","+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
 {Number} {symbolNum+=yylength(); return ("Num("+yytext()+","+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
{Variable} {symbolNum+=yylength(); return ("Var(\""+yytext()+"\","+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
{RussianString} {symbolNum+=yylength(); return ("ERROR: RUSSIAN STRING IN CODE("+yytext()+","+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}
. {symbolNum+=yylength(); return ("ERROR:INVALID STRING("+yytext()+","+lineNum+","+(symbolNum-yylength()+1)+","+symbolNum+");");}