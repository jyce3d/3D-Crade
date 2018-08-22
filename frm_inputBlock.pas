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

unit frm_inputBlock;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,Dialogs;

type
  TfrmInputBlock = class(TForm)
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    txtBlockName: TEdit;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInputBlock: TfrmInputBlock;

implementation

uses Unit1;

{$R *.DFM}

procedure TfrmInputBlock.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TfrmInputBlock.Button1Click(Sender: TObject);
begin
 if frmMain.fDrawer3D.fTree3D.GetScene3DRef(txtBlockName.text,true,nil)<>nil then begin
  if txtBlockName.text<>'MainScene' then begin
   frmMain.BlockName:=txtBlockName.text;
   frmMain.DisplayEditBlock;
   Close;
  end else
   showmessage('Cannot edit the mainscene block, this block is reserved by the system');
 end else
 begin
  showmessage('This block is not defined in the context of 3D-Crade. Please retry');
 end;

end;

procedure TfrmInputBlock.CancelBtnClick(Sender: TObject);
begin
 Close;
end;

end.
