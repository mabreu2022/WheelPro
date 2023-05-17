unit URegistrar;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Layouts,
  FMX.Effects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Edit,
  System.Rtti,
  FMX.Grid.Style,
  FMX.Grid,
  FMX.ScrollBox,
  IniFiles,
  System.UIConsts;

type
  TFrmRegistrar = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label1: TLabel;
    ShadowEffect1: TShadowEffect;
    Label2: TLabel;
    ShadowEffect2: TShadowEffect;
    Edit1: TEdit;
    ShadowEffect8: TShadowEffect;
    Label3: TLabel;
    Label4: TLabel;
    ShadowEffect4: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    Edit2: TEdit;
    ShadowEffect9: TShadowEffect;
    Edit3: TEdit;
    ShadowEffect10: TShadowEffect;
    Label5: TLabel;
    ShadowEffect5: TShadowEffect;
    Label6: TLabel;
    ShadowEffect6: TShadowEffect;
    Edit4: TEdit;
    ShadowEffect11: TShadowEffect;
    Edit5: TEdit;
    ShadowEffect12: TShadowEffect;
    Label7: TLabel;
    ShadowEffect7: TShadowEffect;
    Edit6: TEdit;
    ShadowEffect13: TShadowEffect;
    Button1: TButton;
    ShadowEffect14: TShadowEffect;
    GroupBox1: TGroupBox;
    Grid1: TGrid;
    Column1: TColumn;
    Column2: TColumn;
    Column3: TColumn;
    Label8: TLabel;
    Edit7: TEdit;
    ShadowEffect15: TShadowEffect;
    ShadowEffect16: TShadowEffect;
    ShadowEffect17: TShadowEffect;
    Label9: TLabel;
    Edit8: TEdit;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
    Label10: TLabel;
    Edit9: TEdit;
    ShadowEffect20: TShadowEffect;
    ShadowEffect21: TShadowEffect;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarCores;
  public
    { Public declarations }
  end;

var
  FrmRegistrar: TFrmRegistrar;

implementation

{$R *.fmx}

{ TFrmRegistrar }

procedure TFrmRegistrar.CarregarCores;
var
  IniFile: TIniFile;
  Cor: TAlphaColor;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Cor := StringToAlphaColor(IniFile.ReadString('Cores', 'Cor', ''));
  finally
    IniFile.UpdateFile;
    IniFile.Free;
  end;

  for var I := 0 to FrmRegistrar.ComponentCount - 1 do
  begin
    if FrmRegistrar.Components[I] is TRectangle then
      TRectangle(FrmRegistrar.Components[I]).Fill.Color := Cor;
  end;
end;

procedure TFrmRegistrar.FormCreate(Sender: TObject);
begin
  CarregarCores;
end;

end.
