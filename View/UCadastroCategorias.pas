unit UCadastroCategorias;

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
  FMX.Effects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Edit,
  System.UIConsts,
  IniFiles;

type
  TFrmCategorias = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    LblTitulo: TLabel;
    ShadowEffect1: TShadowEffect;
    Rectangle2: TRectangle;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BtnNovo: TButton;
    BtnAlterar: TButton;
    BtnExcluir: TButton;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    ShadowEffect7: TShadowEffect;
    ShadowEffect8: TShadowEffect;
    Edit1: TEdit;
    Edit2: TEdit;
    lblcodCategoria: TLabel;
    LblCodFabricante: TLabel;
    Edit3: TEdit;
    lblFabricante: TLabel;
    LblAtivo: TLabel;
    ComboBox1: TComboBox;
    ShadowEffect9: TShadowEffect;
    ShadowEffect10: TShadowEffect;
    ShadowEffect11: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    ShadowEffect13: TShadowEffect;
    ShadowEffect14: TShadowEffect;
    ShadowEffect15: TShadowEffect;
    Edit4: TEdit;
    ShadowEffect16: TShadowEffect;
    LblCategoria: TLabel;
    ShadowEffect17: TShadowEffect;
    BtnSalvar: TButton;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
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
  FrmCategorias: TFrmCategorias;

implementation

{$R *.fmx}

{ TFrmCategorias }

procedure TFrmCategorias.CarregarCores;
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

  for var I := 0 to FrmCategorias.ComponentCount - 1 do
  begin
    if FrmCategorias.Components[I] is TRectangle then
      TRectangle(FrmCategorias.Components[I]).Fill.Color := Cor;
  end;

end;

procedure TFrmCategorias.CarregarLinguagem;
var
  IniFile: TIniFile;
  I: Integer;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
     FLinguagem :=IniFile.ReadString('Traducao', 'Linguagem', '');

     if FLinguagem = 'Portuguese' then
     begin
       lblcodCategoria.Text  := 'Cod. Categoria';
       LblCategoria.Text     := 'Categoria';
       LblCodFabricante.Text := 'Cod. Fabricante';
       lblFabricante.Text    := 'Fabricante';
       LblAtivo.Text         := 'Ativo';
       BtnNovo.Text          := '&Novo';
       BtnAlterar.Text       := '&Alterar';
       BtnExcluir.Text       := '&Excluir';
       BtnSalvar.Text        := '&Gravar';
       LblTitulo.Text        := 'Cadastro de Categorias';
       FrmCategorias.Caption := 'Cadastro de Categorias';
     end
     else if FLinguagem = 'Ingles' then
     begin
       lblcodCategoria.Text  := 'Category Id';
       LblCategoria.Text     := 'Category';
       LblCodFabricante.Text := 'Manufacturer Id';
       lblFabricante.Text    := 'Manufacturer';
       LblAtivo.Text         := 'Active';
       BtnNovo.Text          := '&New';
       BtnAlterar.Text       := '&Alter';
       BtnExcluir.Text       := '&Delete';
       BtnSalvar.Text        := '&Save';
       LblTitulo.Text        := 'Category Registration';
       FrmCategorias.Caption := 'Category Registration';
     end;

  finally
    IniFile.Free;
  end;

end;

procedure TFrmCategorias.FormCreate(Sender: TObject);
begin
  CarregarCores;
  CarregarLinguagem;
end;

end.
