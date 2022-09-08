unit AboutForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmAbout = class(TForm)
    imgLogo: TImage;
    lblInformatica: TLabel;
    lblAppointmate: TLabel;
    lblEdition: TLabel;
    lblInfo: TLabel;
    bvlLine: TBevel;
    lblShamelessPlug: TLabel;
    lblEmail: TLabel;
    btnOK: TButton;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblEmailMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblEmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses
  ShellAPI;

// This unit exposes some neat and easy tricks, like context-highlighting
// label controls, and probably the easiest way of sending email available.
// For more nice features like these, follow the hotlink!
 
{$R *.DFM}

procedure TfrmAbout.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  lblEmail.Font.Color := clBlack;
end;

procedure TfrmAbout.lblEmailMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  lblEmail.Font.Color := clBlue;
end;

procedure TfrmAbout.lblEmailClick(Sender: TObject);
begin
	ShellExecute (0, nil, 'mailto:phil@informatica.uk.com?Subject=OOP Masterclass', nil, nil, SW_SHOWDEFAULT);
end;

end.

