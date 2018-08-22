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

// Unit name : CustomTree
// Date : August 2004
// Author jyce3d
// Description : This unit handle tree structure by using references on a item list
//               You have to derivate CustomTree, CustomTreeItem and the virtual functions associated
//               All the tree management is done internally
// Remark : This unit replace the GenericTree unit, which is completely obsolete

unit CustomTree;

interface
uses SysUtils,classes;

type
TTreeItemRef=class;

TTreeItemRefList=class(TCollection)
 private
 function GetRefNode(ind:integer):TObject;
 public
 //function add(value:TTreeItemRef):TTreeItemRef;reintroduce;overloa
 function Delete(Data:TObject):boolean;reintroduce;overload;
 constructor create;reintroduce;
 property Data[ind:integer]:TObject read GetRefNode;
end;

TTreeItemRef=class(TCollectionItem)
 public
 pData:TObject;
 fParentNode:TTreeItemRef;
 fChildNodes:TTreeItemRefList;
 id_node:integer;
 procedure clone(value:TTreeItemRef);
 constructor create(Collection:TCollection);override;
 destructor destroy;override;
 property Value:TObject read pData;
end;

TCustomTree=class(TObject)
 protected

 fCountMaxNode : integer; // Maxvalue for the id_node
 fNodeList:TCollection;
 function Delete(Data:TObject;bSympathic:boolean=true):boolean;
 function RecurFindNode(CurNode:TTreeItemRef;Data:TObject):TTreeItemRef;
 public
 fRefNodeList:TTreeItemRefList;

 function FindNode(Data:TObject):TTreeItemRef;

 function Add(parent:TTreeItemRef):TCollectionItem; overload ;   
 function Add(Parent:TTreeitemRef;Data : TObject) :TTreeItemRef; overload;
 function Remove(Data:TObject):boolean;
 function Removeall : boolean;

 constructor create(Collection:TCollection);

 destructor destroy;override;
end;

TCustomTreeRef=class(TObject) // Same tree but the Add contains a reference on the object, there is internal list (fNodeList)
 protected
 fCountMaxNode : integer; // Maxvalue for the id_node
 function Delete(Data:TObject;bSympathic:boolean=true):boolean;
 function RecurFindNode(CurNode:TTreeItemRef;Data:TObject):TTreeItemRef;
public
 fRefNodeList:TTreeItemRefList;

 function FindNode(Data:TObject):TTreeItemRef;

 function Add(parent:TTreeItemRef;Data:TObject):TCollectionItem;virtual;
 function Remove(Data:TObject):boolean;
 function Removeall : boolean;

 constructor create(Collection:TCollection);

 destructor destroy;override;

end;

implementation

{ TCustomTreeItemList }


{ TTreeItemRefList }



constructor TTreeItemRefList.create;
begin
 inherited create(TTreeItemRef);
end;

function TTreeItemRefList.Delete(Data: TObject): boolean;
var i:integer;
begin
 result:=false;
 for i:=0 to COunt-1 do
 begin
  if (Items[i] as TTreeItemRef).pData=Data then begin
   inherited delete(i);
   result:=true;
   break;
  end;
 end;

end;

function TTreeItemRefList.GetRefNode(ind: integer): TObject;
begin
 result:=nil;
 if ind<Count then
  result:=(inherited Items[ind] as TTreeItemRef).pData;
end;

{ TCustomTreeItem }


{ TTreeItemRef }

procedure TTreeItemRef.clone(value:TTreeItemRef);
var i:integer;ref:TTreeItemRef;
begin
  pData:=value.pData;
  fParentNode:=value.fParentNode;
  fChildNodes.clear;
  for i:=0 to value.fChildNodes.Count-1 do
  begin
   ref:=fChildNodes.add as TTreeItemRef;
   ref.Clone(value.fChildNodes.Items[i] as TTreeItemRef);
  end;
end;

constructor TTreeItemRef.create(Collection: TCollection);
begin
  inherited;
  pData:=nil;
  fParentNode:=nil;
  fChildNodes:=TTreeItemRefList.create;

end;

destructor TTreeItemRef.destroy;
begin
  fChildNodes.Free;
  inherited;

end;

{ TCustomTree }

function TCustomTree.Add(parent: TTreeItemRef): TCollectionItem;
var NewData:TCollectionItem;NewRef:TTreeItemRef;
begin
 NewData:=fNodeList.Add;
 if parent<>nil then
 NewRef:=parent.fChildnodes.add as TTreeItemRef
  else
   NewRef:=fRefNodeList.Add as TTreeItemRef;

 NewRef.id_node:=fCountMaxNode;
 NewRef.pData:=NewData;
 NewRef.fParentNode:=parent;
 inc(fCountMaxNode);
 result:=NewData;
end;

function TCustomTree.Add(Parent: TTreeitemRef;
  Data: TObject): TTreeItemRef;
  var NewRef : TTreeItemRef;
begin
 if parent<>nil then
 NewRef:=parent.fChildnodes.add as TTreeItemRef
  else
   NewRef:=fRefNodeList.Add as TTreeItemRef;

 NewRef.id_node:=fCountMaxNode;
 NewRef.pData:=Data;
 NewRef.fParentNode:=parent;
 inc(fCountMaxNode);
 result:=NewRef;

end;

constructor TCustomTree.create(Collection: TCollection);
begin
 inherited create;
 fNodeList:=Collection;
 fRefNodeList:=TTreeItemRefList.create;
end;

function TCustomTree.Delete(Data: TObject;bSympathic:boolean=true): boolean;
var i:integer;
begin
 result:=false;
 for i:=0 to fNodeList.count -1 do
 begin
  if fNodeList.items[i]=Data then
  begin
   result:=true;
   if not bSympathic then
    fNodeList.Delete(i);
   break;
  end;
 end;
end;

destructor TCustomTree.destroy;
begin
  fRefNodeList.free;
  inherited;

end;

function TCustomTree.FindNode(Data: TObject): TTreeItemRef;
var i:integer;
begin
 result:=nil;
 for i:=0 to fRefNodeList.count-1 do
 begin
  if fRefNodeList.Data[i]=Data then
   result:=fRefNodeList. Items[i] as TTreeItemRef else
   result:=RecurFindNode(fRefNodeList.items[i] as TTreeItemRef,Data);
   if result<>nil then break;
 end;
end;



function TCustomTree.RecurFindNode(CurNode: TTreeItemRef;
  Data: TObject): TTreeItemRef;
var i:integer;
begin
 result:=nil;
 for i:=0to CurNode.fChildNodes.Count -1 do
 begin
  if CurNode.FChildNodes.Data[i]=Data then
   result:=CurNode.FChildNodes.Items[i] as TTreeITemRef else
    result:=RecurFindNode(CurNode.FChildNodes.Items[i] as TTreeITemRef,Data);
   if result<>nil then break;
 end;
end;

function TCustomTree.Remove(Data: TObject): boolean;
var ref,refp:TTreeItemRef;
begin
 result:=false;
 ref:=FindNode(Data);
 if ref<>nil then begin
  refp:=ref.fParentNode;
  result:=refp.fChildNodes.Delete(Data);
  result:=(result and Delete(Data));

 end;
end;
function TCustomTree.Removeall : boolean;

begin
 fRefNodeList.Clear;
 result:=true;
// for i:=0 to fRefNodeList.count -1 do
//  Remove(fRefNodeList.items[i]);
end;
{ TCustomTreeRef }

function TCustomTreeRef.Add(parent: TTreeItemRef;
  Data: TObject): TCollectionItem;
begin
    result:=nil
end;

constructor TCustomTreeRef.create(Collection: TCollection);
begin

end;

function TCustomTreeRef.Delete(Data: TObject;
  bSympathic: boolean): boolean;
begin
   result:=false
end;

destructor TCustomTreeRef.destroy;
begin
  inherited;

end;

function TCustomTreeRef.FindNode(Data: TObject): TTreeItemRef;
begin
   result:=nil;
end;

function TCustomTreeRef.RecurFindNode(CurNode: TTreeItemRef;
  Data: TObject): TTreeItemRef;
begin
   result:=nil;
end;

function TCustomTreeRef.Remove(Data: TObject): boolean;
begin
   result:=false;
end;

function TCustomTreeRef.Removeall: boolean;
begin
  result:=false;
end;

end.
