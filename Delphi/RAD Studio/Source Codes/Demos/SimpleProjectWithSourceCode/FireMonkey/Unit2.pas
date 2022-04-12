unit Unit2;

interface

uses
//** Converted to FireMonkey with Mida 252     http://www.midaconverter.com

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,
  Data.DB,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Menus,
  FMX.Grid,
  FMX.ExtCtrls,
  FMX.ListBox,
  FMX.TreeView,
  FMX.Memo,
  FMX.TabControl,
  FMXTee.RadioGroup,
  FMX.Layouts,
  FMX.Edit,
  FMX.Platform,
  FMX.Bind.DBEngExt,
  FMX.Bind.Editors,
  FMX.Bind.DBLinks,
  FMX.Bind.Navigator,
  Data.Bind.EngExt,
  Data.Bind.Components,
  Data.Bind.DBScope,
  Data.Bind.DBLinks,
  FMXTee.Series,
  FMXTee.Engine,
  FMXTee.Procs,
  FMXTee.Chart,
  Datasnap.DBClient,
  _Mida_FM_Lib;

//**   Original VCL Uses section : 


//**   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
//**   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;


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

{$R *.FMX}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Label1.Text  := 'Hello there!';
  Label1.Font.Style := [TFontStyle.fsBold,TFontStyle.fsUnderline];
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  CheckBox1.IsChecked  := True;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Application_MessageBox('Text',PWideChar(Application_ExeName));
Screen_Cursor_crHourGlass;
//*** Application.BringToFront;
  ShowMessage('Screen_Width = '+FloatToStr(Screen_Width));
end;

procedure TForm2.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vkF1 then
    ShowMessage(TimeToStr(Time)+' - F1 pressed!');
end;

end.
