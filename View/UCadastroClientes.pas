unit UCadastroClientes;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes, System.Variants,
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
  FMX.Edit,
  FMX.ListBox,
  Dao.Conexao,
  Dao.Clientes,
  Interfaces.Clientes,
  Model.Clientes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  System.IniFiles,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.PG,
  FireDAC.Comp.UI;

type
  TFrmCadastroClientes = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label1: TLabel;
    ShadowEffect1: TShadowEffect;
    EdtRazao: TEdit;
    EdtCnpj: TEdit;
    EdtEndereco: TEdit;
    EdtNumero: TEdit;
    EdtComplemento: TEdit;
    EdtCep: TEdit;
    Label2: TLabel;
    ShadowEffect2: TShadowEffect;
    Label3: TLabel;
    Label4: TLabel;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    Label5: TLabel;
    Label6: TLabel;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    Label7: TLabel;
    ShadowEffect7: TShadowEffect;
    ShadowEffect8: TShadowEffect;
    ShadowEffect9: TShadowEffect;
    ShadowEffect10: TShadowEffect;
    ShadowEffect11: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    ShadowEffect13: TShadowEffect;
    BtnPrimeiro: TButton;
    btnAnterior: TButton;
    BtnProximo: TButton;
    BtnUltimo: TButton;
    BtnIncluir: TButton;
    BtnAlterar: TButton;
    BtnExcluir: TButton;
    ShadowEffect14: TShadowEffect;
    ShadowEffect15: TShadowEffect;
    ShadowEffect16: TShadowEffect;
    ShadowEffect17: TShadowEffect;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
    ShadowEffect20: TShadowEffect;
    Label8: TLabel;
    ShadowEffect21: TShadowEffect;
    CBAtivo: TComboBox;
    ShadowEffect22: TShadowEffect;
    BtnGravar: TButton;
    ShadowEffect23: TShadowEffect;
    Label9: TLabel;
    ShadowEffect24: TShadowEffect;
    CBUF: TComboBox;
    Label10: TLabel;
    EdtCidade: TEdit;
    ShadowEffect25: TShadowEffect;
    ShadowEffect26: TShadowEffect;
    ShadowEffect27: TShadowEffect;
    Label11: TLabel;
    EdtBairro: TEdit;
    ShadowEffect28: TShadowEffect;
    ShadowEffect29: TShadowEffect;
    ShadowEffect30: TShadowEffect;
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
  private
    { Private declarations }
    FConexao: TFDConnection;
  public
    { Public declarations }
    constructor create;
    destructor destroy; override;
  end;

var
  FrmCadastroClientes: TFrmCadastroClientes;

implementation

{$R *.fmx}

{ TFrmCadastroClientes }

procedure TFrmCadastroClientes.BtnIncluirClick(Sender: TObject);
var
  RegrasDeNeogicios: TRegrasDeNegocio;
begin
  //RegrasDeNeogicios.TestaseTemEndereco();
end;

constructor TFrmCadastroClientes.create;
begin
  FConexao := TConnection.CreateConnection;
end;

destructor TFrmCadastroClientes.destroy;
begin
   FConexao.Free;
  inherited;
end;

procedure TFrmCadastroClientes.FormShow(Sender: TObject);
begin
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

  //Ler os campos
end;

end.
