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
  FireDAC.Comp.UI,
  Datasnap.DBClient;

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
    procedure FormCreate(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    FConexao: TFDConnection;
    FCliente: TClientes;
    PodeGravar: Boolean;
    qry: TFDQuery;
  public
    { Public declarations }
    DataSet: TClientDataSet;
    Function CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
    procedure OnDataSetChange;
    procedure PopularClientes;
    constructor create;
    destructor destroy; override;
  end;

var
  FrmCadastroClientes: TFrmCadastroClientes;

implementation

{$R *.fmx}

{ TFrmCadastroClientes }

procedure TFrmCadastroClientes.BtnAlterarClick(Sender: TObject);
var
  RegrasDeNeogicios: TRegrasDeNegocio;
  Cliente: TClientes;
begin
  PodeGravar :=  RegrasDeNeogicios.TestaseTemEndereco(Fcliente);

  if PodeGravar then
    Cliente.SalvarCliente(FCliente)
  else
    ShowMessage('Não foi possível alterar os dados do cliente');

end;

procedure TFrmCadastroClientes.btnAnteriorClick(Sender: TObject);
begin
  DataSet.prior;
  OnDataSetChange;
end;

procedure TFrmCadastroClientes.BtnIncluirClick(Sender: TObject);
var
  RegrasDeNeogicios: TRegrasDeNegocio;
  Cliente: TClientes;
begin
  PodeGravar :=  RegrasDeNeogicios.TestaseTemEndereco(Fcliente);

  if PodeGravar then
    Cliente.SalvarCliente(FCliente)
  else
    ShowMessage('Não foi possível salvar os dados do cliente');

end;

procedure TFrmCadastroClientes.BtnPrimeiroClick(Sender: TObject);
begin
  DataSet.First;
  OnDataSetChange;
end;

procedure TFrmCadastroClientes.BtnProximoClick(Sender: TObject);
begin
  DataSet.Next;
  OnDataSetChange;
end;

procedure TFrmCadastroClientes.BtnUltimoClick(Sender: TObject);
begin
  DataSet.Last;
  OnDataSetChange;
end;

constructor TFrmCadastroClientes.create;
begin
  FConexao := TConnection.CreateConnection;
end;

Function TFrmCadastroClientes.CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
var
  CDS: TClientDataSet;
begin
  CDS := TClientDataSet.Create(nil);
  try
    CDS.FieldDefs.Add('RAZAO', ftString, 100);
    CDS.FieldDefs.Add('CNPJ_CPF', ftString, 18);
    CDS.FieldDefs.Add('ENDERECO', ftString, 100);
    CDS.FieldDefs.Add('NUMERO', ftInteger);
    CDS.FieldDefs.Add('COMPLEMENTO', ftString, 100);
    CDS.FieldDefs.Add('CEP', ftString, 10);
    CDS.FieldDefs.Add('CIDADE', ftString, 100);
    CDS.FieldDefs.Add('BAIRRO', ftString, 100);
    CDS.FieldDefs.Add('UF', ftString, 2);
    CDS.FieldDefs.Add('ATIVO', ftBoolean);

    CDS.CreateDataSet;

    Result:= CDS;

  finally
    //CDS.Free;
  end;
end;

destructor TFrmCadastroClientes.destroy;
begin
   FConexao.Free;
  inherited;
end;

procedure TFrmCadastroClientes.FormCreate(Sender: TObject);
var
  Cliente: TClientes;
  UFCliente: string;
  Ativo: string;
  Index: Integer;

begin
  Cliente:= TClientes.create;
  DataSet:= TClientDataset.Create(nil);

  try

     qry:=Cliente.CarregarTodosClientes(DataSet);
     DataSet:=CriarDataSet(DataSet);
     DataSet.Open;
     while Not qry.eof do
     begin

       DataSet.Append;
       DataSet.FieldByName('razao').AsString       := Qry.FieldByName('razao').AsString;
       DataSet.FieldByName('cnpj_cpf').AsString    := Qry.FieldByName('cnpj_cpf').AsString;
       DataSet.FieldByName('endereco').AsString    := Qry.FieldByName('endereco').AsString;
       DataSet.FieldByName('numero').AsInteger     := Qry.FieldByName('numero').AsInteger;
       DataSet.FieldByName('complemento').AsString := Qry.FieldByName('complemento').AsString;
       DataSet.FieldByName('CEP').AsString         := Qry.FieldByName('CEP').AsString;
       DataSet.FieldByName('Cidade').AsString      := Qry.FieldByName('Cidade').AsString;
       DataSet.FieldByName('Bairro').AsString      := Qry.FieldByName('Bairro').AsString;
       DataSet.FieldByName('UF').AsString          := Qry.FieldByName('UF').AsString; //e se gravar o index dom CBUF? 1,2,3,4...
       DataSet.FieldByName('ATIVO').AsString       := Qry.FieldByName('ATIVO').AsString; //e se gravar o index dom CBUF? 1,2,3,4...

       DataSet.Post;

       qry.Next;
     end;
     DataSet.First;
     OnDataSetChange;



//     // Carregar ComboBox CBUF com a UF do cliente
//     CBUF.Clear;
//     UFCliente := DataSet.FieldByName('uf').AsString;
//     Index := CBUF.Items.IndexOf(UFCliente);
//     if Index <> -1 then
//       CBUF.ItemIndex := Index;
//
//     // Carregar ComboBox CBAtivo
//     CBAtivo.Clear;
//     Ativo := DataSet.FieldByName('Ativo').AsString;
//     Index := CBAtivo.Items.IndexOf(Ativo);
//     if Index <> -1 then
//       CBAtivo.ItemIndex := Index;

  finally

  end;
end;

procedure TFrmCadastroClientes.FormShow(Sender: TObject);
begin
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;
end;

procedure TFrmCadastroClientes.OnDataSetChange;
begin
  EdtRazao.Text       := DataSet.FieldByName('razao').AsString;
  EdtCnpj.Text        := DataSet.FieldByName('cnpj_cpf').AsString;
  EdtEndereco.Text    := DataSet.FieldByName('endereco').AsString;
  EdtNumero.Text      := IntToStr(DataSet.FieldByName('numero').AsInteger);
  EdtComplemento.Text := DataSet.FieldByName('complemento').AsString;
  EdtCep.Text         := DataSet.FieldByName('CEP').AsString;
  EdtCidade.Text      := DataSet.FieldByName('Cidade').AsString;
  EdtBairro.Text      := DataSet.FieldByName('Bairro').AsString;
  PopularClientes;
end;

procedure TFrmCadastroClientes.PopularClientes;
begin
  //popular a classe clientes;
  FCliente.razaosocial := EdtRazao.Text;
  FCliente.cnpj        := EdtCnpj.Text;
  EdtEndereco.Text     := EdtEndereco.Text;
  EdtNumero.Text       := EdtNumero.Text;
  EdtComplemento.Text  := EdtComplemento.Text;
  EdtCep.Text          := EdtCep.Text;
  EdtCidade.Text       := EdtCidade.Text;
  EdtBairro.Text       := EdtBairro.Text;
end;

end.
