unit LoginForm;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edUsername: TEdit;
    edPassword: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    function GetPassword: String;
    function GetUsername: String;
    { Private declarations }
  public
    { Public declarations }
    property Username: String read GetUsername;
    property Password: String read GetPassword;
  end;

var
  FormLogin: TFormLogin = nil;

implementation

{$R *.dfm}

{ TFormLogin }

function TFormLogin.GetUsername: String;
begin
  Result := edUsername.Text
end;

function TFormLogin.GetPassword: String;
begin
  Result := edPassword.Text
end;

end.
