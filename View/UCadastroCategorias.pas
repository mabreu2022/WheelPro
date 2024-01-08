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
  IniFiles,
  LogManager,
  FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Comp.UI,
  Data.DB,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.PG,
  Datasnap.DBClient,
  Dao.Conexao,
  Entity.Categorias,
  Model.Categorias,
  FMX.TabControl,
  System.Rtti,
  FMX.Grid.Style,
  FMX.ScrollBox,
  FMX.Grid,
  Controller.Categorias;

type

  TBotaoIndex = (biAlterar, biExcluir, biPrimeiro, biAnterior, biProximo, biUltimo, biNovo, BiGravar);
  TBotaoSet = set of TBotaoIndex;

  TFrmCategorias = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    LblTitulo: TLabel;
    ShadowEffect1: TShadowEffect;
    Rectangle2: TRectangle;
    BtnPrimeiro: TButton;
    BtnAnterior: TButton;
    BtnProximo: TButton;
    BtnUltimo: TButton;
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
    BtnGravar: TButton;
    ShadowEffect18: TShadowEffect;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    CBAtivo: TComboBox;
    ShadowEffect10: TShadowEffect;
    LblAtivo: TLabel;
    ShadowEffect9: TShadowEffect;
    CBCodFabricante: TComboBox;
    ShadowEffect12: TShadowEffect;
    EdtFabricante: TEdit;
    ShadowEffect11: TShadowEffect;
    lblFabricante: TLabel;
    ShadowEffect19: TShadowEffect;
    LblCodFabricante: TLabel;
    ShadowEffect13: TShadowEffect;
    EdtCodCategoria: TEdit;
    ShadowEffect14: TShadowEffect;
    lblcodCategoria: TLabel;
    ShadowEffect15: TShadowEffect;
    EdtCategoria: TEdit;
    ShadowEffect16: TShadowEffect;
    LblCategoria: TLabel;
    ShadowEffect17: TShadowEffect;
    GridClientes: TStringGrid;
    Panel1: TPanel;
    LblPesquisar: TLabel;
    ShadowEffect34: TShadowEffect;
    EditPesquisa: TEdit;
    ShadowEffect33: TShadowEffect;
    BtnPesquisar: TButton;
    ShadowEffect35: TShadowEffect;
    procedure FormCreate(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure CBCodFabricanteChange(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure CBCodFabricanteExit(Sender: TObject);
  private
    { Private declarations }
    FConexao: TFDConnection;
    RegrasDeNegocios: TModelCategorias;
    FLinguagem: string;
    FTipo: String;
    FCategoria: TCategorias;
    CurrentDateTime: TDateTime; //Para uso com o Log
    DateTimeStr: string;        //Para uso com o Log
    FGravarLog: Boolean;        //Para uso com o Log
    FGravacaoSucesso: Boolean;
    PodeGravar: Boolean;
    CDS: TClientDataSet;
    RazaoFabricante: String;
    qry: TFDQuery;
    FHabilitarLogsSistema: string;
    FController: TControllerCategoria;
    procedure CarregarCores;
    procedure CarregarLinguagem;
    Procedure DesabilitaBotoes(const BotaoSet:TBotaoSet);
    Procedure CarregarIdFabricantes;
    procedure popularcategoria;
    procedure popularDataset;
    function LerSalvarLogsBancoDeDados: Boolean;
    procedure PreencheDadosEncontradosDaCategoria;
    function GravarLogsBancoDeDados: Boolean;
    procedure CarregarConfiguracao;
    procedure SelecionarFabricantePorID(idfabricanteValor: Integer);
  public
    { Public declarations }
    DataSet: TClientDataSet;
    FSomenteAtivos: string;
    FSemContatos  : string;
    FBtnUltimo    : string;
    codFabricante : string;
    procedure OnDataSetChange;
    Function CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
  end;

var
  FrmCategorias: TFrmCategorias;

implementation

{$R *.fmx}

{ TFrmCategorias }

procedure TFrmCategorias.BtnAlterarClick(Sender: TObject);
begin
  FTipo:='A';
  DesabilitaBotoes([BiGravar]);
  if EdtCategoria.CanFocus then
    EdtCategoria.SetFocus;

end;

procedure TFrmCategorias.BtnAnteriorClick(Sender: TObject);
begin
  PopularDataSet;
  DataSet.prior;
  OnDataSetChange;
end;

procedure TFrmCategorias.BtnExcluirClick(Sender: TObject);
begin
  FTipo:='E';
  DesabilitaBotoes([BiGravar]);
end;

procedure TFrmCategorias.BtnGravarClick(Sender: TObject);
var
  Abortar: Boolean;
  Confirmacao: Integer;
  LogManager: TLogManager;
begin
  DesabilitaBotoes([BiPrimeiro,BiAnterior,BiProximo,BiUltimo,BiNovo,BiAlterar,BiExcluir]);
  PopularCategoria;

   if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Categorias: Linha : 197 - BtnGravar - Criou a RegrasdeNegocios às ' +  DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Categorias.txt');
    finally
      LogManager.Free;
    end;
  end;

  RegrasDeNegocios:= TModelCategorias.Create;

  //Testar se os campos foram todos preenchidos
  PodeGravar := RegrasDeNegocios.TestaSeCamposPreenchidos(FCategoria);

  if PodeGravar then //testar preenchimento dos campos
  begin  //Rever regras
    Abortar:= RegrasDeNegocios.CategoriaExiste(FCategoria.idcategorias);
    if Abortar then  //Categoria Existe
    begin
      ShowMessage('Categoria já existe no Cadastro!');

      if FTipo='A' then //Alterar
      begin
        FGravacaoSucesso := False;
        FGravacaoSucesso := RegrasDeNegocios.AlterarCategoria(FCategoria);
        PopularDataSet;
        OnDataSetChange;
        if FGravacaoSucesso then
          ShowMessage('Alteracao feita com sucesso!');
        Exit;
      end;

      if FTipo='N' then //Novo Registro
      begin
        FGravacaoSucesso := False;
        FGravacaoSucesso := RegrasDeNegocios.SalvarCategoria(FCategoria);
        PopularDataSet;
        OnDataSetChange;
        if FGravacaoSucesso then
          ShowMessage('Dados  gravados com sucesso!');
        Exit;
      end;

      if FTipo='E' then //Excluir
      begin
        FGravacaoSucesso := False;
        FGravacaoSucesso := RegrasDeNegocios.RemoverCategoria(FCategoria);

        PopularDataSet;
        OnDataSetChange;
        if FGravacaoSucesso then
          ShowMessage('Dados excluidos com sucesso!');
        Exit;
      end;

    end
    else //Cadastra o Categoria nova
    begin
      RegrasDeNegocios.SalvarCategoria(FCategoria);

      PopularDataSet;
      OnDataSetChange;
      Exit;
    end;

  end
  else //Não atendeu as regras de negócios e não grava
  begin
    ShowMessage('Não foi possível salvar os dados da categoria');

    Tabcontrol1.TabIndex:=0;

    if EdtCategoria.CanFocus then
      EdtCategoria.SetFocus;
  end;

end;

procedure TFrmCategorias.BtnNovoClick(Sender: TObject);
var
  qry                   : TFDQuery;
  NextID, NextIDContato : Integer;
  LogManager            : TLogManager;
begin
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
    qry.SQL.Text := 'SELECT MAX(idcategorias) + 1 AS NextID FROM categorias';
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

  //Limpas Campos do Formulário
  EdtCodCategoria.Text := IntToStr(NextID);
  EdtCategoria.Text    := '';
  EdtFabricante.Text   := '';

  if EdtCategoria.CanFocus then
     EdtCategoria.SetFocus;

end;

procedure TFrmCategorias.BtnPesquisarClick(Sender: TObject);
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
        PreencheDadosEncontradosDaCategoria;

        // Você pode retornar aqui se desejar encontrar apenas a primeira correspondência
         Exit;
      end;

    end;
  end;

end;

procedure TFrmCategorias.BtnPrimeiroClick(Sender: TObject);
begin
  PopularDataSet;
  DataSet.First;
  OnDataSetChange;
end;

procedure TFrmCategorias.BtnProximoClick(Sender: TObject);
begin
  PopularDataSet;
  DataSet.Next;
  OnDataSetChange;
end;

procedure TFrmCategorias.BtnUltimoClick(Sender: TObject);
begin
  FBtnUltimo:='S';
  PopularDataSet;
  DataSet.Last;
  OnDataSetChange;
end;

procedure TFrmCategorias.CarregarConfiguracao;
var
   IniFile    : TIniFile;
   LogManager : TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Categorias: Linha : 373 - Carregar Configuração - Criou o IniFile às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Categorias.txt');

    LogManager.CarregarConfiguracao;
    FSomenteAtivos        := LogManager.FSomenteAtivos;        //Carregar categorias Ativos='S'
    FHabilitarLogsSistema := LogManager.FHabilitarLogsSistema; //Salvar Logs do Sistema

  finally
    LogManager.Free;
  end;

end;

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

procedure TFrmCategorias.CarregarIdFabricantes;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := TConnection.CreateConnection;
  try
     qry.SQL.Clear;
     qry.SQL.Add('SELECT IDFABRICANTES FROM FABRICANTES');
     qry.Open;

     CBCodFabricante.Clear;
     while not qry.Eof do
     begin
       CBCodFabricante.Items.Add(qry.FieldByName('idfabricantes').AsString);
       qry.Next;
     end;
  finally
    qry.Free;
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
       BtnGravar.Text        := '&Gravar';
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
       BtnGravar.Text        := '&Save';
       LblTitulo.Text        := 'Category Registration';
       FrmCategorias.Caption := 'Category Registration';
     end;

  finally
    IniFile.Free;
  end;

end;

procedure TFrmCategorias.CBCodFabricanteChange(Sender: TObject);
var
  Model : TModelCategorias;
begin
  Model := TModelCategorias.Create;
  try
    EdtFabricante.Text := Model.PesquisaNomeFabricante(StrToInt(codFabricante));
  finally
    Model.Free;
  end;
end;

procedure TFrmCategorias.CBCodFabricanteExit(Sender: TObject);
var
  Model : TModelCategorias;
begin
  Model := TModelCategorias.Create;
  try
    EdtFabricante.Text := Model.PesquisaNomeFabricante(StrToInt(codFabricante));
  finally
    Model.Free;
  end;

end;

function TFrmCategorias.CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
var
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:=TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de cATEGORIAS: Linha : 405 - Criar DataSet - Criou o CDS às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Categorias.txt');
    finally
      LogManager.Free;
    end;
  end;

  CDS := TClientDataSet.Create(nil);
  try
    CDS.FieldDefs.Add('IDCATEGORIAS', ftInteger);
    CDS.FieldDefs.Add('CATEGORIA', ftString, 100);
    CDS.FieldDefs.Add('ATIVO', ftString,1);
    CDS.FieldDefs.Add('DATACADASTRO', ftDateTime);
    CDS.FieldDefs.Add('dataalteracao', ftDateTime);
    CDS.FieldDefs.Add('DATAEXCLUSAO', ftDateTime);
    CDS.FieldDefs.Add('IDFABRICANTE', ftInteger);

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
      LogManager.AddLog('Tela - Cadastro de Categoias: Linha : 501 - Gravou os arquivos de Logs no Banco de Dados às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Categorias.txt');
      finally
        LogManager.Free;
      end;
      if (FGravarLog) and (FHabilitarLogsSistema='S') then
      GravarLogsBancoDeDados;
    end;
  end;


end;

procedure TFrmCategorias.DesabilitaBotoes(const BotaoSet: TBotaoSet);
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

procedure TFrmCategorias.FormCreate(Sender: TObject);
begin
  FConexao    := TConnection.CreateConnection;
  FCategoria  := TCategorias.create;
  CarregarCores;
  CarregarLinguagem;
  CarregarIdFabricantes;
  FController:= TControllerCategoria.Create;
  CarregarConfiguracao;
  PopularDataSet;
end;

function TFrmCategorias.GravarLogsBancoDeDados: Boolean;
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

function TFrmCategorias.LerSalvarLogsBancoDeDados: Boolean;
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

procedure TFrmCategorias.OnDataSetChange;
var
  ativoCliente  : string;

begin

  EdtCodCategoria.Text  := IntToStr(DataSet.FieldByName('idcategorias').AsInteger);
  EdtCategoria.Text     := DataSet.FieldByName('categoria').AsString;

  // Obter o valor dos campos Ativo do DataSet
  ativoCliente := DataSet.FieldByName('Ativo').AsString;

  // Definir o valor do campo Ativo no combobox CBATivo
  if ativoCliente = 'S' then
    CBATivo.ItemIndex := CBATivo.Items.IndexOf('S')
  else if ativoCliente = 'N' then
    CBATivo.ItemIndex := CBATivo.Items.IndexOf('N')
  else
    CBATivo.ItemIndex := -1; // ou algum valor padrão, caso Ativo não seja válido

  //ver uma function que devolva o fabricante gravado no banco para setar o fabricante no combobox
  //SelecionarFabricantePorID(DataSet.FieldByName('IDFABRICANTE').AsInteger);
  if not DataSet.FieldByName('IDFABRICANTE').IsNull then
  begin
    codFabricante := IntToStr(DataSet.FieldByName('IDFABRICANTE').AsInteger);
    if CBCodFabricante.Items.IndexOf(codFabricante) > -1 then
      CBCodFabricante.ItemIndex := CBCodFabricante.Items.IndexOf(codFabricante)
    else
      CBCodFabricante.ItemIndex := -1; // ou algum valor padrão, caso IDFABRICANTE não seja válido
  end
  else
    CBCodFabricante.ItemIndex := -1; // ou algum valor padrão, caso IDFABRICANTE seja nulo

  PopularCategoria;  //Popula a variável FCategoria

end;

procedure TFrmCategorias.popularcategoria;
var
  LogManager: TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Tela - Cadastro de Categorias: Linha : 344 - Entrou na PopularCategoria e Criou FCategoria às ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
       LogManager.Free;
    end;
  end;

  try
     if FTIpo<>'N' then
     begin
       FCategoria := TCategorias.create;
       FCategoria.idcategorias := StrTOInt(EdtCodCategoria.Text);
       FCategoria.categoria    := EdtCategoria.Text;
       FCategoria.idfabricante := StrToInt(CBCodFabricante.Items[CBCodFabricante.ItemIndex]);
       FCategoria.fabricante   := EdtFabricante.Text;
       FCategoria.Ativo        := CBAtivo.Items[CBAtivo.ItemIndex];
     end;

  finally
    if FGravarLog then
    begin
      LogManager:= TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Categoria: Linha : 367 - Finalizou a PopularCategoria e não deu Free na FCategoria às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      finally
        LogManager.Free;
      end;
    end;
    //FCategoria.Free;
  end;

end;

procedure TFrmCategorias.popularDataset;
var
  Model: TModelCategorias;
  LogManager: TLogManager;
begin
  Model         := TModelCategorias.create;
  DataSet       := TClientDataset.Create(nil);
  try
    //if FBtnUltimo='S' then
      qry := Model.CarregarTodasCategorias(DataSet, FSomenteAtivos, FSemContatos, 0);

    DataSet := CriarDataSet(DataSet);
    DataSet.Open;
    qry.First;
    while not qry.eof do
    begin
      DataSet.Append;
      DataSet.FieldByName('idcategorias').AsInteger   := Qry.FieldByName('idcategorias').AsInteger;
      DataSet.FieldByName('categoria').AsString       := Qry.FieldByName('categoria').AsString;
      DataSet.FieldByName('idfabricante').AsInteger   := Qry.FieldByName('idfabricante').AsInteger;
      DataSet.FieldByName('datacadastro').AsDateTime  := Qry.FieldByName('datacadastro').AsDateTime;
      DataSet.FieldByName('dataalteracao').AsDateTime := Qry.FieldByName('dataalteracao').AsDateTime;
      DataSet.FieldByName('dataexclusao').AsdateTime  := Qry.FieldByName('dataexclusao').AsDateTime;
      DataSet.FieldByName('ATIVO').AsString           := Qry.FieldByName('ATIVO').AsString;

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
        LogManager.AddLog('Tela - Cadastro de Categorias: Linha : 623 - Finalizou a PopularDataSet - Free Model  às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Categorias.txt');

        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 936 - Finalizou a PopularDataSet - E não deu free no DadaSet às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
      finally
        LogManager.Free;
      end;

    end;
    Model.Free;

  end;


end;


procedure TFrmCategorias.PreencheDadosEncontradosDaCategoria;
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
      LogManager.AddLog('Tela - Cadastro de Categorias  - Linha : 703 - Entrou na PreecheDadosEncontratosDaCategoria às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Categorias.txt');
    finally
      LogManager.Free;
    end;
  end;

  if GridClientes.Selected >= 0 then
  begin

    SelectedRow := GridClientes.Selected;
    EdtCodCategoria.Text := GridClientes.Cells[0, SelectedRow];
    EdtCategoria.Text    := GridClientes.Cells[1, SelectedRow];
    CBCodFabricante.Index:= CBCodFabricante.Items.IndexOf(GridClientes.Cells[2, SelectedRow]);
    EdtFabricante.Text   := GridClientes.Cells[3, SelectedRow];
    CBAtivo.ItemIndex    := CBAtivo.Items.IndexOf(GridClientes.Cells[10, SelectedRow]);

  end;

end;

procedure TFrmCategorias.SelecionarFabricantePorID(idfabricanteValor: Integer);
var
  index: Integer;
begin
  index := CBCodFabricante.Items.IndexOf(IntToStr(idfabricanteValor));
  CBCodFabricante.ItemIndex := index;

end;

end.
