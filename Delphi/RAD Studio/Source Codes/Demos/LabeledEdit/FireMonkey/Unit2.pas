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
//**   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;


type
  TForm2 = class(TForm)
    LabeledEdit1: TEdit;
    LabeledEdit1_LBL: TLabel;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
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
  with Label1 do
    Caption := 'Hello World!';
end;

end.
