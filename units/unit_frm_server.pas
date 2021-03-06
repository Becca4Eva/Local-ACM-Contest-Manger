unit unit_frm_server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdServerIOHandler, IdServerIOHandlerSocket, IdServerIOHandlerStack,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,IdStack, Vcl.StdCtrls,
  Vcl.ComCtrls;

type
  Tfrm_server = class(TForm)
    listBox_localIPs: TListBox;
    Refresh: TButton;
    Label1: TLabel;
    edit_port: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure getLocalIPs(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_server: Tfrm_server;

implementation

{$R *.dfm}
uses unit_functions,unit_frm_main;

procedure Tfrm_server.getLocalIPs(Sender: TObject);
var
  IPs: TStringList;
begin
  IPs := TStringList.Create;
  try
    GStack.AddLocalAddressesToList(IPs);
    listbox_localIPs.Items.Assign(IPs);
  finally
    IPs.Free;
  end;
end;

procedure Tfrm_server.Button1Click(Sender: TObject);
begin
  frm_main.id_server.DefaultPort := strtoint(edit_port.Text);
  frm_main.id_server.Active := true;
  statusbar1.SimplePanel := true;
  statusbar1.SimpleText := 'Server Started.';
end;

procedure Tfrm_server.Button2Click(Sender: TObject);
begin
  frm_main.id_server.Active := false;
  statusbar1.SimplePanel := true;
  statusbar1.SimpleText := 'Server Stoped.';
end;

procedure Tfrm_server.FormCreate(Sender: TObject);
begin
  getLocalIPs(nil);
end;



end.
