// interceptors, converters, reverters
unit MarshallingUtils;

interface

uses Rtti, DBXJsonReflect;

type
  TISODateTimeInterceptor = class(TJSONInterceptor)
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string;
      Arg: string); override;
  end;

var
  ISODateTimeConverter: TStringConverter;
  ISODateTimeReverter: TStringReverter;

implementation

uses SysUtils, DateUtils;

{ TISODateTimeInterceptor }

function TISODateTimeInterceptor.StringConverter(Data: TObject;
  Field: string): string;
begin
  Result := ISODateTimeConverter(Data, Field);
end;

procedure TISODateTimeInterceptor.StringReverter(Data: TObject; Field: string;
  Arg: string);
begin
  ISODateTimeReverter(Data, Field, Arg);
end;

initialization
// From http://www.danieleteti.it/?p=146
// Daniele Teti's programming blog
ISODateTimeConverter := function(Data: TObject; Field: string): string
var
  ctx: TRttiContext; date : TDateTime;
begin
  date := ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
  Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', date);
end;

// From http://www.danieleteti.it/?p=146
// Daniele Teti's programming blog
ISODateTimeReverter := procedure(Data: TObject; Field: string; Arg: string)
var
  ctx: TRttiContext;
  datetime :
  TDateTime;
begin
  datetime := EncodeDateTime(StrToInt(Copy(Arg, 1, 4)), StrToInt(Copy(Arg, 6, 2)), StrToInt(Copy(Arg, 9, 2)), StrToInt
      (Copy(Arg, 12, 2)), StrToInt(Copy(Arg, 15, 2)), StrToInt(Copy(Arg, 18, 2)), 0);
  ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, datetime);
end;

end.
