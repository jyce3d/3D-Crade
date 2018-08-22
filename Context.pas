(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is 3D-Crade
 *
 * The Initial Developer of the Original Code is
 * jyce3d
 *
 * Portions created by the Initial Developer are Copyright (C) 2003-2005
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * ***** END LICENSE BLOCK ***** *)

unit Context;
// Auteur:Jyce3d, 2004
// Le contexte permet de gérér des liste de variables et d'évaluer une expression mathématique
// en fonction des variables définies dans sa liste
//
// Ici est définie les listes suivantes :
// Opérateurs supportés
//  (+,-,/,*,^)
// function mathématiques supportées :
//  y=sin(x) ; y=asin(x)
//  y=cos(x) ; y=acos(x)
//  y=tan(x) ; y=atan(x)
// jyce : 9/9/04 : 3D-Crade Scriptor
// Nouveaux opérateurs (<,>,<=,<=,!=,=,!)

interface
uses classes;
type
// Type de valeur possible
TVariableType=(vtCoord,vtFloat,vtChar,vtInvalid);
// List des variables simples (clé=valeur)
TCustomVariables=class(TCollection)
 public
 constructor create;
 destructor destroy;override;
end;

// Variable simple : (clé=valeur)

TCustomVariable=class(TCollectionItem)
 public
 fName,fValue:String;
 fType:TVariableType;
 fProtected:boolean;

 Constructor create(Collection:TCollection);override;
end;

// List des variables structurées (la variable contient une liste de variables)
TStructuredVariables=class(TCollection)
 constructor create;
end;

//(la variable contient une liste de variables)
TStructuredVariable=class(TCustomVariable)
 parent:TStructuredVariable;
 ChildList:TCustomVariables;
 Constructor create(Collection:TCollection);override;
end;

TCustomContext=class
protected

  function RecurEvalFloat(str,_sLeft,_sRight:string):extended;
  function RecurEvalCondition(str,_sLeft,_sRight:string):boolean;
  function ExtractParanth(str:string;var strFn:string;var Extracted:boolean):string;
  function ExtractOpera(oper,str: string; var sLeft,  sRight: string): boolean;
  function ExtractOperaBool(oper,str:string;var sLeft, sRight:string):boolean;
  function ExtractQuote(str:string):string;
  function RecurEvalString(str,_sLeft,_sRight:string):string;
public
 Variables:TCustomVariables;
 StructVariables:TStructuredVariables;
 // Test si l'expression contient un égal
 function CheckEqual(str:string): boolean;
 function EvalFloat(str:string):Extended;

 function EvalString(str:string):String;  //TODO:Implement EvalString better
 class function IsForbidden(str:string): boolean;
 class function IsOperator(str:string):boolean;
 // test l'existance d'une variable
 function IsVariableExist(str:string):boolean;
 function GetVarType(str:string):TVariableType;
 // renvoit une référence sur une variable
 function GetGenericVariable(str:string):TCustomVariable;
 // Renvoit la valeur float d'une variable
 function GetFloatValue(str:string):extended;
 procedure SetFloatValue(str:string;value:extended);
 function EvalCondition(str:string):boolean;

 constructor create;
 destructor destroy;override;

end;

implementation
uses strLib,Math,SysUtils;

function TCustomContext.RecurEvalFloat(str,_sLeft,_sRight:string):extended;
 var _sLeft2,_sRight2:string; var1:TCustomVariable; strFn:string;bExtracted:boolean;
 begin
  result:=0;
  if str='' then exit;
  try
  bExtracted:=false;
  str:=ExtractParanth(str,strFn, bExtracted);
  if strFn='sin' then
  begin
   result:=sin(recurevalfloat(str,_sLeft,_sRight));
   exit;
  end else
  if strFn='cos' then
  begin
   result:=cos(recurevalfloat(str,_sLeft,_sRight));
   exit;
  end else
   if strFn='tan' then
   begin
    result:=tan(recurevalfloat(str,_sLeft,_sRight));
    exit;
   end else
    if strFn='acos' then
    begin
     result:=arccos(recurevalfloat(str,_sLeft,_sRight));
     exit;
    end else
     if strFn='asin' then
     begin
      result:=arcsin(recurevalfloat(str,_sLeft,_sRight));
      exit;
     end else
      if strFn='atan' then
      begin
       result:=arctan(recurevalfloat(str,_sLeft,_sRight));
       exit;
      end else
       if strFn='neg' then
       begin
        result:=-recurevalfloat(str,_sLeft,_sRight);
        exit;
       end;
  // function parser
  if ExtractOpera('+',str,_sLeft,_sRight) then
     result:=RecurEvalFloat(_sLeft,_sLeft2,_sRight2)+RecurEvalFloat(_sRight,_sLeft2,_sRight2)
   else
    if ExtractOpera('-',str,_sLeft,_sRight) then
     result:=RecurEvalFloat(_sLeft,_sLeft2,_sRight2)-RecurEvalFloat(_sRight,_sLeft2,_sRight2) else
      if ExtractOpera('*',str,_sLeft,_sRight) then
           result:=RecurEvalFloat(_sLeft,_sLeft2,_sRight2)*RecurEvalFloat(_sRight,_sLeft2,_sRight2) else
            if ExtractOpera('/',str,_sLeft,_sRight) then
             result:=RecurEvalFloat(_sLeft,_sLeft2,_sRight2)/RecurEvalFloat(_sRight,_sLeft2,_sRight2) else
              if ExtractOpera('^',str,_sLeft,_sRight) then
               result:=Power(RecurEvalFloat(_sLeft,_sLeft2,_sRight2),RecurEvalFloat(_sRight,_sLeft2,_sRight2)) else
              begin
               // plus d'opérateur
               try
                if isnumeric(str) then
                 result:=strtofloat(str)
                else begin
                 str:=trim(str); // variable numérique, l'espace est interdit
                 var1:=GetGenericVariable(str);
                 if var1=nil then
                  raise Exception.Create('Variable '+str+' does not exist')
                 else
                  if var1.ftype<>vtfloat then
                   raise Exception.Create('Variable '+str+' has not the proper format to perform this operation')
                   else
                    result:=strtofloat(var1.fvalue);
                end;
               except
               end;
              end;
   except
 //   raise;
   end;

 end;

function TCustomContext.EvalFloat(str:string): Extended;
var  sLeft,sRight:string;
begin
 // rechercher l'opérateur de plus haute priorité
 result:=RecurEvalFloat(str,sLeft,sRight);

end;

function TCustomContext.ExtractQuote(str:string): String;
var i:integer;
 function TrimLeftRight(str:string):string;
 var _i:integer;bWrite:boolean;
 begin
  _i:=1;
  bWrite:=false;
  result:='';
  while (_i<=length(str))   do
  begin
   if (str[_i]='"') and (bwrite) then
   begin
    result:=result+'"';
    break;
   end;
   if (str[_i]='"') and (not bWrite) then
    bWrite:=true;
   if bWrite then
    result:=result+str[_i];
   inc(_i);
  end;

 end;
begin
 result:='';
 if str='' then
  exit;
 str:=TrimLeftRight(str);
 if (str[1]='"') and (str[length(str)]='"')
  then begin
   for i:=2 to length(str)-1 do
    result:=result+str[i];
  end else
   if str[Length(str)]<>'"' then raise exception.create('Bad formatted string') else
   begin
     // Eval Variable
     result:=str;

   end;
end;

function TCustomContext.CheckEqual(str:string): boolean;
var i,cp:integer;
begin
 cp:=0;
 for i:=1 to length(str) do
  if str[i]='=' then
   inc(cp);

 result:=cp<=1;

end;


function TCustomContext.ExtractOpera(oper,str:string; var sLeft,
  sRight: string): boolean;
begin
 //sRight:='';
 result:=ExtractOperaBool(oper,str,sLeft,sRight);
end;



constructor TCustomContext.create;
begin
 Variables:=TCustomVariables.Create;
 StructVariables:=TStructuredVariables.create;

end;

destructor TCustomContext.destroy;
begin
  FreeAndNil(Variables);
  FreeAndNil(StructVariables);
  inherited;
end;



function TCustomContext.ExtractParanth(str:string; var strFn:string;var Extracted:boolean):string;
var  i:integer;cp,poss:integer;  str2,strFn2:string;
begin
 strFn:='';
 cp:=0;
 // Check if therie is
 for i:=1 to length(str) do
 begin
  if str[i]='(' then cp:=cp+1;

 end;
 if cp=0 then extracted:=true else
 begin
  cp:=0;
  for i:=1 to length(str) do
  begin
   if str[i]='(' then
    inc(cp)
    else
     if str[i]=')' then
      dec(cp)
      else
       if (isOperator(str[i])) and (cp=0) then
        Extracted:=true;
  end;
 end;
 if not extracted then
 begin
  i:=1;
  poss:=-1;
  while (i<=length(str)) do begin
   if str[i]<>'(' then
    strFn:=StrFn+str[i]
    else
    begin
     poss:=i;
     break;
    end;
    inc(i);
  end;
  for i:=poss+1 to length(str)-1 do
   str2:=str2+str[i];
  result:=ExtractParanth(str2,strfn2,extracted);
 end else
  result:=str;
end;

class function TCustomContext.IsForbidden(str:string): boolean;
begin
   result:=(str=',') or (IsOperator(str))
end;

class function TCustomContext.IsOperator(str:string):boolean;
begin
  result:= (str='+') or (str='-') or (str='*') or (str='/') or (str='^')
           or (str='<') or (str='>') or (str='=') or (str='!');// new addition sept 2004
end;

{ TCustomContext }



function TCustomContext.getFloatValue(str: string): extended;
var i:integer;
begin
 result:=0;
 for i:=0 to Variables.count -1 do
  if (Variables.Items[i] as TCustomVariable).fname=str then
  begin
   result:=strtofloat((Variables.Items[i] as TCustomVariable).fvalue);
   break;
  end;
end;

procedure TCustomContext.SetFloatValue(str:string;value:extended);
var i:integer;
begin
 for i:=0 to Variables.count -1 do
 if (Variables.Items[i] as TCustomvariable).fname=str then
 begin
  (Variables.items[i] as TCustomvariable).fvalue:=floattostr(value);
 end;
end;
function TCustomContext.isVariableExist(str: string): boolean;
var i:integer;
begin
 result:=false;
 for i:=0 to Variables.Count -1 do begin
  if (Variables.Items[i] as TCustomVariable).fname=str then
  begin
   result:=true;
   break;
  end;
 end;
 if result=false then begin
  for i:=0 to StructVariables.Count -1 do begin
   if (StructVariables.Items[i] as TStructuredVariable).fname=str then
   begin
    result:=true;
    break;
   end;
  end;
 end;
end;

// Evalue une expression booléenne : resultat: true : expression vraie, false : expression fausse
function TCustomContext.EvalCondition(str: string): boolean;
var sLeft,sRight:string;
begin
 result:=RecurEvalCondition(str,sLeft,sRight);
end;

function TCustomContext.RecurEvalCondition(str, _sLeft,
  _sRight: string ): boolean;
  var bExtracted:boolean;
      strFn,_sLeft2,_sRight2:string;
begin
 result:=false;
 if str='' then
  exit;
 bExtracted:=false;
 strFn:='';
 str:=ExtractParanth(str,strFn,bExtracted);

 // il n'y a pas de fonctions booleennes excepté le !

 if strFn='!' then begin
  result:=RecurEvalCondition(str,_sLeft,_sRight);
  exit;
 end;

 // Traitement des opérateurs de conditions
 if ExtractOperaBool('|',str,_sLeft,_sRight) then
   result:=RecurEvalCondition(_sLeft,_sLeft2,_sRight2) or RecurEvalCondition(_sRight,_sLeft2,_sRight2)
 else
  if ExtractOperaBool('&',str,_sLeft,_sRight) then
   result:=RecurEvalCondition(_sLeft,_sLeft2,_sRight2) and RecurEvalCondition(_sRight,_sLeft2,_sRight2)
  else
    if ExtractOperaBool('!=',str,_sLeft,_sRight) then
     result:=EvalFloat(_sLeft)<>EvalFloat(_sRight)
    else
    if ExtractOperaBool('<=',str,_sLeft,_sRight) then
     result:=EvalFloat(_sLeft)<=EvalFloat(_sRight)
    else
     if ExtractOperaBool('>=',str,_sLeft,_sRight) then
      result:=EvalFloat(_sLeft)>=EvalFloat(_sRight)
     else
      if ExtractOperaBool('==',str,_sLeft,_sRight) then
       result:=EvalFloat(_sLeft) = EvalFloat(_sRight)
      else
       if ExtractOperaBool('<',str,_sLeft,_sRight) then
        result:=EvalFloat(_sLeft) < EvalFloat(_sRight)
       else
        if ExtractOperaBool('>',str,_sLeft,_sRight) then
         result:=EvalFloat(_sLeft) > EvalFloat(_sRight)
        else
         raise Exception.Create('TCustomContext:RecurEvalFloat:Unknown operator');
end;




function TCustomContext.ExtractOperaBool(oper, str: string; var sLeft,
  sRight: string): boolean;
var i,pos,level:integer;

begin
 result:=false;
 if not CheckParanth(str) then
  exit;
 Pos:=-1;
 level:=0;
 for i:=1 to Length(Str) do
 begin
  if str[i]='(' then
   inc(level)
   else
  if str[i]=')' then
   dec(level);
   if length(Oper)=1 then begin
    if (Str[i]=Oper) and (level=0) then
    begin
     Pos:=i;
     break;
    end;
   end else
   begin
    if length(oper)=2 then begin
     if i=Length(Str) then
      break;
     if (str[i]=Oper[1]) and (str[i+1]=Oper[2]) and (level=0) then
     begin
      pos:=i;
      break;
     end;
    end;
   end;
 end;
 if pos=-1 then exit;

 result:=true;
 if length(oper)=1 then begin
  sLeft:=left(str,pos-1);
  sRight:=right(str,length(str)-pos);
 end else begin
  sLeft:=left(str,pos-1);
  sRight:=right(str,length(str)-(pos+1));
 end;
end;

function TCustomContext.EvalString(str: string): String;
var sLeft,sRight:string;
begin
 result:=RecurEvalString(str,sLeft,sRight);
end;

function TCustomContext.RecurEvalString(str, _sLeft,
  _sRight: string): string;
var strFn,
    _sLeft2,
    _sRight2:string;
    bExtracted:boolean;
    var1:TCustomVariable;
begin
  result:='';
  if str='' then exit;
  bExtracted:=false;
  str:=ExtractParanth(str,strFn, bExtracted);

  if ExtractOpera('+',str,_sLeft,_sRight) then
   result:=RecurEvalString(_sLeft,_sLeft2,_sRight2)+RecurEvalString(_sRight,_sLeft2,_sRight2)
    else
     if ExtractOpera('#',str,_sLeft,_sRight) then
      result:=RecurEvalString(_sLeft,_sLeft2,_sRight2)+floattostr(RecurEvalFloat(_sRight,_sLeft2,_sRight2)) else

     begin  // Pas de paranthèse, ni d'opérateur
      if isQuoted(str) then
                 result:=ExtractQuote(str)
                else begin
                 var1:=GetGenericVariable(str);
                 if var1=nil then
                  raise Exception.Create('Variable '+str+' does not exist')
                 else
                  if var1.ftype<>vtchar then
                   raise Exception.Create('Variable '+str+' has not the proper format to perform this operation')
                   else
                    result:=var1.fvalue;
                end;

     end;
end;

{ TCustomVariable }

constructor TCustomVariable.create(Collection:TCollection);
begin
 inherited create(Collection);
 fProtected:=false;
end;

{ TCustomVariables }

constructor TCustomVariables.create;
begin
 inherited create(TCustomVariable);
end;

destructor TCustomVariables.destroy;
begin
  inherited;

end;

constructor TStructuredVariable.create(Collection: TCollection);
begin
  parent:=nil;
  childlist:=TCustomVariables.Create;
  inherited create(Collection);

end;

{ TStructuredVariables }

constructor TStructuredVariables.create;
begin
 inherited Create(TStructuredVariable);
end;

function TCustomContext.GetVarType(str: string): TVariableType;
begin
 result:=vtInvalid;
 if str='coord' then
  result:=vtCoord else
   if str='float' then
    result:=vtFloat else
     if str='char' then
      result:=vtChar;
end;

function TCustomContext.GetGenericVariable(str: string): TCustomVariable;
var i:integer;      name:string;
begin
 result:=nil;
 for i:=0 to Variables.Count -1 do
 begin
  name:=lowercase((Variables.Items[i] as TCustomvariable).fname);
  if name=str then begin
   result:=Variables.Items[i] as TCustomVariable;
   break
  end;
 end;
 if result=nil then begin
  for i:=0 to StructVariables.Count -1 do
   if lowercase((StructVariables.items[i] as TStructuredVariable).fname)=str then begin
    result:=Variables.Items[i] as TCustomVariable;
   end;
 end;
end;


end.
