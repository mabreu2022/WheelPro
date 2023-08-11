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
  Entity.Contatos,
  Controller.Contatos,
  Controller.Clientes,
  Model.Clientes,
  Model.Contatos,
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
  Winapi.Windows,
  LogManager,
  FireDAC.FMXUI.Wait,
  Funcoes.CNPJCPF;


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
    EdtCodContato: TEdit;
    ShadowEffect36: TShadowEffect;
    LblNomeContato: TLabel;
    EdtNomeContato: TEdit;
    lblTelefoneContato: TLabel;
    EdtTelefoneContato: TEdit;
    lblEmailContato: TLabel;
    EdtEmailContato: TEdit;
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
    lblCelularContato: TLabel;
    EdtCelularContato: TEdit;
    ShadowEffect54: TShadowEffect;
    ShadowEffect55: TShadowEffect;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtCnpjExit(Sender: TObject);
  private
    { Private declarations }
    FConexao: TFDConnection;
    FCliente: TClientes;
    FContato: TContato;
    PodeGravar: Boolean;
    FUFCliente: string;
    FAtivoCliente: string;
    qry: TFDQuery;
    RegrasDeNegocios: TModelCliente;
    FModelContato: TModelContato;
    FTipo: String;
    FController: TControllerCliente;
    CDS: TClientDataSet;
    FLinguagem: string;
    CurrentDateTime: TDateTime; //Para uso com o Log
    DateTimeStr: string;        //Para uso com o Log
    FGravarLog: Boolean;        //Para uso com o Log
    FHabilitarLogsSistema: string;
    FNextIDContato: Integer;
    FGravacaoSucesso: Boolean;
    procedure DesabilitaBotoes(const BotaoSet:TBotaoSet);
    Procedure PopularGridClientes;
    procedure PreencheDadosEncontradosDoCliente;
    procedure PopularDataSet;
    procedure CarregarConfiguracao;
    procedure PopularContatos;
    function LerSalvarLogsBancoDeDados: Boolean;
    function GravarLogsBancoDeDados: Boolean;
  public
    { Public declarations }
    DataSet: TClientDataSet;
    FSomenteAtivos: string;
    FSemContatos  : string;
    FBtnUltimo    : string;
    Function CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
    procedure OnDataSetChange;
    procedure PopularClientes;
    procedure CarregarCores;
    procedure CarregarLinguagem;
    function ProximoIDContato: integer;


  end;

var
  FrmCadastroClientes: TFrmCadastroClientes;

implementation

{$R *.fmx}

{ TFrmCadastroClientes }

procedure TFrmCadastroClientes.BtnAlterarClick(Sender: TObject);
begin
  FTipo:='A';

  TabItemPesquisa.Enabled:=False;

  DesabilitaBotoes([BiGravar]);

  //Ver que aba está selecionada para pode setar o foco no campo correto
  if TabControl1.TabIndex = 0 then
  begin
    if EdtRazao.CanFocus then
      EdtRazao.SetFocus;
  end
  else
  if TabControl1.TabIndex = 2 then
  begin
    if EdtNomeContato.CanFocus then
      EdtNomeContato.SetFocus;
  end;

end;

procedure TFrmCadastroClientes.btnAnteriorClick(Sender: TObject);
begin
  PopularDataSet;
  DataSet.prior;
  OnDataSetChange;
end;

procedure TFrmCadastroClientes.BtnExcluirClick(Sender: TObject);
begin
  TabItemPesquisa.Enabled:=False;
  FTipo:='E';
  DesabilitaBotoes([BiGravar]);
end;

procedure TFrmCadastroClientes.BtnGravarClick(Sender: TObject);
var
  Abortar: Boolean;
  Confirmacao: Integer;
  LogManager: TLogManager;
begin
  DesabilitaBotoes([BiPrimeiro,BiAnterior,BiProximo,BiUltimo,BiNovo,BiAlterar,BiExcluir]);

  TabItemPesquisa.Enabled:=True;

  PopularClientes;
  PopularContatos;

  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 295 - BtnnGravar - Criou a RegrasdeNegocios às ' +  DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

  RegrasDeNegocios:= TModelCliente.Create;

  if FGravarLog then
  begin
     LogManager:= TLogManager.Create;
     try
       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 310 - BtnnGravar - Criou a FModelContato às ' +  DateTimeStr);
       LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
     finally
       LogManager.Free;
     end;
  end;

  FModelContato   := TModelContato.Create;

  //Testar se os campos foram todos preenchidos
  PodeGravar      := RegrasDeNegocios.TestaSeCamposPreenchidos(Fcliente);

  if PodeGravar then //testar preenchimento dos campos
  begin  //Rever regras
    Abortar:= RegrasDeNegocios.ClienteExiste(FCliente.cnpj);
    if Abortar then  //cliente Existe
    begin
      ShowMessage('Cliente já existe no Cadastro!');

      if FTipo='A' then //Alterar
      begin
        FGravacaoSucesso := False;
        FGravacaoSucesso := RegrasDeNegocios.AlterarCliente(FCliente);
        FGravacaoSucesso := FModelContato.AlterarContato(FContato);
        PopularDataSet;
        OnDataSetChange;
        if FGravacaoSucesso then
          ShowMessage('Alteracao feita com sucesso!');
        Exit;
      end;

      if FTipo='N' then //Novo Registro
      begin
        FGravacaoSucesso := False;
        FGravacaoSucesso := RegrasDeNegocios.SalvarCliente(FCliente);
        FGravacaoSucesso := FModelContato.SalvarContato(FContato, FCliente);
        PopularDataSet;
        OnDataSetChange;
        if FGravacaoSucesso then
          ShowMessage('Dados  gravados com sucesso!');
        Exit;
      end;

      if FTipo='E' then //Excluir
      begin
        FGravacaoSucesso := False;
        FGravacaoSucesso := RegrasDeNegocios.RemoverCliente(FCliente);
        FGravacaoSucesso := FModelContato.RemoverContato(FContato);
        PopularDataSet;
        OnDataSetChange;
        if FGravacaoSucesso then
          ShowMessage('Dados excluidos com sucesso!');
        Exit;
      end;

    end
    else //Cadastra o Cliente novo   //faz sentido ter  nonvamente   o  SalvarCliente/SalvarContato?????
    begin
      RegrasDeNegocios.SalvarCliente(FCliente);
      FModelContato.SalvarContato(FContato, FCliente);
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

  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 383 - BtnnGravar - deu Free na FCliente às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      FCliente.Free;

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 389 BtnnGravar - deu Free na RegrasDeNegocios às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      RegrasDeNegocios.Free;

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 395 - BtnnGravar - deu Free na FModelContato às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      FModelContato.Free;

    finally
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 402 - BtnnGravar - deu Free na LogManager às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      LogManager.Free;
    end;
  end;

end;

procedure TFrmCadastroClientes.BtnNovoClick(Sender: TObject);
var
  qry                   : TFDQuery;
  NextID, NextIDContato : Integer;
  LogManager            : TLogManager;
begin
  TabItemPesquisa.Enabled:=False;
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha 422 - BtnNovoClick - Criou a qry às '  + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

  FTipo := 'N';

  DesabilitaBotoes([BiGravar]); // Desabilita todos os botões, exceto o botão Gravar

  qry := TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Text := 'SELECT MAX(idclientes) + 1 AS NextID FROM Clientes';
    qry.Open;

    NextID := qry.FieldByName('NextID').AsInteger;

    // Verifique se o valor retornado é NULL (sem registros na tabela)
    if qry.FieldByName('NextID').IsNull then
      NextID := 1;

  finally
    if FGravarLog then
    begin
      LogManager := TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Clientes: Linha 453: BtnNovoClick - Free qry às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      finally
        LogManager.Free;
      end;
    end;
    qry.Free;
  end;

  // Limpar todos os campos de clientes
  EdtCodCliente.Text := IntToStr(NextID);
  EdtRazao.Text       := '';
  EdtCnpj.Text        := '';
  EdtEndereco.Text    := '';
  EdtNumero.Text      := '';
  EdtComplemento.Text := '';
  EdtCep.Text         := '';
  EdtCidade.Text      := '';
  EdtBairro.Text      := '';
  CBUF.ItemIndex      := 24;
  CBAtivo.ItemIndex   := 1;

  // Foco no campo EdtRazao
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

  qry := TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  try
    qry.SQL.Text := 'SELECT MAX(idcontatos) + 1 AS NextIDContatos FROM contatos';
    qry.Open;

    NextIDContato := qry.FieldByName('NextIDContatos').AsInteger;

    // Verifique se o valor retornado é NULL (sem registros na tabela)
    if qry.FieldByName('NextIDContatos').IsNull then
      NextIDContato := 1;

  finally
    if FGravarLog then
    begin
      LogManager := TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Clientes: Linha 498: BtnNovoClick - Free qry às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      finally
        LogManager.free;
      end;
    end;
    qry.Free;
  end;

  //Limpar todos os campos dos contatos
  EdtCodContato.Text       := IntToStr(NextIDContato);
  EdtNomeContato.Text      := '';
  EdtTelefoneContato.Text  := '';
  EdtCElularContato.Text   := '';
  EdtEmailContato.Text     := '';
  CBAtivoContato.ItemIndex := 1;

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
         Exit;
      end;

    end;
  end;

end;

procedure TFrmCadastroClientes.BtnPrimeiroClick(Sender: TObject);
begin
  PopularDataSet;
  DataSet.First;
  OnDataSetChange;
end;

procedure TFrmCadastroClientes.BtnProximoClick(Sender: TObject);
begin
  PopularDataSet;
  DataSet.Next;
  OnDataSetChange;
end;

procedure TFrmCadastroClientes.BtnUltimoClick(Sender: TObject);
begin
  FBtnUltimo:='S';
  PopularDataSet;  //Ver uma forma de aba Contatos Limpar Campos e pegar o proximo IDContato se não tiver registro de contatos daquele cliente.
  DataSet.Last;
  OnDataSetChange;
end;

procedure TFrmCadastroClientes.CarregarConfiguracao;
var
   IniFile    : TIniFile;
   LogManager : TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 580 - Carregar Configuração - Criou o IniFile às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

    LogManager.CarregarConfiguracao;
    FSomenteAtivos        := LogManager.FSomenteAtivos;        //Carregar clientes Ativos='S'
    FSemContatos          := LogManager.FSemContatos;          //Carregar Clientes sem contatos
    FHabilitarLogsSistema := LogManager.FHabilitarLogsSistema; //Salvar Logs do Sistema
  finally
    LogManager.Free;
  end;

end;

procedure TFrmCadastroClientes.CarregarCores;
var
  IniFile: TIniFile;
  Cor: TAlphaColor;
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - na Cadastro de Clientes: Linha : 629 - Entrou no Carregar Cores às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Cor := StringToAlphaColor(IniFile.ReadString('Cores', 'Cor', ''));
  finally
    IniFile.UpdateFile;
    IniFile.Free;
  end;
  //Varre todos os TRecTangle para pintar com a cor escolhida
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
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 664 - Entrou no Carregar Linguagem - Criou o IniFile às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      Logmanager.Free;
    end;
  end;

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
    if FGravarLog then
    begin
      LogManager:= TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 751 - Finalizou o Carregar Linguagem - Deu Free no IniFile às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

      finally
        LogManager.Free;
      end;
    end;
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

Function TFrmCadastroClientes.CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
var
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:=TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 791 - Criar DataSet - Criou o CDS às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

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

    CDS.FieldDefs.Add('IDCONTATOS', ftInteger); //Campos da Tabela Contatos
    CDS.FieldDefs.Add('NOMECONTATO', ftString, 45);
    CDS.FieldDefs.Add('TELEFONE', ftString,45);
    CDS.FieldDefs.Add('CELULAR', ftString,45);
    CDS.FieldDefs.Add('EMAIL', ftString, 100);
    CDS.FieldDefs.Add('CNPJREVENDA', ftString, 15);
    CDS.FieldDefs.Add('ATIVOCONTATO', ftString,1);

    CDS.CreateDataSet;

    Result:= CDS;

  finally
    FGravarLog:=  LerSalvarLogsBancoDeDados;
    if FGravarLog then
    begin
      LogManager := TLogManager.Create;
      try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 831 - Gravou os arquivos de Logs nno Banco de Dados às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      finally
        LogManager.Free;
      end;
      if (FGravarLog) and (FHabilitarLogsSistema='S') then
      GravarLogsBancoDeDados;
    end;
  end;

end;

procedure TFrmCadastroClientes.PopularDataSet;
var
  Model: TModelCliente;
  ModelContatos: TModelContato;
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 858 - Entrou no PopularDataSet e criou Model às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 863 - Entrou o PopularDataSet - e criou ModelContatos às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 868 - Entrou o PopularDataSet - e criou DataSet às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

    finally
      LogManager.Free;
    end;
  end;
  Model         := TModelCliente.create;
  ModelContatos := TModelContato.Create;

  DataSet       := TClientDataset.Create(nil);
  try
    if FBtnUltimo='S' then
      qry := Model.CarregarTodosClientes(DataSet, FSomenteAtivos, FSemContatos, 'S')
    else
      qry := Model.CarregarTodosClientes(DataSet, FSomenteAtivos, FSemContatos);

    DataSet := CriarDataSet(DataSet);
    DataSet.Open;
    qry.First;
    while not qry.eof do
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
      DataSet.FieldByName('UF').AsString          := Qry.FieldByName('UF').AsString;
      DataSet.FieldByName('ATIVO').AsString       := Qry.FieldByName('ATIVO').AsString;

      //Campos da Tabela Contatos
      DataSet.FieldByName('IDCONTATOS').AsInteger  := Qry.FieldByName('IDCONTATOS').AsInteger;
      DataSet.FieldByName('NOMECONTATO').AsString  := Qry.FieldByName('NOMECONTATO').AsString;
      DataSet.FieldByName('TELEFONE').AsString     := Qry.FieldByName('TELEFONE').AsString;
      DataSet.FieldByName('CELULAR').AsString      := Qry.FieldByName('CELULAR').AsString;
      DataSet.FieldByName('EMAIL').AsString        := Qry.FieldByName('EMAIL').AsString;
      DataSet.FieldByName('CNPJREVENDA').AsString  := Qry.FieldByName('CNPJREVENDA').AsString;
      DataSet.FieldByName('ATIVOCONTATO').AsString := Qry.FieldByName('ATIVO').AsString;

      DataSet.Post;
      qry.Next;
    end;

    DataSet.First;
    OnDataSetChange;

  finally
    if FGravarLog then
    begin
      LogManager := TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 926 - Finalizou a PopularDataSet - Free Model  às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 931 - Finalizou a PopularDataSet - Free ModelContatos  às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 936 - Finalizou a PopularDataSet - E não deu free no DadaSet às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      finally
        LogManager.Free;
      end;

    end;
    Model.Free;
    ModelContatos.Free;
  end;

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

procedure TFrmCadastroClientes.EdtCnpjExit(Sender: TObject);
var
  Funcoes: TCNPJCPF;
begin
  Funcoes:= TCNPJCPF.Create;
  try
    if not Funcoes.ValidarCNPJ(EdtCNPJ.Text) then
    begin
      ShowMessage('CNPJ inválido');
      EdtCnpj.SetFocus;
      BtnGravar.Enabled:= False;
    end
    else
      BtnGravar.Enabled:= True;;

    if not Funcoes.ValidarCPF(EdtCnpj.Text) then
    begin
      ShowMessage('CPF inválido');
      EdtCnpj.SetFocus;
      BtnGravar.Enabled:= False;
    end
    else
      BtnGravar.Enabled:= True;

  finally
    Funcoes.Free;
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
var
   LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela Cadastro de Clientes - Linha: 1058 - FormClose -  Deu Free no CDS às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela Cadastro de Clientes - Liha: 1063 - FormClose -  Deu Free no FCliente às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela Cadastro de Clientes - Liha: 1068 - FormClose -  Deu Free no FContato às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela Cadastro de Clientes - Liha: 1073 - FormClose -  Deu Free no FController às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - na Cadastro de Clientes - Linha : 1078 - FrmCadastroClientes Destroy - e deu Free no FConexao às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

      if Assigned(qry) then
      begin
        qry.Close;
        qry.Free;
      end;

    finally
      LogManager.Free;
    end;
  end;

  CDS.Free;
  if Assigned(FCliente) then
   FCliente.Free;
  FContato.Free;
  FController.Free;
  FConexao.Close;
  FConexao.Free;

end;

procedure TFrmCadastroClientes.FormCreate(Sender: TObject);
var
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager := TLogManager.Create;
    try
       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Tela - Cadastro de Clientes - Linha: 1111 - FormCreate - Criou o LogManager às ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1116 - Create - Criou o FConexao às ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Tela -  Cadastro de Clientes: Linha : 1121 - Create - Criou o FCliente às ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1126 - Create - Criou o FContato às ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1131 - Create - Criou o FController às ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

    finally
      LogManager.Free;
    end;
  end;
  FConexao := TConnection.CreateConnection;
  FCliente := TClientes.create;
  FContato := TContato.Create;
  FController:= TControllerCliente.Create;

  CarregarConfiguracao;
  PopularDataSet;
  CarregarCores;
  CarregarLinguagem;

end;

procedure TFrmCadastroClientes.FormShow(Sender: TObject);
begin
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

  BtnGravar.Enabled:= False;

  TabControl1.ActiveTab:=TabItemCadastro;
end;

function TFrmCadastroClientes.GravarLogsBancoDeDados: Boolean;
var
  FLogManager: TLogManager;
begin
  Result:=False;
  FLogManager:= TLogManager.Create;
  try
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Cadastro_de_Clientes.txt', 'Log_Cadastro_de_Clientes.txt' ,'Logs');
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Entity_Contatos.txt' ,'Log_Entity_Contatos.txt','Logs');
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Model_Clientes.txt', 'Log_Model_Clientes.txt','Logs');
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Model_Contatos.txt', 'Log_Model_Contatos.txt','Logs');
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Tela_de_Login.txt', 'Log_Tela_de_Login.txt','Logs');
  finally
    FLogManager.Free;
    Result:= True;
  end;
end;

function TFrmCadastroClientes.LerSalvarLogsBancoDeDados: Boolean;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Result := SameText(IniFile.ReadString('Sistema', 'SalvarLogsBancoDeDados', ''), 'S');
  finally
    IniFile.Free;
  end;
end;

procedure TFrmCadastroClientes.OnDataSetChange;
var
  ufCliente: string;
  ativoCliente: string;
  Index: Integer;
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:=TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1202 - Entrou no OnDataChange às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

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

  //Preenche os campos do contato
  EdtCodContato.Text      := IntToStr(DataSet.FieldByName('IDCONTATOS').AsInteger);
  EdtNomeContato.Text     := DataSet.FieldByName('NOMECONTATO').AsString;
  EdtTelefoneContato.Text := DataSet.FieldByName('TELEFONE').AsString;
  EdtCelularContato.Text  := DataSet.FieldByName('CELULAR').AsString;
  EdtEmailContato.Text    := DataSet.FieldByName('EMAIL').AsString;

  PopularClientes;  //Popula a variável FClientes
  PopularContatos; //Popula Variável FContato

end;

procedure TFrmCadastroClientes.PopularContatos;
var
  LogManager: TLogManager;
  Tabela: TClientDataSet;
  qry: TFDquery;
  Ativo: String;
  i: Integer;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1260 - Entrou on PopularConntatos e Criou Fcontato às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

  //Carregar o contato  dos edits ou da query?
  FModelContato  := TModelContato.Create;
  qry            := FModelContato.ObterContatoPorId(StrToInt(EdtCodCliente.Text));
   try
    if not qry.IsEmpty then
    begin
      EdtCodContato.Text       := IntToStr(qry.FieldByName('IDCONTATOS').AsInteger);
      EdtNomeContato.Text      := qry.FieldByName('NOMECONTATO').AsString;
      EdtTelefoneContato.Text  := qry.FieldByName('TELEFONE').AsString;
      EdtCelularContato.Text   := qry.FieldByName('CELULAR').AsString;
      EdtEmailContato.Text     := qry.FieldByName('EMAIL').AsString;

      //Dados para gravação
      FContato.idcontato    := StrToInt(EdtCodContato.Text);
      Fcontato.idcliente    := StrToInt(EdtCodCliente.Text);
      FContato.NomeContato  := EdtNomeContato.Text;
      FContato.telefone     := EdtTelefoneContato.Text;
      FContato.celular      := EdtCelularContato.Text;
      FContato.email        := EdtEmailContato.Text;

      if CBAtivoContato.ItemIndex <> -1 then
      begin
        FContato.ativo      := CBAtivoContato.Items[CBAtivoContato.ItemIndex];
      end;

      Ativo := qry.FieldByName('ATIVO').AsString;

      CBAtivoContato.ItemIndex := -1; // Define o ItemIndex como -1 (nenhum item selecionado) por padrão

      for i := 0 to CBAtivoContato.Items.Count - 1 do
      begin
        if CBAtivoContato.Items[i] = Ativo then
        begin
          CBAtivoContato.ItemIndex := i; // Atribui o índice do item correspondente
          Break; // Interrompe o loop quando encontrar o item correspondente
        end;
      end;

    end;
  finally
    qry.Free;
    FModelContato.Free;
  end;

  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha :  1273 - Finalizou a PopularConntatos deu free na qry e FModelContato às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

end;

procedure TFrmCadastroClientes.PopularClientes;
var
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1301 - Entrou na PopularClientes e Criou FCliente às ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
       LogManager.Free;
    end;
  end;

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
    if FGravarLog then
    begin
      LogManager:= TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1329 - Finalizou a PopularClientes e não deu Free na FCliente às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      finally
        LogManager.Free;
      end;
    end;
  end;

end;

procedure TFrmCadastroClientes.PopularGridClientes;
var
  I, J: Integer;
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1350 - Entrou na PopularGridClientes às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

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
  //DataSet.Close;
  DataSet.Free;

end;

procedure TFrmCadastroClientes.PreencheDadosEncontradosDoCliente;
var
  SelectedRow: Integer;
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes  - Linha : 1455 - Enntrou na PreecheDadosEncontratosDoCliente às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

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

    //CONTATO
    EdtCodContato.Text       := GridClientes.Cells[11, SelectedRow];
    EdtNomeContato.Text      := GridClientes.Cells[12, SelectedRow];
    EdtTelefoneContato.Text  := GridClientes.Cells[13, SelectedRow];
    EdtCelularContato.Text   := GridClientes.Cells[14, SelectedRow];
    EdtEmailContato.Text     := GridClientes.Cells[15, SelectedRow];
    CBAtivoContato.ItemIndex := CBAtivoContato.Items.IndexOf(GridClientes.Cells[9, SelectedRow]);
  end;

end;

function TFrmCadastroClientes.ProximoIDContato: integer;
var
  qry: TFDQuery;
  LogManager: TLogManager;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  try
    qry.SQL.Text := 'SELECT MAX(idcontatos) + 1 AS NextIDContatos FROM contatos';
    qry.Open;

    FNextIDContato := qry.FieldByName('NextIDContatos').AsInteger;

    // Verifique se o valor retornado é NULL (sem registros na tabela)
    if qry.FieldByName('NextIDContatos').IsNull then
      FNextIDContato := 1;

  finally
    if FGravarLog then
    begin
      LogManager:= TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Clientes: Linha 1512 - Fucntion ProximoIDContato - Free qry às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      finally
        LogManager.Free;
      end;
    end;
    qry.Free;
  end;
end;

procedure TFrmCadastroClientes.TabItemPesquisaClick(Sender: TObject);
begin
  if FTipo<>'N' then
  begin
    PopularDataSet;
    PopularGridClientes;
  end;
end;

end.
