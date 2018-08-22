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

// Handle Pointer List : jyce3d, sept 2004

unit CustomList;

interface
uses SysUtils;
type
 TcustomList=class;

 TCustomListItem=class
  fPredecessor:TCustomListItem;
  fSuccessor:TCustomListItem;
  pData:TObject;
  fOwner:TCustomList;
  constructor create(owner:TCustomList);
 end;
 TCustomList=class
  protected
   fFirstItem:TCustomListItem;
   fCount:integer;
   function GetListItem(ind:integer):TObject;
  function GetListItemRef(ind: integer): TCustomListItem;

  public
  function AddRef(val:TObject):TObject;
  function Delete(index:integer):integer;
  constructor create;virtual;
  destructor destroy;override;
  property Count:Integer read fCount;
  property Items[ind:integer]:TObject read GetListItem; default;
 end;
implementation

{ TCustomList }

function TCustomList.AddRef(val: TObject): TObject;
var curListItem:TCustomListItem;
begin
 if Count=0 then
 begin
  FFirstItem:=TCustomListItem.Create(self);
  FFirstItem.pData:=val;
 end
 else
 begin
  curListItem:=GetListItemRef(count-1);
  curListItem.fsuccessor:=TCustomListItem.Create(self);
  CurListItem.fsuccessor.fpredecessor:=CurListItem;
  curListItem.pData:=val;
 end;

 inc(fcount);
 result:=val;
end;

constructor TCustomList.create;
begin
 inherited;
 fCount:=0;

end;

function TCustomList.Delete(index: integer): integer;
var curlistItem:TCustomListItem;       Prev,next:TCustomListItem;
begin
 result:=0;
 if Count=0 then exit;
 if index>=Count then
  raise Exception.Create('TCustomList::Delete:Index out of bounds');
 if index=0 then
 begin
  curlistItem:=fFirstItem;
  fFirstItem:=GetListItemRef(1);
  fFirstItem.fPredecessor:=nil;
 end else
  if index=count -1 then begin
  curlistItem:=GetListItemRef(count-1);
  GetListItemRef(count-2).fSuccessor:=nil;
  end else
  begin
   curlistItem:=GetListItemRef(index);
   prev:=curlistitem.fpredecessor;
   next:=curlistItem.fsuccessor;
   prev.fsuccessor:=next;
   next.fpredecessor:=prev;
 end;

 curlistItem.free;

 result:=1;
end;

destructor TCustomList.destroy;
begin
  inherited;

end;

function TCustomList.GetListItemRef(ind: integer): TCustomListItem;
var curObj:TCustomListItem; cp:integer;
begin
 if ind>=Count then
  raise Exception.Create('TCustomList::GetListItem:Index out of bounds');
 curObj:=fFirstItem;
 cp:=0;
 while cp<>ind do
  curObj:=CurObj.fSuccessor;
 result:=CurObj;
end;
function TCustomList.GetListItem(ind: integer): TObject;
begin
 result:=GetListItemRef(ind).pData;
end;
{ TCustomListItem }

constructor TCustomListItem.create(owner: TCustomList);
begin
 fOwner:=owner;
 fpredecessor:=nil;
 fsuccessor:=nil;
end;

end.
