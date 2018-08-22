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

//Author:Jyce3d, 2004
unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Scene3D,Parser,Context,
  StdCtrls, ComCtrls;


type
  TfrmViewer = class(TForm)
    sbBar: TStatusBar;
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
     procedure ClearScreen;
  public
     procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  frmViewer: TfrmViewer;

implementation

uses Unit1, Unit3, frmViewObjects;

{$R *.DFM}


procedure TfrmViewer.ClearScreen;
var OldBrush,CurrentBrush:TBrush; Rectangle:TRect;
begin
 OldBrush:=Canvas.Brush;
 CurrentBrush:=TBrush.Create;
 with CurrentBrush do begin
  Style:=bsSolid;
  Color:=clWhite;
 end;
 Canvas.Brush:=CurrentBrush;
 with Rectangle do begin
  Left:=0;
  Top:=0;
  Right:=ClientWidth;
  Bottom:=ClientHeight;
 end;
 Canvas.FillRect(Rectangle);
 Canvas.Brush:=OldBrush;
 CurrentBrush.Free;
end;




{procedure TfrmViewer.DrawSphere(Sphere3D:TSphere3D);
var csx,csy : integer; // coordonnée projetée du centre de la sphère
    xc,yc,zc:extended;
    PointPerArc:integer;
    PhiDelta,Phi:extended;
    TetaDelta,Teta:Extended;
    i,j:integer;
    xp,yp:integer;
begin
 with Sphere3D do begin
  Projection2D(x,y,z,csx,csy);
  PointPerArc:=Round(40*radius);
 end;
 csx:=csx-ClientWidth div 2;csy:=(CLientHeight div 2)-csy;
 PhiDelta:=2*pi/PointPerArc;
 TetaDelta:=pi/Sphere3D.LatitudeCircles;
 Teta:=0;
 // Calculer les coordonnées polaires et ajouter à chaque fois les coordonnées du centre:
 // Latitude
 for i:=0 to Sphere3D.LatitudeCircles do
 begin
    Teta:=Teta+TetaDelta;
    Phi:=0;
    PolarToCart(Sphere3D.Radius,teta,Phi,xc,yc,zc);
    Projection2D(xc,yc,zc,xp,yp);
    xp:=xp+csx; yp:=yp+csy;
    Canvas.MoveTo(xp,yp);
    for j:=0 to PointPerArc do
    begin
     Phi:=Phi+PhiDelta;
     PolarToCart(Sphere3D.Radius,teta,phi,xc,yc,zc);
     Projection2D(xc,yc,zc,xp,yp);
     xp:=xp+csx; yp:=yp+csy;
     Canvas.LineTo(xp,yp);
    end;
 end;
 // Longitude
 TetaDelta:=2*pi/PointPerArc;
 PhiDelta:=2*pi/Sphere3D.LongitudeCircles;
 Phi:=0;
 for i:=0 to Sphere3D.LongitudeCircles do
 begin
    Phi:=Phi+PhiDelta;
    Teta:=0;
    PolarToCart(Sphere3D.Radius,teta,Phi,xc,yc,zc);
    Projection2D(xc,yc,zc,xp,yp);
    xp:=xp+csx;yp:=yp+csy;
    Canvas.MoveTo(xp,yp);
    for j:=0 to PointPerArc do
    begin
     teta:=teta+TetaDelta;
     PolarToCart(Sphere3D.Radius,teta,Phi,xc,yc,zc);
     Projection2D(xc,yc,zc,xp,yp);
     xp:=xp+csx; yp:=yp+csy;
     Canvas.LineTo(xp,yp);
    end;
 end;
end;}
procedure TfrmViewer.FormPaint(Sender: TObject);
var
    Scale:extended;
    Zeye:extended;
    Colatiteye:extended;
    Azimutheye:extended;
    Rhoeye:extended;
    Viewaxes:integer;
    PolygonFrames,
    xTranslate,
    yTranslate,
    zTranslate,
    CursorInc:extended;

begin

 ClearScreen;
 with frmMain.fContext do begin
  Scale:=getFloatValue('_Scale');
  Zeye:=GetFLoatValue('_Zeye');
  Rhoeye:=GetFloatValue('_Rhoeye');
  Colatiteye:=GetFloatValue('_Colatiteye');
  Azimutheye:=GetFloatValue('_Azimutheye');
  Viewaxes:=Round(GetFloatValue('_ViewAxes'));
  polygonFrames:=GetFloatValue('_PolygonFrames');
  xTranslate:=GetFloatValue('_XTranslate');
  yTranslate:=GetFloatValue('_YTranslate');
  zTranslate:=GetFloatValue('_ZTranslate');
  CursorInc:=GetFloatValue('_CursorInc');
 end;

 frmMain.fDrawer3D.ShowScene3D(Self,
                               RhoEye,
                               Colatiteye,
                               Azimutheye,
                               Zeye,
                               Scale,
                               viewaxes,
                               polygonframes,
                               xTranslate, yTranslate, zTranslate,
                               CursorInc,
                               ClientWidth,ClientHeight);
end;

procedure TfrmViewer.FormResize(Sender: TObject);
begin
 Invalidate;
end;

{procedure TfrmViewer.DrawFrame(Frame3D: TFrame3D);
var Line:TLine3D ; tmpLine3DList:TLine3DList;
begin
 tmpLine3DList:=TLine3DList.Create;
 Line:=tmpLine3DList.Add as TLine3D;
 with Frame3D do begin
  line.x1:=x; line.y1:=y; line.z1:=z;
  line.x2:=line.X1+width; line.y2:=line.y1; line.z2:=line.z1;
  DrawLine(line);
  line.x1:=x; line.y1:=y; line.z1:=z;
  line.x2:=line.x1;line.y2:=line.y1+length; line.z2:=line.z1;
  DrawLine(line);
  line.x1:=x+width; line.y1:=y; line.z1:=z;
  line.x2:=line.x1; line.y2:=line.y1+length; line.z2:=line.z1;
  DrawLine(line);
  line.x1:=x+width; line.y1:=y+length; line.z1:=z;
  line.x2:=line.x1-width; line.y2:=line.y1; line.z2:=Line.z1;
  DrawLine(line);
  line.x1:=x; line.y1:=y; line.z1:=z;
  line.x2:=line.x1; line.y2:=line.y1; line.z2:=line.z1+height;
  DrawLine(line);

  line.x1:=x; line.y1:=y; line.z1:=z+height;
  line.x2:=line.X1+width; line.y2:=line.y1; line.z2:=line.z1;
  DrawLine(line);
  line.x1:=x; line.y1:=y; line.z1:=z+height;
  line.x2:=line.x1;line.y2:=line.y1+length; line.z2:=line.z1;
  DrawLine(line);
  line.x1:=x+width; line.y1:=y; line.z1:=z+height;
  line.x2:=line.x1; line.y2:=line.y1+length; line.z2:=line.z1;
  DrawLine(line);
  line.x1:=x+width; line.y1:=y+length; line.z1:=z+height;
  line.x2:=line.x1-width; line.y2:=line.y1; line.z2:=Line.z1;
  DrawLine(line);
 // Edge
  line.x1:=x+width; line.y1:=y; line.z1:=z;
  line.x2:=line.x1; line.y2:=line.y1; line.z2:=line.z1+height;
  DrawLine(line);
  line.x1:=x; line.y1:=y+length; line.z1:=z;
  line.x2:=line.x1; line.y2:=line.y1; line.z2:=line.z1+height;
  DrawLine(line);
  line.x1:=x+width; line.y1:=y+length; line.z1:=z;
  line.x2:=line.x1; line.y2:=line.y1; line.z2:=line.z1+height;
  DrawLine(line);


 end;
 tmpLine3DList.Free;
end;}


procedure TfrmViewer.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   sbBar.SimpleText:=  '('+IntToStr(X)+','+IntToStr(Y)+')';
end;


procedure TfrmViewer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 var CurObject : TTreeNode;
     obj : TObject3D;
     scen : TScene3D;
     tx,ty,tz,
     azimuth,colat: extended;

begin
 //showmessage(inttostr(key));
 tz:=0;
 tx:=0;
 ty:=0;
 if key=38 then tx:=-frmMain.fDrawer3D.CursorInc else
  if key=40 then tx:=frmMain.fDrawer3D.CursorInc else
   if key=37 then ty:=-frmMain.fDrawer3D.CursorInc else
    if key=39 then ty:=frmMain.fDrawer3D.CursorInc;
    if ((key=187) and (ssCtrl in Shift)) then
     begin
      if (ssShift in Shift) then begin
       colat:=frmMain.fCOntext.GetFloatValue('_Colatiteye');
       colat:=colat+frmMain.fContext.GetFloatValue('_RadianInc');
       frmMain.fContext.SetFloatValue('_Colatiteye',colat);
      end else begin
       azimuth:=frmMain.fcontext.GetFloatValue('_Azimutheye');
       azimuth:=azimuth+frmMain.fContext.GetFloatValue('_RadianInc');
       frmMain.fcontext.SetFloatValue('_Azimutheye',azimuth);
      end;
     end else
      if key=187 then tz:=frmMain.fDrawer3D.CursorInc;
     if ((key=189) and (ssCtrl in Shift)) then
     begin
      if (ssShift in Shift) then begin
       colat:=frmMain.fCOntext.GetFloatValue('_Colatiteye');
       colat:=colat-frmMain.fContext.GetFloatValue('_RadianInc');
       frmMain.fContext.SetFloatValue('_Colatiteye',colat);
      end else
      begin
       azimuth:=frmMain.fcontext.GetFloatValue('_Azimutheye');
       azimuth:=azimuth-frmMain.fContext.GetFloatValue('_RadianInc');
       frmMain.fcontext.SetFloatValue('_Azimutheye',azimuth);
      end;
     end else
      if key=189 then tz:=-frmMain.fDrawer3D.CursorInc;

 CurObject:=frm3DObject.trv3DObject.Selected;
 if CurObject<>nil then begin
  if CurObject.Data<>nil then begin
    if TObject(CurObject.Data) is TScene3D then begin
     scen:=TScene3D(CurObject.Data);
     scen.Translate(tx,ty,tz);
    end else
    begin // Block
     obj:=TObject3D(CurObject.Data);
     obj.Translate(tx,ty,tz);
    end;

    Invalidate;
  end;
 end;
end;

procedure TfrmViewer.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style XOR WS_CAPTION;
  Params.Style := Params.Style XOR WS_SIZEBOX;
end;

end.
