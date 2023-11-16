unit UMServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, StdCtrls, ExtCtrls;

type
  TFormMultiServer = class(TForm)
    ListView1: TListView;
    Panel2: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Label12: TLabel;
    Panel1: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMultiServer: TFormMultiServer;

implementation

{$R *.dfm}
Uses
  inifiles;
procedure TFormMultiServer.Button1Click(Sender: TObject);
Var
  l : tlistitem;
begin
  l := listview1.Items.Add;
  l.Caption := edit1.Text;
  l.SubItems.Add(edit2.Text);
  l.SubItems.Add(edit3.Text);
  l.SubItems.Add(edit4.Text);
end;

procedure TFormMultiServer.ListView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  I : Integer;
  L : tlistitem;
begin
  l := listview1.GetItemAt(x,y);
  if l <> nil then
  begin
    l.Selected := true;
    if l.Checked then
    Begin
      For i := 0 to ListView1.Items.Count-1 do
      begin
        if i <> l.Index then
          ListView1.Items[i].Checked := false;
      end;
    end;
  end;
end;


procedure TFormMultiServer.BitBtn1Click(Sender: TObject);
Var
  ini : tinifile;
  i : longint;
begin

(*
[Servers]
NumberOf=1
CurrentServer=1

[Server1]
Servername=controlv
Username=
Password=
Database=ControlCenter
DBUser=sa
DBPassword=infra
DSN=CC
Active=1

  ini := tinifile.Create(extractfilepath(application.ExeName)+'plancenter.ini');
  ini.WriteInteger('Servers','Numberof',ListView1.Items.count);
  For i := 0 to ListView1.Items.count-1 do
  begin
    ini.WriteString('Server'+inttostr(i),'name',ListView1.Items[i].Caption);
    ini.WriteString('Server'+inttostr(i),'user',ListView1.Items[i].subitems[0]);
    ini.WriteString('Server'+inttostr(i),'password',ListView1.Items[i].subitems[1]);
    ini.WriteString('Server'+inttostr(i),'dns',ListView1.Items[i].subitems[2]);
    IF ListView1.Items[i].Checked then
      ini.WriteInteger('Servers','CurrentServer',i);
  end;
  ini.free;
  *)
end;


end.
