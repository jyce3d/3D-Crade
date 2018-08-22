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

// 3D-Crade Commander
// Author:Jyce3d, 2003
unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,Parser,Scene3D,CustomParser;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    txtCommand: TEdit;
    mmoOutput: TMemo;
    Label1: TLabel;
    procedure txtCommandKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fStatement:TParser;
    foutput:TStringList;
//    fScene:TScene3D;
  public
    { Public declarations }
     procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  Form3: TForm3;


implementation

uses Unit1;

{$R *.DFM}

procedure TForm3.txtCommandKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var   status:string; i :integer;
        sCommand,sContent:string;
begin
 if Key=13 then
 begin
  fOutput.Clear;
  if fStatement.Parse(txtCommand.Text,sCommand,sContent)=PARSE_OK then status:='-->DONE' else status:='-->FAILED';
  mmooutput.Lines.Add(txtCommand.text+status);
  if fOutput.count>=1 then
   for i:=0 to foutput.count-1 do
    mmooutput.Lines.Add(foutput[i]);
  txtCommand.Text:='';

  FrmMain.RefreshView;
 end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
 fOutput:=TStringList.Create;
 // Test matrix waste
 Left:=0;
 Top:=round(frmMain.CLientHeight*0.7);
 Width:=frmMain.ClientWidth;
 Height:=round(frmMain.ClientHeight * 0.3);
 fStatement:=TParser.Create(frmMain.fcontext,frmMain.fDrawer3D,foutput);
end;


procedure TForm3.FormDestroy(Sender: TObject);
begin
 fOutput.Free;
 fStatement.Free;
end;



procedure TForm3.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style XOR WS_CAPTION;
  Params.Style := Params.Style XOR WS_SIZEBOX;
end;

end.
