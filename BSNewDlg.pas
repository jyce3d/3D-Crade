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

unit BSNewDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TOKRightDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    txtXFactor: TEdit;
    Label2: TLabel;
    txtYFactor: TEdit;
    Label3: TLabel;
    txtZFactor: TEdit;
    txtModuleXY: TEdit;
    Label4: TLabel;
    txtModuleZ: TEdit;
    Label5: TLabel;
    txtKeyname: TEdit;
    Label6: TLabel;
    chkHeels: TCheckBox;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OKRightDlg: TOKRightDlg;

implementation
uses frmBody ;
{$R *.DFM}

procedure TOKRightDlg.OKBtnClick(Sender: TObject);
begin
 g_frmBody.fXfactor:=strtofloat(txtXFactor.Text);
 g_frmBody.fYfactor:=strtofloat(txtYFactor.Text);
 g_frmBody.FZFactor:=strtofloat(txtZFactor.text);

 g_frmBody.FModuleXY:=strtofloat(txtModuleXY.text);
 g_frmBody.FModuleZ:=strtofloat(txtModuleZ.Text);

 g_frmBody.fKeyname:=txtKeyname.Text;
end;

end.
