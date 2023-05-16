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
  Entity.Clientes,
  Controller.Clientes,
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
  Datasnap.DBClient,
  FMX.TabControl,
  System.Rtti,
  FMX.Grid.Style,
  FMX.Grid,
  FMX.ScrollBox;

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
    BtnGravar: TButton;
    ShadowEffect23: TShadowEffect;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    LblCodCliente: TLabel;
    ShadowEffect32: TShadowEffect;
    EdtCodCliente: TEdit;
    ShadowEffect31: TShadowEffect;
    LblRazaoSocial: TLabel;
    ShadowEffect2: TShadowEffect;
    EdtRazao: TEdit;
    ShadowEffect8: TShadowEffect;
    LblCnpj: TLabel;
    ShadowEffect3: TShadowEffect;
    EdtCnpj: TEdit;
    ShadowEffect9: TShadowEffect;
    LblEndereco: TLabel;
    ShadowEffect4: TShadowEffect;
    EdtEndereco: TEdit;
    ShadowEffect10: TShadowEffect;
    LblNumero: TLabel;
    ShadowEffect5: TShadowEffect;
    EdtNumero: TEdit;
    ShadowEffect11: TShadowEffect;
    LblComplemento: TLabel;
    ShadowEffect6: TShadowEffect;
    EdtComplemento: TEdit;
    ShadowEffect12: TShadowEffect;
    LblCEP: TLabel;
    ShadowEffect7: TShadowEffect;
    EdtCep: TEdit;
    ShadowEffect13: TShadowEffect;
    LblCidade: TLabel;
    ShadowEffect25: TShadowEffect;
    EdtCidade: TEdit;
    ShadowEffect27: TShadowEffect;
    LblBairro: TLabel;
    ShadowEffect29: TShadowEffect;
    EdtBairro: TEdit;
    ShadowEffect28: TShadowEffect;
    ShadowEffect30: TShadowEffect;
    LblUF: TLabel;
    ShadowEffect24: TShadowEffect;
    CBUF: TComboBox;
    ShadowEffect26: TShadowEffect;
    LblAtivo: TLabel;
    ShadowEffect21: TShadowEffect;
    CBAtivo: TComboBox;
    ShadowEffect22: TShadowEffect;
    TabItem2: TTabItem;
    Panel1: TPanel;
    GridClientes: TStringGrid;
    EditPesquisa: TEdit;
    LblPesquisar: TLabel;
    ShadowEffect33: TShadowEffect;
    ShadowEffect34: TShadowEffect;
    BtnPesquisar: TButton;
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
    procedure BtnPesquisarClick(Sender: TObject);
    procedure TabItem2Click(Sender: TObject);
  private
    { Private declarations }
    FConexao: TFDConnection;
    FCliente: TClientes;
    PodeGravar: Boolean;
    FUFCliente: string;
    FAtivoCliente: string;
    qry: TFDQuery;
    RegrasDeNegocios: TModelCliente;
    FTipo: String;
    FController: TControllerCliente;
    CDS: TClientDataSet;
    procedure DesabilitaBotoes(const BotaoSet:TBotaoSet);
    Procedure PopularGridClientes;
    procedure PreencheDadosEncontradosDoCliente;
    procedure PopularDataSet;
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
  RegrasDeNeogicios: TModelCliente;
  Cliente: TClientes;
begin
  FTipo:='A';

  DesabilitaBotoes([BiGravar]);

  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

end;

procedure TFrmCadastroClientes.btnAnteriorClick(Sender: TObject);
begin
  DataSet.prior;
  OnDataSetChange;
end;

procedure TFrmCadastroClientes.BtnExcluirClick(Sender: TObject);
begin
  FTipo:='E';
  DesabilitaBotoes([BiGravar]);
end;

procedure TFrmCadastroClientes.BtnGravarClick(Sender: TObject);
var
  Abortar: Boolean;
begin
  PopularClientes;
  try
     //Testar se os campos foram todos preenchidos
     RegrasDeNegocios:= TModelCliente.Create;
     PodeGravar :=  RegrasDeNegocios.TestaSeCamposPreenchidos(Fcliente);

     if PodeGravar then //testar preenchimento dos campos
     begin

       Abortar:= RegrasDeNegocios.ClienteExiste(FCliente.cnpj);
       if Abortar then  //cliente Existe
       begin
         ShowMessage('Cliente já existe no Cadastro!');
         RegrasDeNegocios.AlterarCliente(FCliente);
       end
       else if FTipo='N' then //Inclusão cai fora
              RegrasDeNegocios.SalvarCliente(FCliente);
     end
     else //Não atendeu as regras de negócios
     begin
       ShowMessage('Não foi possível salvar os dados do cliente');

       if EdtRazao.CanFocus then
         EdtRazao.SetFocus;
     end;
     DesabilitaBotoes([BiPrimeiro,BiAnterior,BiProximo,BiUltimo,BiNovo,BiAlterar,BiExcluir,BiGravar]);
  finally
    FCliente.Free;
    RegrasDeNegocios.Free;
  end;

end;

procedure TFrmCadastroClientes.BtnNovoClick(Sender: TObject);
begin
  FTipo:='N';

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
  CBUF.Index          := 24; //Ver qual o index de SP para trocar aqui
  CBAtivo.Index       := 1;

  //Foco no campo EdtRazao
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

end;

procedure TFrmCadastroClientes.BtnPesquisarClick(Sender: TObject);
var
  I, J: Integer;
  TermoPesquisa: string;
begin
  PopularDataSet;
  //Revisar o uso na aba da tela de clientes onde tem o GRIDClientes.
  TermoPesquisa := EditPesquisa.Text;

  // Percorra as células do grid para encontrar correspondências com o termo de pesquisa
  for I := 0 to GridClientes.RowCount - 1 do
  begin
    for J := 0 to GridClientes.ColumnCount - 1 do
    begin
      if Pos(UpperCase(TermoPesquisa), UpperCase(GridClientes.Cells[J, I])) > 0 then
      begin
        // Destaque a célula encontrada
        GridClientes.SelectCell(J, I);

        // Faça algo com a célula encontrada, como exibir uma mensagem
        ShowMessage('Encontrado em ' + GridClientes.Cells[J, 0] + ': ' + GridClientes.Cells[J, I]);

        //Preencher os Edits da Aba Cadastro
        PreencheDadosEncontradosDoCliente;

        // Você pode retornar aqui se desejar encontrar apenas a primeira correspondência
        // Exit;
      end;

    end;
  end;

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
  FController:= TControllerCliente.Create;
end;

Function TFrmCadastroClientes.CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
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
   FController.Free;
   FConexao.Free;
  inherited;
end;

procedure TFrmCadastroClientes.PopularDataSet;
var
  Model: TModelCliente;
begin
  Model := TModelCliente.create;
  DataSet := TClientDataset.Create(nil);
  try
    qry := Model.CarregarTodosClientes(DataSet);
    DataSet := CriarDataSet(DataSet);
    DataSet.Open;
    qry.First;
    while not qry.eof do
    begin
      DataSet.Append;
      DataSet.FieldByName('idclientes').AsInteger := Qry.FieldByName('idclientes').AsInteger;
      DataSet.FieldByName('razao').AsString := Qry.FieldByName('razao').AsString;
      DataSet.FieldByName('cnpj_cpf').AsString := Qry.FieldByName('cnpj_cpf').AsString;
      DataSet.FieldByName('endereco').AsString := Qry.FieldByName('endereco').AsString;
      DataSet.FieldByName('numero').AsInteger := Qry.FieldByName('numero').AsInteger;
      DataSet.FieldByName('complemento').AsString := Qry.FieldByName('complemento').AsString;
      DataSet.FieldByName('CEP').AsString := Qry.FieldByName('CEP').AsString;
      DataSet.FieldByName('Cidade').AsString := Qry.FieldByName('Cidade').AsString;
      DataSet.FieldByName('Bairro').AsString := Qry.FieldByName('Bairro').AsString;
      DataSet.FieldByName('UF').AsString := Qry.FieldByName('UF').AsString;
      DataSet.FieldByName('ATIVO').AsString := Qry.FieldByName('ATIVO').AsString;
      DataSet.Post;
      qry.Next;
    end;
    DataSet.First;
    OnDataSetChange;
  finally
  end;
  //Cliente.Free;
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
  CDS.Free;
end;

procedure TFrmCadastroClientes.FormCreate(Sender: TObject);
begin
  PopularDataSet;
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
  EdtCodCliente.Text  := IntToStr(DataSet.FieldByName('idclientes').AsInteger);
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
  ufCliente    := DataSet.FieldByName('uf').AsString;
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

  PopularClientes;  //Popula a variável FClientes
  //PopularGridClientes; //Fica pulando cliente
end;

procedure TFrmCadastroClientes.PopularClientes;
begin
  FCliente := TClientes.Create;
  try
     FCliente.razaosocial := EdtRazao.Text;
     FCliente.cnpj        := EdtCnpj.Text;
     FCliente.Endereco    := EdtEndereco.Text;
     FCliente.Numero      := StrToInt(EdtNumero.Text);
     FCliente.Complemento := EdtComplemento.Text;
     FCliente.Cep         := EdtCep.Text;
     FCliente.Cidade      := EdtCidade.Text;
     FCliente.Bairro      := EdtBairro.Text;
     FCliente.UF          := CBUF.Items.Text; //AC toda vez.
     FCliente.Ativo       := CBAtivo.Items.Text;
  finally
    //FCliente.Free;
  end;

end;

procedure TFrmCadastroClientes.PopularGridClientes;
var
  I, J: Integer;

begin
  //Está pulando um registro ao dar o Proximo na View.

  // Limpar as colunas existentes
  while GridClientes.ColumnCount > 0 do
    GridClientes.RemoveObject(GridClientes.Columns[0]);


  // Configurar as colunas do grid
  GridClientes.RowCount := DataSet.RecordCount + 1;

  for I := 0 to DataSet.FieldCount - 1 do
  begin
    GridClientes.AddObject(TStringColumn.Create(GridClientes));
    GridClientes.Columns[I].Header := DataSet.Fields[I].FieldName;
  end;

  // Populando as células do grid com os dados do dataset
  DataSet.First;
  I := 0;

  while not DataSet.Eof do
  begin
    Inc(I);
    for J := 0 to DataSet.FieldCount - 1 do
      GridClientes.Cells[J, I] := DataSet.Fields[J].AsString;

    DataSet.Next;

  end;

end;

procedure TFrmCadastroClientes.PreencheDadosEncontradosDoCliente;
var
  SelectedRow: Integer;
begin
  if GridClientes.Selected >= 0 then
  begin
    SelectedRow := GridClientes.Selected;
    EdtCodCliente.Text  := GridClientes.Cells[0, SelectedRow];
    EdtRazao.Text       := GridClientes.Cells[1, SelectedRow];
    EdtCnpj.Text        := GridClientes.Cells[2, SelectedRow];
    EdtEndereco.Text    := GridClientes.Cells[3, SelectedRow];
    EdtNumero.Text      := GridClientes.Cells[4, SelectedRow];
    EdtComplemento.Text := GridClientes.Cells[5, SelectedRow];
    EdtCep.Text         := GridClientes.Cells[6, SelectedRow];
    EdtCidade.Text      := GridClientes.Cells[7, SelectedRow];
    EdtBairro.Text      := GridClientes.Cells[8, SelectedRow];
    CBUF.ItemIndex      := CBUF.Items.IndexOf(GridClientes.Cells[9, SelectedRow]);
    CBAtivo.ItemIndex   := CBAtivo.Items.IndexOf(GridClientes.Cells[10, SelectedRow]);
  end;

end;

procedure TFrmCadastroClientes.TabItem2Click(Sender: TObject);
begin
  PopularGridClientes;
end;

end.
