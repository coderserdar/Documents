unit JsonTests_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBXJson;

type
  TFormJson = class(TForm)
    btnParseObj: TButton;
    btnParseUTF8: TButton;
    Memo1: TMemo;
    btnValues: TButton;
    btnSimpleArray: TButton;
    btnSimpleObject: TButton;
    procedure btnParseObjClick(Sender: TObject);
    procedure btnParseUTF8Click(Sender: TObject);
    procedure btnValuesClick(Sender: TObject);
    procedure btnSimpleArrayClick(Sender: TObject);
    procedure btnSimpleObjectClick(Sender: TObject);
  private
    procedure LogAndFree(jValue: TJSONValue);
    { Private declarations }
  public
    /// <summary>Output to the Memo</summary>
    procedure Log (const strMsg: string);
  end;

var
  FormJson: TFormJson;

implementation

{$R *.dfm}

procedure TFormJson.btnSimpleArrayClick(Sender: TObject);
var
  jList: TJSONArray;
begin
  jList := TJSONArray.Create;
  jList.Add(22);
  jList.Add('foo');

  jList.Add(
    TJSonArray.Create (
      TJSONTrue.Create));
  (jList.Get (2) as TJSonArray).Add (100);

  Log (jList.ToString);
  jList.Free;
end;

procedure TFormJson.LogAndFree (jValue: TJSONValue);
begin
  try
    Log (jValue.ClassName +  ' > ' + jValue.ToString);
  finally
    jvalue.Free;
  end;
end;

procedure TFormJson.btnValuesClick(Sender: TObject);
begin
  LogAndFree (TJSONNumber.Create(22));
  LogAndFree (TJSONString.Create('sample text'));
  LogAndFree (TJSONTrue.Create);
  LogAndFree (TJSONFalse.Create);
  LogAndFree (TJSONNull.Create);
end;

procedure TFormJson.btnParseObjClick(Sender: TObject);
var
  strParam: string;
  jsonObj: TJSONObject;
begin
  strParam := '{"value":3}';
  jsonObj := TJSONObject.ParseJSONValue(
    TEncoding.ASCII.GetBytes(strParam), 0)
    as TJSONObject;
  if Assigned (jsonObj) then
  begin
    // complete object
    Log (jsonObj.ToString);
    // last name/value pair
    Log (jsonObj.Get (jsonObj.Size - 1).ToString);
  end
  else
    Log ('Error in parsing ' + strParam);
  jsonObj.Free;
end;

procedure TFormJson.btnParseUTF8Click(Sender: TObject);
var
  sUtf8: UTF8String;
  jsonObj: TJSONObject;
begin
  // sample code to parse the JSON returned by a sample DataSnap REST call
  sUtf8 := '{"hello":["Hello Marco Cantù"]}';

  // bug test (space in JSON)
  // s := '{"result": ["hello world...ello world...ld"]}';

  jsonObj := TJSONObject.ParseJSONValue(
    TEncoding.UTF8.GetBytes(sUtf8), 0, True) as TJSONObject;
//  or the following equivalent version
//  jsonObj := TJSONObject.ParseJSONValueUTF8 (
//    TEncoding.UTF8.GetBytes(sUtf8), 0) as TJSONObject;

  if Assigned (jsonObj) then
    Log((jsonObj.Get(0).JsonValue as TJsonArray).Get(0).Value)
  else
    Log ('Error while parsing: ' + sUtf8);
  jsonObj.Free;
end;

procedure TFormJson.btnSimpleObjectClick(Sender: TObject);
var
  jsonObj, subObject: TJSONObject;
begin
  jsonObj := TJSONObject.Create;
  jsonObj.AddPair(TJSONPair.Create ('Name', 'Marco'));
  jsonObj.AddPair(TJSONPair.Create ('Value', TJSONNumber.Create(100)));

  subObject := TJSONObject.Create(TJSONPair.Create ('Subvalue', 'one'));
  jsonObj.AddPair(TJSONPair.Create ('Object', subObject));

  Log (jsonObj.ToString);
  jsonObj.Free;
end;

procedure TFormJson.Log(const strMsg: string);
begin
  Memo1.Lines.Add (strMsg);
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
