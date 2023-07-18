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
  Model.Categorias;

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
    EdtCodCategoria: TEdit;
    lblcodCategoria: TLabel;
    LblCodFabricante: TLabel;
    EdtFabricante: TEdit;
    lblFabricante: TLabel;
    LblAtivo: TLabel;
    CBAtivo: TComboBox;
    ShadowEffect9: TShadowEffect;
    ShadowEffect10: TShadowEffect;
    ShadowEffect11: TShadowEffect;
    ShadowEffect13: TShadowEffect;
    ShadowEffect14: TShadowEffect;
    ShadowEffect15: TShadowEffect;
    EdtCategoria: TEdit;
    ShadowEffect16: TShadowEffect;
    LblCategoria: TLabel;
    ShadowEffect17: TShadowEffect;
    BtnGravar: TButton;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    CBCodFabricante: TComboBox;
    ShadowEffect12: TShadowEffect;
    procedure FormCreate(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
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
    procedure CarregarCores;
    procedure CarregarLinguagem;
    Procedure DesabilitaBotoes(const BotaoSet:TBotaoSet);
    Procedure CarregarIdFabricantes;
    procedure popularcategoria;
    procedure popularDataset;
  public
    { Public declarations }
    DataSet: TClientDataSet;
    FSomenteAtivos: string;
    FSemContatos  : string;
    FBtnUltimo    : string;
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

procedure TFrmCategorias.BtnExcluirClick(Sender: TObject);
begin
  FTipo:='E';
  DesabilitaBotoes([BiGravar]);
  //Chamar o Model de Excluir
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
      LogManager.AddLog('Tela - Cadastro de Categorias: Linha : 161 - BtnnGravar - Criou a RegrasdeNegocios às ' +  DateTimeStr);
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
    if Abortar then  //cliente Existe
    begin
      ShowMessage('Cliente já existe no Cadastro!');  //Comeentar depois

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
        FGravacaoSucesso := RegrasDeNegocios.SalvarCliente(FCliente);
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

  if EdtFabricante.CanFocus then
     EdtFabricante.SetFocus;

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

  CarregarCores;
  CarregarLinguagem;
  CarregarIdFabricantes;

  FConexao    := TConnection.CreateConnection;
  FCategoria  := TCategorias.create;


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
       FCategoria.idcategorias := StrTOInt(EdtCodCategoria.Text);

     FCategoria.categoria    := EdtCategoria.Text;
     FCategoria.idfabricante := StrToInt(CBCodFabricante.Items[CBCodFabricante.ItemIndex]);
     FCategoria.fabricante   := EdtFabricante.Text;
     FCategoria.Ativo        := CBAtivo.Items[CBAtivo.ItemIndex];

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
    if FBtnUltimo='S' then
      qry := Model.CarregarTodasCatagorias(DataSet, FSomenteAtivos, FSemContatos, 'S')
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

end.
