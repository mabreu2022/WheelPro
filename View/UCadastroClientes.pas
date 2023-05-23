unit UCadastroClientes;

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
  FMX.Edit,
  FMX.ListBox,
  Dao.Conexao,
  Entity.Clientes,
  Controller.Clientes,
  Model.Clientes,
  Data.DB,
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
  FireDAC.Comp.Client,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.PG,
  FireDAC.Comp.UI,
  System.IniFiles,
  Datasnap.DBClient,
  FMX.TabControl,
  System.Rtti,
  FMX.Grid.Style,
  FMX.Grid,
  FMX.ScrollBox,
  System.UIConsts,
  Winapi.Windows;


type
  TBotaoIndex = (biAlterar, biExcluir, biPrimeiro, biAnterior, biProximo, biUltimo, biNovo, BiGravar);
  TBotaoSet = set of TBotaoIndex;

  TFrmCadastroClientes = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    lblTitulo: TLabel;
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
    TabItemCadastro: TTabItem;
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
    TabItemPesquisa: TTabItem;
    Panel1: TPanel;
    GridClientes: TStringGrid;
    EditPesquisa: TEdit;
    LblPesquisar: TLabel;
    ShadowEffect33: TShadowEffect;
    ShadowEffect34: TShadowEffect;
    BtnPesquisar: TButton;
    TabItemContato: TTabItem;
    ShadowEffect35: TShadowEffect;
    lblCondContato: TLabel;
    EdtContato: TEdit;
    ShadowEffect36: TShadowEffect;
    LblNomeContato: TLabel;
    EdtNome: TEdit;
    lblTelefoneContato: TLabel;
    EdtTelefone: TEdit;
    lblEmailContato: TLabel;
    EdtEmail: TEdit;
    LblAtivoContato: TLabel;
    ShadowEffect37: TShadowEffect;
    CBAtivoContato: TComboBox;
    ShadowEffect38: TShadowEffect;
    ShadowEffect39: TShadowEffect;
    ShadowEffect40: TShadowEffect;
    ShadowEffect41: TShadowEffect;
    ShadowEffect42: TShadowEffect;
    ShadowEffect43: TShadowEffect;
    ShadowEffect44: TShadowEffect;
    ShadowEffect45: TShadowEffect;
    ShadowEffect46: TShadowEffect;
    ShadowEffect47: TShadowEffect;
    ShadowEffect48: TShadowEffect;
    TabItemModeloCarro: TTabItem;
    lblidmodelocarro: TLabel;
    ComboBox1: TComboBox;
    Edit5: TEdit;
    lblModelo: TLabel;
    ShadowEffect49: TShadowEffect;
    ShadowEffect50: TShadowEffect;
    ShadowEffect51: TShadowEffect;
    ShadowEffect52: TShadowEffect;
    GroupBoxFoto: TGroupBox;
    CalloutPanel1: TCalloutPanel;
    Image1: TImage;
    ShadowEffect53: TShadowEffect;
    procedure FormShow(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
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
    procedure TabItemPesquisaClick(Sender: TObject);
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
    FLinguagem: string;
    procedure DesabilitaBotoes(const BotaoSet:TBotaoSet);
    Procedure PopularGridClientes;
    procedure PreencheDadosEncontradosDoCliente;
    procedure PopularDataSet;
    procedure CarregarConfiguracao;
  public
    { Public declarations }
    DataSet: TClientDataSet;
    FSomenteAtivos: string;
    Function CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
    procedure OnDataSetChange;
    procedure PopularClientes;
    procedure CarregarCores;
    procedure CarregarLinguagem;
    constructor create;
    destructor destroy; override;
  end;

var
  FrmCadastroClientes: TFrmCadastroClientes;

implementation

{$R *.fmx}

{ TFrmCadastroClientes }

procedure TFrmCadastroClientes.BtnAlterarClick(Sender: TObject);
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
  Confirmacao: Integer;
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

         if FTipo='A' then //Alterar
         begin
           RegrasDeNegocios.AlterarCliente(FCliente);
           PopularDataSet;
           OnDataSetChange;
           Exit;
         end;

         if FTipo='N' then //Novo Registro
         begin
           RegrasDeNegocios.SalvarCliente(FCliente);
           PopularDataSet;
           OnDataSetChange;
           Exit;
         end;

         if FTipo='E' then //Excluir
         begin
           RegrasDeNegocios.RemoverCliente(FCliente);
           PopularDataSet;
           OnDataSetChange;
           Exit;
         end;

       end
       else //Cadastra o Cliente novo
       begin
         RegrasDeNegocios.SalvarCliente(FCliente);
         PopularDataSet;
         OnDataSetChange;
         Exit;
       end;

     end
     else //Não atendeu as regras de negócios e não grava
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
var
  qry: TFDQuery;
  NextID: Integer;
begin
  FTipo := 'N';

  DesabilitaBotoes([BiGravar]); // Desabilita todos os botões, exceto o botão Gravar

  qry := TFDQuery.Create(nil); // Crie o objeto TFDQuery

  try
    qry.Connection := TConnection.CreateConnection; // Substitua "SuaConexao" pela sua conexão de banco de dados

    qry.SQL.Text := 'SELECT MAX(idclientes) + 1 AS NextID FROM Clientes';
    qry.Open;

    NextID := qry.FieldByName('NextID').AsInteger;

    // Verifique se o valor retornado é NULL (sem registros na tabela)
    if qry.FieldByName('NextID').IsNull then
      NextID := 1;

  finally
    qry.Free;
  end;

  // Limpar todos os campos da tela
  EdtCodCliente.Text := IntToStr(NextID);
  EdtRazao.Text := '';
  EdtCnpj.Text := '';
  EdtEndereco.Text := '';
  EdtNumero.Text := '';
  EdtComplemento.Text := '';
  EdtCep.Text := '';
  EdtCidade.Text := '';
  EdtBairro.Text := '';
  CBUF.ItemIndex := 24;
  CBAtivo.ItemIndex := 1;

  // Foco no campo EdtRazao
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

procedure TFrmCadastroClientes.CarregarConfiguracao;
var
   IniFile: TIniFile;

begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    FSomenteAtivos :=IniFile.ReadString('Sistema', 'carregaclientesativosn', '');
  finally
    IniFile.Free;
    //FModel.Free;  //Finalizar no onclose do form
  end;
end;

procedure TFrmCadastroClientes.CarregarCores;
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

  for var I := 0 to FrmCadastroClientes.ComponentCount - 1 do
  begin
    if FrmCadastroClientes.Components[I] is TRectangle then
      TRectangle(FrmCadastroClientes.Components[I]).Fill.Color := Cor;
  end;

end;

procedure TFrmCadastroClientes.CarregarLinguagem;
var
  IniFile: TIniFile;
  I: Integer;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    FLinguagem :=IniFile.ReadString('Traducao', 'Linguagem', '');

   if FLinguagem = 'Portuguese' then
   begin
     TabItemCadastro.Text         := 'Cadastro';
     LblCodCliente.Text           := 'Cod.Cliente';
     LblRazaoSocial.Text          := 'Razão Social / Nome';
     LblCnpj.Text                 := 'CNPJ / CPF';
     LblEndereco.Text             := 'Endereço';
     LblNumero.Text               := 'Número';
     LblComplemento.Text          := 'Complemento';
     LblCEP.Text                  := 'CEP';
     LblCidade.Text               := 'Cidade';
     LblBairro.Text               := 'Bairro';
     LblUF.Text                   := 'UF';
     LblAtivo.Text                := 'Ativo';
     TabItemPesquisa.Text         := 'Pesquisa';
     LblPesquisar.Text            := 'Pesquisar';
     BtnPesquisar.Text            := '&Confirmar';
     BtnNovo.Text                 := '&Novo';
     BtnAlterar.Text              := '&Alterar';
     BtnExcluir.Text              := '&Excluir';
     BtnGravar.Text               := '&Salvar';
     TabItemContato.Text          := 'Contato';
     lblCondContato.Text          := 'Cod. Contato';
     LblNomeContato.Text          := 'Nome';
     lblTelefoneContato.Text      := 'Telefone';
     lblEmailContato.Text         := 'E-mail';
     LblAtivoContato.Text         := 'Ativo';
     TabItemModeloCarro.Text      := 'Modelo Carro';
     lblidmodelocarro.Text        := 'Cod. Modelo';
     lblModelo.Text               := 'Modelo';
     GroupBoxFoto.Text            := 'Foto';
     FrmCadastroClientes.Caption  := 'Cadastro de Clientes';
     lblTitulo.Text               := 'Cadastro de Clientes';
   end
   else if FLinguagem = 'Ingles' then
   begin
     TabItemCadastro.Text         := 'Register';
     LblCodCliente.Text           := 'Customer Code';
     LblRazaoSocial.Text          := 'Corporate Name / Name';
     LblCnpj.Text                 := 'Tax Identification Number - TIN';
     LblEndereco.Text             := 'Address';
     LblNumero.Text               := 'Number';
     LblComplemento.Text          := 'Complement';
     LblCEP.Text                  := 'Zip code';
     LblCidade.Text               := 'City';
     LblBairro.Text               := 'Neighborhood';
     LblUF.Text                   := 'State';
     LblAtivo.Text                := 'Active';
     TabItemPesquisa.Text         := 'Search';
     LblPesquisar.Text            := 'To look for';
     BtnPesquisar.Text            := '&Confirm';
     BtnNovo.Text                 := '&New';
     BtnAlterar.Text              := '&Alter';
     BtnExcluir.Text              := '&Delete';
     BtnGravar.Text               := '&Save';
     TabItemContato.Text          := 'Contact';
     lblCondContato.Text          := 'Cod. Contact';
     LblNomeContato.Text          := 'Name';
     lblTelefoneContato.Text      := 'Telephone';
     lblEmailContato.Text         := 'E-mail';
     LblAtivoContato.Text         := 'Active';
     TabItemModeloCarro.Text      := 'Model Car';
     lblidmodelocarro.Text        := 'Model Id';
     lblModelo.Text               := 'Model';
     GroupBoxFoto.Text            := 'Photo';
     FrmCadastroClientes.Caption  := 'Customer Registration';
     lblTitulo.Text               := 'Customer Registration';
   end;

  finally
    IniFile.Free;
  end;

end;

procedure TFrmCadastroClientes.CBAtivoExit(Sender: TObject);
begin
  if FTipo<>'E' then
  begin
    if BtnGravar.CanFocus then
      BtnGravar.SetFocus;
  end
  else
  begin
    CBAtivo.OnExit := nil; // Desativa o evento OnExit temporariamente
    try
      CBAtivo.ItemIndex := 2; // Define o índice do TComboBox como 2
    finally
      CBAtivo.OnExit := CBAtivoExit; // Reativa o evento OnExit
    end;
  end;
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
   //FController.Free;
  inherited;
end;

procedure TFrmCadastroClientes.PopularDataSet;
var
  Model: TModelCliente;
begin
  Model := TModelCliente.create;
  DataSet := TClientDataset.Create(nil);
  try
    qry := Model.CarregarTodosClientes(DataSet, FSomenteAtivos);
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
    Model.Free;
//    DataSet.Free;//Ao fechar o Formulário
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

procedure TFrmCadastroClientes.FormCreate(Sender: TObject);
begin
  CarregarConfiguracao;
  PopularDataSet;
  CarregarCores;
  CarregarLinguagem;
  FController:= TControllerCliente.create;
end;

procedure TFrmCadastroClientes.FormShow(Sender: TObject);
begin
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

  BtnGravar.Enabled:= False;

  TabControl1.ActiveTab:=TabItemCadastro;
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

end;

procedure TFrmCadastroClientes.PopularClientes;
begin
  FCliente := TClientes.Create;
  try
     if FTIpo<>'N' then
       FCliente.idcliente   := StrTOInt(EdtCodCliente.Text);

     FCliente.razaosocial := EdtRazao.Text;
     FCliente.cnpj        := EdtCnpj.Text;
     FCliente.Endereco    := EdtEndereco.Text;
     FCliente.Numero      := StrToInt(EdtNumero.Text);
     FCliente.Complemento := EdtComplemento.Text;
     FCliente.Cep         := EdtCep.Text;
     FCliente.Cidade      := EdtCidade.Text;
     FCliente.Bairro      := EdtBairro.Text;
     FCliente.UF          := CBUF.Items[CBUF.ItemIndex];
     FCliente.Ativo       := CBAtivo.Items[CBAtivo.ItemIndex];
  finally
    //FCliente.Free; //no onclose do form
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
    if FLinguagem='Portugues' then
      GridClientes.Columns[I].Header := DataSet.Fields[I].FieldName
    else
    if FLinguagem='Ingles' then
    begin
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'IDCLIENTES' then
        GridClientes.Columns[I].Header := 'COSTUMER ID'
      else
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'RAZAO' then
        GridClientes.Columns[I].Header := 'BUSINESS NAME'
      else
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'CNPJ_CPF' then
        GridClientes.Columns[I].Header := 'TIN' //Ver como seria em ingles
      else
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'ENDERECO' then
        GridClientes.Columns[I].Header := 'ADRESS'
      else
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'NUMERO' then
        GridClientes.Columns[I].Header := 'NUMBER'
      else
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'COMPLEMENTO' then
        GridClientes.Columns[I].Header := 'COMPLEMENT'
      else
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'CEP' then
        GridClientes.Columns[I].Header := 'ZIP CODE'
      else
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'CIDADE' then
        GridClientes.Columns[I].Header := 'CITY'
      else
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'BAIRRO' then
        GridClientes.Columns[I].Header := 'NEIGHBORHOOD'
      else
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'ATIVO' then
        GridClientes.Columns[I].Header := 'ACTIVE'
      else
      if UPPERCASE(DataSet.Fields[I].FieldName) = 'UF' then
        GridClientes.Columns[I].Header := 'STATE'
      {
      ver aqui se serão necessários os campos de datas e idmodelocarro
      }
    end;
  end;

  // Populando as células do grid com os dados do dataset
  DataSet.First;
  I := 0;

  while not DataSet.Eof do
  begin
    Inc(I);
    for J := 0 to DataSet.FieldCount - 1 do
    begin
      if FLinguagem = 'Ingles' then
      begin
        if DataSet.Fields[J].FieldName = 'ATIVO' then
      begin
        if DataSet.Fields[J].AsString = 'S' then
          GridClientes.Cells[J, I] := 'Y'
        else
          GridClientes.Cells[J, I] := DataSet.Fields[J].AsString;
      end
      else
        GridClientes.Cells[J, I] := DataSet.Fields[J].AsString;
    end
    else
      GridClientes.Cells[J, I] := DataSet.Fields[J].AsString;
    end;

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

procedure TFrmCadastroClientes.TabItemPesquisaClick(Sender: TObject);
begin
  PopularDataSet;
  PopularGridClientes;
end;

end.
