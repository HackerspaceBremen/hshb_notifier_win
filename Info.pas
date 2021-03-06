unit Info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, PJVersionInfo, ShellAPI;

type
  TfrmInfo = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    laVersion: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    viVersionInfo: TPJVersionInfo;
    laHackerspace: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure laHackerspaceClick(Sender: TObject);
    procedure laVersionClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmInfo: TfrmInfo;

implementation

{$R *.dfm}

procedure TfrmInfo.FormShow(Sender: TObject);
begin
  viVersionInfo.Filename := Application.ExeName;

  with viVersionInfo do
  laVersion.Caption := Format('Version %d.%d.%d, Build %d',
    [FileVersionNumber.V1, FileVersionNumber.V2, FileVersionNumber.V3, FileVersionNumber.V4]);
end;

procedure TfrmInfo.laHackerspaceClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('http://www.hackerspace-bremen.de/'), '', '', SW_SHOWNORMAL);
end;

procedure TfrmInfo.laVersionClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('http://hshb.de/osnwin'), '', '', SW_SHOWNORMAL);
end;

end.
