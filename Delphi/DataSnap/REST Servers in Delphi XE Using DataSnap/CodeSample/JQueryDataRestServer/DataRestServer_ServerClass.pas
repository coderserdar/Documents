unit DataRestServer_ServerClass;

interface

uses
  SysUtils, Classes, DSServer, DB, DBClient, dbxJson;

type
{$METHODINFO ON}
  TServerData = class(TDataModule)
    ClientDataSet1: TClientDataSet;
  private
    { Private declarations }
  public
    function Data: TJSONArray;
    function Meta: TJSONArray;
    function DataTables: TJSONObject;
    function NativeTable: TDataset;
  end;
{$METHODINFO OFF}

var
  ServerData: TServerData;

implementation

{$R *.dfm}

{ TServerData }

function TServerData.Data: TJSONArray;
var
  jRecord: TJSONObject;
  I: Integer;
begin
  ClientDataSet1.Open;
  Result := TJSonArray.Create;

  while not ClientDataSet1.EOF do
  begin
    jRecord := TJSONObject.Create;
    for I := 0 to ClientDataSet1.FieldCount - 1 do
      jRecord.AddPair(
        ClientDataSet1.Fields[I].FieldName,
        TJSONString.Create (ClientDataSet1.Fields[I].AsString));
    Result.AddElement(jRecord);
    ClientDataSet1.Next;
  end;
end;

function TServerData.DataTables: TJSONObject;
var
  dataArray, subArray: TJSONArray;
  metaArray: TJSONArray;
  I: Integer;
begin
  ClientDataSet1.Open;
  dataArray:= TJSONArray.Create;

  while not ClientDataSet1.EOF do
  begin
    subArray := TJSONArray.Create;
    for I := 0 to ClientDataSet1.FieldCount - 1 do
      subArray.Add(ClientDataSet1.Fields[I].AsString);
    dataArray.AddElement(subArray);
    ClientDataSet1.Next;
  end;

  metaArray := TJSonArray.Create;
  for I := 0 to ClientDataSet1.FieldDefs.Count - 1 do
  begin
    metaArray.Add (TJSONObject.Create(
      TJSONPair.Create('sTitle', ClientDataSet1.FieldDefs[I].Name)));
  end;

  Result := TJSONObject.Create;
  Result.AddPair(TJSONPair.Create('aaData', dataArray));
  Result.AddPair(TJSONPair.Create('aoColumns', metaArray));

//		"aoColumns": [
//			{ "sTitle": "Engine" },
//			{ "sTitle": "Browser" },
//			{ "sTitle": "Platform" },
//			{ "sTitle": "Version", "sClass": "center" },
//			{
//				"sTitle": "Grade",
//				"sClass": "center",
//				"fnRender": function(obj) {
//					var sReturn = obj.aData[ obj.iDataColumn ];
//					if ( sReturn == "A" ) {
//						sReturn = "<b>A</b>";
//					}
//					return sReturn;
//				}
//			}
//		]

end;

function TServerData.Meta: TJSONArray;
var
  I: Integer;
begin
  ClientDataSet1.Open;
  Result := TJSonArray.Create;

  for I := 0 to ClientDataSet1.FieldDefs.Count - 1 do
    Result.Add(ClientDataSet1.FieldDefs[I].Name);
end;

{ try call with
http://localhost:8080/datasnap/rest/TServerData/NativeTable?t.r=4,6
http://localhost:8080/datasnap/rest/TServerData/NativeTable?t.c=3
}

function TServerData.NativeTable: TDataset;
begin
  ClientDataSet1.Open;
  Result := ClientDataSet1;
end;

end.




