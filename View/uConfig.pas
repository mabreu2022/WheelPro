unit uConfig;

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
  FMX.Layouts,
  FMX.Objects,
  FMX.TabControl,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.ListBox,
  FMX.Colors,
  IniFiles;

type
  TFrmConfig = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Label1: TLabel;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    CheckBox_CarregarTambemClientesAtivoIgualN: TCheckBox;
    BtnGravar: TButton;
    ShadowEffect3: TShadowEffect;
    TabItem2: TTabItem;
    CCBCoresDoSistema: TColorComboBox;
    LblCoresdoSistema: TLabel;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    procedure BtnGravarClick(Sender: TObject);
    procedure CCBCoresDoSistemaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SalvarCores;
    function ColorToHexString(Color: TAlphaColor): string;
  end;

var
  FrmConfig: TFrmConfig;

implementation

{$R *.fmx}

procedure TFrmConfig.BtnGravarClick(Sender: TObject);
begin
  //Chamar a procedure de gravação
  SalvarCores;
end;

procedure TFrmConfig.CCBCoresDoSistemaChange(Sender: TObject);
var
  SelectedColor: TColor;
begin
//  SelectedColor := CCBCoresDoSistema.Selected;
//  // Atualize a cor do TRectangle selecionado
//  if SelectedColor <> clNone then
//    (SelectedRectangle as TRectangle).Fill.Color := SelectedColor;

end;

function TFrmConfig.ColorToHexString(Color: TAlphaColor): string;
begin
  Result := '$' + IntToHex(Color, 8);
end;

procedure TFrmConfig.SalvarCores;
var
  IniFile: TIniFile;
  CorEscolhida: TAlphaColor;
  ColorString: string;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    CorEscolhida := CCBCoresDoSistema.Color;
    ColorString  := ColorToHexString(CorEscolhida);
    IniFile.WriteString('Cores', 'Cor', ColorString);
  finally
    IniFile.Free;
  end;

end;

end.

