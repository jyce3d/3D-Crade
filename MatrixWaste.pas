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

unit MatrixWaste;
//  Unité : MatrixWaste
 // Author : jyce3d
 // Creation Date : 24/12/2003
 // Rmk : ne gère que les vecteurs et les matrices carrées.
interface
type
 TFloatMatrix=class;

 TFloatVector=class
  protected
   fColumns : Array of Extended;
   fDim : integer;
   procedure SetFloat(ind:integer;val:extended);
   function LetFloat(ind:integer):Extended;

  public
   function Multiply( val:extended):integer;overload;
   function Multiply( val:TFloatVector):integer;overload;
   // La matrice se trouve à la droite du vecteur (vecteur ligne)
   function MultiplyByRight( val:TFloatMatrix):integer;overload;
   // La matrice se trouve à gauche du vecteur (vecteur colonne)
   function MultiplyByLeft( val:TFloatMatrix):integer;overload;

   function Addition(val:TFloatVector):integer;
   function Substraction(val:TFloatVector):integer;
   procedure Clone(val:TFloatVector);
   function ToString:String;
   constructor Create(dim:integer);
   destructor destroy;override;

   property Dimension : integer read fDim write fDim;
   property Item[ind:integer] : Extended read LetFloat write SetFloat;
 end;
 TFloatMatrix=class
  private
  protected
   fLines : Array of TFloatVector;
   fDim : integer;
   function LetFloat(line,col:integer):extended;
   procedure SetFloat(line,col:integer;val:extended);
   // mat est une référence sur une matrice de dimension inférieur
   procedure FillSubMatrix(line,col:integer;mat:TFloatMatrix);
   function RecurDeterminant(line,col:integer;_mat:TFloatMatrix):extended;

  public
// opérations
   function Multiply( val:extended):integer;overload;
   function Multiply( val:TFloatMatrix):integer;overload;

   function Addition(val:TFloatMatrix):integer;
   function Substraction(val:TFloatMatrix):integer;

// Matrix Transformations
   function ChangeToInvert:integer;
   function ChangetoIdentity:integer;
   function ChangeToTranspose:integer;
   function ChangeToAdjoint:integer;
// Propriétés
   function Determinant:extended;
   function Cofactor(line,col:integer):extended;

// Class methods
   procedure Clone(val:TFloatMatrix);
   function ToString:String;
   constructor Create(dim:integer);
   destructor destroy;override;
   property Dimension : integer read fDim write fDim;
   property Item[line,col:integer] : Extended read LetFloat write SetFloat;

 end;
implementation
uses SysUtils,math;
{ TFloatVector }

function TFloatVector.Addition(val: TFloatVector): integer;
var i:integer;
begin
 if fDim<>val.Dimension then
  raise Exception.Create('TFloatVector:Uncompatible vector');
 for i:=1 to fDim do
  Item[i]:=Item[i]+val.Item[i];

 result:=0;
end;

constructor TFloatVector.Create(dim: integer);
begin
 fDim:=dim;
 SetLength(fColumns,fDim+1);
end;

destructor TFloatVector.destroy;
begin
  SetLength(fColumns,0);
  fColumns:=nil;
  inherited;

end;

function TFloatVector.Multiply(val: extended): integer;
var i:integer;
begin
  for i:=1 to fDim do
   Item[i]:=Item[i]*val;

  result:=0;
end;

function TFloatVector.Multiply(val: TFloatVector): integer;
var i:integer;
begin
  if Dimension<>val.Dimension then
   raise Exception.Create('TFloatVector:Uncompatible vector');
  for i:=1 to fDim do
   Item[i]:=Item[i]*val.Item[i];
  result:=0;
end;

function TFloatVector.LetFloat(ind: integer): Extended;
begin
 if (ind=0) or (ind>fDim) then
  raise Exception.create('TFloatVector:Invalid Index');
 result:=fColumns[ind];
end;
// Matrice à droite du vecteur
function TFloatVector.MultiplyByRight(val: TFloatMatrix): integer;
var i,j:integer; c:extended; tmp:TFloatVector;
begin
 // tester la compatibilité des matrices
 if val.Dimension<>Dimension then
  raise Exception.Create('TFloatVector:Uncompatible Matrix');
 tmp:=TFloatVector.Create(fDim);

 for i:=1 to fDim do
 begin
  c:=0;
  for j:=1 to fDim do
  begin
   c:=c+Item[j]*val.Item[j,i];
  end;
  tmp.Item[i]:=c;
 end;
 Clone(tmp);
 tmp.Free;
 result:=0;
end;

procedure TFloatVector.SetFloat(ind: integer; val: extended);
begin
 if (ind=0) or (ind>fDim) then
  raise Exception.create('TFloatVector:Invalid Index');
 fColumns[ind]:=val;
end;

function TFloatVector.Substraction(val: TFloatVector): integer;
var i:integer;
begin
 if fDim<>val.Dimension then
  raise Exception.Create('TFloatVector:Uncompatible vector');
 for i:=1 to fDim do
  Item[i]:=Item[i]-val.Item[i];
 result:=0;
end;

procedure TFloatVector.Clone(val: TFloatVector);
var i:integer;
begin
 if fDim<>val.Dimension then
  raise Exception.Create('TFloatVector:Uncompatible vector');

 for i:=1 to fDim do
  Item[i]:=Val.Item[i];
end;

function TFloatVector.MultiplyByLeft(val: TFloatMatrix): integer;
var i,j:integer; c:extended; tmp:TFloatVector;
begin
 // tester la compatibilité des matrices
 if val.Dimension<>Dimension then
  raise Exception.Create('TFloatVector:Uncompatible Matrix');
 tmp:=TFloatVector.Create(fDim);

 for i:=1 to fDim do
 begin
  c:=0;
  for j:=1 to fDim do
  begin
   c:=c+Item[j]*val.Item[i,j];
  end;
  tmp.Item[i]:=c;
 end;
 Clone(tmp);
 tmp.Free;
 result:=0;
end;

function TFloatVector.ToString: String;
var i:integer;
begin
 result:='';
 for i:=1 to fDim do
 begin
  if i=1 then
   result:=result+floattostr(Item[i]) else result:=result+#9+floattostr(Item[i]);
 end;
end;

{ TFloatMatrix }

function TFloatMatrix.Addition(val: TFloatMatrix): integer;
var i,j:integer;
begin
// tester la compatibilité des matrices
 if val.Dimension<>Dimension then
  raise Exception.Create('TFloatMAtrix:Uncompatible Matrix');

 for i:=1 to fDim do
  for j:=1 to fDim do
   Item[i,j]:=Item[i,j]+val.Item[i,j];

  result:=0;
end;

function TFloatMatrix.ChangeToAdjoint: integer;
var tmp:TFloatMatrix;  a:extended; i,j:integer;
begin
 tmp:=TFloatMatrix.Create(fDim);
 for i:=1 to fDim do
 begin
  for j:=1 to fDim do   begin
   a:=Cofactor(i,j);
   tmp.Item[i,j]:=a;
  end;
 end;
 Clone(tmp);
 tmp.free;
 result:=0;
end;

function TFloatMatrix.ChangetoIdentity: integer;
var i,j:integer;
begin
 for i:=1 to fDim do
 begin
  for j:=1 to fDim do
  begin
   if i<>j then Item[i,j]:=0 else Item[i,j]:=1;
  end;
 end;
 result:=0;
end;

function TFloatMatrix.ChangeToInvert: integer;
var det:extended; tmp:TFloatMatrix;
begin

 det:=Determinant;
 if det=0 then
  raise Exception.Create('Unable to invert this kind of Matrix');

 tmp:=TFloatMAtrix.Create(fdim);
  tmp.Clone(self);
  tmp.ChangeToAdjoint;
  tmp.ChangeToTranspose;
  tmp.Multiply(1/det);
  Clone(tmp);
  tmp.free;
  result:=0;
end;

function TFloatMatrix.ChangeToTranspose: integer;
var i,j:integer; tmp:TFloatMAtrix;
begin
 tmp:=TFLoatMAtrix.Create(fdim);
 for i:=1 to fDim do
 begin
  for j:=1 to fDim do
   tmp.Item[i,j]:=Item[j,i];
 end;
 Clone(tmp);
 tmp.free;
 result:=0;
end;

procedure TFloatMatrix.Clone(val: TFloatMatrix);
var i,j:integer;
begin
// tester la compatibilité des matrices
 if val.Dimension<>Dimension then
  raise Exception.Create('TFloatMAtrix:Uncompatible Matrix');

 for i:=1 to fDim do
  for j:=1 to fDim do
   Item[i,j]:=val.Item[i,j];
end;

function TFloatMatrix.Cofactor(line, col: integer): extended;
var mat:TFloatMatrix;
begin
 // Evaluation du Mineur
 mat:=TFloatMatrix.Create(fDim-1);
 FillSubMatrix(line,col,mat);
 result:=power(-1,line+col)*mat.Determinant;
 mat.free;
end;

constructor TFloatMatrix.Create(dim: integer);
var i:integer;vect:TFloatVector;
begin
 fdim:=dim;
 SetLength(fLines,fdim+1);
 for i:=1 to fdim do
 begin
  vect:=TFloatVector.Create(fdim);
  fLines[i]:=vect;
 end;
end;

destructor TFloatMatrix.destroy;
var i:integer;
begin
  for i:=1 to fdim do
   flines[i].Free;

  SetLength(fLines,0);
  inherited;

end;
function TFloatMatrix.RecurDeterminant(line,col:integer;_mat:TFloatMatrix):extended;
  var mat2:TFloatMatrix; j:integer;
  begin
   result:=0;
   if _mat.dimension>2 then begin
    for j:=1 to _mat.fDim do begin
    mat2:=TFloatMatrix.Create(_mat.Dimension-1);
    _mat.FillSubMatrix(line,j,mat2);
    result:=result+Power(-1,(line+j))*_mat.Item[Line,j]*RecurDeterminant(line,j,mat2);
    mat2.free;
    end;
   end else
    result:=_mat.Item[1,1]*_mat.Item[2,2]-_mat.Item[2,1]*_mat.Item[1,2];
end;

// Calcul d'un déterminant par récursivité (évidemment pas la méthode la plus optimale);
// L'algèbre linéaire permet des des méthodes de diagonalisation de matrice qui permettent
// de calculer un déterminant plus rapidement.
function TFloatMatrix.Determinant: extended;
//var  //mat:TFloatMatrix;
begin
 // calcul du déterminant de la matrice
 result:=RecurDeterminant(1,1,self);
end;

function TFloatMatrix.LetFloat(line, col: integer): extended;
var vect:TFloatVector;
begin
 if (line=0) or (line>fDim) then
    raise Exception.create('TFloatMatrix:Invalid Index');

 vect:=fLines[line];
 result:=vect.Item[col]
end;

function TFloatMatrix.Multiply(val: extended): integer;
var i,j:integer;
begin
// tester la compatibilité des matrices

 for i:=1 to fDim do
  for j:=1 to fDim do
   Item[i,j]:=Item[i,j]*val;

 result:=0;
end;


function TFloatMatrix.Multiply(val: TFloatMatrix): integer;
var i,j,k:integer ;c:extended; tmp:TFloatMatrix;
begin
// tester la compatibilité des matrices
 if val.Dimension<>Dimension then
  raise Exception.Create('TFloatMAtrix:Uncompatible Matrix');

 tmp:=TFloatMatrix.Create(Dimension);
 for i:=1 to fDim do
 begin
  for j:=1 to fDim do
  begin
    c:=0;
    for k:=1 to fDim do
     c:=c+Item[i,k]*val.Item[k,j];
    tmp.Item[i,j]:=c;
  end;
 end;
 Clone(tmp);
 tmp.Free;
 result:=0
end;

procedure TFloatMatrix.SetFloat(line, col: integer; val: extended);
var vect:TFloatVector;
begin
 if (line=0) or (line>fDim) then
    raise Exception.create('TFloatMatrix:Invalid Index');

 vect:=fLines[line];
 vect.Item[col]:=val;
end;

function TFloatMatrix.Substraction(val: TFloatMatrix): integer;
var i,j:integer;
begin
// tester la compatibilité des matrices
 if val.Dimension<>Dimension then
  raise Exception.Create('TFloatMAtrix:Uncompatible Matrix');

 for i:=1 to fDim do
  for j:=1 to fDim do
   Item[i,j]:=Item[i,j]-val.Item[i,j];

  result:=0;
end;


procedure TFloatMatrix.FillSubMatrix(line, col: integer;
  mat: TFloatMatrix);
var i,j,cpl,cpc:integer;
begin
 cpl:=1; cpc:=1;
 for i:=1 to fDim do
 begin
  if i<>line then begin
   for j:=1 to fDim do begin
    if j<>col then begin
     mat.Item[cpl,cpc]:=Item[i,j];
     inc(cpc);
    end;
   end;
   inc(cpl);
   cpc:=1;
  end;
 end;

end;

function TFloatMatrix.ToString: String;
var i,j:integer;
begin
 result:='';
 for i:=1 to fDim  do
 begin
  for j:=1 to fDim do
  begin
   if j=1 then result:=result+floattostr(Item[i,j]) else result:=result+#9+floattostr(Item[i,j]);
  end;
  result:=result+#13#10;
 end;
end;

end.
