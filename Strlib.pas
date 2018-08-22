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

unit strlib;
//  Unité : String Functions library
 // Author : Jyce3d
 // Creation Date : 24/12/2003

interface

uses SysUtils,classes;
type
  TDummyEncryption=class
   private
   function ConvHexToDec( c : char) : integer;
   procedure InitializeBox(s:string);
   public
   fstreamOut: array of byte;
   fpseudoBox : array of char;
   fpassphrase:string;
   constructor create(pass:string);
   function Encrypt(s:string):string;
   function Decrypt(s:string):string;

  end;

function Left(str:string;len:integer):string;
function Right(str:string;len:integer):string;
function Mid(str:string;midle,len:integer):string;
function GetFirst(str:string; var position:integer;oper:string=','):string;
function GetNext(str:string;var position:integer;oper:string=','):string;
function IsNumeric(str:string):boolean;
function CheckParanth(str:string): boolean;
function RemoveBlank(str: string): string;
function RemoveBlankFromRight(str:string): string;
function NotParanth(str:string):boolean;
function padding(s:string;char:string;len:integer):string;
function isQuoted(s:string):boolean;
function LoadFromFile(const sFileName:string):string;
function ConvertDateTime(DateasDDMMYYYYHHMMSS: string): TDateTime;
function ConvertDate( DateasDDMMYYYY : string ) : TDateTime;
function SafeStringEncode(const str:string):string;
function SafeStringDecode(const str:string):string;
function HtmlEncode(const str:string):string;


implementation

function Left(str: string; len: integer): string;
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

function Mid(str: string; midle, len: integer): string;
var i:integer;
begin
 result:='';
// if len<1 then
//  exit;
 if midle<1 then
  exit;
 if (len+midle>length(str)) then
 begin
  result:=str;
  exit;
 end;
 for i:=midle to len+midle do
  result:=result+str[i];
end;

function Right(str: string; len: integer): string;
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
 for i:=length(str)-len+1 to length(str) do
  result:=result+str[i];
end;

function GetFirst(str:string; var position:integer;oper:string=','):string;
var i:integer;bF:boolean;
begin
 result:='';
 bf:=false;
 for i:=1 to length(str) do begin
  if str[i]<>oper then
  begin
   result:=result+str[i];
  end
  else
  begin
   bf:=true;
   position:=i+1;
   break;
  end;
 end;

 if not bf then
   position:=length(str)+1;

end;

function GetNext(str:string;var position:integer;oper:string=','):string;
var i:integer;
begin
 result:='';
 if position>length(str) then
  exit;

 for i:=position to length(str) do begin
  if str[i]<>oper then
   result:=result+str[i]
  else
  begin
   position:=i+1;
   break;
  end;
 end;
 if i>=length(str) then
  position:=length(str)+1;
end;

function IsNumeric(str: string): boolean;
begin
 try
  strtofloat(str);
  result:=true
 except
  result:=false;
 end;
end;

function CheckParanth(str:string):boolean;
var cp,pos:integer;
 procedure RecurCheckParanth(str:string;var _poss:integer);
 begin

  while _poss<=length(str) do begin

   if str[_poss]='(' then
   begin
    cp:=cp+1;
    _poss:=_poss+1;
    RecurCheckParanth(str,_poss);
   end else
    if str[_poss]=')' then begin
     cp:=cp-1;
     _poss:=_poss+1;
     exit;
    end else
     _poss:=_poss+1;
  end;
 end;
begin
 cp:=0;
 pos:=1;
 RecurCheckParanth(str,pos);
 result:=(cp=0);
end;

// Remove Blank in a string excepted blanks between quotes
function RemoveBlank(str: string): string;
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
   begin
    _bF:=true;
    result:=result+s[pos];
   end;
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
   if not((str[i]=#32) or (str[i]=#9)) then begin // str[i]<>#32 or str[i]<>#9 cfr De Morgan
     result:=result+lowercase(str[i]);

   end;
   inc(i);
  end
  else
   result:=result+ExtractQuote(str,i);
 end;

end;

function NotParanth(str:string):boolean;
var i:integer;
begin
 result:=true;
 for i:=1 to length(str) do
 begin
  if str[i]='(' then begin
   result:=false;
   break;
  end;
 end;
end;

function padding(s:string;char:string;len:integer):string;
var i:integer;
begin
 if length(s)>=len then
  result:=s
 else
 begin
  for i:=1 to len-length(s) do
   s:=s+char;
  result:=s;
 end;
end;

function isQuoted(s:string):boolean;
var i:integer;
begin
 result:=false;
 for i:=1 to length(s) do
  if s[i]='"' then
  begin
   result:=true;
   exit;
  end;
end;
function RemoveBlankFromRight(str:string): string;
var lc:string;
begin
 result:=str;
 lc:=Right(str,1);
 while (lc=' ') do begin
  result:=left(str,LenGth(Str)-1);
  lc:=Right(result,1);
 end;
end;
{ TBeteEncryption }

function TDummyEncryption.ConvHexToDec(c: char): integer;
begin
 if (ord(c)>=48) and (ord(c)<=57) then
  result:=ord(c)-48 else
   result:=ord(c)-65+10;
end;

constructor TDummyEncryption.create(pass: string);
begin
 fpassphrase:=pass;

end;

function TDummyEncryption.Decrypt(s: string): string;
var w: integer; i,cp:integer;
begin
 setlength(fStreamOut,(length(s) div 2)+1);
 InitializeBox(s);
 cp:=1;
 i:=1;
 while i<=length(s)-1 do begin
   w:=ConvHexToDec(s[i])*16+ConvHexToDec(s[i+1]);
   fstreamOut[cp]:=Ord(w) xor Ord(fPseudoBox[cp]);
   cp:=cp+1;
   i:=i+2;
 end;
 for i:=1 to High(fstreamout) do
  result:=result+char(fstreamout[i]);
end;

function TDummyEncryption.Encrypt(s: string): string;
var i:integer;
begin
 //fstreamOut:=TMemoryStream.Create;
 //fstreamOut.SetSize(length(s));
 SetLength(fstreamout,length(s)+1);
 InitializeBox(s);
 for i:=1 to length(s) do
  fstreamout[i]:=Ord(s[i]) xor Ord(fpseudobox[i]);

 for i:=1 to length(s) do
  result:=result+'ar['+inttostr(i-1)+']='+Format('%x',[Ord(fstreamout[i])])+';';


end;
procedure TDummyEncryption.InitializeBox(s:string);
var i,j:integer;
begin
 SetLength(fpseudobox,0);
 SetLength(fpseudobox,length(s)+1);
 j:=1;
 for i:=1 to length(s) do begin
  fpseudobox[i]:=fpassphrase[j];
  inc(j);
  if j>length(fpassphrase) then j:=1;
 end;

end;

function LoadFromFile(const sFileName:string):string;
var sl:TStringList;
begin
 sl:=TStringList.Create;
 sl.LoadFromFile(sFileName);
 result:=sl.Text;
 sl.Free;
end;

function StrReplace(Chaine, sub1, sub2 : string) : string;
var NewStr    : string;
    LastFound : integer;
begin
 NewStr:='';
 LastFound:=Pos(sub1, Chaine);
 while LastFound>0
       do begin
        NewStr:=NewStr+copy(Chaine, 1, LastFound-1)+sub2;
        Chaine:=Copy(Chaine, LastFound + Length(sub1), Length(Chaine)-LastFound+Length(sub1));
        LastFound:=Pos(sub1, Chaine);
       end;
 Result:=NewStr+Copy(Chaine, LastFound, Length(Chaine)-LastFound);
end;

function StrReplaceAll(Chaine, sub1, sub2 : string) : string;
begin
 while pos(UpperCase(sub1),UpperCase(Chaine))>0 do Chaine:=StrReplace(Chaine,Sub1,Sub2);
 StrReplaceAll:=Chaine;
end;



function ConvertDateTime(DateasDDMMYYYYHHMMSS: string): TDateTime;
var p      : integer;
    xDate  : TDateTime;
    HH,MM,SS:integer;
    xHour  : string;
begin
 DateasDDMMYYYYHHMMSS:=Trim(DateasDDMMYYYYHHMMSS);
 StrReplaceALl(DateasDDMMYYYYHHMMSS,#9,' ');
 while pos('  ',DateasDDMMYYYYHHMMSS)>0 do DateasDDMMYYYYHHMMSS:=StrReplace(DateasDDMMYYYYHHMMSS,'  ',' ');

 p:=pos(' ',DateasDDMMYYYYHHMMSS);
 if p>0
   then begin
    xDate:=ConvertDate(copy(DateasDDMMYYYYHHMMSS,1,p-1));
    xHour:=copy(DateasDDMMYYYYHHMMSS,p+1,length(DateasDDMMYYYYHHMMSS)-p);
    xHour:=StrReplace(xHour,';',':');
    xHour:=StrReplace(xHour,' ',':');
    xHour:=StrReplace(xHour,'.',':');
    xHour:=StrReplace(xHour,';',':');
    xHour:=StrReplace(xHour,'h',':');
    xHour:=StrReplace(xHour,'H',':');
    xHour:=StrReplace(xHour,'u',':');
    xHour:=StrReplace(xHour,'U',':');
    xHour:=StrReplace(xHour,'|',':');
    xHour:=StrReplace(xHour,'#',':');
    xHour:=StrReplace(xHour,'/',':');
    xHour:=StrReplace(xHour,'+',':');
    xHour:=StrReplace(xHour,'*',':');
    xHour:=StrReplace(xHour,'-',':');
    xHour:=StrReplace(xHour,',',':');
    xHour:=StrReplace(xHour,'%',':');
    xHour:=StrReplace(xHour,'!',':');
    xHour:=StrReplace(xHour,'"',':');
    xHour:=StrReplace(xHour,'''',':');
    while pos('::',xHour)>0 do xHour:=StrReplace(xHour,'::',':');

    p:=pos(':',xHour);
    if p>0
      then begin
       HH:=StrToIntDef(copy(xHour,1,p-1),0);
       xHour:=copy(xHour,p+1,length(xHour)-p);
       p:=pos(':',xHour);
       if p>0
          then begin
           MM:=StrToIntDef(copy(xHour,1,p-1),0);
           xHour:=copy(xHour,p+1,length(xHour)-p);
           p:=1;
           while (p<length(xHour)) and (xHour[p] in ['0'..'9']) do inc(p);
           xHour:=copy(xHour,1,p-1);
           SS:=StrToIntDef(xHour,0);
          end
          else begin
           MM:=StrToIntDef(xHour,0);
           SS:=0;
          end;
      end
      else begin
       HH:=StrToIntDef(xHour,0);
       MM:=0;
       SS:=0;
      end
   end
   else begin
    xDate:=ConvertDate(DateasDDMMYYYYHHMMSS);
    HH:=0;
    MM:=0;
    SS:=0;
   end;
 ReplaceDate(Result,xDate);
 ReplaceTime(Result,EncodeTime(HH,MM,SS,0));
end;

function ConvertDate( DateasDDMMYYYY : string ) : TDateTime;
var mm, dd, yyyy : integer;
    s : integer;
    i : integer;
    t : string;
begin
 // put the date to the xx/mm/yyyy format
 DateasDDMMYYYY:=Trim(DateasDDMMYYYY);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'/',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'-',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'.',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,',',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'\',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'_',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,':',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'+',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'*',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'#',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'!',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'%',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'?',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,';',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'=',FormatSettings.DateSeparator);
 DateasDDMMYYYY:=StrReplace(DateasDDMMYYYY,'|',FormatSettings.DateSeparator);

 s:=pos(FormatSettings.DateSeparator,DateasDDMMYYYY);
 if s>0 then dd:=StrToIntDef(Copy(DateasDDMMYYYY,1,s-1),1)
        else dd:=1;
 for i:=1 to s do DateasDDMMYYYY[i]:=' ';
 DateasDDMMYYYY:=Trim(DateasDDMMYYYY);

 s:=pos(FormatSettings.DateSeparator,DateasDDMMYYYY);
 if s>0 then mm:=StrToIntDef(Copy(DateasDDMMYYYY,1,s-1),1)
        else mm:=1;
 for i:=1 to s do DateasDDMMYYYY[i]:=' ';
 DateasDDMMYYYY:=Trim(DateasDDMMYYYY);

 yyyy:=StrToIntDef(DateasDDMMYYYY,0);

 if yyyy>0
  then begin
   if yyyy<100
      then begin
        t:=FormatSettings.shortdateformat;
        FormatSettings.shortdateformat:='m'+FormatSettings.DateSeparator+'d'+FormatSettings.DateSeparator+'yy';
        Result:=StrToDate(IntToStr(mm)+FormatSettings.DateSeparator+IntToSTr(dd)+FormatSettings.DateSeparator+IntToSTr(yyyy));
        FormatSettings.shortdateformat:=t;
      end
      else try
        Result:=EncodeDate(yyyy,mm,dd);
      except
        Result:=0;
      end
  end
  else Result:=0;
end;

function SafeStringEncode(const str:string):string;
begin
 result:=stringReplace(str,'''','@@39@@',[rfIgnorecase,rfReplaceAll]);
 result:=stringReplace(result,#13,'@@13@@',[rfIgnorecase,rfReplaceAll]);
 result:=stringReplace(result,#10,'@@10@@',[rfIgnorecase,rfReplaceAll]);


end;
function SafeStringDecode(const str:string):string;
begin
 result:=stringReplace(str,'@@39@@','''',[rfIgnorecase,rfReplaceAll]);
 result:=stringReplace(result,'@@13@@',#13,[rfIgnorecase,rfReplaceAll]);
 result:=stringReplace(result,'@@10@@',#10,[rfIgnorecase,rfReplaceAll]);

end;
function HtmlEncode(const str:string):string;
begin
 result:=stringreplace(str,#13#10,'<br>',[rfIgnorecase,rfReplaceAll]);
end;
end.

