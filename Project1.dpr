program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmMain},
  Parser in 'Parser.pas',
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {frmViewer},
  Scene3D in 'Scene3D.pas',
  Context in 'Context.pas',
  MatrixWaste in 'MatrixWaste.pas',
  frmViewObjects in 'frmViewObjects.pas' {frm3DObject},
  MayeSurf in 'MayeSurf.pas',
  frm_blockedit in 'frm_blockedit.pas' {frmBlockEdit},
  frm_inputBlock in 'frm_inputBlock.pas' {frmInputBlock},
  CustomTree in 'CustomTree.pas',
  FRM_Translate in 'FRM_Translate.pas' {frmTranslate},
  FRM_FrameBox in 'FRM_FrameBox.pas' {frmFrameBox},
  CustomParser in 'CustomParser.pas',
  CustomList in 'CustomList.pas',
  frm_About in 'frm_About.pas' {AboutBox},
  FRM_Ellipse in 'FRM_Ellipse.pas' {frmEllipse};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '3D Crade';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(Tfrm3DObject, frm3DObject);
  Application.CreateForm(TfrmViewer, frmViewer);
  Application.CreateForm(TfrmEllipse, frmEllipse);
  frmMain.ResizeInnerForms;
  Application.Run;
end.
