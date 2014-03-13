unit Properties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JvComponentBase, JvXPCore, JclRegistry, ShellAPI;

type
  TfrmProperties = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    cbBalloonNotification: TCheckBox;
    cbSoundNotification: TCheckBox;
    btnConfigureSound: TButton;
    cbAutostart: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    cbUseTestBackend: TCheckBox;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfigureSoundClick(Sender: TObject);
    procedure cbSoundNotificationClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

const
  strRegPathRun = '\Software\Microsoft\Windows\CurrentVersion\Run';
  strRegPathApp = '\Software\Jens Bretschneider\';

var
  frmProperties: TfrmProperties;

implementation

{$R *.dfm}

procedure TfrmProperties.btnCancelClick(Sender: TObject);
begin
  frmProperties.Close;
end;

procedure TfrmProperties.FormShow(Sender: TObject);
var
  s: string;
begin
  s := RegReadStringDef(HKEY_CURRENT_USER, strRegPathRun, Application.Title, '');
  cbAutostart.Checked := (s = Application.ExeName);

  cbBalloonNotification.Checked := RegReadBoolDef(HKEY_CURRENT_USER, strRegPathApp + Application.Title,
    'BalloonNotification', true);
  cbSoundNotification.Checked := RegReadBoolDef(HKEY_CURRENT_USER, strRegPathApp + Application.Title,
    'SoundNotification', true);
  cbUseTestBackend.Checked := RegReadBoolDef(HKEY_CURRENT_USER, strRegPathApp + Application.Title,
    'UseTestBackend', false);

  cbUseTestBackend.Visible := (GetAsyncKeyState(VK_SHIFT) and $8000 <> 0);

  cbSoundNotification.OnClick(self);
end;

procedure TfrmProperties.btnConfigureSoundClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('control.exe'), PChar('mmsys.cpl sounds'), '', SW_SHOWNORMAL);
end;

procedure TfrmProperties.cbSoundNotificationClick(Sender: TObject);
begin
  btnConfigureSound.Enabled := cbSoundNotification.Checked;
end;

procedure TfrmProperties.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOK then begin

    if cbAutostart.Checked then begin
      RegWriteString(HKEY_CURRENT_USER, strRegPathRun, Application.Title, Application.ExeName);
    end else begin
      try
        RegDeleteEntry(HKEY_CURRENT_USER, strRegPathRun, Application.Title)
      except
      end;
    end;

    RegWriteBool(HKEY_CURRENT_USER, strRegPathApp + Application.Title,
      'BalloonNotification', cbBalloonNotification.Checked);
    RegWriteBool(HKEY_CURRENT_USER, strRegPathApp + Application.Title,
      'SoundNotification', cbSoundNotification.Checked);
    RegWriteBool(HKEY_CURRENT_USER, strRegPathApp + Application.Title,
      'UseTestBackend', cbUseTestBackend.Checked);

  end;
end;

end.
