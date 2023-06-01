unit UCadastroVeiculos;

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
  FMX.StdCtrls,
  FMX.Effects,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.ListBox,
  IniFiles,
  System.UIConsts, FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Comp.UI;

type
  TFrmCadastroVeiculos = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Button1: TButton;
    ShadowEffect2: TShadowEffect;
    Button2: TButton;
    ShadowEffect3: TShadowEffect;
    Button3: TButton;
    ShadowEffect4: TShadowEffect;
    Button4: TButton;
    ShadowEffect5: TShadowEffect;
    BtnNovo: TButton;
    ShadowEffect6: TShadowEffect;
    BtnAlterar: TButton;
    ShadowEffect7: TShadowEffect;
    BtnExcluir: TButton;
    ShadowEffect8: TShadowEffect;
    Label1: TLabel;
    ShadowEffect1: TShadowEffect;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ShadowEffect9: TShadowEffect;
    ShadowEffect10: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    ShadowEffect13: TShadowEffect;
    ShadowEffect14: TShadowEffect;
    ShadowEffect15: TShadowEffect;
    ShadowEffect16: TShadowEffect;
    Label6: TLabel;
    Label7: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    ShadowEffect17: TShadowEffect;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
    ShadowEffect20: TShadowEffect;
    Label8: TLabel;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    ShadowEffect21: TShadowEffect;
    ShadowEffect22: TShadowEffect;
    ShadowEffect23: TShadowEffect;
    Label9: TLabel;
    ComboBox2: TComboBox;
    ShadowEffect24: TShadowEffect;
    ShadowEffect25: TShadowEffect;
    Button8: TButton;
    ShadowEffect26: TShadowEffect;
    BtnSalvar: TButton;
    ShadowEffect27: TShadowEffect;
    ComboBox3: TComboBox;
    ShadowEffect11: TShadowEffect;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarCores;
  public
    { Public declarations }
  end;

var
  FrmCadastroVeiculos: TFrmCadastroVeiculos;

implementation

{$R *.fmx}

{ TFrmCadastroVeiculos }

procedure TFrmCadastroVeiculos.CarregarCores;
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

  for var I := 0 to FrmCadastroVeiculos.ComponentCount - 1 do
  begin
    if FrmCadastroVeiculos.Components[I] is TRectangle then
      TRectangle(FrmCadastroVeiculos.Components[I]).Fill.Color := Cor;
  end;

end;

procedure TFrmCadastroVeiculos.FormCreate(Sender: TObject);
begin
  CarregarCores;
end;

end.
