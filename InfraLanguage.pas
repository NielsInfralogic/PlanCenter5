unit InfraLanguage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TInfraLanguage = class(TComponent)
  private
    Ptext: Tstringlist;
    Dtext: Tstringlist;
    Planguaget: string;
    Planguage: Tstringlist;
    tottransed: Integer;
    procedure settext(Astrings: Tstringlist);
  protected
  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published

    property language: string read Planguaget write Planguaget;
    procedure makelanguagefile(language: string);
    procedure Readlanguagefile(language: string);

    procedure getlanguages(var Items: Tstringlist);
    function Translate(English: string): string;
  end;

procedure Register;

implementation

uses
  PBExListview, Vcl.ComCtrls, Vcl.ActnMenus, Vcl.TabNotBk, Vcl.Buttons,
  System.IniFiles, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, LanguageList1, Vcl.ActnList, Vcl.ActnMan, Vcl.ActnCtrls;

procedure Register;
begin
  RegisterComponents('INFRA', [TInfraLanguage]);
end;

constructor TInfraLanguage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  tottransed := 0;
  Ptext := Tstringlist.Create;
  Dtext := Tstringlist.Create;

  Planguage := Tstringlist.Create;
end;

destructor TInfraLanguage.Destroy;
begin
  Ptext.free;
  Dtext.free;
  Planguage.free;
  inherited;
end;

function TInfraLanguage.Translate(English: string): string;
var
  i: Integer;
begin
  result := English;
  if Dtext.count > 0 then
  begin
    for i := 0 to Dtext.count - 1 do
    begin
      if uppercase(Dtext[i]) = uppercase(English) then
      begin
        if i <= Ptext.count - 1 then
          result := Ptext[i];
        break;
      end;
    end;
  end;

end;

procedure TInfraLanguage.settext(Astrings: Tstringlist);
begin

end;

procedure TInfraLanguage.Readlanguagefile(language: string);
var
  ini: TiniFile;

  function readit(s, d, t: string): string;
  begin
    if (s <> '') and (d <> '') and (t <> '') then
    begin
      if pos('&', d) > 0 then
        delete(d, pos('&', d), 1);
      if pos('&', t) > 0 then
        delete(t, pos('&', t), 1);

      result := ini.ReadString(s, d, t);
    end;
  end;

  procedure docomp(acomponent: TComponent);
  var
    i, childcomps: Integer;
    t: string;
  begin
    try
      if acomponent is TForm then
      begin
        if TForm(acomponent).caption <> '' then
          TForm(acomponent).caption :=
            readit('Translation', TForm(acomponent).caption,
            TForm(acomponent).caption);
      end;

      if acomponent is TLabel then
      begin
        if TLabel(acomponent).caption <> '' then
          TLabel(acomponent).caption :=
            readit('Translation', TLabel(acomponent).caption,
            TLabel(acomponent).caption);
      end;

      if acomponent is TToolbutton then
      begin
        if TLabel(acomponent).caption <> '' then
          TLabel(acomponent).caption :=
            readit('Translation', TLabel(acomponent).caption,
            TLabel(acomponent).caption);
      end;

      if acomponent is TButton then
      begin
        if TButton(acomponent).caption <> '' then
          TButton(acomponent).caption :=
            readit('Translation', TButton(acomponent).caption,
            TButton(acomponent).caption);
      end;
      if acomponent is TBitBtn then
      begin
        if TBitBtn(acomponent).caption <> '' then
          TBitBtn(acomponent).caption :=
            readit('Translation', TBitBtn(acomponent).caption,
            TBitBtn(acomponent).caption);
      end;
      if acomponent is TGroupBox then
      begin
        if TButton(acomponent).caption <> '' then
          TGroupBox(acomponent).caption :=
            readit('Translation', TGroupBox(acomponent).caption,
            TGroupBox(acomponent).caption);
      end;
      if acomponent is TCheckBox then
      begin
        if TCheckBox(acomponent).caption <> '' then
          TCheckBox(acomponent).caption :=
            readit('Translation', TCheckBox(acomponent).caption,
            TCheckBox(acomponent).caption);
      end;

      if acomponent is TRadioButton then
      begin
        if TRadioButton(acomponent).caption <> '' then
          TRadioButton(acomponent).caption :=
            readit('Translation', TRadioButton(acomponent).caption,
            TRadioButton(acomponent).caption);
      end;

      if acomponent is TRadioGroup then
      begin
        if TRadioGroup(acomponent).caption <> '' then
          TRadioGroup(acomponent).caption :=
            readit('Translation', TRadioGroup(acomponent).caption,
            TRadioGroup(acomponent).caption);
        for i := 0 to TRadioGroup(acomponent).Items.count - 1 do
        begin
          if TRadioGroup(acomponent).Items[i] <> '' then
            TRadioGroup(acomponent).Items[i] :=
              readit('Translation', TRadioGroup(acomponent).Items[i],
              TRadioGroup(acomponent).Items[i]);
        end;
      end;

      if acomponent is TMenuItem then
      begin
        if TMenuItem(acomponent).caption <> '' then
          TMenuItem(acomponent).caption :=
            readit('Translation', TMenuItem(acomponent).caption,
            TMenuItem(acomponent).caption);
      end;

      if acomponent is TLanguageList1 then
      begin

        for i := 0 to TLanguageList1(acomponent).Items.count - 1 do
        begin
          if TLanguageList1(acomponent).Items[i] <> '' then
          begin
            t := readit('Translation', TLanguageList1(acomponent).Items[i],
              TLanguageList1(acomponent).Items[i]);
            Ptext.Add(t);
            Dtext.Add(TLanguageList1(acomponent).Items[i]);
          end;
        end;
      end;

      if acomponent is TAction then
      begin
        TAction(acomponent).caption :=
          readit('Translation', TAction(acomponent).caption,
          TAction(acomponent).caption);
      end;

      if acomponent is TActionmainmenubar then
      begin
        if (TActionmainmenubar(acomponent).ActionClient <> nil) then
        begin
          for i := 0 to TActionmainmenubar(acomponent)
            .ActionClient.Items.count - 1 do
          begin

            TActionmainmenubar(acomponent).ActionClient.Items[i].caption :=
              readit('Translation', TActionmainmenubar(acomponent)
              .ActionClient.Items[i].caption, TActionmainmenubar(acomponent)
              .ActionClient.Items[i].caption);
          end;
        end;
      end;

      if acomponent is TActiontoolbar then
      begin
        if (TActiontoolbar(acomponent).ActionClient <> nil) then
        begin
          for i := 0 to TActiontoolbar(acomponent)
            .ActionClient.Items.count - 1 do
          begin

            TActiontoolbar(acomponent).ActionClient.Items[i].caption :=
              readit('Translation', TActiontoolbar(acomponent)
              .ActionClient.Items[i].caption, TActiontoolbar(acomponent)
              .ActionClient.Items[i].caption);
          end;
        end;
      end;

      if acomponent is TPBExListview then
      begin
        for i := 0 to TPBExListview(acomponent).Columns.count - 1 do
        begin
          if TPBExListview(acomponent).Columns.Items[i].caption <> '' then
          begin
            TPBExListview(acomponent).Columns.Items[i].caption :=
              readit('Translation', TPBExListview(acomponent).Columns.Items[i]
              .caption, TPBExListview(acomponent).Columns.Items[i].caption);
          end;
        end;

      end;

      if acomponent is TListview then
      begin
        for i := 0 to TListview(acomponent).Columns.count - 1 do
        begin
          if TListview(acomponent).Columns.Items[i].caption <> '' then
          begin
            TListview(acomponent).Columns.Items[i].caption :=
              readit('Translation', TListview(acomponent).Columns.Items[i]
              .caption, TListview(acomponent).Columns.Items[i].caption);
          end;
        end;

      end;

      if acomponent is Tpagecontrol then
      begin
        for i := 0 to Tpagecontrol(acomponent).PageCount - 1 do
        begin
          if Tpagecontrol(acomponent).Pages[i].caption <> '' then
            Tpagecontrol(acomponent).Pages[i].caption :=
              readit('Translation', Tpagecontrol(acomponent).Pages[i].caption,
              Tpagecontrol(acomponent).Pages[i].caption);
        end;

      end;

      if (acomponent.ComponentCount > 0) and (not(acomponent is TActiontoolbar))
        and (not(acomponent is TActionManager)) then
      begin
        for childcomps := 0 to acomponent.ComponentCount - 1 do
        begin
          Inc(tottransed);
          try
            docomp(acomponent.Components[childcomps]);
          except
          end;
        end;
      end;
    except
    end;
  end;

var
  i: Integer;
  // acomponent: TComponent;

begin
  Ptext.Clear;
  Dtext.Clear;

  ini := TiniFile.Create(ExtractFilePath(application.exename) + 'INFRA-' +
    language + '.TrL'); // OK!
  Planguage.Clear;

  for i := 0 to application.ComponentCount - 1 do
  begin
    Inc(tottransed);
    try
      docomp(application.Components[i]);
    except
    end;

  end;

  ini.free;

end;

procedure TInfraLanguage.makelanguagefile(language: string);
var
  ini: TiniFile;

  procedure docomp(acomponent: TComponent);

    procedure writeit(d, t: string);
    var
      inires: string;
    begin
      if (pos('grbbox', d) > 0) or (pos('TabSheet', d) > 0) then
        exit;
      if (d <> '') and (t <> '') then
      begin
        if pos('&', d) > 0 then
          delete(d, pos('&', d), 1);
        if pos('&', t) > 0 then
          delete(t, pos('&', t), 1);

        inires := ini.ReadString('Translation', d, '');
        if inires = '' then
        begin
          ini.writestring('Translation', d, t);
        end;

      end;
    end;

  var
    i: Integer;

    caption: string;
    childcomps: Integer;
    // Bcomponent: TComponent;
  begin

    caption := '';

    if acomponent is TForm then
    begin
      caption := TForm(acomponent).caption;
    end;

    if acomponent is TLabel then
    begin
      caption := TLabel(acomponent).caption;
    end;

    if acomponent is TToolbutton then
    begin
      caption := TLabel(acomponent).caption;
    end;

    if acomponent is TButton then
    begin
      caption := TButton(acomponent).caption;
    end;
    if acomponent is TBitBtn then
    begin
      caption := TBitBtn(acomponent).caption;
    end;
    if acomponent is TGroupBox then
    begin
      caption := TGroupBox(acomponent).caption;
    end;
    if acomponent is TCheckBox then
    begin
      caption := TCheckBox(acomponent).caption;
    end;
    if acomponent is TRadioButton then
    begin
      caption := TRadioButton(acomponent).caption;
    end;

    if acomponent is TMenuItem then
    begin
      caption := TMenuItem(acomponent).caption;
    end;

    if acomponent is TRadioGroup then
    begin
      caption := TRadioGroup(acomponent).caption;
      for i := 0 to TRadioGroup(acomponent).Items.count - 1 do
      begin
        writeit(TRadioGroup(acomponent).Items[i], TRadioGroup(acomponent)
          .Items[i]);
      end;
    end;

    if acomponent is TLanguageList1 then
    begin
      for i := 0 to TLanguageList1(acomponent).Items.count - 1 do
      begin
        Ptext.Add(TLanguageList1(acomponent).Items[i]);
        Dtext.Add(TLanguageList1(acomponent).Items[i]);
        writeit(TLanguageList1(acomponent).Items[i], TLanguageList1(acomponent)
          .Items[i]);
      end;
    end;

    if acomponent is TAction then
    begin
      if TAction(acomponent).caption <> '' then
        writeit(TAction(acomponent).caption, TAction(acomponent).caption);
    end;

    if acomponent is TActionmainmenubar then
    begin
      for i := 0 to TActionmainmenubar(acomponent)
        .ActionClient.Items.count - 1 do
      begin
        writeit(TActionmainmenubar(acomponent).ActionClient.Items[i].caption,
          TActionmainmenubar(acomponent).ActionClient.Items[i].caption);
      end;
    end;

    if acomponent is TActiontoolbar then
    begin
      for i := 0 to TActiontoolbar(acomponent).ActionClient.Items.count - 1 do
      begin
        writeit(TActiontoolbar(acomponent).ActionClient.Items[i].caption,
          TActiontoolbar(acomponent).ActionClient.Items[i].caption);

      end;
    end;

    if acomponent is TPBExListview then
    begin
      for i := 0 to TPBExListview(acomponent).Columns.count - 1 do
      begin
        if TPBExListview(acomponent).Columns.Items[i].caption <> '' then
        begin
          writeit(TPBExListview(acomponent).Columns.Items[i].caption,
            TPBExListview(acomponent).Columns.Items[i].caption);
        end;
      end;
    end;

    if caption <> '' then
      writeit(caption, caption);

    if acomponent is Tpagecontrol then
    begin
      for i := 0 to Tpagecontrol(acomponent).PageCount - 1 do
      begin
        if Tpagecontrol(acomponent).Pages[i].caption <> '' then
          writeit(Tpagecontrol(acomponent).Pages[i].caption,
            Tpagecontrol(acomponent).Pages[i].caption);
      end;
    end;

    if acomponent.ComponentCount > 0 then
    begin
      for childcomps := 0 to acomponent.ComponentCount - 1 do
      begin
        Inc(tottransed);
        try
          docomp(acomponent.Components[childcomps]);
        except

        end;
      end;
    end;
  end;

var
  i: Integer;
  // acomponent: TComponent;

begin
  Ptext.Clear;
  Dtext.Clear;

  try

    ini := TiniFile.Create(ExtractFilePath(application.exename) + 'INFRA-' +
      language + '.TrL');
    ini.writestring('Infralogic translationfile', 'Language', language);
    ini.writestring('Infralogic translationfile', 'Application',
      Changefileext(Extractfilename(application.exename), ''));

    for i := 0 to application.ComponentCount - 1 do
    begin
      Inc(tottransed);
      docomp(application.Components[i]);
    end;

    ini.free;
  except
  end;
end;

procedure TInfraLanguage.getlanguages(var Items: Tstringlist);
var
  i: Integer;
  t, T1: string;
  F: TSearchRec;
begin
  Items.Clear;
  t := ExtractFilePath(application.exename) + 'INFRA-*.Trl';

  i := Findfirst(t, faArchive, F);
  while i = 0 do
  begin
    T1 := F.name;
    T1 := Changefileext(T1, '');

    delete(T1, 1, 6);
    Items.Add(T1);
    i := findnext(F);
  end;
  findclose(F);
end;

end.
