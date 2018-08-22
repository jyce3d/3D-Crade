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

unit frm_SceneEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ImgList;

type
  TEditStatusView=(svZView, svXYView);
  TfrmSceneEditor = class(TForm)
    ToolBar1: TToolBar;
    btnZview: TToolButton;
    imgEditor: TImageList;
    btnXYView: TToolButton;
    procedure btnXYViewClick(Sender: TObject);
    procedure btnZviewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fStatusView:TEditStatusView;
  public
    procedure SetView(status:TEditStatusView);

    { Public declarations }
  end;

var
  frmSceneEditor: TfrmSceneEditor;

implementation

{$R *.DFM}

procedure TfrmSceneEditor.btnXYViewClick(Sender: TObject);
begin
  SetView(svXYView);
end;

procedure TfrmSceneEditor.SetView(status: TEditStatusView);
begin
 fStatusView:=status;
 if status=svZView then begin
  btnZView.Indeterminate :=true;
  btnXYView.Indeterminate:=false;

 end else
 begin
  btnZView.Indeterminate :=false;
  btnXYView.Indeterminate:=true;

 end;
end;


procedure TfrmSceneEditor.btnZviewClick(Sender: TObject);
begin
 SetView(svZView);
end;

procedure TfrmSceneEditor.FormCreate(Sender: TObject);
begin
  SetView(svZView);
end;

end.
