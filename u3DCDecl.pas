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

//Ateur:Jyce3d, 2005
unit u3DCDecl;

interface
uses Context,SysUtils;
 procedure InitSystemVariables3D(context:TCustomContext);
 procedure IsometricView(Context:TcustomContext);
 procedure LeftView(Context:TcustomContext);
 procedure UpView(Context:TcustomContext);
 procedure FaceView(Context:TcustomContext);
 procedure SetScale(Const iVal:integer;Context:TCustomContext);

implementation


procedure InitSystemVariables3D(context:TCustomContext);
var varf:TCustomVariable;
begin
 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fName:='_Rhoeye';
  ftype:=vtFloat;
  fValue:='100';
  fprotected:=true;
 end;

 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fName:='_Colatiteye';
  ftype:=vtFloat;
  fValue:=floattostr(pi/4);
  fprotected:=true;
 end;
 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fName:='_Azimutheye';
  ftype:=vtFloat;
  fValue:=floattostr(pi/4);
  fprotected:=true;
 end;

 varf:=context.Variables.add as TCustomVariable;
 with varf do begin
  fName:='_Zeye';
  ftype:=vtFLoat;
  fValue:='30';
  fprotected:=true;
 end;

 varf:=context.Variables.add as TCustomVariable;
 with varf do begin
  fName:='_RulerDiv';
  ftype:=vtFloat;
  fValue:='30';
  fprotected:=true;
 end;

 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fName:='_Scale';
  ftype:=vtFloat;
  fValue:='9';    // 1m=10 pixel
  fprotected:=true;
 end;

 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fName:='_ViewRuler';
  ftype:=vtfloat;
  fvalue:='1';
  fprotected:=true;
 end;

 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fName:='_ViewAxes';
  ftype:=vtFloat;
  fvalue:='1';
  fprotected:=true;
 end;

 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fName:='_PolygonFrames';
  ftype:=vtFloat;
  fvalue:='1';
  fprotected:=true;
 end;
 // New requirements  : June 2005
 // Translation
 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fname:='_XTranslate';
  ftype:=vtFloat;
  fValue:='0';
  fprotected:=true;
 end;

 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fname:='_YTranslate';
  ftype:=vtFloat;
  fValue:='0';
  fprotected:=true;
 end;

 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fname:='_ZTranslate';
  ftype:=vtFloat;
  fValue:='0';
  fprotected:=true;
 end;
 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fname:='_CursorInc';
  ftype:=vtFloat;
  fValue:='1';
  fprotected:=true;
 end;
 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fname:='_RadianInc';
  ftype:=vtFloat;
  fValue:=FloatTostr(pi/100);
  fprotected:=true;
 end;

 varf:=context.Variables.Add as TCustomVariable;
 with varf do begin
  fName:='pi';
  ftype:=vtFloat;
  fvalue:=floattostr(pi);
  fprotected:=true;
 end;

 //varf:=context.Variables.Add as TCustomVariable;


end;
procedure IsometricView(Context:TcustomContext);
begin
 context.SetFloatValue('_Colatiteye',pi/4);
 context.SetFloatValue('_Azimutheye',pi/4);

end;
procedure LeftView(Context:TcustomContext);
begin
 context.SetFloatValue('_Colatiteye',pi/2);
 context.SetFloatValue('_Azimutheye',pi/2);//pi instead of pi/2

end;
procedure UpView(Context:TcustomContext);
begin
 context.SetFloatValue('_Colatiteye',0);
 context.SetFloatValue('_Azimutheye',0);

end;
procedure FaceView(Context:TcustomContext);
begin
 context.SetFloatValue('_Colatiteye',pi/2);
 context.SetFloatValue('_Azimutheye',0);

end;
procedure SetScale(Const iVal:integer;Context:TCustomContext);
begin
 Context.SetFloatValue('_Scale',iVal);
end;
end.
