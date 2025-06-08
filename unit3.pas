unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  hmi_polyline;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    HMIPolyline1: THMIPolyline;
    HMIPolyline2: THMIPolyline;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    PaintBox3: TPaintBox;
    PaintBox4: TPaintBox;
    Shape1: TShape;
    Shape11: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape2: TShape;
    Shape20: TShape;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape24: TShape;
    Shape25: TShape;
    Shape26: TShape;
    Shape27: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.Button1Click(Sender: TObject);
begin
  //VC = Round/min
  //VC=speed
  //Length/min  =RoundxC/min
  //Length/min  =Roundx2πr/min
  //Round/min or speed =Length/2πr

  //C=5cm
  //r=0.795775cm
  //2r or D =1.59155cm
  //Length=5cm
  //Length/π2r = Length/C = 5/π1.59155 = 5/5 = 1rpm
end;

end.

