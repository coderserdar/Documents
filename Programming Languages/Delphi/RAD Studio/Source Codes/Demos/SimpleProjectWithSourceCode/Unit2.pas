unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Label1.Caption := 'Hello there!';
  Label1.Font.Style := [fsBold,fsUnderline];
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  CheckBox1.Checked := True;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Application.MessageBox('Text',PWideChar(Application.ExeName));
  Screen.Cursor := crHourGlass;
  Application.BringToFront;
  ShowMessage('Screen.Width = '+IntToStr(Screen.Width));
end;

procedure TForm2.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    ShowMessage(TimeToStr(Time)+' - F1 pressed!');
end;

end.
