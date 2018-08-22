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

// CustomParser : allow to implement any kin.d of scripting language by derivating the CustomCommand class
//                Basic Conditional and variable handling are defined in this base class
//                Command such let(),set(), kill() and list_var()
//                Handle the script parsing : instruction tree building
//                Handle the scirpt execution
// Author       : jyce3d, sept 2004
unit CustomParser;
interface
uses Classes,SysUtils,Context,CustomList,CustomTree;

 const
  PARSE_OK=0;
  PARSE_NOK=1;
type
// Command List

 TCustomCommand=class
  fContext:TCustomContext;
  CommandList:TStringList;
  constructor create(context:TCustomContext);virtual;
  destructor destroy;override;
  function isCommand(str:string):boolean;
 end;
 TCommandSet=class(TCustomCommand)
  constructor create(strContent:string;Context:TCustomContext; output:TStringList);reintroduce;
 end;
 TCommandListVar=class(TCustomCommand)
  constructor create(strContent: string;
  Context: TCustomContext;output:TStringList);reintroduce;
 end;

 TCommandKill=class(TCustomCommand)
  constructor create(strContent:string;Context:TCustomContext;output:TStringList);reintroduce;
 end;

 TCommandLet=class(TCustomCommand)
  constructor create(strContent: string; Context: TCustomContext;
  output: TStringList);reintroduce;
 end;

 TCustomParser=class
  protected
   fContext:TCustomContext;
   fOutput:TStringList;
   fScriptLines:TStringList;
   fiLine:integer;
   function ExtractCommand(str:string;var sCommand,sContent:string):boolean;
   function RemoveComments(str:string):string;
//   function OnParseScriptCommand(str,sCommand,sContent:string):integer;virtual;
   function ExecuteNeutral(var bContinue:boolean):integer;
   function ExecuteIf(var bContinue:boolean;Const sCondition:string):integer;
   function ExecuteWhile(var bContinue:boolean;Const sCondition:string):integer;
   function OnExecuteNeutral(str,sCommand,sContent:string):integer;virtual;
  public
   constructor create(context:TCustomContext;output:TStringList);virtual;
   destructor destroy;override;
   function Parse(str:string;var sCommand:string;var sContent:string):integer;virtual;

   procedure ParseScriptString(var str,sCommand,sContent:string);
   procedure IncScriptLine(var bContinue:boolean);
   // Could be used in case of Script Compilation
   function ParseScript(Script:TStringList):integer;
   function Execute(Script:TStringList):integer;

 end;

implementation
uses strlib;
{ TCustomParser }

constructor TCustomParser.create(context: TCustomContext;
  output: TStringList);
begin
 fcontext:=context;
 fOutput:=output;
 fiLine:=0;
end;

destructor TCustomParser.destroy;
begin
  inherited;

end;
//
// Execute un script interpreté
//

function TCustomParser.Execute(Script:TStringList): integer;
var bExecuteCondition:boolean;
begin
 fiLine:=0;
 fScriptLines:=Script;
 bExecuteCondition:=true;
 result:=1;
  while bExecuteCondition do
   ExecuteNeutral(bExecuteCondition);

end;
function TCustomParser.ExtractCommand(str:string; var sCommand,
  sContent: string): boolean;
var i:integer;
begin
 i:=1;
 sCommand:='';
 sContent:='';
 str:=RemoveBlankFromRight(str);
 if str[length(str)]<>')' then
  raise Exception.Create('TCustomParser::ExtractCommand:paranthese missing');
 while (str[i]<>'(') and (i<=length(str))  do
 begin
  sCommand:=sCommand+str[i];
  i:=i+1;

 end;
 if str[i]='(' then
  sContent:=Mid(str,i+1,length(str)-(i+2));

 result:=true;

end;
{function TCustomParser.ExtractCommand(str:string; var sCommand,
  sContent: string): boolean;
var i,poss,pose,poscmds:integer; bFlag:boolean;

begin
 result:=false;
 poss:=-1;
 bFlag:=false;
 poscmds:=-1;
 for i:=1 to length(str) do
 begin
  if (bFlag) and (str[i]<>'(') then
  begin
   poss:=i-1;
   break;
  end;
  if str[i]='(' then
  begin
   if not bFlag then
    poscmds:=i-1;
   bFlag:=true;
  end;
 end;
 if (poss=-1) or (poscmds=-1) then
  exit;
 pose:=-1;
 bFlag:=false;
 for i:=length(str) downto poss do
 begin
  if (bFlag) and (str[i]<>')') then
   break;

  if str[i]=')' then
  begin
   if bFlag=false then
    pose:=i-1;
   bFlag:=true;
  end;
 end;
 result:=true;
 sCommand:=left(str,poscmds);
 sContent:=mid(str,poss+1,pose-poss-1);
// sContent:='';
end;   }



{function TCustomParser.OnParseScriptCommand(str, sCommand,
  sContent: string): integer;
var Node:TCollectionItem;
begin
 if fiLine<fScriptLines.count then begin
 // Récupère la commande courrante et sa valeur
  ParseScriptString(str,sCommand,sContent);
  if str<>'' then begin

   if TCustomCOntext.IsForbidden(Right(SContent,1)) then
    raise Exception.Create('TCustomParser::OnParseScriptCommand:Wrong parameter list');
   if sCommand='if' then
   begin
    Node:=fTree.AddConditional(fCurrentNodeRef);
    Node.fpredecessor:=fcurrentnode;
    (Node as TConditionalTreeItem).sCondition:=sContent;
    if fRoot=nil then
    begin
     fRoot:=Node;
     fCurrentNode:=fRoot;
    end else
    begin
     fCurrentNode.fSuccessors.AddRef(Node);
     fCurrentNode:=Node;
    end;
    // crée le nouveau noeud pour la condition vraie
    inc(fIfCount);
    inc(fiLine);
    str:=fScriptLines.strings[fiLine];
    result:=OnParseScriptCommand(str,sCommand,sContent);

   end else
    if sCommand='else' then
    begin
     if fRoot=nil then
      raise Exception.Create('TCustomParser::OnParseScriptCommand:A script cannot begin with a "else" statement');
      if not (fCurrentNode.fPredecessor is TConditionalTreeItem) then
       raise Exception.Create('TCustomParser::OnParseScriptCommand:Orphan "else" statement');
      fCurrentNode:=(fCurrentNode.fpredecessor.fSuccessors[1] as TTreeItem);

     inc(fiLine);
     str:=fScriptLines.strings[fiLine];
     result:=OnParseScriptCommand(str,sCommand,sContent);

    end else
     if sCommand='endif' then
     begin
      dec(fifCount);
      if fRoot=nil then
       raise Exception.Create('TCustomParser::OnParseScriptCommand:A script cannot begin with a "endif" statement');
      if  not(fCurrentNode.fpredecessor is TConditionalTreeItem) then
       raise Exception.Create('TCustomParser::OnParseScriptCommand:Orphan "endif" statement');
      fCurrentNode:=(fCurrentNode.fPredecessor.fSuccessors[2] as TTreeItem);
      inc(fiLine);
      str:=fScriptLines.strings[fiLine];
      result:=OnParseScriptCommand(str,sCommand,sContent);

     end else
      if sCommand='while' then
      begin
       Node:=TConditionalTreeItem.create;
       Node.fpredecessor:=fcurrentnode;
       (Node as TWhileTreeItem).sCondition:=sContent;
       if fRoot=nil then
       begin
        fRoot:=Node;
        fCurrentNode:=fRoot;
       end else
       begin
        fCurrentNode.AddSuccessorNode(Node);
        fCurrentNode:=Node;
       end;
    // crée le nouveau noeud pour la condition vraie
       inc(fWhileCount);
       inc(fiLine);
       str:=fScriptLines.strings[fiLine];
       result:=OnParseScriptCommand(str,sCommand,sContent);
      end else
      if sCommand='wend' then
      begin
       dec(fWhileCount);
       if (fRoot=nil) then
        raise Exception.Create('TCustomParser::OnParseScriptCommand:A script cannot begin with a "wend" statement');
       if not (fCurrentNode.fPredecessor is TWhileTreeItem) then
        raise ExceptioN.Create('TCustomParser::OnParseScriptCommand:Orphan "wend" statement');
       fCurrentNode:=(fCurrentNode.fPredecessor.fSuccessors[1] as TTreeItem);
       inc(fiLine);
       str:=fScriptLines.strings[fiLine];
       result:=OnParseScriptCommand(str,sCommand,sContent);
      end
      else begin // regular command
       Node:=TConditionalTreeItem.create;
       Node.fpredecessor:=fcurrentNode;
       (Node as TSequenceTreeItem).sCommand:=str; // Commande qui sera parsée lors de l'exécution
       if fRoot=nil then
       begin
        fRoot:=Node;
        fCurrentNode:=fRoot;
       end else
       begin
        fCurrentNode.AddSuccessorNode(Node);
        fCurrentNode:=Node;
       end;
       inc(fiLine);
       str:=fScriptLines.strings[fiLine];
       result:=OnParseScriptCommand(str,sCommand,sContent);
      end;
  end else begin // ligne vide
   fiLine:=fiLine+1;
   str:=fScriptLines.strings[fiLine];
   result:=OnParseScriptCommand(str,sCommand,sContent);
  end;
 end else result:=1;
end;
}
function TCustomParser.Parse(str: string;var sCommand:string;var sContent:string): integer;
var cmd:TCustomCommand;
begin
result:=PARSE_NOK;

 str:=RemoveBlank(str);
 // BUG 01: Remove the the last space
 str:=RemoveBlankFromRight(str);

 if not CheckParanth(str) then
  raise Exception.Create('Line mismatch in ''('' or '')''');
// if not CheckEqual(str) then
//  raise Exception.Create('Line mismatch, double assignation is not supported');
 // Recherche un égal si oui => pas une commande

// if ExtractOpera('=',str,strleft,strright) then begin
// end else

  if not ExtractCommand(str,sCommand,sContent) then
    raise Exception.Create('Wrong formatted line');
// Récupération de l'expression

//    if not ExprContent.IsValidExpression then
    if TCustomContext.IsForbidden(Right(sContent,1)) then
     raise Exception.Create('Wrong paramter list');
   if sCommand='set' then begin
    try
      cmd:=TCommandSet.Create(sContent,fContext,foutput);
      FreeAndNil(cmd);
      result:=PARSE_OK;

     except
      raise;
     end;
   end else
   if sCommand='list_var' then begin
    try
     cmd:=TCommandListVar.Create(sContent,fContext,foutput);
     FreeAndNil(cmd);
     result:=PARSE_OK;
    except
     raise;
    end;
   end else
    if sCommand='kill' then begin
     try
      cmd:=TCommandKill.Create(sContent,fcontext,foutput);
      FreeAndNil(cmd);
      result:=PARSE_OK;
     except
      raise;
     end;
    end else
     if sCommand='let' then begin
      cmd:=TCommandLet.Create(sContent,fcontext,foutput);
      FreeAndNil(cmd);
      result:=PARSE_OK;
     end;

end;

procedure TCustomParser.ParseScriptString(var str,  sCommand,  sContent:string);

begin

//  str:=fScriptLines.Strings[fiLine];
  str:=RemoveBlank(str);
  str:=RemoveComments(str);
  if str='' then
  begin
   sCommand:='';
   sContent:='';
  end
  else begin
   if NotParanth(str) then begin
    sCommand:=str;
    sContent:='';
   end else begin
    if not CheckParanth(str) then
     raise Exception.Create('Line mismatch in ''('' or '')''');
    if ExtractCommand(str,sCommand,sContent) then
    else
     raise Exception.Create('Wrong formatted line');
   end;
  end;

end;
// Obsolete function call  (in case of script compilation)
function TCustomParser.ParseScript(Script:TStringList): integer;
var  str,sCommand,sContent:string;
begin
 fScriptLines:=Script;
 fiLine:=0;

 result:=0;

end;


function TCustomParser.RemoveComments(str: string): string;
var pos:integer;
begin
 if str='//' then
  begin
   result:='';
   exit;
  end;
 result:=getFirst(str,pos,'/');
 if pos<length(str) then
 begin
  if str[pos]='/' then
   result:=left(str,pos-2) else
    result:=str;
 end;
end;
function TCustomParser.ExecuteWhile(var bContinue: boolean;Const sCondition:string): integer;
var iWendLine:integer; iFirstWhileLine:integer;
 procedure GetWendLine(var iWendLine:integer;var bContinue:boolean);
 var _level:integer;bNotWendFound,_oldbContinue:boolean;_oldiLine:integer;
     _str,_sCommand,_sContent:string;
 begin
  _level:=0;
  iWendLine:=-1;
  // PUSH Context
  _oldbContinue:=bContinue;
  _oldiLine:=fiLine;
  bNotWendFound:=true;
  while (bContinue) and (bNotWendFound) do begin
   _str:=fScriptLines[fiLine];
   ParseScriptString(_str,_sCommand,_sContent);
   if (_sCommand='while') then
    inc(_level) else
      if (_sCommand='wend') and (_level>0) then
       dec(_level) else
        if (_sCommand='wend') and (_level=0) then
        begin
         iWendLine:=fiLine;
         bNotWendFound:=false;
        end;
   IncScriptLine(bContinue);
  end;
    // POP Context
  bContinue:=_oldbContinue;
  fiLine:=_oldiLine;
 end;
begin
 IncScriptLine(bContinue);
 GetWendLine(iWendLine,bContinue);
 if iWendLine=-1 then
   Raise Exception.Create('TCustomParser::ExecuteWhile:There is no "wend" statement for that "while" statement');
 iFirstWhileLine:=fiLine;

 while (fContext.EvalCondition(sCondition)) do
 begin
  result:=ExecuteNeutral(bContinue);
  if fiLine=iWendLine then
   fiLine:=iFirstWHileLine;
 end;
 fiLine:=iWendLine;
 result:=1;
// IncScriptLine(bContinue);
end;

function TCustomParser.ExecuteIf(var bContinue: boolean;Const sCondition:string): integer;
var iElseLine,iEndifLine:integer;
 procedure GetElseEndifLine(var iElseLine,iEndifLine:integer; var bContinue:boolean);
 var _level:integer;bNotEndifFound:boolean;_oldbContinue:boolean;_oldiLine:integer;
     _str,_sCommand,_sContent:string;
 begin
  _level:=0;
  iElseLine:=-1;
  iEndifLine:=-1;
  // PUSH Context
  _oldbContinue:=bContinue;
  _oldiLine:=fiLine;
  bNotEndifFound:=true;
  while (bContinue) and (bNotEndifFound) do begin
   _str:=fScriptLines[fiLine];
   ParseScriptString(_str,_sCommand,_sContent);
   if (_sCommand='if') then
    inc(_level) else
     if (_sCommand='else') and (_level=0) then
      iElseLine:=fiLine else
       if (_sCommand='endif') and (_level>0) then
        dec(_level) else
         if (_sCommand='endif') and (_level=0) then
         begin
          iEndifLine:=fiLine;
          bNotEndifFound:=false;
         end;
   IncScriptLine(bContinue);
  end;
  // POP Context
  bContinue:=_oldbContinue;
  fiLine:=_oldiLine;
 end;
begin
 IncScriptLine(bContinue);
 GetElseEndifLine(iElseLine,iEndifLine,bContinue);
 if iEndIfLine=-1 then
   Raise Exception.Create('TCustomParser::ExecuteIf:There is no "endif" statement for that "if" statement');
 if not fContext.EvalCondition(sCondition) then
 begin
  // Test s'il y a un else
    if iElseLine<>-1 then begin
     fILine:=iElseLine+1;
     result:=ExecuteNeutral(bContinue);
    end;
 end else
  result:=ExecuteNeutral(bContinue);

 fiLine:=iEndifLine;
// IncScriptLine(bContinue);
 result:=1;
end;

function TCustomParser.ExecuteNeutral(var bContinue: boolean): integer;
var str,sCommand,sContent:string;
begin
 result:=0;
 if not bContinue then exit;

 str:=fScriptLines[fiLine];
 try
  ParseScriptString(str,sCommand,sContent);

  if sCommand<>'' then
  begin
   if sCommand='if' then
    result:=ExecuteIf(bContinue,sContent)
   else
    if sCommand='while' then
     result:=ExecuteWhile(bContinue,sContent)
     else
      result:=OnExecuteNeutral(str,sCommand,sContent); // Go up in the child class if it is necessary and
      // execute the command parsing.
  end;
  IncScriptLine(bContinue);
 except
  on e:exception do
   raise Exception.Create(e.message+' at line '+inttostr(fiLine));
 end;
end;


function TCustomParser.OnExecuteNeutral(str, sCommand, sContent:string): integer;
begin
 result:=Parse(str,sCommand,sContent);
end;

procedure TCustomParser.IncScriptLine(var bContinue: boolean);
begin
 inc(fiLine);
 if (fiLine=fScriptLines.count) then
  bContinue:=false;

end;

{ TCommandSet }

constructor TCommandSet.create(strContent: string; Context: TCustomContext; output:TStringList);
var par1,par2:string; pos:integer;    var1:TCustomVariable;varType:TVariableType; varc:TStructuredVariable;
begin
 inherited create(Context);
 par1:=GetFirst(strContent,pos);
 par2:=GetNext(strContent,pos);

 if GetNext(strContent,pos)<>'' then
 begin
  raise Exception.Create('Invalid argument list.');
  exit;
 end;
 if Context.IsVariableExist(par1) then
 begin
  raise Exception.Create('Variable already defined.');
  exit;
 end;

 if isCommand(par1) then
 begin
  raise Exception.Create('Invalid indentifer name.');
  exit;
 end;
 varType:=fContext.GetVarType(par2);
 if varType=vtInvalid then
 begin
  raise Exception.Create('Invalid type name.');
  exit;
 end;
 if varType<>vtCoord then begin
  var1:=((Context.Variables as TCustomvariables).ADD as TCustomVariable);
  var1.fName:=par1;
  var1.fType:=varType;
  var1.fprotected:=false;
// output.Add('variable count='+inttostr(COntext.Variables.count));
 end else
 begin
  varc:=(Context.StructVariables.Add as TStructuredVariable);
  varc.fname:=par1;
  varc.ftype:=vtcoord;
  varc.fprotected:=false;
  var1:=varc.ChildList.add as TCustomVariable;
  var1.fname:='x';
  var1.ftype:=vtfloat;
  var1.fprotected:=false;
  var1:=varc.childList.add as TCustomVariable;
  var1.fname:='y';
  var1.ftype:=vtfloat;
  var1.fprotected:=false;
  var1:=varc.childlist.add as TCustomVariable;
  var1.fname:='z';
  var1.ftype:=vtfloat;
  var1.fprotected:=false;

 end;
 //Context.Variables.add(var1);

end;

{ TCustomCommand }

constructor TCustomCommand.create(context:TCustomContext);
begin
 fContext:=Context;

 // built-in commands
 CommandList:=TStringList.Create;
 CommandList.Add('set');
 CommandList.Add('let');
 CommandList.Add('line');
 CommandList.add('line@');
 CommandList.add('print');
 CommandList.Add('plot');
 CommandList.add('frame');
 CommandList.add('list');

 // built-in functions
{ FunctionList:=TStringList.create;
 FunctionList.add('sin');
 FunctionList.add('cos');
 FunctionList.add('exp');
 FunctionList.Add('sqr');
 FunctionList.add('sqrt');
 FunctionList.add('ln');
 FunctionList.add('tan');
 FunctionList.add('asin');
 functionList.add('acos');
 functionList.add('atan');
 functionlist.add('xcoord');
 functionlist.add('ycoord');
 functionlist.add('zcoord');}

end;


destructor TCustomCommand.destroy;
begin
  inherited;

end;

function TCustomCommand.isCommand(str: string): boolean;
var i:integer;
begin
 result:=false;
 for i:=0 to CommandList.Count -1 do begin
  if commandlist[i]=str then
   begin
    result:=true;
    break;
   end;
 end;
end;


{ TCommandList }

constructor TCommandListVar.create(strContent: string;
  Context: TCustomContext;output:TStringList);
var i:integer;var1,varx,vary,varz:TCustomVariable;sType,status:string;  varc:TStructuredVariable;
begin
 inherited Create(Context);
 if strContent<>'' then
 begin
  raise Exception.Create('list does not take arguments');
 end;
// output.Add('Variable List');
// output.add('-------------');

 for i:=0 to Context.Variables.Count -1 do
 begin
  status:='';
  var1:=(Context.Variables.Items[i] as TCustomVariable);
   if var1.ftype=vtFloat then sType:='FLOAT' else
    if var1.ftype=vtChar then sType:='CHAR';
   if var1.fprotected then status:='protected';
  output.add(var1.fname+#9+stype+#9+var1.fvalue+#9+status);
 end;
 for i:=0 to Context.StructVariables.count -1 do
 begin
   status:='';
  varc:=(Context.StructVariables.Items[i] as TStructuredVariable);
  varx:=varc.childlist.Items[0] as TCustomvariable;
  vary:=varc.Childlist.Items[1] as TCustomvariable;
  varz:=varc.Childlist.Items[2] as TCustomvariable;
  if varc.fProtected then
   status:='protected';
  output.Add(varc.fname+#9+'COORD'+#9+'('+varx.fvalue+','+vary.fvalue+','+varz.fvalue+')'+#9+status);
 end;
 output.Sort;
end;

{ TCommandKill }

constructor TCommandKill.create(strContent: string;
  Context: TCustomContext; output: TStringList);
var varlist:TStringList;   Pos,i,j:integer;  c:string;    var1:TCustomVariable;varc:TStructuredVariable;   fDeleted:boolean;
begin
 inherited Create(context);
 varList:=TStringList.Create;
 if GetFirst(strContent,Pos)='' then
 begin
  for i:=0 to Context.Variables.Count -1 do
  begin
   var1:=Context.Variables.Items[i] as TCustomVariable;
   if not var1.fprotected then
    Context.Variables.Delete(i);
  end;
  for i:=0 to Context.StructVariables.count-1 do
  begin
   varc:=Context.StructVariables.Items[i] as TStructuredVariable;
   if not varc.fProtected then
    Context.StructVariables.Delete(i);
  end;
  exit;
 end;
 varList.Add(GetFirst(strContent,Pos));
 c:=GetNext(strContent,Pos);
 while c<>'' do begin
  varList.add(c);
  c:=GetNext(strContent,Pos);
 end;
 // Efface
 for i:=0 to varlist.count -1 do
 begin
  fDeleted:=false;
  for j:=0 to Context.Variables.Count -1 do
  begin
   var1:=Context.Variables.Items[j] as TCustomVariable;
   if var1.fname=varlist[i] then
   begin
    if not var1.fProtected then
     Context.Variables.Delete(j);
    fDeleted:=true;
    break;
   end;
  end;
  if not fDeleted then begin
   for j:=0 to Context.StructVariables.Count -1 do
   begin
    varc:=Context.StructVariables.Items[j] as TStructuredVariable;
    if varc.fname=varlist[i] then
    begin
     if not varc.fProtected then
      Context.StructVariables.Delete(j);
     fDeleted:=true;
     break;
    end;

   end;
  end;
  if not fDeleted then
   raise Exception.Create('Variable : '+varList[i]+'does not exist');
 end;


 FreeAndNil(varlist);
end;

{ TCommandLet }

constructor TCommandLet.create(strContent: string; Context: TCustomContext;
  output: TStringList);
var var1,varx,vary,varz:TCustomVariable;varc:TStructuredVariable;   expr,exprx,expry,exprz:string;  pos:integer;
begin
 // rechercher une variable connue + déterminer son type
 inherited Create(Context);
 var1:=fContext.GetGenericVariable(GetFirst(strContent,pos));
 if var1=nil then
 begin
  raise Exception.Create('Invalid variable name');
  exit;
 end;

 if var1.ftype=vtCoord then begin
  exprx:=GetNext(strContent,pos);
  expry:=GetNext(strContent,pos);
  exprz:=GetNext(strContent,pos);
  varc:=var1 as TStructuredVariable;
  varx:=varc.ChildList.Items[0] as TCustomVariable;
  vary:=varc.ChildList.Items[1] as TCustomVariable;
  varz:=varc.ChildList.items[2] as TCustomVariable;
  varx.fvalue:=FloatTostr(fContext.EvalFloat(exprx));
  vary.fvalue:=FloatToStr(fContext.EvalFloat(expry));
  varz.fvalue:=FloatToStr(fContext.EvalFloat(exprz));

 end else
 begin
  expr:=GetNext(strContent,pos);
  if GetNext(strContent,pos)<>'' then
  begin
   raise Exception.Create('Invalid argument lis');
   exit;
  end;
  if var1.ftype=vtfloat then
   var1.fvalue:=FloatToStr(fContext.EvalFloat(expr)) else
    if var1.ftype=vtchar then
     var1.fvalue:=fContext.EvalString(expr);

 end;
 // rechercher les patterns en fonction des types

end;


end.
