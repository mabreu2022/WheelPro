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
  TBotaoIndex = (biAlterar, biExcluir, biPrimeiro, biAnterior, biProximo, biUltimo, biNovo, BiGravar);
  TBotaoSet = set of TBotaoIndex;

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
    LblRazaoSocial: TLabel;
    ShadowEffect2: TShadowEffect;
    LblCnpj: TLabel;
    LblEndereco: TLabel;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    LblNumero: TLabel;
    LblComplemento: TLabel;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    LblCEP: TLabel;
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
    BtnNovo: TButton;
    BtnAlterar: TButton;
    BtnExcluir: TButton;
    ShadowEffect14: TShadowEffect;
    ShadowEffect15: TShadowEffect;
    ShadowEffect16: TShadowEffect;
    ShadowEffect17: TShadowEffect;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
    ShadowEffect20: TShadowEffect;
    LblAtivo: TLabel;
    ShadowEffect21: TShadowEffect;
    CBAtivo: TComboBox;
    ShadowEffect22: TShadowEffect;
    LblUF: TLabel;
    ShadowEffect24: TShadowEffect;
    CBUF: TComboBox;
    LblCidade: TLabel;
    EdtCidade: TEdit;
    ShadowEffect25: TShadowEffect;
    ShadowEffect26: TShadowEffect;
    ShadowEffect27: TShadowEffect;
    LblBairro: TLabel;
    EdtBairro: TEdit;
    ShadowEffect28: TShadowEffect;
    ShadowEffect29: TShadowEffect;
    ShadowEffect30: TShadowEffect;
    BtnGravar: TButton;
    ShadowEffect23: TShadowEffect;
    EdtCodCliente: TEdit;
    LblCodCliente: TLabel;
    ShadowEffect31: TShadowEffect;
    ShadowEffect32: TShadowEffect;
    procedure FormShow(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnGravarClick(Sender: TObject);
    procedure CBAtivoExit(Sender: TObject);
    procedure EdtNumeroKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtCnpjKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtCepKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure BtnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    FConexao: TFDConnection;
    FCliente: TClientes;
    PodeGravar: Boolean;
    qry: TFDQuery;
    RegrasDeNegocios: TRegrasDeNegocio;
    procedure DesabilitaBotoes(const BotaoSet:TBotaoSet);

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
  DesabilitaBotoes([BiGravar]);

  if EdtCnpj.CanFocus then
    EdtCnpj.SetFocus;

end;

procedure TFrmCadastroClientes.btnAnteriorClick(Sender: TObject);
begin
  DataSet.prior;
  OnDataSetChange;
end;

procedure TFrmCadastroClientes.BtnExcluirClick(Sender: TObject);
begin
  DesabilitaBotoes([BiGravar]);

end;

procedure TFrmCadastroClientes.BtnGravarClick(Sender: TObject);
var
  Cliente: TClientes;
  Abortar: Boolean;
begin

  Cliente:= TClientes.create;
  try
     //Testar se os campos foram todos preenchidos
     RegrasDeNegocios:= TRegrasDeNegocio.Create;
     PodeGravar :=  RegrasDeNegocios.TestaseTemEndereco(Fcliente);

     if PodeGravar then //testar preenchimento dos campos
     begin
       PopularClientes;
       Abortar:= Cliente.ClienteExiste(EdtCnpj.text);
       if Abortar then
       begin
         ShowMessage('Cliente já existe no Cadastro!');
         Exit;
       end
       else
         Cliente.SalvarCliente(FCliente);
     end
     else
     begin
       ShowMessage('Não foi possível salvar os dados do cliente');

       if EdtRazao.CanFocus then
         EdtRazao.SetFocus;
     end;

     DesabilitaBotoes([BiPrimeiro,BiAnterior,BiProximo,BiUltimo,BiNovo,BiAlterar,BiExcluir,BiGravar]);
  finally
    Cliente.Free;
    RegrasDeNegocios.Free;
  end;

end;

procedure TFrmCadastroClientes.BtnNovoClick(Sender: TObject);
begin
  DesabilitaBotoes([BiGravar]);//Desabilita todos botões menos o botão gravar

  //Limpar todos os campos da tela
  EdtRazao.Text       := '';
  EdtCnpj.Text        := '';
  EdtEndereco.Text    := '';
  EdtNumero.Text      := '';
  EdtComplemento.Text := '';
  EdtCep.Text         := '';
  EdtCidade.Text      := '';
  EdtBairro.Text      := '';
  CBUF.Index          := 1;
  CBAtivo.Index       := 1;

  //Foco no campo EdtRazao
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

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

procedure TFrmCadastroClientes.CBAtivoExit(Sender: TObject);
begin
  if BtnGravar.CanFocus then
    BtnGravar.SetFocus;
end;

constructor TFrmCadastroClientes.create;
begin
  FConexao := TConnection.CreateConnection;
  FCliente := TClientes.create;
end;

Function TFrmCadastroClientes.CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
var
  CDS: TClientDataSet;
begin
  CDS := TClientDataSet.Create(nil);
  try
    CDS.FieldDefs.Add('IDCLIENTES', ftInteger);
    CDS.FieldDefs.Add('RAZAO', ftString, 100);
    CDS.FieldDefs.Add('CNPJ_CPF', ftString, 18);
    CDS.FieldDefs.Add('ENDERECO', ftString, 100);
    CDS.FieldDefs.Add('NUMERO', ftInteger);
    CDS.FieldDefs.Add('COMPLEMENTO', ftString, 100);
    CDS.FieldDefs.Add('CEP', ftString, 10);
    CDS.FieldDefs.Add('CIDADE', ftString, 100);
    CDS.FieldDefs.Add('BAIRRO', ftString, 100);
    CDS.FieldDefs.Add('UF', ftString, 2);
    CDS.FieldDefs.Add('ATIVO', ftString,1);

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

procedure TFrmCadastroClientes.EdtCepKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  // Verifica se a tecla pressionada não é um número
  if not (KeyChar in ['0'..'9', #8, #127]) then
  begin
    // Ignora a tecla pressionada, impedindo que ela seja inserida no campo de edição
    KeyChar := #0;

    // Verifica se a mensagem já foi exibida
    if EdtCep.Tag = 0 then
    begin
      // Exibe a mensagem de erro
      ShowMessage('Só são aceitos números nesse campo');
      EdtCep.Tag := 1;
    end;
  end
  else
  begin
    // Permite a entrada de caracteres válidos
    EdtCep.Tag := 0;
  end;
end;

procedure TFrmCadastroClientes.EdtCnpjKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  // Verifica se a tecla pressionada não é um número
  if not (KeyChar in ['0'..'9', #8, #127]) then
  begin
    // Ignora a tecla pressionada, impedindo que ela seja inserida no campo de edição
    KeyChar := #0;

    // Verifica se a mensagem já foi exibida
    if EdtCnpj.Tag = 0 then
    begin
      // Exibe a mensagem de erro
      ShowMessage('Só são aceitos números nesse campo');
      EdtCnpj.Tag := 1;
    end;
  end
  else
  begin
    // Permite a entrada de caracteres válidos
    EdtCnpj.Tag := 0;
  end;
end;

procedure TFrmCadastroClientes.EdtNumeroKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  // Verifica se a tecla pressionada não é um número
  if not (KeyChar in ['0'..'9', #8, #127]) then
  begin
    // Ignora a tecla pressionada, impedindo que ela seja inserida no campo de edição
    KeyChar := #0;

    // Verifica se a mensagem já foi exibida
    if EdtNumero.Tag = 0 then
    begin
      // Exibe a mensagem de erro
      ShowMessage('Só são aceitos números nesse campo');
      EdtNumero.Tag := 1;
    end;
  end
  else
  begin
    // Permite a entrada de caracteres válidos
    EdtNumero.Tag := 0;
  end;
end;


procedure TFrmCadastroClientes.DesabilitaBotoes(const BotaoSet:TBotaoSet);
var
  TodosOsBotoes: array[TBotaoIndex] of TButton;
  Botao: TBotaoIndex;
begin
  // Mapeia os botões para seus índices correspondentes
  TodosOsBotoes[biAlterar]  := BtnAlterar;
  TodosOsBotoes[biExcluir]  := BtnExcluir;
  TodosOsBotoes[biPrimeiro] := BtnPrimeiro;
  TodosOsBotoes[biAnterior] := BtnAnterior;
  TodosOsBotoes[biProximo]  := BtnProximo;
  TodosOsBotoes[biUltimo]   := BtnUltimo;
  TodosOsBotoes[biNovo]     := BtnNovo;
  TodosOsBotoes[biGravar]   := BtnGravar;

  // Desabilita todos os botões
  for Botao := Low(TBotaoIndex) to High(TBotaoIndex) do
    TodosOsBotoes[Botao].Enabled := False;

  // Habilita apenas os botões do conjunto do parâmetro
  for Botao in BotaoSet do
    TodosOsBotoes[Botao].Enabled := True;

end;

procedure TFrmCadastroClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FCliente.Free;
end;

procedure TFrmCadastroClientes.FormCreate(Sender: TObject);
var
  Cliente: TClientes;

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
       DataSet.FieldByName('idclientes').AsInteger := Qry.FieldByName('idclientes').AsInteger;
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

  finally

  end;
end;

procedure TFrmCadastroClientes.FormShow(Sender: TObject);
begin
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

  BtnGravar.Enabled:= False;
end;

procedure TFrmCadastroClientes.OnDataSetChange;
var
  ufCliente: string;
  ativoCliente: string;
  Index: Integer;
begin
  EdtCodCliente.Text  := IntToStr(DataSet.FieldByName('idcllientes').AsInteger);
  EdtRazao.Text       := DataSet.FieldByName('razao').AsString;
  EdtCnpj.Text        := DataSet.FieldByName('cnpj_cpf').AsString;
  EdtEndereco.Text    := DataSet.FieldByName('endereco').AsString;
  EdtNumero.Text      := IntToStr(DataSet.FieldByName('numero').AsInteger);
  EdtComplemento.Text := DataSet.FieldByName('complemento').AsString;
  EdtCep.Text         := DataSet.FieldByName('CEP').AsString;
  EdtCidade.Text      := DataSet.FieldByName('Cidade').AsString;
  EdtBairro.Text      := DataSet.FieldByName('Bairro').AsString;

  // Definir o valor do campo UF no combobox CBUF
  // Obter o valor dos campos UF e Ativo do DataSet
  ufCliente := DataSet.FieldByName('uf').AsString;
  ativoCliente := DataSet.FieldByName('Ativo').AsString;

  // Definir o valor do campo UF no combobox CBUF
  if CBUF.Items.IndexOf(ufCliente) > -1 then
    CBUF.ItemIndex := CBUF.Items.IndexOf(ufCliente)
  else
    CBUF.ItemIndex := -1; // ou algum valor padrão, caso UF não seja válido

  // Definir o valor do campo Ativo no combobox CBATivo
  if ativoCliente = 'S' then
    CBATivo.ItemIndex := CBATivo.Items.IndexOf('S')
  else if ativoCliente = 'N' then
    CBATivo.ItemIndex := CBATivo.Items.IndexOf('N')
  else
    CBATivo.ItemIndex := -1; // ou algum valor padrão, caso Ativo não seja válido

  PopularClientes;
end;

procedure TFrmCadastroClientes.PopularClientes;
begin
  //popular a classe clientes;
  FCliente := TClientes.create;
  try
    FCliente.razaosocial := EdtRazao.Text;
    FCliente.cnpj        := EdtCnpj.Text;
    FCliente.Endereco    := EdtEndereco.Text;
    FCliente.Numero      := StrToInt(EdtNumero.Text);
    FCliente.Complemento := EdtComplemento.Text;
    FCliente.Cep         := EdtCep.Text;
    FCliente.Cidade      := EdtCidade.Text;
    FCliente.Bairro      := EdtBairro.Text;
    FCliente.UF          := CBUF.Items.Text;
    FCliente.Ativo       := CBAtivo.Items.Text;
  finally
//    FCliente.Free; //Está  no onclose do form
  end;

end;

end.
