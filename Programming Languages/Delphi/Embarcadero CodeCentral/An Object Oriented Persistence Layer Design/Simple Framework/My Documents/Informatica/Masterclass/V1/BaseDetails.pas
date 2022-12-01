unit BaseDetails;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type
  TdlgBaseDetails = class(TForm)
    pgcMain: TPageControl;
    tabMain: TTabSheet;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    lblTab: TLabel;
    imgTab: TImage;
    procedure btnApplyClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    FEditObject: TObject;
  protected
    // The object being edited
    property EditObject: TObject read FEditObject;
    // Override this to populate form controls from the object
    procedure LoadDetails; virtual; abstract;
    // Override this to save details from the form to the object when the OK
    // or Apply buttons are pressed. Return False if the save should be prevented.
    function SaveDetails: Boolean; virtual; abstract;
  public
    class function Edit (ObjectToEdit: TObject): TModalResult;
  end;

implementation

uses
  Framework;
  
{$R *.DFM}

class function TdlgBaseDetails.Edit (ObjectToEdit: TObject): TModalResult;
var
  dlg: TdlgBaseDetails;
begin
  if ObjectToEdit = nil then begin
    Result := mrCancel;
  end else begin
    dlg := Self.Create (nil);
    try
      dlg.FEditObject := ObjectToEdit;
      dlg.LoadDetails;
      Result := dlg.ShowModal;
    finally
      dlg.Free;
    end;
  end;
end;

// Events

procedure TdlgBaseDetails.btnApplyClick(Sender: TObject);
begin
  if SaveDetails then begin
    btnApply.Enabled := False;
    btnOK.Caption := 'Close';
  end;
end;

procedure TdlgBaseDetails.btnOKClick(Sender: TObject);
begin
  if SaveDetails then begin
    if EditObject is TPDObject then TPDObject (EditObject).Save;
    ModalResult := mrOK;
  end;
end;

end.

