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

unit FRM_Translate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,Scene3D,ClipBrd,math;


  
type

  TfrmTranslate = class(TForm)
    Label1: TLabel;
    cboFrom: TComboBox;
    lstFrom: TListBox;
    Label2: TLabel;
    cboTo: TComboBox;
    lstTo: TListBox;
    cmdApply: TButton;
    cmdCancel: TButton;
    cmdXFromSort: TButton;
    cmdYFromSort: TButton;
    cmdZFromSort: TButton;
    cmdYToSort: TButton;
    cmdXToSort: TButton;
    cmdZToSort: TButton;
    cmdCopyL: TButton;
    cmdCopyR: TButton;
    procedure cmdApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cboFromChange(Sender: TObject);
    procedure cboToChange(Sender: TObject);
    procedure cmdXFromSortClick(Sender: TObject);
    procedure cmdZFromSortClick(Sender: TObject);
    procedure cmdYFromSortClick(Sender: TObject);
    procedure cmdXToSortClick(Sender: TObject);
    procedure cmdYToSortClick(Sender: TObject);
    procedure cmdZToSortClick(Sender: TObject);
    procedure cmdCopyLClick(Sender: TObject);
    procedure cmdCopyRClick(Sender: TObject);
  private
    { Private declarations }
    fiFromCriteria:integer;
    fiToCriteria:integer;
    procedure DisplayToContent;
    procedure DisplayFromContent;
     // Sorting procedure
  public
    { Public declarations }
  end;

var
  frmTranslate: TfrmTranslate;

implementation

uses Unit1, Unit3,MayeSurf;

{$R *.DFM}


procedure TfrmTranslate.cmdApplyClick(Sender: TObject);
var StrCommand:string;  EdgeFrom:TMayeEdge; EdgeTo:TMayeEdge;

begin
if cboFrom.ItemIndex=-1 then
begin
 ShowMessage('You must choose a "From" object');
 exit;
end;
if cboTo.ItemIndex=-1 then
begin
 ShowMessage('You must choose a "To" object');
 exit;
end;
EdgeFrom:=lstFrom.Items.Objects[lstFrom.ItemIndex] as TMayeEdge;
EdgeTo:=lstTO.Items.Objects[lstTo.ItemIndex] as TMayeEdge;

 StrCommand:='translate('+floattostr(EdgeTo.x-EdgeFrom.x)+','+floattostr(EdgeTo.y-EdgeFrom.y)+','+floattostr(EdgeTo.z-EdgeFrom.z)+',"'+cboFrom.Text+'")';
 Form3.txtCommand.text:=strCommand;
 close;
end;

procedure TfrmTranslate.FormCreate(Sender: TObject);
var i:integer;
begin
 lstFrom.Enabled:=false;
 for i:=0 to frmMain.fDrawer3D.MayeSurface3DList.count -1 do
  cboFrom.Items.Add((frmMain.fDrawer3D.MayeSurface3DList.Items[i] as TObject3D).KeyName);

 lstTo.Enabled:=false;
 for i:=0 to frmMain.fDrawer3D.MayeSurface3DList.Count - 1 do
  cboTo.items.Add((frmMain.fDrawer3D.MayeSurface3DList.items[i] as TObject3D).KeyName);

 fiToCriteria:=SortOnXAsc;
 fiFromCriteria:=SortOnXAsc;
end;

procedure TfrmTranslate.cmdCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmTranslate.cboFromChange(Sender: TObject);
begin
 if cboFrom.itemindex=-1 then
  lstFrom.Enabled:=false
 else begin
  DisplayFromContent;
 end;
end;

procedure TfrmTranslate.cboToChange(Sender: TObject);
begin
 if cboTo.itemindex=-1 then
  lstTo.Enabled:=false
 else begin
  DisplayToContent;
 end;
end;


procedure TfrmTranslate.cmdXFromSortClick(Sender: TObject);
begin
 fiFromCriteria:=SortOnXAsc;
 if cboFrom.itemIndex<>-1 then
  DisplayFromContent;
end;

procedure TfrmTranslate.cmdZFromSortClick(Sender: TObject);
begin
  fiFromCriteria:=SortOnZAsc;
   if cboFrom.itemIndex<>-1 then
  DisplayFromContent;

end;

procedure TfrmTranslate.cmdYFromSortClick(Sender: TObject);
begin
fiFromCriteria:=SortOnYAsc;
 if cboFrom.itemIndex<>-1 then
  DisplayFromContent;

end;

procedure TfrmTranslate.DisplayFromContent;
var MayeSurface3D:TMayeSurface3D; MayeTriFace3D:TMayeTriFace3D;
    i,j:integer;
    _MayeEdgeListRef:array of TMayeEdge;
    CurrentCount:integer;

begin
  MayeSurface3D:=frmMain.fDrawer3D.MayeSurface3DList.MayeSurface3D[cboFrom.ItemIndex];
  lstFrom.Enabled:=true;
  lstFrom.Items.Clear;
  CurrentCount:=0;
  SetLength(_MayeEdgeListRef,CurrentCOunt);
  for i:=0 to MayeSurface3D.fMayeTriFace3DList.count -1 do
  begin
    MayeTriFace3D:=MayeSurface3D.fMayeTriFace3DList.MayeTriFace3D[i];
    SetLength(_MayeEdgeListRef,CurrentCount+MayeTriFace3D.fMayeEdgeList.Count);
    for j:=0 to MayeTriFace3D.fMayeEdgeList.Count -1 do
     _MayeEdgeListRef[j+CurrentCount]:=MayeTriFace3D.fMayeEdgeList.Edge[j];
    CurrentCount:=CurrentCount+MayeTriFAce3D.fMayeEdgeList.count;
  end;
  Sort(_MayeEdgeListRef,fiFromCriteria);
  for j:=0 to High(_MayeEdgeListRef) do
      lstFrom.Items.AddObject('('+Format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).x])+','+Format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).y])+','+format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).z])+')',(_MayeEdgeListRef[j] as TMayeEdge));
  SetLength(_MayeEdgeListRef,0);

end;

procedure TfrmTranslate.DisplayToContent;
var MayeSurface3D:TMayeSurface3D; MayeTriFace3D:TMayeTriFace3D;
    i,j:integer;
    _MayeEdgeListRef:array of TMayeEdge;
   CurCount:integer;
begin
  MayeSurface3D:=frmMain.fDrawer3D.MayeSurface3DList.MayeSurface3D[cboTo.ItemIndex];
  lstTo.Enabled:=true;
  lstTo.Items.Clear;
  CurCount:=0;
  SetLength(_MayeEdgeListRef,CurCount);
  for i:=0 to MayeSurface3D.fMayeTriFace3DList.count -1 do
  begin
   MayeTriFace3D:=MayeSurface3D.fMayeTriFace3DList.MayeTriFace3D[i];
   SetLength(_MayeEdgeListRef,CurCount+MayeTriFace3D.fMayeEdgeList.Count);
   for j:=0 to MayeTriFace3D.fMayeEdgeList.Count -1 do
    _MayeEdgeListRef[j+CurCount]:=MayeTriFace3D.fMayeEdgeList.Edge[j];
   CurCount:=CurCount+MayeTriFace3D.fMayeEdgeList.count;
  end;
  Sort(_MayeEdgeListRef,fiTOCriteria);
  for j:=0 to High(_MayeEdgeListRef) do
    lstTo.Items.AddObject('('+Format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).x])+','+Format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).y])+','+format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).z])+')',(_MayeEdgeListRef[j] as TMayeEdge));
  SetLength(_MayeEdgeListRef,0);

end;

procedure TfrmTranslate.cmdXToSortClick(Sender: TObject);
begin
 fiToCriteria:=SortOnXAsc;
 if cboTo.itemIndex<>-1 then
  DisplayToContent;

end;

procedure TfrmTranslate.cmdYToSortClick(Sender: TObject);
begin
 fiToCriteria:=SortOnYAsc;
 if cboTo.itemIndex<>-1 then
  DisplayToContent;

end;

procedure TfrmTranslate.cmdZToSortClick(Sender: TObject);
begin
 fiToCriteria:=SortOnZAsc;
 if cboTo.itemIndex<>-1 then
  DisplayToContent;

end;

procedure TfrmTranslate.cmdCopyLClick(Sender: TObject);
begin
 if lstFrom.ItemIndex>-1 then
  clipboard.AsText:=lstFrom.Items[lstFrom.ItemIndex];

end;

procedure TfrmTranslate.cmdCopyRClick(Sender: TObject);
begin
 if lstTo.ItemIndex>-1 then
  clipboard.AsText:=lstTo.Items[lstTo.ItemIndex];

end;


end.
