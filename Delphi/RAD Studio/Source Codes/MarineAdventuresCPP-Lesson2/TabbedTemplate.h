//---------------------------------------------------------------------------

#ifndef TabbedTemplateH
#define TabbedTemplateH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Gestures.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Types.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.ListBox.hpp>
#include <Data.Bind.Components.hpp>
#include <Data.Bind.EngExt.hpp>
#include <Data.Bind.GenData.hpp>
#include <Data.Bind.ObjectScope.hpp>
#include <Fmx.Bind.DBEngExt.hpp>
#include <Fmx.Bind.Editors.hpp>
#include <Fmx.Bind.GenData.hpp>
#include <FMX.ListView.hpp>
#include <FMX.ListView.Types.hpp>
#include <System.Bindings.Outputs.hpp>
#include <System.Rtti.hpp>
//---------------------------------------------------------------------------
class TTabbedForm : public TForm
{
__published:	// IDE-managed Components
	TToolBar *HeaderToolBar;
	TLabel *ToolBarLabel;
	TTabControl *TabControl1;
	TTabItem *CustomerTabItem;
	TTabItem *EmployeeTabItem;
	TTabItem *PartsTabItem;
	TTabItem *SettingsTabItem;
	TListBox *SettingsListBox;
	TListBoxItem *ListBoxItem1;
	TEdit *UsernameEdit;
	TListBoxItem *ListBoxItem2;
	TSwitch *OrdersShippedPushNotificationsSwitch;
	TListBoxItem *ListBoxItem3;
	TEdit *PasswordEdit;
	TListBoxItem *ListBoxItem4;
	TSwitch *PartsBackorderedPushNotificationsSwitch;
	TListBoxGroupHeader *ListBoxGroupHeader2;
	TListBoxGroupHeader *ListBoxGroupHeader3;
	TListBoxItem *ListBoxItem5;
	TSwitch *InventoryLowPushNotificationSwitch;
	TListView *ListView1;
	TBindingsList *BindingsList1;
	TPrototypeBindSource *PrototypeBindSource1;
	TLinkListControlToField *LinkListControlToField1;
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TTabbedForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TTabbedForm *TabbedForm;
//---------------------------------------------------------------------------
#endif
