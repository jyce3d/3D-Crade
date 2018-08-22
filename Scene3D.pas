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

// Module Scene3D
// Author : jyce3d
// 22/05/04     jyce3d    New additions for Mayage
// 13/08/04     jyce3d    Epuration Technique

unit Scene3D;

interface
uses classes,graphics,MatrixWaste,MSXML_TLB,windows,graphlib,Forms,Dialogs,CustomTree,Context;

const
 DRAWTYPE_DEFAULT=0;
 DRAWTYPE_THIN=1;
 DRAWTYPE_SOLID=2;

type
TDrawer3D=class;
TScene3D=class;
TScene3DList=class;
TAxe3D=class;
TRefMayeTriFace3DList=class;
TMayeEdgeList=class;
TObject3D=class;
TPoint3D=class;
TLine3D=class;
TFrame3D=class;
TPoint3DList=class;
TFrame3DList=class;
TMayeSurface3DList=class;
TLine3DList=class;
TMayeSurface3D=class;
TObject3DRef=class;

TScene3DTree=class(TCustomTree)
 private
 // fRefNodeList represents the SceneRef list: TTreeItem the scene item
 fDrawer3D:TDrawer3D;

 function RecurRemoveScene3D(ItemRef:TTreeItemRef):boolean;


 function RecurGetScene3DRef(sKeyname: string;bRecursif:boolean;parent:TTreeItemRef): TTreeItemRef;
 function RecurGetObject3DRef(sKeyName: string; bRecursif: boolean;parent: TTreeItemRef): TObject3DRef;
 function RecurGetPoint3DRef(sKeyName:string; bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;
 function RecurGetLine3DRef(sKeyName:string;bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;
 function RecurGetMayeSurface3DRef(sKeyName:string;bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;
 function RecurGetFrame3DRef(sKeyName:string;bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;

// procedure AssignObject3DRef(Object3D:TObject3D);
 public

 function RemoveObject3DRef(Object3DRef:TObject3DRef):boolean;

 procedure GetStringItemList(slTreeList:TStringList);
 function GetScene3DRef(sKeyname:string;bRecursif:boolean;parent:TTreeItemRef=nil):TTreeItemRef;
 function GetObject3DRef(sKeyName: string; bRecursif: boolean; parent: TTreeItemRef=nil): TObject3DRef;
 function GetPoint3DRef(sKeyName:string; bRecursif:boolean;parent:TTreeItemRef=nil):TObject3DRef;
 function GetLine3DRef(sKeyname:string; bRecursif:boolean;parent:TTreeItemRef=nil):TObject3DRef;
 function GetFrame3DRef(sKeyName:string;bRecursif:boolean;parent:TTreeItemRef=nil):TObject3DRef;
 function GetMayeSurface3DRef(sKeyname: string;bRecursif:boolean;parent:TTreeItemRef=nil): TObject3DRef;

 function AddPoint3D(parent:TTreeItemRef=nil):TPoint3D;
 function AddScene3D(parent:TTreeItemRef=nil):TScene3D;
 function AddLine3D(parent:TTreeItemRef=nil):TLine3D;
 function AddFrame3D(parent:TTreeItemRef=nil):TFrame3D;
 function AddObject3D(ThisObject:TObject3D;parent:TTreeItemRef=nil):TObject3D;
 function AddObject3DRef(ThisObject:TObject3D;parent:TTreeItemRef=nil):TObject3DRef;

 function AddMayeSurface3D(parent:TTreeItemRef=nil):TMayeSurface3D;

 function RemoveObject3D(skeyname:string):boolean;
 procedure MoveObject3D(sFromScene:string;sToScene:String;sKeyName:string);overload;
 procedure MoveObject3D(FromScene:TTreeItemRef;ToScene:TTreeItemRef;Object3D:TObject3D);overload;
 procedure RecurGetXmlNode(DomDoc:DomDocument; XmlObjectList:IXmlDomNode;Scene3DRef:TTreeItemRef);
 procedure RecurSetXMLNode(DomDoc: DomDocument;XmlObjectList: IXmlDomNode;Scene3DRef,ParentScene3DRef:TTreeItemRef);

 procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);
 procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode; ParentSceneRef : TTreeItemRef=nil);virtual;


 procedure MoveScene3D(FromScene3DRef:TTreeItemRef;ToScene3DRef:TTreeItemRef;Scene3D:TScene3D);overload;
 constructor create(Drawer3D:TDrawer3D;Collection:TCollection);reintroduce;

end;
TDrawer3D=class
//  private

//    function GetScene3D(sKeyName: string): TScene3D;
 protected
  fCanvas:TCanvas;
  fForm:TForm;
  fMainScene3D:TScene3D;
  fMainScene3DRef:TTreeItemRef;
  frhoeye, fcolatiteye, fazimutheye :extended;
  fscale,fzeye, fxTranslate, fyTranslate, fzTranslate,fCursorInc : extended;
  fSHowAxes:extended;
  fPolygonFrames:extended;
  fAxeX,fAxeY, fAxeZ : TAxe3D;
  fClientWidth,fClientHeight: integer;
  fDrawer3D:TDrawer3D;                  //
  fPoint3DList:TPoint3DList;           // Physical list of objects, these list contains the actual objects, not references
  fLine3DList:TLine3DList;
  fFrame3DList:TFrame3DList;
  fMayeSurface3DList:TMayeSurface3DList;
  fScene3DList:TScene3DList;
  fCurrentScene3D:TScene3D;       // Manipulé par les scripts
  fCurrentScene3DRef:TTreeItemRef; // Manipulé par les scripts

//  fClientWidth, fClientHeight : integer;
  procedure Projection2D(x,y,z:extended;var xp,yp:integer);
  procedure GetVectorEye(x,y,z:extended;var xm,ym,zm:extended);
  procedure PolarToCart(_rho,_teta,_phi:extended;var _x,_y,_z:extended);

//  function GetScene3D: TScene3D; overload;
 public
  fTree3D : TScene3DTree;
  fRefMayeTriFace3DList : TRefMayeTriFace3DList;
  procedure DrawObjects;
  function getLookupColor(c:integer):TColor;
  function GetObject3D(sKeyName: string): TObject3D;
  function GetScene3D(sKeyName:string):TScene3D;

  function DeleteObject3D(sKeyName:string):boolean;
  //  function getScene3D:TScene3D;
  procedure SetCurrentScene3D(Scene3D:TScene3D);
  Procedure ShowScene3D(Form:TForm;       // The Canvas of the form
                        rhoeye,               // Distance of the eye from the center of the scene
                        colatiteye,           // Longitudinal position of the eye [0,PI]
                        azimutheye,           // Latitude position of the eye [0,2PI]
                        zeye,                 // Position du plan de projection par rapport à l'oeil
                        scale,                // Scale
                        showaxes,               // Display the axes of the
                        polygonframes,
                        xtranslate,
                        ytranslate,
                        ztranslate,            // offset between the original center point and the user point of view
                        cursorinc              // valeur d'incrémentation lors de la pression d'une touche de déplacement
                        :extended;    // Display a frame arround the polygons
                        ClientWidth,          // Client Window Canvas Width
                        ClientHeight:integer);// Client Window Canvas Height
  function LoadFromXMLFile(const sFilename:string;Const Context:TCustomContext):integer;
  function ImportFromXMLFile (const sFileName:string) : integer;
  function SaveToXmlFile(const sFileName:string):integer;
  function GetTypeObject3D(sType:string):integer;
  function RemoveAll:boolean;
//  function GetScene3D(sKeyName:string):TScene3D;overload;
//  function GetObject3D(sKeyName:string):TObject3D;
  constructor create;
  destructor destroy;override;
  property Scene3DRef:TTreeItemRef read fcurrentscene3DRef;//fMainScene3DRef;
  property Scene3D:TScene3D read fCurrentScene3d;//fMainScene3D;
  property CurrentScene3D:TScene3D read fCurrentScene3D;            // Manipulé par les scripts
  property CurrentScene3DRef:TTreeItemRef read fCurrentScene3DRef; // Manipulé par les scripts
  property Point3DList  :TPoint3DList read fPoint3DList;
  property Line3DList  :TLine3DList read fLine3DList;
  property Frame3DList  :TFrame3DList read fFrame3DList;
  property MayeSurface3DList  :TMayeSurface3DList read fMayeSurface3DList;
  property Scene3DList : TScene3DList read fScene3DList;
  property Scene3DTree : TScene3DTree read fTree3D;
  property CursorInc : Extended read fCursorInc;

end;


TObject3D=Class(TCollectionItem)
 protected
   fDrawer3D:TDrawer3D;

 public
  color:integer;
  oType:integer;
  foColor:TColor;
  foPenStyle:TPenStyle;
  KeyName:string;
  Hide : boolean;
  fparent : TScene3D;
  procedure Rotate(const dteta,dphi:extended);virtual;
  procedure RotateX(const dteta:extended);virtual;
  procedure RotateY(const dteta:extended);virtual;
  procedure RotateZ(const dphi:extended);virtual;
  procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);virtual;
  procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);virtual;
  procedure Clone(ThisObject:TObject3D);virtual;
  procedure Translate(cx,cy,cz:extended);virtual;
  Procedure DrawObject;virtual;
  // Contains the method to draw
  Property Drawer3D:TDrawer3D read fDrawer3D write fDrawer3D;
  procedure Clear;virtual;

end;

TPoint3D=class(TObject3D)
 public
  x,y,z : extended;
 procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
 procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
 procedure Rotate(const dteta,dphi:extended);override;
 procedure RotateX(const dteta:extended);override;
 procedure RotateY(const dteta:extended);override;
 procedure RotateZ(const dphi:extended);override;
 procedure Clone(ThisObject:TObject3D);override;
 procedure Translate(cx,cy,cz:extended);override;

 constructor create(Collection:TCollection);override;
 Procedure DrawObject;override;

end;

// Description
//  Draw an arc, based on one ellipse in 3D coordonates
// Parameters
// x,y,z : first point of ellipse
// width,length, height : increment
// clipx,clipy,clipz : first point of clipping of the ellipse
// clipwidth,cliplength,clipheight : clip increment
// Return
//
// Remarks
// On définit un paralellépipède rectangle contenant l'ellipse
// ainsi qu'un paralellépipède rectangle de clipping pour définir l'arc


{TEllipseClip3D=class(TObject3D)
 public
  x,y,z:extended;
  width,length,height:extended;
  clipx,clipy,clipz:extended;
  clipwidth,cliplength,clipheight:extended;

  procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
  procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;

  constructor create(Collection:TCollection);override;
  Procedure DrawObject;override;

end; }

{TSphere3D=class(TObject3D)
 public
  x,y,z : extended; // Centre de la sphère
  radius : extended; // rayon de la sphérule
  LatitudeCircles, LongitudeCircles : integer;

  Constructor create(Collection:TCollection);override;
  procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
  procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
  procedure DrawObject;override;
end; }

TFrame3D=class(TObject3D)
 public
 { x,y,z : extended;// Centre
  length : extended;// largeur
  width : extended;// largeur
  height : extended;// hauteur}
  fPoints:TMayeEdgeList;
  procedure Rotate(const dteta,dphi:extended);override;
  procedure RotateX(const dteta:extended);override;
  procedure RotateY(const dteta:extended);override;
  procedure RotateZ(const dphi:extended);override;

  procedure Clone(ThisObject:TObject3D);override;
  procedure Translate(cx,cy,cz:extended);override;


  Constructor create(Collection:TCollection);override;
  destructor destroy;override;
  procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
  procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
  procedure DrawObject;override;
  procedure clear;override;
end;

TLine3D=class(TObject3D)
 public
  x1,y1,z1 : extended;
  x2,y2,z2 : extended;
  procedure RotateX(const dteta:extended);override;
 procedure RotateY(const dteta:extended);override;
 procedure RotateZ(const dphi:extended);override;
 procedure Clone(ThisObject:TObject3D);override;
 procedure Translate(cx,cy,cz:extended);override;

 procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
 procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;

 procedure Rotate(const dteta,dphi:extended);override;
 constructor create(Collection:TCollection);override;
 procedure DrawObject;override;
end;
//
// New additions from jyce (22/05/04)
//
TMayeTriface3D=class;
TMayeTriFace3DList=class;


TRefMayeTriFace3DList=class
 private
  function GetRef(i:integer):TMayeTriFace3D;
  procedure SetRef(i:integer;MayeTriFaceRef:TMayeTriFace3D);
 public
 Count : integer;
 fRefArray : array of TMayeTriface3D;
 procedure AddRef(ref:TMayeTriFace3D);
 procedure Delete(ref:TMayeTriFace3D);
 procedure clear;
 procedure CalcZMoy(Drawer:TDrawer3D);
 procedure SortByZ;
 property Items[i:integer]:TMayeTriFace3D read getRef write SetRef;
 constructor create;
 destructor destroy;override;

end;
TObject3DRef=class(TCollectionItem)
 fObject3DRef:TObject3D;
 constructor create(Collection:TCollection);override;
 procedure Clone(ThisObject:TObject3DRef);
 procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode;sNodeName:string);
 procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode;Drawer3D:TDrawer3D;Scene3D:TScene3D);

 destructor destroy;override;
 property Value:TObject3D read fObject3DRef write fObject3DRef;
end;
TObject3DRefList=class(TCollection)
 public
 constructor create;reintroduce;
 function add(Object3D:TObject3D):TObject3DRef;reintroduce;
end;

TMayeEdge=class(TCollectionItem)
 public
 x,y,z : extended;
 constructor create(Collection:TCollection);override;
 procedure clone(ThisObject:TMayeEdge);
end;

TMayeEdgeList=class(TCollection)
  private
    function getEdge(ind: integer): TMayeEdge;
    procedure setEdge(ind: integer; const Value: TMayeEdge);
 public
 fOwner:TMayeTriFace3D;
 constructor create(owner:TMayeTriFace3D);reintroduce;
 property Edge[ind:integer]:TMayeEdge read getEdge write setEdge;
end;

TMayeTriFace3D=class(TObject3D)
 protected
 public
 fMayeEdgeList:TMayeEdgeList;
 nTransparent:integer;
 Zmoy:Extended;
 constructor create(Collection:TCollection);override;
 destructor destroy;override;
 procedure Rotate(const dteta, dphi: extended);override;
 procedure RotateX(const dteta:extended);override;
 procedure RotateY(const dteta:extended);override;
 procedure RotateZ(const dphi:extended);override;
 procedure Clone(ThisObject:TObject3D);override;
 procedure Translate(cx,cy,cz:extended);override;

 procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
 procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
 procedure DrawObject;override;
 function getZMin(Drawer:TDrawer3D):extended;


end;

// Dragostea din tei, Haiducii
TMayeSurface3D=class(TObject3D)
 public
  nLong, nLat : integer;
  nTransparent : integer;
  fMayeTriFace3DList:TMayeTriFace3DList;
  constructor create(Collection:TCollection);override;
  destructor destroy;override;
  procedure Rotate(const dteta, dphi: extended);override;
 procedure RotateX(const dteta:extended);override;
 procedure RotateY(const dteta:extended);override;
 procedure RotateZ(const dphi:extended);override;
 procedure Clone(ThisObject:TObject3D);override;
 procedure Translate(cx,cy,cz:extended);override;
 procedure Clear;override;
 procedure SetHide;
 procedure SetUnHide;
 procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
 procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;

 procedure DrawObject;override;
end;


TAxe3D=Class(TLine3D)
 public
 AxeName:String;
 constructor create(Collection:TCollection); override;
 procedure DrawObject;override;
end;

// TODO:Add your extra Object3D classes here
// before the TScene3D class

// TXXXX3D=class(TOjbect3D)
// end;


TObject3DList=class(TCollection)
 public
 fDrawer3D : TDrawer3D;
 function GetByName(const name:string):TObject3D;
 function add:TCollectionItem;reintroduce;
 procedure DeleteByRef(object3D:Tobject3D);virtual;
 constructor create(Drawer3D:TDrawer3D;ItemClass: TCollectionItemClass);reintroduce;
 function AddNewObject3D:TObject3D;virtual;
end;

TPoint3DList=class(TObject3DList)
  constructor create(Drawer3D:TDrawer3D); reintroduce;
  function AddNewObject3D:TObject3D;override;
end;
{TEllipse3DList=class(TObject3DList)
 constructor Create;reintroduce;
end;
TEllipseClip3DList=class(TObject3DList)
 constructor Create;reintroduce;
end;
TRectangle3DList=class(TObject3DList)
 constructor Create;reintroduce;
end;}
TLine3DList=class(TObject3DList)
  constructor create(Drawer3D:TDrawer3D); reintroduce;
    function AddNewObject3D:TObject3D;override;

end;
TAxe3DList=class(TObject3DList)
 constructor create(Drawer3D:TDrawer3D);reintroduce;
end;
// New additions Jyce 22/05/04
TMayeSurface3DList=class(TObject3DList)
  private
    function getMayeSurface3D(ind: integer): TMayeSurface3D;
    procedure SetMayeSurface3D(ind: integer; const Value: TMayeSurface3D);
 public
  constructor create(Drawer3D:TDrawer3D);reintroduce;
  function AddNewObject3D:TObject3D;override;
  procedure DeleteByRef(object3D:Tobject3D);override;
 property MayeSurface3D[ind:integer]:TMayeSurface3D read getMayeSurface3D write SetMayeSurface3D;

end;

TMayeTriFace3DList=class(TObject3DList)
  private
    function getMayeTriFace3D(ind: integer): TMayeTriFace3D;
    procedure SetMayeTriFace3D(ind: integer; const Value: TMayeTriFace3D);
 public
 fOwner:TMayeSurface3D;
 function Add:TCollectionItem;reintroduce;
 function AddNewObject3D:TObject3D;override;

 constructor create(owner:TMayeSurface3D;Drawer3D:TDrawer3D);reintroduce;
 property MayeTriFace3D[ind:integer]:TMayeTriFace3D read getMayeTriFace3D write SetMayeTriFace3D;
end;


// TODO:Add your extra Object3D classes here
// before the TScene3D class

// TXXXX3DList=class(TOjbect3DList)
//    constructor create;reintroduce;
// end;
TFrame3DList=class(TObject3DList)
 constructor create(Drawer3D:TDrawer3D); reintroduce;
  function AddNewObject3D:TObject3D;override;

end;
TScene3DList=class(TObject3DList)

 constructor create(Drawer3D:TDrawer3D); reintroduce;
end;

TScene3D=class(TObject3D)
  public
   // Block management

   fPoint3DRefList:TObject3DRefList;
   fLine3DRefList:TObject3DRefList;
   fFrame3DRefList:TObject3DRefList;
   fMayeSurface3DRefList:TObject3DRefList;
   //TODO:Add your new shape collection
   // Add your new shape collection here
   // and don't forget the create the appropriate classes
   procedure RotateX(const dteta:extended);override;
   procedure RotateY(const dteta:extended);override;
   procedure RotateZ(const dphi:extended);override;
   procedure GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
   procedure SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);override;
   procedure Translate(cx,cy,cz:extended);override;
   procedure Copy(ThisObject:TScene3D);

   procedure SetHide;
   procedure SetUnHide;
   procedure Clone(ThisObject:TObject3D); override;
   function DeleteRef(Object3D:TObject3D):boolean;
   function DeleteAllChildObjects : boolean;
   constructor create(Collection:TCollection);override;
   procedure Clear;override;
   procedure ChangeObjectParent(Parent:TScene3D);
   destructor destroy;override;
   // Return All items contained in the scene on text form
end;


implementation
uses SysUtils,sortlib,math;


{ TPoint3D }

procedure TPoint3D.Clone(ThisObject: TObject3D);
begin
 x:=(ThisObject as TPoint3D).x;
 y:=(ThisObject as TPoint3D).y;
 z:=(ThisObject as TPoint3D).z;
end;

constructor TPoint3D.create(Collection: TCollection);
begin
  inherited;
  x:=0; y:=0; z:=0;
end;

procedure TPoint3D.DrawObject;
var xp,yp:integer;
begin
  inherited;
  if not Hide then begin
   Drawer3D.Projection2D(x,y,z,xp,yp);
//   Drawer3D.fCanvas.MoveTo(xp,yp);
//   Drawer3D.fCanvas.LineTo(xp+1,yp+1);
   Drawer3D.fCanvas.Pixels[xp,yp]:=Color;
  end;
  Drawer3D.fCanvas.Pen.Color:=foColor;
  Drawer3D.fCanvas.Pen.Style:=foPenStyle;

end;

procedure TPoint3D.GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);
var XmlObject,XmlAttrib:IXmlDomNode;
begin
   XmlObject:=DomDoc.createElement('Line3D');
   XmlObjectList.AppendChild(XmlObject);
   XmlObject.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

  inherited GetXmlNode(DomDOc,XmlObject);

  XmlAttrib:=DomDoc.CreateAttribute('x');
  XmlAttrib.Text:=floattostr(x);
  XmlObject.attributes.setNamedItem(XmlAttrib);

  XmlAttrib:=DomDoc.CreateAttribute('y');
  XmlAttrib.Text:=floattostr(y);
  XmlObject.attributes.setNamedItem(XmlAttrib);

  XmlAttrib:=DomDoc.CreateAttribute('z');
  XmlAttrib.Text:=floattostr(z);
  XmlObject.attributes.setNamedItem(XmlAttrib);

end;

procedure TPoint3D.Rotate(const dteta, dphi: extended);
var rho,phi,teta:extended;
begin
 topolar(x,y,z,rho,teta,phi);
 teta:=teta+dteta;
 phi:=phi+dphi;
 tocartesian(rho,teta,phi,x,y,z);
end;

procedure TPoint3D.RotateX(const dteta: extended);
begin
  inherited;
  Rotate3DX(dteta,x,y,z);
end;

procedure TPoint3D.RotateY(const dteta: extended);
begin
  inherited;
 Rotate3DY(dteta,x,y,z);
end;

procedure TPoint3D.RotateZ(const dphi: extended);
begin
  inherited;
 Rotate3DZ(dphi,x,y,z);
end;

procedure TPoint3D.SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);
var XmlAttrib:IXmlDomNode;

begin
 inherited SetXmlNode(DomDoc,XmlObjectList);
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('x');
 if XmlAttrib<>nil then
 x:=strtofloat(XmlAttrib.text);
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('y');
 if XmlAttrib<>nil then
 y:=strtofloat(XmlAttrib.text);
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('z');
 if XmlAttrib<>nil then
 z:=strtofloat(XmlAttrib.text);



end;

procedure TPoint3D.Translate(cx, cy, cz: extended);
begin
 x:=x+cx;
 y:=y+cy;
 z:=z+cz;
end;

{ TLine3D }

procedure TLine3D.Clone(ThisObject: TObject3D);
begin
  inherited;
  x1:=(ThisObject as TLine3D).x1;
  y1:=(ThisObject as TLine3D).y1;
  z1:=(ThisObject as TLine3D).z1;

  x2:=(ThisObject as TLine3D).x2;
  y2:=(ThisObject as TLine3D).y2;
  z2:=(ThisObject as TLine3D).z2;

end;

constructor TLine3D.create(Collection: TCollection);
begin
  inherited;
  x1:=0; y1:=0; z1:=0;
  x2:=0; y2:=0; z2:=0;

end;

procedure TLine3D.DrawObject;
var xp1,yp1,xp2,yp2:integer;
begin

  inherited;
  if not Hide then begin
   try
    with Drawer3D do begin
     Projection2D(x1,y1,z1,xp1,yp1);
     Projection2D(x2,y2,z2,xp2,yp2);

     fCanvas.MoveTo(xp1,yp1);
     fCanvas.LineTo(xp2,yp2);
    end;
   except
   end;
  end;
  Drawer3D.fCanvas.Pen.Color:=foColor;
  Drawer3D.fCanvas.Pen.Style:=foPenStyle;
end;

procedure TLine3D.GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);
var XmlObject,XmlAttrib:IXmlDomNode;
begin
   XmlObject:=DomDoc.createElement('Line3D');
   XmlObjectList.AppendChild(XmlObject);
   XmlObject.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

   inherited GetXmlNode(DomDoc,XmlObject);

   XmlAttrib:=DomDoc.CreateAttribute('x1');
   XmlAttrib.Text:=floattostr(x1);
   XmlObject.attributes.setNamedItem(XmlAttrib);

   XmlAttrib:=DomDoc.CreateAttribute('y1');
   XmlAttrib.Text:=floattostr(y1);
   XmlObject.attributes.setNamedItem(XmlAttrib);

   XmlAttrib:=DomDoc.CreateAttribute('z1');
   XmlAttrib.Text:=floattostr(z1);
   XmlObject.attributes.setNamedItem(XmlAttrib);

   XmlAttrib:=DomDoc.CreateAttribute('x2');
   XmlAttrib.Text:=floattostr(x2);
   XmlObject.attributes.setNamedItem(XmlAttrib);

   XmlAttrib:=DomDoc.CreateAttribute('y2');
   XmlAttrib.Text:=floattostr(y2);
   XmlObject.attributes.setNamedItem(XmlAttrib);

   XmlAttrib:=DomDoc.CreateAttribute('z2');
   XmlAttrib.Text:=floattostr(z2);
   XmlObject.attributes.setNamedItem(XmlAttrib);

end;

procedure TLine3D.Rotate(const dteta,dphi: extended);
var rho,teta,phi:extended;
begin
 topolar(x1,y1,z1,rho,teta,phi);
 teta:=teta+dteta;
 phi:=phi+dphi;
 tocartesian(rho,teta,phi,x1,y1,z1);

 topolar(x2,y2,z2,rho,teta,phi);
 teta:=teta+dteta;
 phi:=phi+dphi;
 tocartesian(rho,teta,phi,x2,y2,z2);

end;

procedure TLine3D.RotateX(const dteta: extended);
begin
  inherited;
  Rotate3DX(dteta,x1,y1,z1);
  Rotate3DX(dteta,x2,y2,z2);
end;

procedure TLine3D.RotateY(const dteta: extended);
begin
  inherited;
  Rotate3DY(dteta,x1,y1,z1);
  Rotate3DY(dteta,x2,y2,z2);

end;

procedure TLine3D.RotateZ(const dphi: extended);
begin
  inherited;
  Rotate3DZ(dphi,x1,y1,z1);
  Rotate3DZ(dphi,x2,y2,z2);

end;

procedure TLine3D.SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);
var XmlAttrib:IXmlDomNode;

begin
 inherited SetXmlNode(DomDoc,XmlObjectList);
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('x1');
 if XmlAttrib<>nil then
 x1:=strtofloat(XmlAttrib.text);
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('y1');
 if XmlAttrib<>nil then
 y1:=strtofloat(XmlAttrib.text);
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('z1');
 if XmlAttrib<>nil then
 z1:=strtofloat(XmlAttrib.text);

 XMLAttrib := XmlObjectList.attributes.getNamedItem ('x2');
 if XmlAttrib<>nil then
 x2:=strtofloat(XmlAttrib.text);
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('y2');
 if XmlAttrib<>nil then
 y2:=strtofloat(XmlAttrib.text);
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('z2');
 if XmlAttrib<>nil then
 z2:=strtofloat(XmlAttrib.text);
end;
procedure TLine3D.Translate(cx, cy, cz: extended);
begin
  inherited;

  x1:=x1+cx;
  y1:=y1+cy;
  z1:=z1+cz;

  x2:=x2+cx;
  y2:=y2+cy;
  z2:=z2+cz;

end;

{ TPoint3DList }

function TPoint3DList.AddNewObject3D: TObject3D;
begin
 result:=add as TObject3D;
end;

constructor TPoint3DList.create(Drawer3D:TDrawer3D);
begin
 inherited create(Drawer3D,TPoint3D);
end;

{ TLine3DList }

function TLine3DList.AddNewObject3D: TObject3D;
begin
 result:=Add as TObject3D;
end;

constructor TLine3DList.create(Drawer3D:TDrawer3D);
begin
 inherited Create(Drawer3D,TLine3D);
end;

{ TScene3DList }

constructor TScene3DList.create(Drawer3D:TDrawer3D);
begin
 inherited Create(Drawer3D,TScene3D);
end;


function TObject3DList.add: TCollectionItem;
var ob:TObject3D;
begin
 ob:=inherited Add as TObject3D;
 ob.fDrawer3D:=fDrawer3D;
 result:=ob as TCollectionItem;
end;

function TObject3DList.AddNewObject3D: TObject3D;
begin
  result:=nil;
end;

constructor TObject3DList.create(Drawer3D: TDrawer3D;
  ItemClass: TCollectionItemClass);
begin
inherited Create(ItemClass);
fDrawer3D:=Drawer3D;
end;

procedure TObject3DList.DeleteByRef(object3D: Tobject3D);
var i,ind:integer;
begin
 ind:=-1;
 for i:=0 to count -1 do
  if object3D.keyname=(Items[i] as TObject3D).KeyName then
  begin
   ind:=i;
   break;
  end;
 if ind<>-1 then
  Delete(ind);
end;

function TObject3DList.GetByName(const name: string): TObject3D;
var i:integer; obj:TObject3D;
begin
 result:=nil;
 for i:=0 to count -1  do
 begin
  obj:=Items[i] as TObject3D;
  if obj.Keyname=name then
  begin
   result:=obj;
   break;
  end;
 end;

end;

{ TScene3D }

function TScene3DTree.AddObject3D(ThisObject:TObject3D;parent:TTreeItemRef=nil):TObject3D;
var Point3D:TPoint3D;Line3D:TLine3D;Frame3D:TFrame3D;MayeSurface3D:TMayeSurface3D;
    Object3DRef:TObject3DRef;
begin
 Object3DRef:=nil;
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;

 if (ThisObject is TPoint3D) then
 begin
  Point3D:=fDrawer3D.Point3DList.Add as TPoint3D;
  if ThisObject<>nil then
   Point3D.CLone(ThisObject);
  Object3DRef:=(Parent.Value as TScene3D).fPoint3DRefList.Add(Point3D);


 end else
  if (ThisObject is TLine3D) then
  begin
   Line3D:=fDrawer3D.fLine3DList.Add as TLine3D;
   if ThisObject<>nil then
    Line3D.Clone(ThisObject);
   Object3DRef:=(Parent.value as TScene3D).fLine3DRefList.Add(Line3D);
  end else
   if (ThisObject is TFrame3D) then
   begin
    Frame3D:=fDrawer3D.fFrame3DList.Add as TFrame3D;
    if ThisObject<>nil then
     Frame3D.Clone(ThisObject);
    Object3DRef:=(Parent.value as TScene3D).fFrame3DRefList.add(Frame3D);
   end else
   if (ThisObject is TMayeSurface3D) then
   begin
    MayeSurface3D:=fDrawer3D.fMayeSurface3DList.Add as TMayeSurface3D;
    if ThisObject<>nil then
     MayeSurface3D.Clone(ThisObject);
    Object3DRef:=(Parent.value as TScene3D).fMayeSurface3DRefList.add(MayeSurface3D);
   end;
   if object3DRef<>nil then
    result:=Object3DRef.Value as TObject3D else
     result:=nil;
end;

procedure TScene3D.Clear;
begin
 inherited;
 fPoint3DRefList.Clear;
 fLine3DRefList.Clear;
 fFrame3DRefList.Clear;
 FMayeSurface3DRefList.Clear;
end;

procedure TScene3D.Clone(ThisObject: TObject3D);
var i:integer;
begin
//  fparent:=ThisObject.fparent;
  //fDrawer3D:=ThisObject.fDrawer3D;
  if not (ThisObject is TScene3D) then
   raise Exception.Create('TScene3D:Clone : unable to clone a non TScene3D object');
  fPoint3DRefList.Clear;
  for i:=0 to (ThisObject as TScene3D).fPoint3DRefList.count -1 do
   fPoint3DRefList.Add(((ThisObject as TScene3D).fPoint3DRefList.Items[i] as TObject3DRef).Value);
  fLine3DRefList.Clear;
  for i:=0 to (ThisObject as TScene3D).fLine3DRefList.count -1 do
   fLine3DRefList.Add(((ThisObject as TScene3D).fLine3DRefList.Items[i] as TObject3DRef).Value);
  fFrame3DRefList.Clear;
  for i:=0 to (ThisObject as TScene3D).fFrame3DRefList.count -1 do
   fFrame3DRefList.Add(((ThisObject as TScene3D).fFrame3DRefList.Items[i] as TObject3DRef).Value);
  fMayeSurface3DRefList.Clear;
  for i:=0 to (ThisObject as TScene3D).fMayeSurface3DRefList.count -1 do
   fMayeSurface3DRefList.Add(((ThisObject as TScene3D).fMayeSurface3DRefList.Items[i] as TObject3DRef).Value);

end;

constructor TScene3D.create(Collection: TCollection);
begin
  inherited;
//  Drawer3D:=(Collection as TObject3DList).fDrawer3D;
   // Management of basic shape
  fPoint3DRefList:=TObject3DRefList.Create;
  fLine3DRefList:=TObject3DRefList.Create;
  fFrame3DRefList:=TObject3DRefList.Create;
  fMayeSurface3DRefList:=TObject3DRefList.Create;
  // TODO:Add your new shape collection here

end;

destructor TScene3D.destroy;
begin
  fPoint3DRefList.Free;
  fLine3DRefList.free;
  fFrame3DRefList.free;
  fMayeSurface3DRefList.free;
  // TODO:Add your new object3D candidate to destruction here
  inherited;

end;

 //TODO:Add new shapes list here}

{ TRefObject3DList }

function TObject3DRefList.add(Object3D: TObject3D): TObject3DRef;
begin
 result:= inherited add as TObject3DRef;
 result.fObject3DRef:=Object3D;
end;

constructor TObject3DRefList.create;
begin
 inherited create(TObject3DRef);
end;


{ TrefObject3D }

procedure TObject3DRef.Clone(ThisObject: TObject3DRef);
begin
 fObject3DRef:=ThisObject.fObject3DRef;
end;

constructor TObject3DRef.create(Collection: TCollection);
begin
  inherited;
  fObject3DRef:=nil;
end;



(*function TScene3D.GetByName(const name: string): TObject3D;
var i:integer;
begin
// result:=nil;
 for i:=0 to fChildList.count -1 do begin
  result:=(fChildList.Items[i] as TScene3D).GetByName(name);
  if result<>nil then
   exit;
 end;
 result:=fPoint3DList.getByName(name);
 if result<>nil then exit;
 result:=fLine3DList.getByName(name);
 if result<>nil then
  exit;
 result:=fFrame3DList.getbyname(name);
 if result<>nil then exit;
 result:=fMayeSurface3DList.getbyname(name);
 if result<>nil then exit;
end;*)

(*procedure TScene3D.GetStringItemList(sl: TStringlist);
var i:integer; Point3D:TPoint3D;Line3D:TLine3D;MayeSurface3D:TMayeSurface3D;
    tmpoutput:TStringlist;   str:string;
   Frame3D:TFrame3D;
begin
 tmpoutput:=TStringList.create;
 for i:=0 to fPoint3DList.Count -1 do
 begin
  Point3D:=fPoint3DList.Items[i] as TPoint3D;
  with Point3D do begin
    str:=KeyName+#9+'Point'+#9+'('+floattostr(x)+','+floattostr(y)+','+floattostr(z)+')';
    tmpoutput.Add(str);
  end;
 end;
 tmpoutput.Sort;
 for i:=0 to tmpoutput.count -1 do
  sl.add(tmpoutput.Strings[i]);
 // lines
 tmpOutput.Clear;
 for i:=0 to fLine3DList.count -1 do
 begin
  Line3D:=fLine3DList.Items[i] as TLine3D;
  with Line3D do
  begin
   tmpoutput.Add(KeyName+#9+'Line'+#9+'('+floattostr(x1)+','+floattostr(y1)+','+floattostr(z1)+') to ('
    + floattostr(x2)+ ','+floattostr(y2)+','+floattostr(z2)+')');
  end;
 end;
 tmpOutput.Sort;
 for i:=0 to tmpoutput.count -1 do
  sl.add(tmpoutput.Strings[i]);
// Maye Surface
 tmpoutput.Clear;
 for i:=0 to fMayeSurface3DList.count -1 do
 begin
  MayeSurface3D:=fMayeSurface3DList.Items[i] as TMayeSurface3D;
  with MayeSurface3D do
  begin
   tmpoutput.Add(KeyName+#9+'Maye Surface'+#9+'(nLong pts='+inttostr(nLong)+';nLat pts='+inttostr(nLat)+')'+#9+'Transparent='+inttostr(nTransparent));
  end;
 end;
 tmpOutput.Sort;
 for i:=0 to tmpoutput.count -1 do
  sl.add(tmpoutput.Strings[i]);

 tmpoutput.Clear;
 // Frame
 for i:=0 to fFrame3DList.count -1 do
 begin
  Frame3D:=fFrame3DList.Items[i] as TFrame3D;
  with Frame3D do
  begin
   // Get
   tmpoutput.Add(KeyName+#9+'Frame');
  end;
 end;
 tmpOutput.Sort;
 for i:=0 to tmpoutput.count -1 do
  sl.add(tmpoutput.Strings[i]);

 //TODO:Add new items to display

 tmpOutput.Free;
end;

procedure TScene3D.RemoveAll;
var i:integer;
begin
 fPoint3DList.Clear;
 fLine3DList.Clear;
 fFrame3DList.Clear;
 fMayeSurface3DList.Clear;
 fAxe3DList.Clear;

 for i:=0 to fChildList.Count-1 do
  (fChildList.Items[i] as TScene3D).RemoveAll;
 fChildList.Clear;
end;

procedure TScene3D.RemovebyName(key: string);
var Point3D:TPoint3D;Line3D:TLine3D;Frame3D:TFrame3D;MayeSurface3D:TMayeSurface3D;
begin
 Point3D:=(fPoint3DList.GetByName(key) as TPoint3D);
 if Point3D<> nil
  then
   fPoint3DList.DeleteByRef(Point3D) else
   begin
    Line3D:=(fLine3DList.GetByName(key) as TLine3D);
    if Line3D<>nil then
      fLine3DList.DeleteByRef(Line3D)
      else
      begin
       Frame3D:=(FFrame3DList.getByName(key) as TFrame3D);
       if Frame3D<>nil then
        fFrame3DList.DeleteByRef(Frame3D)
       else
       begin
        MayeSurface3D:=(FMayeSurface3DList.getByName(key) as TMayeSurface3D);
        if MayeSurface3D<>nil then
         fMayeSurface3DList.DeleteByRef(MayeSurface3D)
        else
        raise Exception.Create('This item does not exist');
       end;
      end;
   end;
   // TODO:Add the new shapes collection here

end;

procedure TScene3D.RemoveChild(key: string);
var i:integer;
begin
 for i:=0 to fChildList.Count -1 do
 begin
  if (fChildList.Items[i] as TScene3D).KeyName = key then
  begin
   (fChildList.items[i] as TScene3D).Removeall; // bazarde tout ce que le bloc contient
   fChildList.Delete(i);
   break;
  end;
 end;
end; *)

destructor TObject3DRef.destroy;
begin
  fObject3DRef:=nil;
  inherited;

end;

procedure TScene3D.GetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode);
var XmlObject,XmlObject2:IXmlDomNode;
    i: integer;
begin
  //inherited;
  XmlObject:=DomDoc.createElement('Scene3D');
  XmlObjectList.AppendChild(XmlObject);
  XmlObject.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

  inherited GetXmlNode(DomDOc,XmlObject);

  XmlObject2:=DomDoc.createElement('Points3DRef');
  XmlObject.appendChild(XmlObject2);
// Point3D Ref List
   for i:=0 to fPoint3DRefList.Count -1 do
    (fPoint3DRefList.Items[i] as TObject3DRef).GetXmlNode(DomDoc,XmlObject2,'Point3DRef');
// Line3D Ref List
   XmlObject2:=DomDoc.createElement('Lines3DRef');
   XmlObject.appendChild(XmlObject2);

   for i:=0 to fLine3DRefList.Count -1 do
    (fLine3DRefList.Items[i] as TObject3DRef).GetXmlNode(DomDoc,XmlObject2,'Line3DRef');
// Frame3D Ref List
  XmlObject2:=DomDoc.createElement('Frames3DRef');
  XmlObject.appendChild(XmlObject2);

   for i:=0 to fFrame3DRefList.Count -1 do
    (fFrame3DRefList.Items[i] as TObject3DRef).GetXmlNode(DomDoc,XmlObject2,'Frame3DRef');
// MayeSurface3D Ref List
   XmlObject2:=DomDoc.createElement('MayeSurfaces3DRef');
   XmlObject.appendChild(XmlObject2);

   for i:=0 to fMayeSurface3DRefList.Count -1 do
    (fMayeSurface3DRefList.Items[i] as TObject3DRef).GetXmlNode(DomDoc,XmlObject2,'MayeSurface3DRef');


//  XmlAttrib:=DomDoc.CreateAttribute('keyname');
//  XmlAttrib.Text:=floattostr(x);
//  XmlObject.attributes.setNamedItem(XmlAttrib);

end;

procedure TScene3D.SetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode);
var  XmlObjectList2:IXmlDomNodeList;Object3DRef:TObject3DRef;
     i:integer;
begin
  inherited SetXmlNode(DomDoc,XmlObjectList);

  XmlObjectList2:=XMLObjectList.selectNodes('Points3DRef/*');
  for i:=0 to XmlObjectList2.length -1 do begin
   Object3DRef:=fPoint3DRefList.Add(nil) as TObject3DRef;
   Object3DRef.SetXMLNode(DomDoc,XmlObjectList2.Item[i],fDrawer3D,self);
  end;
  XmlObjectList2:=XMLObjectList.selectNodes('Lines3DRef/*');
  for i:=0 to XmlObjectList2.length -1 do begin
   Object3DRef:=fLine3DRefList.Add(nil) as TObject3DRef;
   Object3DRef.SetXMLNode(DomDoc,XmlObjectList2.Item[i],fDrawer3D,self);
  end;
  XmlObjectList2:=XMLObjectList.selectNodes('Frames3DRef/*');
  for i:=0 to XmlObjectList2.length -1 do begin
   Object3DRef:=fFrame3DRefList.Add(nil) as TObject3DRef;
   Object3DRef.SetXMLNode(DomDoc,XmlObjectList2.Item[i],fDrawer3D,self);
  end;
  XmlObjectList2:=XMLObjectList.selectNodes('MayeSurfaces3DRef/*');
  for i:=0 to XmlObjectList2.length -1 do begin
   Object3DRef:=fMayeSurface3DRefList.Add(nil) as TObject3DRef;
   Object3DRef.SetXMLNode(DomDoc,XmlObjectList2.Item[i],fDrawer3D,self);
  end;

end;

procedure TScene3D.RotateX(const dteta: extended);
var i:integer;  Scene3DRef : TTreeItemRef;  ChildScene3D: TScene3D;
begin
  inherited;
  for i:=0 to fPoint3DRefList.count -1 do
   (fPoint3DRefList.Items[i] as TObject3DRef).Value.RotateX(dteta);
  for i:=0 to fLine3DRefList.count -1 do
   (fLine3DRefList.Items[i] as TObject3DRef).Value.RotateX(dteta);

  for i:=0 to fFrame3DRefList.count -1 do
   (fFrame3DRefList.Items[i] as TObject3DRef).Value.RotateX(dteta);
  for i:=0 to fMayeSurface3DRefList.count -1 do
   (fMayeSurface3DRefList.Items[i] as TObject3DRef).Value.RotateX(dteta);

     // Tenir compte de la rotation des sous-scènes
  Scene3DRef:=Drawer3D.Scene3DTree.GetScene3DRef(Keyname,true,nil);
  if scene3DRef=nil then
    raise Exception.Create('TScene3D::RotateX:Current scene does not defined in the SceneTree') else
  begin
    for i:=0 to Scene3DRef.fChildNodes.Count -1 do
    begin
     ChildScene3D:=(Scene3DRef.fChildNodes.Items[i] as TTreeItemRef).Value as TScene3D;
     ChildScene3D.RotateX(dteta);
    end;
  end;


end;

procedure TScene3D.RotateY(const dteta: extended);
var i:integer;Scene3DRef : TTreeItemRef;  ChildScene3D: TScene3D;
begin
  inherited;
  for i:=0 to fPoint3DRefList.count -1 do
   (fPoint3DRefList.Items[i] as TObject3DRef).Value.RotateY(dteta);
  for i:=0 to fLine3DRefList.count -1 do
   (fLine3DRefList.Items[i] as TObject3DRef).Value.RotateY(dteta);

  for i:=0 to fFrame3DRefList.count -1 do
   (fFrame3DRefList.Items[i] as TObject3DRef).Value.RotateY(dteta);
  for i:=0 to fMayeSurface3DRefList.count -1 do
   (fMayeSurface3DRefList.Items[i] as TObject3DRef).Value.RotateY(dteta);
  // ROtation des sous scenes
  Scene3DRef:=Drawer3D.Scene3DTree.GetScene3DRef(Keyname,true,nil);
  if scene3DRef=nil then
    raise Exception.Create('TScene3D::RotateY:Current scene does not defined in the SceneTree') else
  begin
    for i:=0 to Scene3DRef.fChildNodes.Count -1 do
    begin
     ChildScene3D:=(Scene3DRef.fChildNodes.Items[i] as TTreeItemRef).Value as TScene3D;
     ChildScene3D.RotateY(dteta);
    end;
  end;

end;

procedure TScene3D.RotateZ(const dphi: extended);
var i:integer;Scene3DRef : TTreeItemRef;  ChildScene3D: TScene3D;
begin
  inherited;
  for i:=0 to fPoint3DRefList.count -1 do
   (fPoint3DRefList.Items[i] as TObject3DRef).Value.RotateZ(dphi);
  for i:=0 to fLine3DRefList.count -1 do
   (fLine3DRefList.Items[i] as TObject3DRef).Value.RotateZ(dphi);

  for i:=0 to fFrame3DRefList.count -1 do
   (fFrame3DRefList.Items[i] as TObject3DRef).Value.RotateZ(dphi);
  for i:=0 to fMayeSurface3DRefList.count -1 do
   (fMayeSurface3DRefList.Items[i] as TObject3DRef).Value.RotateZ(dphi);
  // ROtation des sous scenes
  Scene3DRef:=Drawer3D.Scene3DTree.GetScene3DRef(Keyname,true,nil);
  if scene3DRef=nil then
    raise Exception.Create('TScene3D::RotateZ:Current scene does not defined in the SceneTree') else
  begin
    for i:=0 to Scene3DRef.fChildNodes.Count -1 do
    begin
     ChildScene3D:=(Scene3DRef.fChildNodes.Items[i] as TTreeItemRef).Value as TScene3D;
     ChildScene3D.RotateZ(dphi);
    end;
  end;

end;


procedure TScene3D.Translate(cx, cy, cz: extended);
var i:integer; Scene3DRef : TTreeItemRef;  ChildScene3D: TScene3D;
begin
  inherited;
  for i:=0 to fPoint3DRefList.count -1 do
   (fPoint3DRefList.Items[i] as TObject3DRef).Value.Translate(cx,cy,cz);
  for i:=0 to fLine3DRefList.count -1 do
   (fLine3DRefList.Items[i] as TObject3DRef).Value.Translate(cx,cy,cz);

  for i:=0 to fFrame3DRefList.count -1 do
   (fFrame3DRefList.Items[i] as TObject3DRef).Value.Translate(cx,cy,cz);
  for i:=0 to fMayeSurface3DRefList.count -1 do
   (fMayeSurface3DRefList.Items[i] as TObject3DRef).Value.Translate(cx,cy,cz);
   // Tenir compte de la translation des sous-scènes
   Scene3DRef:=Drawer3D.Scene3DTree.GetScene3DRef(Keyname,true,nil);
   if scene3DRef=nil then
    raise Exception.Create('TScene3D::Translate:Current scene does not defined in the SceneTree') else
   begin
    for i:=0 to Scene3DRef.fChildNodes.Count -1 do
    begin
     ChildScene3D:=(Scene3DRef.fChildNodes.Items[i] as TTreeItemRef).Value as TScene3D;
     ChildScene3D.Translate(cx,cy,cz);
    end;
   end;
end;

function TScene3D.DeleteRef(Object3D: TObject3D):boolean;
var i:integer;
begin
 result:=false;
 for i:=0 to fPoint3DRefList.Count -1 do
 begin
  if (fPoint3DRefList.Items[i] as TObject3DRef).Value=Object3D then
  begin
   fPoint3DRefList.Delete(i);
   result:=true;
   break;
  end;
 end;
 if result then exit;
 for i:=0 to fLine3DRefList.Count -1 do
 begin
  if (fLine3DRefList.items[i] as TObject3DRef).Value=Object3D then
  begin
   fLine3DRefList.Delete(i);
   result:=true;
   break;
  end;
 end;
 if result then exit;
 for i:=0 to fFrame3DRefList.count -1 do
 begin
  if (FFrame3DRefList.Items[i] as TObject3DRef).Value=Object3D then
  begin
   fFrame3DRefList.Delete(i);
   result:=true;
   break;
  end;

 end;
 if result then exit;
 for i:=0 to fMayeSurface3DRefList.count -1 do
 begin
  if (fMayeSurface3DRefList.Items[i] as TObject3DRef).Value=Object3D then
  begin
   fMayeSurface3DRefList.delete(i);
   result:=true;
   break;
  end;
 end;
end;

procedure TScene3D.ChangeObjectParent(Parent: TScene3D);
var i:integer;Object3D:TObject3D;
begin
 if Parent=nil then
  raise Exception.Create('TScene3D::ChangeObjectParent:The object Parent must be not null');
 for i:=0 to fPoint3DRefList.Count -1 do
 begin
  Object3D:=(fPoint3DRefList.Items[i] as TObject3DRef).Value;
  parent.fPoint3DRefList.add(Object3D);
  Object3D.fParent:=Parent;
 end;
 fPoint3DRefList.Clear;
 for i:=0 to fLine3DRefList.Count -1 do
 begin
  Object3D:=(fLine3DRefList.Items[i] as TObject3DRef).Value;
  parent.fLine3DRefList.add(Object3D);
  Object3D.fParent:=Parent;
 end;
 fLine3DRefList.Clear;
 for i:=0 to fFrame3DRefList.Count -1 do
 begin
  Object3D:=(fFrame3DRefList.Items[i] as TObject3DRef).Value;
  parent.fFrame3DRefList.add(Object3D);
  Object3D.fParent:=Parent;
 end;
 fFrame3DRefList.Clear;
 for i:=0 to fMayeSurface3DRefList.Count -1 do
 begin
  Object3D:=(fMayeSurface3DRefList.Items[i] as TObject3DRef).Value;
  parent.fMayeSurface3DRefList.add(Object3D);
  Object3D.fParent:=Parent;
 end;
 fMayeSurface3DRefList.Clear;

end;

procedure TScene3D.Copy(ThisObject: TScene3D);
var i:integer; Object3D,Object3DNew:TObject3D;Parent:TTreeItemRef;
    SScene3DRef,TaScene3DRef : TTreeItemRef; Scene3DNew, ChildScene3D : TScene3D;
begin
// Vide la liste au cas où le target contiendrait déjà des objets
  Clear;
  Parent:=fParent.fDrawer3D.Scene3DTree.GetScene3DRef(Keyname,true);
  // Recrée les objet 3D
  for i:=0 to (ThisObject as TScene3D).fPoint3DRefList.count -1 do
  begin
   Object3D:=((ThisObject as TScene3D).fPoint3DRefList.Items[i] as TObject3DRef).Value;
   Object3DNew:=fDrawer3D.Scene3DTree.AddObject3D(Object3D,Parent);
   Object3DNew.KeyName:=Keyname+'_'+Object3D.KeyName;
   Object3DNew.fParent:=Self;
//   fPoint3DRefList.Add(Object3DNew);
  end;
  for i:=0 to (ThisObject as TScene3D).fLine3DRefList.count -1 do
  begin
   Object3D:=((ThisObject as TScene3D).fLine3DRefList.Items[i] as TObject3DRef).Value;
   Object3DNew:=fDrawer3D.Scene3DTree.AddObject3D(Object3D,Parent);
   Object3DNew.KeyName:=Keyname+'_'+Object3D.KeyName;
   Object3DNew.fParent:=Self;
//   fPoint3DRefList.Add(Object3DNew);
  end;
  for i:=0 to (ThisObject as TScene3D).fFrame3DRefList.count -1 do
  begin
   Object3D:=((ThisObject as TScene3D).fFrame3DRefList.Items[i] as TObject3DRef).Value;
   Object3DNew:=fDrawer3D.Scene3DTree.AddObject3D(Object3D,parent);
   Object3DNew.KeyName:=Keyname+'_'+Object3D.KeyName;
   Object3DNew.fParent:=Self;
//   fPoint3DRefList.Add(Object3DNew);
  end;
  for i:=0 to (ThisObject as TScene3D).fMayeSurface3DRefList.count -1 do
  begin
   Object3D:=((ThisObject as TScene3D).fMayeSurface3DRefList.Items[i] as TObject3DRef).Value;
   Object3DNew:=fDrawer3D.Scene3DTree.AddObject3D(Object3D,parent);
   Object3DNew.KeyName:=Keyname+'_'+Object3D.KeyName;
   Object3DNew.fParent:=Self;
//   fPoint3DRefList.Add(Object3DNew);
  end;
// Copier les sous-blocs   de la scène source vers la scène cible
  SScene3DRef:=Drawer3D.Scene3DTree.GetScene3DRef((ThisObject as TScene3D).Keyname,true,nil);
  TaScene3DRef:=Drawer3D.Scene3DTree.GetScene3DRef(self.Keyname,true,nil);
  if Sscene3DRef=nil then
    raise Exception.Create('TScene3D::Copy:Current scene does not defined in the SceneTree') else
  begin
    for i:=0 to SScene3DRef.fChildNodes.Count -1 do
    begin
    // ajouter une nouvelle scène dans la scène cible
     SCene3DNew:=Drawer3D.Scene3DTree.Add(TaSCene3DRef) as TScene3D;
     Scene3DNew.fDrawer3D:=Drawer3D;
     Scene3DNew.fparent:=self;
     ChildScene3D:=(SScene3DRef.fChildNodes.Items[i] as TTreeItemRef).Value as TScene3D;
     Scene3DNew.Keyname:=KeyName+'_'+ChildScene3D.KeyName;

     Scene3DNew.Copy(ChildScene3D)

    end;
  end;

end;

procedure TScene3D.SetHide;
var i:integer; Scene3DRef : TTreeItemRef;  ChildScene3D: TScene3D;
begin
 for i:=0 to FFrame3DRefList.Count -1 do
  (fFrame3DRefList.Items[i] as TObject3DRef).Value.Hide:=true;
 for i:=0 to FLine3DRefList.Count -1 do
  (fLine3DRefList.Items[i] as TObject3DRef).Value.Hide:=true;
 for i:=0 to FPoint3DRefList.Count -1 do
  (fPoint3DRefList.Items[i] as TObject3DRef).Value.Hide:=true;
 for i:=0 to FMayeSurface3DRefList.Count -1 do
  ((fMayeSurface3DRefList.Items[i] as TObject3DRef).Value as TMayeSurface3D).SetHide;
 Scene3DRef:=Drawer3D.Scene3DTree.GetScene3DRef(Keyname,true,nil);
 if scene3DRef=nil then
    raise Exception.Create('TScene3D::SetHide:Current scene does not defined in the SceneTree') else
 begin
    for i:=0 to Scene3DRef.fChildNodes.Count -1 do
    begin
     ChildScene3D:=(Scene3DRef.fChildNodes.Items[i] as TTreeItemRef).Value as TScene3D;
     ChildScene3D.SetHide;
    end;
  end;

end;

procedure TScene3D.SetUnHide;
var i:integer; Scene3DRef : TTreeItemRef;  ChildScene3D: TScene3D;
begin
 for i:=0 to FFrame3DRefList.Count -1 do
  (fFrame3DRefList.Items[i] as TObject3DRef).Value.Hide:=false;
 for i:=0 to FLine3DRefList.Count -1 do
  (fLine3DRefList.Items[i] as TObject3DRef).Value.Hide:=false;
 for i:=0 to FPoint3DRefList.Count -1 do
  (fPoint3DRefList.Items[i] as TObject3DRef).Value.Hide:=false;
 for i:=0 to FMayeSurface3DRefList.Count -1 do
  ((fMayeSurface3DRefList.Items[i] as TObject3DRef).Value as TMayeSurface3D).SetUnHide;
 Scene3DRef:=Drawer3D.Scene3DTree.GetScene3DRef(Keyname,true,nil);
 if scene3DRef=nil then
    raise Exception.Create('TScene3D::SetUnHide:Current scene does not defined in the SceneTree') else
 begin
    for i:=0 to Scene3DRef.fChildNodes.Count -1 do
    begin
     ChildScene3D:=(Scene3DRef.fChildNodes.Items[i] as TTreeItemRef).Value as TScene3D;
     ChildScene3D.SetUnHide;
    end;
  end;

end;

// Delete the content and the reference from the scene.
function TScene3D.DeleteAllChildObjects: boolean;
var i: integer;
    Scene3DRef : TTreeItemRef;
    Ref : TObject3DRef;
    Obj : TObject3D;
begin
 for i:=fPoint3DRefList.Count -1 downto 0  do
 begin
   Ref:=fPoint3DRefList.Items[i] as TObject3DRef ;
   Obj :=Ref.Value as TObject3D;
   Drawer3D.DeleteObject3D(Obj.Keyname);
   fPoint3DRefList.Delete(i);
 end;
 for i:=fLine3DRefList.Count -1 downto 0  do
 begin
   Drawer3D.DeleteObject3D(((fLine3DRefList.Items[i] as TObject3DRef).Value as TObject3D).Keyname);
   fLine3DRefList.Delete(i);
 end;
 for i:=fFrame3DRefList.count -1 downto 0  do
 begin
   Drawer3D.DeleteObject3D(((fFrame3DRefList.Items[i] as TObject3DRef).Value as TObject3D).Keyname);

   fFrame3DRefList.Delete(i);

 end;
 for i:=fMayeSurface3DRefList.count -1 downto 0  do
 begin
   Drawer3D.DeleteObject3D(((fMayeSurface3DRefList.Items[i] as TObject3DRef).Value as TObject3D).Keyname);
   fMayeSurface3DRefList.delete(i);
 end;
// Ne pas oublier les sous scène
 Scene3DRef:=Drawer3D.Scene3DTree.GetScene3DRef(self.Keyname,true,nil);
 if Scene3DRef=nil then
  raise Exception.Create('TScene3DList : DeleteAllChildObjects : Unabble to find the current scene');

{ for i:=Scene3DRef.fChildNodes.Count - 1 to 0 do
  (Scene3DRef.fChildNodes.Items[i] as TTreeItem).}

 result:=true;
end;


{ TObject3D }

procedure TObject3D.Clear;
begin

end;

procedure TObject3D.Clone(ThisObject: TObject3D);
begin
  color:=ThisObject.color;
  oType:=ThisObject.oType;
  KeyName:=ThisObject.KeyName;
  Hide :=ThisObject.Hide;
  fParent:=ThisObject.fParent;
end;

procedure TObject3D.DrawObject;
begin
 // Set the line-type
 foColor:=fDrawer3D.fCanvas.Pen.Color;
 foPenStyle:=fDrawer3D.fCanvas.Pen.Style;

 if fDrawer3D.fPolygonFrames=0 then
  fDrawer3D.fCanvas.Pen.COlor:=Drawer3D.getLookupColor(Color);
 case oType of
  0: fDrawer3D.fCanvas.Pen.Style:=psSolid;
  1: fDrawer3D.fCanvas.Pen.Style:=psDot;
 end;
end;

procedure TObject3D.GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);
var XmlAttrib:IXmlDomNode;
begin
  XmlAttrib:=DomDoc.CreateAttribute('Keyname');
  XmlAttrib.Text:=KeyName;
  XmlObjectList.attributes.setNamedItem(XmlAttrib);

  XmlAttrib:=DomDoc.CreateAttribute('Color');
  XmlAttrib.Text:=inttostr(Color);
  XmlObjectList.attributes.setNamedItem(XmlAttrib);


  XmlAttrib:=DomDoc.CreateAttribute('ParentKeyname');
  if fparent<>nil then
  XmlAttrib.Text:=fParent.Keyname else XmlAttrib.text:='';
  XmlObjectList.attributes.setNamedItem(XmlAttrib);

  XmlAttrib:=DomDoc.CreateAttribute('Hide');
  if Hide then
  XmlAttrib.Text:='true' else
   XmlAttrib.Text:='false';
  XmlObjectList.attributes.setNamedItem(XmlAttrib);

  XmlAttrib:=DomDoc.CreateAttribute('Type');
  XmlAttrib.Text:=inttostr(oType);
  XmlObjectList.attributes.setNamedItem(XmlAttrib);

end;

procedure TObject3D.Rotate(const dteta,dphi: extended);
begin

end;

procedure TObject3D.RotateX(const dteta: extended);
begin

end;

procedure TObject3D.RotateY(const dteta: extended);
begin

end;

procedure TObject3D.RotateZ(const dphi: extended);
begin

end;

procedure TObject3D.SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);
var XmlAttrib:IXmlDomNode;
begin
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('Keyname');
 if XmlAttrib<>nil then
 keyname:=XmlAttrib.text;
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('Color');
 if XmlAttrib<>nil then
 Color:=strtoint(XmlAttrib.text);
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('Hide');
 if XmlAttrib<>nil then
  if XmlAttrib.text='true' then
   Hide:=true else Hide:=false;

 XMLAttrib := XmlObjectList.attributes.getNamedItem ('Type');
 if XmlAttrib<>nil then
   oType:=strtoint(XmlAttrib.Text);
end;

{ TSphere3D }

{constructor TSphere3D.create(Collection: TCollection);
begin
  inherited;
  x:=0;y:=0;z:=0;
  radius:=0;
  LatitudeCircles:=0;
  LongitudeCircles:=0;
end;

procedure TSphere3D.DrawObject;
var csx,csy : integer; // coordonnée projetée du centre de la sphère
    xc,yc,zc:extended;
    PointPerArc:integer;
    PhiDelta,Phi:extended;
    TetaDelta,Teta:Extended;
    i,j:integer;
    xp,yp:integer;
begin
 inherited;
 Drawer3D.Projection2D(x,y,z,csx,csy);
 PointPerArc:=Round(40*radius);
 csx:=csx-Drawer3D.fClientWidth div 2;csy:=(Drawer3D.fCLientHeight div 2)-csy;
 PhiDelta:=2*pi/PointPerArc;
 TetaDelta:=pi/LatitudeCircles;
 Teta:=0;
 // Calculer les coordonnées polaires et ajouter à chaque fois les coordonnées du centre:
 // Latitude
 for i:=0 to LatitudeCircles do
 begin
    Teta:=Teta+TetaDelta;
    Phi:=0;
    Drawer3D.PolarToCart(Radius,teta,Phi,xc,yc,zc);
    Drawer3D.Projection2D(xc,yc,zc,xp,yp);
    xp:=xp+csx; yp:=yp+csy;
    Drawer3D.fCanvas.MoveTo(xp,yp);
    for j:=0 to PointPerArc do
    begin
     Phi:=Phi+PhiDelta;
     Drawer3D.PolarToCart(Radius,teta,phi,xc,yc,zc);
     Drawer3D.Projection2D(xc,yc,zc,xp,yp);
     xp:=xp+csx; yp:=yp+csy;
     Drawer3D.fCanvas.LineTo(xp,yp);
    end;
 end;
 // Longitude
 TetaDelta:=2*pi/PointPerArc;
 PhiDelta:=2*pi/LongitudeCircles;
 Phi:=0;
 for i:=0 to LongitudeCircles do
 begin
    Phi:=Phi+PhiDelta;
    Teta:=0;
    Drawer3D.PolarToCart(Radius,teta,Phi,xc,yc,zc);
    Drawer3D.Projection2D(xc,yc,zc,xp,yp);
    xp:=xp+csx;yp:=yp+csy;
    Drawer3D.fCanvas.MoveTo(xp,yp);
    for j:=0 to PointPerArc do
    begin
     teta:=teta+TetaDelta;
     Drawer3D.PolarToCart(Radius,teta,Phi,xc,yc,zc);
     Drawer3D.Projection2D(xc,yc,zc,xp,yp);
     xp:=xp+csx; yp:=yp+csy;
     Drawer3D.fCanvas.LineTo(xp,yp);
    end;
 end;
end;
}


procedure TObject3D.Translate(cx, cy, cz: extended);
begin

end;

{ TFrame3DList }

function TFrame3DList.AddNewObject3D: TObject3D;
begin
 result:=add as TObject3D;
end;

constructor TFrame3DList.create(Drawer3D:TDrawer3D);
begin
 inherited create(Drawer3D,TFrame3D);
end;

{ TFrame3D }

procedure TFrame3D.clear;
begin
  inherited;
  fPoints.free;
end;

procedure TFrame3D.Clone(ThisObject: TObject3D);
var i:integer; ref:TMayeEdge;
begin
  inherited;
  fPoints.Clear;
  for i:=0 to (ThisObject as TFrame3D).fPoints.Count-1 do
  begin
   ref:=fPoints.Add as TMayeEdge;
   ref.Clone( (ThisObject as TFrame3D).fPoints.Items[i] as TMayeEdge);
  end;

end;

constructor TFrame3D.create(Collection: TCollection);
begin
  inherited;
  fPoints:=TMayeEdgeList.create(nil);
end;

destructor TFrame3D.destroy;
begin
  fPoints.free;
  inherited;

end;

procedure TFrame3D.DrawObject;
var xp,yp:integer;p:TMayeEdge;
begin
 inherited;
 {if fPoints.Count<>24 then
  raise Exception.Create('TFrame3D::DrawObject:Invalid edge number');}
 if not Hide then begin
 // 1-2
  p:=fPoints.Items[0] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[1] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
 // 1-5
  p:=fPoints.Items[0] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[4] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
// 2-3
  p:=fPoints.Items[1] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[2] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
// 2-6
  p:=fPoints.Items[1] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[5] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
 // 3-4
  p:=fPoints.Items[2] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[3] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
// 3-7
  p:=fPoints.Items[2] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[6] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
// 4-1
  p:=fPoints.Items[3] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[0] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
// 4-8
  p:=fPoints.Items[3] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[7] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
// 5-6
  p:=fPoints.Items[4] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[5] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
// 5-8
  p:=fPoints.Items[4] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[7] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
// 6-7
  p:=fPoints.Items[5] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[6] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
// 7-8
  p:=fPoints.Items[6] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.MoveTo(xp,yp);
  p:=fPoints.Items[7] as TMayeEdge;
  fDrawer3D.Projection2D(p.x,p.y,p.z,xp,yp);
  fDrawer3D.fcanvas.LineTo(xp,yp);
 end;
 Drawer3D.fCanvas.Pen.Color:=foColor;
 Drawer3D.fCanvas.Pen.Style:=foPenStyle;

end;

procedure TFrame3D.GetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);
var XmlObject,XmlAttrib,XmlObject2,xmlObject3:IXmlDomNode; i:integer;
begin
   XmlObject:=DomDoc.createElement('Frame3D');
   XmlObjectList.AppendChild(XmlObject);
   XmlObject.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

   inherited GetXmlNode(DomDoc,XmlObject);

   XmlObject2:=DomDoc.createElement('Points');
   XmlObject.appendChild(XmlObject2);
   XmlObject2.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

   for i:=0 to fPoints.Count-1 do begin
     XmlObject3:=DomDoc.createElement('Point');
     XmlObject2.appendchild(XmlObject3);
     XmlAttrib:=DomDoc.CreateAttribute('x');
     XmlAttrib.Text:=floattostr((fPoints.Items[i] as TMayeEdge).x);
     XmlObject3.attributes.setNamedItem(XmlAttrib);

     XmlAttrib:=DomDoc.CreateAttribute('y');
     XmlAttrib.Text:=floattostr((fPoints.Items[i] as TMayeEdge).y);
     XmlObject3.attributes.setNamedItem(XmlAttrib);

     XmlAttrib:=DomDoc.CreateAttribute('z');
     XmlAttrib.Text:=floattostr((fPoints.Items[i] as TMayeEdge).z);
     XmlObject3.attributes.setNamedItem(XmlAttrib);
   end;
{   XmlAttrib:=DomDoc.CreateAttribute('height');
   XmlAttrib.Text:=floattostr(height);
   XmlObject.attributes.setNamedItem(XmlAttrib);

   XmlAttrib:=DomDoc.CreateAttribute('length');
   XmlAttrib.Text:=floattostr(length);
   XmlObject.attributes.setNamedItem(XmlAttrib);

   XmlAttrib:=DomDoc.CreateAttribute('width');
   XmlAttrib.Text:=floattostr(width);
   XmlObject.attributes.setNamedItem(XmlAttrib);}

end;

procedure TFrame3D.Rotate(const dteta, dphi: extended);
var rho,teta,phi:extended;
    i:integer;
begin
  inherited;
  for i:=0 to fPoints.count -1 do
  begin
   ToPolar((fPoints.Items[i] as TMayeEdge).x,(fPoints.Items[i] as TMayeEdge).y,(fPoints.Items[i] as TMayeEdge).z,rho,teta,phi);
   teta:=teta+dteta;
   phi:=phi+dphi;
   ToCartesian(rho,teta,phi,(fPoints.Items[i] as TMayeEdge).x,(fPoints.Items[i] as TMayeEdge).y,(fPoints.Items[i] as TMayeEdge).z);
  end;
end;

procedure TFrame3D.RotateX(const dteta: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fPoints.count -1 do
   Rotate3DX(dteta,(fPoints.Items[i] as TMayeEdge).x,(fPoints.Items[i] as TMayeEdge).y,(fPoints.Items[i] as TMayeEdge).z);

end;

procedure TFrame3D.RotateY(const dteta: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fPoints.count -1 do
   Rotate3DY(dteta,(fPoints.Items[i] as TMayeEdge).x,(fPoints.Items[i] as TMayeEdge).y,(fPoints.Items[i] as TMayeEdge).z);

end;

procedure TFrame3D.RotateZ(const dphi: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fPoints.count -1 do
   Rotate3DZ(dphi,(fPoints.Items[i] as TMayeEdge).x,(fPoints.Items[i] as TMayeEdge).y,(fPoints.Items[i] as TMayeEdge).z);

end;

procedure TFrame3D.SetXMLNode(DomDoc:DomDocument;XmlObjectList:IXmlDomNode);
var XmlAttrib:IXmlDomNode; i:integer; XmlObjectList2:IXmlDomNodeList; Point3D:TMayeEdge;
begin
 inherited SetXmlNode(DomDoc,XmlObjectList);
  XmlObjectList2:=XMLObjectList.selectNodes('Points/*'); // Edges collection
  for i:=0 to XmlObjectList2.length -1 do  // Edge
   begin
   Point3D:=fPoints.Add as TMayeEdge;
   XMLAttrib := XmlObjectList2.item[i].attributes.getNamedItem ('x');
   if XmlAttrib<>nil then
   Point3D.x:=strtofloat(XmlAttrib.text);

   XMLAttrib := XmlObjectList2.item[i].attributes.getNamedItem ('y');
   if XmlAttrib<>nil then
   Point3D.y:=strtofloat(XmlAttrib.text);

  XMLAttrib := XmlObjectList2.item[i].attributes.getNamedItem ('z');
  if XmlAttrib<>nil then
   Point3D.z:=strtofloat(XmlAttrib.text);
 end;
{ XMLAttrib := XmlObjectList.attributes.getNamedItem ('height');
 if XmlAttrib<>nil then
 height:=strtofloat(XmlAttrib.text);

 XMLAttrib := XmlObjectList.attributes.getNamedItem ('length');
 if XmlAttrib<>nil then
 length:=strtofloat(XmlAttrib.text);

 XMLAttrib := XmlObjectList.attributes.getNamedItem ('width');
 if XmlAttrib<>nil then
 width:=strtofloat(XmlAttrib.text);}

end;

procedure TDrawer3D.PolarToCart(_rho,_teta,_phi:extended;var _x,_y,_z:extended);
begin
   _x:=_rho*sin(_teta)*cos(_phi);
   _y:=_rho*sin(_teta)*sin(_phi);
   _z:=_rho*cos(_teta);
end;
procedure TDrawer3D.GetVectorEye(x, y, z: extended; var xm, ym, zm: extended);
var
   tx,ty,tz:extended; // Coordonnée de Translation
   // new
   PVect:TFloatVector;
   MatTrans:TFloatMatrix;
   MatRotphi:TFloatMatrix;
   MatRotTeta:TFloatMatrix;
   MatInvertX:TFloatMatrix;
   rho,teta,phi:extended;
begin
 // Nouvelle méthode
 rho:=frhoeye;
 teta:=fcolatiteye;
 phi:=fazimutheye;
 tx:=rho*sin(teta)*cos(phi);
 ty:=rho*sin(teta)*sin(phi);
 tz:=rho*cos(teta);

 Pvect:=TFloatVector.Create(4);
 with PVect do   begin
  Item[1]:=x; Item[2]:=y; Item[3]:=z; Item[4]:=1;
 end;
// Apply translation matrix
 MatTrans:=TFloatMatrix.Create(4);
 with MatTrans do begin
  Item[1,1]:=1; Item[1,2]:=0; Item[1,3]:=0; Item[1,4]:=-tx;
  Item[2,1]:=0; Item[2,2]:=1; Item[2,3]:=0; Item[2,4]:=-ty;
  Item[3,1]:=0; Item[3,2]:=0; Item[3,3]:=1; Item[3,4]:=-tz;
  Item[4,1]:=0; Item[4,2]:=0; Item[4,3]:=0; Item[4,4]:=1; 

 end;
// Rotation autours de Zt
 PVect.MultiplyByLeft(MatTrans);

 MatRotPhi:=TFloatMatrix.Create(4);
 with MatRotPhi do begin
  Item[1,1]:=sin(phi); Item[1,2]:=-cos(phi);  Item[1,3]:=0; Item[1,4]:=0;
  Item[2,1]:=cos(phi) ;Item[2,2]:= sin(phi);  Item[2,3]:=0; Item[2,4]:=0;
  Item[3,1]:=0;        Item[3,2]:=0;          Item[3,3]:=1; Item[3,4]:=0;
  Item[4,1]:=0;        Item[4,2]:=0;          Item[4,3]:=0; Item[4,4]:=1;
 end;
 PVect.MultiplyByLeft(MatRotPhi);
// Rotation autours des Xphi
 MatRotTeta:=TFloatMatrix.Create(4);
 with MatRotTeta do begin
  Item[1,1]:=1            ; Item[1,2]:=0            ;   Item[1,3]:=0;             Item[1,4]:=0;
  Item[2,1]:=0            ; Item[2,2]:=-cos(teta)   ;   Item[2,3]:= sin(teta);    Item[2,4]:=0;
  Item[3,1]:=0;             Item[3,2]:=-sin(teta);      Item[3,3]:=-cos(teta);    Item[3,4]:=0;
  Item[4,1]:=0;             Item[4,2]:=0;               Item[4,3]:=0;             Item[4,4]:=1;
 end;

 PVect.MultiplyByLeft(MatRotTeta);

// Inversion XTeta
 MatInvertX:=TFloatMatrix.Create(4);
 with MatInvertX do begin
  Item[1,1]:=-1; Item[1,2]:=0; Item[1,3]:=0; Item[1,4]:=0;
  Item[2,1]:=0; Item[2,2]:=1;  Item[2,3]:=0; Item[2,4]:=0;
  Item[3,1]:=0; Item[3,2]:=0;  Item[3,3]:=1; Item[3,4]:=0;
  Item[4,1]:=0; Item[4,2]:=0;  Item[4,3]:=0; Item[4,4]:=1;
 end;
 PVect.MultiplyByLeft(MatInvertX);


// récupération du résultat
 with PVect do begin
  xm:=Item[1]; ym:=Item[2] ; zm:=Item[3];
 end;
 // Calcul de la matrice de translation par rapport à Z0;
 MatInvertX.free;
 MatRotTeta.Free;
 MatRotPhi.Free;
// MatProj.free;

// with PVect do begin
//  xm:=Item[1]; ym:=Item[2] ; zm:=Item[3];
// end;

 MatTrans.Free;

 PVect.free;
end;

procedure TDrawer3D.Projection2D(x, y, z: extended; var xp, yp: integer);
var xm,ym,zm:extended;
    ClientX,ClientY:integer;
begin

 ClientX:=fClientWidth div 2;
 ClientY:=fClientHeight div 2;

 GetVectorEye(x+fxTranslate,y+fyTranslate,z+fzTranslate,xm,ym,zm);
 //if zm>fZeye then begin
if (zm<>0) and (zm>fzeye) then begin
  xp:=Round((fZeye*xm/zm)*fscale)+ClientX;
  yp:=ClientY-Round((fZeye*ym/zm)*fscale);
end
 else
 begin
 // raise Exception.Create('Unable to evaluate the');
  xp:=0;
  yp:=0;
 end;

//  xp:=(xp*(ClientWidth div 2) div 640);
//  yp:=(ClientHeight div 2)-(yp*(ClientHeight div 2) div 480)
// end else
// begin // Eviter l'effet de lentille
// end;
end;

constructor TDrawer3D.create;
begin
 // Construction
 fPoint3DList:=TPoint3DList.create(self);
 fLine3DList:=TLine3DList.Create(self);
 fFrame3DList:=TFrame3DList.Create(self);
 fMayeSurface3DList:=TMayeSurface3DList.Create(self);
 fScene3DList:=TScene3DList.Create(Self);

 fTree3D:=TScene3DTree.create(Self,fScene3DList); // L'arbre contient des ref sur les scene3D
 fTree3D.add(nil);
 fMainScene3DRef:=fTree3D.fRefNodeList.Items[0] as TTreeItemRef;
 //fMainScene3DRef.pData:=fScene3DList.add;
 fMainScene3D:=fMainScene3DRef.value as TScene3D;
 fMainScene3D.KeyName:='MainScene';
 fMainScene3D.Drawer3D:=self;

 fRefMayeTriFace3DList :=TRefMayeTriFace3DList.create;
 fCurrentScene3D:=fMainScene3D;
 fCurrentScene3DRef:=fMainScene3DRef;
//
 FormatSettings.DecimalSeparator:='.';
end;


procedure TDrawer3D.ShowScene3D(Form:TForm;rhoeye, colatiteye, azimutheye, zeye,
  scale,Showaxes,Polygonframes,xtranslate,ytranslate,ztranslate,cursorinc: extended;ClientWidth,ClientHeight:integer);
var  axe3Dlist:TAxe3DList;axe3Dx,axe3Dy,axe3Dz:TAxe3D;
begin
 fForm:=Form;
 fCanvas:=Form.Canvas;
 fRhoeye:=RhoEye;
 fColatiteye:=Colatiteye;
 fAzimutheye:=Azimutheye;
 fZeye:=Zeye;
 fScale:=Scale;
 fSHowAxes:=Showaxes;
 fClientWidth:=ClientWidth;
 fClientHeight:=CLientHeight;
 fxTranslate:=xTranslate;
 fyTranslate:=yTranslate;
 fzTranslate:=zTranslate;
 fCursorInc:=CursorInc;
 if fShowAxes=1 then
 begin
  Axe3DList:=TAxe3DList.Create(self);
  Axe3Dx:=Axe3DList.Add as TAxe3D;
  with axe3Dx do begin
   x1:=0;
   y1:=0;
   z1:=0;
   x2:=50;
   y2:=0;
   z2:=0;
   Axename:='X';
   DrawObject;
  end;
  Axe3Dy:=Axe3DList.Add as TAxe3D;
  with axe3Dy do  begin
 //  Drawer3D:=self;
   x1:=0;
   y1:=0;
   z1:=0;
   x2:=0;
   y2:=50;
   z2:=0;
   Axename:='Y';
   DrawObject;
  end;
  Axe3Dz:=Axe3DList.Add as TAxe3D;
  with axe3Dz do begin
   Drawer3D:=self;
   x1:=0;
   y1:=0;
   z1:=0;
   x2:=0;
   y2:=0;
   z2:=50;
   Axename:='Z';
   DrawObject;
  end;
  Axe3DList.Free;
 end;
 //fMainScene3D.DrawObject;
 fPolygonFrames:=PolygonFrames;
 DrawObjects;
end;

destructor TDrawer3D.destroy;
begin
  fScene3DList.Free;
  fPoint3DList.free;
  fLine3DList.free;
  fFrame3Dlist.Free;
  fMayeSurface3DList.free;
  fRefMayeTriFace3DList.free;
  inherited;

end;

procedure TFrame3D.Translate(cx, cy, cz: extended);
var i:integer; ref:TMayeEdge;
begin
  inherited;
  for i:=0 to fPoints.Count-1 do begin
   ref:=fPoints.Items[i] as TMayeEdge;
   ref.x:=ref.x+cx;
   ref.y:=ref.y+cy;
   ref.z:=ref.z+cz;
  end;
end;

{ TAxe3D }

constructor TAxe3D.create(Collection: TCollection);
begin
 inherited create(Collection);
end;

procedure TAxe3D.DrawObject;
var xp1,yp1,xp2,yp2:integer;
begin
  try
   with Drawer3D do begin
    Projection2D(x1,y1,z1,xp1,yp1);
    Projection2D(x2,y2,z2,xp2,yp2);


    fCanvas.MoveTo(xp1,yp1);
    fCanvas.LineTo(xp2,yp2);
    fCanvas.TextOut(xp2,yp2,AxeName);
   end;
  except
  end;

end;

{ TAxe3DList }

constructor TAxe3DList.create(Drawer3D:TDrawer3D);
begin
 inherited Create(Drawer3D,TAxe3D);

end;

function TDrawer3D.SaveToXmlFile(const sFileName: string): integer;
var DomDoc : DOMDocument;
    XmlRoot : IXmlDomNode;
    XmlObjectList : IXmlDomNode;
    XmlAttrib:IxmlDomnode;
    XmlNode:IXmlDomNode;
//    XmlObject : IXmlDomNode;
//    XmlAttrib : IXmlDomNode;
    i:integer;
begin
 //TODO:Implement the save XML
 DomDoc:=CoDomDocument.Create;
 DomDoc.appendChild (DomDoc.createProcessingInstruction('xml', 'version="1.0"'));

 XMLRoot:=DomDoc.CreateElement('Doc3DCrade');
 DomDoc.appendChild(XmlRoot);
 XmlRoot.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

 XmlNode:=DomDoc.createElement('Parameters');
 XmlRoot.appendChild(XmlNode);

 XmlAttrib:=DomDoc.CreateAttribute('rhoeye');
 XmlAttrib.Text:=floattostr(frhoeye);
 XmlNode.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.CreateAttribute('colatiteye');
 XmlAttrib.Text:=floattostr(fcolatiteye);
 XmlNode.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.CreateAttribute('azimutheye');
 XmlAttrib.Text:=floattostr(fazimutheye);
 XmlNode.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.CreateAttribute('zeye');
 XmlAttrib.Text:=floattostr(fZeye);
 XmlNode.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.CreateAttribute('scale');
 XmlAttrib.Text:=floattostr(fscale);
 XmlNode.attributes.setNamedItem(XmlAttrib);
 XmlNode.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

 XmlNode:=DomDoc.createElement('Objects');
 XmlRoot.appendChild(XmlNode);
 XmlNode.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));
 // Point3D List
 XmlObjectList:=DomDoc.createElement('Points3D');
 XmlNode.appendChild(XmlObjectList);
 XmlNode.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

 for i:=0 to fPoint3DList.Count -1 do
  (fPoint3DList.Items[i] as TPoint3D).GetXmlNode(DomDoc,XmlObjectList);
 // Line3D list
 XmlObjectList:=DomDoc.createElement('Lines3D');
 XmlNode.appendChild(XmlObjectList);
 XmlNode.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));
 for i:=0 to fLine3DList.Count -1 do
  (fLine3DList.Items[i] as TLine3D).GetXmlNode(DomDoc,XmlObjectList);
  // Frame3D List
 XmlObjectList:=DomDoc.createElement('Frames3D');
 xmlNode.appendChild(XmlObjectList);
 XmlNode.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));
 for i:=0 to fFrame3DList.count -1 do
  (fFrame3DList.items[i] as TFrame3D).GetXmlNode(DomDoc,XmlObjectList);

  // MayeSurface 3D List
 XmlObjectList:=DomDoc.createElement('MayeSurfaces3D');
 xmlNode.appendChild(XmlObjectList);
 XmlNode.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));
 for i:=0 to fMayeSurface3DList.count -1 do
  (fMayeSurface3DList.Items[i] as TMayeSurface3D).GetXmlNode(DomDoc,XmlObjectList);

  // Scene 3D List
 XmlObjectList:=DomDoc.createElement('Scenes3D');
 xmlNode.appendChild(XmlObjectList);
 XmlNode.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

 for i:=0 to fScene3DList.count -1 do
  (fScene3DList.Items[i] as TScene3D).GetXmlNode(DomDoc,XmlObjectList);

 // Link between the scenes to produce the Tree
 XmlObjectList:=DomDoc.createElement('Scenes3DRef');
 xmlNode.appendChild(XmlObjectList);
 XmlNode.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

 fTree3D.GetXmlNode(DomDoc,XmlObjectList);

 DomDoc.Save(sFileName);

 result:=0;
end;

function TDrawer3D.LoadFromXMLFile(const sFilename: string;Const Context:TCustomContext): integer;
var DomDoc:DOMDocument;
    XmlObject:IXmlDomNode;
    XmlObjectList:IXmlDomNodeList;
    XmlRoot:IXmlDomNode;

 //   XmlObject:IXmlDomNode;
 XmlAttrib:IXmlDomNode;
    i,j,k:integer;
    Point3D:TPoint3D; Line3D:TLine3D; Frame3D:TFrame3D; MayeSurface3D:TMayeSurface3D;
    Scene3D:TScene3D;
begin
 //TODO:Implement the Load from XML
 // Ne pas destroyer c'est COM qui s'en charge
 RemoveAll;

 DomDoc:=CoDomDocument.Create;
 DomDoc.load(sFileName);
 XmlRoot:=DomDoc.selectSingleNode('Doc3DCrade');
 if XmlRoot=nil then
  raise Exception.Create('TDrawer3D::LoadFromXml:This is not a Doc3DCrade file');

 XmlObject:=XmlRoot.selectSingleNode('Parameters');
 XMLAttrib := XmlObject.attributes.getNamedItem ('rhoeye');
 fRhoeye:=strtofloat(XmlAttrib.Text);
 Context.SetFloatValue('_Rhoeye',fRhoeye);

 XMLAttrib := XmlObject.attributes.getNamedItem ('colatiteye');
 fColatiteye:=strtofloat(XmlAttrib.Text);
 Context.SetFloatValue('_Colatiteye',fColatiteye);

 XMLAttrib := XmlObject.attributes.getNamedItem ('azimutheye');
 fazimutheye:=strtofloat(XmlAttrib.Text);
 context.SetFloatValue('_Azimutheye',fazimutheye);

 XMLAttrib := XmlObject.attributes.getNamedItem ('zeye');
 fZeye:=strtofloat(XmlAttrib.Text);
 Context.SetFloatValue('_Zeye',fZeye);

 XMLAttrib := XmlObject.attributes.getNamedItem ('scale');
 fscale:=strtofloat(XmlAttrib.Text);
 Context.SetFloatValue('_Scale',fScale);


 XmlObject:=XmlRoot.selectSingleNode('Objects');

 XmlObjectList:=XmlObject.selectNodes('Points3D/*');
 if XmlObjectList.Length>0 then begin
   for i:=0 to XmlObjectList.Length-1 do
   begin
    Point3D:=fPoint3DList.Add as TPoint3D;
    Point3D.SetXMLNode(DomDoc,XmlObjectList.Item[i]);
   end;
 end;
 XmlObjectList:=XmlObject.selectNodes('Lines3D/*');
 if XmlObjectList.Length>0 then begin
   for i:=0 to XmlObjectList.Length-1 do
   begin
    Line3D:=fLine3DList.Add as TLine3D;
    Line3D.SetXMLNode(DomDoc,XmlObjectList.Item[i]);
   end;
 end;
 XmlObjectList:=XmlObject.selectNodes('Frames3D/*');
 if XmlObjectList.Length>0 then begin
   for i:=0 to XmlObjectList.Length-1 do
   begin
    Frame3D:=fFrame3DList.Add as TFrame3D;
    Frame3D.SetXMLNode(DomDoc,XmlObjectList.Item[i]);
   end;
 end;
 XmlObjectList:=XmlObject.selectNodes('MayeSurfaces3D/*');
 if XmlObjectList.Length>0 then begin
   for i:=0 to XmlObjectList.Length-1 do
   begin
    MayeSurface3D:=fMayeSurface3DList.Add as TMayeSurface3D;
    MayeSurface3D.SetXMLNode(DomDoc,XmlObjectList.Item[i]);
   end;
 end;

 XmlObjectList:=XmlObject.selectNodes('Scenes3D/*');
 if XmlObjectList.Length>0 then begin
   for i:=0 to XmlObjectList.Length-1 do
   begin
    Scene3D:=fScene3DList.Add as TScene3D;
    Scene3D.SetXMLNode(DomDoc,XmlObjectList.Item[i]);
   end;
 end;

 XmlObject:=XmlObject.selectsingleNode('Scenes3DRef/*');
 fTree3D.SetXMLNode(DomDoc,XmlObject);

 // Set the parent of all the childs
 for i:=0 to fScene3DList.Count -1 do begin
  for j:=0 to (fScene3DList.Items[i] as TScene3D).fPoint3DRefList.Count -1 do
   ((fScene3DList.Items[i] as TScene3D).fPoint3DRefList.Items[j] as TObject3DRef).Value.fparent:=(fScene3DList.Items[i] as TScene3D);
  for j:=0 to (fScene3DList.Items[i] as TScene3D).fLine3DRefList.Count -1 do
   ((fScene3DList.Items[i] as TScene3D).fLine3DRefList.Items[j] as TObject3DRef).Value.fparent:=(fScene3DList.Items[i] as TScene3D);
  for j:=0 to (fScene3DList.Items[i] as TScene3D).fFrame3DRefList.Count -1 do
   ((fScene3DList.Items[i] as TScene3D).fFrame3DRefList.Items[j] as TObject3DRef).Value.fparent:=(fScene3DList.Items[i] as TScene3D);
  for j:=0 to (fScene3DList.Items[i] as TScene3D).fMayeSurface3DRefList.Count -1 do
  begin
   MayeSurface3D:=((fScene3DList.Items[i] as TScene3D).fMayeSurface3DRefList.Items[j] as TObject3DRef).Value as TMayeSurface3D;
   MayeSurface3D.fparent:=(fScene3DList.Items[i] as TScene3D);
   for k:=0 to MayeSurface3D.fMayeTriFace3DList.Count -1 do
    (MayeSurface3D.fMayeTriFace3DList.Items[k] as TMayeTriface3D).fParent:=(fScene3DList.Items[i] as TScene3D);
  end;
 end;
 // Rends ses marques
 fMainScene3D:=fScene3DList.Items[0] as TScene3D;
 fMainScene3DRef:=fTree3D.fRefNodeList.Items[0] as TTreeItemRef;
 fCurrentScene3D:=fMainScene3D;
 fCurrentScene3DRef:=fMainScene3DRef;

 result:=0;
end;



{ TMayeTriFace3D }


procedure TMayeTriFace3D.Clone(ThisObject: TObject3D);
var i:integer; ref:TMayeEdge;
begin
  inherited;
  fMayeEdgeList.Clear;
  for i:=0 to (ThisObject as TMayeTriFace3D).fMayeEdgeList.count -1 do
  begin
   ref:=fMayeEdgeList.add as TMayeEdge;
   ref.clone( (ThisObject as TMayeTriFace3D).fMayeEdgeList.Items[i] as TMayeEdge);
  end;
end;

constructor TMayeTriFace3D.create(Collection: TCollection);
begin
  inherited;
  fMayeEdgeList:=TMayeEdgeList.create(self);
end;

destructor TMayeTriFace3D.destroy;
begin
  fDrawer3D.fRefMayeTriFace3DList.Delete(Self);
  fMayeEdgeList.Free;
  inherited;

end;

{ TMayeSueface3DList }

function TMayeSurface3DList.AddNewObject3D: TObject3D;
begin
 result := add as TObject3D;
end;

constructor TMayeSurface3DList.create(Drawer3D:TDrawer3D);
begin
  inherited create(Drawer3D,TMayeSurface3D);
end;

procedure TMayeTriFace3D.DrawObject;
var e:TMayeEdge; ap:array of TPoint;  oc:Tcolor;
//cPen:Tpen;

procedure SortArray();
var PtList:TPoint2DList; _i:integer; pt:TPoint2D;str:string;
begin
 str:='';
  PtList:=TPoint2DList.Create;
  for _i:=0 to 3 do
  begin
   pt:=PtList.Add as TPoint2D;
   pt.x:=ap[_i].x;
   pt.y:=ap[_i].y;
  end;
  OrderFourPointsList(pTList);
  for _i:=0 to 3 do begin
   ap[_i].x:=(ptList.Items[_i] as TPoint2D).x;
   ap[_i].y:=(ptList.Items[_i] as TPoint2D).y;
//   str:=str+'(x('+inttostr(_i)+')='+inttostr(ap[_i].x)+';y('+inttostr(_i)+')='+inttostr(ap[_i].y)+#13#10;
  end;
//  showmessage(str);
  PtList.Free;
end;
begin
 inherited;
 if not Hide then begin
  SetLength(ap,4);
  if fMayeEdgeList.Count>=2 then begin
   e:=fMayeEdgeList.Items[0] as TMayeEdge;
  // Convertir les Coordonnée en 3D-> 2D

   fDrawer3D.Projection2D(e.x,e.y,e.z,ap[0].x,ap[0].y);
   e:=fMayeEdgeList.Items[1] as TMayeEdge;
   fDrawer3D.Projection2D(e.x,e.y,e.Z,ap[1].x,ap[1].y);

   if fMayeEdgeList.count=2 then begin
    fDrawer3D.fCanvas.MoveTo(ap[0].x,ap[0].y);
    fDrawer3D.fCanvas.LineTo(ap[1].x,ap[1].y);
   end else
   if fMayeEdgeList.COunt>=3 then begin
    e:=fMayeEdgeList.Items[2] as TMayeEdge;
    fDrawer3D.Projection2D(e.x,e.y,e.z,ap[2].x,ap[2].y);
    // TODO:Change the polyline to polygon
   // fDrawer3D.fCanvas.Polygon(ap);
    if fMayeEdgeList.count=3 then
    begin
     oc:=fDrawer3D.fcanvas.Brush.color;
     fDrawer3D.fcanvas.Brush.Color:=fDrawer3D.getLookupColor(Color);
     if nTransparent=1 then
      fDrawer3D.fCanvas.Polyline(ap) else
       fDrawer3D.fCanvas.Polygon(ap);
     fDrawer3D.fcanvas.Brush.Color:=oc;
    end;
   end;
   if fMayeEdgeList.Count=4 then begin

    e:=fMayeEdgeList.Items[3] as TMayeEdge;
    fDrawer3D.Projection2D(e.x,e.y,e.z,ap[3].x,ap[3].y);
    // Trier le tableau par ordre de x,y
    SortArray;
    oc:=fDrawer3D.fcanvas.Brush.color;
    fDrawer3D.fcanvas.Brush.Color:=fDrawer3D.getLookupColor(Color);
    if nTransparent=1 then
     fDrawer3D.fcanvas.Polyline(ap) else
      fDrawer3D.fCanvas.Polygon(ap);
   // fDrawer3D.fCanvas.Polyline(ap);
     fDrawer3D.fcanvas.Brush.Color:=oc;
   end;
  end;

  SetLength(ap,0);
 end;

  Drawer3D.fCanvas.Pen.Color:=foColor;
  Drawer3D.fCanvas.Pen.Style:=foPenStyle;
end;

procedure TMayeTriFace3D.GetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode);
var XmlObject,XmlObject2,XmlObject3,XmlAttrib:IXmlDomNode; i:integer;
    MayeEdge:TMayeEdge;
begin
   XmlObject:=DomDoc.createElement('MayeTriFace3D');
   XmlObjectList.AppendChild(XmlObject);
   XmlObject.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

   inherited GetXmlNode(DomDoc,XmlObject);

   XmlObject2:=DomDoc.createElement('Edges');
   XmlObject.appendChild(XmlObject2);
   XmlObject2.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

   for i:=0 to fMayeEdgeList.count -1 do begin
    MayeEdge:=fMayeEdgeList.Items[i] as TMayeEdge;
    XmlObject3:=DomDoc.CreateElement('Edge');
    XmlObject2.appendChild(XmlObject3);
    XmlObject3.appendChild(DomDoc.CreateTextNode(chr(13)+chr(10)));
    XmlAttrib:=DomDoc.CreateAttribute('x');
    XmlAttrib.Text:=floattostr(MayeEdge.x);
    XmlObject3.attributes.setNamedItem(XmlAttrib);
    XmlAttrib:=DomDoc.CreateAttribute('y');
    XmlAttrib.Text:=floattostr(MayeEdge.y);
    XmlObject3.attributes.setNamedItem(XmlAttrib);
    XmlAttrib:=DomDoc.CreateAttribute('z');
    XmlAttrib.Text:=floattostr(MayeEdge.z);
    XmlObject3.attributes.setNamedItem(XmlAttrib);
   end;
end;

function TMayeTriFace3D.getZMin(Drawer:TDrawer3D): extended;
var i:integer;    x,y,z:extended;
begin
{ result:=0;
 if fMayeEdgeList.Count>0 then begin
  result:=(fMayeEdgeList.Items[0] as TMayeEdge).z;
  for i:=1 to fMayeEdgeList.Count -1 do
  begin

   if (fMayeEdgeList.Items[i] as TMayeEdge).z<result then
    result:=(fMayeEdgeList.Items[i] as TMayeEdge).z;
  end;
 end;
}
  result:=0;
  if fMayeEdgeList.Count>0 then begin
   for i:=0 to fMayeEdgeList.Count -1 do begin
     Drawer.GetVectorEye((fMayeEdgeList.Items[i] as TMayeEdge).x,(fMayeEdgeList.Items[i] as TMayeEdge).y,(fMayeEdgeList.Items[i] as TMayeEdge).z,x,y,z);
  //   z:=(fMayeEdgeList.Items[i] as TMayeEdge).x;
     result:=result+z;
   end;
   result:=result / fMayeEdgeList.Count
  end;

end;

procedure TMayeTriFace3D.Rotate(const dteta, dphi: extended);
var i:integer;rho,teta,phi:extended;
begin
  inherited;
  for i:=0 to fMayeEdgeList.count -1 do
  begin

   topolar((fMayeEdgeList.Items[i] as TMayeEdge).x,(fMayeEdgeList.Items[i] as TMayeEdge).y,(fMayeEdgeList.Items[i] as TMayeEdge).z,rho,teta,phi);
   teta:=teta+dteta;
   phi:=phi+dphi;
   tocartesian(rho,teta,phi,(fMayeEdgeList.Items[i] as TMayeEdge).x,(fMayeEdgeList.Items[i] as TMayeEdge).y,(fMayeEdgeList.Items[i] as TMayeEdge).z);
  end;
end;

procedure TMayeTriFace3D.RotateX(const dteta: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fMayeEdgeList.count -1 do
   Rotate3DX(dteta,(fMayeEdgeList.Items[i] as TMayeEdge).x,(fMayeEdgeList.Items[i] as TMayeEdge).y,(fMayeEdgeList.Items[i] as TMayeEdge).z);

end;

procedure TMayeTriFace3D.RotateY(const dteta: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fMayeEdgeList.count -1 do
   Rotate3DY(dteta,(fMayeEdgeList.Items[i] as TMayeEdge).x,(fMayeEdgeList.Items[i] as TMayeEdge).y,(fMayeEdgeList.Items[i] as TMayeEdge).z);

end;

procedure TMayeTriFace3D.RotateZ(const dphi: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fMayeEdgeList.count -1 do
   Rotate3DZ(dphi,(fMayeEdgeList.Items[i] as TMayeEdge).x,(fMayeEdgeList.Items[i] as TMayeEdge).y,(fMayeEdgeList.Items[i] as TMayeEdge).z);

end;

procedure TMayeTriFace3D.SetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode);
var XmlAttrib:IXmlDomNode;
    XmlObjectList2: IXmlDomNodeList;
    i : integer;
    Edge : TMayeEdge;
begin
  inherited SetXmlNode(DomDoc,XmlObjectList);

  XmlObjectList2:=XMLObjectList.selectNodes('Edges/*'); // Edges collection
  for i:=0 to XmlObjectList2.length -1 do  // Edge
   begin
    Edge:=fMayeEdgeList.add as TMayeEdge;
    XMLAttrib := XmlObjectList2.item[i].attributes.getNamedItem ('x');
    if XmlAttrib<>nil then
     Edge.x:=strtofloat(XmlAttrib.text);
    XMLAttrib := XmlObjectList2.item[i].attributes.getNamedItem ('y');
    if XmlAttrib<>nil then
     Edge.y:=strtofloat(XmlAttrib.text);
    XMLAttrib := XmlObjectList2.item[i].attributes.getNamedItem ('z');
    if XmlAttrib<>nil then
     Edge.z:=strtofloat(XmlAttrib.text);
   end;
end;

procedure TMayeTriFace3D.Translate(cx, cy, cz: extended);
var i:integer; ref:TMayeEdge;
begin
  inherited;
  for i:=0 to fMayeEdgeList.count -1 do
  begin
   ref:=fMayeEdgeList.Items[i] as TMayeEdge;
   ref.x:=ref.x+cx;
   ref.y:=ref.y+cy;
   ref.z:=ref.z+cz;
  end;
end;

{ TMayeEdge }

procedure TMayeEdge.clone(ThisObject: TMayeEdge);
begin
 x:=ThisObject.x;
 y:=THisObject.y;
 z:=ThisObject.z;
end;

constructor TMayeEdge.create(Collection: TCollection);
begin
  inherited;

end;

{ TMayeEdgeList }


constructor TMayeEdgeList.create(owner: TMayeTriFace3D);
begin
 fOwner:=owner;
 inherited create(TMayeEdge);
end;

function TMayeEdgeList.getEdge(ind: integer): TMayeEdge;
begin
 result:=Items[ind] as TMayeEdge;
end;

procedure TMayeEdgeList.setEdge(ind: integer; const Value: TMayeEdge);
begin
 Items[ind]:=Value;
end;

{ TMayeTriFace3DList }


function TMayeTriFace3DList.Add: TCollectionItem;

begin
 result:=inherited Add;
 fDrawer3D.fRefMayeTriFace3DList.AddRef((result as TMayeTriFace3D));
end;

function TMayeTriFace3DList.AddNewObject3D: TObject3D;
begin
 result:=add as TObject3D;
end;

constructor TMayeTriFace3DList.create(owner: TMayeSurface3D;Drawer3D:TDrawer3D);
begin
 fOwner:=owner;
 inherited create(Drawer3D,TMayeTriFace3D);
end;

function TMayeTriFace3DList.getMayeTriFace3D(ind: integer): TMayeTriFace3D;
begin
 result:=Items[ind] as TMayeTriFace3D;
end;

procedure TMayeTriFace3DList.SetMayeTriFace3D(ind: integer;
  const Value: TMayeTriFace3D);
begin
 Items[ind]:=Value;
end;

{ TMayeSurface3D }


procedure TMayeSurface3D.Clear;
begin
 nTransparent:=0;
 nLong:=0;
 nLat:=0;
 fMayeTriFace3DList.Clear;
end;

procedure TMayeSurface3D.Clone(ThisObject: TObject3D);
var i:integer;ref:TMayeTriFace3D;
begin
  inherited;
  nTransparent:=(ThisObject as TMayeSurface3D).nTransparent;
  nLong:=(ThisObject as TMayeSurface3D).nLong;
  nLat:=(ThisObject as TMayeSurface3D).nLat;
  fMayeTriFace3DList.Clear;
  for i:=0 to (ThisObject as TMayeSurface3D).fMayeTriFace3DList.Count -1 do begin
   ref:=fMayeTriFace3DList.add as TMayeTriFace3D;
   ref.Clone((ThisObject as TMayeSurface3D).fMayeTriFace3DList.Items[i] as TMayeTriFace3D);
  end;
end;

constructor TMayeSurface3D.create(Collection: TCollection);
begin
  inherited;
  nLong:=0; nLat:=0;
  nTransparent:=0;
  fMayeTriFace3DList:=TMayeTriFace3DList.create(Self,(Collection as TObject3DList).fDrawer3D);
end;

destructor TMayeSurface3D.destroy;
begin
  fMayeTriFace3DList.Free;
  inherited;

end;

procedure TMayeSurface3D.DrawObject;
begin
  inherited;

end;

procedure TMayeSurface3D.GetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode);
var XmlObject,XmlAttrib,XmlObject2:IXmlDomNode;
    i:integer;
begin
   XmlObject:=DomDoc.createElement('MayeSurface3D');
   XmlObjectList.AppendChild(XmlObject);
   XmlObject.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

   inherited GetXmlNode(DomDoc,XmlObject);

   XmlAttrib:=DomDoc.CreateAttribute('nLong');
   XmlAttrib.Text:=inttostr(nLong);
   XmlObject.attributes.setNamedItem(XmlAttrib);

   XmlAttrib:=DomDoc.CreateAttribute('nLat');
   XmlAttrib.Text:=inttostr(nLat);
   XmlObject.attributes.setNamedItem(XmlAttrib);

   XmlAttrib:=DomDoc.CreateAttribute('Transparent');
   XmlAttrib.Text:=inttostr(nTransparent);
   XmlObject.attributes.setNamedItem(XmlAttrib);

   XmlObject2:=DomDoc.createElement('MayeTriFaces3D');
   XmlObject.appendChild(XmlObject2);

   for i:=0 to FmayeTriFace3DList.Count -1 do
    (FmayeTriFace3DList.Items[i] as TMayeTriFace3D).GetXmlNode(DomDoc,XmlObject2);
end;

procedure TMayeSurface3D.Rotate(const dteta, dphi: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fMayeTriFace3Dlist.count -1 do begin
   (fMayeTriFace3DList.Items[i] as TMayeTriFace3D).Rotate(dteta,dphi);
  end;
end;

procedure TMayeSurface3D.RotateX(const dteta: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fMayeTriFace3Dlist.count -1 do
   (fMayeTriFace3DList.Items[i] as TMayeTriFace3D).RotateX(dteta);

end;

procedure TMayeSurface3D.RotateY(const dteta: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fMayeTriFace3Dlist.count -1 do
   (fMayeTriFace3DList.Items[i] as TMayeTriFace3D).RotateY(dteta);

end;

procedure TMayeSurface3D.RotateZ(const dphi: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fMayeTriFace3Dlist.count -1 do
   (fMayeTriFace3DList.Items[i] as TMayeTriFace3D).RotateZ(dphi);

end;

procedure TMayeSurface3D.SetHide;
var i:integer;
begin
 for i:=0 to fMayeTriFace3DList.Count -1 do
  (fMayeTriFace3DList.items[i] as TObject3D).Hide:=true;
end;

procedure TMayeSurface3D.SetUnHide;
var i:integer;
begin
 for i:=0 to fMayeTriFace3DList.Count -1 do
  (fMayeTriFace3DList.items[i] as TObject3D).Hide:=false;
end;

procedure TMayeSurface3D.SetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode);
var XmlAttrib:IXmlDomNode;
    XmlObjectList2 : IXmlDomNodeList;
    i : integer;
    MayeTriFace3D : TMayeTriFace3D;
begin
  nLong:=0; nLat:=0;
  inherited SetXmlNode(DomDoc,XmlObjectList);

  XMLAttrib := XmlObjectList.attributes.getNamedItem ('nLong');
  if XmlAttrib<>nil then
  nLong:=strtoint(XmlAttrib.text);

  XMLAttrib := XmlObjectList.attributes.getNamedItem ('nLat');
  if XmlAttrib<>nil then
  nLat:=strtoint(XmlAttrib.text);

  XMLAttrib := XmlObjectList.attributes.getNamedItem ('Transparent');
  if XmlAttrib<>nil then
  nTransparent:=strtoint(XmlAttrib.text);

  XmlObjectList2:=XMLObjectList.selectNodes('MayeTriFaces3D/*');
  for i:=0 to XmlObjectList2.length -1 do begin
   MayeTriFace3D:=fMayeTriFace3DList.Add as TMayeTriFace3D;
   MayeTriFace3D.SetXMLNode(DomDoc,XmlObjectList2.Item[i]);
  end;

end;

{ TRefMyTriFace3DList }

procedure TRefMayeTriFace3DList.AddRef(ref: TMayeTriFace3D);
begin
 Inc(Count);
 SetLength(fRefArray,Count);
 fRefArray[Count-1]:=ref;
end;

procedure TRefMayeTriFace3DList.CalcZMoy(Drawer: TDrawer3D);
var i:integer;
begin
 for i:=0 to Count -1 do
  frefarray[i].Zmoy:=frefArray[i].getZMin(Drawer);
end;

procedure TRefMayeTriFace3DList.clear;
begin
 SetLength(fRefArray,0);
end;

constructor TRefMayeTriFace3DList.create;
begin
 Count:=0;
 SetLength(fRefArray,0);
end;

procedure TRefMayeTriFace3DList.Delete(ref: TMayeTriFace3D);
var i,j:integer;
begin
 for i:=0 to Count-1 do
 begin
  if fRefArray[i]=ref then begin
    for j:=i+1 to Count -1 do
     fRefArray[j-1]:=fRefArray[j];
    Count:=Count -1;
    break;
  end;
 end;
end;

destructor TRefMayeTriFace3DList.destroy;
begin
  SetLength(fRefArray,0);
  inherited;

end;

function TRefMayeTriFace3DList.GetRef(i: integer): TMayeTriFace3D;
begin
  result:=nil;
  if i<count then
   result:=fRefArray[i];
end;

procedure TRefMayeTriFace3DList.SetRef(i: integer;
  MayeTriFaceRef: TMayeTriFace3D);
begin
  if i<count then
   fRefArray[i]:=MayeTriFaceRef;

end;

procedure TRefMayeTriFace3DList.SortByZ;
var i,j:integer;
 procedure swap(_i,_j:integer);
 var MayeTriFace3DRef:TMayeTriFace3D;
 begin
  MayeTriFace3DRef:=Items[_i];
  Items[_i]:=Items[_j];
  Items[_j]:=MayeTriFace3DRef;
 end;
begin
 // TODO:Implement this VIP (very important procedure)
 for i:=0 to count -2 do
  for j:=i+1 to count -1  do begin
   if Items[j].Zmoy>=Items[i].Zmoy then
    swap(j,i);
  end;


end;

function TDrawer3D.GetTypeObject3D(sType: string): integer;
begin
 result:=0;
 if comparetext(sType,'_default')=0 then
  result:=DRAWTYPE_DEFAULT;
 if comparetext(sType,'_thin')=0 then
  result:=DRAWTYPE_THIN;
  if comparetext(sType,'_solid')=0 then
   result:=DRAWTYPE_SOLID;
 // TODO: Add the several types of line

end;

function TDrawer3D.getLookupColor(c: integer): TColor;
begin
 case c of
  0 : result:=RGB(255,255,255);
  1 : result:=RGB(255,0,0);
  2 : result:=RGB(0,255,0);
  3 : result:=RGB(0,0,255);
  4 : result:=RGB(255,255,0);
  5 : result:=RGB(255,0,255);
  6 : result:=RGB(0,255,0);
  7 : result:=RGB(0,255,255);
  8 : result:=RGB(0,0,0);
  9 : result:=RGB(24,24,24);
  10 : result:=RGB(48,48,48);
  11 : result:=RGB(96,96,96);
  12 : result:=RGB(128,128,128);
  13 : result:=RGB(144,144,144);
  14 : result:=RGB(192,192,192);
  15 : result:=RGB(216,216,216);
  else
   result:=RGB(0,0,0);
 end;
end;

procedure TMayeSurface3D.Translate(cx, cy, cz: extended);
var i:integer;
begin
  inherited;
  for i:=0 to fMayeTriFace3DList.Count -1 do
   (fMayeTriFace3DList.Items[i] as TMayeTriFace3D).Translate(cx,cy,cz);

end;

function TDrawer3D.GetScene3D(sKeyName: string): TScene3D;
var i:integer;
begin
//  result:=fTree3D.GetScene3DRef(sKeyName,true,nil).Value as TScene3D;
 result:=nil;
 for i:=0 to fScene3DList.Count -1 do
 begin
  if (fScene3DList.Items[i] as TObject3D).KeyName=sKeyName then begin
   result:=fScene3DList.items[i] as TScene3D;
   break;
  end;
 end;
end;

function TDrawer3D.GetObject3D(sKeyName: string): TObject3D;
var i:integer; bFound:boolean;
begin
 result:=nil;
 bFound:=false;
 //result:=fTree3D.GetObject3DRef(SKeyName,true,nil).Value as TObject3D;
 for i:=0 to fPoint3DList.count -1 do
 begin
  if (fPoint3DList.Items[i] as TObject3D).Keyname=sKeyname then
  begin
   result:=fPoint3DList.items[i] as TObject3D;
   bFound:=true;
   break;
  end;
 end;
 if bFound then exit;
 for i:=0 to fLine3DList.count -1 do
 begin
  if (fLine3DList.Items[i] as TObject3D).Keyname=sKeyname then
  begin
   result:=fLine3DList.items[i] as TObject3D;
   bFound:=true;
   break;
  end;
 end;
 if bFound then exit;
 for i:=0 to fFrame3DList.count -1 do
 begin
  if (fFrame3DList.Items[i] as TObject3D).Keyname=sKeyname then
  begin
   result:=fFrame3DList.items[i] as TObject3D;
   bFound:=true;
   break;
  end;
 end;
 if bFound then exit;
 for i:=0 to fMayeSurface3DList.count -1 do
 begin
  if (fMayeSurface3DList.Items[i] as TObject3D).Keyname=sKeyname then
  begin
   result:=fMayeSurface3DList.items[i] as TObject3D;
   bFound:=true;
   break;
  end;
 end;

end;

procedure TMayeSurface3DList.DeleteByRef(object3D: Tobject3D);
var i,ind:integer;
begin
 // trouver l'objet

 ind:=-1;
 for i:=0 to count-1 do

  if object3D.keyname=(Items[i] as TObject3D).KeyName then
  begin
   ind:=i;
   break;
  end;
 if ind<>-1 then
 begin
 // trouver les mayetriface correspondants dans la ref list

  for i:=0 to (Items[ind] as TMayeSurface3D).fMayeTriface3Dlist.Count -1 do
 // deleter les mayetriface dans la reflist
   fDrawer3D.fRefMayeTriFace3DList.Delete( ((Items[ind] as TMayeSurface3D).fMayeTriface3Dlist.Items[i] as TMayeTriface3D));
 // deleter l'objet

  Delete(ind);
 end;
end;

{ TScene3DTree }

constructor TScene3DTree.create(Drawer3D: TDrawer3D;
  Collection: TCollection);
begin
 inherited create(Collection);
 fDrawer3D:=Drawer3D;
end;


function TScene3DTree.RecurGetMayeSurface3DRef(sKeyName:string;bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;
var i:integer;bFound:boolean;
begin
 result:=nil;
 bFound:=false;
 for i:=0 to (parent.Value as TScene3D).fMayeSurface3DRefList.Count -1 do
 begin
   if ((parent.Value as TScene3D).fMayeSurface3DRefList.items[i] as TObject3DRef).value.KeyName=sKeyName then
   begin
    result:=((parent.Value as TScene3D).fMayeSurface3DRefList.items[i] as TObject3DRef) ;
    bFound:=true;
    break;
   end;
 end;
 if (not bFound) and (bRecursif) then begin
  for i:=0 to parent.fChildNodes.count -1 do begin
   result:=RecurGetMayeSurface3DRef(sKeyName,bRecursif,(parent.fchildNodes.items[i] as TTreeItemRef));
   if result<>nil then break;
  end;
 end;


end;
function TScene3DTree.GetMayeSurface3DRef(sKeyname: string;bRecursif:boolean;parent:TTreeItemRef=nil): TObject3DRef;
begin
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;
  result:=RecurGetMayeSurface3DRef(sKeyName,bRecursif,parent);

end;

function TScene3DTree.RecurGetFrame3DRef(sKeyName:string;bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;
var i:integer;bFound:boolean;
begin
 result:=nil;
 bFound:=false;
 for i:=0 to (parent.Value as TScene3D).fFrame3DRefList.Count -1 do
 begin
   if ((parent.Value as TScene3D).fFrame3DRefList.items[i] as TObject3DRef).Value.KeyName=sKeyName then
   begin
    result:=((parent.Value as TScene3D).fFrame3DRefList.items[i] as TObject3DRef);
    bFound:=true;
    break;
   end;
 end;
 if (not bFound) and (bRecursif) then begin
  for i:=0 to parent.fChildNodes.count -1 do begin
   result:=RecurGetFrame3DRef(sKeyName,bRecursif,(parent.fchildNodes.items[i] as TTreeItemRef));
   if result<>nil then break;
  end;
 end;

end;
function TScene3DTree.GetFrame3DRef(sKeyName:string;bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;
begin
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;
  result:=RecurGetFrame3DRef(sKeyName,bRecursif,parent);

end;

function TScene3DTree.RecurGetLine3DRef(sKeyName:string;bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;
var i:integer;bFound:boolean;
begin
 result:=nil;
 bFound:=false;
 for i:=0 to (parent.Value as TScene3D).fLine3DRefList.Count -1 do
 begin
   if ((parent.Value as TScene3D).fLine3DRefList.items[i] as TObject3DRef).Value.KeyName=sKeyName then
   begin
    result:=((parent.Value as TScene3D).fLine3DRefList.items[i] as TObject3DRef);
    bFound:=true;
    break;
   end;
 end;
 if (not bFound) and (bRecursif) then begin
  for i:=0 to parent.fChildNodes.count -1 do begin
   result:=RecurGetLine3DRef(sKeyName,bRecursif,(parent.fchildNodes.items[i] as TTreeItemRef));
   if result<>nil then break;
  end;
 end;

end;

function TScene3DTree.GetLine3DRef(sKeyName:string;bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;
begin
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;
  result:=RecurGetLine3DRef(sKeyName,bRecursif,parent);

end;

function TScene3DTree.RecurGetPoint3DRef(sKeyname:string;bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;
var i:integer;bFound:boolean;
begin
 result:=nil;
 bFound:=false;
 for i:=0 to (parent.Value as TScene3D).fPoint3DRefList.Count -1 do
 begin
   if ((parent.Value as TScene3D).fPoint3DRefList.items[i] as TObject3DRef).Value.KeyName=sKeyName then
   begin
    result:=((parent.Value as TScene3D).fPoint3DRefList.items[i] as TObject3DRef);
    bFound:=true;
    break;
   end;
 end;
 if (not bFound) and (bRecursif) then begin
  for i:=0 to parent.fChildNodes.count -1 do begin
   result:=RecurGetPoint3DRef(sKeyName,bRecursif,(parent.fchildNodes.items[i] as TTreeItemRef));
   if result<>nil then break;
  end;
 end;
end;

function TScene3DTree.GetPoint3DRef(sKeyname: string;bRecursif:boolean;parent:TTreeItemRef=nil): TObject3DRef;
begin
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;
  result:=RecurGetPoint3DRef(sKeyName,bRecursif,parent);

end;

function TScene3DTree.RecurGetScene3DRef(sKeyname: string;bRecursif:boolean;parent:TTreeItemRef): TTreeItemRef;
var i:integer;
begin
 result:=nil;
 if (parent.Value as TScene3D).keyName=sKeyName then
  result:=parent

 else
 begin
  if bRecursif then begin
   for i:=0 to parent.fChildNodes.Count -1 do
   begin
    result:=RecurGetScene3DRef(sKeyName,bRecursif,parent.fChildNodes.Items[i] as TTreeItemRef);
    if result<>nil then
     break;
   end;
  end;
 end;
end;

function TScene3DTree.GetScene3DRef(sKeyname: string;bRecursif:boolean;parent:TTreeItemRef=nil): TTreeItemRef;
begin
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;
  result:=RecurGetScene3DRef(sKeyName,bRecursif,parent);
end;



function TScene3DTree.RecurGetObject3DRef(sKeyName:string;bRecursif:boolean;parent:TTreeItemRef):TObject3DRef;
var i:integer;bFound:boolean;
begin
 result:=nil;
 bFound:=false;
 if (parent.value as TScene3D).keyname=sKeyName then
 begin
  Raise Exception.Create('TScene3DTree:RecurGetObject3DRef is unable to retrieve a scene reference object.');
 end else
 begin
  for i:=0 to (parent.Value as TScene3D).fPoint3DRefList.Count -1 do
  begin
   if ((parent.Value as TScene3D).fPoint3DRefList.items[i] as TObject3DRef).Value.KeyName=sKeyName then
   begin
    result:=((parent.Value as TScene3D).fPoint3DRefList.items[i] as TObject3DRef) ;
    bFound:=true;
    break;
   end;
  end;
// line
  if not bfound then begin
   for i:=0 to (parent.Value as TScene3D).fLine3DRefList.Count -1 do
   begin
    if ((parent.Value as TScene3D).fLine3DRefList.items[i] as TObject3DRef).Value.KeyName=sKeyName then
    begin
     result:=((parent.Value as TScene3D).fLine3DRefList.items[i] as TObject3DRef) ;
     bFound:=true;
     break;
    end;
   end;
  end;
// frame
  if not bfound then begin
   for i:=0 to (parent.Value as TScene3D).fFrame3DRefList.Count -1 do
   begin
    if ((parent.Value as TScene3D).fFrame3DRefList.items[i] as TObject3DRef).Value.KeyName=sKeyName then
    begin
     result:=((parent.Value as TScene3D).fFrame3DRefList.items[i] as TObject3DRef) ;
     bFound:=true;
     break;
    end;
   end;
  end;
// Maye surface
  if not bfound then begin
   for i:=0 to (parent.Value as TScene3D).fMayeSurface3DRefList.Count -1 do
   begin
    if ((parent.Value as TScene3D).fMayeSurface3DRefList.items[i] as TObject3DRef).Value.KeyName=sKeyName then
    begin
     result:=((parent.Value as TScene3D).fMayeSurface3DRefList.items[i] as TObject3DRef) ;
     bFound:=true;
     break;
    end;
   end;
  end;
  if (not bfound) and (bRecursif) then
  begin
   for i:=0 to parent.fChildNodes.Count -1 do
   begin
    result:=RecurGetObject3DRef(sKeyName,bRecursif,parent.fChildNodes.Items[i] as TTreeItemRef);
    if result<>nil then break;
   end;
  end;
 end;
end;

function TScene3DTree.GetObject3DRef(sKeyName: string; bRecursif: boolean;
  parent: TTreeItemRef): TObject3DRef;
begin
 result:=nil;
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef; // Take the mainscene

 result:=RecurGetObject3DRef(sKeyname,bRecursif,parent);
end;

procedure TScene3DTree.GetStringItemList(slTreeList:TStringList);
var sIndent:string;Parent:TTreeItemRef;
 procedure RecurGetStringItemList(Parent:TTreeItemRef;slTreeList:TStringList;sIdent : string);
 var sc:TScene3D;i:integer;o3D:TObject3D;
 begin
  sc:=Parent.Value as TScene3D;
  for i:=0 to sc.fPoint3DRefList.Count -1 do
  begin
   o3D:=((sc.fPoint3DRefList.Items[i] as TObject3DRef).Value as TObject3D);
   slTreeList.Add(sIdent+o3D.KeyName);
  end;
  for i:=0 to sc.fLine3DRefList.Count -1 do
  begin
   o3D:=((sc.fLine3DRefList.Items[i] as TObject3DRef).Value as TObject3D);
   slTreeList.Add(sIdent+o3D.KeyName);
  end;
  for i:=0 to sc.fFrame3DRefList.Count -1 do
  begin
   o3D:=((sc.fFrame3DRefList.Items[i] as TObject3DRef).Value as TObject3D);
   slTreeList.Add(sIdent+o3D.KeyName);
  end;
  for i:=0 to sc.fMayeSurface3DRefList.Count -1 do
  begin
   o3D:=((sc.fMayeSurface3DRefList.Items[i] as TObject3DRef).Value as TObject3D);
   slTreeList.Add(sIdent+o3D.KeyName);
  end;
  sIdent:=sIdent+'-';
  for i:=0 to Parent.fChildNodes.count -1 do
  begin
   slTreeList.Add(sIdent+'+'+((Parent.fChildNodes.Items[i] as TTreeItemRef).value as TObject3D).keyname);
   RecurGetStringItemList(Parent.fChildNodes.Items[i] as TTreeItemRef,slTreeList,sIdent);
  end;
 end;
begin
 parent:=fRefNodeList.items[0] as TTreeItemRef;
 slTreeList.Add('+'+(parent.value as TObject3D).keyname);
 sIndent:='-';
 RecurGetStringItemList(Parent,slTreeList,sIndent);
end;

procedure TDrawer3D.DrawObjects;
var i:integer;
sl:TStringlist;// TEST ONLY
begin
  // draw the point list
  for i:=0 to fPoint3DList.count-1 do
   (fPoint3DList.items[i] as TPoint3D).DrawObject;
  for i:=0 to fLine3DList.count-1 do
   (fLine3DList.items[i] as TLine3D).DrawObject;
  for i:=0 to fFrame3DList.count-1 do
   (fFrame3DList.items[i] as TFrame3D).DrawObject;

   // test
   //sl:=TStringList.Create;
 {for i:=0 to fRefMayeTriFace3DList.count -1 do
   sl.add(fRefMayeTriFace3DList.Items[i].Keyname+#9+floattostr(fRefMayeTriFace3DList.Items[i].zMin));
  sl.SaveTofile('c:\before.txt');}
  fRefMayeTriFace3DList.CalcZMoy(self);
  fRefMayeTriface3DList.SortByZ;

{  sl.Clear;
  for i:=0 to fRefMayeTriFace3DList.count -1 do
   sl.add(fRefMayeTriFace3DList.Items[i].Keyname+#9+floattostr(fRefMayeTriFace3DList.Items[i].zMoy));
  sl.SaveTofile('c:\after.txt');
  sl.free;                 }
  // end test
  for i:=0 to fRefMayeTriFace3DList.count-1 do
   fRefMayeTriFace3DList.Items[i].DrawObject;

end;

function TDrawer3D.RemoveAll: boolean;
begin
 fTree3D.RemoveAll;
 fScene3DList.Clear;
 fPoint3DList.Clear;
 fLine3DList.Clear;
 fFrame3DList.Clear;
 fMayeSurface3DList.Clear; //TODO: Check if the fRefMayeTriFace is also cleared otherwise
 fRefMayeTriFace3DList.Clear;
 result:=true;
end;

function TScene3DTree.AddFrame3D(parent: TTreeItemRef): TFrame3D;
begin
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;

 Result:=fDrawer3D.Frame3DList.Add as TFrame3D;
 Result.fparent:=parent.value as TScene3D;
 (Parent.Value as TScene3D).fFrame3DRefList.Add(Result);

end;

function TScene3DTree.AddLine3D(parent: TTreeItemRef): TLine3D;
begin
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;

 Result:=fDrawer3D.Line3DList.Add as TLine3D;
 Result.fparent:=parent.value as TScene3D;
 (Parent.Value as TScene3D).fLine3DRefList.Add(Result);

end;

function TScene3DTree.AddMayeSurface3D(parent: TTreeItemRef): TMayeSurface3D;
begin
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;

 Result:=fDrawer3D.MayeSurface3DList.Add as TMayeSurface3D;
 Result.fparent:=parent.value as TScene3D;
 (Parent.Value as TScene3D).fMayeSurface3DRefList.Add(Result);

end;

function TScene3DTree.AddPoint3D(parent: TTreeItemRef): TPoint3D;
begin
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;

 Result:=fDrawer3D.Point3DList.Add as TPoint3D;
 Result.fparent:=parent.value as TScene3D;
 (Parent.Value as TScene3D).fPoint3DRefList.Add(Result);



end;

function TScene3DTree.AddScene3D(parent: TTreeItemRef): TScene3D;
begin
 if parent=nil then
  parent:=fRefNodeList.Items[0] as TTreeItemRef;

 Result:=fDrawer3D.fScene3DList.Add as TScene3D;
 Result.fparent:=parent.value as TScene3D;
 Parent.pData:=Result;

end;

procedure TScene3DTree.MoveObject3D(sFromScene, sToScene,
  sKeyName: string);
begin

end;

function TScene3DTree.RemoveObject3D(skeyname: string):boolean;
var ItemRef:TTreeItemRef;Object3DRef:TObject3DRef; Data:TObject3D;
    i : integer;
begin
 // TODO:Remove dans le tree
 // check if the object is a Scene
 result:=false;
 ItemRef:=self.GetScene3DRef(sKeyName,true,nil);
 if ItemRef<>nil then  // Delete a scene and all its items

  result:=RecurRemoveScene3D(ItemRef)


 else
 begin
  Object3DRef:=GetObject3DRef(sKeyname,true,nil);
  if Object3DRef<>nil then
   result:=RemoveObject3DRef(Object3DRef);

 end;
 // TODO:remove dans les listes
 // TODO:attention quant on remove une scène, il faut que les parents soient remis à nil!
end;

function TScene3DTree.RecurRemoveScene3D(ItemRef:TTreeItemRef):boolean;
var i:integer;
    Col:TCollection;
begin
 try
  for i:=(ItemRef.Value as TScene3D).fPoint3DRefList.count -1 downto 0  do
   RemoveObject3DRef(((ItemRef.Value as TScene3D).fPoint3DRefList.Items[i] as TObject3DRef));

  for i:=(ItemRef.Value as TScene3D).fLine3DRefList.count -1 downto 0  do
   RemoveObject3DRef(((ItemRef.Value as TScene3D).fLine3DRefList.Items[i] as TObject3DRef));

  for i:=(ItemRef.Value as TScene3D).fFrame3DRefList.count -1 downto 0 do
   RemoveObject3DRef(((ItemRef.Value as TScene3D).fFrame3DRefList.Items[i] as TObject3DRef));

  for i:=(ItemRef.Value as TScene3D).fMayeSurface3DRefList.count -1 downto 0  do
   RemoveObject3DRef(((ItemRef.Value as TScene3D).fMayeSurface3DRefList.Items[i] as TObject3DRef));

  for i:=ItemRef.fChildNodes.Count -1 downto 0 do
   result:=RecurRemoveScene3D(ItemRef.fChildNodes.items[i] as TTreeItemRef);

 // delete the Scene3D itself
  fDrawer3D.DeleteObject3D((ItemRef.Value as TScene3D).Keyname);
  Col:=ItemRef.Collection;
  for i:=0 to Col.Count -1 do
  begin
   if (Col.Items[i] as TTreeItemRef)=ItemRef then
   begin
    Col.Delete(i);
    break;
   end;
  end;
  result:=true;
 except
  result:=false;
 end;
end;
function TScene3DTree.RemoveObject3DRef(Object3DRef:TObject3DRef):boolean;
var Col:TObject3DRefList;
    i : integer;
begin
// delete the object3D in the main object list
 try
 fDrawer3D.DeleteObject3D((Object3DRef.Value as TObject3D).KeyName);
// delete the reference
 Col:=Object3DRef.Collection as TObject3DRefList;
 for i:=Col.Count-1 downto 0 do
 begin
  if Col.items[i]=Object3DRef then
  begin
   Col.Delete(i);
   break;
  end;
 end;
 result:=true;
 except
  result:=false;
 end;
end;
function TDrawer3D.DeleteObject3D(sKeyName: string): boolean;
var i:integer; bDone:boolean;
begin
 bDone:=false;
 result:=true;
 for i:=fPoint3DList.Count -1 downto 0 do
 begin
  if (fPoint3DList.Items[i] as TPoint3D).KeyName=sKeyName then
  begin
   fPoint3DList.Delete(i);
   bDone:=true;
   break;
  end;
 end;
 if bDone then exit;
 for i:=fLine3DList.Count -1 downto 0 do
 begin
  if (fLine3DList.Items[i] as TLine3D).KeyName=sKeyName then
  begin
   fLine3DList.Delete(i);
   bDone:=true;
   break;
  end;
 end;
 if bDone then exit;
 for i:=fFrame3DList.Count -1 downto 0  do
 begin
  if (fFrame3DList.Items[i] as TFrame3D).KeyName=sKeyName then
  begin
   fFrame3DList.Delete(i);
   bDone:=true;
   break;
  end;
 end;
 if bDone then exit;
 for i:=fMayeSurface3DList.Count -1 downto 0  do
 begin
  if (fMayeSurface3DList.Items[i] as TMayeSurface3D).KeyName=sKeyName then
  begin
   fMayeSurface3DList.Delete(i);
   bDone:=true;
   break;
  end;
 end;
 if bDone then exit;
 for i:=fScene3DList.Count -1 downto 0  do
 begin
  if (fScene3DList.Items[i] as TScene3D).KeyName=sKeyName then
  begin
   fScene3DList.Delete(i);
   bDone:=true;
   break;
  end;
 end;

end;

procedure TScene3DTree.MoveScene3D(FromScene3DRef,
  ToScene3DRef: TTreeItemRef; Scene3D: TScene3D);
var i:integer; NewScene3DRef,ParentScene3DRef:TTreeItemRef;
begin
 if FromScene3DRef=ToScene3DRef then
  exit;
 if ToScene3DRef=nil then
  Raise Exception.Create('TScene3DTree::MoveScene3D:The target scene cannot be null');
 NewScene3DRef:=ToScene3DRef.fChildNodes.Add as TTreeItemRef;
 NewScene3DRef.pData:=Scene3D;
 NewScene3DRef.fparentnode:=ToScene3DRef;
 Scene3D.fparent:=ToScene3DRef.value as TScene3D;
 if FromScene3DRef<>nil then begin
  ParentScene3DRef:=FromScene3DRef;
  ParentScene3DRef.FChildNodes.Delete(Scene3D);
 end;
end;

procedure TObject3DRef.GetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode;sNodeName:string);
var XmlObject,XmlAttrib:IXmlDomNode;
begin
  XmlObject:=DomDoc.createElement(sNodeName);
  XmlObjectList.AppendChild(XmlObject);
  XmlObject.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));


  XmlAttrib:=DomDoc.CreateAttribute('Keyname');
  XmlAttrib.Text:=(Value as TObject3D).KeyName;
  XmlObject.attributes.setNamedItem(XmlAttrib);

end;

procedure TObject3DRef.SetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode;Drawer3D:TDrawer3D;Scene3D:TScene3D);
var XmlAttrib:IXmlDomNode;sKeyName:string;
begin
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('Keyname');
 if XmlAttrib<>nil then
 begin
  sKeyname:=XmlAttrib.text;
  fObject3DRef:=Drawer3D.GetObject3D(sKeyName);
  if fObject3DRef<>nil then
   fObject3DRef.fParent:=Scene3D;
 end;
end;

procedure TScene3DTree.RecurGetXmlNode(DomDoc:DomDocument; XmlObjectList:IXmlDomNode;Scene3DRef:TTreeItemRef);
var XmlObject,XmlObject2,XmlAttrib:IXmlDomNode; i:integer; ParentScene3DRef:TTreeItemRef; sParentKeyName:string;
begin
  XmlObject:=DomDoc.createElement('Scene3DRef');
  XmlObjectList.AppendChild(XmlObject);
  XmlObject.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

  XmlAttrib:=DomDoc.CreateAttribute('Keyname');
  XmlAttrib.Text:=(Scene3DRef.Value as TScene3D).KeyName;
  XmlObject.attributes.setNamedItem(XmlAttrib);

 (* XmlAttrib:=DomDoc.CreateAttribute('ParentKeyname');
  ParentScene3DRef:=Scene3DRef.fParentNode;
  if ParentScene3DRef<>nil then
   sParentKeyName:=(ParentScene3DRef.Value as TScene3D).Keyname else
    sParentKeyName:='';
  XmlAttrib.Text:=sParentKeyName;
  XmlObject.attributes.setNamedItem(XmlAttrib);    *)
  XmlObject2:=DomDoc.createElement('Scene3DChildsRef');
  XmlObject.appendChild(XmlObject2);
  for i:=0 to Scene3DRef.fChildNodes.Count -1 do
   RecurGetXmlNode(DomDoc,XmlObject2,Scene3DRef.fChildNodes.Items[i] as TTreeItemRef);
end;
procedure TScene3DTree.GetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode);

begin
 RecurGetXmlNode(DomDoc,XmlObjectList,fDrawer3D.Scene3DRef);
end;
procedure TScene3DTree.RecurSetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode;Scene3DRef,ParentScene3DRef:TTreeItemRef);
var Scene3DChildRef:TTreeItemRef;    XmlAttrib:IXmlDomNode; sKeyName:string;
    XmlObjectList2:IXmlDomNodeList; i:integer;
begin
 XMLAttrib := XmlObjectList.attributes.getNamedItem ('Keyname');
 if XmlAttrib<>nil then
 begin
  sKeyname:=XmlAttrib.text;
  Scene3DRef.pData:=fDrawer3D.GetScene3D(sKeyName);
 end;
 Scene3DRef.fParentNode:=ParentScene3DRef;
 XmlObjectList2:=XMLObjectList.selectNodes('Scene3DChildsRef/*');
 if XmlObjectList2<>nil then begin
  for i:=0 to XmlObjectList2.length -1 do begin
   Scene3DChildRef:=Scene3DRef.fChildNodes.Add as TTreeItemRef;
   RecurSetXmlNode(DomDoc,XmlObjectList2.Item[i],Scene3DChildRef,Scene3DRef);
  end;
 end;
end;

procedure TScene3DTree.SetXMLNode(DomDoc: DomDocument;
  XmlObjectList: IXmlDomNode ; ParentSceneRef : TTreeItemRef=nil);
var MainScene3DRef:TTreeItemRef;
    XmlObjectList2 : IXMLDOmNodeList;   i:integer;
    Scene3DChildRef : TTreeItemRef;
begin
  // recréer la première scène
  if ParentSceneRef=nil then
  begin
   MainScene3DRef:=fRefNodeList.Add as TTreeItemRef;
   RecurSetXmlNode(DomDoc,XmlObjectList,MainScene3DRef,nil);

  end else
  begin
    MainScene3DRef:=ParentSceneRef;
  // appeler la récurrence
   XmlObjectList2:=XmlObjectList.selectNodes('Scene3DChildsRef/*');
   for i:=0 to XmlObjectList2.length -1 do begin
    Scene3DChildRef:=MainScene3DRef.fChildNodes.Add as TTreeItemRef;
    RecurSetXmlNode(DomDoc,XmlObjectList2.Item[i],Scene3DChildRef,MainScene3DRef);
   end;

   //RecurSetXmlNode(DomDoc,XmlObjectList.selectNodes('Scene3DChildsRef/*'),MainScene3DRef,nil);
  end;
end;


function TScene3DTree.AddObject3DRef(ThisObject: TObject3D;
  parent: TTreeItemRef): TObject3DRef;
var Scene3D:TScene3D; NewNode:TTreeItemRef;
begin
 result:=nil;
 if parent=nil then
  parent:=fRefNodeList.items[0] as TTReeItemRef;

 Scene3D:=parent.value as TScene3D;
 // Change the parent object
 if parent<>nil then
  ThisObject.fparent:=parent.value as TScene3D;
 if (ThisObject is TScene3D) then
  // add a new scene
 begin
  NewNode:=parent.fChildNodes.Add as TTreeItemRef;
  NewNode.fParentNode:=parent;
  NewNode.pData:=ThisObject;
 end
 else
 if (ThisObject is TPoint3D) then
  result:=Scene3D.fPoint3DRefList.add(ThisObject) else
   if (ThisObject is TLine3D) then
    result:=Scene3D.fLine3DRefList.add(ThisObject) else
     if (ThisObject is TFrame3D) then
      result:=Scene3D.fFrame3DRefList.Add(ThisObject) else
       if (ThisObject is TMayeSurface3D) then
        result:=Scene3D.fMayeSurface3DRefList.Add(ThisObject);

end;

procedure TScene3DTree.MoveObject3D(FromScene, ToScene: TTreeItemRef;
  Object3D: TObject3D);
var i:integer;ref:TTreeItemRef;
begin

 AddObject3DRef(OBject3D,ToScene);
 (FromScene.value as TScene3D).DeleteRef(Object3D);

end;

function TMayeSurface3DList.getMayeSurface3D(ind: integer): TMayeSurface3D;
begin
 result:=Items[ind] as TMayeSurface3D;
end;

procedure TMayeSurface3DList.SetMayeSurface3D(ind: integer;
  const Value: TMayeSurface3D);
begin
 Items[ind]:=value;
end;

procedure TDrawer3D.SetCurrentScene3D(Scene3D: TScene3D);
begin
 fCurrentScene3D:=Scene3D;
 fCurrentScene3DRef:=fTree3D.GetScene3DRef(scene3D.Keyname,true)
end;

function TDrawer3D.ImportFromXMLFile(const sFileName: string): integer;
var DomDoc:DOMDocument;
    XmlObject:IXmlDomNode;
    XmlObjectList:IXmlDomNodeList;
    XmlRoot:IXmlDomNode;

 //   XmlObject:IXmlDomNode;
 XmlAttrib:IXmlDomNode;
    i,j,k:integer;
    Point3D:TPoint3D; Line3D:TLine3D; Frame3D:TFrame3D; MayeSurface3D:TMayeSurface3D;
    Scene3D:TScene3D;
    MainScene3DRef : TTreeItemRef;

begin
 DomDoc:=CoDomDocument.Create;
 DomDoc.load(sFileName);
 XmlRoot:=DomDoc.selectSingleNode('Doc3DCrade');
 XmlObject:=XmlRoot.selectSingleNode('Objects');

 XmlObjectList:=XmlObject.selectNodes('Points3D/*');
 if XmlObjectList.Length>0 then begin
   for i:=0 to XmlObjectList.Length-1 do
   begin
    Point3D:=fPoint3DList.Add as TPoint3D;
    Point3D.SetXMLNode(DomDoc,XmlObjectList.Item[i]);
   end;
 end;
 XmlObjectList:=XmlObject.selectNodes('Lines3D/*');
 if XmlObjectList.Length>0 then begin
   for i:=0 to XmlObjectList.Length-1 do
   begin
    Line3D:=fLine3DList.Add as TLine3D;
    Line3D.SetXMLNode(DomDoc,XmlObjectList.Item[i]);
   end;
 end;
 XmlObjectList:=XmlObject.selectNodes('Frames3D/*');
 if XmlObjectList.Length>0 then begin
   for i:=0 to XmlObjectList.Length-1 do
   begin
    Frame3D:=fFrame3DList.Add as TFrame3D;
    Frame3D.SetXMLNode(DomDoc,XmlObjectList.Item[i]);
   end;
 end;
 XmlObjectList:=XmlObject.selectNodes('MayeSurfaces3D/*');
 if XmlObjectList.Length>0 then begin
   for i:=0 to XmlObjectList.Length-1 do
   begin
    MayeSurface3D:=fMayeSurface3DList.Add as TMayeSurface3D;
    MayeSurface3D.SetXMLNode(DomDoc,XmlObjectList.Item[i]);
   end;
 end;

 XmlObjectList:=XmlObject.selectNodes('Scenes3D/*');
 if XmlObjectList.Length>0 then begin
   for i:=0 to XmlObjectList.Length-1 do
   begin
    Scene3D:=fScene3DList.Add as TScene3D;
    Scene3D.SetXMLNode(DomDoc,XmlObjectList.Item[i]);
   end;
 end;

 XmlObject:=XmlObject.selectsingleNode('Scenes3DRef/*');
 MainScene3DRef:=fTree3D.GetScene3DRef('MainScene',true,nil);
 fTree3D.SetXMLNode(DomDoc,XmlObject,MainScene3DRef);

 // Set the parent of all the childs
 for i:=0 to fScene3DList.Count -1 do begin
  for j:=0 to (fScene3DList.Items[i] as TScene3D).fPoint3DRefList.Count -1 do
   ((fScene3DList.Items[i] as TScene3D).fPoint3DRefList.Items[j] as TObject3DRef).Value.fparent:=(fScene3DList.Items[i] as TScene3D);
  for j:=0 to (fScene3DList.Items[i] as TScene3D).fLine3DRefList.Count -1 do
   ((fScene3DList.Items[i] as TScene3D).fLine3DRefList.Items[j] as TObject3DRef).Value.fparent:=(fScene3DList.Items[i] as TScene3D);
  for j:=0 to (fScene3DList.Items[i] as TScene3D).fFrame3DRefList.Count -1 do
   ((fScene3DList.Items[i] as TScene3D).fFrame3DRefList.Items[j] as TObject3DRef).Value.fparent:=(fScene3DList.Items[i] as TScene3D);
  for j:=0 to (fScene3DList.Items[i] as TScene3D).fMayeSurface3DRefList.Count -1 do
  begin
   MayeSurface3D:=((fScene3DList.Items[i] as TScene3D).fMayeSurface3DRefList.Items[j] as TObject3DRef).Value as TMayeSurface3D;
   MayeSurface3D.fparent:=(fScene3DList.Items[i] as TScene3D);
   for k:=0 to MayeSurface3D.fMayeTriFace3DList.Count -1 do
    (MayeSurface3D.fMayeTriFace3DList.Items[k] as TMayeTriface3D).fParent:=(fScene3DList.Items[i] as TScene3D);
  end;
 end;
 // Rends ses marques
 fMainScene3D:=fScene3DList.Items[0] as TScene3D;
 fMainScene3DRef:=fTree3D.fRefNodeList.Items[0] as TTreeItemRef;
 fCurrentScene3D:=fMainScene3D;
 fCurrentScene3DRef:=fMainScene3DRef;

 result:=0;

end;

end.


