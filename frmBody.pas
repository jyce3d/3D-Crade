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

unit frmBody;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Scene3D,Context,u3DCDecl,clsBody3D,
  Menus,bsNewDlg,bsAboutDlg;

type
  TfrmBody = class(TForm)
    btnHead: TSpeedButton;
    btnThorax: TSpeedButton;
    btnPelvis: TSpeedButton;
    btnLeg1: TSpeedButton;
    btnLeg2: TSpeedButton;
    btnLowerLeg1: TSpeedButton;
    btnLowerLeg2: TSpeedButton;
    btnFoot1: TSpeedButton;
    btnFoot2: TSpeedButton;
    btnArm1: TSpeedButton;
    btnArm2: TSpeedButton;
    btnForeArm1: TSpeedButton;
    btnForeArm2: TSpeedButton;
    btnHand1: TSpeedButton;
    btnHand2: TSpeedButton;
    Inc: TLabel;
    txtInc: TEdit;
    Label1: TLabel;
    txtPart: TEdit;
    Label2: TLabel;
    txtRotX: TEdit;
    Label3: TLabel;
    txtRotY: TEdit;
    udRotX: TUpDown;
    udRotY: TUpDown;
    MainMenu1: TMainMenu;
    mmuFile: TMenuItem;
    mmuEdit: TMenuItem;
    mmuView: TMenuItem;
    mmuFace: TMenuItem;
    mmuLeft: TMenuItem;
    mmuUp: TMenuItem;
    mmuIsometric: TMenuItem;
    Label4: TLabel;
    New1: TMenuItem;
    txtRotZ: TEdit;
    udRotz: TUpDown;
    Button1: TButton;
    mmuOpen: TMenuItem;
    mmuSave: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    mmuMan: TMenuItem;
    mmuWoman: TMenuItem;
    mmuHelp: TMenuItem;
    mmuAbout: TMenuItem;
    N1: TMenuItem;
    mmuExport: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure mmuFaceClick(Sender: TObject);
    procedure mmuLeftClick(Sender: TObject);
    procedure mmuUpClick(Sender: TObject);
    procedure mmuIsometricClick(Sender: TObject);
    procedure btnHeadClick(Sender: TObject);
    procedure udRotXClick(Sender: TObject; Button: TUDBtnType);
    procedure udRotzClick(Sender: TObject; Button: TUDBtnType);
    procedure btnHand1Click(Sender: TObject);
    procedure btnForeArm1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnArm1Click(Sender: TObject);
    procedure btnThoraxClick(Sender: TObject);
    procedure btnArm2Click(Sender: TObject);
    procedure btnForeArm2Click(Sender: TObject);
    procedure btnHand2Click(Sender: TObject);
    procedure btnPelvisClick(Sender: TObject);
    procedure btnLeg1Click(Sender: TObject);
    procedure btnLeg2Click(Sender: TObject);
    procedure btnLowerLeg1Click(Sender: TObject);
    procedure btnLowerLeg2Click(Sender: TObject);
    procedure btnFoot1Click(Sender: TObject);
    procedure btnFoot2Click(Sender: TObject);
    procedure udRotYClick(Sender: TObject; Button: TUDBtnType);
    procedure mmuOpenClick(Sender: TObject);
    procedure mmuSaveClick(Sender: TObject);
    procedure mmuManClick(Sender: TObject);
    procedure mmuWomanClick(Sender: TObject);
    procedure mmuAboutClick(Sender: TObject);
    procedure mmuExportClick(Sender: TObject);
  private
    { Private declarations }
    fDrawer : TDrawer3D;
    fContext : TCustomContext;
(*    Head : TManHead3D;
    Thorax : TManThorax3D;
    Pelvis : TManPelvis3D;
    Arm1,Arm2 : TManArm3D;
    ForeArm1,ForeArm2 : TManForeArm3D;
    Leg1,Leg2 : TManLeg3D;
    LowerLeg1,LowerLeg2 : TManLowerLeg3D;
    Foot1,Foot2 : TManFoot3D;
    Hand1,Hand2 : TManHand3D;*)
    Body  : TBody3D;
    fCurrentSelection : TBlock3D;

    wnd_Height, wnd_Width : integer;
    fudRotXold, fudRotYOld, fudRotZOld : integer;
    function RefreshView : integer;
    procedure ClearScreen;
  public
    { Public declarations }
    fModuleXY,
    fModuleZ,
    fXFactor,
    fYFactor,
    fZFactor : extended;
    fKeyname : string;
    procedure TextBoxRefresh;
  end;

var
  g_frmBody: TfrmBody;

implementation

{$R *.DFM}

procedure TfrmBody.FormCreate(Sender: TObject);
var scale : extended;
begin
 scale:=700;
 fDrawer:=TDrawer3D.create;
 fContext:=TCustomContext.create;

 InitSystemVariables3D(fContext);
 wnd_Height:=ClientHeight;
 wnd_Width:=ClientWidth div 2;

 LeftView(fContext);
 SetScale(round(scale),fContext);
 fContext.SetFloatValue('_ViewAxes',0);
 fContext.SetFloatValue('_PolygonFrames',1);
 fContext.SetFloatValue('_ZTranslate',-1);

 Body:=nil;
 fCurrentSelection :=nil;

 udRotY.Position:=0;
 udRotX.Position:=0;
 udRotZ.Position:=0;
 fudRotXold:=0;
 fudRotYOld:=0;
 fUdRotZOld:=0;
end;

procedure TfrmBody.FormDestroy(Sender: TObject);
begin
 fContext.free;
 fDrawer.free;
 if Body<>Nil then
  Body.Free;
end;

function TfrmBody.RefreshView: integer;
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
 with fContext do begin
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
 fDrawer.ShowScene3D(Self,
                               RhoEye,
                               Colatiteye,
                               Azimutheye,
                               Zeye,
                               Scale,
                               viewaxes,
                               polygonframes,
                               xTranslate, yTranslate, zTranslate,
                               CursorInc,
                               Wnd_Width,Wnd_Height);
 result:=0;
end;

procedure TfrmBody.ClearScreen;
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
  Right:=Wnd_Width;
  Bottom:=Wnd_Height;
 end;
 Canvas.FillRect(Rectangle);
 Canvas.Brush:=OldBrush;
 CurrentBrush.Free;
end;


procedure TfrmBody.FormPaint(Sender: TObject);
begin
 RefreshView;
end;


procedure TfrmBody.mmuFaceClick(Sender: TObject);
begin
 FaceView(fContext);
 Invalidate;
end;

procedure TfrmBody.mmuLeftClick(Sender: TObject);
begin
 LeftView(fContext);
 Invalidate;
end;

procedure TfrmBody.mmuUpClick(Sender: TObject);
begin
 UpView(fContext);
 Invalidate;
end;

procedure TfrmBody.mmuIsometricClick(Sender: TObject);
begin
 IsometricView(fContext);
 Invalidate;

end;



procedure TfrmBody.btnHeadClick(Sender: TObject);
begin
 if Body<>nil then
 begin
  fCurrentSelection:=Body.Head;
  self.txtPart.text:='Head';
  txtRotX.Text:=FloatTostr(fCurrentSelection.fRxphi);
  udRotX.Position:=fCurrentSelection.fXPosition;
  txtRotY.Text:=FloatTostr(fCurrentSelection.fRYphi);
  udRotY.Position:=fCurrentSelection.fYPosition;
  txtRotZ.Text:=FloatTostr(fCurrentSelection.fRzteta);
  udRotZ.Position:=fCurrentSelection.fZPosition;

 end;
 // Test de barycentre
 //fCurrentSelection.SetToOrigin;
// Invalidate;
end;



procedure TfrmBody.udRotXClick(Sender: TObject; Button: TUDBtnType);
var eInc,eFinal : extended;
begin
 eInc:=fContext.EvalFloat(TxtInc.Text);
 eFinal:=eInc*Round(UdRotX.Position);

 if fCurrentSelection<>nil then begin
  fCurrentSelection.fXPosition:=UdRotX.Position;

  fCurrentSelection.RotateX(eFinal);
  txtRotX.Text:=FloatTostr(eFinal);

  Invalidate;

 end;

end;

procedure TfrmBody.udRotzClick(Sender: TObject; Button: TUDBtnType);
var eInc,eFinal : extended;
begin
 eInc:=fContext.EvalFloat(TxtInc.Text);

 eFinal:=eInc*Round(UdRotZ.Position);
 if fCurrentSelection<>nil then begin
  fCurrentSelection.fZPosition:=UdRotZ.Position;

  fCurrentSelection.RotateZ(eFinal);
  txtRotZ.Text:=FloatTostr(eFinal);

  Invalidate;

 end;

end;

procedure TfrmBody.btnHand1Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.HandRight;
  self.txtPart.text:='HandRight';
  txtRotX.Text:=FloatTostr(fCurrentSelection.fRxphi);
  udRotX.Position:=fCurrentSelection.fXPosition;
  txtRotY.Text:=FloatTostr(fCurrentSelection.fRYphi);
  udRotY.Position:=fCurrentSelection.fYPosition;
  txtRotZ.Text:=FloatTostr(fCurrentSelection.fRzteta);
  udRotZ.Position:=fCurrentSelection.fZPosition;

  Invalidate;
//  Invalidate;
 end;

end;

procedure TfrmBody.btnForeArm1Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.ForeArmRight;
  txtPart.text:='ForeArmRight';
  txtRotX.Text:=FloatTostr(fCurrentSelection.fRxphi);
  udRotX.Position:=fCurrentSelection.fXPosition;
  txtRotY.Text:=FloatTostr(fCurrentSelection.fRYphi);
  udRotY.Position:=fCurrentSelection.fYPosition;
  txtRotZ.Text:=FloatTostr(fCurrentSelection.fRzteta);
  udRotZ.Position:=fCurrentSelection.fZPosition;

  //fCurrentSelection.SetToOrigin;
  //fCurrentSelection.SetToOrigin;
  Invalidate;
 end;

end;

procedure TfrmBody.Button1Click(Sender: TObject);
begin
 if fCurrentSelection<>nil then
  fCurrentSelection.SetToOrigin;
 Invalidate;
end;

procedure TfrmBody.btnArm1Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.ArmRight;
  txtPart.text:='ArmRight';
  txtRotX.Text:=FloatTostr(fCurrentSelection.fRxphi);
  udRotX.Position:=fCurrentSelection.fXPosition;
  txtRotY.Text:=FloatTostr(fCurrentSelection.fRYphi);
  udRotY.Position:=fCurrentSelection.fYPosition;
  txtRotZ.Text:=FloatTostr(fCurrentSelection.fRzteta);
  udRotZ.Position:=fCurrentSelection.fZPosition;

  Invalidate;
 end;

end;

procedure TfrmBody.btnThoraxClick(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.Thorax;
  txtPart.text:='Thorax';
  txtRotX.Text:=FloatTostr(fCurrentSelection.fRxphi);
  udRotX.Position:=fCurrentSelection.fXPosition;
  txtRotY.Text:=FloatTostr(fCurrentSelection.fRYphi);
  udRotY.Position:=fCurrentSelection.fYPosition;
  txtRotZ.Text:=FloatTostr(fCurrentSelection.fRzteta);
  udRotZ.Position:=fCurrentSelection.fZPosition;

  Invalidate;
 end;

end;

procedure TfrmBody.btnArm2Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.ArmLeft;
  txtPart.text:='ArmLeft';
  txtRotX.Text:=FloatTostr(fCurrentSelection.fRxphi);
  udRotX.Position:=fCurrentSelection.fXPosition;
  txtRotY.Text:=FloatTostr(fCurrentSelection.fRYphi);
  udRotY.Position:=fCurrentSelection.fYPosition;
  txtRotZ.Text:=FloatTostr(fCurrentSelection.fRzteta);
  udRotZ.Position:=fCurrentSelection.fZPosition;

  Invalidate;
 end;


end;

procedure TfrmBody.btnForeArm2Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.ForeArmLeft;
  txtPart.text:='ForeArmLeft';
  txtRotX.Text:=FloatTostr(fCurrentSelection.fRxphi);
  udRotX.Position:=fCurrentSelection.fXPosition;
  txtRotY.Text:=FloatTostr(fCurrentSelection.fRYphi);
  udRotY.Position:=fCurrentSelection.fYPosition;
  txtRotZ.Text:=FloatTostr(fCurrentSelection.fRzteta);
  udRotZ.Position:=fCurrentSelection.fZPosition;

  //fCurrentSelection.SetToOrigin;
  //fCurrentSelection.SetToOrigin;
  Invalidate;
 end;

end;

procedure TfrmBody.btnHand2Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.HandLeft;
  self.txtPart.text:='HandLeft';
  TextBoxRefresh;
  //  Invalidate;
 end;

end;

procedure TfrmBody.btnPelvisClick(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.Pelvis;
  self.txtPart.text:='Pelvis';
  TextBoxRefresh;
//  Invalidate;
 end;

end;

procedure TfrmBody.TextBoxRefresh;
begin
  txtRotX.Text:=FloatTostr(fCurrentSelection.fRxphi);
  udRotX.Position:=fCurrentSelection.fXPosition;
  txtRotY.Text:=FloatTostr(fCurrentSelection.fRYphi);
  udRotY.Position:=fCurrentSelection.fYPosition;
  txtRotZ.Text:=FloatTostr(fCurrentSelection.fRzteta);
  udRotZ.Position:=fCurrentSelection.fZPosition;

  Invalidate;

end;

procedure TfrmBody.btnLeg1Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.LegRight;
  self.txtPart.text:='LegRight';
  TextBoxRefresh;
//  Invalidate;
 end;

end;

procedure TfrmBody.btnLeg2Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.LegLeft;
  self.txtPart.text:='LegLeft';
  TextBoxRefresh;
//  Invalidate;
 end;

end;

procedure TfrmBody.btnLowerLeg1Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.LowerLegRight;
  self.txtPart.text:='LowerLegRight';
  TextBoxRefresh;
//  Invalidate;
 end;

end;

procedure TfrmBody.btnLowerLeg2Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.LowerLegLeft;
  self.txtPart.text:='LowerLegLeft';
  TextBoxRefresh;
//  Invalidate;
 end;


end;

procedure TfrmBody.btnFoot1Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.FootRight;
  self.txtPart.text:='FootRight';
  TextBoxRefresh;
//  Invalidate;
 end;

end;

procedure TfrmBody.btnFoot2Click(Sender: TObject);
begin
if Body<>nil then
 begin
  fCurrentSelection:=Body.FootLeft;
  self.txtPart.text:='FootLeft';
  TextBoxRefresh;
//  Invalidate;
 end;

end;



procedure TfrmBody.udRotYClick(Sender: TObject; Button: TUDBtnType);
var eInc,eFinal : extended;
begin
 eInc:=fContext.EvalFloat(TxtInc.Text);

 eFinal:=eInc*Round(UdRotY.Position);
 if fCurrentSelection<>nil then begin
  fCurrentSelection.fYPosition:=UdRotY.Position;
  fCurrentSelection.RotateY(eFinal);
  txtRotY.Text:=FloatTostr(eFinal);

  Invalidate;

 end;
end;

procedure TfrmBody.mmuOpenClick(Sender: TObject);
begin
  OpenDialog.Filter:='Body Sculptor XML data file (*.xml)|*.xml';
  OpenDialog.DefaultExt:='xml';
  OpenDIalog.FilterIndex:=1;
  openDialog.Options:=openDialog.Options -[ofExtensionDifferent];
  if OpenDIalog.Execute then begin

   if OpenDialog.FileName<>'' then
    CreateAndLoadXmlBody(OpenDialog.FileName,Body,fDrawer);
  end;
 Invalidate;
end;

procedure TfrmBody.mmuSaveClick(Sender: TObject);
begin
 try
  SaveDialog.Execute;
  if SAveDialog.FileName<>'' then
  Body.SaveXmlBody(SaveDialog.Filename)
 except
  on e:Exception do
   raise Exception.Create(e.Message);
 end;

end;

procedure TfrmBody.mmuManClick(Sender: TObject);
begin
 //module:=;
 // Cold Play : Speed of sound
 OkRightDlg:=TOkRightDlg.Create(Self);
 OkRightDlg.txtKeyname.Text:='ManBody';
 OkRightDlg.txtModuleXY.Text:=floattostr(0.225/3.5);
 OkRightDlg.txtModuleZ.Text:=OkRightDlg.txtModuleXY.Text;
 OkRightDlg.chkHeels.Visible:=false;

 OkRightDlg.ShowModal;


 if Body<>nil then
  FreeAndNil(Body);
 Body:=TManBody3D.Create(fmoduleXY,fModuleZ,'WoManTst',fDrawer,fXFactor,fYFactor,fZFactor);
 Body.ResetBody;
 Invalidate;

end;

procedure TfrmBody.mmuWomanClick(Sender: TObject);
begin
 OkRightDlg:=TOkRightDlg.Create(Self);
 OkRightDlg.txtKeyname.Text:='WomanBody';
 OkRightDlg.txtModuleXY.Text:=floattostr(0.2125/3.5);
 OkRightDlg.txtModuleZ.Text:=OkRightDlg.txtModuleXY.Text;
 OkRightDlg.chkHeels.Visible:=true;

 OkRightDlg.ShowModal;

 if Body<>nil then
  FreeAndNil(Body);
 Body:=TWoManBody3D.Create(fmoduleXY,fmoduleZ,'WoManTst',fDrawer,OkRightDlg.chkHeels.Checked,fXFactor,fYFactor,fZFactor);
 Body.ResetBody;
 Invalidate;

end;

procedure TfrmBody.mmuAboutClick(Sender: TObject);
begin
 OKBottomDlg:=TOKBottomDlg.Create(self);
 OKBottomDlg.SHowModal;
end;

procedure TfrmBody.mmuExportClick(Sender: TObject);
begin
 try
  SaveDialog.Execute;
  if SAveDialog.FileName<>'' then
   fDrawer.SaveToXmlFile(SaveDialog.Filename);
  //Body.SaveXmlBody()
 except
  on e:Exception do
   raise Exception.Create(e.Message);
 end;

end;

end.
