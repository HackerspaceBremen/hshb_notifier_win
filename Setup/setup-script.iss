#define MyAppName "Open Space Notifier"
#define MyAppPublisher "Hackerspace Bremen e.V."
#define MyAppURL "http://hshb.de/osnwin"
#define MyAppPublisherURL "http://www.hackerspace-bremen.de/"
#define MyAppSupportURL "https://www.hackerspace-bremen.de/kontakt/"
#define MyAppCopyright "Hackerspace Bremen e.V."
#define MyAppExeName "osn.exe"
#define MyAppId "{E8B7B703-9347-44AB-9B7A-921AF77802B9}"

[Setup]
AppId={{#MyAppId}
AppName={#MyAppName}
AppVersion={#getFileVersion('..\' + MyAppExeName)}
VersionInfoProductVersion={#getFileVersion('..\' + MyAppExeName)}
VersionInfoVersion={#getFileVersion('..\' + MyAppExeName)}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppPublisherURL}
AppSupportURL={#MyAppSupportURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=.
OutputBaseFilename=setup-osn
AppContact=Jens Bretschneider
VersionInfoCopyright={#MyAppCopyright}
MinVersion=0,5.1.2600
Compression=lzma2/max
SolidCompression=yes
AppMutex=osn,Global\osn}
LicenseFile="..\LICENSE"

[Messages]
BeveledLabel={#MyAppCopyright}

[Languages]
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Files]
Source: "..\osn.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\osn.local"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ssleay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\libeay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\171671__fins__success-1.wav"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\171673__fins__failure-1.wav"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\icon closed.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\icon open.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\icon error.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\LICENSE"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{#MyAppName} Homepage"; Filename: "{#MyAppURL}"; Flags: excludefromshowinnewinstall

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Registry]
Root: "HKCU"; Subkey: "AppEvents\EventLabels\SpaceClosed"; ValueType: string; ValueData: "Hackerspace geschlossen"; Flags: uninsdeletekey
Root: "HKCU"; Subkey: "AppEvents\EventLabels\SpaceOpened"; ValueType: string; ValueData: "Hackerspace geöffnet"; Flags: uninsdeletekey
Root: "HKCU"; Subkey: "AppEvents\Schemes\Apps\OSN"; ValueType: string; ValueData: "Open Space Notifier"; Flags: uninsdeletekey
Root: "HKCU"; Subkey: "AppEvents\Schemes\Apps\OSN\SpaceClosed\.Current"; ValueType: string; ValueData: "{app}\171673__fins__failure-1.wav"
Root: "HKCU"; Subkey: "AppEvents\Schemes\Apps\OSN\SpaceClosed\.Default"; ValueType: string; ValueData: "{app}\171673__fins__failure-1.wav"
Root: "HKCU"; Subkey: "AppEvents\Schemes\Apps\OSN\SpaceOpened\.Current"; ValueType: string; ValueData: "{app}\171671__fins__success-1.wav"
Root: "HKCU"; Subkey: "AppEvents\Schemes\Apps\OSN\SpaceOpened\.Default"; ValueType: string; ValueData: "{app}\171671__fins__success-1.wav"
Root: "HKCU"; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: none; ValueName: "{#MyAppName}"; Flags: uninsdeletevalue
Root: "HKCU"; Subkey: "Software\Jens Bretschneider\{#MyAppName}"; ValueType: none; Flags: uninsdeletekey
