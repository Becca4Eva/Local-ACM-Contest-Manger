unit unit_functions;

interface

uses
  IdStack, System.Classes, System.SysUtils,inifiles,vcl.forms,math,Winapi.Windows;


procedure GetSubDirectories(const directory : string; list : TStrings);
function addTeam(const contestName, teamName, teamUser, teamPassword : string) : boolean;
function randomPassword(PLen: Integer = 8; str : string = 'BECCA0123456789'): string;
function generateTeamName(teamName : string) : string;
function RoundDateTimeToNearestInterval(vTime : TDateTime; vInterval : TDateTime = 30*60/SecsPerDay) : TDateTime;
function GetDosOutput(CommandLine: string; Work: string = 'C:\'): string;


implementation

function GetDosOutput(CommandLine: string; Work: string = 'C:\'): string;
{ Run a DOS program and retrieve its output dynamically while it is running. }
var
  SecAtrrs: TSecurityAttributes;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: tHandle;
  WasOK: Boolean;
  pCommandLine: array [0 .. 255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  Result := '';
  with SecAtrrs do
  begin
    nLength := Sizeof(SecAtrrs);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SecAtrrs, 0);
  try
    with StartupInfo do
    begin
      FillChar(StartupInfo, Sizeof(StartupInfo), 0);
      cb := Sizeof(StartupInfo);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine), nil, nil,
      True, 0, nil, PChar(WorkDir), StartupInfo, ProcessInfo);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := Winapi.Windows.ReadFile(StdOutPipeRead, pCommandLine, 255,
            BytesRead, nil);
          if BytesRead > 0 then
          begin
            pCommandLine[BytesRead] := #0;
            Result := Result + pCommandLine;
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
      finally
        CloseHandle(ProcessInfo.hThread);
        CloseHandle(ProcessInfo.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;


function RoundDateTimeToNearestInterval(vTime : TDateTime; vInterval : TDateTime = 30*60/SecsPerDay) : TDateTime;
var
  vTimeSec,vIntSec,vRoundedSec : int64;
begin
  //Rounds to nearest 5-minute by default
  vTimeSec := round(vTime * SecsPerDay + 0.499999);
  vIntSec := round(vInterval * SecsPerDay + 0.499999);

  if vIntSec = 0 then exit(vTimeSec / SecsPerDay);

  vRoundedSec := round(vTimeSec / vIntSec + 0.499999) * vIntSec;

  Result := vRoundedSec / SecsPerDay;
end;
function addTeam(const contestName, teamName, teamUser, teamPassword : string) : boolean;
var
  ini : tinifile;
  dir : string;
begin
  result := true;
  dir := extractfilepath(application.ExeName) + '\Contests\' + contestName + '\Teams\' + teamUser;
  if not ForceDirectories(dir) then result := false;
  ini := tinifile.Create(dir + '\team.info.ini');
  try
    ini.WriteString('Team Info' ,'name',teamName);
    ini.WriteString('Team Info','user',teamUser);
    ini.WriteString('Team Info','pass',teamPassword);
  finally
    ini.Free;
  end;
end;

function generateTeamName(teamName : string) : string;
const
  ww: set of char = ['1'..'9', '0', 'a'..'z'];
var
  I : integer;
begin
  teamName := teamName.ToLower;
  I := teamName.Length;
  repeat
    if not(teamName[i] in ww) then delete(teamName, I, 1);
    dec(I);
  until i <= 0;
  if teamName = '' then teamName := randomPassword(10,'abcdefghijklmnopqrstuvwxyz1234567890');
  if teamName.Length > 10 then teamName := teamName.Remove(10);
  Result := teamName;
end;


procedure GetSubDirectories(const directory : string; list : TStrings);
 var
   sr : TSearchRec;
 begin
   try
     if FindFirst(IncludeTrailingPathDelimiter(directory) + '*.*', faDirectory, sr) < 0 then
       Exit
     else
     repeat
       if ((sr.Attr and faDirectory <> 0) AND (sr.Name <> '.') AND (sr.Name <> '..')) then
         List.Add(IncludeTrailingPathDelimiter(directory) + sr.Name) ;
     until FindNext(sr) <> 0;
   finally
     System.SysUtils.FindClose(sr) ;
   end;
 end;

function randomPassword(PLen: Integer = 8; str : string = 'BECCA0123456789'): string;
begin
  Randomize;
  Result := '';
  repeat
    Result := Result + str[Random(Length(str)) + 1];
  until (Length(Result) = PLen)
end;

end.
