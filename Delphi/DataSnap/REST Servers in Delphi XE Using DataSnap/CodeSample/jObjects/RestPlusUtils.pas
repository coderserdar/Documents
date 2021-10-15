unit RestPlusUtils;

interface

uses
  Classes, DBXJson;

function GenerateMapper (aClass: TClass): string;
function ObjectToJson (obj: TObject): TJSOnObject;
procedure JsonToObject (obj: TObject; jObject: TJSOnObject);
function HtmlFormForClass (aClassName: string): string;

implementation

uses
  StrUtils, Rtti, SysUtils;

function HtmlFormForClass (aClassName: string): string;
var
  sList: TStringList;
  context: TRttiContext;
  rttiType: TRttiType;
  aProperty: TRTTIProperty;
begin
  rttiType := context.FindType(aClassName);
  sList := TStringList.Create;
  try
    sList.Add ('<table id="' + rttiType.Name + '">'); // non-qualified!
    for aProperty in rttiType.GetProperties do
    begin
      sList.Add (Format (
        '<tr><td><label>%s</label></td> ' +
          '<td><input type="text" id="%s" size="50" value=""></td></tr>',
        [aProperty.Name, aProperty.Name]));
    end;
    sList.Add ('</table>');
    Result := sList.Text;
  finally
    sList.Free;
  end;
end;

function GenerateMapper (aClass: TClass): string;
var
  sList: TStringList;
  context: TRttiContext;
  aProperty: TRTTIProperty;
begin
  sList := TStringList.Create;
  try
    sList.Add ('function ' + aClass.classname + 'ToForm (anObj)');
    sList.Add ('{');
    for aProperty in context.GetType(aClass.ClassInfo).GetProperties do
    begin
      // sList.Add ('   $("#TMyData #Name").val(anObj.Name);');
      sList.Add ('   $("#' + aClass.classname +
        ' #' + aProperty.Name + '").val(anObj.' + aProperty.Name + ');');
    end;
    sList.Add ('};');
    sList.Add ('');
    sList.Add ('function FormTo' + aClass.classname + ' (anObj)');
    sList.Add ('{');
    for aProperty in context.GetType(aClass.ClassInfo).GetProperties do
    begin
      // sList.Add ('   anObj.Name = $("#TMyData #Name").val();');
      sList.Add ('   anObj.' + aProperty.Name + ' = $("#' + aClass.classname +
        ' #' + aProperty.Name + '").val();');
    end;
    sList.Add ('};');
    Result := sList.Text;
  finally
    sList.Free;
  end;
end;

function ObjectToJson (obj: TObject): TJSOnObject;
var
  context: TRttiContext;
  aProperty: TRttiProperty;
begin
  Result := TJSONObject.Create;
  for aProperty in context.GetType(obj.ClassInfo).GetProperties do
    Result.AddPair(
      TJSONPair.Create (aProperty.Name, aProperty.GetValue(obj).ToString));
end;

procedure JsonToObject (obj: TObject; jObject: TJSOnObject);
var
  context: TRttiContext;
  aProperty: TRttiProperty;
  jPair: TJsonPair;
begin
  for aProperty in context.GetType(obj.ClassInfo).GetProperties do
  begin
    jPair := jObject.Get (aProperty.Name);
    if Assigned (jPair) then
    begin
      if aProperty.PropertyType.IsOrdinal then
        aProperty.SetValue(obj, StrToIntDef (jPair.JsonValue.Value, 0)) // not always string
      else
        aProperty.SetValue(obj, jPair.JsonValue.Value); // string
    end;
  end;
end;


end.
