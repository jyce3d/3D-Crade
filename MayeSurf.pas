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

//Auteur: Jyce3d, 2005
unit MayeSurf;

interface
uses scene3D;

   const
  SortOnXAsc=1;
  SortOnXDesc=2;
  SortOnYAsc=4;
  SortOnYDesc=8;
  SortOnZAsc=16;
  SortOnZDesc=32;

 function ExtrudeSurfOnX(source,target:TMayeSurface3D;nPosition:extended;nPoints:integer;bAbsolute:boolean=false):integer;
 function ExtrudeSurfOnY(source,target:TMayeSurface3D;nPosition:extended;nPoints:integer;bAbsolute:boolean=false):integer;
 function ExtrudeSurfOnZ(source,target:TMayeSurface3D;nPosition:extended;nPoints:integer;bAbsolute:boolean=false):integer;
// Révolution : Jean-Michel Jarre
 function RevolutionSurfOnX(source,target:TMayeSurface3D;phi0,phi1:extended;nPoints:Integer):integer;
 // Revolution Industrielle : Jean-Michel Jarre
 function RevolutionSurfOnY(source,target:TMayeSurface3D;phi0,phi1:extended;nPoints:Integer):integer;
 // Ma révolution : Jenifer
 function RevolutionSurfOnZ(source,target:TMayeSurface3D;phi0,phi1:extended;nPoints:Integer):integer;
 function CreateMayeFrameBox(MayeFrameBox:TMayeSurface3D;cx,cy,cz,width,length,height:extended):integer;
 function CreateMayeLine(MayeLine:TMayeSurface3D;x1,y1,z1,x2,y2,z2:extended):integer;
 function CreateLine(Line3D:TLine3D;x1,y1,z1,x2,y2,z2 : extended; color,otype : integer; Const sKeyname:string;Const parent:TScene3D; Const Drawer:TDrawer3D):integer;
 function CreateMayeEllipseClip(MayeEllipseClip:TMayeSurface3D;cx,cy,cz,a,b,phi0,phi1:extended):integer;overload;
 function CreateMayeEllipseClip(MayeEllipseClip:TMayeSurface3D;cx,cy,cz,a,b,phi0,phi1:extended;nLong,color,otype:integer;const sKeyname:string;Const parent:TScene3D; Const Drawer:TDrawer3D):integer;overload;
 function CreateMayeArcoid(MayeArcoid:TMayeSurface3D;cx,cy,cz,rx,ry,rz,phi0,phi1,teta0,teta1:extended):integer;overload;
 function CreateMayeArcoid(MayeArcoid:TMayeSurface3D;cx,cy,cz,rx,ry,rz,phi0,phi1,teta0,teta1:extended; nLong,nLat,Color,oType,Transparent:integer; Const sKeyname:string;Const parent:TScene3D; Const Drawer:TDrawer3D):integer;overload;
 function CreateFrame(Frame3D:TFrame3D;cx,cy,cz,height,length,width : extended; color,otype: integer; const sKeyname:string; const parent:TScene3D; const Drawer:TDrawer3D):integer;
 function CreateMayeEllipse(MayeEllipse:TMayeSurface3D;cx,cy,cz,a,b:extended):integer;overload;
 function CreateMayeEllipse(MayeEllipse:TMayeSurface3D;cx,cy,cz,a,b:extended;nLong,color,oType:integer;Const sKeyname:string;Const parent:TScene3D; Const Drawer:TDrawer3D):integer;overload;

 function CreateMayeSolidEllipse(MayeEllipse:TMayeSurface3D;cx,cy,cz,a,b:extended):integer;
 function CreateWall(MayeWall:TMayeSurface3D;length,height:extended):integer;
 function CreateWallCorner(MayeWall:TMayeSurface3D; height: extended):integer;
 function CreateWallFence(MayeWall:TMayeSurface3D;length,height : extended):integer;
 function CreateFence(MayeWall:TMayeSurface3D;length,height:extended):integer;

 procedure DrawBrikX(MayeWall:TMayeSurface3D;length:extended;var width:extended;height:extended;sKeyname:string;offset:extended=0);
 procedure DrawBlockX(MayeWall:TMayeSurface3D;length:extended;var width:extended;height:extended;sKeyname:string;offset:extended=0);
 procedure DrawWoolX(MayeWall:TMayeSurface3D;length:extended;var width:extended;height:extended;sKeyname:string;offset:extended=0);
 procedure DrawFenceX(MayeWall:TMayeSurface3D;length:extended;var width:extended;height:extended;sKeyname:string;offset:extended=0;dy:extended=0.005);

 procedure DrawBrikY(MayeWall:TMayeSurface3D;var length:extended; width:extended;height:extended;skeyname:string;offset:extended=0);
 procedure DrawBlockY(MayeWall:TMayeSurface3D;var length:extended; width:extended;height:extended;sKeyname:string;offset:extended=0);
 procedure DrawWoolY(MayeWall:TMayeSurface3D;var length:extended;width:extended;height:extended;sKeyname:string;offset:extended=0);
 procedure DrawFenceY(MayeWall:TMayeSurface3D;var length:extended;width:extended;height:extended;sKeyname:string;offset:extended=0);
 
 // Sorting routines
 procedure Sort(var a:array of TMayeEdge;Criteria:integer);
 procedure ExchangeSortAscX(var a: array of TMayeEdge);
 procedure ExchangeSortAscY(var a: array of TMayeEdge);
 procedure ExchangeSortAscZ(var a: array of TMayeEdge);

 procedure Swap(var aRef:TMayeEdge; var bRef:TMayeEdge);



implementation
uses sysutils,graphlib;
 function ExtrudeSurfOnX(source,target:TMayeSurface3D;nPosition:extended;nPoints:integer;bAbsolute:boolean=false):integer;
 var step:extended;
     tri,tri2,tri3 : TMayeTriFace3D;
     edl:TMayeEdgelist;
     eds,edt,ed1:TMayeEdge;
     i,j,cp:integer;
     bTwoFace : boolean;
 begin
  result:=0;

  target.nLong:=source.nLong;
  target.nLat:=nPoints;

  for i:=0 to source.fMayeTriFace3DList.Count -1 do
  begin
//   tri2:=Target.fMayeTriFace3DList.Add ;
 //   tri.fParent:=target.fparent;
    tri:=Source.fMayeTriFace3DList.Items[i] as TMayeTriface3D;
    edl:=tri.fMayeEdgeList;

    if edl.Count=2 then
     bTwoFace:=true else bTwoFace:=false;

    cp:=0;
    tri2:=target.fMayeTriFace3DList.Add as TMayeTriFace3D;
    tri2.Clone(tri);
    tri2.KeyName:=Target.Keyname+'_'+inttostr(i)+'0_extr';

    while cp<nPoints-1 do begin

     for j:=0 to edl.Count -1 do
     begin
      if bTwoFace then begin
       eds:=edl.items[j] as TMayeEdge;
       if not bAbsolute then
        step:=nPosition/(nPoints-1) else
         step:=(nPosition-((Source.fMayeTriFace3DList.Items[i] as TMayeTriface3D).fMayeEdgeList.Items[j] as TMayeEdge).x)/(nPoints-1);
       edt:=tri2.fMayeEdgeList.Add as TMayeEdge;
       edt.x:=eds.x+step;
       edt.y:=eds.y;
       edt.z:=eds.z;
      end;
     end;
     if cp<nPoints-2 then begin
      tri3:=target.fMayeTriFace3DList.Add as TMayeTriFace3D;
      tri3.fparent:=tri2.fparent;
      tri3.Color:=tri2.color;
      tri3.oType:=tri2.oType;
      tri3.Hide:=tri2.Hide;
      tri3.Keyname:=Target.KeyName+'_'+inttostr(i)+inttostr(cp+1)+'_extr';
      for j:=2 to tri2.fMayeEdgeList.Count -1 do
      begin
       ed1:=tri3.fMayeEdgeList.add as TMayeEdge;
       ed1.x:=(tri2.fMayeEdgeList.items[j] as TMayeEdge).x;
       ed1.y:=(tri2.fMayeEdgeList.items[j] as TMayeEdge).y;
       ed1.z:=(tri2.fMayeEdgeList.items[j] as TMayeEdge).z;
      end;
      tri2:=tri3;
      edl:=tri2.fMayeEdgeList;
     end;
     cp:=cp+1;
    end;

  end;

 end;

 function ExtrudeSurfOnY(source,target:TMayeSurface3D;nPosition:extended;nPoints:integer;bAbsolute:boolean=false):integer;
 var step:extended;
     tri,tri2,tri3 : TMayeTriFace3D;
     edl:TMayeEdgelist;
     eds,edt,ed1:TMayeEdge;
     i,j,cp:integer;
     bTwoFace : boolean;
 begin
  result:=0;

  target.nLong:=source.nLong;
  target.nLat:=nPoints;

  for i:=0 to source.fMayeTriFace3DList.Count -1 do
  begin
//   tri2:=Target.fMayeTriFace3DList.Add ;
    tri:=Source.fMayeTriFace3DList.Items[i] as TMayeTriface3D;
    edl:=tri.fMayeEdgeList;

    if edl.Count=2 then
     bTwoFace:=true else bTwoFace:=false;
    cp:=0;
    tri2:=target.fMayeTriFace3DList.Add as TMayeTriFace3D;
    tri2.Clone(tri);
    tri2.KeyName:=Target.Keyname+'_'+inttostr(i)+'0_extr';

    while cp<nPoints-1 do begin

     for j:=0 to edl.Count -1 do
     begin
      if bTwoFace then begin
       eds:=edl.items[j] as TMayeEdge;
       if not bAbsolute then
        step:=nPosition/(nPoints-1) else
         step:=(nPosition-((Source.fMayeTriFace3DList.Items[i] as TMayeTriface3D).fMayeEdgeList.Items[j] as TMayeEdge).y)/(nPoints-1);
       edt:=tri2.fMayeEdgeList.Add as TMayeEdge;
       edt.x:=eds.x;
       edt.y:=eds.y+step;
       edt.z:=eds.z;
      end;
     end;
     if cp<nPoints-2 then begin
      tri3:=target.fMayeTriFace3DList.Add as TMayeTriFace3D;
      tri3.fparent:=tri2.fparent;
      tri3.Keyname:=Target.KeyName+'_'+inttostr(i)+inttostr(cp+1)+'_extr';
      tri3.Color:=tri2.color;
      tri3.oType:=tri2.oType;
      tri3.Hide:=tri2.Hide;
      for j:=2 to tri2.fMayeEdgeList.Count -1 do
      begin
       ed1:=tri3.fMayeEdgeList.add as TMayeEdge;
       ed1.x:=(tri2.fMayeEdgeList.items[j] as TMayeEdge).x;
       ed1.y:=(tri2.fMayeEdgeList.items[j] as TMayeEdge).y;
       ed1.z:=(tri2.fMayeEdgeList.items[j] as TMayeEdge).z;
      end;
      tri2:=tri3;
      edl:=tri2.fMayeEdgeList;
     end;
     cp:=cp+1;
    end;

  end;
 end;
 function ExtrudeSurfOnZ(source,target:TMayeSurface3D;nPosition:extended;nPoints:integer;bAbsolute:boolean=false):integer;
 var step:extended;
     tri,tri2,tri3 : TMayeTriFace3D;
     edl:TMayeEdgelist;
     eds,edt,ed1:TMayeEdge;
     i,j,cp:integer;
     bTwoFace : boolean;
 begin
  result:=0;

  target.nLat:=source.nLong;
  target.nLong:=nPoints;

  for i:=0 to source.fMayeTriFace3DList.Count -1 do
  begin
//   tri2:=Target.fMayeTriFace3DList.Add ;
    tri:=Source.fMayeTriFace3DList.Items[i] as TMayeTriface3D;
    edl:=tri.fMayeEdgeList;

    if edl.Count=2 then
     bTwoFace:=true else bTwoFace:=false;
    cp:=0;
    tri2:=target.fMayeTriFace3DList.Add as TMayeTriFace3D;
    tri2.Clone(tri);
    tri2.KeyName:=Target.Keyname+'_'+inttostr(i)+'0_extr';

    while cp<nPoints-1 do begin

     for j:=0 to edl.Count -1 do
     begin
      if bTwoFace then begin
       eds:=edl.items[j] as TMayeEdge;
       if not bAbsolute then
        step:=nPosition/(nPoints-1) else
         step:=(nPosition-((Source.fMayeTriFace3DList.Items[i] as TMayeTriface3D).fMayeEdgeList.Items[j] as TMayeEdge).z)/(nPoints-1);
       edt:=tri2.fMayeEdgeList.Add as TMayeEdge;
       edt.x:=eds.x;
       edt.y:=eds.y;
       edt.z:=eds.z+step;
      end;
     end;
     if cp<nPoints-2 then begin

      tri3:=target.fMayeTriFace3DList.Add as TMayeTriFace3D;
      tri3.fparent:=tri2.fparent;
      tri3.Keyname:=Target.KeyName+'_'+inttostr(i)+inttostr(cp+1)+'_extr';
      tri3.Color:=tri2.color;
      tri3.oType:=tri2.oType;
      tri3.Hide:=tri2.Hide;

      for j:=2 to tri2.fMayeEdgeList.Count -1 do
      begin
       ed1:=tri3.fMayeEdgeList.add as TMayeEdge;
       ed1.x:=(tri2.fMayeEdgeList.items[j] as TMayeEdge).x;
       ed1.y:=(tri2.fMayeEdgeList.items[j] as TMayeEdge).y;
       ed1.z:=(tri2.fMayeEdgeList.items[j] as TMayeEdge).z;
      end;
      tri2:=tri3;
      edl:=tri2.fMayeEdgeList;
     end;
     cp:=cp+1;
    end;

  end;

 end;
 function RevolutionSurfOnX(source,target:TMayeSurface3D;phi0,phi1:extended;nPoints:Integer):integer;
 var delta:extended; i,cp,j:integer; eds, edt:TMayeEdge;      xr,yr,zr:extended;
     edl:TMayeEdgeList;
     tri,TriTarget,TriTargetNext:TMayeTriFace3D;
 begin
  delta:=abs(phi1-phi0) / (nPoints-1);
  target.nLong:=source.nLong;
  target.nLat:=nPoints;

  for i:=0 to source.fMayeTriFace3DList.Count -1 do
  begin
   tri:=Source.fMayeTriFace3DList.Items[i] as TMayeTriFace3D;
   edl:=Tri.fMayeEdgeList;
   if edl.count<>2 then
    raise Exception.Create('RevolutionSurfOnX:This mayesurface cannot be revolved.');
   cp:=0;
   TriTarget:=Target.fMayeTriFace3DList.Add as TMayeTriFace3D;
   TriTarget.Clone(Tri);
   TriTarget.KeyName:=Target.KeyName+'_'+inttostr(i)+inttostr(cp)+'_revolt';
   while cp<nPoints-1 do begin
    for j:=0 to edl.Count -1 do
    begin
     eds:=edl.Items[j] as TMayeEdge;
     xr:=eds.x;
     yr:=eds.y;
     zr:=eds.z;
     Rotate3DX(delta,xr,yr,zr);
     edt:=TriTarget.fMayeEdgeList.Add as TMayeEdge;
     edt.x:=xr;
     edt.y:=yr;
     edt.z:=zr;
    end;
    if cp<nPoints-2 then begin

     TriTargetNext:=Target.fMayeTriFace3DList.Add as TMayeTriFace3D;
     TriTargetNext.fparent:=TriTarget.fparent;
     TriTargetNext.Color:=TriTarget.Color;
     TriTargetNext.oType:=TriTarget.oType;
     TriTargetNext.Hide:=TriTarget.Hide;
     for j:=2 to TriTarget.fMayeEdgeList.Count -1 do
     begin
      edt:=TriTargetNext.fMayeEdgeList.Add as TMayeEdge;
      edt.x:=(TriTarget.fMayeEdgeList.Items[j] as TMayeEdge).x;
      edt.y:=(TriTarget.fMayeEdgeList.Items[j] as TMayeEdge).y;
      edt.z:=(TriTarget.fMayeEdgeList.Items[j] as TMayeEdge).z;
     end;
     TriTarget:=TriTargetNext;
     Edl:=TriTarget.fMayeEdgeList;
    end;
    cp:=cp+1;
   end;// end while

  end;   // for i
  result:=1;

 end;

 function RevolutionSurfOnY(source,target:TMayeSurface3D;phi0,phi1:extended;nPoints:Integer):integer;
 var delta:extended; i,cp,j:integer; eds, edt:TMayeEdge;      xr,yr,zr:extended;
     edl:TMayeEdgeList;
     tri,TriTarget,TriTargetNext:TMayeTriFace3D;
 begin
  delta:=abs(phi1-phi0) / (nPoints-1);
  target.nLong:=source.nLong;
  target.nLat:=nPoints;

  for i:=0 to source.fMayeTriFace3DList.Count -1 do
  begin
   tri:=Source.fMayeTriFace3DList.Items[i] as TMayeTriFace3D;
   edl:=Tri.fMayeEdgeList;
   if edl.count<>2 then
    raise Exception.Create('RevolutionSurfOnY:This mayesurface cannot be revolved.');
   cp:=0;
   TriTarget:=Target.fMayeTriFace3DList.Add as TMayeTriFace3D;
   TriTarget.Clone(Tri);
   TriTarget.KeyName:=Target.KeyName+'_'+inttostr(i)+inttostr(cp)+'_revolt';
   while cp<nPoints-1 do begin
    for j:=0 to edl.Count -1 do
    begin
     eds:=edl.Items[j] as TMayeEdge;
     xr:=eds.x;
     yr:=eds.y;
     zr:=eds.z;
     Rotate3DY(delta,xr,yr,zr);
     edt:=TriTarget.fMayeEdgeList.Add as TMayeEdge;
     edt.x:=xr;
     edt.y:=yr;
     edt.z:=zr;
    end;
    if cp<nPoints-2 then begin
     TriTargetNext:=Target.fMayeTriFace3DList.Add as TMayeTriFace3D;
     TriTargetNext.fparent:=Target.fparent;
     TriTargetNext.Color:=TriTarget.Color;
     TriTargetNext.oType:=TriTarget.oType;
     TriTargetNext.Hide:=TriTarget.Hide;
     for j:=2 to TriTarget.fMayeEdgeList.Count -1 do
     begin
      edt:=TriTargetNext.fMayeEdgeList.Add as TMayeEdge;
      edt.x:=(TriTarget.fMayeEdgeList.Items[j] as TMayeEdge).x;
      edt.y:=(TriTarget.fMayeEdgeList.Items[j] as TMayeEdge).y;
      edt.z:=(TriTarget.fMayeEdgeList.Items[j] as TMayeEdge).z;
     end;
     TriTarget:=TriTargetNext;
     Edl:=TriTarget.fMayeEdgeList;
    end;
    cp:=cp+1;
   end;// end while

  end;   // for i
  result:=1;
 end;

 function RevolutionSurfOnZ(source,target:TMayeSurface3D;phi0,phi1:extended;nPoints:Integer):integer;
 var delta:extended; i,cp,j:integer; eds, edt:TMayeEdge;      xr,yr,zr:extended;
     edl:TMayeEdgeList;
     tri,TriTarget,TriTargetNext:TMayeTriFace3D;
 begin
  delta:=abs(phi1-phi0) / (nPoints-1);
  target.nLat:=source.nLong;
  target.nLong:=nPoints;

  for i:=0 to source.fMayeTriFace3DList.Count -1 do
  begin
   tri:=Source.fMayeTriFace3DList.Items[i] as TMayeTriFace3D;
   edl:=Tri.fMayeEdgeList;
   if edl.count<>2 then
    raise Exception.Create('RevolutionSurfOnZ:This mayesurface cannot be revolved.');
   cp:=0;
   TriTarget:=Target.fMayeTriFace3DList.Add as TMayeTriFace3D;
   TriTarget.Clone(Tri);
   TriTarget.KeyName:=Target.KeyName+'_'+inttostr(i)+inttostr(cp)+'_revolt';
   while cp<nPoints-1 do begin
    for j:=0 to edl.Count -1 do
    begin
     eds:=edl.Items[j] as TMayeEdge;
     xr:=eds.x;
     yr:=eds.y;
     zr:=eds.z;
     Rotate3DZ(delta,xr,yr,zr);
     edt:=TriTarget.fMayeEdgeList.Add as TMayeEdge;
     edt.x:=xr;
     edt.y:=yr;
     edt.z:=zr;
    end;
    if cp<nPoints-2 then begin
     TriTargetNext:=Target.fMayeTriFace3DList.Add as TMayeTriFace3D;
     TriTargetNext.fparent:=TriTarget.fparent;
     TriTargetNext.Color:=TriTarget.Color;
     TriTargetNext.oType:=TriTarget.oType;
     TriTargetNext.Hide:=TriTarget.Hide;
     for j:=2 to TriTarget.fMayeEdgeList.Count -1 do
     begin
      edt:=TriTargetNext.fMayeEdgeList.Add as TMayeEdge;
      edt.x:=(TriTarget.fMayeEdgeList.Items[j] as TMayeEdge).x;
      edt.y:=(TriTarget.fMayeEdgeList.Items[j] as TMayeEdge).y;
      edt.z:=(TriTarget.fMayeEdgeList.Items[j] as TMayeEdge).z;
     end;
     TriTarget:=TriTargetNext;
     Edl:=TriTarget.fMayeEdgeList;
    end;
    cp:=cp+1;
   end;// end while

  end;   // for i
  result:=1;
 end;

 function CreateMayeFrameBox(MayeFrameBox:TMayeSurface3D;cx,cy,cz,width,length,height:extended):integer;
 var
 deltax,deltay,deltaz,px,py,pz:extended;
 MayeTriList:TMayeTriFace3DList;
 Tri : TMayeTriFace3D;
 Seg : TMayeEdge;
 i,j : integer;

 begin
  result:=0;
 if (MayeFrameBox.nLat<>0) and (MayeFrameBox.nLong<>0) then begin
   deltax:=2*width/MayeFramebox.nLong;
   deltay:=2*length/MayeFramebox.nLong;
   deltaz:=2*height/MayeFramebox.nLat;

   // First face
   px:=cx+width;py:=cy-length;pz:=cz+height;

   MayeTriList:=MayeFramebox.fMayeTriFace3DList;
   for j:=1 to MayeFramebox.nLat do begin
     for i:=1 to MayeFramebox.nLong do begin
      // First Point
       Tri:=MayeTriList.Add as TMayeTriFace3D;
       Tri.KeyName:=MayeFramebox.KeyName+'_'+inttostr(i)+';'+inttostr(j);
       Tri.Color:=MayeFramebox.color;
       Tri.oType:=MayeFramebox.oType;
       Tri.fParent:=MayeFrameBox.fParent;
       Tri.nTransparent:=MayeFrameBox.nTransparent;
       Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
       Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      // Second Point
       Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
       pz:=pz-deltaz;
       Seg.x:=px; Seg.y:=py; Seg.z:=pz;
       pz:=pz+deltaz;
      // 3 Point
       Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
       py:=py+deltay;
       Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      // 4 Point
       Seg:=Tri.FmayeEdgeList.Add AS TMayeEdge;
       pz:=pz-deltaz;
       Seg.x:=px; Seg.y:=py; Seg.z:=pz;
       pz:=pz+deltaz;
      end;
     pz:=pz-deltaz;
     py:=cy-length;
   end;
   // Second Face
   px:=cx-width;py:=cy+length;pz:=cz+height;
   MayeTriList:=MayeFramebox.fMayeTriFace3DList;
   for j:=1 to MayeFramebox.nLat do begin
     for i:=1 to MayeFramebox.nLong do begin
      Tri:=MayeTriList.Add as TMayeTriFace3D;
      Tri.KeyName:=MayeFramebox.KeyName+'_'+inttostr(i)+';'+inttostr(j);
      Tri.Color:=MayeFramebox.color;
      Tri.oType:=MayeFramebox.oType;
      Tri.nTransparent:=MayeFrameBox.nTransparent;
      Tri.fParent:=MayeFrameBox.fParent;

      // 1rs point
      Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      // 2d point
      Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
      pz:=pz-deltaz;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      pz:=pz+deltaz;
      // 3ème pt
      Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
      px:=px+deltax;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      // 4em
      Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
      pz:=pz-deltaz;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      pz:=pz+deltaz;
     end;
     pz:=pz-deltaz;
     px:=cx-width;
   end;

  // Third
   px:=cx-width;py:=cy-length;pz:=cz+height;
   MayeTriList:=MayeFramebox.fMayeTriFace3DList;
   for j:=1 to MayeFramebox.nLat do begin
     for i:=1 to MayeFramebox.nLong do begin
      // First Point
       Tri:=MayeTriList.Add as TMayeTriFace3D;
       Tri.KeyName:=MayeFramebox.KeyName+'_'+inttostr(i)+';'+inttostr(j);
       Tri.Color:=MayeFramebox.color;
       Tri.oType:=MayeFramebox.oType;
       Tri.nTransparent:=MayeFrameBox.nTransparent;
       Tri.fParent:=MayeFrameBox.fParent;

       Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
       Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      // Second Point
       Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
       pz:=pz-deltaz;
       Seg.x:=px; Seg.y:=py; Seg.z:=pz;
       pz:=pz+deltaz;
      // 3 Point
       Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
       py:=py+deltay;
       Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      // 4 Point
       Seg:=Tri.FmayeEdgeList.Add AS TMayeEdge;
       pz:=pz-deltaz;
       Seg.x:=px; Seg.y:=py; Seg.z:=pz;
       pz:=pz+deltaz;
      end;
     pz:=pz-deltaz;
     py:=cy-length;
   end;
   // Fourth
   px:=cx-width;py:=cy-length;pz:=cz+height;
   MayeTriList:=MayeFramebox.fMayeTriFace3DList;
   for j:=1 to MayeFramebox.nLat do begin
     for i:=1 to MayeFramebox.nLong do begin
      Tri:=MayeTriList.Add as TMayeTriFace3D;
      Tri.KeyName:=MayeFramebox.KeyName+'_'+inttostr(i)+';'+inttostr(j);
      Tri.Color:=MayeFramebox.color;
      Tri.oType:=MayeFramebox.oType;
      Tri.nTransparent:=MayeFrameBox.nTransparent;
      Tri.fParent:=MayeFrameBox.fParent;

      // 1rs point
      Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      // 2d point
      Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
      pz:=pz-deltaz;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      pz:=pz+deltaz;
      // 3ème pt
      Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
      px:=px+deltax;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      // 4em
      Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
      pz:=pz-deltaz;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      pz:=pz+deltaz;
     end;
     pz:=pz-deltaz;
     px:=cx-width;
   end;

   // Fifth

   px:=cx+width;py:=cy-length;pz:=cz-height;
   for j:=1 to MayeFramebox.nLong do begin
     for i:=1 to MayeFramebox.nLong do begin
      MayeTriList:=MayeFramebox.fMayeTriFace3DList;
      Tri:=MayeTriList.Add as TMayeTriFace3D;
      Tri.KeyName:=MayeFramebox.KeyName+'_'+inttostr(i)+';'+inttostr(j);
      Tri.Color:=MayeFramebox.color;
      Tri.oType:=MayeFramebox.oType;
      Tri.nTransparent:=MayeFrameBox.nTransparent;
      Tri.fParent:=MayeFrameBox.fParent;
  // 1 pt
      Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
  // 2 pt
      Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
      px:=px-deltax;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      px:=px+deltax;
  // 3
      Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
      py:=py+deltay;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
  // 4
      Seg:=Tri.FmayeEdgeList.add as TMayeEdge;
      px:=px-deltax;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      px:=px+deltax;
     end;
     px:=px-deltax;
     py:=cy-length;
   end;
  // Sixth
   px:=cx+width;py:=cy-length;pz:=cz+height;
   for j:=1 to MayeFramebox.nLong do begin
     for i:=1 to MayeFramebox.nLong do begin
      MayeTriList:=MayeFramebox.fMayeTriFace3DList;
      Tri:=MayeTriList.Add as TMayeTriFace3D;
      Tri.KeyName:=MayeFramebox.KeyName+'_'+inttostr(i)+';'+inttostr(j);
      Tri.Color:=MayeFramebox.color;
      Tri.oType:=MayeFramebox.oType;
      Tri.nTransparent:=MayeFrameBox.nTransparent;
      Tri.fParent:=MayeFrameBox.fParent;

  // 1 pt
      Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
  // 2 pt
      Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
      px:=px-deltax;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      px:=px+deltax;
  // 3
      Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
      py:=py+deltay;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
  // 4
      Seg:=Tri.FmayeEdgeList.add as TMayeEdge;
      px:=px-deltax;
      Seg.x:=px; Seg.y:=py; Seg.z:=pz;
      px:=px+deltax;
     end;
     px:=px-deltax;
     py:=cy-length;
   end;

   end
    else
  // plane surface
  if MayeFramebox.nLat=0 then begin    // XY
    deltax:=2*width/MayeFramebox.nLong;
    deltay:=2*length/MayeFramebox.nLong;

    MayeTriList:=MayeFramebox.fMayeTriFace3DList;
    px:=cx-width;py:=cy-length;pz:=cz;
   for i:=1 to MayeFrameBox.nLong do begin
    for j:=1 to MayeFrameBox.nLong do begin
      Tri:=MayeTriList.Add as TMayeTriFace3D;
      Tri.KeyName:=MayeFramebox.KeyName+'_'+inttostr(i)+';'+inttostr(j);
      Tri.Color:=MayeFramebox.color;
      Tri.oType:=MayeFramebox.oType;
      Tri.nTransparent:=MayeFrameBox.nTransparent;
      Tri.fParent:=MayeFrameBox.fParent;

      Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
      Seg.x:=px;Seg.y:=py;Seg.z:=pz;

      Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
      Seg.x:=px+deltax;Seg.y:=py;Seg.z:=pz;

      Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
      Seg.x:=px+deltax;Seg.y:=py+deltay;Seg.z:=pz;

      Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
      Seg.x:=px;Seg.y:=py+deltay;Seg.z:=pz;
      px:=px+deltax;
    end;
    px:=cx-width;
    py:=py+deltay;
   end;
  end else
    if MayeFrameBox.nLong=0 then begin
     if width=0 then begin  // CAS YZ
      deltay:=2*length/MayeFrameBox.nLat;
      deltaz:=2*height/MayeFrameBox.nLat;
      MayeTriList:=MayeFramebox.fMayeTriFace3DList;
      px:=cx;py:=cy-length;pz:=cz-height;

     for i:=1 to MayeFrameBox.nLat do begin
      for j:=1 to MayeFrameBox.nLat do begin
       Tri:=MayeTriList.Add as TMayeTriFace3D;
       Tri.KeyName:=MayeFramebox.KeyName+'_'+inttostr(i)+';'+inttostr(j);
       Tri.Color:=MayeFramebox.color;
       Tri.oType:=MayeFramebox.oType;
       Tri.nTransparent:=MayeFrameBox.nTransparent;
       Tri.fParent:=MayeFrameBox.fParent;

       Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
       Seg.x:=px;Seg.y:=py;Seg.z:=pz;

       Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
       Seg.x:=px;Seg.y:=py;Seg.z:=pz+deltaz;

       Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
       Seg.x:=px;Seg.y:=py+deltay;Seg.z:=pz+deltaz;

       Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
       Seg.x:=px;Seg.y:=py+deltay;Seg.z:=pz;
       py:=py+deltay;
     end;
     pz:=pz+deltaz;
     py:=cy-length;
    end;

     end else
      if length=0 then begin // CAS XZ
      deltax:=2*length/MayeFrameBox.nLat;
      deltaz:=2*height/MayeFrameBox.nLat;
      MayeTriList:=MayeFramebox.fMayeTriFace3DList;
      px:=cx-width;py:=cy;pz:=cz-height;

     for i:=1 to MayeFrameBox.nLat do begin
      for j:=1 to MayeFrameBox.nLat do begin
       Tri:=MayeTriList.Add as TMayeTriFace3D;
       Tri.KeyName:=MayeFramebox.KeyName+'_'+inttostr(i)+';'+inttostr(j);
       Tri.Color:=MayeFramebox.color;
       Tri.oType:=MayeFramebox.oType;
       Tri.nTransparent:=MayeFrameBox.nTransparent;
       Tri.fParent:=MayeFrameBox.fParent;

       Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
       Seg.x:=px;Seg.y:=py;Seg.z:=pz;

       Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
       Seg.x:=px;Seg.y:=py;Seg.z:=pz+deltaz;

       Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
       Seg.x:=px+deltax;Seg.y:=py;Seg.z:=pz+deltaz;

       Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
       Seg.x:=px+deltax;Seg.y:=py;Seg.z:=pz;
       px:=px+deltax;
     end;
     pz:=pz+deltaz;
     px:=cx-width;
    end;

      end else
       raise exception.Create('CreateMayeFrameBox:Case not supported');
    end;



  end;

 procedure ExchangeSortAscX(var a: array of TMayeEdge);
 var n,i,j:integer;
 begin
  n:=High(a);
 for i:=0 to n -1 do
  for j:=i+1 to n  do begin
   if (a[j] as TMayeEdge).x<(a[i] as TMayeEdge).x then
    swap(a[j],a[i]);
  end;

 end;
procedure ExchangeSortAscY(var a: array of TMayeEdge);
 var n,i,j:integer;
 begin
  n:=High(a);
 for i:=0 to n -1 do
  for j:=i+1 to n  do begin
   if (a[j] as TMayeEdge).y<(a[i] as TMayeEdge).y then
    swap(a[j],a[i]);
  end;
 end;
procedure ExchangeSortAscZ(var a: array of TMayeEdge);
 var n,i,j:integer;
 c:TMayeEdge;
 begin
  n:=High(a);
 for i:=0 to n -1 do
  for j:=i+1 to n  do begin
   if (a[j] as TMayeEdge).z<(a[i] as TMayeEdge).z then
   begin
    c:=a[j];
    a[j]:=a[i];
    a[i]:=c;
   end;
  end;

  //for i:=0 to n-1 do
  // showmessage(floattostr((a[i] as TMayeEdge).z));
 end;

procedure Sort(var a: array of TMayeEdge; Criteria: integer);
begin
 if (Criteria and SortOnXAsc)=SortOnXAsc then
  ExchangeSortAscX(a) else
 if (Criteria and SortOnYAsc)=SortOnYAsc then
  ExchangeSortAscY(a) else
 if (Criteria and SortOnZAsc)=SortOnZAsc then
  ExchangeSortAscZ(a);

end;

procedure Swap( var aRef, bRef: TMayeEdge);
var c:TMayeEdge;
begin
 c:=aRef;
 aRef:=bRef;
 bRef:=c;
end;
// On construit suivant le sens qui est donné en fonction de phi1-phi0
// le départ est toujours phi0
// ex : phi1=-pi/4 et phi0=pi/4 on tourne ans le sens négatif
//      phi1=7pi/4 (=2pi-pi/4=-pi/4) mais ici on tourne dans le sens positif
// On construit suivant le sens qui est donné en fonction de teta1-teta0
// le départ est toujours teta0
// !!!!! Dans le cas de téta le sens positif est le sens horlogé en partant de z vers xy
// ex : teta1=-pi/4 et teta0=pi/4 on tourne ans le sens négatif
//      teta1=7pi/4 (=2pi-pi/4=-pi/4) mais ici on tourne dans le sens positif

function CreateMayeArcoid(MayeArcoid:TMayeSurface3D;cx,cy,cz,rx,ry,rz,phi0,phi1,teta0,teta1:extended):integer;
var MayeTriList:TMayeTriFace3DList;Tri:TMayeTriFace3D;Seg:TMayeEdge;
    i,j:integer;
    deltateta,teta,deltaphi,phi,px,py,pz:extended;
 procedure CalcArcoid(var px,py,pz:extended);
 begin
  px:=rx*sin(teta)*cos(phi)+cx;
  py:=ry*sin(teta)*sin(phi)+cy;
  pz:=rz*cos(teta)+cz;
 end;

begin

 phi:=phi0;teta:=teta0;
 deltaphi:=(phi1-phi0)/MayeArcoid.nLong; deltateta:=(teta1-teta0)/MayeArcoid.nLat;
// if teta1>=teta0 then
//  teta:=teta0 else teta:=teta1;
 for j:=1 to MayeArcoid.nLat do begin
   for i:=1 to MayeArcoid.nLong do begin
    MayeTriList:=MayeArcoid.fMayeTriFace3DList;
    Tri:=MayeTriList.Add as TMayeTriFace3D;
    Tri.KeyName:=MayeArcoid.KeyName+'_'+inttostr(i)+';'+inttostr(j);
    Tri.Color:=MayeArcoid.color;
    Tri.oType:=MayeArcoid.oType;
    Tri.fParent:=MayeArcoid.fparent;
    Tri.nTransparent:=MayeArcoid.nTransparent;
    // First
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    CalcArcoid(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    // Second
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    teta:=teta+deltateta;
    CalcArcoid(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    // Third
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    teta:=teta-deltateta;
    phi:=phi+deltaphi;
    CalcArcoid(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    // Added
    teta:=teta+deltateta;
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    CalcArcoid(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;

    teta:=teta-deltateta;
   end;
   phi:=phi0;
   teta:=teta+deltateta;
 end;
 result:=0;
end;
// On construit suivant le sens qui est donné en fonction de phi1-phi0
// le départ est toujours phi0
// ex : phi1=-pi/4 et phi0=pi/4 on tourne ans le sens négatif
//      phi=7pi/4 (=2pi-pi/4=-pi/4) mais ici on tourne dans le sens positif

function CreateMayeEllipseClip(MayeEllipseClip:TMayeSurface3D;cx,cy,cz,a,b,phi0,phi1:extended):integer;
var i:integer; deltaphi:extended; MayeTriList:TMayeTriFace3DList; Tri:TMayeTriFace3D;
    Seg:TMayeEdge; px,py,pz:extended;
  procedure calcEllipseClip(var px,py,pz:extended);
  begin
   px:=a*cos(phi0)+cx;
   py:=b*sin(phi0)+cy;
   pz:=cz;
  end;

begin
  deltaphi:=(phi1-phi0)/MayeEllipseClip.nLong;
//  if deltaphi<0 then
//   start:=phi1 else start:=phi0;

  for i:=1 to MayeEllipseClip.nLong do begin
    MayeTriList:=MayeEllipseClip.fMayeTriFace3DList;
    Tri:=MayeTriList.Add as TMayeTriFace3D;
    Tri.KeyName:=MayeEllipseClip.KeyName+'_'+inttostr(i);
    Tri.Color:=MayeEllipseClip.color;
    Tri.oType:=MayeEllipseClip.oType;
    Tri.fParent:=MayeEllipseClip.Fparent;
        // First
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    CalcEllipseClip(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;

    phi0:=phi0+deltaphi;
    // Second
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    CalcEllipseClip(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;


  end;
  result:=0;
end;
function CreateMayeLine(MayeLine:TMayeSurface3D;x1,y1,z1,x2,y2,z2:extended):integer;
var dx,dy,dz,x,y,z:extended;
    Tri:TMayeTriFace3D; Edge:TMayeEdge;
    i:integer;
begin



 dx:=(x2-x1)/MayeLine.nLong;
 dy:=(y2-y1)/MayeLine.nLong;
 dz:=(z2-z1)/MayeLine.nLong;

 x:=x1;
 y:=y1;
 z:=z1;
 i:=1;
 while i<=MayeLine.nLong do begin
  Tri:=MayeLine.fMayeTriFace3DList.Add as TMayeTriFace3D;
  Tri.KeyName:=MayeLine.KeyName+'_'+inttostr(i);
  Tri.Color:=MayeLine.color;
  Tri.oType:=MayeLine.oType;
  Tri.fParent:=MayeLine.fParent;

  Edge:=Tri.fMayeEdgeList.Add as TMayeEdge;
  Edge.x:=x;
  Edge.y:=y;
  Edge.z:=z;
  x:=x+dx;
  y:=y+dy;
  z:=z+dz;

  Edge:=Tri.fMayeEdgeList.Add as TMayeEdge;
  Edge.x:=x;
  Edge.y:=y;
  Edge.z:=z;

  i:=i+1;
 end;

 result:=1;
end;
procedure DrawBlockX(MayeWall:TMayeSurface3D;length:extended;var width:extended;height:extended;sKeyname:string;offset:extended=0);
var  i,j,loop:integer;
     px,pz,x2,dy,deltah,dx,dz:extended;
     Tri:TMayeTriFace3D;
     Seg:TMayeEdge;
begin
     px:=-length/2+offset;pz:=0;
     x2:=0;
     loop:=0;
     dy:=0.20;
     dx:=length/MayeWall.nLong;
     dz:=height/MayeWall.nLat;
     while loop<=1 do begin
      for j:=1 to MayeWall.nLat do begin
       for i:=1 to MayeWall.nLong do begin

         Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
         Tri.KeyName:=sKeyname+'_'+inttostr(i)+';'+inttostr(j);
         Tri.Color:=MayeWall.color;
         Tri.oType:=MayeWall.oType;
         Tri.fParent:=MayeWall.fparent;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz+dz;
         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz-dz;
         px:=px+dx;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz+dz;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz-dz;

        end; // end for i
        pz:=pz+dz;
        x2:=px;
        px:=-length/2+offset;
      end; // end for j
    loop:=loop+1;
    width:=width+dy;
    px:=-length/2+offset;
    if loop<>2 then
     pz:=0;
   end;
   px:=-length/2+offset;
   width:=width-2*dy;
   deltah:=1/5;
   i:=1;
   while px+deltah<(x2-dy) do
   begin
    Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
    Tri.KeyName:=sKeyname+'_up'+'_'+inttostr(i);
    Tri.Color:=MayeWall.color;
    Tri.oType:=MayeWall.oType;
    Tri.fParent:=MayeWall.fparent;

    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px+(deltah+0.10);
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px-(deltah+0.10);
    width:=width+dy;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px+deltah;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;
    width:=width-dy;
    i:=i+1;
   end;
   // Dernier bloc de fermeture

   width:=width+dy;

end;
procedure DrawWoolX(MayeWall:TMayeSurface3D;length:extended;var width:extended;height:extended;sKeyname:string;offset:extended=0);
var  i,j,loop:integer;
     px,pz,dy,dx,dz:extended;
     Tri:TMayeTriFace3D;
     Seg:TMayeEdge;
begin
     px:=-length/2+offset;pz:=0;
     loop:=0;
     dy:=0.04;
     dx:=length/MayeWall.nLong;
     dz:=height/MayeWall.nLat;
     while loop<=1 do begin
      for j:=1 to MayeWall.nLat do begin
       for i:=1 to MayeWall.nLong do begin

         Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
         Tri.KeyName:=sKeyname+'_'+inttostr(i)+';'+inttostr(j);
         Tri.Color:=MayeWall.color;
         Tri.oType:=MayeWall.oType;
         Tri.fParent:=MayeWall.fparent;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz+dz;
         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz-dz;
         px:=px+dx;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz+dz;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz-dz;

        end; // end for i
        pz:=pz+dz;
        px:=-length/2 + offset;
      end; // end for j
    loop:=loop+1;
    width:=width+dy;
    px:=-length/2+offset;
    if loop<>2 then
     pz:=0;
   end;
   px:=-length/2+offset;
   width:=width-2*dy;
   for i:=1 to MayeWall.nLong do
   begin
    Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
    Tri.KeyName:=sKeyname+'_up'+'_'+inttostr(i);
    Tri.Color:=13;//MayeWallX.color;
    Tri.oType:=MayeWall.oType;
    Tri.fParent:=MayeWall.fparent;

    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px+dx;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px-dx;
    width:=width+dy;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px+dx;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;
    width:=width-dy;
   end;
   width:=width+dy;
end;
procedure DrawFenceX(MayeWall:TMayeSurface3D;length:extended;var width:extended;height:extended;sKeyname:string;offset:extended=0;dy:extended=0.005);
var  i,j,loop:integer;
     px,pz,dx,dz:extended;
     Tri:TMayeTriFace3D;
     Seg:TMayeEdge;
begin
     px:=-length/2+offset;pz:=0;
     loop:=0;

//     dy:=0.005;
     dx:=length/ MayeWall.nLong;
     dz:=height /MayeWall.nLat;

     while loop<=1 do begin
      for j:=1 to MayeWall.nLat do begin
       for i:=1 to MayeWall.nLong do begin

         Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
         Tri.KeyName:=sKeyname+'_'+inttostr(i)+';'+inttostr(j);
         Tri.Color:=MayeWall.color;
         Tri.oType:=MayeWall.oType;
         Tri.fParent:=MayeWall.fparent;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz+dz;
         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz-dz;
         px:=px+dx;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz+dz;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz-dz;

        end; // end for i
        pz:=pz+dz;
        px:=-length/2+offset;
      end; // end for j
    loop:=loop+1;
    width:=width+dy;
    px:=-length/2+offset;
    if loop<>2 then
     pz:=0;
   end;
   px:=-length/2+offset;
   width:=width-2*dy;
   for i:=1 to MayeWall.nLong do
   begin
    Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
    Tri.KeyName:=sKeyname+'_up'+'_'+inttostr(i);
    Tri.Color:=8;
    Tri.oType:=MayeWall.oType;
    Tri.fParent:=MayeWall.fparent;

    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px+dx;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px-dx;
    width:=width+dy;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px+dx;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;
    width:=width-dy;
   end;
   width:=width+dy;
end;

procedure DrawBrikX(MayeWall:TMayeSurface3D;length:extended;var width:extended;height:extended;sKeyname:string;offset:extended=0);
var  i,j,loop:integer;
     px,pz,dy,dx,dz:extended;
     Tri:TMayeTriFace3D;
     Seg:TMayeEdge;
begin
     px:=-length/2+offset;pz:=0;
     loop:=0;
     dy:=0.10;
     dx:=length/MayeWall.nLong;
     dz:=height/MayeWall.nLat;

     while loop<=1 do begin
      for j:=1 to MayeWall.nLat do begin
       for i:=1 to MayeWall.nLong do begin

         Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
         Tri.KeyName:=sKeyname+'_'+inttostr(i)+';'+inttostr(j);
         Tri.Color:=MayeWall.color;
         Tri.oType:=MayeWall.oType;
         Tri.fParent:=MayeWall.fparent;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz+dz;
         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz-dz;
         px:=px+dx;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz+dz;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=px;
         Seg.y:=width;
         Seg.Z:=pz;

         pz:=pz-dz;

        end; // end for i
        pz:=pz+dz;
        px:=-length/2+offset;
      end; // end for j
    loop:=loop+1;
    width:=width+dy;
    px:=-length/2+offset;
    if loop<>2 then
     pz:=0;
   end;
   px:=-length/2+offset;
   width:=width-2*dy;
   for i:=1 to MayeWall.nLong do
   begin
    Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
    Tri.KeyName:=sKeyname+'_up'+'_'+inttostr(i);
    Tri.Color:=8;
    Tri.oType:=MayeWall.oType;
    Tri.fParent:=MayeWall.fparent;

    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px+dx;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px-dx;
    width:=width+dy;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;

    px:=px+dx;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=px;
    Seg.y:=width;
    Seg.z:=pz;
    width:=width-dy;
   end;
   width:=width+dy;
end;

function CreateWall(MayeWall:TMayeSurface3D;length,height:extended):integer;
var
 width : extended;

begin

 width:=-0.2375;

 DrawBrikX(MayeWall,length,width,height,MayeWall.Keyname+'_bf');
 DrawBlockX(MayeWall,length,width,height,MayeWall.Keyname+'_bl');
 DrawWoolX(MayeWall,length,width,height,MayeWall.Keyname+'_wo');
 width:=width+0.03;
 DrawBrikX(MayeWall,length,width,height,MayeWall.Keyname+'_bi');
 DrawFenceX(MayeWall,length,width,height,MayeWall.Keyname+'_fe');

 result:=0;

end;
function CreateWallFence(MayeWall:TMayeSurface3D;length,height : extended):integer;
 var
  width : extended;
begin
 width:=-0.060;
 DrawFenceX(MayeWall,length,width,height,MayeWall.Keyname+'_fel',0,0.015);
 DrawBrikX(MayeWall,length,width,height,MayeWall.Keyname+'_bf');
 DrawFenceX(MayeWall,length,Width,height,MayeWall.Keyname+'_fer',0,0.005);

 result:=0;
end;
function CreateFence(MayeWall:TMayeSurface3D;length,height:extended):integer;
var
 width : extended;
begin
 width:=-0.0075;
 DrawFenceX(MayeWall,length,Width,height,MayeWall.Keyname,0,0.015);
 result:=0;
end;
// Description : Crée un coin de mur
// Le coin de mur est une mayesurface carrée de dimension 0.475 * 0.475
function CreateWallCorner(MayeWall:TMayeSurface3D; height: extended):integer;
var
    width,length: extended;
    yOrg : extended;
begin
 yOrg:=-0.475/2;
 width :=yOrg;
 length:=0;

 MayeWall.nLong:=2;
 DrawBrikX(MayeWall,0.475,width,height,MayeWall.Keyname+'_bfx');
 DrawBlockX(MayeWall,0.200-0.025,width,height,MayeWall.Keyname+'_blx',0.1375+0.0125);
 length:=-0.475/2;
 DrawBrikY(MayeWall,length,0.475,height,MayeWall.Keyname+'_bfy',0.250+yOrg);
 length:=-0.275/2;
 DrawBlockY(MayeWall,length,(0.200-0.025),height,MayeWall.Keyname+'_bly',0.3750+0.0125+yOrg);

// DrawWoolX(MayeWall,0.131,width,height,Mayewall.Keyname+'_wox',0.172);
 DrawWoolX(MayeWall,0.135,width,height,Mayewall.Keyname+'_wox',0.169);
 width:=0.235;
 DrawFenceX(MayeWall,0.10, width, height, MayeWall.Keyname+'_fex',0.185);

 length:=-0.475/2+0.30;
 DrawWoolY(MayeWall,length,0.175,height,Mayewall.Keyname+'_woy',0.475-0.175/2+yOrg);

 length:=-0.475/2+0.375;
 DrawBrikY(MayeWall,length,0.100,height,MayeWall.Keyname+'_biy',0.475-0.0550+yOrg);

 length:=-0.475/2+0.470;
 DrawFenceY(MayeWall,length,0.05,height,MayeWall.Keyname+'_fey',0.475-0.0250+yOrg);
 result:=0;

end;

procedure DrawBrikY(MayeWall:TMayeSurface3D;var length:extended; width:extended;height:extended;skeyname:string;offset:extended=0);
var  i,j,loop:integer;
     py,pz,dy,dx,dz:extended;
     Tri:TMayeTriFace3D;
     Seg:TMayeEdge;
begin
     py:=-width/2+offset;pz:=0;
     loop:=0;
     dx:=0.10;
     dy:=width/MayeWall.nLong;
     dz:=height/MayeWall.nLat;

     while loop<=1 do begin
      for j:=1 to MayeWall.nLat do begin
       for i:=1 to MayeWall.nLong do begin

         Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
         Tri.KeyName:=sKeyname+'_'+inttostr(i)+';'+inttostr(j);
         Tri.Color:=MayeWall.color;
         Tri.oType:=MayeWall.oType;
         Tri.fParent:=MayeWall.fparent;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz+dz;
         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz-dz;
         py:=py+dy;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz+dz;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz-dz;

        end; // end for i
        pz:=pz+dz;
        py:=-width/2+offset;
      end; // end for j
    loop:=loop+1;
    length:=length+dx;
    py:=-width/2+offset;
    if loop<>2 then
     pz:=0;
   end;
   py:=-width/2+offset;
   length:=length-2*dx;
   for i:=1 to MayeWall.nLong do
   begin
    Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
    Tri.KeyName:=sKeyname+'_up'+'_'+inttostr(i);
    Tri.Color:=8;
    Tri.oType:=MayeWall.oType;
    Tri.fParent:=MayeWall.fparent;

    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py+dy;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py-dy;
    length:=length+dx;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py+dy;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;
    length:=length-dx;
   end;
   length:=length+dx;
end;
procedure DrawBlockY(MayeWall:TMayeSurface3D;var length:extended; width:extended;height:extended;sKeyname:string;offset:extended=0);
var  i,j,loop:integer;
     py,pz,y2,dy,deltah,dx,dz:extended;
     Tri:TMayeTriFace3D;
     Seg:TMayeEdge;
begin
     py:=-width/2+offset;pz:=0;
     y2:=0;
     loop:=0;
     dx:=0.20;
     dy:=width/MayeWall.nLong;
     dz:=height/MayeWall.nLat;
     while loop<=1 do begin
      for j:=1 to MayeWall.nLat do begin
       for i:=1 to MayeWall.nLong do begin

         Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
         Tri.KeyName:=sKeyname+'_'+inttostr(i)+';'+inttostr(j);
         Tri.Color:=MayeWall.color;
         Tri.oType:=MayeWall.oType;
         Tri.fParent:=MayeWall.fparent;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz+dz;
         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz-dz;
         py:=py+dy;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz+dz;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz-dz;

        end; // end for i
        pz:=pz+dz;
        y2:=py;
        py:=-width/2+offset;
      end; // end for j
    loop:=loop+1;
    length:=length+dx;
    py:=-width/2+offset;
    if loop<>2 then
     pz:=0;
   end;
   py:=-width/2+offset;
   length:=length-2*dx;
   deltah:=1/5;
   i:=1;
   while py+deltah<(y2-dx) do
   begin
    Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
    Tri.KeyName:=sKeyname+'_up'+'_'+inttostr(i);
    Tri.Color:=MayeWall.color;
    Tri.oType:=MayeWall.oType;
    Tri.fParent:=MayeWall.fparent;

    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py+(deltah+0.10);
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py-(deltah+0.10);
    length:=length+dx;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py+deltah;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;
    length:=length-dx;
    i:=i+1;
   end;
   // Dernier bloc de fermeture

   length:=length+dx;

end;
procedure DrawWoolY(MayeWall:TMayeSurface3D;var length:extended;width:extended;height:extended;sKeyname:string;offset:extended=0);
var  i,j,loop:integer;
     py,pz,dy,dx,dz:extended;
     Tri:TMayeTriFace3D;
     Seg:TMayeEdge;
begin
     py:=-width/2+offset;pz:=0;
     loop:=0;
     dx:=0.04;
     dy:=width/MayeWall.nLong;
     dz:=height/MayeWall.nLat;
     while loop<=1 do begin
      for j:=1 to MayeWall.nLat do begin
       for i:=1 to MayeWall.nLong do begin

         Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
         Tri.KeyName:=sKeyname+'_'+inttostr(i)+';'+inttostr(j);
         Tri.Color:=MayeWall.color;
         Tri.oType:=MayeWall.oType;
         Tri.fParent:=MayeWall.fparent;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz+dz;
         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz-dz;
         py:=py+dy;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz+dz;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz-dz;

        end; // end for i
        pz:=pz+dz;
        py:=-width/2 + offset;
      end; // end for j
    loop:=loop+1;
    length:=length+dx;
    py:=-width/2+offset;
    if loop<>2 then
     pz:=0;
   end;
   py:=-width/2+offset;
   length:=length-2*dx;
   for i:=1 to MayeWall.nLong do
   begin
    Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
    Tri.KeyName:=sKeyname+'_up'+'_'+inttostr(i);
    Tri.Color:=13;//MayeWallX.color;
    Tri.oType:=MayeWall.oType;
    Tri.fParent:=MayeWall.fparent;

    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py+dy;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py-dy;
    length:=length+dx;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py+dy;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;
    length:=length-dx;
   end;
   length:=length+dx;
end;
procedure DrawFenceY(MayeWall:TMayeSurface3D;var length:extended;width:extended;height:extended;sKeyname:string;offset:extended=0);
var  i,j,loop:integer;
     py,pz,dy,dx,dz:extended;
     Tri:TMayeTriFace3D;
     Seg:TMayeEdge;
begin
     py:=-width/2+offset;pz:=0;
     loop:=0;

     dx:=0.005;
     dy:=width/ MayeWall.nLong;
     dz:=height /MayeWall.nLat;

     while loop<=1 do begin
      for j:=1 to MayeWall.nLat do begin
       for i:=1 to MayeWall.nLong do begin

         Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
         Tri.KeyName:=sKeyname+'_'+inttostr(i)+';'+inttostr(j);
         Tri.Color:=MayeWall.color;
         Tri.oType:=MayeWall.oType;
         Tri.fParent:=MayeWall.fparent;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz+dz;
         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz-dz;
         py:=py+dy;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz+dz;

         Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
         Seg.x:=length;
         Seg.y:=py;
         Seg.Z:=pz;

         pz:=pz-dz;

        end; // end for i
        pz:=pz+dz;
        py:=-width/2+offset;
      end; // end for j
    loop:=loop+1;
    length:=length+dx;
    py:=-width/2+offset;
    if loop<>2 then
     pz:=0;
   end;
   py:=-width/2+offset;
   length:=length-2*dx;
   for i:=1 to MayeWall.nLong do
   begin
    Tri:=MayeWall.fMayeTriFace3DList.Add as TMayeTriFace3D;
    Tri.KeyName:=sKeyname+'_up'+'_'+inttostr(i);
    Tri.Color:=8;
    Tri.oType:=MayeWall.oType;
    Tri.fParent:=MayeWall.fparent;

    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py+dy;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py-dy;
    length:=length+dx;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;

    py:=py+dy;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    Seg.x:=length;
    Seg.y:=py;
    Seg.z:=pz;
    length:=length-dx;
   end;
   length:=length+dx;
end;

procedure CalculEllipse(const a,b,teta,cx,cy,cz:extended; var px,py,pz:extended);
  begin
   px:=a*cos(teta)+cx;
   py:=b*sin(teta)+cy;
   pz:=cz;
  end;

function CreateMayeEllipse(MayeEllipse:TMayeSurface3D;cx,cy,cz,a,b:extended):integer;
var i:integer; teta,deltateta : extended; MayeTriList : TMayeTriFace3DList;
    Tri : TMayeTriFace3D;
    Seg : TMayeEdge;
    px,py,pz: extended;

begin

 teta:=0;
 deltateta:=(2*pi/MayeEllipse.nLong);
 MayeTriList:=MayeEllipse.fMayeTriFace3DList;

 Tri:=MayeTriList.Add as TMayeTriFace3D;
 Tri.KeyName:=MayeEllipse.KeyName+'_0';
 Tri.fParent:=MayeEllipse.fparent;
 Tri.Hide:=MayeEllipse.Hide;
 Tri.Color:=MayeEllipse.Color;
 Tri.oType:=MayeEllipse.oType;

 seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
 CalculEllipse(a,b,teta,cx,cy,cz,px,py,pz);
 seg.x:=px;
 seg.y:=py;
 seg.z:=pz;

 seg:=Tri.fMayeEdgeList.Add as TMayeEdge;

 for i:=1 to MayeEllipse.nLong do
 begin
  teta:=teta+deltateta;
  CalculEllipse(a,b,teta,cx,cy,cz,px,py,pz);
  seg.x:=px;
  seg.y:=py;
  seg.z:=pz;

  if i<MayeEllipse.nLong then begin
   Tri:=MayeTriList.Add as TMayeTriFace3D;
   Tri.KeyName:=MayeEllipse.KeyName+'_'+inttostr(i);
   Tri.FParent:=MayeEllipse.fparent;
   Tri.Hide:=MayeEllipse.Hide;
   Tri.Color:=MayeEllipse.Color;
   Tri.oType:=MayeEllipse.oType;
   seg:=Tri.FmayeEdgeList.add as Tmayeedge;
   seg.x:=px;
   seg.y:=py;
   seg.z:=pz;
   seg:=Tri.fMayeEdgeList.add as TMayeEdge;
  end;
 end;
 result:=1;
end;

function CreateMayeSolidEllipse(MayeEllipse:TMayeSurface3D;cx,cy,cz,a,b:extended):integer;
var i:integer; teta,deltateta:extended; MayeTriList : TMayeTriFace3DList;
    Tri : TMayeTriFace3D;
    Seg : TMayeEdge;
    px,py,pz: extended;
    _px,_py,_pz : extended;
    ca,cb : extended;
    delta_a,delta_b: extended;
begin
 teta:=0;
 deltateta:=(2*pi/MayeEllipse.nLong);

 delta_a:=a/MayeEllipse.nLong;
 delta_b:=b/MayeEllipse.nLong;
 ca:=delta_a;
 cb:=delta_b;

 px:=cx; py:=cy;pz:=cz;
 for i:=0 to MayeEllipse.nLong do begin
  MayeTriList:=MayeEllipse.fMayeTriFace3DList;
  Tri:=MayeTriList.Add as TMayeTriFace3D;
  Tri.KeyName:=MayeEllipse.KeyName+'_0';
  Tri.fParent:=MayeEllipse.fparent;
  Tri.Hide:=MayeEllipse.Hide;
  Tri.Color:=MayeEllipse.Color;
  Tri.oType:=MayeEllipse.oType;

  CalculEllipse(ca,cb,teta,cx,cy,cz,_px,_py,_pz);

  Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
  Seg.x:=px;
  Seg.y:=py;
  Seg.z:=pz;

  Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
  Seg.x:=_px;
  seg.y:=py;
  Seg.z:=pz;

  Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
  Seg.x:=_px;
  Seg.y:=_py;
  Seg.z:=pz;

  Seg:=Tri.fMayeEdgeList.add as TMayeEdge;
  Seg.x:=px;
  Seg.y:=py;
  Seg.z:=pz;

  teta:=teta+deltateta;
 end;
 result:=0;
end;
function CreateLine(Line3D:TLine3D;x1,y1,z1,x2,y2,z2 : extended; color,otype : integer; Const sKeyname:string; Const parent:TScene3D;Const Drawer:TDrawer3D):integer;
begin

   Line3D.x1:=x1;
   Line3D.y1:=y1;
   Line3D.z1:=z1;
   Line3D.x2:=x2;
   Line3D.y2:=y2;
   Line3D.z2:=z2;
   Line3D.color:=color;
   Line3D.oType:=oType;
   Line3D.keyname:=sKeyname;
   Line3D.fParent:=parent;
   Line3D.Drawer3D:=Drawer;
   result:=0;
end;
function CreateMayeEllipseClip(MayeEllipseClip:TMayeSurface3D;cx,cy,cz,a,b,phi0,phi1:extended;nLong,color,otype:integer;const sKeyname:string; Const parent:TScene3D; Const Drawer:TDrawer3D):integer;
begin
 MayeEllipseClip.nLong:=nLong;
 MayeEllipseClip.color:=color;
 MayeEllipseClip.oType:=oType;
 MayeEllipseClip.Keyname:=sKeyname;
 MayeEllipseClip.fparent:=parent;
 MayeEllipseClip.Drawer3D:=Drawer;
 result:=CreateMayeEllipseClip(MayeEllipseClip,cx,cy,cz,a,b,phi0,phi1);


end;
function CreateMayeEllipse(MayeEllipse:TMayeSurface3D;cx,cy,cz,a,b:extended;nLong,color,oType:integer;Const sKeyname:string; Const parent:TScene3D; Const Drawer:TDrawer3D):integer;overload;
begin
 MayeEllipse.nLong:=nLong;
 MayeEllipse.color:=color;
 MayeEllipse.oType:=oType;
 MayeEllipse.Keyname:=sKeyName;
 MayeEllipse.fParent:=Parent;
 MayeEllipse.Drawer3D:=Drawer;
 result:=CreateMayeEllipse(MayeEllipse,cx,cy,cz,a,b);


end;
function CreateMayeArcoid(MayeArcoid:TMayeSurface3D;cx,cy,cz,rx,ry,rz,phi0,phi1,teta0,teta1:extended; nLong,nLat,Color,oType,Transparent:integer; Const sKeyname:string;Const parent:TScene3D; Const Drawer:TDrawer3D):integer;overload;
begin
 MayeArcoid.nLong:=nLong;
 MayeArcoid.nLat:=nLat;
 MayeArcoid.nTransparent:=Transparent;
 MayeArcoid.Color:=color;
 MayeArcoid.oType:=oType;
 MayeArcoid.Keyname:=sKeyname;
 MayeArcoid.fParent:=parent;
 MayeArcoid.Drawer3D:=Drawer;
 result:= CreateMayeArcoid(MayeArcoid,cx,cy,cz,rx,ry,rz,phi0,phi1,teta0,teta1);

end;
// Height =z
// length = x
// width =y
function CreateFrame(Frame3D:TFrame3D;cx,cy,cz,height,length,width : extended; color,otype: integer; const sKeyname:string; const parent:TScene3D; const Drawer:TDrawer3D):integer;
var
    MayeList:TMayeEdgeList; MayeEdge:TMayeEdge;

begin
  MayeList:=Frame3D.fPoints as TMayeEdgeList;
  // 1-2
  MayeEdge:=MayeList.Add as TMayeEdge;
  MayeEdge.x:=cx+width ; MayeEdge.y:=cy-length; MayeEdge.z:=cz-height;

  MayeEdge:=MayeList.Add as TMayeEdge;
  MayeEdge.x:=cx+(width); MayeEdge.y:=cy+(length); MayeEdge.z:=cz-(height);
  // 3-4
  MayeEdge:=MayeList.Add as TMayeEdge;
  MayeEdge.x:=cx-(width); MayeEdge.y:=cy+(length); MayeEdge.z:=cz-(height);
  MayeEdge:=MayeList.Add as TMayeEdge;
  MayeEdge.x:=cx-(width); MayeEdge.y:=cy-(length); MayeEdge.z:=cz-(height);
  // 5-6
  MayeEdge:=MayeList.Add as TMayeEdge;
  MayeEdge.x:=cx+(width ); MayeEdge.y:=cy-(length); MayeEdge.z:=cz+(height);
  MayeEdge:=MayeList.Add as TMayeEdge;
  MayeEdge.x:=cx+(width); MayeEdge.y:=cy+(length); MayeEdge.z:=cz+(height);
  // 7-8
  MayeEdge:=MayeList.Add as TMayeEdge;
  MayeEdge.x:=cx-(width); MayeEdge.y:=cy+(length); MayeEdge.z:=cz+(height);
  MayeEdge:=MayeList.Add as TMayeEdge;
  MayeEdge.x:=cx-(width); MayeEdge.y:=cy-(length); MayeEdge.z:=cz+(height);
  result:=1;
end;
end.

