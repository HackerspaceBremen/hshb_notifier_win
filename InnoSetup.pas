unit InnoSetup;

interface

procedure CreateMutexes(const MutexName: String);

implementation

uses
  Windows;

procedure CreateMutexes(const MutexName: String);
{ Creates the two mutexes checked for by the installer/uninstaller to see if
  the program is still running.
  One of the mutexes is created in the global name space (which makes it
  possible to access the mutex across user sessions in Windows XP); the other
  is created in the session name space (because versions of Windows NT prior
  to 4.0 TSE don't have a global name space and don't support the 'Global\'
  prefix). }
const
  SECURITY_DESCRIPTOR_REVISION = 1;  { Win32 constant not defined in Delphi 3 }
var
  SecurityDesc: TSecurityDescriptor;
  SecurityAttr: TSecurityAttributes;
begin
  { By default on Windows NT, created mutexes are accessible only by the user
    running the process. We need our mutexes to be accessible to all users, so
    that the mutex detection can work across user sessions in Windows XP. To
    do this we use a security descriptor with a null DACL. }
  InitializeSecurityDescriptor(@SecurityDesc, SECURITY_DESCRIPTOR_REVISION);
  SetSecurityDescriptorDacl(@SecurityDesc, True, nil, False);
  SecurityAttr.nLength := SizeOf(SecurityAttr);
  SecurityAttr.lpSecurityDescriptor := @SecurityDesc;
  SecurityAttr.bInheritHandle := False;
  CreateMutex(@SecurityAttr, False, PChar(MutexName));
  CreateMutex(@SecurityAttr, False, PChar('Global\' + MutexName));
end;

end.
