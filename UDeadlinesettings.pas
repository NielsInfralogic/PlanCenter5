unit UDeadlinesettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TFormdeadlines = class(TForm)
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Panelmovepress: TPanel;
    Image2: TImage;
    Label11: TLabel;
    Label12: TLabel;
    GroupBox3: TGroupBox;
    DateTimePickerdeadlinetime: TDateTimePicker;
    DateTimePickerDeadlinedate: TDateTimePicker;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formdeadlines: TFormdeadlines;

implementation

{$R *.dfm}

end.
