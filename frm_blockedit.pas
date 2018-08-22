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

unit frm_blockedit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Scene3D,
  StdCtrls, ExtCtrls,CustomTree;

type
  TfrmBlockEdit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    txtBlockName: TEdit;
    Label2: TLabel;
    lstAvailable: TListBox;
    btnCancel: TButton;
    btnSave: TButton;
    btnAdd: TButton;
    lstBlock: TListBox;
    Label3: TLabel;
    Label4: TLabel;
    cboParentBlock: TComboBox;
    btnRemove: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
  private
    { Private declarations }
    BlockToEdit:TScene3D;
    procedure _Initialize(BlockRef: TTreeItemRef);
    procedure RecurSceneChild(Scene3DRef:TTreeItemRef;ExitNodeName:string;slScene:TStringList);
    procedure RecurObject3DList(Scene3DRef:TTreeItemRef;CurEditBlock:TScene3D;lstAvailable,lstBlock:TListbox);
    function  isObjectBelongBLock(Object3D:TObject3D;CurEditBlock:TScene3D):boolean;

  public
    { Public declarations }
  end;

var
  frmBlockEdit: TfrmBlockEdit;

implementation

uses Unit1, frmViewObjects;

{$R *.DFM}

procedure TfrmBlockEdit.btnCancelClick(Sender: TObject);
begin
  if frmMain.BLockName='' then
   BlockToEdit.free;
  Close;
end;

procedure TfrmBlockEdit.btnSaveClick(Sender: TObject);
var Scene3D:TScene3D;ParentScene3DRef,CurrentScene3DRef:TTreeItemRef;
begin
 if txtBlockName.Text='' then
 begin
  showmessage('A block must have a blockname');
  exit;
 end;
 if lstBlock.Items.Count=0 then
 begin
  ShowMessage('A block must contain at least one item');
  exit;
 end;
 if frmMain.BlockName='' then
 begin
  ParentScene3DRef:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(cboParentBlock.Text,true,nil);
  Scene3D:=frmMain.fDrawer3D.fTree3D.Add(ParentScene3DRef) as TScene3D;
  Scene3D.KeyName:=self.txtBlockName.Text;
  // assign the drawer after creation to remove the pointer failure
  Scene3D.Drawer3D:=frmMain.fDrawer3d;
 end else
 begin
  // remove the link if necessarry
  // if you are changing the parent of the current scene
  CurrentScene3DRef:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(frmMain.BLockName,true,nil);
  ParentScene3DRef:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(cboParentBlock.Text,true,nil);
  Scene3D:=CurrentScene3DRef.Value as TScene3D;
  if ParentScene3DRef<>CurrentScene3DRef.fparentNode then
   frmMain.fDrawer3D.fTree3D.MoveScene3D(CurrentScene3DRef,ParentScene3DRef,Scene3D);
 end;
 // Vire toutes les sous référence
 // Initialiser la propriété fparent pour les scènes 3D.
 if ParentScene3DRef<>nil then
  Scene3D.fParent:=ParentScene3DRef.Value as TScene3D else
   Scene3D.fParent:=nil;
 CurrentScene3DRef:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(Scene3D.KeyName,true,nil);
 _Initialize(CurrentScene3DRef);         // Les blocs du bloc doivent être placés, s'il n'existe pas
 // dans le bloc courant
 // les autres blocs disponibles doivent être placés dans le parent
 frm3DObject.Initalize_Objects(frmMain.fDrawer3D);        // Refresh the Object 3D TreeView
 Close;
end;

procedure TfrmBlockEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TfrmBlockEdit.RecurSceneChild(Scene3DRef:TTreeItemRef;ExitNodeName:string;slScene:TStringList);
var i:integer; ItemRef:TTreeItemRef;
begin
 for i:=0 to Scene3DRef.fChildNodes.Count -1 do
 begin
  ItemRef:=(Scene3DRef.fChildNodes.items[i] as TTreeItemRef);
  if (ItemRef.Value as TScene3D).KeyName=ExitNodeName then
   break else
  begin
   slScene.Add((ItemRef.Value as TScene3D).KeyName);
   RecurSceneChild(ItemRef,ExitNodeName,slScene);
  end;
 end;
end;
// description : Check if the current object belongs the the existing block or belongs to a
// sub-block of the existing block
function TfrmBlockEdit.isObjectBelongBLock(Object3D:TObject3D;CurEditBlock:TScene3D):boolean;
var ParentScene:TScene3D;
begin
 result:=false;
 if CurEditBlock=nil then exit;
 ParentScene:=(Object3D.fparent as TScene3d);
 while ParentScene<>nil do
 begin
  if ParentScene.KeyName=CurEditBlock.KeyName then
  begin
   result:=true;
   break;
  end else
   ParentScene:=ParentScene.fParent;
 end;
end;
// Create the available object list to insert in the block

procedure TfrmBlockEdit.RecurObject3DList(Scene3DRef:TTreeItemRef;CurEditBlock:TScene3D;lstAvailable,lstBlock:TListbox);
var i:integer; Scene3D : TScene3D; Object3D:TObject3D;
begin
Scene3D:=Scene3DRef.Value as TScene3D;
if (Scene3D.fparent=nil) or (Scene3D=curEditBlock) then
begin
   for i:=0 to Scene3D.fPoint3DRefList.Count -1 do
   begin
    Object3D:=(Scene3D.fPoint3DRefList.Items[i] as TObject3DRef).Value;
    if not isObjectBelongBLock(Object3D,curEditBlock) then
    lstAvailable.Items.Add((Object3D as TPoint3D).KeyName) else
     lstBlock.Items.Add((Object3D as TPoint3D).KeyName)
   end;
   for i:=0 to Scene3D.fLine3DRefList.Count -1 do
   begin
    Object3D:=(Scene3D.fLine3DRefList.Items[i] as TObject3DRef).Value;
    if not isObjectBelongBLock(Object3D,curEditBlock) then
     lstAvailable.Items.Add((Object3D as TLine3D).KeyName) else
      lstBlock.Items.Add((Object3D as TLine3D).KeyName)

   end;
   for i:=0 to Scene3D.fFrame3DRefList.Count -1 do
   begin
    Object3D:=(Scene3D.fFrame3DRefList.Items[i] as TObject3DRef).Value;
    if not isObjectBelongBLock(Object3D,CurEditBlock) then
     lstAvailable.Items.Add((Object3D as TFrame3D).KeyName) else
      lstBlock.Items.Add((Object3D as TFrame3D).KeyName)

   end;
   for i:=0 to Scene3D.fMayeSurface3DRefList.Count -1 do
   begin
    Object3D:=(Scene3D.FMayeSurface3DRefList.Items[i] as TObject3DRef).Value;
    if not isObjectBelongBLock(Object3D,CurEditBlock) then
     lstAvailable.Items.Add((Object3D as TMayeSurface3D).KeyName) else
        lstBlock.Items.Add((Object3D as TMayeSurface3D).KeyName)

   end;
 end;
 for i:=0 to Scene3Dref.fChildnodes.Count -1 do begin
   Scene3D:=(Scene3DRef.fChildnodes.Items[i] as TTreeItemRef).Value as TScene3D;
   if CurEditBlock<>nil then begin
    if not (Scene3D.KeyName=CurEditBlock.KeyName) then begin
     if not isObjectBelongBLock(Scene3D,CurEditBlock) then
      lstAvailable.Items.Add(Scene3D.KeyName) else
      lstBlock.Items.Add(Scene3D.KeyName);
    end;
   end else
    begin
     if not isObjectBelongBLock(Scene3D,CurEditBlock) then
      lstAvailable.Items.Add(Scene3D.KeyName) else
      lstBlock.Items.Add(Scene3D.KeyName);

    end;
  RecurObject3DList((Scene3DRef.fChildNodes.Items[i] as TTreeItemRef),CurEditBlock,lstAvailable,lstBlock);
 end;
end;

procedure TfrmBlockEdit.FormCreate(Sender: TObject);
var slScene:TStringList;
    i : integer;
    ItemRef:TTreeItemRef;
begin
// Initialise la liste des
 if frmMain.BlockName='' then
  BlockToEdit:=nil else
 begin
   ItemRef:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(frmMain.BlockName,true,nil);
   if ItemRef<>nil then
    BlockToEdit:=ItemRef.value as TScene3D else
     Raise Exception.Create('TFrmBlockToEdit::FormCreate:The Block '+frmMain.BLockName+' does not exist.');
 end;
 if BlockToEdit<>nil then
  self.txtBlockName.text:=BlockToEdit.KeyName;

 slScene:=TStringList.Create;
 slScene.add(frmMain.fDrawer3D.Scene3D.KeyName) ;       // ajoute par défaut la première scène

 if BlockToEdit<>nil then
  RecurSceneChild(frmMain.FDrawer3D.Scene3DRef,BlockToEdit.Keyname,slScene);

 for i:=0 to slScene.count -1 do
  cboParentBlock.Items.Add(slScene.Strings[i]);

 cboParentBLock.ItemIndex:=0;
 // create the lsAvailable and lstBlock
 RecurObject3DList(frmMain.fDrawer3D.Scene3DRef,blockToEdit, lstAvailable,lstBlock);

 slScene.Free;
end;

procedure TfrmBlockEdit._Initialize(BlockRef: TTreeItemRef);
var i:integer; obj3D:TObject3D;ParentScene3DRef:TTreeItemRef;
    BlockRef2:TTreeItemRef;Scene3D:TScene3D;
begin
 // Récupère tous les objets placé dans la list box et les ajoute au bloc

 for i:=0 to lstBlock.Items.COunt-1 do
 begin
  obj3D:=frmMain.fDrawer3D.GetObject3D(lstBlock.Items[i]);
  if (Obj3D<>nil) then begin
   ParentScene3DRef:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(Obj3D.fParent.KeyName,true,nil);
   if ParentScene3DRef.value<>BlockRef.value then
   frmMain.fDrawer3D.fTree3D.MoveObject3D(ParentScene3DRef,BlockRef,Obj3D);
  end else // TODO: The Scene case
  begin
   Scene3D:=frmMain.fDrawer3D.GetScene3D(lstBlock.Items[i]);
   if scene3D=nil then
    raise Exception.Create('TFRMBlockEdit::_Initialize:This Scene doesnot exist');
   ParentScene3DRef:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(Scene3D.fparent.keyname,true,nil);
   if ParentScene3DRef.Value<>BlockRef.Value then
    frmMain.fDrawer3D.ftree3D.MoveScene3D(ParentScene3DRef,BlockRef,Scene3D);
  end;
 end;
 // s'occupe des autres block   ssi le parent de ces blocs sont les même que l'ancien block

 for i:=0 to self.lstAvailable.Items.Count -1 do
 begin
  obj3D:=frmMain.fDrawer3D.GetObject3D(lstAvailable.Items[i]);
  if Obj3D<>nil then begin
   if Obj3D.fParent=BlockRef.Value then
   begin
    BlockRef2:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(cboParentBlock.Text,true,nil);
    ParentScene3DRef:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(Obj3D.fParent.KeyName,true,nil);
    if ParentScene3DRef.Value<>Blockref2.Value then
      frmMain.fDrawer3D.fTree3D.MoveObject3D(ParentScene3DRef,BlockRef2,Obj3D);
   end;
  end else
  begin
   Scene3D:=frmMain.fDrawer3D.GetScene3D(lstAvailable.Items[i]);
   if scene3D=nil then
    raise Exception.Create('TFRMBlockEdit::_Initialize:This Scene doesnot exist');
   if Scene3D.fParent=BlockRef.Value then
   begin
    BlockRef2:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(cboParentBlock.Text,true,nil);
    ParentScene3DRef:=frmMain.fDrawer3D.fTree3D.GetScene3DRef(Scene3D.fParent.KeyName,true,nil);
    if ParentScene3DRef.Value<>Blockref2.Value then
     frmMain.fDrawer3D.fTree3D.MoveScene3D(ParentScene3DRef,BlockRef2,Scene3D);
   end;
  end;
 end;
end;

procedure TfrmBlockEdit.FormDestroy(Sender: TObject);
begin
 //BlockToEditList.Free;
end;

procedure TfrmBlockEdit.btnAddClick(Sender: TObject);
var i:integer;bExist:boolean;
begin
// Send from lstAvailable to lstBlock
 bExist:=false;
 if lstAvailable.ItemIndex=-1 then
  exit;
 for i:= 0 to lstBlock.Items.Count-1 do
  if lstBlock.Items[i]=lstAvailable.Items[lstAvailable.ItemIndex] then
  begin
   bExist:=true;
   break;
  end;

 if bExist then exit;

 lstBlock.Items.Add(lstAvailable.Items[lstAvailable.ItemIndex]);
 lstAvailable.Items.Delete(lstAvailable.ItemIndex);
end;

procedure TfrmBlockEdit.btnRemoveClick(Sender: TObject);
begin
 if lstBlock.ItemIndex=-1 then
  exit;

 lstAvailable.Items.Add(lstBlock.Items[lstBlock.ItemIndex]);
 lstBlock.Items.Delete(lstBLock.ItemIndex);

end;

end.
