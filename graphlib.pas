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

// Unit Graphlib
// Description : This unit contains some functions used in the scope of the 3D-2D display.
// Author : Jyce3d
// Creation date : 20/04/04

unit graphlib;
interface
uses graphics,classes;

     type
      TPoint2D=class(TCollectionItem)
       public
       x,y : integer;
       constructor create(Collection:TCollection);override;
       procedure clone(ob:TPoint2D);
      end;

      TPoint2DList=class(TCollection)
       procedure SortByY;
       procedure SortByX;
       procedure Swap(i,j:integer);
       constructor Create;reintroduce;
      end;
     const

     CLIPDRAWALL = 2;
     CLIPNODRAW =0;
     CLIPDRAWPART=3;


// 3D Functions
    procedure ToPolar(x,y,z:extended; var rho,teta,phi:extended);
    procedure ToCartesian(rho,teta,phi:extended; var x,y,z:extended);
    procedure Rotate3DX(phi:extended; var xr,yr,zr:extended);
    procedure Rotate3DY(phi:extended; var xr,yr,zr:extended);
    procedure Rotate3DZ(phi:extended; var xr,yr,zr:extended);
//  3D-2D Graphic function
    procedure Ellipse(canvas:TCanvas;tx,ty,rx,ry:integer;alpha:extended=0);
    Procedure AngleEllipse(canvas:TCanvas;p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y,color:integer);
// Deprecated
    Procedure StretchedEllipse(canvas:TCanvas;cx,cy,R1x,r1y,R2x,r2y,color:integer;alpha:extended);overload;
    procedure StretchedEllipse(canvas:TCanvas;p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y,color:integer);overload;
    procedure StretchedEllipse(canvas:TCanvas;p1,p2,p3,p4:TPoint2D;color:integer);overload;
    Procedure StretchedEllipseClip(canvas:TCanvas;cx,cy,R1x,r1y,R2x,r2y,clip1x,clip1y,clip2x,clip2y,color:integer;alpha:extended);overload;
    Procedure StretchedEllipseClip(canvas:TCanvas;p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y,x1,y1,x2,y2,color:integer);overload;
    Procedure Plane(canvas:TCanvas;p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y,color:integer);
// Standard function
    procedure Rotation(x,y:integer; alpha:extended; var xr,yr:integer);
    procedure OrderFourPointsList(pointlist:TPoint2DList);
// Protected function
    procedure QuadDraw(canvas:TCanvas;x, y, cx,cy,quad, color: integer;alpha:extended);
    procedure QuadEllipse(canvas:TCanvas;cx,cy,Rx,ry,quad,color:integer;alpha:extended);
    procedure ExtractCenterRadius(p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y:integer; var cx,cy,ra1,rb1,ra2,rb2:integer; var alpha:extended; Canvas:TCanvas);
    procedure QuadEllipseClip(Canvas:TCanvas;cx,cy,Rx,ry,clip1x,clip1y,clip2x,clip2y,quad,color:integer;alpha:extended;STATUS:integer);
    Procedure QuadAngleEllipse(canvas:TCanvas;cx,cy,Rx,ry,color,quad:integer;alpha,beta:extended);

    function  GetQuadran(x,y:integer):integer;
    Procedure DrawStretchedEllipseClip(Canvas:TCanvas;Quad1,Quad2,cx,cy,r1x,r1y,r2x,r2y,clip1x,clip1y,clip2x,clip2y,color:integer;alpha:extended);

    procedure GetRadius(Quad,r1x,r1y,r2x,r2y:integer; var rX:integer;var rY:integer);
    function SumQuad(quad,val:integer):integer;

    procedure Draw(Canvas:TCanvas;x,y,tx,ty:integer;alpha:extended);

    Procedure AngleDraw(Canvas:TCanvas;x,y,alpha,beta:extended;cx,cy,color,quad:integer);
    procedure TransformCoordonate(x,y,alpha,beta:extended; var x2,y2:integer);
    procedure XIncrement(var x,y:extended;alpha,beta:extended);
    procedure YIncrement(var x,y:extended;alpha,beta:extended);

implementation
uses math,genlib,sysutils;
// Standard function

 procedure Rotation(x,y:integer; alpha:extended; var xr,yr:integer);
 begin
  xr:=round(x*cos(alpha)-y*sin(alpha));
  yr:=round(x*sin(alpha)+y*cos(alpha));
 end;

// 3D-2D Graphic functions

// Ellipse: Draw an Ellipse
// Input :
//        Canvas
procedure Ellipse(canvas:TCanvas;tx,ty,rx,ry:integer;alpha:extended);
  var x,y:integer; err:extended; bContinue:boolean;

 begin
  err:=-ry*ry*Rx / 2;
 x:=Rx;
 y:=0;
// Rotation(x,y,pi/4,tmprx,tmpry);
// x:=tmprx;
// y:=tmpry;
 bContinue:=true;
// rotation(x,y,pi/4,xr,yr);
 draw(canvas,x,y,tx,ty,alpha);
 while bContinue do begin
  y:=y+1;
  err:=err+Rx*Rx*(2*y-1);
  if err>0 then
  begin
   x:=x-1;
   err:=err-ry*ry*(2*x+1);
   if err>=0 then bContinue:=false;
  end;
//  rotation(x,y,pi/4,xr,yr);
  Draw(canvas,x,y,tx,ty,alpha);
 end;
//  showmessage('test') ;
 y:=Ry;
 x:=0;
 err:=-rX*rX*Ry/2;
 bContinue:=true;
// rotation(x,y,pi/4,xr,yr);
 Draw(canvas,x,y,tx,ty,alpha);

  while bCOntinue do begin
   x:=x+1;
   err:=err+Ry*ry*(2*x-1);
   if err>0 then  begin
    y:=y-1;
    err:=err-rx*rx*(2*y+1);
    if err>0 then bContinue:=false;
   end;
//   rotation(x,y,pi/4,xr,yr);
   Draw(canvas,x,y,tx,ty,alpha);
  end;

 end;


// Description
//  Dessine une ellipse déformée (une patate).
//
// Parameters
//  cx,cy : centre de l'ellipse
//  R1x   : premier grand Rayon : allant de cx vers +l'infini
//  r1y   : premier petit rayon : allant du cy vers +l'infini
//  R2x   : second grand Rayaon : allant de cx à -l'infini
//  r2y   : second petit rayon : allant de cy vers - l'infini
//  color : couleur du point.
// Return
//
// Remarks
//

procedure StretchedEllipse(canvas:TCanvas;cx, cy, R1x, r1y, R2x, r2y,
  color: integer;alpha:extended);
begin
  // first quadrature
  QuadEllipse(canvas,cx,cy,R1x,r1y,1,color,alpha);
  // second quadrature
  QuadEllipse(canvas,cx,cy,R2x,r1y,2,color,alpha);
  // third quadrature
  QuadEllipse(canvas,cx,cy,R2x,r2y,3,color,alpha);
  // fourth quadrature
  QuadEllipse(canvas,cx,cy,R1X,r2y,4,color,alpha);
end;

procedure StretchedEllipse(Canvas:TCanvas;p1x, p1y, p2x, p2y, p3x, p3y, p4x, p4y,
  color: integer);
  var cx,cy,ra1,rb1,ra2,rb2:integer;
      alpha:extended;
begin

 // cx:=cx+((p2x+p1x) div 2); cy:=cy+((p1y+p4y) div 2);
  ExtractCenterRadius(p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y,cx,cy,ra1,rb1,ra2,rb2,alpha,Canvas);
  StretchedEllipse(Canvas,cx,cy,ra1,rb1,ra2,rb2,color,-alpha);
end;

procedure StretchedEllipseClip(Canvas:TCanvas;cx, cy, R1x, r1y, R2x, r2y, clip1x,
  clip1y, clip2x, clip2y,color: integer;alpha:extended);
var quad1,quad2,rx,ry,SENS:integer;

begin
  SENS:=0; // 0 negatif; 1 positif

  Quad1:=GetQuadran(clip1x,clip1y);
  Quad2:=GetQuadran(clip2x,clip2y);

  // Détermination du sens, mesure de l'angle Clip2 et Clip1 si >0=> sens positif sinon négatif
  // Dans la mesure de l'angle tenir compte que l'axe des Y du repère est inversé par rapport à l'ordonnée mathématique

  if Quad1=Quad2 then begin
   // Les deux points sont dans le même quadrant
   if abs(clip1y)<abs(clip2y) then
    // sens positif
    SENS:=1;
  end
  else
   if Quad2>Quad1 then
    SENS:=1;
// Dessine dans le sens positif
  if (quad1=4) or (quad1=3) then
  SENS:=1;
  if SENS=1 then begin

    if Quad1=Quad2 then begin
     GetRadius(Quad1,r1x,r1y,r2x,r2y,Rx,Ry);
     QuadEllipseClip(Canvas,cx,cy,Rx,ry,clip1x,clip1y,clip2x,clip2y,Quad1,color,alpha,CLIPDRAWPART);
    end else begin
     DrawStretchedEllipseClip(Canvas,quad1,quad2,cx,cy,r1x,r1y,r2x,r2y,clip1x,clip1y,clip2x,clip2y,color,alpha);
    end;

  end else
  // Dessine dans le sens négatif
  begin
   if (Quad1=Quad2) then begin
     // Cas particulier on est dans le même quadrant en coordonnées négatives
    GetRadius(Quad1,r1x,r1y,r2x,r2y,Rx,Ry);
    QuadEllipseClip(Canvas,cx,cy,Rx,Ry,clip2x,clip2y,0,0,quad1,color,alpha,CLIPDRAWPART);
    QuadEllipseClip(Canvas,cx,cy,Rx,Ry,0,0,clip1x,clip1y,quad1,color,alpha,CLIPDRAWPART);

    // fill the other quadrant
    GetRadius(SumQuad(Quad1,1),r1x,r1y,r2x,r2y,Rx,Ry);
    QuadEllipseclip(Canvas,cx,cy,rx,ry,0,0,0,0,SumQuad(Quad1,1),color,alpha,CLIPDRAWALL);
    GetRadius(SumQuad(Quad1,2),r1x,r1y,r2x,r2y,Rx,Ry);
    QuadEllipseClip(Canvas,cx,cy,rx,ry,0,0,0,0,SumQuad(Quad1,2),color,alpha,CLIPDRAWALL);
    GetRadius(SumQuad(Quad1,3),r1x,r1y,r2x,r2y,Rx,Ry);
    QuadEllipseClip(Canvas,cx,cy,rx,ry,0,0,0,0,SumQuad(Quad1,3),color,alpha,CLIPDRAWALL);

   end else begin
     // Affiche l'arc
     swap(clip1x,clip2x);
     swap(clip1y,clip2y);
     swap(quad1,quad2);
     DrawStretchedEllipseClip(Canvas,quad1,quad2,cx,cy,r1x,r1y,r2x,r2y,clip1x,clip1y,clip2x,clip2y,color,alpha);
   end;
  end;
end;

procedure Plane(Canvas:TCanvas;p1x, p1y, p2x, p2y, p3x, p3y, p4x, p4y,
  color: integer);
begin

 Canvas.MoveTo(p1x,p1y); Canvas.LineTo(p2x,p2y);
 Canvas.LineTo(p3x,p3y); Canvas.LineTo(p4x,p4y);
 Canvas.LineTo(p1x,p1y);

 // Affiche le centre du plan
// Canvas.MoveTo( (abs(p1x-p2x) div 2)+p2x,(abs(p1y-p2y) div 2)+p2y);
// Canvas.LineTo( (abs(p4x-p3x) div 2)+p3x,(abs(p4y-p3y) div 2)+p3y);
end;

procedure StretchedEllipseClip(Canvas:TCanvas;p1x, p1y, p2x, p2y, p3x, p3y, p4x,p4y,x1,y1,x2,y2,
   color: integer);
var cx,cy,ra1,rb1,ra2,rb2 : integer;
    alpha:extended;
begin
  ExtractCenterRadius(p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y,cx,cy,ra1,rb1,ra2,rb2,alpha,Canvas);
  StretchedEllipseClip(Canvas,cx,cy,ra1,rb1,ra2,rb2,x1,y1,x2,y2,color,-alpha);
end;



//
// Private functions
//
function GetQuadran(x,y:integer):integer;
begin
 if (x>0) and (y<0) then
  result:=1 else
   if (x<0) and (y<0) then
    result:=2 else
     if (x<0) and (y>0) then
      result:=3 else
       result:=4;
end;

procedure QuadDraw(canvas:TCanvas;x, y, cx,cy,quad, color: integer;alpha:extended);
var xr,yr:integer;
begin
 case quad of
  1: // first quadrature
  begin
   rotation(x,y,alpha,xr,yr);
   Canvas.MoveTo(cx+xr,cy-yr); Canvas.LineTo(cx+xr+1,cy-yr-1);
  end;
  2:
  begin
   rotation(x,y,-alpha,xr,yr);
   Canvas.MoveTo(cx-xr,cy-yr); Canvas.LineTo(cx-xr-1,cy-yr-1);
  end;
  3:
  begin
   rotation(x,y,alpha,xr,yr);
   Canvas.MoveTo(cx-xr,cy+yr); Canvas.LineTo(cx-xr-1,cy+yr+1);
  end;
  4:
  begin
   rotation(x,y,-alpha,xr,yr);
   Canvas.MoveTo(cx+xr,cy+yr); Canvas.LineTo(cx+xr+1,cy+yr+1);
  end;
 end;
end;

// Description
//  Algorithme de tracé d'ellipse de Bresenham dans un quadrant donné
// Parameters
//  cx,cy : Centre de l'ellipse
//  Rx : Grand Rayon de l'ellipse (de cx,à cx+Rx)
//  ry : Petit rayon de l'ellipse (de cy à cy+ry)
//  quad : numéro du quadrant trigonométrique (1..4);
//  color : couleur des points.
// Return
// Draw a quarter of ellipse
// Remarks
// La condition d'arrêt lors du tracé n'est pas totalement valide, elle
// serait à revérifier.

procedure QuadEllipse(canvas:TCanvas;cx, cy, Rx, ry, quad, color: integer;alpha:extended);
var x,y:integer; err:extended;bContinue:boolean;
begin
 err:=-ry*ry*Rx / 2;
 x:=Rx;
 y:=0;
// Rotation(x,y,pi/4,tmprx,tmpry);
// x:=tmprx;
// y:=tmpry;
 bContinue:=true;
 Quaddraw(canvas,x,y,cx,cy,quad,color,alpha);
 while bContinue do begin
  y:=y+1;
  err:=err+Rx*Rx*(2*y-1);
  if err>0 then
  begin
   x:=x-1;
   err:=err-ry*ry*(2*x+1);
   if err>=0 then bContinue:=false;
  end;
  QuadDraw(canvas,x,y,cx,cy,quad,color,alpha);
 end;

 y:=Ry;
 x:=0;
 err:=-rX*rX*Ry/2;
 QuadDraw(canvas,x,y,cx,cy,quad,color,alpha);
 bContinue:=true;
  while bCOntinue do begin
   x:=x+1;
   err:=err+Ry*ry*(2*x-1);
   if err>0 then  begin
    y:=y-1;
    err:=err-rx*rx*(2*y+1);
    if err>0 then bContinue:=false;
   end;
  QuadDraw(canvas,x,y,cx,cy,quad,color,alpha);
  end;

end;

procedure QuadEllipseClip(canvas:TCanvas;cx, cy, Rx, ry, clip1x, clip1y, clip2x,
  clip2y, quad, color: integer; alpha:extended;STATUS:integer);

 procedure Draw(x,y,tx,ty,quad:integer;alpha:extended);
 var xr,yr:integer;
 begin
  //Rotation(x,y,alpha,xr,yr);
  if quad=1 then
  begin
   rotation(x,y,alpha,xr,yr);
   Canvas.MoveTo(xr+tx,ty-yr); Canvas.LineTo(tx+xr+1,ty-yr-1);
  end;
  if quad=2 then
  begin
   rotation(x,y,-alpha,xr,yr);
   Canvas.MoveTo(tx-xr,ty-yr); Canvas.LineTo(tx-xr-1,ty-yr-1);
  end;
  if quad=3 then begin
   rotation(x,y,alpha,xr,yr);
   Canvas.MoveTo(tx-xr,ty+yr); Canvas.LineTo(tx-xr-1,ty+yr+1);
  end;
  if quad=4 then begin
   rotation(x,y,-alpha,xr,yr);
   Canvas.MoveTo(tx+xr,ty+yr); Canvas.LineTo(tx+xr+1,ty+yr+1);
  end;
 end;

 procedure DrawQuadPart(cx,cy,rx,ry,clip1x,clip1y,clip2x,clip2y,color,quad:integer);
 var x,y,xl1,yl1,xl2,yl2:integer; err,ca1,ca2:extended;bContinue,trace:boolean;
 begin
  Trace:=false;
  ca1:=(Clip1y)/(clip1x);
  ca2:=(Clip2y)/(clip2x);
  xl1:=Round(sqrt((Rx*Rx*ry*ry)/(Rx*Rx*ca1*ca1+ry*ry)));
  yl1:=Round(sqrt(ry*ry*(1-ry*ry/(Rx*Rx*Ca1*ca1+ry*ry))));
  xl2:=Round(sqrt((Rx*Rx*ry*ry)/(Rx*Rx*ca2*ca2+ry*ry)));
  yl2:=Round(sqrt(ry*ry*(1-ry*ry/(Rx*Rx*Ca2*ca2+ry*ry))));


 //
 // Trace du bas du quadrant vers le Haut du quadrant.
 //
  err:=-ry*ry*Rx / 2;
  x:=Rx;
  y:=0;
 bContinue:=true;
 if Trace then
  Draw(x,y,cx,cy,quad,alpha);
 while bContinue do begin
  y:=y+1;
  if (y>=yl1) and (y<yl2) then
   Trace:=true else trace:=false;
  err:=err+Rx*Rx*(2*y-1);
  if err>0 then
  begin
   x:=x-1;
   err:=err-ry*ry*(2*x+1);
   if err>=0 then bContinue:=false;
  end;
  if Trace then
   Draw(x,y,cx,cy,quad,alpha);
 end;
 Trace:=false;
 //
 // Trace du haut du Quadrant vers le bas du quadrant.
 //
  y:=Ry;
  x:=0;
  err:=-rX*rX*Ry/2;
  bContinue:=true;
  if Trace then
   Draw(x,y,cx,cy,quad,alpha);

  while bCOntinue do begin
   x:=x+1;
   if (x>=xl2) and (x<xl1) then
    trace:=true else trace:=false;
   err:=err+Ry*ry*(2*x-1);
   if err>0 then  begin
    y:=y-1;
    err:=err-rx*rx*(2*y+1);
    if err>0 then bContinue:=false;
   end;
    if Trace then
     Draw(x,y,cx,cy,quad,alpha);
  end;

 end;
 procedure DrawQuadFromTop(cx,cy,rx,ry,clipx,clipy,color,quad:integer;alpha:extended);
 var ca,xl,yl,err:extended;trace,bcontinue:boolean; x,y:integer;
 begin
  Trace:=false;
  ca:=(Clipy)/(clipx);
  xl:=Round(sqrt((Rx*Rx*ry*ry)/(Rx*Rx*ca*ca+ry*ry)));
  yl:=Round(sqrt(ry*ry*(1-ry*ry/(Rx*Rx*Ca*ca+ry*ry))));

 //
 // Trace du bas du quadrant vers le Haut du quadrant.
 //
  err:=-ry*ry*Rx / 2;
  x:=Rx;
  y:=0;
 bContinue:=true;
 if Trace then
  Draw(x,y,cx,cy,quad,alpha);
 while bContinue do begin
  y:=y+1;
  if (y>=yl) then
   Trace:=true else trace:=false;
  err:=err+Rx*Rx*(2*y-1);
  if err>0 then
  begin
   x:=x-1;
   err:=err-ry*ry*(2*x+1);
   if err>=0 then bContinue:=false;
  end;
  if Trace then
   Draw(x,y,cx,cy,quad,alpha);
 end;
 Trace:=true;
 //
 // Trace du haut du Quadrant vers le bas du quadrant.
 //
  y:=Ry;
  x:=0;
  err:=-rX*rX*Ry/2;
  bContinue:=true;
  if Trace then
   Draw(x,y,cx,cy,quad,alpha);

  while bCOntinue do begin
   x:=x+1;
   if (x>=xl) then
    trace:=false;
   err:=err+Ry*ry*(2*x-1);
   if err>0 then  begin
    y:=y-1;
    err:=err-rx*rx*(2*y+1);
    if err>0 then bContinue:=false;
   end;
    if Trace then
     Draw(x,y,cx,cy,quad,alpha);
  end;

 end;
 procedure DrawQuadFromBottom(cx,cy,rx,ry,clipx,clipy,color,quad:integer;alpha:extended);
 var ca,xl,yl,err:extended;trace,bcontinue:boolean; x,y:integer;

 begin
  Trace:=true;
  ca:=(Clipy)/(clipx);
  xl:=Round(sqrt((Rx*Rx*ry*ry)/(Rx*Rx*ca*ca+ry*ry)));
  yl:=Round(sqrt(ry*ry*(1-ry*ry/(Rx*Rx*Ca*ca+ry*ry))));

 //
 // Trace du bas du quadrant vers le Haut du quadrant.
 //
  err:=-ry*ry*Rx / 2;
  x:=Rx;
  y:=0;
 bContinue:=true;
 if Trace then
  Draw(x,y,cx,cy,quad,alpha);
 while bContinue do begin
  y:=y+1;
  if (y<yl) then
   Trace:=true else trace:=false;
  err:=err+Rx*Rx*(2*y-1);
  if err>0 then
  begin
   x:=x-1;
   err:=err-ry*ry*(2*x+1);
   if err>=0 then bContinue:=false;
  end;
  if Trace then
   Draw(x,y,cx,cy,quad,alpha);
 end;
 Trace:=false;
 //
 // Trace du haut du Quadrant vers le bas du quadrant.
 //
  y:=Ry;
  x:=0;
  err:=-rX*rX*Ry/2;
  bContinue:=true;
  if Trace then
   Draw(x,y,cx,cy,quad,alpha);

  while bCOntinue do begin
   x:=x+1;
   if (x>=xl) then
    trace:=true else trace:=false;
   err:=err+Ry*ry*(2*x-1);
   if err>0 then  begin
    y:=y-1;
    err:=err-rx*rx*(2*y+1);
    if err>0 then bContinue:=false;
   end;
    if Trace then
     Draw(x,y,cx,cy,quad,alpha);
  end;

 end;
 procedure DrawQuadAll(cx,cy,rx,ry,color,quad:integer;alpha:extended);
 var bContinue:boolean;x,y:integer;Err:extended;
 begin
   err:=-ry*ry*Rx / 2;
  x:=Rx;
  y:=0;

  bContinue:=true;
 Draw(x,y,cx,cy,quad,alpha);
 while bContinue do begin
  y:=y+1;
  err:=err+Rx*Rx*(2*y-1);
  if err>0 then
  begin
   x:=x-1;
   err:=err-ry*ry*(2*x+1);
   if err>=0 then bContinue:=false;
  end;
  Draw(x,y,cx,cy,quad,alpha);
 end;
 //
 // Trace du haut du Quadrant vers le bas du quadrant.
 //
  y:=Ry;
  x:=0;
  err:=-rX*rX*Ry/2;
  bContinue:=true;
  Draw(x,y,cx,cy,quad,alpha);

  while bCOntinue do begin
   x:=x+1;
   err:=err+Ry*ry*(2*x-1);
   if err>0 then  begin
    y:=y-1;
    err:=err-rx*rx*(2*y+1);
    if err>0 then bContinue:=false;
   end;
     Draw(x,y,cx,cy,quad,alpha);
  end;

 end;
begin
// Evaluate Status :

// PClip1InQuadran:=(GetQuadran(clip1x,clip1y)=quad);

// PClip2InQuadran:=(GetQuadran(clip2x,clip2y)=quad);


 // Rotation(x,y,pi/4,tmprx,tmpry);
 if not status=CLIPDRAWALL then
 begin
  if (clip1x=0) and (clip1y=0) and (clip2x=0) and (clip2y=0) then
  EXIT;
 end;
 Case STATUS of
   CLIPDRAWALL:
    DrawQuadAll(cx,cy,rx,ry,color,quad,alpha);
   CLIPDRAWPART: begin
    if (clip1x=0) and (clip1y=0) then begin
     DrawQuadFromTop(cx,cy,rx,ry,clip2x,clip2y,color,quad,alpha);
     EXIT;
    end;
    if (clip2x=0) and (clip2y=0) then begin
     DrawQuadFromBottom(cx,cy,rx,ry,clip1x,clip1y,color,quad,alpha);
     EXIT;
    end;
    DrawQuadPart(cx,cy,rx,ry,clip1x,clip1y,clip2x,clip2y,color,quad);
   end;
 end;
end;

procedure GetRadius(Quad,r1x,r1y,r2x,r2y:integer; var rX:integer;var rY:integer);
begin
 case quad of
  1:begin
    rx:=r1x;
    ry:=r1y;
    end;
  2:begin
     rx:=r2x;
     ry:=r1y;
    end;
  3:begin
     rx:=r2x;
     ry:=r2y;
    end;
  4:begin
     rx:=r1x;
     ry:=r2y;
    end;
 end;
end;

function SumQuad(quad,val:integer):integer;
begin
 if quad+val>4 then
  result:=quad+val-4 else
   result:=quad+val;
end;

Procedure DrawStretchedEllipseClip(Canvas:TCanvas;Quad1,Quad2,cx,cy,r1x,r1y,r2x,r2y,clip1x,clip1y,clip2x,clip2y,color:integer;alpha:extended);
var rx,ry:integer;

begin
     // Dessine le premier quadrant
     GetRadius(Quad1,r1x,r1y,r2x,r2y,rX,rY);
    if (quad1<>2) and (quad1<>4) then // if (Quad1 mod 2)<>0 then
      QuadEllipseClip(Canvas,cx,cy,Rx,ry,0,0,clip1x,Clip1y,Quad1,color,alpha,CLIPDRAWPART)
     else
      QuadEllipseClip(Canvas,cx,cy,Rx,ry,clip1x,clip1y,0,0,quad1,color,alpha,CLIPDRAWPART);
     // Dessine les quadrants suivants...
     if quad2=SumQuad(Quad1,1) then begin
      GetRadius(SumQuad(Quad1,1),r1x,r1y,r2x,r2y,Rx,Ry);
      if (quad2 mod 2)=0 then
       QuadEllipseCLip(Canvas,cx,cy,Rx,ry,0,0,clip2x,clip2y,Quad2,color,alpha,CLIPDRAWPART)
      else
       QuadEllipseCLip(Canvas,cx,cy,Rx,ry,clip2x,clip2y,0,0,Quad2,color,alpha,CLIPDRAWPART);
      end
      else
      begin
      GetRadius(SumQuad(Quad1,1),r1x,r1y,r2x,r2y,Rx,Ry);
        if quad2>Quad1+1 then
         QuadEllipseClip(Canvas,cx,cy,rX,ry,0,0,0,0,SumQuad(Quad1,1),color,alpha,CLIPDRAWALL);
      end;
     if quad2=SumQuad(quad1,2) then
     begin
      GetRadius(SumQuad(quad1,2),r1x,r1y,r2x,r2y,Rx,Ry);
      if (quad2 mod 2)<>0 then
       QuadEllipseCLip(Canvas,cx,cy,Rx,ry,clip2x,clip2y,0,0,quad2,color,alpha,CLIPDRAWPART) else
        QuadEllipseCLip(Canvas,cx,cy,Rx,ry,0,0,clip2x,clip2y,quad2,color,alpha,CLIPDRAWPART)
     end
       else
       begin
        GetRadius(SumQuad(quad1,2),r1x,r1y,r2x,r2y,Rx,Ry);
        if quad2>quad1+2 then
         QuadEllipseClip(Canvas,cx,cy,rX,ry,0,0,0,0,SumQuad(quad1,2),color,alpha,CLIPDRAWALL);

       end;
     if quad2=SumQuad(quad1,3) then
     begin
      GetRadius(SumQuad(Quad1,3),r1x,r1y,r2x,r2y,Rx,Ry);
       QuadEllipseCLip(Canvas,cx,cy,Rx,ry,0,0,clip2x,clip2y,quad2,color,alpha,CLIPDRAWPART)

     end;

end;

procedure ExtractCenterRadius(p1x, p1y, p2x, p2y, p3x, p3y, p4x,
  p4y: integer; var cx, cy, ra1, rb1, ra2, rb2: integer;
  var alpha: extended;Canvas:TCanvas);
var d1xr,d1yr,d2xr,d2yr,daxr,dayr,dbxr,dbyr,d1xa,d1ya,d2xa,d2ya,daxa,daya,dbxa,dbya:integer;
    posx,posy:integer;
begin
 d1xr:=(abs(p3x-p2x) div 2) ; d1yr:=(abs(p3y-p2y) div 2);
 d2xr:=(abs(p4x-p1x) div 2) ; d2yr:=(abs(p4y-p1y) div 2);

 if p2x<p3x then
  posx:=p2x else posx:=p3x;

 if p2y<p3y then
   posy:=p2y else posy:=p3y;

 d1xa:=d1xr+posx;d1ya:=d1yr+posy;

 if p1x<p4x then
  posx:=p1x else posx:=p4x;
 if p1y<p4y then
  posy:=p1y else posy:=p4y;

 d2xa:=d2xr+posx;d2ya:=d2yr+posy;

 daxr:=(abs(p1x-p2x) div 2); dayr:=(abs(p1y-p2y) div 2);
 dbxr:=(abs(p4x-p3x) div 2); dbyr:=(abs(p4y-p3y) div 2);

 if p2x<p1x then
  posx:=p2x else posx:=p1x;
 if p2y<p1y then
  posy:=p2y else posy:=p1y;
 daxa:=daxr+posx; daya:=dayr+posy;

 if p3x<p4x then
  posx:=p3x else posx:=p4x;
 if p3y<p4y then
  posy:=p3y else posy:=p4y;
 dbxa:=dbxr+posx; dbya:=dbyr+posy;

 if d2xa=d1xa then begin
   if d2ya=d1ya then alpha:=0 else
   begin
   if  d2ya>d1ya then alpha:=pi/2 else alpha:=-pi/2;
  end;
 end else
  alpha:=arctan((d2ya-d1ya)/(d2xa-d1xa));

  cx:=(abs(d2xa-d1xa) div 2)+d1xa; cy:=(abs(dbya-daya) div 2)+daya;
  if Canvas<>nil then begin
   Canvas.MoveTo(cx,cy); Canvas.LineTo(d1xa,d1ya);
   Canvas.MoveTo(cx,cy); Canvas.LineTo(d2xa,d2ya);
   Canvas.MoveTo(cx,cy); Canvas.LineTo(daxa,daya);
   Canvas.MoveTo(cx,cy); Canvas.LineTo(dbxa,dbya);
  end;
  Ra1:=round(sqrt( power((cx-d2xa),2)+ power((cy-d2ya),2) ));
  Rb1:=round(sqrt( power( (cx-daxa),2) + power( (cy-daya),2) ));
  ra2:=round(sqrt( power( (cx-d1xa),2) + power((cy-d1ya),2) ));
  rb2:=round(sqrt( power( (cx-dbxa),2)+power ((cy-dbya),2) ));

end;

procedure Draw(Canvas:TCanvas;x,y,tx,ty:integer;alpha:extended);
 var xr,yr:integer;
 begin
  rotation(x,y,alpha,xr,yr);
  Canvas.MoveTo(tx+xr,ty-yr); Canvas.LineTo(tx+xr-1,ty-yr-1);

  rotation(x,y,-alpha,xr,yr);
  Canvas.MoveTo(tx-xr,ty-yr); Canvas.LineTo(tx-xr-1,ty-yr-1);

  rotation(x,y,alpha,xr,yr);
  Canvas.MoveTo(tx-xr,ty+yr); Canvas.LineTo(tx-xr-1,ty+yr+1);
  rotation(x,y,-alpha,xr,yr);
  Canvas.MoveTo(xr+tx,yr+ty); Canvas.LineTo(tx+xr+1,ty+yr+1);

 end;

 procedure StretchedEllipse(canvas:TCanvas;p1,p2,p3,p4:TPoint2D;color:integer);
 begin
  StretchedEllipse(canvas,p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y,color);
 end;
 // Re-order a four point list with p1, first quad
 //                                 p2, second quad
 //                                 p3, third quad
 //                                 p4, fourth quad
 procedure OrderFourPointsList(pointlist:TPoint2DList);
 var ptMinXList:TPoint2DList; ptMaxXList:TPoint2DList;
  function EvalCriteria(xa1,ya1,xb1,yb1,xa2,ya2,xb2,yb2:extended):boolean;
  var xc,yc, deno:extended;
      ca1,ca2:extended;
  begin
   if (xa1=xb1) and (xb2=xa2) then begin
    result:=false;
    exit;
   end;
   if (xb2=xa2) or (xa1=xb1) then begin
    if xb2=xa2 then begin
     ca1:=((yb1-ya1) / (xb1-xa1));
     xc:=xa2;
     yc:=ya1+ca1*(xc-xa1);
     if xa1<xb1 then
      swap(xa1,xb1);
     if ya1<yb1 then
      swap(ya1,yb1);
     result:=(xc<=xa1) and (yc<=ya1) and (xc>=xb1) and (yc>=yb1);
     exit;
    end else
    begin
     ca2:=((yb2-ya2) / (xb2-xa2));
     xc:=xa1;
     yc:=ya2+ca2*(xc-xa2);
     if xa2>xb2 then
      swap(xa2,xb2);
     if ya2>yb2 then
      swap(ya2,yb2);
     result:=(xc>=xa2) and (yc>=ya2) and (xc<=xb2) and (yc<=yb2);
     exit;
    end;
    exit;
   end;
   ca1:=((yb1-ya1) / (xb1-xa1));
   ca2:=((yb2-ya2) / (xb2-xa2));
   deno:=(  ca1 - ca2 );
   if deno=0 then begin
    result:=false;
    exit;
   end;
   xc:= ((ya2-ya1)+(ca1*xa1-ca2*xa2))/( deno) ;
   yc:=ya2+ca2*(xc-xa2);
   if xa1<xb1 then
    swap(xa1,xb1);
   if ya1<yb1 then
    swap(ya1,yb1);
 //  if ca1=0 then begin ya1:=ya1+1; yb1:=yb1-1; end;
   result:=(xc<=(xa1+1)) and (yc<=(ya1+1)) and (xc>=(xb1-1)) and (yc>=(yb1-1));
  end;
 begin
  ptMinXlist:=TPOint2DList.Create;
  ptMaxXList:=TPOint2DList.Create;
  if pointlist.count<>4 then raise Exception.Create('The list must contain four points');
  pointlist.SortByX;


  if  EvalCriteria((pointlist.items[1] as TPoint2D).x,(pointlist.items[1] as TPoint2D).y,(pointlist.items[2] as TPoint2D).x,(pointlist.items[2] as TPoint2D).y,(pointlist.items[3] as TPoint2D).x,(pointlist.items[3] as TPoint2D).y,(pointlist.items[0] as TPoint2D).x,(pointlist.items[0] as TPoint2D).y) then
  begin
   pointlist.swap(2,3);
  end;

  {if (ptMaxXList.items[1] as TPoint2D).y>(ptMaxXList.items[0] as TPoint2D).y then
   // rechercher le + grand Y dans MinX et l'ajouter
  begin

   if (ptMinXList.items[0] as TPoint2D).y>(ptMinXList.items[1] as TPoint2D).y then
   begin
    pt.Clone(ptMinxList.Items[0] as Tpoint2D);
    pt:=pointlist.add as TPoint2D;
    pt.Clone(ptMinxList.items[1] as TPoint2D);
   end
   else
   begin
    pt.Clone(ptMinxList.Items[1] as TPoint2D);
    pt:=pointlist.add as TPoint2D;
    pt.Clone(ptMinXList.Items[0] as TPoint2D);
   end;
  end else
  begin // rechercher le + petit Y et le connecter
   if (ptMinXList.items[0] as TPoint2D).y<(ptMinXList.items[1] as TPoint2D).y then
   begin
    pt.Clone(ptMinxList.Items[0] as Tpoint2D);
    pt:=pointlist.add as TPoint2D;
    pt.Clone(ptMinxList.items[1] as TPoint2D);

   end
   else
   begin
    pt.Clone(ptMinxList.Items[1] as TPoint2D);
    pt:=pointlist.add as TPoint2D;
    pt.Clone(ptMinxList.items[0] as TPoint2D);

   end;
  end;}
  {  pt:=pointlist.add as TPoint2D;
  pt.CLone(ptMinXList.items[1] as Tpoint2D);
  pt:=pointlist.add as TPoint2D;
  pt.CLone(ptMaxXList.items[1] as Tpoint2D);}

  ptMinXList.Free;
  ptMaxXList.Free;

 end;
 { Point2DList }

constructor TPoint2DList.Create;
begin
 inherited Create(TPoint2D);
end;

procedure TPoint2DList.SortByX;
var i,j:integer;
begin
 for i:=0 to count -2 do begin
  for j:=0 to count -2 do
  begin
   if TPoint2D(items[j]).x<TPoint2D(items[j+1]).x then
    swap(j,j+1);
  end;
 end;
end;

procedure TPoint2DList.SortByY;
var i,j:integer;
begin
 for i:=0 to count -2 do begin
  for j:=0 to count -2 do
  begin
   if TPoint2D(items[j]).y<TPoint2D(items[j+1]).y then
    swap(j,j+1);
  end;
 end;
end;

procedure TPoint2DList.Swap(i, j: integer);
var pc:TPoint2D;
begin
 if i> count - 1 then
  exit;
  if j>count -1 then
   exit;
  pc:=TPoint2D.Create(nil);
  pc.x:=(Items[i] as TPoint2D).x;
  pc.y:=(Items[i] as TPoint2D).y;
  TPoint2D(Items[i]).x:=TPoint2D(Items[j]).x;
  TPoint2D(Items[i]).y:=TPoint2D(Items[j]).y;
  TPoint2D(Items[j]).x:=pc.x;
  TPoint2D(Items[j]).y:=pc.y;

  pc.Free;
end;

{ TPoint2D }

procedure TPoint2D.clone(ob: TPoint2D);
begin
 x:=ob.x;
 y:=ob.y;
end;

constructor TPoint2D.create(Collection: TCollection);
begin
  inherited;

end;

Procedure AngleEllipse(canvas:TCanvas;p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y,color:integer);
begin
end;
Procedure AngleDraw(Canvas:TCanvas;x,y,alpha,beta:extended;cx,cy,color,quad:integer);
var xt,yt:integer;
begin
 TransformCoordonate(x,y,alpha,beta,xt,yt);

 case quad of
  1: begin
   Canvas.MoveTo(cx+xt,cy-yt);
   Canvas.LineTo(cx+xt+1,cy-yt-1);
  end;
  2:begin
   Canvas.MoveTo(cx-xt,cy-yt);
   Canvas.LineTo(cx-xt-1,cy-yt-1);
  end;
  3:begin
   Canvas.MoveTo(cx-xt,cy+yt);
   Canvas.LineTo(cx-xt-1,cy+yt+1);
  end;
  4:begin
   Canvas.MoveTo(cx+xt,cy+yt);
   Canvas.LineTo(cx+xt+1,cy+yt+1);
  end;
 end;
end;

Procedure QuadAngleEllipse(canvas:TCanvas;cx,cy,Rx,ry,color,quad:integer;alpha,beta:extended);
var x,y,ix,iy,v1,v2:extended;
 Function EllipseError(x,y:extended):extended;
 begin
  // Valeur absolue, car positif erreur externe, négatif erreur vers l'intérieur, or ce n'est pas le signe de l'erreur qui
  // importe mais la valeur de l'erreur.
  Result:=abs((power(ry,2)*power(x,2))+(power(rx,2)*power(y,2))-(power(rx,2)*power(ry,2)));

 end;
 Function derivative(x,y:extended):extended;
 begin
  result:=2;
  if y=0 then exit;
  result:=-(x*ry*ry)/(y*rx*rx);
 end;
begin
 // demi quadrant bas
 iy:=1;
 ix:=1;
 rx:=round(rx*cos(alpha)+0*sin(alpha));
 ry:=round(ry*sin(beta));
 x:=Rx;
 y:=0;
 AngleDraw(canvas,x,y,alpha,beta,cx,cy,color,quad);

 while abs(derivative(x,y))>1 do begin
  //YIncrement(ix,iy,alpha,beta);
  y:=y+iy;
  ix:=1-iy*cotan(beta);
//  x:=x+ix;
  v1:=EllipseError(x-ix,y);
  v2:=EllipseError(x,y);
 if v1<v2 then
  x:=x-ix;
//   XIncrement(ix,iy,alpha,beta);
  AngleDraw(canvas,x,y,alpha,beta,cx,cy,color,quad);
 end;

 x:=0;
 y:=ry;
 AngleDraw(canvas,x,y,alpha,beta,cx,cy,color,quad);

 while abs(derivative(x,y))<=1 do begin
  //XIncrement(ix,iy,alpha,beta);
  //y:=y+iy;
  x:=x+ix;
  if EllipseError(x,y-iy)<EllipseError(x,y) then
   y:=y-iy;
  AngleDraw(canvas,x,y,alpha,beta,cx,cy,color,quad);
 end;

end;

procedure TransformCoordonate(x,y,alpha,beta:extended; var x2,y2:integer);
begin
  x2:=round(x)+round(y*cos(beta)/sin(beta));
  y2:=round(y)+round(x*tan(alpha));
end;
procedure XIncrement(var x,y:extended;alpha,beta:extended);
 var det:extended;
begin
  det:=1-(tan(alpha)*cos(beta)/sin(beta));
  x:=1/det;
  y:=-tan(alpha)/det;
end;
procedure YIncrement(var x,y:extended;alpha,beta:extended);
 var det:extended;
begin
  det:=1-(tan(alpha)*cos(beta)/sin(beta));
  y:=1/det;
  x:=-(cos(beta)/sin(beta))/det;
end;

procedure ToPolar(x, y, z: extended; var rho, teta,
  phi: extended);
begin
  // TODO:Tester les cas particuliers (0,0,0), rho=0 et (x2+y2)=0
  rho:=sqrt(power(x,2)+power(y,2)+power(z,2));
  teta:=arccos(z/rho);
  phi:=arcsin(y / (sqrt(power(x,2)+power(y,2))));
end;
procedure ToCartesian(rho,teta,phi:extended; var x,y,z:extended);
begin
 x:=rho*sin(teta)*cos(phi);
 y:=rho*sin(teta)*sin(phi);
 z:=rho*cos(teta);
end;
procedure Rotate3DX(phi:extended; var xr,yr,zr:extended);
var y,z:extended;
begin
 y:=yr;z:=zr;
 yr:=cos(phi)*y-sin(phi)*z;
 zr:=sin(phi)*y+cos(phi)*z;
end;
procedure Rotate3DY(phi:extended; var xr,yr,zr:extended);
var x,z:extended;
begin
 x:=xr;z:=zr;
 xr:=cos(phi)*x+sin(phi)*z;
 zr:=-sin(phi)*x+cos(phi)*z;
end;
procedure Rotate3DZ(phi:extended; var xr,yr,zr:extended);
var x,y:extended;
begin
 x:=xr;y:=yr;
 xr:=cos(phi)*x-y*sin(phi);
 yr:=sin(phi)*x+y*cos(phi);
end;

end.
