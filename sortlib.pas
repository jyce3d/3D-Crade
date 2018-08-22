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

// Unit sortlib
// Description : Contient des fonctions de tri
// Author : Jyce3d
// Creation date : 21/04/04
unit sortlib;

interface
   // Tri par echange
   procedure ExchangeSort(var aInt : array of integer);
   procedure swap(var x : integer; var y:integer);

   // Private

implementation

 procedure swap(var x : integer; var y:integer);
 var c:integer;
 begin
  c:=y;
  y:=x;
  x:=c;
 end;

 procedure ExchangeSort(var aInt : array of integer);
 var n,i,j:integer;
 begin
  n:=High(aInt);
   for i:=0 to n-1 do
    for j:=i to n do
    begin
     if aint[j]>aint[j+1] then swap(aint[j],aint[i]);
    end;
   

 end;
end.
