unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, hmi_polyline, BCMaterialDesignButton, ECEditBtns, Math, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    BCMaterialDesignButton1: TBCMaterialDesignButton;
    BCMaterialDesignButton2: TBCMaterialDesignButton;
    BCMaterialDesignButton3: TBCMaterialDesignButton;
    BCMaterialDesignButton4: TBCMaterialDesignButton;
    BCMaterialDesignButton5: TBCMaterialDesignButton;
    BCMaterialDesignButton6: TBCMaterialDesignButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    English: TECBitBtn;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Round_: TEdit;
    Thai: TECBitBtn;
    HMIPolyline1: THMIPolyline;
    ImageList1: TImageList;
    InsideDiameter: TEdit;
    Label10: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    OutsideDiameter: TEdit;
    OutsideCircumference: TEdit;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    PopupMenu1: TPopupMenu;
    Shape1: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Thickness: TEdit;
    Length_: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure BCMaterialDesignButton1Click(Sender: TObject);
    procedure BCMaterialDesignButton2Click(Sender: TObject);
    procedure BCMaterialDesignButton3Click(Sender: TObject);
    procedure BCMaterialDesignButton4Click(Sender: TObject);
    procedure BCMaterialDesignButton5Click(Sender: TObject);
    procedure BCMaterialDesignButton6Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure EnglishChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure InsideDiameterEditingDone(Sender: TObject);
    procedure Length_EditingDone(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure OutsideDiameterEditingDone(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure Shape1Paint(Sender: TObject);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Shape4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Shape4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Shape4MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Shape5MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Shape5MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Shape5MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); procedure Shape6MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Shape6MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Shape6MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ThaiChange(Sender: TObject);
    procedure ThicknessEditingDone(Sender: TObject);
  private
    function InsideDiameterGreatThenOrEquOutsideDiameter(InsideDiameter_: string; UnitIndex1:integer; OutsideDiameter_: string; UnitIndex2:integer) : boolean;
    procedure ChangeLanguage(Language_: string);
  public

  end;
//L=pi*[(OD^2 /4)−(ID^2 /4)]/t
//L is the roll length
//OD is the outer diameter
//ID is the inner diameter
//t is the thickness

var
  Form1: TForm1;
  Var_InsideDiameter:String;
  Var_OutsideDiameter:String;
  Var_Thickness:String;
  Var_Length_:String;
  Var_OutsideCircumference:String;
  T_MouseDownVer:boolean;
  B_MouseDownVer:boolean;
  L_MouseDownHor:boolean;
  R_MouseDownHor:boolean;
  MouseX_old:integer;
  MouseX_new:integer;
  MouseY_old:integer;
  MouseY_new:integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BCMaterialDesignButton1Click(Sender: TObject);
var
  OD:float;
  OD_2:float;
  ID:float;
  Thickness_float:float;
  Length_float:float;
begin
  //ID=sqrt((OD^2)-(Lt4/Pi))
  //1 Micrometres = 0.001 Millimetre
  //1 Millimetre = 1000 Micrometres

  Thickness_float:=100;
  OD:=100;
  ID:=5;
  Length_float:=1;

  if (ComboBox2.ItemIndex=0) then OD:= StrToFloat(OutsideDiameter.Caption)*1000;
  if (ComboBox2.ItemIndex=1) then OD:= StrToFloat(OutsideDiameter.Caption)*10;
  if (ComboBox2.ItemIndex=2) then OD:= StrToFloat(OutsideDiameter.Caption);

  OD_2:=Math.Power(OD,2);

  if (ComboBox4.ItemIndex=0) then Length_float:= StrToFloat(Length_.Caption);
  if (ComboBox4.ItemIndex=1) then Length_float:= StrToFloat(Length_.Caption)*100;
  if (ComboBox4.ItemIndex=2) then Length_float:= StrToFloat(Length_.Caption)*1000;

  if (ComboBox3.ItemIndex=0) then Thickness_float:= StrToFloat(Thickness.Caption)*1000000;
  if (ComboBox3.ItemIndex=1) then Thickness_float:= StrToFloat(Thickness.Caption)*10000;
  if (ComboBox3.ItemIndex=2) then Thickness_float:= StrToFloat(Thickness.Caption)*1000;
  if (ComboBox3.ItemIndex=3) then Thickness_float:= StrToFloat(Thickness.Caption);

  ID:=sqrt(OD_2-((Length_float*Thickness_float*4)/Pi));

  if (ComboBox1.ItemIndex=0) then InsideDiameter.Caption:= FloatToStr(ID/1000);
  if (ComboBox1.ItemIndex=1) then InsideDiameter.Caption:= FloatToStr(ID/10);
  if (ComboBox1.ItemIndex=2) then InsideDiameter.Caption:= FloatToStr(ID);

  InsideDiameterEditingDone(Sender);
  BCMaterialDesignButton6Click(Sender);

  InsideDiameter.Color:=clDefault;
  OutsideDiameter.Color:=clDefault;
  Thickness.Color:=clDefault;
  Length_.Color:=clDefault;
end;

procedure TForm1.BCMaterialDesignButton2Click(Sender: TObject);
var
  OD:float;
  ID:float;
  ID_2:float;
  Thickness_float:float;
  Length_float:float;
begin
  //OD=sqrt((Lt4/Pi)+(ID^2))
  //1 Micrometres = 0.001 Millimetre
  //1 Millimetre = 1000 Micrometres

  Thickness_float:=100;
  OD:=100;
  ID:=5;
  Length_float:=1;

  if (ComboBox1.ItemIndex=0) then ID:= StrToFloat(InsideDiameter.Caption)*1000;
  if (ComboBox1.ItemIndex=1) then ID:= StrToFloat(InsideDiameter.Caption)*10;
  if (ComboBox1.ItemIndex=2) then ID:= StrToFloat(InsideDiameter.Caption);

  ID_2:=Math.Power(ID,2);

  if (ComboBox4.ItemIndex=0) then Length_float:= StrToFloat(Length_.Caption);
  if (ComboBox4.ItemIndex=1) then Length_float:= StrToFloat(Length_.Caption)*100;
  if (ComboBox4.ItemIndex=2) then Length_float:= StrToFloat(Length_.Caption)*1000;

  if (ComboBox3.ItemIndex=0) then Thickness_float:= StrToFloat(Thickness.Caption)*1000000;
  if (ComboBox3.ItemIndex=1) then Thickness_float:= StrToFloat(Thickness.Caption)*10000;
  if (ComboBox3.ItemIndex=2) then Thickness_float:= StrToFloat(Thickness.Caption)*1000;
  if (ComboBox3.ItemIndex=3) then Thickness_float:= StrToFloat(Thickness.Caption);

  OD:=sqrt(((Length_float*Thickness_float*4)/Pi)+ID_2);

  if (ComboBox2.ItemIndex=0) then OutsideDiameter.Caption:= FloatToStr(OD/1000);
  if (ComboBox2.ItemIndex=1) then OutsideDiameter.Caption:= FloatToStr(OD/10);
  if (ComboBox2.ItemIndex=2) then OutsideDiameter.Caption:= FloatToStr(OD);

  BCMaterialDesignButton5Click(Sender);
  BCMaterialDesignButton6Click(Sender);

  InsideDiameter.Color:=clDefault;
  OutsideDiameter.Color:=clDefault;
  Thickness.Color:=clDefault;
  Length_.Color:=clDefault;
end;

procedure TForm1.BCMaterialDesignButton3Click(Sender: TObject);
var
  OD:float;
  OD_2:float;
  OD_2_4:float;
  ID:float;
  ID_2:float;
  ID_2_4:float;
  Thickness_float:float;
  Length_float:float;
begin
  //t=pi*[(OD^2 /4)−(ID^2 /4)]/L
  //1 Micrometres = 0.001 Millimetre
  //1 Millimetre = 1000 Micrometres

  Thickness_float:=100;
  OD:=100;
  ID:=5;
  Length_float:=1;

  if (ComboBox1.ItemIndex=0) then ID:= StrToFloat(InsideDiameter.Caption)*1000;
  if (ComboBox1.ItemIndex=1) then ID:= StrToFloat(InsideDiameter.Caption)*10;
  if (ComboBox1.ItemIndex=2) then ID:= StrToFloat(InsideDiameter.Caption);

  ID_2:=Math.Power(ID,2);
  ID_2_4:=ID_2/4;

  if (ComboBox2.ItemIndex=0) then OD:= StrToFloat(OutsideDiameter.Caption)*1000;
  if (ComboBox2.ItemIndex=1) then OD:= StrToFloat(OutsideDiameter.Caption)*10;
  if (ComboBox2.ItemIndex=2) then OD:= StrToFloat(OutsideDiameter.Caption);

  OD_2:=Math.Power(OD,2);
  OD_2_4:=OD_2/4;

  if (ComboBox4.ItemIndex=0) then Length_float:= StrToFloat(Length_.Caption);
  if (ComboBox4.ItemIndex=1) then Length_float:= StrToFloat(Length_.Caption)*100;
  if (ComboBox4.ItemIndex=2) then Length_float:= StrToFloat(Length_.Caption)*1000;

  Thickness_float:=(Pi*(OD_2_4-ID_2_4))/Length_float;

  if (ComboBox3.ItemIndex=0) then Thickness.Caption:= FloatToStr(Thickness_float/1000000);
  if (ComboBox3.ItemIndex=1) then Thickness.Caption:= FloatToStr(Thickness_float/10000);
  if (ComboBox3.ItemIndex=2) then Thickness.Caption:= FloatToStr(Thickness_float/1000);
  if (ComboBox3.ItemIndex=3) then Thickness.Caption:= FloatToStr(Thickness_float);

  ThicknessEditingDone(Sender);
  BCMaterialDesignButton6Click(Sender);

  InsideDiameter.Color:=clDefault;
  OutsideDiameter.Color:=clDefault;
  Thickness.Color:=clDefault;
  Length_.Color:=clDefault;
end;

procedure TForm1.BCMaterialDesignButton4Click(Sender: TObject);
var
  OD:float;
  OD_2:float;
  OD_2_4:float;
  ID:float;
  ID_2:float;
  ID_2_4:float;
  Thickness_float:float;
  Length_float:float;
begin
  //L=pi*[(OD^2 /4)−(ID^2 /4)]/t
  //1 Micrometres = 0.001 Millimetre
  //1 Millimetre = 1000 Micrometres

  Thickness_float:=100;
  OD:=100;
  ID:=5;
  Length_float:=1;

  if (ComboBox1.ItemIndex=0) then ID:= StrToFloat(InsideDiameter.Caption)*1000;
  if (ComboBox1.ItemIndex=1) then ID:= StrToFloat(InsideDiameter.Caption)*10;
  if (ComboBox1.ItemIndex=2) then ID:= StrToFloat(InsideDiameter.Caption);

  ID_2:=Math.Power(ID,2);
  ID_2_4:=ID_2/4;

  if (ComboBox2.ItemIndex=0) then OD:= StrToFloat(OutsideDiameter.Caption)*1000;
  if (ComboBox2.ItemIndex=1) then OD:= StrToFloat(OutsideDiameter.Caption)*10;
  if (ComboBox2.ItemIndex=2) then OD:= StrToFloat(OutsideDiameter.Caption);

  OD_2:=Math.Power(OD,2);
  OD_2_4:=OD_2/4;

  if (ComboBox3.ItemIndex=0) then Thickness_float:= StrToFloat(Thickness.Caption)*1000000;
  if (ComboBox3.ItemIndex=1) then Thickness_float:= StrToFloat(Thickness.Caption)*10000;
  if (ComboBox3.ItemIndex=2) then Thickness_float:= StrToFloat(Thickness.Caption)*1000;
  if (ComboBox3.ItemIndex=3) then Thickness_float:= StrToFloat(Thickness.Caption);

  Length_float:=Pi*(OD_2_4-ID_2_4)/Thickness_float;

  if (ComboBox4.ItemIndex=0) then Length_float:= Length_float;
  if (ComboBox4.ItemIndex=1) then Length_float:= Length_float*100;
  if (ComboBox4.ItemIndex=2) then Length_float:= Length_float*1000;

  Length_.Caption:= FloatToStr(Length_float);

  Length_EditingDone(Sender);
  BCMaterialDesignButton6Click(Sender);

  InsideDiameter.Color:=clDefault;
  OutsideDiameter.Color:=clDefault;
  Thickness.Color:=clDefault;
  Length_.Color:=clDefault;
end;

procedure TForm1.BCMaterialDesignButton5Click(Sender: TObject);
var
  Diameter:float;
  Circumference:float;
begin
  //C=2πr
  //D=C/π  31.831=100/3.141

  if (ComboBox2.ItemIndex=0) then Diameter:= StrToFloat(OutsideDiameter.Caption)*1000;  //2r
  if (ComboBox2.ItemIndex=1) then Diameter:= StrToFloat(OutsideDiameter.Caption)*10; //2r
  if (ComboBox2.ItemIndex=2) then Diameter:= StrToFloat(OutsideDiameter.Caption);  //2r

  Circumference:=Pi*Diameter;

  if (ComboBox5.ItemIndex=0) then Circumference:=Circumference/1000;
  if (ComboBox5.ItemIndex=1) then Circumference:=Circumference/10;
  if (ComboBox5.ItemIndex=2) then Circumference:=Circumference;

  Var_OutsideCircumference:=FloatToStr(Circumference);

  OutsideCircumference.Caption:=FloatToStrf(Circumference,ffFixed,18,5);
end;

procedure TForm1.BCMaterialDesignButton6Click(Sender: TObject);
var
  InRi:float;
  OuRi:float;
  DifLenght:float;
  Thi:float;
  Rou:float;

begin
  //0=M.
  //1=CM.
  //2=mm
  //3=micron

  //1 Micrometres = 0.001 Millimetre
  //1 Millimetre = 1000 Micrometres
  //Round:=(InRi-OuRi)/Thi

  InRi:=5/2;
  OuRi:=100/2;
  Thi:=100;

  if (ComboBox1.ItemIndex=0) then InRi:=StrToFloat(InsideDiameter.Caption)/2*1000000;
  if (ComboBox1.ItemIndex=1) then InRi:=StrToFloat(InsideDiameter.Caption)/2*10000;
  if (ComboBox1.ItemIndex=2) then InRi:=StrToFloat(InsideDiameter.Caption)/2*1000;

  if (ComboBox2.ItemIndex=0) then OuRi:=StrToFloat(OutsideDiameter.Caption)/2*1000000;
  if (ComboBox2.ItemIndex=1) then OuRi:=StrToFloat(OutsideDiameter.Caption)/2*10000;
  if (ComboBox2.ItemIndex=2) then OuRi:=StrToFloat(OutsideDiameter.Caption)/2*1000;

  DifLenght:=OuRi-InRi;

  if (ComboBox3.ItemIndex=0) then Thi:=StrToFloat(Thickness.Caption)*1000000;
  if (ComboBox3.ItemIndex=1) then Thi:=StrToFloat(Thickness.Caption)*10000;
  if (ComboBox3.ItemIndex=2) then Thi:=StrToFloat(Thickness.Caption)*1000;
  if (ComboBox3.ItemIndex=3) then Thi:=StrToFloat(Thickness.Caption);

  Rou:=DifLenght/Thi;
  Round_.Caption:=FloatToStr(Rou);
  if English.Tag=1 then
  begin
    Label13.Caption:='Turn: '+Round_.Caption+' round';
  end;
  if Thai.Tag=1 then
  begin
    Label13.Caption:='หมุน: '+Round_.Caption+' รอบ';
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  conveter_:float;
begin
  //0=M.
  //1=CM.
  //2=mm

  conveter_:=5;

  if (ComboBox1.Tag=0) then conveter_:= StrToFloat(InsideDiameter.Caption)*1000;
  if (ComboBox1.Tag=1) then conveter_:= StrToFloat(InsideDiameter.Caption)*10;
  if (ComboBox1.Tag=2) then conveter_:= StrToFloat(InsideDiameter.Caption);

  if (ComboBox1.ItemIndex=0) then conveter_:=conveter_/1000;
  if (ComboBox1.ItemIndex=1) then conveter_:=conveter_/10;
  if (ComboBox1.ItemIndex=2) then conveter_:=conveter_;
  InsideDiameter.Caption:= FloatToStr(conveter_);
  ComboBox1.Tag:=ComboBox1.ItemIndex;

  Var_InsideDiameter:=InsideDiameter.Caption;

  if English.Tag=1 then
  begin
    if (ComboBox1.ItemIndex =0) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' m.');
    if (ComboBox1.ItemIndex=1) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' cm.');
    if (ComboBox1.ItemIndex=2) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' mm.');
  end;
  if Thai.Tag=1 then
  begin
    if (ComboBox1.ItemIndex=0) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' ม.');
    if (ComboBox1.ItemIndex=1) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' ซ.ม.');
    if (ComboBox1.ItemIndex=2) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' ม.ม.');
  end;
  PaintBox2.Refresh;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
var
  conveter_:float;
begin
  //0=M.
  //1=CM.
  //2=mm

  conveter_:=100;

  if (ComboBox2.Tag=0) then conveter_:= StrToFloat(OutsideDiameter.Caption)*1000;
  if (ComboBox2.Tag=1) then conveter_:= StrToFloat(OutsideDiameter.Caption)*10;
  if (ComboBox2.Tag=2) then conveter_:= StrToFloat(OutsideDiameter.Caption);

  if (ComboBox2.ItemIndex=0) then conveter_:=conveter_/1000;
  if (ComboBox2.ItemIndex=1) then conveter_:=conveter_/10;
  if (ComboBox2.ItemIndex=2) then conveter_:=conveter_;
  OutsideDiameter.Caption:= FloatToStr(conveter_);
  ComboBox2.Tag:=ComboBox2.ItemIndex;

  Var_OutsideDiameter:=OutsideDiameter.Caption;

  if English.Tag=1 then
  begin
    if (ComboBox2.ItemIndex=0) then Label6.Caption:=Var_OutsideDiameter+' m.';
    if (ComboBox2.ItemIndex=1) then Label6.Caption:=Var_OutsideDiameter+' cm.';
    if (ComboBox2.ItemIndex=2) then Label6.Caption:=Var_OutsideDiameter+' mm.';
  end;
  if Thai.Tag=1 then
  begin
    if (ComboBox2.ItemIndex=0) then Label6.Caption:=Var_OutsideDiameter+' ม.';
    if (ComboBox2.ItemIndex=1) then Label6.Caption:=Var_OutsideDiameter+' ซ.ม.';
    if (ComboBox2.ItemIndex=2) then Label6.Caption:=Var_OutsideDiameter+' ม.ม.';
  end;
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
var
  conveter_:float;
begin
  //0=M.
  //1=CM.
  //2=mm
  //2=micron

  conveter_:=100;

  if (ComboBox3.Tag=0) then conveter_:= StrToFloat(Thickness.Caption)*1000000;
  if (ComboBox3.Tag=1) then conveter_:= StrToFloat(Thickness.Caption)*10000;
  if (ComboBox3.Tag=2) then conveter_:= StrToFloat(Thickness.Caption)*1000;
  if (ComboBox3.Tag=3) then conveter_:= StrToFloat(Thickness.Caption);

  if (ComboBox3.ItemIndex=0) then conveter_:=conveter_/1000000;
  if (ComboBox3.ItemIndex=1) then conveter_:=conveter_/10000;
  if (ComboBox3.ItemIndex=2) then conveter_:=conveter_/1000;
  if (ComboBox3.ItemIndex=3) then conveter_:=conveter_;
  Thickness.Caption:= FloatToStr(conveter_);
  ComboBox3.Tag:=ComboBox3.ItemIndex;

  Var_Thickness:=Thickness.Caption;

  if English.Tag=1 then
  begin
    if (ComboBox3.ItemIndex=0) then Label8.Caption:=Var_Thickness+' m.';
    if (ComboBox3.ItemIndex=1) then Label8.Caption:=Var_Thickness+' cm.';
    if (ComboBox3.ItemIndex=2) then Label8.Caption:=Var_Thickness+' mm.';
    if (ComboBox3.ItemIndex=3) then Label8.Caption:=Var_Thickness+' micron';
  end;
 if Thai.Tag=1 then
 begin
    if (ComboBox3.ItemIndex=0) then Label8.Caption:=Var_Thickness+' ม.';
    if (ComboBox3.ItemIndex=1) then Label8.Caption:=Var_Thickness+' ซ.ม.';
    if (ComboBox3.ItemIndex=2) then Label8.Caption:=Var_Thickness+' ม.ม.';
    if (ComboBox3.ItemIndex=3) then Label8.Caption:=Var_Thickness+' ไมครอน';
 end;
end;

procedure TForm1.ComboBox4Change(Sender: TObject);
var
  conveter_:float;
begin
  //0=M.
  //1=CM.
  //2=mm

  conveter_:=1;

  if (ComboBox4.Tag=0) then conveter_:= StrToFloat(Length_.Caption)*1000;
  if (ComboBox4.Tag=1) then conveter_:= StrToFloat(Length_.Caption)*10;
  if (ComboBox4.Tag=2) then conveter_:= StrToFloat(Length_.Caption);

  if (ComboBox4.ItemIndex=0) then conveter_:=conveter_/1000;
  if (ComboBox4.ItemIndex=1) then conveter_:=conveter_/10;
  if (ComboBox4.ItemIndex=2) then conveter_:=conveter_;
  Length_.Caption:= FloatToStr(conveter_);
  ComboBox4.Tag:=ComboBox4.ItemIndex;

  Var_Length_:=Length_.Caption;

  if English.Tag=1 then
  begin
    if (ComboBox4.ItemIndex=0) then Label9.Caption:='Length: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' m.';
    if (ComboBox4.ItemIndex=1) then Label9.Caption:='Length: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' cm.';
    if (ComboBox4.ItemIndex=2) then Label9.Caption:='Length: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' mm.';
  end;
  if Thai.Tag=1 then
  begin
    if (ComboBox4.ItemIndex=0) then Label9.Caption:='ความยาว: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' ม.';
    if (ComboBox4.ItemIndex=1) then Label9.Caption:='ความยาว: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' ซ.ม.';
    if (ComboBox4.ItemIndex=2) then Label9.Caption:='ความยาว: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' ม.ม.';
  end;
end;

procedure TForm1.ComboBox5Change(Sender: TObject);
var
  conveter_:float;
begin
  //0=M.
  //1=CM.
  //2=mm

  conveter_:=100;

  if (ComboBox5.Tag=0) then conveter_:= StrToFloat(OutsideCircumference.Caption)*1000;
  if (ComboBox5.Tag=1) then conveter_:= StrToFloat(OutsideCircumference.Caption)*10;
  if (ComboBox5.Tag=2) then conveter_:= StrToFloat(OutsideCircumference.Caption);

  if (ComboBox5.ItemIndex=0) then conveter_:=conveter_/1000;
  if (ComboBox5.ItemIndex=1) then conveter_:=conveter_/10;
  if (ComboBox5.ItemIndex=2) then conveter_:=conveter_;
  OutsideCircumference.Caption:= FloatToStr(conveter_);
  ComboBox5.Tag:=ComboBox5.ItemIndex;

  Var_OutsideCircumference:=OutsideCircumference.Caption;
end;

procedure TForm1.EnglishChange(Sender: TObject);
begin
  ChangeLanguage('English');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  T_MouseDownVer:=false;
  B_MouseDownVer:=false;
  L_MouseDownHor:=false;
  R_MouseDownHor:=false;
  MouseX_old:=0;
  MouseX_new:=0;
  MouseY_old:=0;
  MouseY_new:=0;

  ComboBox1.Tag:=ComboBox1.ItemIndex;
  ComboBox2.Tag:=ComboBox2.ItemIndex;
  ComboBox3.Tag:=ComboBox3.ItemIndex;
  ComboBox4.Tag:=ComboBox4.ItemIndex;
  ComboBox5.Tag:=ComboBox5.ItemIndex;

  Var_InsideDiameter:=InsideDiameter.Caption;
  Var_OutsideDiameter:=OutsideDiameter.Caption;
  Var_Thickness:=Thickness.Caption;
  Var_Length_:=Length_.Caption;
  Var_OutsideCircumference:=OutsideCircumference.Caption;

  //Label7.Caption:='I'+#10+'n'+#10+'s'+#10+'i'+#10+'d'+#10+'e'+#10+' '+#10+'D'+#10+'i'+#10+'a'+#10+'m'+#10+'e'+#10+'t'+#10+'e'+#10+'r';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  //Form2.Close;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin

end;

function TForm1.InsideDiameterGreatThenOrEquOutsideDiameter(InsideDiameter_: string; UnitIndex1:integer; OutsideDiameter_: string; UnitIndex2:integer) : boolean;
  //0=M.
  //1=CM.
  //2=mm
var
  InsideDiameter_Float:float;
  OutsideDiameter_Float:float;
begin
  InsideDiameterGreatThenOrEquOutsideDiameter:=false;

  InsideDiameter_Float:=StrToFloat(InsideDiameter_);
  if(UnitIndex1=0)then InsideDiameter_Float:=InsideDiameter_Float*1000;
  if(UnitIndex1=1)then InsideDiameter_Float:=InsideDiameter_Float*10;
  if(UnitIndex1=2)then InsideDiameter_Float:=InsideDiameter_Float;

  OutsideDiameter_Float:=StrToFloat(OutsideDiameter_);
  if(UnitIndex2=0)then OutsideDiameter_Float:=OutsideDiameter_Float*1000;
  if(UnitIndex2=1)then OutsideDiameter_Float:=OutsideDiameter_Float*10;
  if(UnitIndex2=2)then OutsideDiameter_Float:=OutsideDiameter_Float;

  if(InsideDiameter_Float>=OutsideDiameter_Float)then InsideDiameterGreatThenOrEquOutsideDiameter:=true;

end;


procedure TForm1.InsideDiameterEditingDone(Sender: TObject);
var
  InsideDiameter_Single:Single;
begin
  if not TryStrToFloat(InsideDiameter.Caption,InsideDiameter_Single) then InsideDiameter.Caption:=Var_InsideDiameter;
  if InsideDiameter.Caption='' then InsideDiameter.Caption:=Var_InsideDiameter;
  if InsideDiameter_Single<0 then InsideDiameter.Caption:=Var_InsideDiameter;
  if InsideDiameterGreatThenOrEquOutsideDiameter(InsideDiameter.Caption,ComboBox1.ItemIndex,OutsideDiameter.Caption,ComboBox2.ItemIndex)then InsideDiameter.Caption:=Var_InsideDiameter;
  if Var_InsideDiameter<>InsideDiameter.Caption then InsideDiameter.Color:=$0080FFFF;   //clDefault
  Var_InsideDiameter:=InsideDiameter.Caption;

  if English.Tag=1 then
  begin
    if (ComboBox1.ItemIndex=0) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' m.');
    if (ComboBox1.ItemIndex=1) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' cm.');
    if (ComboBox1.ItemIndex=2) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' mm.');
  end;
  if Thai.Tag=1 then
  begin
    if (ComboBox1.ItemIndex=0) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' ม.');
    if (ComboBox1.ItemIndex=1) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' ซ.ม.');
    if (ComboBox1.ItemIndex=2) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' ม.ม.');
  end;
  PaintBox2.Refresh;
end;

procedure TForm1.Length_EditingDone(Sender: TObject);
var
  Thickness_Single:Single;
begin

  if not TryStrToFloat(Length_.Caption,Thickness_Single) then Length_.Caption:=Var_Length_;
  if Length_.Caption='' then Length_.Caption:=Var_Length_;
  if Thickness_Single<0 then Length_.Caption:=Var_Length_;
  if Var_Length_<>Length_.Caption then Length_.Color:=$0080FFFF;   //clDefault
  Var_Length_:=Length_.Caption;

  //ffFixed,ffGeneral,ffNumber

  if English.Tag=1 then
  begin
    if (ComboBox4.ItemIndex=0) then Label9.Caption:='Length: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' m.';
    if (ComboBox4.ItemIndex=1) then Label9.Caption:='Length: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' cm.';
    if (ComboBox4.ItemIndex=2) then Label9.Caption:='Length: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' mm.';
  end;
  if Thai.Tag=1 then
  begin
    if (ComboBox4.ItemIndex=0) then Label9.Caption:='ความยาว: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' ม.';
    if (ComboBox4.ItemIndex=1) then Label9.Caption:='ความยาว: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' ซ.ม.';
    if (ComboBox4.ItemIndex=2) then Label9.Caption:='ความยาว: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' ม.ม.';
  end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.ChangeLanguage(Language_: string);
begin
  if (Language_='English') then
  begin
    English.Tag:=1;
    Thai.Tag:=0;
    Label2.Caption:='Inside Diameter:';
    Label4.Caption:='Outside Diameter:';
    Label1.Caption:='Thickness:';
    Label3.Caption:='Length:';
    Label10.Caption:='Outside Circumference:';
    BCMaterialDesignButton1.Caption:='Inside diameter';
    BCMaterialDesignButton1.TextSize:=15;
    BCMaterialDesignButton2.Caption:='Outside Diameter';
    BCMaterialDesignButton2.TextSize:=15;
    BCMaterialDesignButton3.Caption:='Thickness';
    BCMaterialDesignButton3.TextSize:=15;
    BCMaterialDesignButton4.Caption:='Length';
    BCMaterialDesignButton4.TextSize:=15;
    BCMaterialDesignButton5.Caption:='Circumference';
    BCMaterialDesignButton5.TextSize:=15;
    Label5.Caption:='Outside Diameter:';
    Label7.Caption:='Thickness:';
    MenuItem2.Caption:='About';
    PaintBox1.Canvas.TextOut(17,0,'Inside Diameter:');
    PaintBox1.Refresh;
    if (ComboBox1.ItemIndex=0) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' m.');
    if (ComboBox1.ItemIndex=1) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' cm.');
    if (ComboBox1.ItemIndex=2) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' mm.');
    PaintBox2.Refresh;
    if (ComboBox2.ItemIndex=0) then Label6.Caption:=Var_OutsideDiameter+' m.';
    if (ComboBox2.ItemIndex=1) then Label6.Caption:=Var_OutsideDiameter+' cm.';
    if (ComboBox2.ItemIndex=2) then Label6.Caption:=Var_OutsideDiameter+' mm.';
    if (ComboBox3.ItemIndex=0) then Label8.Caption:=Var_Thickness+' m.';
    if (ComboBox3.ItemIndex=1) then Label8.Caption:=Var_Thickness+' cm.';
    if (ComboBox3.ItemIndex=2) then Label8.Caption:=Var_Thickness+' mm.';
    if (ComboBox3.ItemIndex=3) then Label8.Caption:=Var_Thickness+' micron';
    if (ComboBox4.ItemIndex=0) then Label9.Caption:='Length: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' m.';
    if (ComboBox4.ItemIndex=1) then Label9.Caption:='Length: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' cm.';
    if (ComboBox4.ItemIndex=2) then Label9.Caption:='Length: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' mm.';
    ComboBox1.Items.Clear;
    ComboBox1.Items.Add('M.');
    ComboBox1.Items.Add('CM.');
    ComboBox1.Items.Add('mm.');
    ComboBox1.ItemIndex:=ComboBox1.Tag;
    ComboBox2.Items.Clear;
    ComboBox2.Items.Add('M.');
    ComboBox2.Items.Add('CM.');
    ComboBox2.Items.Add('mm.');
    ComboBox2.ItemIndex:=ComboBox2.Tag;
    ComboBox3.Items.Clear;
    ComboBox3.Items.Add('M.');
    ComboBox3.Items.Add('CM.');
    ComboBox3.Items.Add('mm.');
    ComboBox3.Items.Add('micron');
    ComboBox3.ItemIndex:=ComboBox3.Tag;
    ComboBox4.Items.Clear;
    ComboBox4.Items.Add('M.');
    ComboBox4.Items.Add('CM.');
    ComboBox4.Items.Add('mm.');
    ComboBox4.ItemIndex:=ComboBox4.Tag;
    ComboBox5.Items.Clear;
    ComboBox5.Items.Add('M.');
    ComboBox5.Items.Add('CM.');
    ComboBox5.Items.Add('mm.');
    ComboBox5.ItemIndex:=ComboBox5.Tag;
    Label11.Caption:='Turn:';
    Label12.Caption:='round';
    BCMaterialDesignButton6.Caption:='round';
    Label13.Caption:='Turn: '+Round_.Caption+' round';
  end;
  if (Language_='Thai') then
  begin
    Thai.Tag:=1;
    English.Tag:=0;
    Label2.Caption:='เส้นผ่านศูนย์กลางภายใน:';
    Label4.Caption:='เส้นผ่านศูนย์กลางภายนอก:';
    Label1.Caption:='ความหนา:';
    Label3.Caption:='ความยาว:';
    Label10.Caption:='เส้นรอบวงด้านนอก:';
    BCMaterialDesignButton1.Caption:='เส้นผ่านศูนย์กลางภายใน';
    BCMaterialDesignButton1.TextSize:=12;
    BCMaterialDesignButton2.Caption:='เส้นผ่านศูนย์กลางภายนอก';
    BCMaterialDesignButton2.TextSize:=12;
    BCMaterialDesignButton3.Caption:='ความหนา';
    BCMaterialDesignButton3.TextSize:=13;
    BCMaterialDesignButton4.Caption:='ความยาว';
    BCMaterialDesignButton4.TextSize:=13;
    BCMaterialDesignButton5.Caption:='เส้นรอบวงภายนอก';
    BCMaterialDesignButton5.TextSize:=13;
    Label5.Caption:='เส้นผ่านศูนย์กลางภายนอก:';
    Label7.Caption:='ความหนา:';
    MenuItem2.Caption:='เกี่ยวกับ';
    PaintBox1.Canvas.TextOut(17,0,'เส้นผ่านศูนย์กลางภายใน:');
    PaintBox1.Refresh;
    if (ComboBox1.ItemIndex=0) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' ม.');
    if (ComboBox1.ItemIndex=1) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' ซ.ม.');
    if (ComboBox1.ItemIndex=2) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(Var_InsideDiameter),ffFixed,18,2)+' ม.ม.');
    PaintBox2.Refresh;
    if (ComboBox2.ItemIndex=0) then Label6.Caption:=Var_OutsideDiameter+' ม.';
    if (ComboBox2.ItemIndex=1) then Label6.Caption:=Var_OutsideDiameter+' ซ.ม.';
    if (ComboBox2.ItemIndex=2) then Label6.Caption:=Var_OutsideDiameter+' ม.ม.';
    if (ComboBox3.ItemIndex=0) then Label8.Caption:=Var_Thickness+' ม.';
    if (ComboBox3.ItemIndex=1) then Label8.Caption:=Var_Thickness+' ซ.ม.';
    if (ComboBox3.ItemIndex=2) then Label8.Caption:=Var_Thickness+' ม.ม.';
    if (ComboBox3.ItemIndex=3) then Label8.Caption:=Var_Thickness+' ไมครอน';
    if (ComboBox4.ItemIndex=0) then Label9.Caption:='ความยาว: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' ม.';
    if (ComboBox4.ItemIndex=1) then Label9.Caption:='ความยาว: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' ซ.ม.';
    if (ComboBox4.ItemIndex=2) then Label9.Caption:='ความยาว: '+FloatToStrf(StrToFloat(Var_Length_),ffFixed,18,2)+' ม.ม.';
    ComboBox1.Items.Clear;
    ComboBox1.Items.Add('ม.');
    ComboBox1.Items.Add('ซ.ม.');
    ComboBox1.Items.Add('ม.ม.');
    ComboBox1.ItemIndex:=ComboBox1.Tag;
    ComboBox2.Items.Clear;
    ComboBox2.Items.Add('ม.');
    ComboBox2.Items.Add('ซ.ม.');
    ComboBox2.Items.Add('ม.ม.');
    ComboBox2.ItemIndex:=ComboBox2.Tag;
    ComboBox3.Items.Clear;
    ComboBox3.Items.Add('ม.');
    ComboBox3.Items.Add('ซ.ม.');
    ComboBox3.Items.Add('ม.ม.');
    ComboBox3.Items.Add('ไมตรอน');
    ComboBox3.ItemIndex:=ComboBox3.Tag;
    ComboBox4.Items.Clear;
    ComboBox4.Items.Add('ม.');
    ComboBox4.Items.Add('ซ.ม.');
    ComboBox4.Items.Add('ม.ม.');
    ComboBox4.ItemIndex:=ComboBox4.Tag;
    ComboBox5.Items.Clear;
    ComboBox5.Items.Add('ม.');
    ComboBox5.Items.Add('ซ.ม.');
    ComboBox5.Items.Add('ม.ม.');
    ComboBox5.ItemIndex:=ComboBox5.Tag;
    Label11.Caption:='หมุน:';
    Label12.Caption:='รอบ';
    BCMaterialDesignButton6.Caption:='รอบ';
    Label13.Caption:='หมุน: '+Round_.Caption+' รอบ';
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  ChangeLanguage('English');
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  ChangeLanguage('Thai');
end;

procedure TForm1.OutsideDiameterEditingDone(Sender: TObject);
var
  OutsideDiameter_Single:Single;
begin
  if not TryStrToFloat(OutsideDiameter.Caption,OutsideDiameter_Single) then OutsideDiameter.Caption:=Var_OutsideDiameter;
  if OutsideDiameter.Caption='' then OutsideDiameter.Caption:=Var_OutsideDiameter;
  if OutsideDiameter_Single<0 then OutsideDiameter.Caption:=Var_OutsideDiameter;
  if InsideDiameterGreatThenOrEquOutsideDiameter(InsideDiameter.Caption,ComboBox1.ItemIndex,OutsideDiameter.Caption,ComboBox2.ItemIndex)then OutsideDiameter.Caption:=Var_OutsideDiameter;
  if Var_OutsideDiameter<>OutsideDiameter.Caption then OutsideDiameter.Color:=$0080FFFF;   //clDefault
  Var_OutsideDiameter:=OutsideDiameter.Caption;

  if English.Tag=1 then
  begin
    if (ComboBox2.ItemIndex=0) then Label6.Caption:=Var_OutsideDiameter+' m.';
    if (ComboBox2.ItemIndex=1) then Label6.Caption:=Var_OutsideDiameter+' cm.';
    if (ComboBox2.ItemIndex=2) then Label6.Caption:=Var_OutsideDiameter+' mm.';
  end;
  if Thai.Tag=1 then
  begin
    if (ComboBox2.ItemIndex=0) then Label6.Caption:=Var_OutsideDiameter+' ม.';
    if (ComboBox2.ItemIndex=1) then Label6.Caption:=Var_OutsideDiameter+' ซ.ม.';
    if (ComboBox2.ItemIndex=2) then Label6.Caption:=Var_OutsideDiameter+' ม.ม.';
  end;

  BCMaterialDesignButton5Click(Sender);
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  PaintBox1.Canvas.Font.Orientation := -900;
  if English.Tag=1 then PaintBox1.Canvas.TextOut(17,0,'Inside Diameter:');
  if Thai.Tag=1 then PaintBox1.Canvas.TextOut(17,0,'เส้นผ่านศูนย์กลางภายใน:');
end;

procedure TForm1.PaintBox2Paint(Sender: TObject);
begin
  PaintBox2.Canvas.Font.Orientation := -900;
  if English.Tag=1 then
  begin
    if (ComboBox1.ItemIndex=0) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(InsideDiameter.Caption),ffFixed,18,2)+' m.');
    if (ComboBox1.ItemIndex=1) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(InsideDiameter.Caption),ffFixed,18,2)+' cm.');
    if (ComboBox1.ItemIndex=2) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(InsideDiameter.Caption),ffFixed,18,2)+' mm.');
  end;
  if Thai.Tag=1 then
  begin
    if (ComboBox1.ItemIndex=0) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(InsideDiameter.Caption),ffFixed,18,2)+' ม.');
    if (ComboBox1.ItemIndex=1) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(InsideDiameter.Caption),ffFixed,18,2)+' ซ.ม.');
    if (ComboBox1.ItemIndex=2) then PaintBox2.Canvas.TextOut(17,0,FloatToStrf(StrToFloat(InsideDiameter.Caption),ffFixed,18,2)+' ม.ม.');
  end;
end;

procedure TForm1.Shape1Paint(Sender: TObject);
var
  i:float;
  t:float;
  Orgx:integer;
  Orgy:integer;
  x:integer;
  y:integer;
  turn:integer;
  Radian:integer;
  Loop_:boolean;

begin
  //$ff000000=alpha $00ff0000=Blue  $0000ff00=Green $000000ff=Red $00000000=black
  //BGRA(0,255,255,255)
  //Shape10.Canvas.Pixels[10,10]:=$00000000;
  //radian to degree
  //3.14159=180
  //6.28319=360
  //RadToDeg(pi),DegToRad(180)

  Orgx:=round(Shape1.Width/2);
  Orgy:=round(Shape1.Height/2);
  i:=0;
  x:=2;
  y:=2;
  Radian:=78;
  Loop_:=true;

  while Loop_ do
  begin
   if (i>360*5) or (x>Radian) or (y>Radian) or (x<2) or (y<2)  then  Loop_:=false;
   t:=DegToRad(i);
   turn:=round(i/42);
   x := round((turn*cos(t)) - (0*sin(t))+Orgx);
   y := round((turn*sin(t)) + (0*cos(t))+Orgy);
   //x1 := (22*cos(t)) - (0*sin(t))+Orgx;
   //y1 := (22*sin(t)) + (0*cos(t))+Orgy;

   Shape1.Canvas.Pixels[x,y]:=$00B0B0B0;

   i := i-1;
  end;

end;

procedure TForm1.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  B_MouseDownVer:=true;
  MouseY_old:=Y;
end;

procedure TForm1.Shape3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if B_MouseDownVer then
  begin
    InsideDiameter.Caption:=FloatToStr(StrToFloat(Var_InsideDiameter)+Y);
    if (ComboBox2.ItemIndex=0) then PaintBox2.Canvas.TextOut(17,0,InsideDiameter.Caption+' m.');
    if (ComboBox2.ItemIndex=1) then PaintBox2.Canvas.TextOut(17,0,InsideDiameter.Caption+' cm.');
    if (ComboBox2.ItemIndex=2) then PaintBox2.Canvas.TextOut(17,0,InsideDiameter.Caption+' mm.');
    InsideDiameter.Color:=$0080FFFF;   //clDefault
  end;
end;

procedure TForm1.Shape3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if B_MouseDownVer then
  begin
    InsideDiameterEditingDone(Sender);
  end;
  B_MouseDownVer:=false;
  MouseY_new:=Y;
end;

procedure TForm1.Shape4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  T_MouseDownVer:=true;
  MouseY_old:=Y;
end;

procedure TForm1.Shape4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if T_MouseDownVer then
  begin
    InsideDiameter.Caption:=FloatToStr(StrToFloat(Var_InsideDiameter)-Y);
    if (ComboBox2.ItemIndex=0) then PaintBox2.Canvas.TextOut(17,0,InsideDiameter.Caption+' m.');
    if (ComboBox2.ItemIndex=1) then PaintBox2.Canvas.TextOut(17,0,InsideDiameter.Caption+' cm.');
    if (ComboBox2.ItemIndex=2) then PaintBox2.Canvas.TextOut(17,0,InsideDiameter.Caption+' mm.');
    InsideDiameter.Color:=$0080FFFF;   //clDefault
  end;
end;

procedure TForm1.Shape4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if T_MouseDownVer then
  begin
    InsideDiameterEditingDone(Sender);
  end;
  T_MouseDownVer:=false;
  MouseY_new:=-Y;
end;

procedure TForm1.Shape5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  R_MouseDownHor:=true;
  MouseX_old:=X;
end;

procedure TForm1.Shape5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if R_MouseDownHor then
  begin
    OutsideDiameter.Caption:=FloatToStr(StrToFloat(Var_OutsideDiameter)+X);
    if (ComboBox2.ItemIndex=0) then Label6.Caption:=OutsideDiameter.Caption+' m.';
    if (ComboBox2.ItemIndex=1) then Label6.Caption:=OutsideDiameter.Caption+' cm.';
    if (ComboBox2.ItemIndex=2) then Label6.Caption:=OutsideDiameter.Caption+' mm.';
    OutsideDiameter.Color:=$0080FFFF;   //clDefault
  end;
end;

procedure TForm1.Shape5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if R_MouseDownHor then
  begin
    OutsideDiameterEditingDone(Sender);
  end;
  R_MouseDownHor:=false;
  MouseX_new:=X;
end;

procedure TForm1.Shape6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  L_MouseDownHor:=true;
  MouseX_old:=-X;
end;

procedure TForm1.Shape6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if L_MouseDownHor then
  begin
    OutsideDiameter.Caption:=FloatToStr(StrToFloat(Var_OutsideDiameter)-X);
    if (ComboBox2.ItemIndex=0) then Label6.Caption:=OutsideDiameter.Caption+' m.';
    if (ComboBox2.ItemIndex=1) then Label6.Caption:=OutsideDiameter.Caption+' cm.';
    if (ComboBox2.ItemIndex=2) then Label6.Caption:=OutsideDiameter.Caption+' mm.';
    OutsideDiameter.Color:=$0080FFFF;   //clDefault
  end;
end;

procedure TForm1.Shape6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if L_MouseDownHor then
  begin
    OutsideDiameterEditingDone(Sender);
  end;
  L_MouseDownHor:=false;
  MouseX_new:=-X;
end;

procedure TForm1.ThaiChange(Sender: TObject);
begin
  ChangeLanguage('Thai');

end;

procedure TForm1.ThicknessEditingDone(Sender: TObject);
var
  Thickness_Single:Single;
begin

  if not TryStrToFloat(Thickness.Caption,Thickness_Single) then Thickness.Caption:=Var_Thickness;
  if Thickness.Caption='' then Thickness.Caption:=Var_Thickness;
  if Thickness_Single<0 then Thickness.Caption:=Var_Thickness;
  if Var_Thickness<>Thickness.Caption then Thickness.Color:=$0080FFFF;   //clDefault
  Var_Thickness:=Thickness.Caption;
  if English.Tag=1 then
  begin
    if (ComboBox3.ItemIndex=0) then Label8.Caption:=Var_Thickness+' m.';
    if (ComboBox3.ItemIndex=1) then Label8.Caption:=Var_Thickness+' cm.';
    if (ComboBox3.ItemIndex=2) then Label8.Caption:=Var_Thickness+' mm.';
    if (ComboBox3.ItemIndex=3) then Label8.Caption:=Var_Thickness+' micron';
  end;
 if Thai.Tag=1 then
 begin
    if (ComboBox3.ItemIndex=0) then Label8.Caption:=Var_Thickness+' ม.';
    if (ComboBox3.ItemIndex=1) then Label8.Caption:=Var_Thickness+' ซ.ม.';
    if (ComboBox3.ItemIndex=2) then Label8.Caption:=Var_Thickness+' ม.ม.';
    if (ComboBox3.ItemIndex=3) then Label8.Caption:=Var_Thickness+' ไมครอน';
 end;
end;


end.

