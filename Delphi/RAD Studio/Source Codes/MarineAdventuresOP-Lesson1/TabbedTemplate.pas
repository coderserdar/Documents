unit TabbedTemplate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Edit, FMX.ListBox, FMX.Layouts,
  FMX.ListView.Types, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.GenData,
  Fmx.Bind.GenData, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.ListView;

type
  TTabbedForm = class(TForm)
    HeaderToolBar: TToolBar;
    ToolBarLabel: TLabel;
    TabControl1: TTabControl;
    CustomersTabItem: TTabItem;
    EmployeeTabItem: TTabItem;
    PartsTabItem: TTabItem;
    SettingsTabItem: TTabItem;
    GestureManager1: TGestureManager;
    SettingsListBox: TListBox;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    UsernameEdit: TEdit;
    ListBoxItem3: TListBoxItem;
    PasswordEdit: TEdit;
    ListBoxGroupHeader3: TListBoxGroupHeader;
    ListBoxItem2: TListBoxItem;
    OrdersShippedPushNotificationsSwitch: TSwitch;
    ListBoxItem4: TListBoxItem;
    PartsBackorderedPushNotificationsSwitch: TSwitch;
    ListBoxItem5: TListBoxItem;
    InventoryLowPushNotificationSwitch: TSwitch;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TabbedForm: TTabbedForm;

implementation

{$R *.fmx}

procedure TTabbedForm.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := CustomersTabItem;
end;

procedure TTabbedForm.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
{$IFDEF ANDROID}
  case EventInfo.GestureID of
    sgiLeft:
    begin
      if TabControl1.ActiveTab <> TabControl1.Tabs[TabControl1.TabCount-1] then
        TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex+1];
      Handled := True;
    end;

    sgiRight:
    begin
      if TabControl1.ActiveTab <> TabControl1.Tabs[0] then
        TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex-1];
      Handled := True;
    end;
  end;
{$ENDIF}
end;

end.
