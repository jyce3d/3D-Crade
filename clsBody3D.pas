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

//Author:Jyce3d, 2005

unit clsBody3D;

interface
uses SysUtils, Scene3D,CustomTree,MayeSurf,math,graphlib, MSXML_TLB;

const
 BODY_COLOR=8;
 BODY_THIN=0;
type
 TManBody3D=class;
 TManTHorax3D=class;
 TWoManTHorax3D=class;

 TWomanBody3D=class;
 TBody3D=class;


 TBlock3D=class

  protected
   fDrawer3D : TDrawer3D;

   //function GetParentoNode: TBlock3D;virtual;

  public
   fScene3D : TScene3D; // reférence sur la scene 3D

   modulez,             // le module hauteur exprimé en mètre, la tête humaine fait 3,5 * le modulez de haut
   modulexy : extended; // le module largeur exprimé en mètre, la tête humaine fait 2,5 * le modulexy

//   fbary_x,
//   fbary_y,
//   fbary_z : extended; // Coordonnées du barycentre du bloc
   fRxphi,
   fRyphi,
   fRzteta   : extended; // Valeur des angles pour la rotation
   fPrefix : string;
   fParentBody:TBody3D;
   fRotule3D : TPoint3D;
   fXPosition, fYPosition, fZPosition : integer;
   fsBlockTypeName: string;
 //  function GetDescendant: TBlock3D;virtual;
    procedure GetXMLBlock(  DomDoc : DomDocument; XmlNode : IXmlDomNode);
    procedure SetXMLBlock(  XmlNode : IXmlDomNode);

   constructor Create(Const sKeyname:string;ParentBody:TBody3D;Drawer3D:TDrawer3D;Parent : TTreeItemRef=nil);virtual;
   destructor Destroy;override;
   function GetScene3DRef : TTreeItemRef;
   procedure BuildBodyPart; virtual;
   procedure SetToOrigin;
   procedure RotateX( const Phi: Extended); // Rotation autours des axes associées de la scène autorisée ou pas à définir dans les classes filles
//   procedure RotateX( const DPhi : Extended; Const bx,by,bz : extended); overload; // Rotation autours d'un autre barycentre donné par l'élément principal
   procedure RotateY (Const Phi : Extended);overload ; // Rotation autours des axes associées de la scène autorisée ou pas à définir dans les classes filles
   //procedure RotateY( const DPhi : Extended; Const bx,by,bz : extended); overload;

   procedure RotateZ (Const teta : Extended); overload;
  published
  // property ParentNode : TBlock3D read GetParentoNode;

 end;
 TBody3D=class(TBlock3D)
  private

      protected
    fRotuleTree : TCustomTree;
    function getHead: TBlock3D;virtual;
    function getArmRight: TBlock3D;virtual;
    function getForeArmRight: TBlock3D;virtual;
    function getHandRight: TBlock3D;virtual;
    function getThorax: TBlock3D;virtual;
    function GetHandLeft: TBlock3D;virtual;
    function getArmLeft: TBlock3D;virtual;
    function getForeArmLeft: TBlock3D;virtual;
    function getFootRight: TBlock3D;virtual;
    function getFootLeft: TBlock3D;virtual;
    function getLegRight: TBlock3D;virtual;
    function getLegLeft: TBlock3D;virtual;
    function getLowerLegRight: TBlock3D;virtual;
    function getLowerLegLeft: TBlock3D;virtual;
    function getPelvis: TBlock3D;virtual;

    procedure RecurCalcBody(Current : TTreeItemRef; xphi,yphi, zteta, rx,ry,rz : extended);
    procedure RecurGenerateBody(Current : TTreeItemRef);
//    procedure RecurResetBody(Current : TTreeItemREf);

    procedure LinkRotules;

   public
      x_factor,
      y_factor,
      z_factor : extended;

    procedure GenerateBody;
    procedure ResetBody;

    constructor Create(Const sKeyname:string;ParentBody:TBody3D;Drawer3D:TDrawer3D;Parent : TTreeItemRef=nil);override;
    destructor destroy;override;
    procedure SaveXMLBody(Const sFileName: string);
    function GetHumanType : string;virtual;
   published
    property Head : TBlock3D read getHead;
    property Thorax: TBlock3D read getThorax;
    property ArmRight : TBlock3D read getArmRight;
    property ArmLeft : TBlock3D read getArmLeft;
    property ForeArmRight : TBlock3D read getForeArmRight;
    property ForeArmLeft : TBlock3D read getForeArmLeft;
    property HandRight : TBlock3D read getHandRight;
    property HandLeft  : TBlock3D read GetHandLeft;

    //
    property Pelvis : TBlock3D read getPelvis;
    property LegRight : TBlock3D read getLegRight;
    property LowerLegRight : TBlock3D read getLowerLegRight;
    property FootRight : TBlock3D read getFootRight;
    property LegLeft : TBlock3D read getLegLeft;
    property LowerLegLeft : TBlock3D read getLowerLegLeft;
    property FootLeft : TBlock3D read getFootLeft;

 end;

 TManHead3D=Class(TBlock3D)
   protected

//    function GetParentoNode: TBlock3D;override;
   public

    fThorax:TManThorax3D;
    radius_eyes : extended; // radius of the eyes by default (1/4) modulexy
    tr_z : extended;
    procedure BuildBodyPart;override;
    constructor Create(Thorax:TManThorax3D;Const sKeyname:string;ParentBody:TBody3D;Drawer3D:TDrawer3D;Parent : TTreeItemRef=nil);reintroduce;

 end;
 TWoManHead3D=Class(TBlock3D)
   protected

//    function GetParentoNode: TBlock3D;override;
   public

    fThorax:TWoManThorax3D;
    radius_eyes : extended; // radius of the eyes by default (1/4) modulexy
    tr_z : extended;
    procedure BuildBodyPart;override;
    constructor Create(Thorax:TWoManThorax3D;Const sKeyname:string;ParentBody:TBody3D;Drawer3D:TDrawer3D;Parent : TTreeItemRef=nil);reintroduce;

 end;

 TManTHorax3D=class(TBlock3D)
  protected
//   function GetParentoNode: TBlock3D;override;

  public
   fBody : TManBody3D;
   // fArm1, fArm2 : TArm3D TODO
   constructor Create(Body : TManBody3D; const sKeyname : string; Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;
   procedure BuildBodyPart;override;
 end;
 TWomanTHorax3D=class(TBlock3D)
  protected
//   function GetParentoNode: TBlock3D;override;

  public
   fBody : TWomanBody3D;
   // fArm1, fArm2 : TArm3D TODO
   constructor Create(Body : TWoManBody3D; const sKeyname : string; Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;
   procedure BuildBodyPart;override;
 end;

 TManArm3D=class(TBlock3D)
 protected
//   function GetParentoNode: TBlock3D;override;
  public
  fTHorax : TManThorax3D;
   procedure BuildBodyPart;override;

  constructor create(Thorax : TManThorax3D ;const sKeyname : string; ParentBody: TBody3D;Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;
 end;
 TWoManArm3D=class(TBlock3D)
 protected
//   function GetParentoNode: TBlock3D;override;
  public
  fTHorax : TWoManThorax3D;
   procedure BuildBodyPart;override;

  constructor create(Thorax : TWoManThorax3D ;const sKeyname : string; ParentBody: TBody3D;Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;
 end;

 TManForeArm3D=class(TBlock3D)
   protected
//   function GetParentoNode: TBlock3D;override;
  public
  fArm : TManArm3D;
  procedure BuildBodyPart;override;
  constructor Create(Arm : TManArm3D;const sKeyname : string; ParentBody:TBody3D;Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;

 end;
 TWoManForeArm3D=class(TBlock3D)
   protected
//   function GetParentoNode: TBlock3D;override;
  public
  fArm : TWoManArm3D;
  procedure BuildBodyPart;override;
  constructor Create(Arm : TWoManArm3D;const sKeyname : string; ParentBody:TBody3D;Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;

 end;

 TManHand3D=class(TBlock3D)
  protected
//   function GetParentoNode: TBlock3D;override;
  public

  fForeArm : TManForeArm3D;
  procedure BuildBodyPart;override;

  constructor create(ForeArm : TManForeArm3D;const sKeyname : string;ParentBody:TBody3D; Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;

 end;
 TWoManHand3D=class(TBlock3D)
  protected
//   function GetParentoNode: TBlock3D;override;
  public

  fForeArm : TWoManForeArm3D;
  procedure BuildBodyPart;override;

  constructor create(ForeArm : TWoManForeArm3D;const sKeyname : string;ParentBody:TBody3D; Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;

 end;

 TManPelvis3D=class(TBlock3D)
  protected
//   function GetParentoNode: TBlock3D;override;
  public
  fThorax : TManThorax3D;
  procedure BuildBodyPart;override;
  constructor Create(Thorax : TManThorax3D; const sKeyname : string; ParentBody:TBody3D;Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;
 end;
 TWoManPelvis3D=class(TBlock3D)
  protected
//   function GetParentoNode: TBlock3D;override;
  public
  fThorax : TWoManThorax3D;
  procedure BuildBodyPart;override;
  constructor Create(Thorax : TWoManThorax3D; const sKeyname : string; ParentBody:TBody3D;Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;
 end;

 TManLeg3D=class(TBlock3D)
  protected
//   function GetParentoNode: TBlock3D;override;
  public
  fPelvis : TManPelvis3D;
  procedure BuildBodyPart;override;
  constructor Create(Pelvis : TManPelvis3D; const sKeyname : string; ParentBody:TBody3D;Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;

 end;
 TWoManLeg3D=class(TBlock3D)
  protected
//   function GetParentoNode: TBlock3D;override;
  public
  fPelvis : TWoManPelvis3D;
  procedure BuildBodyPart;override;
  constructor Create(Pelvis : TWoManPelvis3D; const sKeyname : string; ParentBody:TBody3D;Drawer3D:TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;

 end;

 TManLowerLeg3D=class(TBlock3D)
   protected
//   function GetParentoNode: TBlock3D;override;
  public
  fLeg : TManLeg3D;
  procedure BuildBodyPart;override;
  constructor Create(Leg : TManLeg3D; const sKeyname : string; ParentBody:TBody3D;Drawer3D : TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;
 end;
 TWoManLowerLeg3D=class(TBlock3D)
   protected
//   function GetParentoNode: TBlock3D;override;
  public
  fLeg : TWoManLeg3D;
  procedure BuildBodyPart;override;
  constructor Create(Leg : TWoManLeg3D; const sKeyname : string; ParentBody:TBody3D;Drawer3D : TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;
 end;

 TManFoot3D=class(TBlock3D)
   protected
//   function GetParentoNode: TBlock3D;override;
  public
  fLowerLeg : TManLowerLeg3D;
  procedure BuildBodyPart;override;
  constructor Create(LowerLeg : TManLowerLeg3D; const sKeyname : string; ParentBody:TBody3D;Drawer3D : TDrawer3D; Parent : TTreeItemRef=nil);reintroduce;

 end;
 TWoManFoot3D=class(TBlock3D)
   protected
//   function GetParentoNode: TBlock3D;override;
   fbHeels:boolean;
  public
  fLowerLeg : TWoManLowerLeg3D;
  procedure BuildBodyPart;override;
  constructor Create(LowerLeg : TWoManLowerLeg3D; const sKeyname : string; ParentBody:TBody3D;Drawer3D : TDrawer3D; bHeels : boolean;Parent : TTreeItemRef=nil);reintroduce;

 end;

 TManBody3D=class(TBody3D)
 protected
  ManHead : TManHead3D;
  ManThorax : TManThorax3D;
  ManPelvis : TManPelvis3D;
  ArmRight : TManArm3D;
  ArmLeft  : TManArm3D;
  ForeArmRight : TManForeArm3D;
  ForeArmLeft  : TManForeArm3D;
  LegRight : TManLeg3D;
  LegLeft  : TManLeg3D;
  LowerLegRight : TManLowerLeg3D;
  LowerLegLeft  : TManLowerLeg3D;
  FootRight, FootLeft : TManFoot3D;
  HandRight, HandLeft : TManHand3D;
  function getHead: TBlock3D;override;
  function getArmRight: TBlock3D;override;
  function getForeArmRight: TBlock3D;override;
  function getHandRight: TBlock3D;override;
  function GetHandLeft: TBlock3D;override;
  function getThorax: TBlock3D;override;
  function getArmLeft: TBlock3D;override;
  function getForeArmLeft: TBlock3D;override;
  function getFootRight: TBlock3D;override;
  function getFootLeft: TBlock3D;override;
  function getLegRight: TBlock3D;override;
  function getLegLeft: TBlock3D;override;
  function getLowerLegRight: TBlock3D;override;
  function getLowerLegLeft: TBlock3D;override;
  function getPelvis: TBlock3D;override;


  public
  function GetHumanType : string;override;
  constructor Create(const iModuleXY:extended; const iModuleZ : extended;const sKeyname : string; Drawer3D: TDrawer3D; x_f : extended=2.5; y_f:extended=3.5; z_f:extended=3.5;Parent : TTreeItemRef=nil);reintroduce;
  destructor destroy;override;
 end;

 TWomanBody3D=class(TBody3D)
 protected
  WomanHead : TWomanHead3D;
  WomanThorax : TWomanThorax3D;
  WomanPelvis : TWomanPelvis3D;
  ArmRight : TWomanArm3D;
  ArmLeft  : TWomanArm3D;
  ForeArmRight : TWomanForeArm3D;
  ForeArmLeft  : TWomanForeArm3D;
  LegRight : TWomanLeg3D;
  LegLeft  : TWomanLeg3D;
  LowerLegRight : TWomanLowerLeg3D;
  LowerLegLeft  : TWomanLowerLeg3D;
  FootRight, FootLeft : TWomanFoot3D;
  HandRight, HandLeft : TWomanHand3D;
  fbHeels : boolean;
  function getHead: TBlock3D;override;
  function getArmRight: TBlock3D;override;
  function getForeArmRight: TBlock3D;override;
  function getHandRight: TBlock3D;override;
  function GetHandLeft: TBlock3D;override;
  function getThorax: TBlock3D;override;
  function getArmLeft: TBlock3D;override;
  function getForeArmLeft: TBlock3D;override;
  function getFootRight: TBlock3D;override;
  function getFootLeft: TBlock3D;override;
  function getLegRight: TBlock3D;override;
  function getLegLeft: TBlock3D;override;
  function getLowerLegRight: TBlock3D;override;
  function getLowerLegLeft: TBlock3D;override;
  function getPelvis: TBlock3D;override;


  public
  function GetHumanType : string;override;
  constructor Create(const iModuleXY:extended; const iModuleZ : extended;const sKeyname : string; Drawer3D: TDrawer3D;bHeels : boolean; x_f : extended=2.5; y_f:extended=3.5; z_f:extended=3.5;Parent : TTreeItemRef=nil);reintroduce;
  destructor destroy;override;
 end;

procedure MirroringX(Target:TBlock3D);
procedure CreateAndLoadXMLBody(Const sFileName : string; var Body : TBody3D; Drawer3D : TDrawer3D; bHeels:boolean=false);
procedure CreateManThorax(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
procedure CreateManHead(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D; radius_eyes, tr_z, modulexy,modulez : extended );
procedure CreateManPelvis(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
procedure CreateManArm(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
procedure CreateManForeArm(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
procedure CreateManHand(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
procedure CreateManLeg(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
procedure CreateManLowerLeg(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
procedure CreateManFoot(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
procedure CreateWoManPelvis(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
procedure CreateWoManLowerLeg(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
procedure CreateWoManFoot(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D; bHeels:boolean );


implementation

{ TBlock3D }

procedure TBlock3D.BuildBodyPart;
begin
 fRotule3D:=fDrawer3D.Scene3DTree.AddPoint3D(GetScene3DRef);
 fRotule3D.oType:=0;
 fRotule3D.Keyname:='rot_'+fPrefix;

end;

constructor TBlock3D.Create(Const sKeyname:string;ParentBody:TBody3D;Drawer3D:TDrawer3D; Parent : TTreeItemRef);
begin
 fDrawer3D:=Drawer3D;
 fScene3D:=Drawer3D.fTree3D.Add(Parent) as TScene3D;
// fScene3D:=Drawer3D.fTree3D.AddScene3D(Parent);
 fScene3D.Keyname:=sKeyname;
 fScene3D.Drawer3D:=Drawer3D;
 fPrefix:=sKeyname;
 fParentBody:=ParentBody;

end;

destructor TBlock3D.Destroy;
begin
  inherited;

end;


function TBlock3D.GetScene3DRef: TTreeItemRef;
begin
 result:=fDrawer3D.fTree3D.GetScene3DRef(fScene3D.Keyname,true,nil);
end;

procedure TBlock3D.RotateX(const Phi: Extended);
begin
  // Get the rotule
{  ParentRxPhi :=0;
  if ParentNode<>Nil then
  begin
  // Invalider l'angle du parent
   ParentRxPhi:=ParentNode.fRxphi;
   px:=ParentNode.fRotule3D.x;
   py:=ParentNode.fRotule3D.y;
   pz:=ParentNode.fRotule3D.z;
   fScene3D.Translate(-px,-py,-pz);
   fScene3D.RotateX(-ParentRxPhi);
   fScene3D.Translate(px,py,pz);
  end;

  bx:=fRotule3D.x;
  by:=fRotule3D.y;
  bz:=fRotule3D.z;

  oRxPhi:=fRxPhi;
  fScene3D.Translate(-bx,-by,-bz);
  // On utilise l'angle du parent pour effectuer la rotation inverse au lieu de fRxphi
  fScene3D.RotateX(-fRxphi+dphi);
  fScene3D.Translate(bx,by,bz);

  if ParentNode<>nil then begin
   fScene3D.Translate(-px,-py,-pz);
   fScene3D.RotateX(PDPhi+ParentRxPhi);
   fScene3D.Translate(px,py,pz);
  end;


  Descendant:=GetDescendant;

  if Descendant<>nil then

   //Descendant.RotateX(DPhi-ParentRxPhi-oRxphi,fRotule3D.x,fRotule3D.y,fRotule3D.z);
     Descendant.RotateX(0,-fRXphi+dphi);
}
  fParentBody.ResetBody;
//  fRxPhi:=Phi-fRxPhi;
  fRxPhi:=Phi;
  fParentBody.GenerateBody;


end;

{procedure TBlock3D.RotateX(const DPhi,bx, by, bz: extended);
var Descendant : TBlock3D;
    ParentRxPhi : Extended;
begin
  fScene3D.Translate(-Bx,-By,-Bz);
  ParentRxPhi:=0;
  if ParentNode<> nil then
   ParentRxPhi:=ParentNode.fRxPhi;
  fScene3D.RotateX(-fRxPhi+ParentRxPhidphi);
  fScene3D.Translate(Bx,By,Bz);

  Descendant:=GetDescendant;

  if Descendant<>nil then
   //Descendant.RotateX(DPhi,fRotule3D.x,fRotule3D.y,fRotule3D.z);
   Descendant.RotateX(Dphi,Bx,By,Bz);

end;                                  }

procedure TBlock3D.RotateY(const phi: Extended);

begin
{  fScene3D.Translate(fRotule3D.x,fRotule3D.y,fRotule3D.z);
  fScene3D.RotateY(-fRyphi+dphi);
  fScene3D.Translate(-fRotule3D.x,-fRotule3D.y,-fRotule3D.z);
  fRyPhi:=DPhi;}
  fParentBody.ResetBody;
//  fRxPhi:=Phi-fRxPhi;
  fRyPhi:=Phi;
  fParentBody.GenerateBody;

{  Descendant:=GetDescendant;
  if Descendant<>nil then
   Descendant.RotateY(DPhi,fRotule3D.x,fRotule3D.y,fRotule3D.z);    }

end;

procedure TBlock3D.RotateZ(const teta: Extended);
begin
     fParentBody.ResetBody;
//  fRxPhi:=Phi-fRxPhi;
  fRzTeta:=Teta;
  fParentBody.GenerateBody;


//  fScene3D.Translate(fRotule3D.x,fRotule3D.y,fRotule3D.z);
//  fScene3D.RotateZ(-fRzteta+dteta);
//  fScene3D.Translate(-fRotule3D.x,-fRotule3D.y,-fRotule3D.z);
//  fRzteta:=Dteta;

 { Descendant:=GetDescendant;
  if Descendant<>nil then
   Descendant.RotateZ(DTeta,fRotule3D.x,fRotule3D.y,fRotule3D.z);  }

end;


{procedure TBlock3D.RotateY(const DPhi, bx, by, bz: extended);
var _bx,_bz : extended;
begin
    _bx:=fRotule3D.x;
    _bz:=fRotule3D.z;

    fRotule3D.x:=bx;
    fRotule3D.z:=bz;

    RotateY(Dphi);

    fRotule3D.x:=_bx;
    fRotule3D.z:=_bz;

end;}

{ THead3D }

procedure TManHead3D.BuildBodyPart;
var
    module_cz, module_cy, module_cx : extended;

begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
 inherited;
 module_cz:=ModuleZ * (fParentBody as TManBody3D).z_factor;
 module_cx:=ModuleXY * (fParentBody as TManBody3D).x_factor;
 module_cy:=ModuleXY * (fParentBody as TManBody3D).y_factor;

 radius_eyes:=0.25*Modulexy;
 tr_z:=0;

 CreateManHead(fPrefix,Module_cx,module_cy,module_cz,fDrawer3D,GetScene3DRef,fRotule3D,radius_eyes,tr_z,moduleXY,moduleZ);


end;

constructor TManHead3D.Create( Thorax:TManThorax3D;Const sKeyname:string;ParentBody:TBody3D;Drawer3D:TDrawer3D;
  Parent: TTreeItemRef);
begin
 inherited Create(sKeyname,ParentBody,Drawer3D,Parent);
 ModuleXY:=Thorax.ModuleXY;
 ModuleZ:=Thorax.ModuleZ;

 fThorax:=Thorax;
 fsBLockTypeName:='Head';
 //module_cy:=ModuleXY * Body.y_factor;
 //module_cx:=Modulexy * Body.x_factor;


end;

{function TManHead3D.GetDescendant: TBlock3D;
begin
 result:=nil;
end;

function TManHead3D.GetParentoNode: TBlock3D;
begin
 result:=fThorax;
end;           }


{ TTHorax3D }

procedure TManTHorax3D.BuildBodyPart;
var  module_cy,module_cx,module_cz:extended;

begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;

 inherited;
 module_cy:=ModuleXY * fBody.y_factor;
 module_cx:=Modulexy * fBody.x_factor;
 module_cz:=ModuleZ * fBody.z_factor;

 CreateManThorax(fprefix,Module_cx,module_cy,module_cz,fDrawer3D,GetScene3DRef,fRotule3D);


end;

constructor TManTHorax3D.Create(Body : TManBody3D; const sKeyname: string;
  Drawer3D: TDrawer3D; Parent: TTreeItemRef);
begin
 inherited create(sKeyname,Body,Drawer3D,Parent);
 ModuleZ:=Body.ModuleZ;
 ModuleXY:=Body.ModuleXY;
 fBody:=Body;
 fsBlockTypeName:='Thorax';
end;

{ TPelvis3D }

procedure TManPelvis3D.BuildBodyPart;
var module_cx,module_cy,module_cz : extended;

begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;

  inherited;
 module_cy:=ModuleXY * fThorax.fBody.y_factor;
 module_cx:=Modulexy * fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fThorax.fBody.z_factor;

 //module_c:=fThorax.fHead.modulexy*3.5;
 CreateManPelvis(fprefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);
end;

constructor TManPelvis3D.Create(Thorax: TManThorax3D; const sKeyname: string;
  ParentBody:TBody3D;Drawer3D: TDrawer3D; Parent: TTreeItemRef);
begin
 inherited Create(sKeyname,ParentBody,Drawer3D,Parent);
 ModuleZ:=Thorax.ModuleZ;
 ModuleXY:=Thorax.ModuleXY;
 fThorax:=Thorax;
 fsBlockTypeName:='Pelvis';
end;

procedure TBlock3D.SetToOrigin;
begin
 fScene3D.Translate(-fRotule3D.x,-fRotule3D.y,-fRotule3D.z);
end;

{function TBlock3D.GetParentoNode: TBlock3D;
begin
 result:=nil;
end;           }


{ TManArm3D }

procedure TManArm3D.BuildBodyPart;
var Module_cx,Module_cy,Module_cz: extended;

begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
  inherited;
 module_cy:=ModuleXY * fThorax.fBody.y_factor;
 module_cx:=Modulexy * fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fThorax.fBody.z_factor;

// Module_c:=fThorax.fHead.Modulexy*3.5;
 CreateManArm(fPrefix,module_cx,module_cy,module_cz,fDrawer3D,GetScene3DRef,fRotule3D);
end;

constructor TManArm3D.create(Thorax: TManThorax3D; const sKeyname: string; ParentBody: TBody3D;
  Drawer3D: TDrawer3D; Parent: TTreeItemRef);
begin
 inherited create(sKeyname,ParentBody,Drawer3D,parent);
 ModuleZ:=Thorax.ModuleZ;
 ModuleXY:=Thorax.ModuleXY;
 fThorax:=Thorax;

end;

{function TManArm3D.GetDescendant: TBlock3D;
begin
 result:=nil;
 if fParentBody.ForeArmRight.ParentNode=self then
  result:=fParentBody.ForeArmRight
 else
  if fParentBody.ForeArmLeft.ParentNode=self then
   result:=fParentBody.ForeArmLeft;

end;  }

{function TManArm3D.GetParentoNode: TBlock3D;
begin
 result:=fThorax;
end;}

{ TManForeArm3D }

procedure TManForeArm3D.BuildBodyPart;
var Module_cx,Module_cy,Module_cz: extended;
begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
 inherited;
 module_cy:=ModuleXY * fArm.fThorax.fBody.y_factor;
 module_cx:=Modulexy * fArm.fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fArm.fThorax.fBody.z_factor;

 //Module_c:=fArm.fThorax.fHead.Modulexy*3.5;
 CreateManForeArm(fprefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);

end;

constructor TManForeArm3D.create(Arm: TManArm3D; const sKeyname: string; ParentBody:TBody3D;
  Drawer3D: TDrawer3D; Parent: TTreeItemRef);
begin
 inherited create(sKeyname,ParentBody,Drawer3D,parent);
 ModuleZ:=Arm.fThorax.ModuleZ;
 ModuleXY:=Arm.fThorax.ModuleXY;
 fArm:=Arm;

end;

{function TManForeArm3D.GetDescendant: TBlock3D;
begin
 result:=nil;
 if fParentBody.HandRight.ParentNode=self then
  result:=fParentBody.HandRight
 else
  if fParentBody.HandLeft.ParentNode=self then
   result:=fParentBody.HandLeft;
end;          }

{function TManForeArm3D.GetParentoNode: TBlock3D;
begin
 result:=fArm;
end;}


{ TManLeg3D }

procedure TManLeg3D.BuildBodyPart;
var module_cx,Module_cy,Module_cz : extended;

begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
  inherited;
 module_cy:=ModuleXY * fPelvis.fThorax.fBody.y_factor;
 module_cx:=Modulexy * fPelvis.fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fPelvis.fThorax.fBody.z_factor;

 //module_cx:=Fpelvis.Modulexy*.5;

 CreateManLeg(fprefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);

end;

constructor TManLeg3D.Create(Pelvis: TManPelvis3D; const sKeyname: string; ParentBody:TBody3D;
  Drawer3D: TDrawer3D; Parent: TTreeItemRef);

begin

 inherited Create(sKeyname,ParentBody,Drawer3D,Parent);
 ModuleZ:=Pelvis.ModuleZ;
 ModuleXY:=Pelvis.ModuleXY;
 fPelvis:=Pelvis;           // Presley Elvis : P. Elvis : Pelvis

end;

{function TManLeg3D.GetParentoNode: TBlock3D;
begin
 result:=fPelvis;
end; }

{ TManLowerLeg3D }

procedure TManLowerLeg3D.BuildBodyPart;
var module_cx,Module_cy,Module_cz : extended;

begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;

  inherited;
 module_cy:=ModuleXY * fLeg.fPelvis.fThorax.fBody.y_factor;
 module_cx:=Modulexy * fLeg.fPelvis.fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fLeg.fPelvis.fThorax.fBody.z_factor;

 CreateManLowerLeg(fPrefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);
end;

constructor TManLowerLeg3D.Create(Leg: TManLeg3D;
  const sKeyname: string; ParentBody:TBody3D;Drawer3D: TDrawer3D; Parent: TTreeItemRef);
begin
 inherited Create(sKeyname,ParentBody,Drawer3D,Parent);
 ModuleZ:=Leg.ModuleZ;
 ModuleXY:=Leg.ModuleXY;
 fLeg:=Leg;

end;

{function TManLowerLeg3D.GetParentoNode: TBlock3D;
begin
 result:=fLeg;
end; }

{ TManFoot3D }

procedure TManFoot3D.BuildBodyPart;
var module_cx,Module_cy,Module_cz : extended;

begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;

  inherited;
 module_cy:=ModuleXY * fLowerLeg.fLeg.fPelvis.fThorax.fBody.y_factor;
 module_cx:=Modulexy * fLowerLeg.fLeg.fPelvis.fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fLowerLeg.fLeg.fPelvis.fThorax.fBody.z_factor;

 //module_c:=fLowerLeg.fLeg.fPelvis.fThorax.fHead.modulexy*3.5;
 CreateManFoot(fPrefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);

end;

constructor TManFoot3D.Create(LowerLeg: TManLowerLeg3D;
  const sKeyname: string; ParentBody:TBody3D; Drawer3D: TDrawer3D; Parent: TTreeItemRef);
begin
 inherited Create(sKeyname,ParentBody,Drawer3D,Parent);
 ModuleZ:=LowerLeg.ModuleZ;
 ModuleXY:=LowerLeg.ModuleXY;
 fLowerLeg:=LowerLeg;

end;

{function TManFoot3D.GetParentoNode: TBlock3D;
begin
 result:=fLowerLeg;
end;   }

{ TManHand3D }

procedure TManHand3D.BuildBodyPart;
var Module_cx,Module_cy,Module_cz: extended;

begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
 inherited;
 module_cy:=ModuleXY * fForeArm.fArm.fThorax.fBody.y_factor;
 module_cx:=Modulexy * fForeArm.fArm.fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fForeArm.fArm.fThorax.fBody.z_factor;

 //Module_c:=fForeArm.fArm.fThorax.fHead.Modulexy*3.5;
 //fRotule3D.z:=fRotule3D.z + 0.5*module_Cz;
 CreateManHand(fprefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);
end;

constructor TManHand3D.create(ForeArm: TManForeArm3D;
  const sKeyname: string; ParentBody:TBody3D;Drawer3D: TDrawer3D; Parent: TTreeItemRef);
begin
 inherited create(sKeyname,ParentBody,Drawer3D,parent);
 ModuleZ:=ForeArm.ModuleZ;
 ModuleXY:=ForeArm.ModuleXY;
 fForeArm:=ForeArm;

end;
procedure MirroringX(Target:TBlock3D);
var i:integer;Line3D : TLine3D;     Frame3D : TFrame3D;    Maye : TMayeEdge;
    j,k:integer;   MayeSurface3D : TMayeSurface3D;   TriFace:TMayeTriFace3D;
begin
 for i:=0 to Target.fScene3D.fLine3DRefList.Count -1 do
 begin
  Line3D:=((Target.fScene3D.fLine3DRefList.Items[i] as TObject3DRef).Value as TLine3D);
  Line3D.x1:=-Line3D.x1;
  Line3D.x2:=-Line3D.x2;
 end;
 for i:=0 to Target.fScene3D.fFrame3DRefList.Count -1 do
 begin
  Frame3D:=((Target.fScene3D.fFrame3DRefList.Items[i] as TObject3DRef).Value as TFrame3D);
  for j:=0 to Frame3D.fPoints.Count -1 do
  begin
   Maye:=Frame3D.fPoints.Edge[j];
   Maye.x:=-Maye.x;
  end;
 end;
 for i:=0 to Target.fScene3D.fMayeSurface3DRefList.Count -1 do
 begin
  MayeSurface3D:=((Target.fScene3D.fMayeSurface3DRefList.Items[i] as TObject3DRef).Value as TMayeSurface3D);
  for j:=0 to MayeSurface3D.fMayeTriFace3DList.Count -1 do
  begin
     TriFace:=MayeSurface3D.fMayeTriFace3DList.MayeTriFace3D[j];
     for k:=0 to TriFace.fMayeEdgeList.Count -1 do
     begin
      Maye:=Triface.fMayeEdgeList.Edge[k];
      Maye.x:=-Maye.x;
     end;
  end;
 end;
 Target.fRotule3D.x:=-Target.fRotule3D.x;
end;

{function TManHand3D.GetDescendant: TBlock3D;
begin
 result:=nil;
end;         }

{function TManHand3D.GetParentoNode: TBlock3D;
begin
 result:=fForeArm;
end; }


{ TManBody3D }

constructor TManBody3D.Create(const iModuleXY:extended; const iModuleZ : extended;const sKeyname : string; Drawer3D: TDrawer3D; x_f : extended=2.5; y_f:extended=3.5; z_f:extended=3.5;Parent : TTreeItemRef=nil);
var     CurParent:TTreeItemRef;
begin
 if Parent=nil then
  Parent:=Drawer3D.CurrentScene3DRef;

 inherited Create(sKeyname,nil,Drawer3D,Parent);

 ModuleZ:=iModuleZ;
 ModuleXY:=iModuleXY;
 x_factor:=x_f;
 y_factor:=y_f;
 z_factor:=z_f;
 CurParent:=Drawer3D.Scene3DTree.GetScene3DRef(sKeyname,true,nil);
 if CurParent=nil then
  raise Exception.Create('TManBody::Create:The scene does no longer exist');
 ManThorax:=TManThorax3D.Create(Self,sKeyname+'_Thorax',Drawer3D,CurParent);
 ManHead:=TManHead3D.Create(ManThorax,sKeyname+'_Head',self,Drawer3D,CurParent);
 ArmRight :=TManArm3D.create(ManThorax,sKeyname+'_ArmR',self,Drawer3D,CurParent);
 ArmLeft  :=TManArm3D.Create(ManThorax,sKeyname+'_ArmL',self,Drawer3D,CurParent);
// MirroringX(ArmLeft);
 ForeArmRight := TManForeArm3D.Create(ArmRight,skeyname+'_ForeArmR',self,Drawer3D,CurParent);
 ForeArmLeft  := TManForeArm3D.Create(ArmLeft,skeyname+'_ForeArmL',self,Drawer3D,CurParent);
// MirroringX(ForeArmLeft);
 HandRight :=TManHand3D.Create(ForeArmRight,sKeyname+'_HandR',self,Drawer3D,CurParent);
 HandLeft  :=TManHand3D.create(ForeArmLeft,sKeyname+'_HandL',self,Drawer3D,CurParent);
// MirroringX(HandLeft);
 // Creation des liens entre les éléments :

 ManPelvis:=TManPelvis3D.Create(ManThorax,sKeyname+'_Pelvis',self,Drawer3D,CurParent);
 LegRight :=TManLeg3D.Create(ManPelvis,sKeyname+'_LegR',self,Drawer3D,CurParent);
 LegLeft  :=TManLeg3D.Create(ManPelvis,sKeyname+'_LegL',self,Drawer3D,CurParent);
// MirroringX(LegLeft);
 LowerLegRight :=TManLowerLeg3D.Create(LegRight,sKeyname+'_LowerLegR',self,Drawer3D,CurParent);
 LowerLegLeft  :=TManLowerLeg3D.Create(LegLeft,sKeyname+'_LowerLegL',self,Drawer3D,CurParent);
// MirroringX(LowerLegLeft);
 FootRight :=TManFoot3D.Create(LowerLegRight,sKeyname+'_FootR',self,Drawer3D,CurParent);
 FootLeft  :=TManFoot3D.Create(LowerLegLeft,sKeyname+'_FootL',self,Drawer3D,CurParent);
// MirroringX(FootLeft);

 LinkRotules;
// ResetBody;
end;

destructor TManBody3D.destroy;
begin
  FreeAndNil(LowerLegLeft);
  FreeAndNil(LowerLegRight);
  FreeandNil(LegRight);
  FreeAndNil(LegLeft);
  FreeAndNil(ForeArmLeft);
  FreeAndNil(ForeArmRight);
  FreeAndNil(ArmLeft);
  FreeAndNil(ArmRight);
  FreeAndNil(ManHead);
  FreeAndNil(ManThorax);
  FreeAndNil(ManPelvis);
  FreeAndNil(FootRight);
  FreeAndNil(FootLeft);
  FreeAndNil(HandRight);
  FreeAndNil(HandLeft);
  inherited;

end;

{ TBody }


constructor TBody3D.Create(const sKeyname: string; ParentBody:TBody3D;Drawer3D: TDrawer3D;
  Parent: TTreeItemRef);
begin
  inherited;
  fRotuleTree:=TCustomTree.create( nil );

  if Parent=nil then
   Raise Exception.Create('TBody3D : Error the TBody3D object must be a part of a scene !');
end;
procedure TBody3D.LinkRotules;
var
  ThoraxRef,PelvisRef,CurRef : TTreeItemRef;

begin
 // Create the rotule tree
  ThoraxRef:=fRotuleTree.Add(nil,Thorax);
  fRotuleTree.Add(ThoraxRef,Head);
 // Right
  CurRef:=fRotuleTree.Add(ThoraxRef,ArmRight);
  CurRef:=fRotuleTree.Add(CurRef,ForeArmRight);
  fRotuleTree.Add(CurRef,HandRight);
 // Left
  CurRef:=fRotuleTree.Add(ThoraxRef,ArmLeft);
  CurRef:=fRotuleTree.Add(CurRef,ForeArmLeft);
  fRotuleTree.Add(CurRef,HandLeft);

  PelvisRef:=fRotuleTree.Add(nil,Pelvis);
  CurRef:=fRotuleTree.Add(PelvisRef,LegRight);
  CurRef:=fRotuleTree.Add(CurRef,LowerLegRight);
  fRotuleTree.Add(CurRef,FootRight);
  CurRef:=fRotuleTree.Add(PelvisRef,LegLeft);
  CurRef:=fRotuleTree.Add(CurRef,LowerLegLeft);
  fRotuleTree.Add(CurRef,FootLeft);

  ArmRight.fsBlockTypeName:='ArmRight';
  ArmLeft.fsBlocktypeName:='ArmLeft';
  ForeArmRight.fsBlockTypeName:='ForeArmRight';
  ForeArmLeft.fsBlockTypeName:='ForeArmLeft';

  HandRight.fsBlockTypeName:='HandRight';
  HandLeft.fsBlockTypeName:='HandLeft';

  LegRight.fsBlockTypeName:='LegRight';
  LegLeft.fsBlockTypeName:='LegLeft';
  LowerLegRight.fsBlockTypeName:='LowerLegRight';
  LowerLegLeft.fsBlockTypeName:='LowerLegLeft';

  FootRight.fsBlocktypename:='FootRight';
  FootLeft.fsBlockTypeName:='FootLeft';
end;

destructor TBody3D.destroy;
begin
  fRotuleTree.free;
  inherited;
end;

function TBody3D.getArmLeft: TBlock3D;
begin
  result:=nil;
end;

function TBody3D.getArmRight: TBlock3D;
begin
 result:=nil;
end;

{function TBlock3D.GetDescendant: TBlock3D;
begin

end;}

function TBody3D.getForeArmLeft: TBlock3D;
begin
  result:=nil;
end;

function TBody3D.getForeArmRight: TBlock3D;
begin
  result:=nil;
end;

function TBody3D.GetHandLeft: TBlock3D;
begin
   result:=nil;
end;

function TBody3D.getHandRight: TBlock3D;
begin
  result:=nil;
end;

function TBody3D.getHead: TBlock3D;
begin
 result:=nil;
end;

function TManBody3D.getArmLeft: TBlock3D;
begin
 result:=ArmLeft;

end;

function TManBody3D.getArmRight: TBlock3D;
begin
 result:=ArmRight;
end;

function TManBody3D.getFootLeft: TBlock3D;
begin
 result:=FootLeft;
end;

function TManBody3D.getFootRight: TBlock3D;
begin
 result:=FootRight;
end;

function TManBody3D.getForeArmLeft: TBlock3D;
begin
 result:=ForeArmLeft;

end;

function TManBody3D.getForeArmRight: TBlock3D;
begin
 result:=ForeArmRight;
end;

function TManBody3D.GetHandLeft: TBlock3D;
begin
 result:=HandLeft;
end;

function TManBody3D.getHandRight: TBlock3D;
begin
 result:=HandRight;
end;

function TManBody3D.getHead: TBlock3D;
begin
 result:=ManHead;
end;


function TBody3D.getThorax: TBlock3D;
begin
 result:=nil;
end;

function TManBody3D.GetHumanType: string;
begin
 result:='MAN';
end;

function TManBody3D.getLegLeft: TBlock3D;
begin
 result:=LegLeft;
end;

function TManBody3D.getLegRight: TBlock3D;
begin
 result:=LegRight;
end;

function TManBody3D.getLowerLegLeft: TBlock3D;
begin
 result:=LowerLegLeft;
end;

function TManBody3D.getLowerLegRight: TBlock3D;
begin
 result:=LowerLegRight;
end;

function TManBody3D.getPelvis: TBlock3D;
begin
 result:=ManPelvis;
end;

function TManBody3D.getThorax: TBlock3D;
begin
 result:=ManTHorax;
end;

{function TManTHorax3D.GetParentoNode: TBlock3D;
begin
 result:=fBody;
end; }

{function TManPelvis3D.GetParentoNode: TBlock3D;
begin
 result:=fThorax;
end; }
// Applique l'état d'un élément à tous ses sous élements
procedure TBody3D.RecurCalcBody(Current : TTreeItemRef; xphi,yphi,zteta, rx,ry,rz : extended);
var  i : integer; CurrentBlock : TBlock3D;
begin
 CurrentBLock:=Current.Value as TBlock3D;

 CurrentBLock.fScene3D.Translate(-rx,-ry, - rz);
 // Rotate the current block X position
 CurrentBlock.fScene3D.RotateZ(zteta);
 CurrentBlock.fScene3D.RotateY(yphi);

 CurrentBLock.fScene3D.RotateX(xphi);
 // Y
 // Z
 CurrentBLock.fScene3D.Translate(rx,ry,rz);

 for i:=0 to Current.fChildNodes.Count -1 do
  RecurCalcBody(Current.fChildNodes.Items[i] as TTreeItemRef,xphi,yphi,zteta ,rx,ry,rz);
end;


// iMode : 0 = Stand By
//         1 = new Position
procedure TBody3D.GenerateBody;
var i:integer;
begin

 for i:=0 to fRotuleTree.fRefNodeList.Count -1 do
  RecurGenerateBody(fRotuleTree.fRefNodeList.Items[i] as TTreeItemRef);
 //RecurCalcBody(Pelvis);
end;

procedure TBody3D.RecurGenerateBody(Current: TTreeItemRef);
var rx,ry,rz,phi : extended;  bk : TBlock3D;  i:integer;
begin
 bk:=Current.Value as TBlock3D;
 rx:=bk.fRotule3D.x;
 ry:=bk.fRotule3D.y;
 rz:=bk.fRotule3D.z;
// if iMode=1 then
 RecurCalcBody(Current,bk.fRxphi,bk.fRyphi,bk.fRzteta,rx,ry,rz);// else
{  if iMode=0 then
    RecurCalcBody(Current,-bk.fRxphi,-bk.fRyPhi,rx,ry,rz);}

 for i:=0 to Current.fChildNodes.Count -1 do
  RecurGenerateBody(Current.fChildNodes.Items[i] as TTreeItemRef);
end;

function TBody3D.getFootRight: TBlock3D;
begin
  result:=nil;
end;

function TBody3D.getFootLeft: TBlock3D;
begin
  result:=nil;
end;

function TBody3D.getLegRight: TBlock3D;
begin
 result:=nil;
end;

function TBody3D.getLegLeft: TBlock3D;
begin
 result:=nil;
end;

function TBody3D.getLowerLegRight: TBlock3D;
begin
result:=nil;
end;

function TBody3D.getLowerLegLeft: TBlock3D;
begin
result:=nil;
end;

function TBody3D.getPelvis: TBlock3D;
begin
 result:=nil;
end;

(*procedure TBody3D.RecurResetBody(Current: TTreeItemREf);
var i : integer;   Bk : TBlock3D;
begin
 Bk:=Current.Value as TBlock3D;

 Bk.fScene3D.DeleteAllChildObjects;

 for i:=0 to Current.fChildNodes.Count -1 do
  RecurResetBody(Current.fChildNodes.Items[i] as TTreeItemRef);
end;     *)

procedure TBody3D.ResetBody;
var i: integer;
begin

// Reconstruire le corps ici : morceau par morceau  contenu de TManBodyCreate;
 Thorax.BuildBodyPart;
 Head.BuildBodyPart;
 ArmRight.BuildBodyPart;
 ArmLeft.BuildBodyPart;
 MirroringX(ArmLeft);
 ForeArmRight.BuildBodyPart;
 ForeArmLeft.BuildBodyPart;
 MirroringX(ForeArmLeft);
 HandRight.BuildBodyPart;
 HandLeft.BuildBodyPart;
 MirroringX(HandLeft);

 Pelvis.BuildBodyPart;
 LegRight.BuildBodyPart;
 LegLeft.BuildBodyPart;
 MirroringX(LegLeft);
 LowerLegRight.BuildBodyPart;
 LowerLegLeft.BuildBodyPart;
 MirroringX(LowerLegLeft);
 FootRight.BuildBodyPart;
 FootLeft.BuildBodyPart;;
 MirroringX(FootLeft);

end;


procedure TBlock3D.GetXMLBlock(DomDoc : DomDocument; XmlNode : IXmlDomNode);
var XMLObject, XmlAttrib : IXMLDomNode;
begin
 XmlObject:=DomDoc.createElement(fsBlockTypeName);
 XmlNode.appendChild(XmlObject);
 XmlObject.appendChild(DomDoc.CreateTextNode(chr(13)+chr(10)));
 XmlAttrib:=DomDoc.createAttribute('rxphi');
 XmlAttrib.Text:=FloatToStr(fRxphi);
 XmlObject.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.createAttribute('ryphi');
 XmlAttrib.Text:=FloatToStr(fRyphi);
 XmlObject.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.createAttribute('rzteta');
 XmlAttrib.Text:=FloatToStr(fRzteta);
 XmlObject.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.createAttribute('xpos');
 XmlAttrib.Text:=IntToStr(fXPosition);
 XmlObject.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.createAttribute('ypos');
 XmlAttrib.Text:=IntToStr(fYPosition);
 XmlObject.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.createAttribute('zpos');
 XmlAttrib.Text:=IntToStr(fZPosition);
 XmlObject.attributes.setNamedItem(XmlAttrib);

end;

procedure TBody3D.SaveXMLBody( Const sFilename : string);
var DomDoc : DOMDocument;
    XmlRoot : IXmlDomNode;
    XmlObjectList : IXmlDomNode;
    XmlAttrib:IxmlDomnode;
    XmlNode:IXmlDomNode;
//
begin
 DomDoc:=CoDomDocument.Create;
 DomDoc.appendChild (DomDoc.createProcessingInstruction('xml', 'version="1.0"'));

 XMLRoot:=DomDoc.CreateElement('BodySculptDoc');
 DomDoc.appendChild(XmlRoot);
 XmlRoot.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));

 XmlNode:=DomDoc.createElement('Human');
 XmlRoot.appendChild(XmlNode);

 XmlAttrib:=DomDoc.CreateAttribute('type');
 XmlAttrib.Text:=GetHumanType;
 XmlNode.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.CreateAttribute('name');
 XmlAttrib.Text:=fScene3D.Keyname;
 XmlNode.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.CreateAttribute('moduleXY');
 XmlAttrib.Text:=floattostr(ModuleXY);
 XmlNode.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.CreateAttribute('moduleZ');
 XmlAttrib.Text:=floattostr(ModuleZ);
 XmlNode.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.CreateAttribute('x_Factor');
 XmlAttrib.Text:=floattostr(x_factor);
 XmlNode.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.CreateAttribute('y_Factor');
 XmlAttrib.Text:=floattostr(y_factor);
 XmlNode.attributes.setNamedItem(XmlAttrib);

 XmlAttrib:=DomDoc.CreateAttribute('z_Factor');
 XmlAttrib.Text:=floattostr(y_factor);
 XmlNode.attributes.setNamedItem(XmlAttrib);
 XmlNode.appendChild(DomDoc.createTextNode(chr(13)+chr(10)));
 // Un parcours récursif aurait été aussi plus intelligent !
 Thorax.GetXMLBlock(DomDoc,XmlNode);
 Head.GetXMLBlock(DomDoc,XmlNode);
 ArmRight.GetXMLBlock(DomDoc,XmlNode);
 ArmLeft.GetXmlBlock(DomDoc,XmlNode);
 ForeArmRight.GetXmlBlock(DomDoc,XmlNode);
 ForeArmLeft.GetXmlBlock(DomDoc,XmlNode);
 HandRight.GetXMLBlock(DomDoc,XmlNode);
 HandLeft.GetXMLBlock(DomDoc,XmlNode);

 Pelvis.GetXmlBlock(DomDoc,XmlNode);
 LegRight.GetXmlBlock(DomDoc,XmlNode);
 LegLeft.GetXmlBlock(DomDoc,XmlNode);
 LowerLegRight.GetXmlBlock(DomDoc,XmlNode);
 LowerLegLeft.GetXmlBlock(DomDoc,XmlNode);
 FootRight.GetXmlBlock(DomDoc,XmlNode);
 FootLeft.GetXmlBlock(DomDoc,XmlNode);

 DomDoc.Save(sFileName);

end;

procedure TBlock3D.SetXMLBlock( XmlNode : IXmlDomNode);
var XmlAttrib:IXmlDomNode;
begin
 XMLAttrib := XmlNode.attributes.getNamedItem ('rxphi');
 if XmlAttrib<>nil then
  fRxPhi:=strtofloat(XmlAttrib.text);

 XMLAttrib := XmlNode.attributes.getNamedItem ('ryphi');
 if XmlAttrib<>nil then
  fRyPhi:=strtofloat(XmlAttrib.text);

 XMLAttrib := XmlNode.attributes.getNamedItem ('rzteta');
 if XmlAttrib<>nil then
  fRzTeta:=strtofloat(XmlAttrib.text);

 XMLAttrib := XmlNode.attributes.getNamedItem ('xpos');
 if XmlAttrib<>nil then
  fXPosition:=strtoint(XmlAttrib.text);

 XMLAttrib := XmlNode.attributes.getNamedItem ('ypos');
 if XmlAttrib<>nil then
  fYPosition:=strtoint(XmlAttrib.text);

 XMLAttrib := XmlNode.attributes.getNamedItem ('zpos');
 if XmlAttrib<>nil then
  fZPosition:=strtoint(XmlAttrib.text);

end;

procedure CreateAndLoadXMLBody(Const sFileName : string; var Body : TBody3D; Drawer3D : TDrawer3D; bHeels:boolean=false);
var DomDoc:DOMDocument;
    XmlObject:IXmlDomNode;
    XmlRoot:IXmlDomNode;

    XmlObject2:IXmlDomNode;
 XmlAttrib:IXmlDomNode;
 sType,
 sName : string;
 modulexy, modulez : extended;
 x_f, y_f,z_f : extended;
begin
 if Body<>nil then
  FreeAndNil(Body);
 DomDoc:=CoDomDocument.Create;
 DomDoc.load(sFileName);
 XmlRoot:=DomDoc.selectSingleNode('BodySculptDoc');
 if XmlRoot=nil then
  raise Exception.Create('BodySculptor::LoadFromXml:This is not a "BodySculptor" file');

 XmlObject:=XmlRoot.selectSingleNode('Human');
 XMLAttrib := XmlObject.attributes.getNamedItem ('type');
 sType:=XmlAttrib.Text;

 XMLAttrib := XmlObject.attributes.getNamedItem ('name');
 sName:=XmlAttrib.Text;

 XMLAttrib := XmlObject.attributes.getNamedItem ('moduleXY');
 modulexy:=strtofloat(XmlAttrib.Text);

 XMLAttrib := XmlObject.attributes.getNamedItem ('moduleZ');
 modulez:=strtofloat(XmlAttrib.Text);

 XMLAttrib := XmlObject.attributes.getNamedItem ('x_Factor');
 x_f:=strtofloat(XmlAttrib.Text);
 XMLAttrib := XmlObject.attributes.getNamedItem ('y_Factor');
 y_f:=strtofloat(XmlAttrib.Text);
 XMLAttrib := XmlObject.attributes.getNamedItem ('z_Factor');
 z_f:=strtofloat(XmlAttrib.Text);

 // Create the body
 if lowercase(sType)='man' then
  Body:=TManBody3D.Create(modulexy,modulez,sName,Drawer3D,x_f,y_f,z_f,nil)
 else
 begin
 if lowercase(sType)='woman' then
  Body:=TWoManBody3D.Create(modulexy,modulez,sName,Drawer3D,bHeels,x_f,y_f,z_f,nil)

  // Create woman
  // or childs, or animals, or anything else ...
 end;
 if Body<>nil then begin
    // un parcours récursif des Body Parts, à travers les rotules, aurait été plus intelligible mais bon ... paresse intellectuelle quand tu nous tiens
   XmlObject2:=XmlObject.selectSingleNode(Body.Thorax.fsBlockTypeName);
   Body.Thorax.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.Head.fsBlockTypeName);
   Body.Head.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.ArmRight.fsBlockTypeName);
   Body.ArmRight.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.ArmLeft.fsBlockTypeName);
   Body.ArmLeft.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.ForeArmRight.fsBlockTypeName);
   Body.ForeArmRight.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.ForeArmLeft.fsBlockTypeName);
   Body.ForeArmLeft.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.HandRight.fsBlockTypeName);
   Body.HandRight.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.HandLeft.fsBlockTypeName);
   Body.HandLeft.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.Pelvis.fsBlockTypeName);
   Body.Pelvis.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.LegRight.fsBlockTypeName);
   Body.LegRight.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.LegLeft.fsBlockTypeName);
   Body.LegLeft.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.LowerLegRight.fsBlockTypeName);
   Body.LowerLegRight.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.LowerLegLeft.fsBlockTypeName);
   Body.LowerLegLeft.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.FootRight.fsBlockTypeName);
   Body.FootRight.SetXMLBlock(XmlObject2);

   XmlObject2:=XmlObject.selectSingleNode(Body.FootLeft.fsBlockTypeName);
   Body.FootLeft.SetXMLBlock(XmlObject2);

  Body.ResetBody;
  Body.GenerateBody;
 end;
end;

function TBody3D.GetHumanType: string;
begin
 result:='';
end;
procedure CreateManThorax(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
var Line : TLine3D; Scene3D : TScene3D;
begin

 Scene3D:=Scene3DRef.Value as TScene3D;
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-Module_cx,Module_cy * (2/25-1/2), Module_cz*(8-4/3),-Module_cx,4/25*Module_cy,Module_cz*(8-4/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,Module_cx,Module_cy * (2/25-1/2), Module_cz*(8-4/3),Module_cx,4/25*Module_cy,Module_cz*(8-4/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax2',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-Module_cx,Module_cy * (2/25-1/2),Module_cz*(8-4/3),Module_cx,Module_cy * (2/25-1/2),Module_cz*(8-4/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax3',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-Module_cx,4/25*Module_cy,Module_cz*(8-4/3),Module_cx,4/25*Module_cy,Module_cz*(8-4/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax4',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-Module_cx,4/25*Module_cy,Module_cz*(8-4/3),(-0.5*Module_cx),1/2*Module_cy,6*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax5',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,Module_cx,4/25*Module_cy,Module_cz*(8-4/3),(0.5*Module_cx),1/2*Module_cy,6*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax6',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-Module_cx,(2/25-0.5)*Module_cy,Module_cz*(8-4/3),-Module_cx,(2/25-0.5)*Module_cy,Module_cz*(1/3+6),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax7',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,Module_cx,(2/25-0.5)*Module_cy,Module_cz*(8-4/3),Module_cx,(2/25-0.5)*Module_cy,Module_cz*(1/3+6),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax8',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-Module_cx,(2/25-0.5)*Module_cy,Module_cz*(1/3+6),-0.5*Module_cx,-4/25*Module_cy,Module_cz*(5+1/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax9',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,Module_cx,(2/25-0.5)*Module_cy,Module_cz*(1/3+6),0.5*Module_cx,-4/25*Module_cy,Module_cz*(5+1/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax10',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.5*Module_cx,0.5*Module_cy,6*Module_cz,-0.5*Module_cx,Module_cy*(0.5-2/25),Module_cz*(5+1/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax11',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.5*Module_cx,0.5*Module_cy,6*Module_cz,0.5*Module_cx,Module_cy*(0.5-2/25),Module_cz*(5+1/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax12',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.5*Module_cx,Module_cy*(0.5-2/25),Module_cz*(5+1/3),0.5*Module_cx,Module_cy*(0.5-2/25),Module_cz*(5+1/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax13',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.5*Module_cx,Module_cy*(-4/25),Module_cz*(5+1/3),0.5*Module_cx,Module_cy*(-4/25),Module_cz*(5+1/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax14',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.5*Module_cx,Module_cy*(-4/25),Module_cz*(5+1/3),-0.5*Module_cx,Module_cy*(0.5-2/25),Module_cz*(5+1/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax15',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.5*Module_cx,Module_cy*(-4/25),Module_cz*(5+1/3),0.5*Module_cx,Module_cy*(0.5-2/25),Module_cz*(5+1/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax16',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,4/25*Module_cy,Module_cz*(8-4/3),0,2/3*Module_cy,6*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax17',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,2/3*Module_cy,6*Module_cz,0,Module_cy*(0.5-2/25),Module_cz*(5+1/3),BODY_COLOR,BODY_THIN,sPrefix+'_li_thorax18',Scene3D,Drawer3D);
 Rotule3D.x:=0;
 Rotule3D.y:=0;
 Rotule3D.z:=5*module_cz;//5.2*module_cz;

end;
procedure CreateManHead(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D; radius_eyes, tr_z, modulexy,modulez : extended );
var arc,arc1,ellipse : TMayeSurface3D; Line : TLine3D;
    valuex,valuez : extended;
    Scene3D : TScene3D;
begin
 Scene3D:=Scene3DRef.Value as TScene3D;
 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,1.5*modulexy,1.5*modulez,0.585685543458,(pi-0.585685543458),10,BODY_COLOR,BODY_THIN,sprefix+'_cr_zup',Scene3D,Drawer3D);
 arc.RotateX(pi/2);
 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,1.5*modulexy,1.5*modulez,0.585685543458,(pi-0.585685543458),10,BODY_COLOR,BODY_THIN,sprefix+'_cr_zdw',Scene3D,Drawer3D);
 arc.RotateX(-pi/2);
 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,1.5*modulexy,1.5*modulez,0.585685543458,(pi-0.585685543458),10,BODY_COLOR,BODY_THIN,sprefix+'_cr_xyface',Scene3D,Drawer3D);
 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,1.5*modulexy,1.5*modulez,0.585685543458,(pi-0.585685543458),10,BODY_COLOR,BODY_THIN,sprefix+'_cr_arcnose',Scene3D,Drawer3D);
 arc.Translate(0,(0.16666666667*modulexy),-modulez);
 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,1.5*modulexy,1.5*modulez,0.585685543458,(pi-0.585685543458),10,BODY_COLOR,BODY_THIN,sprefix+'_cr_arcmouth',Scene3D,Drawer3D);
 arc.Translate(0,(0.16666666667*modulexy),-1.5*modulez);
 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,1.5*modulexy,1.5*modulez,0.585685543458,(pi-0.585685543458),10,BODY_COLOR,BODY_THIN,sprefix+'_cr_arcarcade',Scene3D,Drawer3D);
 arc.Translate(0,(1.11803398875-1.5)*modulexy,modulez);
 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,1.5*modulexy,1.5*modulez,0.585685543458,(pi-0.585685543458),10,BODY_COLOR,BODY_THIN,sprefix+'_cr_xyback',Scene3D,Drawer3D);
 arc.RotateX(pi);
 valuex:=1.2499999999993;
 valuez:=0.829156197589911;
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,valuex*modulexy,0,valuez*moduleZ,valuex*modulexy,0,-valuez*modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_hl1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,valuex*modulexy,-valuez*modulexy,0,valuex*modulexy,valuez*modulexy,0,BODY_COLOR,BODY_THIN,sPrefix+'_cr_hl2',Scene3D,Drawer3D);
 Ellipse:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipse(Ellipse,0,0,0,valuez*modulez,valuez*modulexy,20,BODY_COLOR,BODY_THIN,sPrefix+'_cr_xysidel',Scene3D,Drawer3D);
 Ellipse.RotateY(pi/2);
 Ellipse.Translate(valuex*modulexy,0,0);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-valuex*modulexy,0,valuez*moduleZ,-valuex*modulexy,0,-valuez*modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_hr1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-valuex*modulexy,-valuez*modulexy,0,-valuex*modulexy,valuez*modulexy,0,BODY_COLOR,BODY_THIN,sPrefix+'_cr_hr2',Scene3D,Drawer3D);
 Ellipse:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipse(Ellipse,0,0,0,valuez*modulez,valuez*modulexy,20,BODY_COLOR,BODY_THIN,sPrefix+'_cr_xysider',Scene3D,Drawer3D);
 Ellipse.RotateY(pi/2);
 Ellipse.Translate(-valuex*modulexy,0,0);

 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,1.5*modulez,1.5*modulexy,0,2*pi,40,BODY_COLOR,BODY_THIN,sprefix+'_cr_ring',Scene3D,Drawer3D);
 arc.RotateY(pi/2);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,(2-1/3)*modulexy,0,0,2*modulexy,-modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_noze',Scene3D,Drawer3D);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,0,modulez,0,1.11803398875*modulexy,modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_ljoin1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,1.5*modulexy,0,0,-1.5*modulexy,0,BODY_COLOR,BODY_THIN,sPrefix+'_cr_ljoin2',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,2*modulexy,-modulez,0,0,-modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_ljoin3',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,(2-1/3)*modulexy,-1.5*modulez,0,0,-1.5*modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_ljoin4',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,(2-1/3)*modulexy,-2*modulez,0,0,-2*modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_ljoin5',Scene3D,Drawer3D);

 valuex:=0.97338991015;
 valuez:=1.38217994062;
 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,4/3*modulexy,4/3*modulexy,valuex,valuez,5,BODY_COLOR,BODY_THIN,sPrefix+'_cr_arceye1',Scene3D,Drawer3D);
 arc.Translate(0,0,-0.25*modulez+tr_z);
 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,4/3*modulexy,4/3*modulexy,pi-valuex,pi-valuez,5,BODY_COLOR,BODY_THIN,sPrefix+'_cr_arceye2',Scene3D,Drawer3D);
 arc.Translate(0,0,-0.25*modulez+tr_z);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.75*modulexy,modulexy,-0.125*modulez,0.75*modulexy,modulexy,-1.5*modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_reye',Scene3D,Drawer3D);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.75*modulexy,modulexy,-0.125*modulez,-0.75*modulexy,modulexy,-1.5*modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_leye',Scene3D,Drawer3D);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.25*modulexy,(2-1/3)*modulexy,-2*modulez,0.25*modulexy,(2-1/3)*modulexy,-2*modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_menton',Scene3D,Drawer3D);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.25*modulexy,(2-1/3)*modulexy,-2*modulez,-0.25*modulexy,(2-1/3)*modulexy,0,BODY_COLOR,BODY_THIN,sPrefix+'_cr_lnose1',Scene3D,Drawer3D);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.25*modulexy,(2-1/3)*modulexy,-2*modulez,0.25*modulexy,(2-1/3)*modulexy,0,BODY_COLOR,BODY_THIN,sPrefix+'_cr_lnose2',Scene3D,Drawer3D);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.75*modulexy,4/3*modulexy,-0.60*modulez,-(0.75*modulexy+0.005),4/3*modulexy+0.003,-0.60*modulez+0.010,BODY_COLOR,BODY_THIN,sPrefix+'_cr_maxi1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.75*modulexy,4/3*modulexy,-0.60*modulez,(0.75*modulexy+0.005),4/3*modulexy+0.003,-0.60*modulez+0.010,BODY_COLOR,BODY_THIN,sPrefix+'_cr_maxi2',Scene3D,Drawer3D);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.25*modulexy,modulexy,-2*modulez,1.25*modulexy,0.20*modulexy,-4/3*modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_mandib1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.25*modulexy,modulexy,-2*modulez,-1.25*modulexy,0.20*modulexy,-4/3*modulez,BODY_COLOR,BODY_THIN,sPrefix+'_cr_mandib2',Scene3D,Drawer3D);

 arc:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc,0,0,0,1.5*modulexy,1.5*modulexy,arctan(0.0552455357/(1.5*modulexy)),-arctan(0.0552455357/( 1.5*modulexy)),5,BODY_COLOR,BODY_THIN,sPrefix+'_sph_mouth1',Scene3D,Drawer3D);
 arc.RotateZ(pi/2);
 arc1:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipseClip(arc1,0,0,0,1.5*modulexy,1.5*modulexy,arctan(0.0552455357/(1.5*modulexy)),-arctan(0.0552455357/( 1.5*modulexy)),5,BODY_COLOR,BODY_THIN,sPrefix+'_sph_mouth2',Scene3D,Drawer3D);
 arc1.RotateZ(pi/2);
 arc.Translate(0,0.16666666667*modulexy,-(1.5*modulez-0.0140625));
 arc1.Translate(0,0.16666666667*modulexy,-(1.5*modulez-0.005625));

 //module_cz:=3.5*moduleZ;

 Scene3D.Translate(0,0,2*modulez+7*Module_cz);
 Rotule3D.x:=0;
 Rotule3D.y:= - 0.25*modulexy;
 Rotule3D.z:= ((1.75+1.25) * modulez+6.25*Module_cz);

end;
procedure CreateManPelvis(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
var Line: TLine3D;
    ellipse : TMayeSurface3D;
    Scene3D : TScene3D;
begin
 Scene3D:=Scene3DRef.Value as TScene3D;

 Ellipse:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipse(Ellipse,0,2/25*Module_cy,5*Module_cz,Module_cx/2,Module_cy/4,20,BODY_COLOR,BODY_THIN,sprefix+'_el_bassin1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,-4/25*Module_cy,5*Module_cz,0,-(1/2-2/25)*Module_cy,4.4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,-(1/2-2/25)*Module_cy,4.4*Module_cz,0,-Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin2',Scene3D,Drawer3D);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,Module_cy*(1/2-4/25),5*Module_cz,0,Module_cy/2,4.4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin3',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,Module_cy/2,4.4*Module_cz,0,Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin4',Scene3D,Drawer3D);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-(1/2-2/25)*Module_cx,2/25*Module_cy,5*Module_cz,-0.75*Module_cx,0,4.4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin5',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.75*Module_cx,0,4.4*Module_cz,-2/3*Module_cx,0,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin6',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.5*Module_cx,2/25*Module_cy,5*Module_cz,0.75*Module_cx,0,4.4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin7',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.75*Module_cx,0,4.4*Module_cz,2/3*Module_cx,0,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin8',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.75*Module_cx,0,4.4*Module_cz,0,Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin9',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.75*Module_cx,0,4.4*Module_cz,0,-Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin10',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.75*Module_cx,0,4.4*Module_cz,0,Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin11',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.75*Module_cx,0,4.4*Module_cz,0,-Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin12',Scene3D,Drawer3D);

 Rotule3D.x:=0;
 Rotule3D.y:=0;
 Rotule3D.z:=4.5*Module_cz;

end;

procedure CreateManArm(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
var Line:TLine3D; radius,x_off,z_off,y_off : extended;
    Scene3D : TScene3D;
begin

 Scene3D :=Scene3DRef.Value as TScene3D;

 radius := Module_cx/10;
 z_off :=-Module_cz/8;
 y_off :=0; //-Module_cy/5;
 x_off :=Module_cx;
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,(2/3+6)*module_cz,radius,0,5*module_cz-z_off,BODY_COLOR,BODY_THIN,sPrefix+'_li_arm1',Scene3D,Drawer3D);
 Line.Translate(x_off,y_off,z_off);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,(2/3+6)*module_cz,radius,0,5*module_cz-z_off,BODY_COLOR,BODY_THIN,sPrefix+'_li_arm2',Scene3D,Drawer3D);
 Line.RotateZ(pi/4);
 Line.Translate(x_off,y_off,z_off);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,(2/3+6)*module_cz,radius,0,5*module_cz-z_off,BODY_COLOR,BODY_THIN,sPrefix+'_li_arm3',Scene3D,Drawer3D);
 Line.RotateZ(pi/2);
 Line.Translate(x_off,y_off,z_off);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,(2/3+6)*module_cz,radius,0,5*module_cz-z_off,BODY_COLOR,BODY_THIN,sPrefix+'_li_arm4',Scene3D,Drawer3D);
 Line.RotateZ(3*pi/4);
 Line.Translate(x_off,y_off,z_off);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,(2/3+6)*module_cz,radius,0,5*module_cz-z_off,BODY_COLOR,BODY_THIN,sPrefix+'_li_arm5',Scene3D,Drawer3D);
 Line.RotateZ(pi);
 Line.Translate(x_off,y_off,z_off);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,(2/3+6)*module_cz,radius,0,5*module_cz-z_off,BODY_COLOR,BODY_THIN,sPrefix+'_li_arm6',Scene3D,Drawer3D);
 Line.RotateZ(5*pi/4);
 Line.Translate(x_off,y_off,z_off);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,(2/3+6)*module_cz,radius,0,5*module_cz-z_off,BODY_COLOR,BODY_THIN,sPrefix+'_li_arm7',Scene3D,Drawer3D);
 Line.RotateZ(6*pi/4);
 Line.Translate(x_off,y_off,z_off);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,(2/3+6)*module_cz,radius,0,5*module_cz-z_off,BODY_COLOR,BODY_THIN,sPrefix+'_li_arm8',Scene3D,Drawer3D);
 Line.RotateZ(7*pi/4);
 Line.Translate(x_off,y_off,z_off);

 Rotule3D.x:=x_off;
 Rotule3D.y:=y_off;
 Rotule3D. z:=(2/3+6)*module_cz+z_off;

end;

procedure CreateManForeArm(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
var     Line:TLine3D; radius,y_offset : extended;
        Scene3D : TScene3D;
begin
  Scene3D :=Scene3DRef.Value as TScene3D;
 radius := Module_cx/10;
 y_offset :=0; //-Module_cy/5;
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,5*module_cz,radius,0,4*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_forearm1',Scene3D,Drawer3D);
 Line.Translate(Module_cx,y_offset,0);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,5*module_cz,radius,0,4*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_forearm2',Scene3D,Drawer3D);
 Line.RotateZ(pi/4);
 Line.Translate(Module_cx,y_offset,0);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,5*module_cz,radius,0,4*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_forearm3',Scene3D,Drawer3D);
 Line.RotateZ(2*pi/4);
 Line.Translate(Module_cx,y_offset,0);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,5*module_cz,radius,0,4*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_forearm4',Scene3D,Drawer3D);
 Line.RotateZ(7*pi/4);
 Line.Translate(Module_cx,y_offset,0);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius,0,5*module_cz,radius,0,4*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_forearm5',Scene3D,Drawer3D);
 Line.RotateZ(6*pi/4);
 Line.Translate(Module_cx,y_offset,0);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-radius,0,5*module_cz,0,0,4*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_forearm6',Scene3D,Drawer3D);
 Line.Translate(Module_cx,y_offset,0);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-radius,0,5*module_cz,0,0,4*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_forearm7',Scene3D,Drawer3D);
 Line.RotateZ(pi/4);
 Line.Translate(Module_cx,y_offset,0);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-radius,0,5*module_cz,0,0,4*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_forearm8',Scene3D,Drawer3D);
 Line.RotateZ(7*pi/4);
 Line.Translate(Module_cx,y_offset,0);

 Rotule3D.y:=y_offset;
 Rotule3D.z:=5*Module_CZ;
 Rotule3D.x:=Module_CX;

end;
procedure CreateManHand(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
var {Frame:TFrame3D;} radius,y_offset,z_off : extended;
        Scene3D : TScene3D;// Frame: TMayeSurface3D;
        Line : TLine3D;
begin
 Scene3D:=Scene3DRef.Value as TScene3D;
 radius:=module_cx/10;
 y_offset := 0;//-Module_cy/5;
// Frame:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 z_off:=3.70*Module_cz-0.25*Module_cz;
 //CreateFrame(Frame,0,0,0,0.75*module_cz/2,0.5*module_cy/2,1/6*module_cy/2,BODY_COLOR,BODY_THIN,fPrefix+'_fr_hand1',fScene3D,fDrawer3D);
// //CreateFrame(Frame,0,0,0,0.60*module_cz/2,0.5*module_cy/2,1/6*module_cy/2,BODY_COLOR,BODY_THIN,sPrefix+'_fr_hand1',Scene3D,Drawer3D);
//  Frame.Keyname:=sPrefix+'_fr_hand1';
//  Frame.oType:=BODY_THIN;
//  Frame.fParent:=Scene3D;
 // Frame.Drawer3D:=Drawer3D;
 // Frame.nLong:=2;
 // Frame.nLat:=2;
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius/2+Module_cx-1/12*module_cx,y_offset-0.15*module_cy,z_off,radius/2+Module_cx-1/12*module_cx,y_offset-0.15*module_cy,z_off+0.6*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_hand1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);

 CreateLine(Line,radius/2+Module_cx-1/12*module_cx,y_offset+0.15*module_cy,z_off,radius/2+Module_cx-1/12*module_cx,y_offset+0.15*module_cy,z_off+0.6*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_hand2',Scene3D,Drawer3D);

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,radius/2+Module_cx+1/12*module_cx,y_offset-0.15*module_cy,z_off,radius/2+Module_cx+1/12*module_cx,y_offset-0.15*module_cy,z_off+0.6*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_hand3',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);

 CreateLine(Line,radius/2+Module_cx+1/12*module_cx,y_offset+0.15*module_cy,z_off,radius/2+Module_cx+1/12*module_cx,y_offset+0.15*module_cy,z_off+0.6*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_hand4',Scene3D,Drawer3D);

//  CreateMayeFrameBox(Frame,0,0,0,1/6*module_cx/2,0.5*module_cy/2,0.60*module_cz/2);
// Frame.Translate(radius/2+Module_cx,y_offset,z_off);

 Rotule3D.x:=(radius/2+Module_cx);
 Rotule3D.y:=y_Offset;
 Rotule3D.z:= z_off+0.6*Module_cz;
end;

procedure CreateManLeg(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
var     Line: TLine3D;
        offset_x : extended;
        y_off : extended;
        Scene3D : TScene3D;
begin
 Scene3D:=Scene3DRef.Value as TScene3D;
 
 offset_x:=0.25*module_cx;

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,2/3*module_cx,0,4*module_cz,0.5*module_cx,0,2.25*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_leg1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,2/3*module_cx,0,4*module_cz,0.5*module_cx,0,2.25*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_leg2',Scene3D,Drawer3D);
 Line.Translate(-offset_x,0,0);
 Line.RotateZ(pi/4);
 Line.Translate(offset_x,0,0);
 Line.translate(0,(0.25*Module_cy)-Line.y1,0);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,2/3*module_cx,0,4*module_cz,0.5*module_cx,0,2.25*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_leg3',Scene3D,Drawer3D);
 Line.Translate(-offset_x,0,0);
 Line.RotateZ(pi/2);
 Line.Translate(offset_x,0,0);
 Line.translate(0,(0.5*Module_cy)-Line.y1,0);
 Line.Translate(-Line.x1+2/6*Module_cx,0,0);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,2/3*module_cx,0,4*module_cz,0.5*module_cx,0,2.25*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_leg4',Scene3D,Drawer3D);
 Line.Translate(-offset_x,0,0);
 Line.RotateZ(3*pi/4);
 Line.Translate(offset_x,0,0);
 Line.translate(0,(0.25*Module_cy)-Line.y1,0);
 Line.translate(-4*Line.x1,0,0);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,2/3*module_cx,0,4*module_cz,0.5*module_cx,0,2.25*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_leg5',Scene3D,Drawer3D);
 Line.Translate(-offset_x,0,0);
 Line.RotateZ(pi);
 Line.Translate(offset_x,0,0);
 Line.Translate(-Line.x1,0,0);
// Arrière
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,2/3*module_cx,0,4*module_cz,0.5*module_cx,0,2.25*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_leg6',Scene3D,Drawer3D);
 Line.Translate(-offset_x,0,0);
 Line.RotateZ(3*pi/2);
 Line.Translate(offset_x,0,0);
 Line.translate(0,-(0.25*Module_cy)-Line.y1,0);
 Line.Translate(-Line.x1+2/6*Module_cx,0,0);

 Rotule3D.x:=offset_x;
 Rotule3D.y:=0;
 Rotule3D.z:=4*Module_cz;
 Scene3D.Translate(0,-0.25*Module_cy/3,0);

end;

procedure CreateManLowerLeg(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
var Line: TLine3D;
    offset_x : extended;
    z_off : extended;
    Scene3D : TScene3D;
begin
 Scene3D :=Scene3DRef.Value as TScene3D;
 z_off :=0.40;
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(2/6+1/5)*module_cx,0,z_off*module_cz,(0.5+1/5)*module_cx,0,1.5*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(0.5+1/5)*module_cx,0,1.5*module_cz,(2/6+1/5)*module_cx,0,2*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg1_1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(1/5)*module_cx,0,1.5*module_cz,(1/5)*module_cx,0,2*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg2',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(1/5)*module_cx,0,1.5*module_cz,(1/4)*module_cx,0,z_off*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg2_1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,22/60*module_cx,1/5*module_cy,2*module_cz,(22/60)*module_cx,1/5*module_cy,Z_Off*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg3',Scene3D,Drawer3D);
 offset_x:=(22/60)*module_cx;
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,22/60*module_cx,1/5*module_cy,2*module_cz,(22/60)*module_cx,1/5*module_cy,Z_off*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg4',Scene3D,Drawer3D);
 Line.Translate(-offset_x,0,0);
 line.RotateZ(7*pi/4);
 Line.Translate(offset_x,0,0);
 // Mollet
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,22/60*module_cx,-1/10*module_cy,2*module_cz,(22/60)*module_cx,-1/2*module_cy,(z_off+0.875)*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg5',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,22/60*module_cx,-1/2*module_cy,(z_off+0.875)*module_cz,(22/60)*module_cx,-1/10*module_cy,0.75*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg6',Scene3D,Drawer3D);

 Rotule3D.x:=0;
 Rotule3D.y:=0;
 Rotule3D.z:=2.2*Module_cz;

end;
procedure CreateManFoot(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
var    Line: TLine3D;
       Scene3D : TScene3D;
begin
 Scene3D :=Scene3DRef.Value as TScene3D;
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(2/6+1/5)*Module_cx,-(1/2-4/25)*module_cy,0,(2/6+1/5+0.25)*module_cx,0.5*module_cz,0,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.25*module_cx,-(1/2-4/25)*module_cy,0,0.25*module_cx,0.5*module_cy,0,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot2',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.25*module_cx,0.5*module_cy,0,(2/6+1/5+0.25)*module_cx,0.5*module_cz,0,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot3',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
// Up
 CreateLine(Line,(2/6+1/5)*Module_cx,-(1/2-4/25)*module_cy,0.33*module_cz,(2/6+1/5+0.25)*module_cx,0.5*module_cy,1/10*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot4',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.25*module_cx,-(1/2-4/25)*module_cy,0.33*module_cz,0.25*module_cx,0.5*module_cy,1/10*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot5',Scene3D,Drawer3D);
 Rotule3D.x:=(0.25*module_cx+(1/2-1/5)*Module_cx/2);
 Rotule3D.y:=-0.2*module_cy;
 Rotule3D.z:=0.33*Module_cz;

 Scene3D.Translate(0,0.35*module_cy,0);

end;
{ TWomanTHorax3D }

procedure TWomanTHorax3D.BuildBodyPart;
var module_cx,module_cy,module_cz : extended;
begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
 inherited;
 module_cy:=ModuleXY * fBody.y_factor;
 module_cx:=Modulexy * fBody.x_factor;
 module_cz:=ModuleZ * fBody.z_factor;
 // TODO : Create a specific woman thorax
 CreateManThorax(fprefix,Module_cx,module_cy,module_cz,fDrawer3D,GetScene3DRef,fRotule3D);

end;

constructor TWomanTHorax3D.Create(Body: TWomanBody3D; const sKeyname: string;
  Drawer3D: TDrawer3D; Parent: TTreeItemRef);
var module_cx,module_cy,module_cz : extended;
begin
 inherited create(sKeyname,Body,Drawer3D,Parent);
 ModuleZ:=Body.ModuleZ;
 ModuleXY:=Body.ModuleXY;
 fBody:=Body;
 fsBlockTypeName:='Thorax';

end;

{ TWoManHead3D }

procedure TWoManHead3D.BuildBodyPart;
var module_cx,module_cy,module_cz : extended;
begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
 inherited;
 module_cz:=ModuleZ * (fParentBody as TWomanBody3D).z_factor;
 module_cx:=ModuleXY * (fParentBody as TWoManBody3D).x_factor;
 module_cy:=ModuleXY * (fParentBody as TWoManBody3D).y_factor;

 radius_eyes:=0.25*Modulexy;
 tr_z:=-0.007515;

 CreateManHead(fPrefix,Module_cx,module_cy,module_cz,fDrawer3D,GetScene3DRef,fRotule3D,radius_eyes,tr_z,moduleXY,moduleZ);

end;

constructor TWoManHead3D.Create(Thorax: TWomanThorax3D;
  const sKeyname: string; ParentBody: TBody3D; Drawer3D: TDrawer3D;
  Parent: TTreeItemRef);
begin
 inherited Create(sKeyname,ParentBody,Drawer3D,Parent);
 ModuleXY:=Thorax.ModuleXY;
 ModuleZ:=Thorax.ModuleZ;

 fThorax:=Thorax;
 fsBLockTypeName:='Head';

end;

{ TWoManPelvis3D }

procedure TWoManPelvis3D.BuildBodyPart;
var module_cx,module_cy,module_cz : extended;
begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;

  inherited;
 module_cy:=ModuleXY * fThorax.fBody.y_factor;
 module_cx:=Modulexy * fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fThorax.fBody.z_factor;

 //module_c:=fThorax.fHead.modulexy*3.5;
 CreateWoManPelvis(fprefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);

end;

constructor TWoManPelvis3D.Create(Thorax: TWoManThorax3D;
  const sKeyname: string; ParentBody: TBody3D; Drawer3D: TDrawer3D;
  Parent: TTreeItemRef);
begin
 inherited Create(sKeyname,ParentBody,Drawer3D,Parent);
 ModuleZ:=Thorax.ModuleZ;
 ModuleXY:=Thorax.ModuleXY;
 fThorax:=Thorax;
 fsBlockTypeName:='Pelvis';

end;

{ TWoManArm3D }

procedure TWoManArm3D.BuildBodyPart;
var module_cx,module_cy,module_cz : extended;
begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
  inherited;
 module_cy:=ModuleXY * fThorax.fBody.y_factor;
 module_cx:=Modulexy * fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fThorax.fBody.z_factor;

// Module_c:=fThorax.fHead.Modulexy*3.5;
 CreateManArm(fPrefix,module_cx,module_cy,module_cz,fDrawer3D,GetScene3DRef,fRotule3D);

end;

constructor TWoManArm3D.create(Thorax: TWoManThorax3D;
  const sKeyname: string; ParentBody: TBody3D; Drawer3D: TDrawer3D;
  Parent: TTreeItemRef);
begin
 inherited create(sKeyname,ParentBody,Drawer3D,parent);
 ModuleZ:=Thorax.ModuleZ;
 ModuleXY:=Thorax.ModuleXY;
 fThorax:=Thorax;

end;

{ TWoManForeArm3D }

procedure TWoManForeArm3D.BuildBodyPart;
var module_cx,module_cy,module_cz : extended;
begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
 inherited;
 module_cy:=ModuleXY * fArm.fThorax.fBody.y_factor;
 module_cx:=Modulexy * fArm.fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fArm.fThorax.fBody.z_factor;

 //Module_c:=fArm.fThorax.fHead.Modulexy*3.5;
 CreateManForeArm(fprefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);

end;

constructor TWoManForeArm3D.Create(Arm: TWoManArm3D;
  const sKeyname: string; ParentBody: TBody3D; Drawer3D: TDrawer3D;
  Parent: TTreeItemRef);
begin
 inherited create(sKeyname,ParentBody,Drawer3D,parent);
 ModuleZ:=Arm.fThorax.ModuleZ;
 ModuleXY:=Arm.fThorax.ModuleXY;
 fArm:=Arm;

end;

{ TWoManHand3D }

procedure TWoManHand3D.BuildBodyPart;
var module_cx,module_cy,module_cz : extended;
begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
 inherited;
 module_cy:=ModuleXY * fForeArm.fArm.fThorax.fBody.y_factor;
 module_cx:=Modulexy * fForeArm.fArm.fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fForeArm.fArm.fThorax.fBody.z_factor;

 //Module_c:=fForeArm.fArm.fThorax.fHead.Modulexy*3.5;
 //fRotule3D.z:=fRotule3D.z + 0.5*module_Cz;
 CreateManHand(fprefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);

end;

constructor TWoManHand3D.create(ForeArm: TWoManForeArm3D;
  const sKeyname: string; ParentBody: TBody3D; Drawer3D: TDrawer3D;
  Parent: TTreeItemRef);
begin
 inherited create(sKeyname,ParentBody,Drawer3D,parent);
 ModuleZ:=ForeArm.ModuleZ;
 ModuleXY:=ForeArm.ModuleXY;
 fForeArm:=ForeArm;

end;

{ TWoManLeg3D }

procedure TWoManLeg3D.BuildBodyPart;
var module_cx,module_cy,module_cz : extended;
begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;
  inherited;
 module_cy:=ModuleXY * fPelvis.fThorax.fBody.y_factor;
 module_cx:=Modulexy * fPelvis.fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fPelvis.fThorax.fBody.z_factor;

 //module_cx:=Fpelvis.Modulexy*.5;

 CreateManLeg(fprefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);

end;

constructor TWoManLeg3D.Create(Pelvis: TWoManPelvis3D;
  const sKeyname: string; ParentBody: TBody3D; Drawer3D: TDrawer3D;
  Parent: TTreeItemRef);
begin

 inherited Create(sKeyname,ParentBody,Drawer3D,Parent);
 ModuleZ:=Pelvis.ModuleZ;
 ModuleXY:=Pelvis.ModuleXY;
 fPelvis:=Pelvis;           // Presley Elvis : P. Elvis : Pelvis

end;

{ TWoManLowerLeg3D }

procedure TWoManLowerLeg3D.BuildBodyPart;
var module_cx,module_cy,module_cz : extended;
begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;

  inherited;
 module_cy:=ModuleXY * fLeg.fPelvis.fThorax.fBody.y_factor;
 module_cx:=Modulexy * fLeg.fPelvis.fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fLeg.fPelvis.fThorax.fBody.z_factor;
 // TODO : Change this by a specific function to create th wo lowerleg
 CreateWoManLowerLeg(fPrefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D);

end;

constructor TWoManLowerLeg3D.Create(Leg: TWoManLeg3D;
  const sKeyname: string; ParentBody: TBody3D; Drawer3D: TDrawer3D;
  Parent: TTreeItemRef);
begin
 inherited Create(sKeyname,ParentBody,Drawer3D,Parent);
 ModuleZ:=Leg.ModuleZ;
 ModuleXY:=Leg.ModuleXY;
 fLeg:=Leg;

end;

{ TWoManFoot3D }

procedure TWoManFoot3D.BuildBodyPart;
var module_cx,module_cy,module_cz : extended;
begin
 (GetScene3DRef.Value as TScene3D).DeleteAllChildObjects;

  inherited;
 module_cy:=ModuleXY * fLowerLeg.fLeg.fPelvis.fThorax.fBody.y_factor;
 module_cx:=Modulexy * fLowerLeg.fLeg.fPelvis.fThorax.fBody.x_factor;
 module_cz:=ModuleZ * fLowerLeg.fLeg.fPelvis.fThorax.fBody.z_factor;

 //module_c:=fLowerLeg.fLeg.fPelvis.fThorax.fHead.modulexy*3.5;
 CreateWoManFoot(fPrefix,Module_cx,Module_cy,Module_cz,fDrawer3D,GetScene3DRef,fRotule3D, fbHeels);

end;

constructor TWoManFoot3D.Create(LowerLeg: TWoManLowerLeg3D;
  const sKeyname: string; ParentBody: TBody3D; Drawer3D: TDrawer3D;bHeels:boolean;
  Parent: TTreeItemRef);
begin
 inherited Create(sKeyname,ParentBody,Drawer3D,Parent);
 ModuleZ:=LowerLeg.ModuleZ;
 ModuleXY:=LowerLeg.ModuleXY;
 fLowerLeg:=LowerLeg;
 fbHeels:=bHeels;
end;

{ TWomanBody3D }

constructor TWomanBody3D.Create(const iModuleXY, iModuleZ: extended;
  const sKeyname: string; Drawer3D: TDrawer3D;bHeels : boolean; x_f, y_f, z_f: extended;
  Parent: TTreeItemRef);
var     CurParent:TTreeItemRef;

begin
 if Parent=nil then
  Parent:=Drawer3D.CurrentScene3DRef;

 inherited Create(sKeyname,nil,Drawer3D,Parent);

 ModuleZ:=iModuleZ;
 ModuleXY:=iModuleXY;
 x_factor:=x_f;
 y_factor:=y_f;
 z_factor:=z_f;
 fbHeels:=bHeels;
 CurParent:=Drawer3D.Scene3DTree.GetScene3DRef(sKeyname,true,nil);
 if CurParent=nil then
  raise Exception.Create('TWomanBody::Create:The scene does no longer exist');
 WomanThorax:=TWomanThorax3D.Create(Self,sKeyname+'_Thorax',Drawer3D,CurParent);
 WomanHead:=TWomanHead3D.Create(WoManThorax,sKeyname+'_Head',self,Drawer3D,CurParent);
 ArmRight :=TWoManArm3D.create(WoManThorax,sKeyname+'_ArmR',self,Drawer3D,CurParent);
 ArmLeft  :=TWoManArm3D.Create(WoManThorax,sKeyname+'_ArmL',self,Drawer3D,CurParent);
// MirroringX(ArmLeft);
 ForeArmRight := TWoManForeArm3D.Create(ArmRight,skeyname+'_ForeArmR',self,Drawer3D,CurParent);
 ForeArmLeft  := TWoManForeArm3D.Create(ArmLeft,skeyname+'_ForeArmL',self,Drawer3D,CurParent);
// MirroringX(ForeArmLeft);
 HandRight :=TWoManHand3D.Create(ForeArmRight,sKeyname+'_HandR',self,Drawer3D,CurParent);
 HandLeft  :=TWoManHand3D.create(ForeArmLeft,sKeyname+'_HandL',self,Drawer3D,CurParent);
// MirroringX(HandLeft);
 // Creation des liens entre les éléments :

 WomanPelvis:=TWoManPelvis3D.Create(WoManThorax,sKeyname+'_Pelvis',self,Drawer3D,CurParent);
 LegRight :=TWoManLeg3D.Create(WoManPelvis,sKeyname+'_LegR',self,Drawer3D,CurParent);
 LegLeft  :=TWoManLeg3D.Create(WoManPelvis,sKeyname+'_LegL',self,Drawer3D,CurParent);
// MirroringX(LegLeft);
 LowerLegRight :=TWoManLowerLeg3D.Create(LegRight,sKeyname+'_LowerLegR',self,Drawer3D,CurParent);
 LowerLegLeft  :=TWoManLowerLeg3D.Create(LegLeft,sKeyname+'_LowerLegL',self,Drawer3D,CurParent);
// MirroringX(LowerLegLeft);
 FootRight :=TWoManFoot3D.Create(LowerLegRight,sKeyname+'_FootR',self,Drawer3D,bHeels,CurParent);
 FootLeft  :=TWoManFoot3D.Create(LowerLegLeft,sKeyname+'_FootL',self,Drawer3D,bHeels,CurParent);
// MirroringX(FootLeft);

 LinkRotules;
// ResetBody;

end;

destructor TWomanBody3D.destroy;
begin
  FreeAndNil(LowerLegLeft);
  FreeAndNil(LowerLegRight);
  FreeandNil(LegRight);
  FreeAndNil(LegLeft);
  FreeAndNil(ForeArmLeft);
  FreeAndNil(ForeArmRight);
  FreeAndNil(ArmLeft);
  FreeAndNil(ArmRight);
  FreeAndNil(WoManHead);
  FreeAndNil(WoManThorax);
  FreeAndNil(WoManPelvis);
  FreeAndNil(FootRight);
  FreeAndNil(FootLeft);
  FreeAndNil(HandRight);
  FreeAndNil(HandLeft);

  inherited;

end;

function TWomanBody3D.getArmLeft: TBlock3D;
begin
 result:=ArmLeft;
end;

function TWomanBody3D.getArmRight: TBlock3D;
begin
 result:=ArmRight;
end;

function TWomanBody3D.getFootLeft: TBlock3D;
begin
 result:=FootLeft;
end;

function TWomanBody3D.getFootRight: TBlock3D;
begin
 result:=FootRight;
end;

function TWomanBody3D.getForeArmLeft: TBlock3D;
begin
 result:=ForeArmLeft;
end;

function TWomanBody3D.getForeArmRight: TBlock3D;
begin
 result:=ForeArmRight;
end;

function TWomanBody3D.GetHandLeft: TBlock3D;
begin
 result:=HandLeft;
end;

function TWomanBody3D.getHandRight: TBlock3D;
begin
 result:=HandRight;
end;

function TWomanBody3D.getHead: TBlock3D;
begin
 result:=WomanHead;
end;

function TWomanBody3D.GetHumanType: string;
begin
 result:='WOMAN';
end;

function TWomanBody3D.getLegLeft: TBlock3D;
begin
 result:=LegLeft;
end;

function TWomanBody3D.getLegRight: TBlock3D;
begin
 result:=LegRight;
end;

function TWomanBody3D.getLowerLegLeft: TBlock3D;
begin
 result:=LowerLegLeft;
end;

function TWomanBody3D.getLowerLegRight: TBlock3D;
begin
 result:=LowerLegRight;
end;

function TWomanBody3D.getPelvis: TBlock3D;
begin
 result:=WomanPelvis;
end;

function TWomanBody3D.getThorax: TBlock3D;
begin
 result:=WomanThorax;
end;

procedure CreateWoManPelvis(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
var Line: TLine3D;
    ellipse : TMayeSurface3D;
    Scene3D : TScene3D;
begin
 Scene3D:=Scene3DRef.Value as TScene3D;

 Ellipse:=Drawer3D.Scene3DTree.AddMayeSurface3D(Scene3DRef);
 CreateMayeEllipse(Ellipse,0,2/25*Module_cy,5*Module_cz,Module_cx/2,Module_cy/4,20,BODY_COLOR,BODY_THIN,sprefix+'_el_bassin1',Scene3D,Drawer3D);
 // Fesses (vue de côté)
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,-4/25*Module_cy,5*Module_cz,0,-1/2*Module_cy,4.4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,-1/2*Module_cy,4.4*Module_cz,0,-Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin2',Scene3D,Drawer3D);

 // Avant (vue de côté)
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,Module_cy*(1/2-4/25),5*Module_cz,0,Module_cy/2,4.4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin3',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0,Module_cy/2,4.4*Module_cz,0,Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin4',Scene3D,Drawer3D);

 // Cotés Droit (vue face)
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-(1/2-2/25)*Module_cx,2/25*Module_cy,5*Module_cz,-0.75*Module_cx,0,4.4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin5',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.75*Module_cx,0,4.4*Module_cz,-2/3*Module_cx,0,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin6',Scene3D,Drawer3D);
// Cotés Droit (vue face)
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.5*Module_cx,2/25*Module_cy,5*Module_cz,0.75*Module_cx,0,4.4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin7',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.75*Module_cx,0,4.4*Module_cz,2/3*Module_cx,0,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin8',Scene3D,Drawer3D);
// Avant Gauche (vue face)
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.75*Module_cx,0,4.4*Module_cz,0,Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin9',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,-0.75*Module_cx,0,4.4*Module_cz,0,-Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin10',Scene3D,Drawer3D);
 // Avant Droit  (vue face)
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.75*Module_cx,0,4.4*Module_cz,0,Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin11',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.75*Module_cx,0,4.4*Module_cz,0,-Module_cy/4,4*Module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_bassin12',Scene3D,Drawer3D);

 Rotule3D.x:=0;
 Rotule3D.y:=0;
 Rotule3D.z:=4.5*Module_cz;

end;
procedure CreateWoManLowerLeg(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D );
var Line: TLine3D;
    offset_x : extended;
    z_off : extended;
    Scene3D : TScene3D;
begin
 Scene3D :=Scene3DRef.Value as TScene3D;
 z_off :=0.40;
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(2/6+1/5)*module_cx,0,z_off*module_cz,(0.5+1/5)*module_cx,0,1.5*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(0.5+1/5)*module_cx,0,1.5*module_cz,(2/6+1/5)*module_cx,0,2*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg1_1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(1/5)*module_cx,0,1.5*module_cz,(1/5)*module_cx,0,2*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg2',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(1/5)*module_cx,0,1.5*module_cz,(1/4)*module_cx,0,z_off*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg2_1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,22/60*module_cx,1/5*module_cy,2*module_cz,(22/60)*module_cx,1/5*module_cy,Z_Off*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg3',Scene3D,Drawer3D);
 offset_x:=(22/60)*module_cx;
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,22/60*module_cx,1/5*module_cy,2*module_cz,(22/60)*module_cx,1/5*module_cy,Z_off*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg4',Scene3D,Drawer3D);
 Line.Translate(-offset_x,0,0);
 line.RotateZ(7*pi/4);
 Line.Translate(offset_x,0,0);
 // TODO : Remove the comment and change the values for the Mollet
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,22/60*module_cx,-1/10*module_cy,2*module_cz,(22/60)*module_cx,-(1/2-2/25)*module_cy,(z_off+0.875)*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg5',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,22/60*module_cx,-(1/2-2/25)*module_cy,(z_off+0.875)*module_cz,(22/60)*module_cx,-1/10*module_cy,0.75*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_lowerleg6',Scene3D,Drawer3D);

 Rotule3D.x:=0;
 Rotule3D.y:=0;
 Rotule3D.z:=2.2*Module_cz;

end;
procedure CreateWoManFoot(sPrefix : string; module_cx, module_cy, module_cz : extended; Drawer3D : TDrawer3D; Scene3DRef : TTreeItemRef; var Rotule3D : TPoint3D; bHeels:boolean );
var    Line: TLine3D;
       Scene3D : TScene3D;
       bShoe : Boolean;
       nHeel : extended;
       nPlateau : extended;
       nHeel_y : extended;
begin
 Scene3D :=Scene3DRef.Value as TScene3D;
// Bottom
 bShoe:=true; // TODO : Remove if you want to take off the shoe
 nHeel:=0.10; // hateur du talon
 nPlateau:=0.02;
 nHeel_y:=0.04;
if not bHeels then begin
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(2/6+1/5)*Module_cx,-(1/2-4/25)*module_cy,0,(2/6+1/5+0.25)*module_cx,0.5*module_cy,0,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot1',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.25*module_cx,-(1/2-4/25)*module_cy,0,0.25*module_cx,0.5*module_cy,0,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot2',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.25*module_cx,0.5*module_cy,0,(2/6+1/5+0.25)*module_cx,0.5*module_cz,0,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot3',Scene3D,Drawer3D);
// Up

 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,(2/6+1/5)*Module_cx,-(1/2-4/25)*module_cy,0.33*module_cz,(2/6+1/5+0.25)*module_cx,0.5*module_cy,1/10*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot4',Scene3D,Drawer3D);
 Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
 CreateLine(Line,0.25*module_cx,-(1/2-4/25)*module_cy,0.33*module_cz,0.25*module_cx,0.5*module_cy,1/10*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot5',Scene3D,Drawer3D);
 end else begin
  //Botom
  Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
  CreateLine(Line,(2/6+1/5)*Module_cx,-(1/2-4/25)*module_cy,0,(2/6+1/5+0.25)*module_cx,0.5*module_cy,-nHeel+nPlateau,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot1',Scene3D,Drawer3D);
  Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
  CreateLine(Line,0.25*module_cx,-(1/2-4/25)*module_cy,0,0.25*module_cx,0.5*module_cy,-nHeel+nPlateau,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot2',Scene3D,Drawer3D);
  Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
  CreateLine(Line,0.25*module_cx,0.5*module_cy,-nHeel+nPlateau,(2/6+1/5+0.25)*module_cx,0.5*module_cy,-nHeel+nPlateau,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot3',Scene3D,Drawer3D);
  // Up
  Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
  CreateLine(Line,(2/6+1/5)*Module_cx,-(1/2-8/25)*module_cy,0.33*module_cz,(2/6+1/5+0.25)*module_cx,0.5*module_cy,-nHeel+nPlateau+1/10*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot4',Scene3D,Drawer3D);
  Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
  CreateLine(Line,0.25*module_cx,-(1/2-8/25)*module_cy,0.33*module_cz,0.25*module_cx,0.5*module_cy,-nHeel+nPlateau+1/10*module_cz,BODY_COLOR,BODY_THIN,sPrefix+'_li_foot5',Scene3D,Drawer3D);
  // Heel
  Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
  CreateLine(Line,0.25*module_cx,-(1/2-4/25)*module_cy-1/10*module_cy,0,0.25*module_cx+1/10*module_cx,-(1/2-4/25)*module_cy,-nHeel,BODY_COLOR,BODY_THIN,sPrefix+'_li_heel1',Scene3D,Drawer3D);
  Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
  CreateLine(Line,0.25*module_cx,-(1/2-4/25)*module_cy+nHeel_y,-nHeel,0.25*module_cx,-(1/2-4/25)*module_cy+nHeel_y,-nHeel/2,BODY_COLOR,BODY_THIN,sPrefix+'_li_heel2',Scene3D,Drawer3D);
  Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
  CreateLine(Line,0.525*module_cx,-(1/2-4/25)*module_cy-1/10*module_cy,0,0.525*module_cx,-(1/2-4/25)*module_cy,-nHeel,BODY_COLOR,BODY_THIN,sPrefix+'_li_heel3',Scene3D,Drawer3D);
  Line:=Drawer3D.Scene3DTree.AddLine3D(Scene3DRef);
  CreateLine(Line,0.525*module_cx,-(1/2-4/25)*module_cy+nHeel_y,-nHeel,0.525*module_cx,-(1/2-4/25)*module_cy+nHeel_y,-nHeel/2,BODY_COLOR,BODY_THIN,sPrefix+'_li_heel4',Scene3D,Drawer3D);

 end;
 Rotule3D.x:=(0.25*module_cx+(1/2-1/5)*Module_cx/2);
 Rotule3D.y:=-0.2*module_cy;
 Rotule3D.z:=0.33*Module_cz;

 Scene3D.Translate(0,0.35*module_cy,0);

end;

end.

