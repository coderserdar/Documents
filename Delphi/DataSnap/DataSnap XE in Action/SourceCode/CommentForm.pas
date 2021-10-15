unit CommentForm;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormComments = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormComments: TFormComments;

implementation
uses
  ClientForm,
  DataMod;

{$R *.dfm}

procedure TFormComments.BitBtn1Click(Sender: TObject);
begin
  DataModule1.cdsComments.Insert;
  DataModule1.cdsCommentsCommentID.AsInteger := -1;
  DataModule1.cdsCommentsUserID.AsInteger := (Owner.Owner as TFormClient).UserID;
  DataModule1.cdsCommentsCommentDate.AsDateTime := Now;
  DataModule1.cdsCommentsComment.AsString := Memo1.Text;
  DataModule1.cdsComments.Post;
  Close
end;

end.
