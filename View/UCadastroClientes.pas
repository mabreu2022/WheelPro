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
  LogManager;


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
    //LogManager: TLogManager;    //Para uso com o Log
    CurrentDateTime: TDateTime; //Para uso com o Log
    DateTimeStr: string;        //Para uso com o Log
    FGravarLog: Boolean;        //Para uso com o Log
    FHabilitarLogsSistema: string;
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
   LogManager: TLogManager;
begin
  PopularClientes;
  PopularContatos;

  LogManager:= TLogManager.Create;
  try
     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 289 - BtnnGravar - Criou a RegrasdeNegocios às ' +  DateTimeStr);
     LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
     RegrasDeNegocios:= TModelCliente.Create;

     FModelContato   := TModelContato.Create;

     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 297 - BtnnGravar - Criou a FModelContato às ' +  DateTimeStr);
     LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

     //Testar se os campos foram todos preenchidos
     PodeGravar      := RegrasDeNegocios.TestaSeCamposPreenchidos(Fcliente);

     if PodeGravar then //testar preenchimento dos campos
     begin

       Abortar:= RegrasDeNegocios.ClienteExiste(FCliente.cnpj);
       if Abortar then  //cliente Existe
       begin
         ShowMessage('Cliente já existe no Cadastro!');

         if FTipo='A' then //Alterar
         begin
           RegrasDeNegocios.AlterarCliente(FCliente);
           FModelContato.AlterarContato(FContato);
           PopularDataSet;
           OnDataSetChange;
           Exit;
         end;

         if FTipo='N' then //Novo Registro
         begin
           RegrasDeNegocios.SalvarCliente(FCliente);
           FModelContato.SalvarContato(FContato); //ver onde preenche o FContato
           PopularDataSet;
           OnDataSetChange;
           Exit;
         end;

         if FTipo='E' then //Excluir
         begin
           RegrasDeNegocios.RemoverCliente(FCliente);
           FModelContato.RemoverContato(FContato);
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
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 360 - BtnnGravar - deu Free na FCliente às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    FCliente.Free;

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 366 BtnnGravar - deu Free na RegrasDeNegocios às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    RegrasDeNegocios.Free;

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 372 - BtnnGravar - deu Free na FModelContato às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    FModelContato.Free;

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 372 - BtnnGravar - deu Free na LogManager às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    LogManager.Free;

    //Chamar Rotina de Salvar Logs Caso esteja configurado para isso.
    //if FLogar then
  end;

end;

procedure TFrmCadastroClientes.BtnNovoClick(Sender: TObject);
var
  qry: TFDQuery;
  NextID: Integer;
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    FTipo := 'N';

    DesabilitaBotoes([BiGravar]); // Desabilita todos os botões, exceto o botão Gravar

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha 399 - BtnNovoClick - Criou a qry às '  + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

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
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha 418: BtnNovoClick - Free qry às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
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

  finally
    LogManager.Free;
  end;
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
   LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 501 - Carregar Configuração - Criou o IniFile às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

    IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
    try
      FSomenteAtivos := IniFile.ReadString('Sistema', 'carregaclientesativosn', '');
      FSemContatos   := IniFile.ReadString('Sistema', 'carregaclientesativosn', '');
      FHabilitarLogsSistema := IniFile.ReadString('HabilitarLogs', 'HabilitarLogsSistema', '');
   finally
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 512 - Carregar Configuração - Deu Free no IniFile às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      IniFile.Free;
   end;

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
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - na Cadastro de Clientes: Linha : 533 - Entrou no Carregar Cores às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

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

  finally
    LogManager.Free;
  end;

end;

procedure TFrmCadastroClientes.CarregarLinguagem;
var
  IniFile: TIniFile;
  I: Integer;
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 565 - Entrou no Carregar Linguagem - Criou o IniFile às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

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
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 644 - Finalizou o Carregar Linguagem - Deu Free no IniFile às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      IniFile.Free;
    end;

  finally
    LogManager.Free;
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
var
   LogManager: TLogManager;
begin
  ShowMessage('ENTREI NO CREATE DO CADASTRO DE CLIENTES');
  LogManager := TLogManager.Create;
  try
     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 680 - Create - Criou o LogManager às ' + DateTimeStr);
     LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 685 - Create - Criou o FConexao às ' + DateTimeStr);
     LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
     FConexao := TConnection.CreateConnection;

     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager.AddLog('Tela -  Cadastro de Clientes: Linha : 691 - Create - Criou o FCliente às ' + DateTimeStr);
     LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
     FCliente := TClientes.create;

     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 697 - Create - Criou o FContato às ' + DateTimeStr);
     LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
     FContato := TContato.Create;

     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 679 - Create - Criou o FController às ' + DateTimeStr);
     LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
     FController:= TControllerCliente.Create;
  finally
    LogManager.Free;
  end;
end;

Function TFrmCadastroClientes.CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
var
  LogManager: TLogManager;
begin
  LogManager:=TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 717 - Criar DataSet - Criou o CDS às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

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
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 750 - Finalizou o Criar DataSet - e não deu Free no CDS às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      FGravarLog:=  LerSalvarLogsBancoDeDados;
      if (FGravarLog) and (FHabilitarLogsSistema='S') then
        GravarLogsBancoDeDados;
    end;
  finally
    LogManager.Free;
  end;

end;

destructor TFrmCadastroClientes.destroy;
var
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - na Cadastro de Clientes: Linha : 767 - FrmCadastroClientes Destroy - e deu Free no FConexao às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    FConexao.Free;

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - na Cadastro de Clientes: Linha : 773 - FrmCadastroClientes Destroy - deu Free no FController às '  + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    FController.Free;

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - na Cadastro de Clientes: Linha : 780 - Criar DataSet Destroy - deu Free no CDS às '  + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    //DataSet.Free;

  finally
    LogManager.Free;
  end;
  inherited;
end;

procedure TFrmCadastroClientes.PopularDataSet;
var
  Model: TModelCliente;
  ModelContatos: TModelContato;
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 799 - Entrou no PopularDataSet e criou Model às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    Model         := TModelCliente.create;

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 805 - Entrou o PopularDataSet - e criou ModelContatos às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    ModelContatos := TModelContato.Create;

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 811 - Entrou o PopularDataSet - e criou DataSet às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

    DataSet       := TClientDataset.Create(nil);
    try
      qry     := Model.CarregarTodosClientes(DataSet, FSomenteAtivos, FSemContatos);
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
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 852 - Finalizou a PopularDataSet - Free Model  às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      Model.Free;

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 858 - Finalizou a PopularDataSet - Free ModelContatos  às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      ModelContatos.Free;

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 864 - Finalizou a PopularDataSet - E não deu free no DadaSet às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    end;

  finally
    LogManager.Free;
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
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela Cadastro de Clientes - Linha: 979 - FormClose -  Deu Free no CDS às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    CDS.Free;

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela Cadastro de Clientes - Liha: 985 - FormClose -  Deu Free no FCliente às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    FCliente.Free;

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela Cadastro de Clientes - Liha: 991 - FormClose -  Deu Free no FContato às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    FContato.Free;

    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela Cadastro de Clientes - Liha: 997 - FormClose -  Deu Free no FController às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    FController.Free;

    //  CurrentDateTime := Now;
    //  DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    //  LogManager.AddLog('Tela Cadastro de Clientes - Liha: 919 - FormClose -  Deu Free no DataSet às ' + DateTimeStr);
    //  LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    //  DataSet.Free;
  finally
    LogManager.Free;
  end;

end;

procedure TFrmCadastroClientes.FormCreate(Sender: TObject);
var
  LogManager: TLogManager;
begin
  LogManager := TLogManager.Create;
  try
     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager.AddLog('Tela - Cadastro de Clientes - Linha: 1018 - FormCreate - Criou o LogManager às ' + DateTimeStr);
     LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

     CarregarConfiguracao;
     PopularDataSet;
     CarregarCores;
     CarregarLinguagem;

//     CurrentDateTime := Now;
//     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
//     LogManager.AddLog('Tela - Cadastro de Clientes: Linha 1028: FormCreate Criou o FController às ' + DateTimeStr);
//     LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
//     FController:= TControllerCliente.create;
  finally
     //LogManager.Free; //Deu Freen Antes
  end;

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
  FModel : TModelCliente;
begin
  Result:=False;
  FModel:= TModelCliente.Create;
  try
    FModel.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Cadastro_de_Clientes.txt', 'Log_Cadastro_de_Clientes.txt');
    FModel.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Entity_Contatos.txt' ,'Log_Entity_Contatos.txt');
    FModel.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Model_Clientes.txt', 'Log_Model_Clientes.txt');
    FModel.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Model_Contatos.txt', 'Log_Model_Contatos.txt');
  finally
    FModel.Free;
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
  LogManager:=TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1086 - Entrou no OnDataChange às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

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

    //Preenche os campos do conntato
    EdtCodContato.Text      := IntToStr(DataSet.FieldByName('IDCONTATOS').AsInteger);
    EdtNomeContato.Text     := DataSet.FieldByName('NOMECONTATO').AsString;
    EdtTelefoneContato.Text := DataSet.FieldByName('TELEFONE').AsString;
    EdtCelularContato.Text  := DataSet.FieldByName('CELULAR').AsString;
    EdtEmailContato.Text    := DataSet.FieldByName('EMAIL').AsString;

    PopularClientes;  //Popula a variável FClientes
    PopularContatos; //Popula Variável FContato

  finally
    //LogManager.Free;
  end;

end;

procedure TFrmCadastroClientes.PopularContatos;
var
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1140 - Entrou on PopularConntatos e Criou Fcontato às ' + DateTimeStr);
     LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
     FContato := TContato.Create;
     try
       if FTipo<>'N' then
         FContato.idcontato := StrToInt(EdtCodContato.Text);

       FContato.idcliente   := StrToInt(EdtCodCliente.Text);
       FContato.Nome        := EdtNomeContato.Text;
       FContato.telefone    := EdtTelefoneContato.Text;
       FContato.celular     := EdtCelularContato.Text;
       FContato.email       := EdtEmailContato.Text;
     //    FContato.cnpjrevenda := ; //Provável que não seja necessário
     finally
       //FContato.Free;//Liberar ao fechar o form.
       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Tela - Cadastro de Clientes: Linha :  1157 - Finalizou a PopularConntatos e NÂO deu free no FContato às ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
     end;
  finally
     //LogManager.Free;  ficou Free
  end;

end;

procedure TFrmCadastroClientes.PopularClientes;
var
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1172 - Entrou na PopularClientes e Criou FCliente às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

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
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1193 - Finalizou a PopularClientes e não deu Free na FCliente às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    end;
  finally
    LogManager.Free;
  end;

end;

procedure TFrmCadastroClientes.PopularGridClientes;
var
  I, J: Integer;
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 1210 - Entrou na PopularGridClientes às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

    // Limpar as colunas existentes
    while GridClientes.ColumnCount > 0 do  //Não teria que ter um begin aqui?
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
  finally
    LogManager.Free;
  end;

end;

procedure TFrmCadastroClientes.PreencheDadosEncontradosDoCliente;
var
  SelectedRow: Integer;
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Clientes  - Linha : 1308 - Enntrou na PreecheDadosEncontratosDoCliente às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

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
  finally
    LogManager.Free;
  end;

end;

procedure TFrmCadastroClientes.TabItemPesquisaClick(Sender: TObject);
begin
  PopularDataSet;
  PopularGridClientes;
end;

end.
