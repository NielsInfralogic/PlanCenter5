unit UChangeserver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormChangeserver = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panelb: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Label9: TLabel;
    ListBox1: TListBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    newDSN : string;
    Newname : string;
    newserveradress : string;
    Function getservername:string;
  end;

var
  FormChangeserver: TFormChangeserver;

implementation

{$R *.dfm}
Uses
  inifiles,umain;

Function TFormChangeserver.getservername:string;
Var
  I,N : Longint;
  ini : tinifile;
Begin
  ini := tinifile.Create(extractfilepath(application.exename)+ 'Plancenter.ini');
  N :=  ini.readInteger('Mserver','numberof',1);
  For i := 1 to N do
  begin
    IF ini.readstring('Mserver','DSN'+inttostr(i),'') = ini.readstring('Server1','DSN','') then
    begin
      result := ini.readstring('Mserver','Servername'+inttostr(i),'');
    end;
  end;
  ini.Free;
end;

procedure TFormChangeserver.FormActivate(Sender: TObject);
Var
  I : Longint;
  ini : tinifile;
begin
  ListBox1.Items.clear;
  ini := tinifile.Create(extractfilepath(application.exename)+ 'Plancenter.ini');
  NMultiservers :=  ini.readInteger('Mserver','numberof',1);
  For i := 1 to NMultiservers do
  begin
    Multiservers[i].name := ini.readstring('Mserver','Servername'+inttostr(i),'');
    Multiservers[i].serveradress := ini.readstring('Mserver','Serveradress'+inttostr(i),'');
    Multiservers[i].dsn := ini.readstring('Mserver','DSN'+inttostr(i),'');
    ListBox1.Items.add(Multiservers[i].name);
  end;
  ini.Free;
  ListBox1.Itemindex := 0;
end;

procedure TFormChangeserver.BitBtn1Click(Sender: TObject);


begin
  newDSN := Multiservers[ListBox1.Itemindex+1].dsn;
  Newname := Multiservers[ListBox1.Itemindex+1].name;
  newserveradress := Multiservers[ListBox1.Itemindex+1].serveradress;
end;

end.
