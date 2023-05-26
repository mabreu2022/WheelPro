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
  System.UIConsts,
  LogManager;

type
  TFrmRegistrar = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    LblTitulo: TLabel;
    ShadowEffect1: TShadowEffect;
    lblRazao: TLabel;
    ShadowEffect2: TShadowEffect;
    EdtRazao: TEdit;
    ShadowEffect8: TShadowEffect;
    lblCnpj_cpf: TLabel;
    lblEndereco: TLabel;
    ShadowEffect4: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    EdtCnpj: TEdit;
    ShadowEffect9: TShadowEffect;
    EdtEndereco: TEdit;
    ShadowEffect10: TShadowEffect;
    lblNumero: TLabel;
    ShadowEffect5: TShadowEffect;
    LblComplemento: TLabel;
    ShadowEffect6: TShadowEffect;
    EdtNumero: TEdit;
    ShadowEffect11: TShadowEffect;
    EdtComplemento: TEdit;
    ShadowEffect12: TShadowEffect;
    LblBairro: TLabel;
    ShadowEffect7: TShadowEffect;
    EdtBairro: TEdit;
    ShadowEffect13: TShadowEffect;
    BtnRegistrar: TButton;
    ShadowEffect14: TShadowEffect;
    GroupBox1: TGroupBox;
    Grid1: TGrid;
    Column1: TColumn;
    Column2: TColumn;
    Column3: TColumn;
    LblResponnsavel: TLabel;
    EdtResponsavel: TEdit;
    ShadowEffect15: TShadowEffect;
    ShadowEffect16: TShadowEffect;
    ShadowEffect17: TShadowEffect;
    LblTelefone: TLabel;
    EdtTelefone: TEdit;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
    LblEmail: TLabel;
    EdtEmail: TEdit;
    ShadowEffect20: TShadowEffect;
    ShadowEffect21: TShadowEffect;
    LblCidade: TLabel;
    EdtCidade: TEdit;
    ShadowEffect22: TShadowEffect;
    ShadowEffect23: TShadowEffect;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FLinguagem: string;
    procedure CarregarCores;
    procedure CarregarLinguagem;
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

procedure TFrmRegistrar.CarregarLinguagem;
var
  IniFile: TIniFile;
  I: Integer;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    FLinguagem :=IniFile.ReadString('Traducao', 'Linguagem', '');

   if FLinguagem = 'Portuguese' then
   begin
     lblRazao.Text        := 'Raz�o Social / Nome';
     lblCnpj_cpf.Text     := 'CNPJ / CPF';
     lblEndereco.Text     := 'Endere�o';
     lblNumero.Text       := 'N�mero';
     LblComplemento.Text  := 'Complemento';
     LblBairro.Text       := 'Bairro';
     LblCidade.Text       := 'Cidade';
     LblResponnsavel.Text := 'Nome do respons�vel pelo registro';
     LblTelefone.Text     := 'Telefone/WhatsApp';
     LblEmail.Text        := 'E-mail';
     BtnRegistrar.Text    := '&Registrar';
     LblTitulo.Text       := 'Registro do Wheel Pro';
     FrmRegistrar.Caption := 'Registro do Wheel Pro';
   end
   else if FLinguagem = 'Ingles' then
   begin
     lblRazao.Text        := 'Corporate Name / Name';
     lblCnpj_cpf.Text     := 'Tax Identification Number - TIN';
     lblEndereco.Text     := 'Address';
     lblNumero.Text       := 'Number';
     LblComplemento.Text  := 'Complement';
     LblBairro.Text       := 'Neighborhood';
     LblCidade.Text       := 'City';
     LblResponnsavel.Text := 'Name of person responsible for registration';
     LblTelefone.Text     := 'Phone/WhatsApp';
     LblEmail.Text        := 'E-mail';
     BtnRegistrar.Text    := '&Register';
     LblTitulo.Text       := 'Wheel Pro registration';
     FrmRegistrar.Caption := 'Wheel Pro registration';
   end;

  finally
    IniFile.Free;
  end;

end;

procedure TFrmRegistrar.FormCreate(Sender: TObject);
begin
  CarregarCores;
  CarregarLinguagem;
end;

end.
