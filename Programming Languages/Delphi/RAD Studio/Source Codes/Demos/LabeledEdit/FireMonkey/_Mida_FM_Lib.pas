unit _Mida_FM_Lib;

//** Mida - Convert VCL Application To FireMonkey for Embarcadero Delphi XE2 and C++Builder XE2
//** Official Site : www.midaconverter.com
//** ------------------------------------------------------------------------------------------
//**
//** Version : 2.5
//** Date : 3 May 2012
//** 
//** you can use this file but the distribution is prohibited
//** 

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,FMX.Platform;

Procedure Screen_Cursor_crHourGlass;
Procedure Screen_Cursor_crDefault;
function  Screen_MonitorCount:Integer;

function Application_ExeName:String;
function Screen_Width:Single;
function Screen_Height:Single;
function Application_MessageBox
(sText,sTitle:String;iMsgDlgType:TMsgDlgType;iMsgDlgButtons:TMsgDlgButtons):Integer;

implementation

// uses FMX.Platform, System.UITypes;
Procedure Screen_Cursor_crHourGlass;
begin
Platform.SetCursor(nil, crHourGlass);
end;

Procedure Screen_Cursor_crDefault;
begin
Platform.SetCursor(nil, crDefault);
end;

function  Screen_MonitorCount:Integer;
begin
Result := 1;
end;

function Application_ExeName:String;
begin
Result := ParamStr(0);
end;

function Screen_Width:Single;
begin
Result := Platform.GetScreenSize.X;
end;

function Screen_Height:Single;
begin
Result := Platform.GetScreenSize.Y;
end;


function Application_MessageBox
(sText,sTitle:String;iMsgDlgType:TMsgDlgType;iMsgDlgButtons:TMsgDlgButtons):Integer;
begin
Result := 0;
MessageDlg(sTitle+Chr(13)+Chr(10)+Chr(13)+Chr(10)+sText, iMsgDlgType, iMsgDlgButtons, 0);
end;

end.
