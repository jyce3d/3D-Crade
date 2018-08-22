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

unit FRM_FrameBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,Scene3D;

type
  TfrmFrameBox = class(TForm)
    cbo2Point: TComboBox;
    btn2XSort: TButton;
    btn2YSort: TButton;
    btn2ZSort: TButton;
    lst2Point: TListBox;
    cbo1Point: TComboBox;
    btn1SortX: TButton;
    btn1YSort: TButton;
    btn1ZSort: TButton;
    lst1Point: TListBox;
    txt2PointX: TEdit;
    txt2PointY: TEdit;
    txt2PointZ: TEdit;
    txt1PointX: TEdit;
    txt1PointY: TEdit;
    txt1PointZ: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    txtnLong: TEdit;
    txtnLat: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    txtColor: TEdit;
    Label6: TLabel;
    txtKeyname: TEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbo1PointChange(Sender: TObject);
    procedure cbo2PointChange(Sender: TObject);
    procedure btn1SortXClick(Sender: TObject);
    procedure btn1YSortClick(Sender: TObject);
    procedure btn1ZSortClick(Sender: TObject);
    procedure btn2XSortClick(Sender: TObject);
    procedure btn2YSortClick(Sender: TObject);
    procedure btn2ZSortClick(Sender: TObject);
    procedure lst1PointClick(Sender: TObject);
    procedure lst2PointClick(Sender: TObject);
  private
    { Private declarations }
    f1PointCriteria,
    f2PointCriteria : integer;
    procedure Display1PointContent;
    procedure Display2PointContent;
  public
    { Public declarations }
  end;

var
  frmFrameBox: TfrmFrameBox;

implementation

uses Unit1,MayeSurf, Unit3;

{$R *.DFM}

procedure TfrmFrameBox.btnCancelClick(Sender: TObject);
begin
close;
end;

procedure TfrmFrameBox.btnApplyClick(Sender: TObject);
var x1,y1,z1,
    x2,y2,z2,
    nLong,nLat : extended;

    cx,cy,cz:extended;
    length,width,height:extended;

    color:string;

    strCommand:string;
begin
 if txt1Pointx.text='' then
  txt1Pointx.text:='0';
 if txt1Pointy.text='' then
  txt1Pointy.text:='0';
 if txt1Pointz.text='' then
  txt1Pointz.text:='0';

 if txt2Pointx.text='' then
  txt2Pointx.text:='0';
 if txt2Pointy.text='' then
  txt2Pointy.text:='0';
 if txt2Pointz.text='' then
  txt2Pointz.text:='0';

 if txtnLat.text='' then
  txtnLat.text:='0';

 if txtnLong.text='' then
  txtnLong.text:='0';

 if txtColor.text='' then
  txtcolor.text:='0';

 x1:=strtofloat(txt1Pointx.text);
 y1:=strtofloat(txt1pointY.text);
 z1:=strtofloat(txt1pointZ.text);

 x2:=strtofloat(txt2Pointx.text);
 y2:=strtofloat(txt2pointY.text);
 z2:=strtofloat(txt2pointZ.text);

 nLong:=strtofloat(txtnLong.text);
 nLat:=strtofloat(txtnLat.Text);

 color:=txtcolor.text;

 if z1=z2 then
  nLat:=0 else
   if y1=y2 then
    nLong:=0 else
     if x1=x2 then
      nLong:=0;

  cx:=(x1+x2)/2;
  cy:=(y1+y2)/2;
  cz:=(z1+z2)/2;

  length:=(x2-x1)/2;
  width:=(y2-y1)/2;
  height:=(z2-z1)/2;

 StrCommand:='_framebox('+floattostr(cx)+','+floattostr(cy)+','+floattostr(cz)+','+floattostr(length)+','+floattostr(width)+','+floattostr(height)+','+floattostr(nLong)+','+floattostr(nLat)+','+color+',"_default",0,"'+txtKeyname.text+'")';
 Form3.txtCommand.text:=strCommand;

// at the end close

 close;
end;

procedure TfrmFrameBox.FormCreate(Sender: TObject);
var i:integer;
begin
 for i:=0 to frmMain.fDrawer3D.MayeSurface3DList.count -1 do
  cbo1Point.Items.Add((frmMain.fDrawer3D.MayeSurface3DList.Items[i] as TObject3D).KeyName);

 for i:=0 to frmMain.fDrawer3D.MayeSurface3DList.count -1 do
  cbo2Point.Items.Add((frmMain.fDrawer3D.MayeSurface3DList.Items[i] as TObject3D).KeyName);


 f1PointCriteria:=SortOnXAsc;
 f2PointCriteria:=SortOnXAsc;

end;

procedure TfrmFrameBox.Display1PointContent;
var MayeSurface3D:TMayeSurface3D; MayeTriFace3D:TMayeTriFace3D;
    i,j:integer;
    _MayeEdgeListRef:array of TMayeEdge;
    CurrentCount:integer;

begin
  MayeSurface3D:=frmMain.fDrawer3D.MayeSurface3DList.MayeSurface3D[cbo1Point.ItemIndex];
  lst1Point.Enabled:=true;
  lst1Point.Items.Clear;
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
  Sort(_MayeEdgeListRef,f1PointCriteria);
  for j:=0 to High(_MayeEdgeListRef) do
      lst1Point.Items.AddObject('('+Format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).x])+','+Format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).y])+','+format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).z])+')',(_MayeEdgeListRef[j] as TMayeEdge));
  SetLength(_MayeEdgeListRef,0);

end;

procedure TfrmFrameBox.Display2PointContent;
var MayeSurface3D:TMayeSurface3D; MayeTriFace3D:TMayeTriFace3D;
    i,j:integer;
    _MayeEdgeListRef:array of TMayeEdge;
   CurCount:integer;
begin
  MayeSurface3D:=frmMain.fDrawer3D.MayeSurface3DList.MayeSurface3D[cbo2Point.ItemIndex];
  lst2Point.Enabled:=true;
  lst2Point.Items.Clear;
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
  Sort(_MayeEdgeListRef,f2PointCriteria);
  for j:=0 to High(_MayeEdgeListRef) do
    lst2Point.Items.AddObject('('+Format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).x])+','+Format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).y])+','+format('%8.13f',[(_MayeEdgeListRef[j] as TMayeEdge).z])+')',(_MayeEdgeListRef[j] as TMayeEdge));
  SetLength(_MayeEdgeListRef,0);

end;

procedure TfrmFrameBox.cbo1PointChange(Sender: TObject);
begin
 if cbo1Point.itemindex=-1 then
  lst1Point.Enabled:=false
 else begin
  Display1PointContent;
 end;

end;

procedure TfrmFrameBox.cbo2PointChange(Sender: TObject);
begin
 if cbo2Point.itemindex=-1 then
  lst2Point.Enabled:=false
 else begin
  Display2PointContent;
 end;

end;

procedure TfrmFrameBox.btn1SortXClick(Sender: TObject);
begin
 f1PointCriteria:=SortOnXAsc;
 if cbo1Point.itemIndex<>-1 then
  Display1PointContent;

end;

procedure TfrmFrameBox.btn1YSortClick(Sender: TObject);
begin
 f1PointCriteria:=SortOnYAsc;
 if cbo1Point.itemIndex<>-1 then
  Display1PointContent;

end;

procedure TfrmFrameBox.btn1ZSortClick(Sender: TObject);
begin
 f1PointCriteria:=SortOnZAsc;
 if cbo1Point.itemIndex<>-1 then
  Display1PointContent;

end;

procedure TfrmFrameBox.btn2XSortClick(Sender: TObject);
begin
 f2PointCriteria:=SortOnXAsc;
 if cbo2Point.itemIndex<>-1 then
  Display2PointContent;

end;

procedure TfrmFrameBox.btn2YSortClick(Sender: TObject);
begin
 f2PointCriteria:=SortOnYAsc;
 if cbo2Point.itemIndex<>-1 then
  Display2PointContent;

end;

procedure TfrmFrameBox.btn2ZSortClick(Sender: TObject);
begin
 f2PointCriteria:=SortOnZAsc;
 if cbo2Point.itemIndex<>-1 then
  Display2PointContent;

end;

procedure TfrmFrameBox.lst1PointClick(Sender: TObject);
begin
 if lst1Point.ItemIndex<>-1 then begin
  txt1PointX.Text:= floattostr((lst1Point.Items.Objects[lst1Point.ItemIndex] as TMayeEdge).x);
  txt1PointY.Text:= floattostr((lst1Point.Items.Objects[lst1Point.ItemIndex] as TMayeEdge).y);
  txt1PointZ.Text:= floattostr((lst1Point.Items.Objects[lst1Point.ItemIndex] as TMayeEdge).z);

 end;
end;

procedure TfrmFrameBox.lst2PointClick(Sender: TObject);
begin
 if lst2Point.ItemIndex<>-1 then begin
  txt2PointX.Text:= floattostr((lst2Point.Items.Objects[lst2Point.ItemIndex] as TMayeEdge).x);
  txt2PointY.Text:= floattostr((lst2Point.Items.Objects[lst2Point.ItemIndex] as TMayeEdge).y);
  txt2PointZ.Text:= floattostr((lst2Point.Items.Objects[lst2Point.ItemIndex] as TMayeEdge).z);
 end;

end;

end.
