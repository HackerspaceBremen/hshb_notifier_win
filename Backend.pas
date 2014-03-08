unit Backend;

interface

uses
  Classes, httpsend, ssl_openssl,
  uLkJSON, DateUtils, Windows, SysUtils;

type
  TBackend = class
  protected
    FJSON: string;
    FOpen: boolean;
    FStatus: string;
    FLastChange: TDateTime;
    FError: boolean;
    FErrorMsg: string;
    FBackendURL: string;
    OldLastChange: TDateTime;
  private
    resp: TStrings;
    function GetHasChanged: boolean;
  public
    constructor Create(aBackendURL: string);
    destructor Destroy; override;
    procedure Read;
  published
    property JSON: string read FJSON;
    property Status: string read FStatus;
    property LastChange: TDateTime read FLastChange;
    property Open: boolean read FOpen;
    property HasChanged: boolean read GetHasChanged;
    property Error: boolean read FError;
    property ErrorMsg: string read FErrorMsg;
    property BackendURL: string read FBackendURL write FBackendURL;
  end;

implementation

function GMTToLocalTime(GMTTime: TDateTime): TDateTime;
var
  GMTST: Windows.TSystemTime;
  LocalST: Windows.TSystemTime;
begin
   SysUtils.DateTimeToSystemTime(GMTTime, GMTST);
   SysUtils.Win32Check(Windows.SystemTimeToTzSpecificLocalTime(nil, GMTST, LocalST));
   Result := SysUtils.SystemTimeToDateTime(LocalST);
end;

constructor TBackend.Create(aBackendURL: string);
begin
  inherited Create;
  resp := TStringList.Create;
  FBackendURL := aBackendURL;

  // Initial befüllen, dabei nicht gleich eine Änderung auslösen
  Read;
  GetHasChanged;
end;

destructor TBackend.Destroy;
begin
  inherited Destroy;
end;

function TBackend.GetHasChanged: boolean;
begin
  result := (FLastChange <> OldLastChange);
  OldLastChange := FLastChange;
end;

procedure TBackend.Read;
var
  js:TlkJSONobject;
begin
  if HttpGetText(FBackendURL, resp) then begin

    FError := false;
    FErrorMsg := '';

    if resp.Text = '' then begin
      FError := true;
      FErrorMsg := 'Keine Daten vom Server erhalten.';
      exit;
    end;

    FJSON := resp.Text;
    js := TlkJSON.ParseText(FJSON) as TlkJSONobject;
    if not assigned(js) then begin
      FError := true;
      FErrorMsg := 'Keine JSON-Struktur erkannt.';
      exit;
    end;

    FStatus := js.getString('status');
    FOpen := js.getBoolean('open');
    FLastChange := GMTToLocalTime(UnixToDateTime(js.getInt('lastchange')));

    js.free;

    if FLastChange = 0 then begin
      FError := true;
      FErrorMsg := 'JSON-Struktur fehlerhaft.';
      exit;
    end;
  end else begin
    FStatus := '';
    FError := true;
    FErrorMsg := 'HTTPS-Verbindung fehlgeschlagen.';
    exit;
  end;
end;

end.
