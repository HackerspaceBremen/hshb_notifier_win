program osn;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Properties in 'Properties.pas' {frmProperties},
  Backend in 'Backend.pas',
  Info in 'Info.pas' {frmInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Open Space Notifier';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmProperties, frmProperties);
  Application.CreateForm(TfrmInfo, frmInfo);
  Application.ShowMainForm := false;
  Application.Run;
end.
