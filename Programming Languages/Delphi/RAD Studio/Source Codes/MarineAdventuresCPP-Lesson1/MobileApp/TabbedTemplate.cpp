//---------------------------------------------------------------------------

#include <fmx.h>
#include <System.UITypes.hpp>
#pragma hdrstop

#include "TabbedTemplate.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.fmx"
TTabbedForm *TabbedForm;
//---------------------------------------------------------------------------
__fastcall TTabbedForm::TTabbedForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TTabbedForm::FormCreate(TObject *Sender)
{
	// This defines the default active tab at runtime
	TabControl1->ActiveTab = CustomerTabItem;
}
//---------------------------------------------------------------------------

