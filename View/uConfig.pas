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
  IniFiles,
  System.UIConsts,
  FMX.Edit,
  ShellAPI,
  Winapi.Windows,
  Vcl.Dialogs;

type
  TFrmConfig = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    TabControl1: TTabControl;
    TabItemSistema: TTabItem;
    Label1: TLabel;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    BtnGravar: TButton;
    ShadowEffect3: TShadowEffect;
    TabItemBancoDeDados: TTabItem;
    lblIPdoBanco: TLabel;
    Edit1: TEdit;
    lblLogin: TLabel;
    Edit2: TEdit;
    lblSenha: TLabel;
    Edit3: TEdit;
    ShadowEffect7: TShadowEffect;
    ShadowEffect8: TShadowEffect;
    ShadowEffect9: TShadowEffect;
    ShadowEffect10: TShadowEffect;
    ShadowEffect11: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    GroupBox1: TGroupBox;
    CBWhatsApp: TCheckBox;
    GroupBox2: TGroupBox;
    CCBCoresDoSistema: TColorComboBox;
    ShadowEffect5: TShadowEffect;
    GroupBox3: TGroupBox;
    CheckBox_CarregarTambemClientesAtivoIgualN: TCheckBox;
    ShadowEffect6: TShadowEffect;
    procedure BtnGravarClick(Sender: TObject);
    procedure CCBCoresDoSistemaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCorMudou: Boolean;
  public
    { Public declarations }
    procedure SalvarCores;
    procedure CarregarCores;
    function ColorToHexString(Color: TAlphaColor): string;
  end;

var
  FrmConfig: TFrmConfig;

implementation

{$R *.fmx}

procedure TFrmConfig.BtnGravarClick(Sender: TObject);
var
  AppPath: string;
  Confirmation: Integer;
begin
  //Chamar a procedure de gravação
  SalvarCores;

  // Salve o caminho completo do aplicativo atual
  AppPath := ParamStr(0);

  // Exiba uma caixa de diálogo de confirmação
  Confirmation := MessageDlg('Deseja reiniciar a aplicação para modificar a cor?', mtConfirmation, [mbYes, mbNo], 0);

  // Verifique a resposta do usuário
  if Confirmation = mrYes then
  begin
    // Encerre a aplicação atual
    Application.Terminate;

    // Execute o aplicativo novamente
    ShellExecute(0, 'open', PChar(AppPath), nil, nil, SW_SHOW);
  end;
end;

procedure TFrmConfig.CarregarCores;
var
  IniFile: TIniFile;
  Cor: TAlphaColor;

begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Cor := StringToAlphaColor(IniFile.ReadString('Cores', 'Cor', ''));
    CCBCoresDoSistema.Color:=cor;
//    CBWhatsApp.
  finally
    IniFile.UpdateFile;
    IniFile.Free;
  end;

  for var I := 0 to FrmConfig.ComponentCount - 1 do
  begin
    if FrmConfig.Components[I] is TRectangle then
      TRectangle(FrmConfig.Components[I]).Fill.Color := Cor;
  end;

end;

procedure TFrmConfig.CCBCoresDoSistemaChange(Sender: TObject);
begin
  FCorMudou:= True;
end;

function TFrmConfig.ColorToHexString(Color: TAlphaColor): string;
begin
  Result := '$' + IntToHex(Color, 8);
end;

procedure TFrmConfig.FormCreate(Sender: TObject);
begin
  CarregarCores;
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
  TabControl1.TabIndex:=0;
end;

procedure TFrmConfig.SalvarCores;
var
  IniFile: TIniFile;
  CorEscolhida: TAlphaColor;
  ColorString: string;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    if FCorMudou then
    begin
      CorEscolhida := CCBCoresDoSistema.Color;
      ColorString  := ColorToHexString(CorEscolhida);
      IniFile.WriteString('Cores', 'Cor', ColorString);
    end;

    if CBWhatsApp.IsChecked  then
      IniFile.WriteString('WhatsApp', 'EnviaParaContatoEspecifico', 'N')
    else
      IniFile.WriteString('WhatsApp', 'EnviaParaContatoEspecifico', 'S');

    if CheckBox_CarregarTambemClientesAtivoIgualN.IsChecked then
      IniFile.WriteString('Sistema', 'carregaclientesativosn', 'S')
    else
      IniFile.WriteString('Sistema', 'carregaclientesativosn', 'N');

  finally
    IniFile.Free;
  end;

end;

end.

