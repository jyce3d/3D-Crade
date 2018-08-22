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

//Auteur:Jyce3d, 2003
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus,Parser,Scene3D, Context,Unit4,u3DCDecl;

type
  TfrmMain = class(TForm)
    SMM: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    View1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    mmuBloc: TMenuItem;
    mmNew: TMenuItem;
    N2: TMenuItem;
    mmuModify: TMenuItem;
    N3: TMenuItem;
    Run1: TMenuItem;
    Cascade1: TMenuItem;
    Tile1: TMenuItem;
    Operation1: TMenuItem;
    Translate1: TMenuItem;
    New1: TMenuItem;
    View2: TMenuItem;
    Face1: TMenuItem;
    Left1: TMenuItem;
    Up1: TMenuItem;
    Isometric1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Mesh1: TMenuItem;
    mnuEllipse: TMenuItem;
    mnuArc: TMenuItem;
    mnuLine: TMenuItem;
    N4: TMenuItem;
    mnuFrameBox: TMenuItem;
    mnuSphere: TMenuItem;
    mnuEllipsoid: TMenuItem;
    mnuArcoid: TMenuItem;
    mmuBkImport: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure mmNewClick(Sender: TObject);
    procedure mmuModifyClick(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
    procedure Tile1Click(Sender: TObject);
    procedure Run1Click(Sender: TObject);
    procedure Translate1Click(Sender: TObject);
    procedure Face1Click(Sender: TObject);
    procedure Left1Click(Sender: TObject);
    procedure Up1Click(Sender: TObject);
    procedure Isometric1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure mnuFrameBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mmuBkImportClick(Sender: TObject);
  private
    { Private declarations }
    fStatement:TParser;

  public
    { Public declarations }
    fcontext:TCustomContext;
    fDrawer3D:TDrawer3D;
    BlockName:string;
    procedure RefreshView;
    procedure DisplayEditBlock;
    procedure ResizeInnerForms;
  end;

var
  frmMain: TfrmMain;

implementation

uses Unit3, frmViewObjects, frm_blockedit, frm_inputBlock,strlib,
  FRM_Translate, FRM_FrameBox, frm_About;

{$R *.DFM}

procedure TfrmMain.FormDestroy(Sender: TObject);

begin
fContext.free;
fDrawer3D.free;
fStatement.Free;
end;


procedure TfrmMain.RefreshView;
begin
 if frmViewer<>nil then
  frmViewer.Invalidate;
 if frm3DObject<>nil then
   frm3DObject.Initalize_Objects(FDrawer3D);


end;


procedure TfrmMain.Save1Click(Sender: TObject);
begin
 try
  SaveDialog.Execute;
  if SAveDialog.FileName<>'' then
  fDrawer3D.SaveToXmlFile(SaveDialog.Filename)
 except
  on e:Exception do
   raise Exception.Create(e.Message);
 end;
end;

procedure TfrmMain.Open1Click(Sender: TObject);
begin
  OpenDialog.Filter:='3D Crade XML data file (*.xml)|*.xml';
  OpenDialog.DefaultExt:='xml';
  OpenDIalog.FilterIndex:=1;
  openDialog.Options:=openDialog.Options -[ofExtensionDifferent];
  if OpenDIalog.Execute then begin

   if OpenDialog.FileName<>'' then
   begin
    fDrawer3D.LoadFromXmlFile(OpenDialog.FileName,fContext);
    RefreshView;
   end;
  end;
end;

procedure TfrmMain.mmNewClick(Sender: TObject);
begin
  BlockName:='';
  DisplayEditBlock;
end;

procedure TfrmMain.mmuModifyClick(Sender: TObject);
begin
 frmInputBlock:=TFrmInputBlock.Create(self);
 frmInputBlock.Show;
end;

procedure TfrmMain.DisplayEditBlock;
begin
  frmBlockEdit:=TFrmBlockEdit.Create(self);
  frmBLockEdit.Show;

end;

procedure TfrmMain.Cascade1Click(Sender: TObject);
begin
 Cascade;
end;

procedure TfrmMain.Tile1Click(Sender: TObject);
begin
 Tile;
end;

procedure TfrmMain.Run1Click(Sender: TObject);
var slScript:TStringList;

begin

  slScript:=TStringList.Create;

  OpenDialog.Filter:='3D Crade Scripting file (*.3ds)|*.3ds';
  OpenDialog.DefaultExt:='3ds';
  OpenDIalog.FilterIndex:=1;
  openDialog.Options:=openDialog.Options -[ofExtensionDifferent];

  if OpenDialog.Execute then begin
   slScript.LoadFromFile(OpenDialog.Filename);
   fStatement.Execute(slScript);
  end;
  RefreshView;
  slScript.Free;

(*  slScript:=TStringList.Create;

  if OpenDialog.Execute then begin
   slScript.LoadFromFile(OpenDialog.Filename);

   for i:=0 to slScript.Count -1 do
   begin
    strLine:=slScript.Strings[i];
    strLine:=Trim(strLine);
    if strLine<>'' then begin
     if (strFunc.left(strLine,2)<>'//') then
      try
       fStatement.Parse(slScript.Strings[i],sCommand,sContent);
      except
       raise Exception.Create('Script error in line :'+inttostr(i+1));
      end;
    end;
   end;

  end;
 RefreshView;
 slScript.Free;
 *)
end;

procedure TfrmMain.Translate1Click(Sender: TObject);
begin
 frmTranslate:=TfrmTranslate.Create(self);
 frmTranslate.ShowModal;
end;

procedure TfrmMain.Face1Click(Sender: TObject);
begin
 FaceView(frmMain.fContext);
 frmMain.RefreshView;

end;

procedure TfrmMain.Left1Click(Sender: TObject);
begin
 LeftView(frmMain.fContext);
 frmMain.RefreshView;

end;

procedure TfrmMain.Up1Click(Sender: TObject);
begin
 UpView(frmMain.fContext);
 frmMain.RefreshView;

end;

procedure TfrmMain.Isometric1Click(Sender: TObject);
begin
 IsometricView(frmMain.fContext);
 frmMain.RefreshView;

end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
 Application.Terminate;
end;



procedure TfrmMain.About1Click(Sender: TObject);
begin
 AboutBOx:=TAboutBox.Create(self);
 AboutBox.ShowModal;
end;

procedure TfrmMain.mnuFrameBoxClick(Sender: TObject);
begin
 frmFrameBox:=TfrmFrameBox.Create(self);
 frmFrameBox.ShowModal;
end;


procedure TfrmMain.FormCreate(Sender: TObject);
var slOutput:TStringList;
begin
 // Main Window

 // Create MDI Forms:
 // Form3:=TForm3.Create(Self);
  //frmViewer:=TFrmViewer.Create(self);

// frm3DObject:=Tfrm3DObject.Create(self);
 //frmViewer:=nil;
 // Creation du contexte contenant les variables et évaluateurs divers
 BlockName:='';
 fContext:=TCustomContext.Create;
 // Création de la structure de donnée 3D
 fDrawer3D:=TDrawer3D.create;
 // Initialisation variable système
 InitSystemVariables3D(fcontext);
 slOutput:=TStringList.Create;
 fStatement:=TParser.Create(FContext,fDrawer3D,slOutput);
 slOutput.Free;

end;

procedure TfrmMain.ResizeInnerForms;
begin
  // Object Browser
  frm3DObject.Top := 0;
  frm3DObject.Width := 200;
  frm3DObject.Height := (FrmMain.ClientRect.Bottom - FrmMain.ClientRect.Top) - 4 {SMM.Height};
  frm3DObject.Left   := (FrmMain.ClientRect.Right - FrmMain.ClientRect.Left) - frm3DObject.Width - 4 {border};
  // Command Editor
  Form3.left := 0;
  Form3.Height := 150;
  Form3.top := frm3DObject.height - Form3.Height;
  Form3.width := frm3DObject.Left -1 ;
  // Viewer
  frmViewer.Top := 0;
  frmViewer.Left := 0;
  frmViewer.Height := frm3DObject.Height - Form3.Height - 1;
  frmViewer.Width  := Form3.Width;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  // This event could be called too early
  try ResizeInnerForms; except end;
end;

procedure TfrmMain.mmuBkImportClick(Sender: TObject);
begin
  OpenDialog.Filter:='3D Crade XML data file (*.xml)|*.xml';
  OpenDialog.DefaultExt:='xml';
  OpenDIalog.FilterIndex:=1;
  openDialog.Options:=openDialog.Options -[ofExtensionDifferent];
  if OpenDIalog.Execute then begin

   if OpenDialog.FileName<>'' then
   begin
    fDrawer3D.ImportFromXmlFile(OpenDialog.FileName);
    RefreshView;
   end;
  end;

end;

end.
