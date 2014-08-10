unit unit_frm_compiler;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,unit_frm_main,unit_functions,ShellApi;

type
  Tfrm_compiler = class(TForm)
    Label1: TLabel;
    edit_contestName: TEdit;
    btn_refresh: TButton;
    list_submits: TListView;
    memo_compilerMessage: TMemo;
    Button1: TButton;
    edit_compilerPath: TEdit;
    lb_time: TLabel;
    Memo1: TMemo;
    Edit1: TEdit;
    Button2: TButton;
    procedure btn_refreshClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_compiler: Tfrm_compiler;

implementation

{$R *.dfm}

procedure Tfrm_compiler.btn_refreshClick(Sender: TObject);
var
  dir : string;
  contests : TStringList;
  I,I1,I3: Integer;
  st: tstrings;
  submits,submitFolder,submitFolder1 : Tstringlist;
begin
  //edit_contestName.Text := contestName;
  list_submits.Clear;
  contestName := edit_contestName.Text;
  submits := TStringList.Create;
  try
    for I := 0 to usersList.Count - 1 do
    begin
      dir := extractfilepath(application.ExeName) + 'Contests\' + contestName + '\Teams\' + usersList.Names[I] + '\sources\';
      submitFolder := TStringList.Create;
      try
        GetSubDirectories(dir,submitFolder);
        for I1 := 0 to submitFolder.Count - 1 do
        begin
          submitFolder1 := TStringList.Create;
          try
            GetSubDirectories(submitFolder.Strings[I1] ,submitFolder1);
            for I3 := 0 to submitFolder1.Count - 1 do
            begin
              if FileExists(submitFolder1.Strings[I3] + '\status.ini') then list_submits.Items.Add.Caption := submitFolder1.Strings[I3];

            end;
          finally
            submitFolder1.Free;
          end;
        end;
      finally
        submitFolder.Free;
      end;
    end;
  finally
    submits.Free;
  end;


end;

procedure Tfrm_compiler.Button1Click(Sender: TObject);
var
  bat: TStringList;
  tt, tt1: tdatetime;
  a,inputfile: string;
  outt : String;
begin



  memo_compilerMessage.Text := GetDosOutput('"'+edit_compilerPath.Text + ' -o "' + list_submits.Selected.Caption + '\output.exe" "' + list_submits.Selected.Caption + '\source.cpp""');

  bat:= TStringlist.create;
  bat.Add('@echo off');
  bat.Add('set %ERRORLEVEL%=1');
  bat.Add('"'+list_submits.Selected.Caption + '\output.exe" < "' + extractfilepath(application.ExeName) + 'Contests\' + contestName + '\Problems\A\input.in' +'" > "' + list_submits.Selected.Caption + '\output.out"');
  bat.Add('echo errorlevel:%errorlevel%');
  bat.Add('set %ERRORLEVEL%=1');
  bat.SaveToFile(list_submits.Selected.Caption + '\output.bat');

  sleep(100);
  tt := now;
    outt := GetDosOutput('""' + list_submits.Selected.Caption + '\output.bat""');
  tt1 := now;
  memo1.Text := outt;
  //kKillTask('out1.exe');
  //KillTask('out1.exe');
  lb_time.Caption := formatdatetime('HH:MM:SS:ZZZ', tt1 - tt);
 // MyText.Free;
  //kKillTask('out1.exe');
  //KillTask('out1.exe');
end;

end.
