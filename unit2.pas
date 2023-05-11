unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  BCMaterialDesignButton;

type

  { TForm2 }

  TForm2 = class(TForm)
    BCMaterialDesignButton1: TBCMaterialDesignButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BCMaterialDesignButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.BCMaterialDesignButton1Click(Sender: TObject);
begin
  Form2.Close;
end;

end.

