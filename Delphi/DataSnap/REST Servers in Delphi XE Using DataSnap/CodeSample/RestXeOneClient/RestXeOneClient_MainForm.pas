unit RestXeOneClient_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP;

type
  TRestClientForm = class(TForm)
    IdHTTP1: TIdHTTP;
    btnManual: TButton;
    edInput: TEdit;
    btnProxy: TButton;
    procedure btnManualClick(Sender: TObject);
    procedure btnProxyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RestClientForm: TRestClientForm;

implementation

{$R *.dfm}

uses
  DBXJSON, ClientModuleUnit1, ClientClassesUnit1;

const
  strServerUrl = 'http://localhost:8080';
  strMethodUrl = '/datasnap/rest/TServerMethods1/ReverseString/';

procedure TRestClientForm.btnManualClick(Sender: TObject);
var
  strParam, strHttpResult, strResult: string;
  jValue: TJSONValue;
  jObj: TJSONObject;
  jPair: TJSONPair;
  jArray: TJSOnArray;
begin
  strParam := edInput.Text;
  strHttpResult := IdHTTP1.Get(strServerUrl +
    strMethodUrl + strParam);
  jValue := TJSONObject.ParseJSONValue(
    TEncoding.ASCII.GetBytes(strHttpResult), 0);
  try
    jObj := jValue as TJSONObject;
    jPair := jObj.Get(0); // get the first and only JSON pair
    jArray := jPair.JsonValue as TJsonArray; // pair value is an array
    strResult := jArray.Get(0).Value; // first-only element of array
    edInput.Text := strResult;
  finally
    jValue.Free;
  end;
end;

procedure TRestClientForm.btnProxyClick(Sender: TObject);
begin
  edInput.Text := ClientModule1.ServerMethods1Client.
    ReverseString(edInput.Text);
end;

end.
