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

unit frmViewObjects;

// jyce 27/05/04

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls,Scene3D,CustomTree;

type
  Tfrm3DObject = class(TForm)
    trv3DObject: TTreeView;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
        Procedure Initalize_Objects(Drawer:TDrawer3D);
     procedure CreateParams(var Params: TCreateParams); override;

  end;

var
  frm3DObject: Tfrm3DObject;

implementation

uses Unit1;

{$R *.DFM}

{ Tfrm3DObject }

// Description Display in a tree-view all the objects of 3D-Crade
procedure Tfrm3DObject.Initalize_Objects(Drawer: TDrawer3D);
var Child,FirstNode:TTreeNode; bHasChild:boolean;
 procedure UpdateBasicProperties(NewNode:TTreeNode;list:TTreeNodes;Object3D:TObject3D);
 var _sHide:string;
 begin
  list.addChild(NewNode,'Keyname='+Object3D.KeyName);
  if Object3D.Hide then
   _sHide:='True' else _sHide:='False';
  list.addChild(NewNode,'Hide='+_sHide);
  list.AddChild(NewNode,'color='+inttostr(Object3D.color));
  list.AddChild(NewNode,'type='+inttostr(Object3D.oType));
  list.AddCHild(NewNode,'Parent='+Object3D.fparent.Keyname);
 end;
 procedure UpdateScene3D(Scene3D:TTreeItemRef;Node:TTreeNode;list:TTreeNodes;var hasChild:boolean);
 var i,j,k:integer;NewNode,StartNode,ilevnode,jlevnode,klevnode,CurrentNode:TTreeNode; MayeTriFace3D:TMayeTriFace3D;
     Point3D:TMayeEdge;
 begin
  StartNode:=Node;
  if Scene3D.fChildNodes.Count>0 then begin
   NewNode:=list.AddChild(node,'<SubScenes>');
   NewNode.Data:=nil;
    for i:=0 to Scene3D.fChildNodes.Count -1 do
    begin
     CurrentNode:=NewNode;
     NewNode:=list.AddChild(Newnode,(Scene3D.fChildNodes.Data[i] as TScene3D).KeyName);
     NewNode.Data:=Scene3D.fChildNodes.Data[i];
     list.AddChild(NewNode,'Keyname='+(Scene3D.fChildNodes.Data[i] as TScene3D).KeyName);
//     UpdateScene3D(scene3D.fChildNodes.Items[i] as TTreeItemRef,NewNode,list,haschild);
     NewNode:=CurrentNode;
    end;
  end;
  Node:=StartNode;
  if (Scene3D.Value as TScene3D).fPoint3DRefList.Count>0 then begin
    NewNode:=list.AddChild(node,'<Points>');
    NewNode.Data:=nil;
    for i:=0 to (Scene3D.Value as TScene3D).fPoint3DRefList.Count -1 do
    begin
     hasChild:=true;
     iLevNode:=list.AddChild(Newnode,((Scene3D.Value as TScene3D).fPoint3DRefList.Items[i] as TObject3DRef).Value.KeyName);
     iLevNode.Data:=((Scene3D.Value as TScene3D).fPoint3DRefList.items[i] as TObject3DRef).Value;
     UpdateBasicProperties(iLevNode,list,((Scene3D.Value as TScene3D).fPoint3DRefList.items[i] as TObject3DRef).Value);
     list.AddChild(iLevNode,'x='+floattostr((((Scene3D.Value as TScene3D).fPoint3DRefList.Items[i] as TObject3DRef).value as TPoint3D).x));
     list.AddChild(iLevNode,'y='+floattostr((((Scene3D.Value as TScene3D).fPoint3DRefList.Items[i] as TObject3DRef).value as TPoint3D).y));
     list.AddChild(iLevNode,'z='+floattostr((((Scene3D.Value as TScene3D).fPoint3DRefList.Items[i] as TObject3DRef).value as TPoint3D).z));
    end;
  end;
  Node:=StartNode;
  if (Scene3D.Value as TScene3D).FLine3DRefList.Count>0 then begin
   NewNode:=list.AddChild(node,'<Lines>');
   NewNode.Data:=nil;
   for i:=0 to (Scene3D.Value as TScene3D).fLine3DRefList.Count -1 do
   begin
    hasChild:=true;
    iLevNode:=list.AddChild(Newnode,((Scene3D.Value as TScene3D).FLine3DRefList.items[i] as TObject3DRef).Value.KeyName);
    iLevNode.Data:=((Scene3D.Value as TScene3D).FLine3DRefList.Items[i] as TObject3DRef).Value;
    UpdateBasicProperties(iLevNode,list,((Scene3D.Value as TScene3D).fLine3DRefList.items[i] as TObject3DRef).Value);
    list.AddChild(iLevNode,'x1='+floattostr((((Scene3D.Value as TScene3D).Fline3DRefList.items[i] as TObject3DRef).Value as TLine3D).x1));
    list.AddChild(iLevNode,'y1='+floattostr((((Scene3D.Value as TScene3D).Fline3DRefList.items[i] as TObject3DRef).Value as TLine3D).y1));
    list.AddChild(iLevNode,'z1='+floattostr((((Scene3D.Value as TScene3D).Fline3DRefList.items[i] as TObject3DRef).Value as TLine3D).z1));
    list.AddChild(iLevNode,'x2='+floattostr((((Scene3D.Value as TScene3D).Fline3DRefList.items[i] as TObject3DRef).Value as TLine3D).x2));
    list.AddChild(iLevNode,'y2='+floattostr((((Scene3D.Value as TScene3D).Fline3DRefList.items[i] as TObject3DRef).Value as TLine3D).y2));
    list.AddChild(iLevNode,'z2='+floattostr((((Scene3D.Value as TScene3D).Fline3DRefList.items[i] as TObject3DRef).Value as TLine3D).z2));
   end;
  end;
  Node:=StartNode;
  if (Scene3D.Value as TScene3D).FFrame3DRefList.Count>0 then begin
   newnode:=list.AddChild(node,'<Frames>');
   newnode.Data:=nil;
   for i:=0 to (Scene3D.Value as TScene3D).FFrame3DRefList.count -1 do begin
    hasChild:=true;
    ilevnode:=list.addChild(NewNode,((Scene3D.Value as TScene3D).FFrame3DRefList.Items[i] as TObject3DRef).Value.KeyName);
    ilevnode.Data:=((Scene3D.Value as TScene3D).FFrame3DRefList.Items[i] as TObject3DRef).Value;
    UpdateBasicProperties(ilevnode,list,((Scene3D.Value as TScene3D).fFrame3DRefList.items[i] as TObject3DRef).Value);
    ilevNode:=List.AddChild(ilevNode,'<Points>');

    for j:=0 to (((Scene3D.Value as TScene3D).FFrame3DRefList.Items[i] as TObject3DRef).Value as TFrame3D).fPoints.Count -1 do
    begin
     Point3D:=((((Scene3D.Value as TScene3D).FFrame3DRefList.Items[i] as TObject3DRef).Value as TFrame3D).fPoints as TMayeEdgeList).Items[j] as TMayeEdge;
     List.AddChild(ilevNode,'x'+inttostr(j+1)+'='+floattostr(Point3D.x));
     List.AddChild(iLevNode,'y'+inttostr(j+1)+'='+floattostr(Point3D.y));
     List.AddChild(iLevNode,'z'+inttostr(j+1)+'='+floattostr(Point3D.z));

    end;
  {  list.addChild(NewNode,'x='+floattostr((Scene3D.FFrame3DList.Items[i] as TFrame3D).x));
    list.addChild(NewNode,'y='+floattostr((Scene3D.FFrame3DList.Items[i] as TFrame3D).y));
    list.addChild(NewNode,'z='+floattostr((Scene3D.FFrame3DList.Items[i] as TFrame3D).z));
    list.addChild(NewNode,'height='+floattostr((Scene3D.FFrame3DList.Items[i] as TFrame3D).height));
    list.addChild(NewNode,'length='+floattostr((Scene3D.FFrame3DList.Items[i] as TFrame3D).length));
    list.addChild(NewNode,'width='+floattostr((Scene3D.FFrame3DList.Items[i] as TFrame3D).width));}
   end;
  end;
  Node:=StartNode;
  if (Scene3D.Value as TScene3D).FMayeSurface3DRefList.Count >0 then begin
   NewNode:=list.AddChild(node,'<MayeSurfaces>');
   NewNode.Data:=nil;
   for i:=0 to (Scene3D.Value as TScene3D).fMayeSurface3DRefList.Count-1 do begin
     ilevNode:=List.AddChild(NewNode,((Scene3D.Value as TScene3D).FMayeSurface3DRefList.Items[i] as TObject3DRef).Value.KeyName);
     ilevNode.Data:=((Scene3D.Value as TScene3D).FMayeSurface3DRefList.Items[i] as TObject3DRef).Value;
     UpdateBasicProperties(ilevNode,List,((Scene3D.Value as TScene3D).FMayeSurface3DRefList.Items[i] as TObject3DRef).Value);
//     List.addChild(ilevNode,'Keyname='+((Scene3D.Value as TScene3D).FMayeSurface3DRefList.Items[i] as TObject3DRef).Value.KeyName);
     List.addChild(ilevNode,'nLong='+inttostr((((Scene3D.Value as TScene3D).FMayeSurface3DRefList.Items[i] as TObject3DRef).Value as TMayeSurface3D).nLong));
     List.addChild(ilevNode,'nLat='+inttostr((((Scene3D.Value as TScene3D).FMayeSurface3DRefList.Items[i] as TObject3DRef).Value as TMayeSurface3D).nLat));
     List.addchild(ilevNode,'Transparent='+inttostr((((Scene3D.Value as TScene3D).FmayeSurface3DRefList.Items[i] as TObject3DRef).Value as TMayeSurface3D).nTransparent));
{       for j:=0 to (((Scene3D.Value as TScene3D).fMayeSurface3DRefList.Items[i] as TObject3DRef).Value as TMayeSurface3D).fMayeTriFace3DList.Count -1 do begin
        MayeTriFace3D:=(((Scene3D.Value as TScene3D).fMayeSurface3DRefList.Items[i] as TObject3DRef).Value as TMayeSurface3D).fMayeTriFace3DList.Items[j] as TMayeTriFace3D;
        jlevNode:=List.AddChild(ilevNode,MayeTriFace3D.KeyName);
        UpdatebasicProperties(jlevNode,List,MayeTriFace3D);
        NewNode.Data:=Nil;
        for k:=0 to (MayeTriFace3D.FMayeEdgeList.count -1) do begin
         klevNode:=List.AddChild(jlevNode,'Edge_'+inttostr(k));
         klevNode.Data:=Nil;
         List.AddChild(klevNode,'x='+floattostr((Mayetriface3D.FMayeEdgeList.items[k] as TMayeEdge).x));
         List.AddChild(klevNode,'y='+floattostr((Mayetriface3D.FMayeEdgeList.items[k] as TMayeEdge).y));
         List.AddChild(klevNode,'z='+floattostr((Mayetriface3D.FMayeEdgeList.items[k] as TMayeEdge).z));

        end;
       end; }
   end;
  end;
  Node:=StartNode;
  // TO DO : add next
 end;
begin
 bHasChild:=false;
 if Drawer<>nil then begin
   trv3DObject.Items.Clear;
   Child:=TTreeNode.Create(trv3DObject.Items);
//   trv3DObject.Visible:=false;
   trv3DObject.Items.BeginUpdate;
   FirstNode:=trv3DObject.Items.AddObjectFirst(nil,'<MainScene>',Drawer.Scene3D);

   // Add the content
   UpdateScene3D(Drawer.Scene3DRef,FirstNode,trv3DObject.Items,bHasChild);
   if not bHasChild then
    trv3DObject.Items.AddChild(FirstNode,'<none>');
   trv3DObject.Items.EndUpdate;
//   trv3DObject.Visible:=true;
 end;
end;

procedure Tfrm3DObject.FormCreate(Sender: TObject);
begin
 frm3DObject.Width:=227;
 frm3DObject.Height:=747;
 frm3DObject.Top:=0;
 frm3DObject.Left:=frmMain.ClientWidth-frm3DObject.Width-16;
 frm3DObject.Initalize_Objects(frmMain.FDrawer3D);

end;

procedure Tfrm3DObject.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style XOR WS_CAPTION;
  Params.Style := Params.Style XOR WS_SIZEBOX;
end;

end.
