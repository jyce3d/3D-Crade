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

//Auteur:Jyce3d, 2003
unit Unit2;

interface
uses Classes,SysUtils;

type

TVariableType=(vtCoord,vtFloat,vtText);

TCustomVariables=class(TCollection)
 public
 constructor create;
end;

TCustomVariable=class(TCollectionItem)
 public
 fName,fValue:String;
 fType:TVariableType;

 Constructor create(Collection:TCollection);override;
end;

TStructuredVariables=class(TCollection)
 constructor create;
end;

TStructuredVariable=class(TCustomVariable)
 parent:TStructuredVariable;
 ChildList:TStructuredVariables;
 Constructor create(Collection:TCollection);override;
end;

TCustomContext=class
 Variables:TCustomVariables;

 constructor Create;
 destructor destroy;override;
end;

TCustomStatement=class
 fContext:TCustomContext;

 function RemoveBlank(str:string):string;
 function ExtractOpera(oper,str:string;var sLeft,sRight:string):boolean;
 function ExtractCommand(str:string;var sCommand,sContent:string):boolean;
 function CheckParanth(str:string):boolean;
 function CheckEqual(str:string):boolean;
 function Left(str:string;len:integer):string;
 function Right(str:string;len:integer):string;
 
 constructor create(context:TCustomContext);
 function Parse(str:string):integer;
end;

implementation

{ TCustomVariable }

constructor TCustomVariable.create(Collection:TCollection);
begin

end;

{ TCustomVariables }

constructor TCustomVariables.create;
begin
 inherited create(TCustomVariable);
end;

{ TCustomContext }

constructor TCustomContext.Create;
begin
 Variables:=TCustomVariables.Create;
end;

destructor TCustomContext.destroy;
begin
  FreeAndNil(Variables);
  inherited;
end;

{ TCustomStatement }

function TCustomStatement.CheckEqual(str: string): boolean;
var i,cp:integer;
begin
 cp:=0;
 for i:=1 to length(str) do
  if str[i]='=' then
   inc(cp);

 result:=cp<=1;

end;

function TCustomStatement.CheckParanth(str: string): boolean;
var i,poss,pose:integer;
begin
 i:=1;
 while i<=lengt(str) do
 begin

 end;
end;

constructor TCustomStatement.create(context: TCustomContext);
begin
 fcontext:=context;
end;

function TCustomStatement.ExtractCommand(str: string; var sCommand,
  sContent: string): boolean;
var i,poss,pose:integer;
begin
 result:=false;
 poss:=-1;
 for i:=1 to length(str) do
  if str[i]='(' then
  begin
   poss:=i;
   break;
  end;
 if poss=-1 then
  exit;
 pose:=-1;
 for i:=length(str) downto 1 do
  if str[i]=')' then
  begin
   pose:=i;
   break;
  end;
 result:=true;
 sCommand:=left(str,poss-1);
 sContent:=right(str,pose-1);
end;

function TCustomStatement.ExtractOpera(oper,str: string; var sLeft,
  sRight: string): boolean;
var i,pos:integer;
begin
 result:=false;
 pos:=-1;
 for i:=1 to length(str) do
  if str[i]=oper then
  begin
   pos:=i;
   break;
  end;
 if pos=-1 then exit;

 result:=true;
 sLeft:=left(str,pos-1);
 sRight:=right(str,pos-1);

end;

function TCustomStatement.Left(str: string; len: integer): string;
var i:integer;
begin
 result:='';
 if len<1 then
  exit;
 if len>length(str) then
 begin
  result:=str;
  exit;
 end;
 for i:=1 to len do
  result:=result+str[i];
end;

function TCustomStatement.Parse(str: string): integer;
var strLeft,strRight,strCommand,strComContent:string;
begin
 // Trimer
 str:=RemoveBlank(str);

 if not CheckParanth(str) then
  raise Exception.Create('Line mismatch in ''('' or '')''');
// if not CheckEqual(str) then
//  raise Exception.Create('Line mismatch, double assignation is not supported');
 // Recherche un égal si oui => pas une commande

// if ExtractOpera('=',str,strleft,strright) then begin
// end else
  if ExtractCommand(str,strCommand,strComContent) then
  begin
  end
   else
    raise Exception.Create('Wrong formatted line');
 // sinon commande, rechercher ( et prendre à gauche, identi
 //  Extraire paramètre, en fonction de leur type : SET (var,type)
 //                                                 LET (var,value)
 //                                                 LET (varc,valx,valy,valz)
 //                                                 LET (vart,"text 1")
 //                                                 LET (varc,[SELECT({NEAREST|ENDPOINT|STARTPOINT|CENTER}])
 //                                                    ex:LET (varc,[SELECT(NEAREST)]) => ask for a mouse selection
 //                                                 PRINT (var)
 //                                                 LINE (var,value,var2,value2,value3,value4[,color,type,keyname])
 //                                                 LINE (varc1,varc2[,color,type,keyname])
 //                                                 LINE (x1,y1,z1,varc2[,color,type,keyname])
 //                                                 LINE (varc1,x2,y2,z2[,color,type,keyname])
 //
 //                                                 LINE@ (rho,teta,phi[,x1,y1,z1,color,type,keyname])
 //                                                 LINE@ (rho,teta,phi[,varc,color,type,keyname])
 //                                                 PLOT (x,y,z[,color,keyname])
 //                                                 PLOT (varc,[,color,keyname])
 //                                                 FRAME
 //                                                 BOXFILL
 //                                                 SPHERE
 //
 // Sinon Si Egal
end;

// Remove Blank in a string excepted blanks between quotes
function TCustomStatement.RemoveBlank(str: string): string;
var i:integer;
 function ExtractQuote(s:string;var pos:integer):string;
  var _bF:boolean;
 begin
  result:='';
  _bF:=true;
  while (pos<=length(s)) and (_bF) do
  begin
   if s[pos]<>'"' then
    result:=result+s[pos]
   else
    _bF:=true;
   pos:=pos+1;
  end;
  if not _bf then
   raise Exception.Create('Undefined quote');
 end;

begin
 i:=1;
 result:='';
 while i<=length(str) do begin
  if str[i]<>'"' then begin
   if not((str[i]=#32) and (str[i]=#9)) then // str[i]<>#32 or str[i]<>#9 cfr De Morgan
     result:=result+str[i]
  end
  else result:=result+ExtractQuote(str,i);

 end;

end;

function TCustomStatement.Right(str: string; len: integer): string;
var i:integer;
begin
 result:='';
 if len<1 then
  exit;
 if len>length(str) then
 begin
  result:=str;
  exit;
 end;
 for i:=len to length(str) do
  result:=result+str[i];
end;

{ TStructuredVariable }

constructor TStructuredVariable.create(Collection: TCollection);
begin
  inherited create(Collection);

end;

{ TStructuredVariables }

constructor TStructuredVariables.create;
begin
 inherited Create(TStructuredVariable);
end;

end.
