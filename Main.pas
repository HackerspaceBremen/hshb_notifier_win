unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, JvMenus, JvComponentBase, JvTrayIcon, ShellAPI, Properties,
  ExtCtrls, BomeOneInstance, MMSystem, JvXPCore, XPMan, Backend, JclRegistry;

type
  TfrmMain = class(TForm)
    pmMenu: TJvPopupMenu;
    miExit: TMenuItem;
    tiTrayIcon: TJvTrayIcon;
    miShowState: TMenuItem;
    N1: TMenuItem;
    miChangeState: TMenuItem;
    N2: TMenuItem;
    miInfo: TMenuItem;
    N3: TMenuItem;
    miProperties: TMenuItem;
    tiTimer: TTimer;
    oiOneInstance: TOneInstance;
    XPManifest: TXPManifest;
    miHomepage: TMenuItem;
    miTestBackendEnabled: TMenuItem;
    procedure miExitClick(Sender: TObject);
    procedure miShowStateClick(Sender: TObject);
    procedure tiTrayIconDblClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miChangeStateClick(Sender: TObject);
    procedure miPropertiesClick(Sender: TObject);
    procedure miInfoClick(Sender: TObject);
    procedure tiTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miHomepageClick(Sender: TObject);
    procedure pmMenuPopup(Sender: TObject);
  private
    { Private-Deklarationen }
    backend: TBackend;
  public
    { Public-Deklarationen }
    procedure DoShowState(aForce: boolean);
  end;

var
  frmMain: TfrmMain;

implementation

uses Info, InnoSetup;

{$R *.dfm}

procedure TfrmMain.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.miShowStateClick(Sender: TObject);
begin
  DoShowState(true);
end;

procedure TfrmMain.tiTrayIconDblClick(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  miShowState.Click;
end;

procedure TfrmMain.miChangeStateClick(Sender: TObject);
begin
  if RegReadBoolDef(HKEY_CURRENT_USER, strRegPathApp + Application.Title, 'UseTestBackend', false) then
    ShellExecute(0, 'OPEN', PChar('https://testhackerspacehb.appspot.com/'), '', '', SW_SHOWNORMAL)
  else
    ShellExecute(0, 'OPEN', PChar('https://hackerspacehb.appspot.com/'), '', '', SW_SHOWNORMAL)
end;

procedure TfrmMain.miPropertiesClick(Sender: TObject);
begin
  if not frmProperties.Visible then
    frmProperties.Show
  else
    frmProperties.BringToFront;
end;

procedure TfrmMain.miInfoClick(Sender: TObject);
begin
  frmInfo.Show;
end;

procedure TfrmMain.tiTimerTimer(Sender: TObject);
begin
  DoShowState(false);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  BackendURL: string;
begin
  CreateMutexes('osn');

  if RegReadBoolDef(HKEY_CURRENT_USER, strRegPathApp + Application.Title, 'UseTestBackend', false) then
    BackendURL := 'https://testhackerspacehb.appspot.com/v2/status'
  else
    BackendURL := 'https://hackerspacehb.appspot.com/v2/status';
  Backend := TBackend.Create(BackendURL);

  DoShowState(false);
end;

procedure TfrmMain.DoShowState(aForce: boolean);
var
  strState: string;
  strHeadline: string;
  strBody: string;
  strIcon: string;
  strSound: string;
  boolBalloonNotification: bool;
  boolSoundNotification: bool;
  boolHasChanged: bool;
begin
  boolBalloonNotification := RegReadBoolDef(HKEY_CURRENT_USER, strRegPathApp + Application.Title, 'BalloonNotification', true);
  boolSoundNotification   := RegReadBoolDef(HKEY_CURRENT_USER, strRegPathApp + Application.Title, 'SoundNotification', true);

  Backend.Read;
  boolHasChanged := Backend.HasChanged;

  if Backend.Error then begin
    strIcon     := 'icon error.ico';
    strHeadline := 'Fehler';
    strBody     := Backend.ErrorMsg;
  end else begin
    if Backend.Open then begin
      strState := 'Geöffnet';
      strIcon  := 'icon open.ico';
      strSound := 'SpaceOpened';
    end else begin
      strState := 'Geschlossen';
      strIcon  := 'icon closed.ico';
      strSound := 'SpaceClosed';
    end;
    strHeadline := Format('%s seit %s Uhr', [strState, FormatDateTime('ddd h:nn', Backend.LastChange)]);
    if backend.Status <> '' then
      strBody     := Backend.Status
    else
      strBody     := '(Keine Nachricht)';
  end;

  with tiTrayIcon do begin
    Hint := strHeadline + #13#10#13#10 + strBody;
    Icon.LoadFromFile(ExtractFilePath(Application.ExeName) + strIcon);

    if (boolHasChanged and boolBalloonNotification) or aForce then
      BalloonHint(strHeadline, strBody, btNone, 10000, True);
  end;

  if (boolHasChanged and boolSoundNotification) or aForce then
    PlaySound(PAnsiChar(strSound), 0, SND_ALIAS or SND_APPLICATION or SND_ASYNC);
end;

procedure TfrmMain.miHomepageClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('http://www.hackerspace-bremen.de/'), '', '', SW_SHOWNORMAL);
end;

procedure TfrmMain.pmMenuPopup(Sender: TObject);
begin
  miTestBackendEnabled.Visible := RegReadBoolDef(HKEY_CURRENT_USER, strRegPathApp + Application.Title, 'UseTestBackend', false);
end;

end.
