program BodySculpt;

uses
  Forms,
  frmBody in 'frmBody.pas' {frmBOdy},
  Context in 'Context.pas',
  Scene3D in 'Scene3D.pas',
  u3DCDecl in 'u3DCDecl.pas',
  clsBody3D in 'clsBody3D.pas',
  BSNewDlg in 'BSNewDlg.pas' {OKRightDlg},
  BSAboutDlg in 'BSAboutDlg.pas' {OKBottomDlg};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBody, g_frmBody);
  Application.Run;
end.
