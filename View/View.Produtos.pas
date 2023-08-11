unit View.Produtos;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Objects,
  FMX.Effects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.ListBox,
  System.Rtti,
  FMX.Grid.Style,
  FMX.ScrollBox,
  FMX.Grid,
  FMX.Edit,
  FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Comp.UI,
  Dao.Conexao,
  Entity.Produtos,
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
  LogManager,
  Model.Produtos,
  System.UIConsts,
  Datasnap.DBClient,
  Controller.Produtos,
  Vcl.Imaging.pngimage;

type
   TBotaoIndex = (biAlterar, biExcluir, biPrimeiro, biAnterior, biProximo, biUltimo, biNovo, BiGravar);
   TBotaoSet = set of TBotaoIndex;

  TFrmCadastrodeProdutos = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    BtnGravar: TButton;
    ShadowEffect27: TShadowEffect;
    BtnExcluir: TButton;
    ShadowEffect8: TShadowEffect;
    BtnAlterar: TButton;
    ShadowEffect7: TShadowEffect;
    BtnNovo: TButton;
    ShadowEffect6: TShadowEffect;
    BtnUltimo: TButton;
    ShadowEffect5: TShadowEffect;
    BtnProximo: TButton;
    ShadowEffect4: TShadowEffect;
    BtnAnterior: TButton;
    ShadowEffect3: TShadowEffect;
    BtnPrimeiro: TButton;
    ShadowEffect2: TShadowEffect;
    lblTitulo: TLabel;
    ShadowEffect1: TShadowEffect;
    TabControl1: TTabControl;
    TabItemCadastro: TTabItem;
    ShadowEffect9: TShadowEffect;
    LblAtivo: TLabel;
    ShadowEffect21: TShadowEffect;
    CBAtivo: TComboBox;
    ShadowEffect22: TShadowEffect;
    TabItemPesquisa: TTabItem;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    LblPesquisar: TLabel;
    ShadowEffect34: TShadowEffect;
    EditPesquisa: TEdit;
    ShadowEffect33: TShadowEffect;
    BtnPesquisar: TButton;
    ShadowEffect35: TShadowEffect;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    EdtIdProduto: TEdit;
    Edtproduto: TEdit;
    EdtPreco: TEdit;
    CBoxAro: TComboBox;
    CBoxIdFabricante: TComboBox;
    CBoxLancamento: TComboBox;
    CBoxFuracao: TComboBox;
    CBoxOffSet: TComboBox;
    CBoxIdLinha: TComboBox;
    LblIdProduto: TLabel;
    LblProduto: TLabel;
    lblPreco: TLabel;
    ImageFoto: TImage;
    Button5: TButton;
    ShadowEffect10: TShadowEffect;
    ShadowEffect11: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    ShadowEffect13: TShadowEffect;
    ShadowEffect14: TShadowEffect;
    ShadowEffect15: TShadowEffect;
    ShadowEffect16: TShadowEffect;
    ShadowEffect17: TShadowEffect;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
    ShadowEffect23: TShadowEffect;
    ShadowEffect24: TShadowEffect;
    ShadowEffect25: TShadowEffect;
    ShadowEffect26: TShadowEffect;
    ShadowEffect28: TShadowEffect;
    lblAro: TLabel;
    lblIdFabricante: TLabel;
    lblLancamento: TLabel;
    lblFuracao: TLabel;
    lblOffSet: TLabel;
    lblIdLinha: TLabel;
    ShadowEffect29: TShadowEffect;
    ShadowEffect30: TShadowEffect;
    ShadowEffect31: TShadowEffect;
    ShadowEffect32: TShadowEffect;
    ShadowEffect36: TShadowEffect;
    ShadowEffect37: TShadowEffect;
    EdtFabricante: TEdit;
    EdtLinha: TEdit;
    ShadowEffect20: TShadowEffect;
    ShadowEffect38: TShadowEffect;
    CBoxIdAcabamento: TComboBox;
    ShadowEffect39: TShadowEffect;
    lbldAcabamento: TLabel;
    ShadowEffect40: TShadowEffect;
    EdtAcabamento: TEdit;
    ShadowEffect41: TShadowEffect;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    FConexao: TFDConnection;
    FProduto: TProduto;
    CurrentDateTime: TDateTime; //Para uso com o Log
    DateTimeStr: string;        //Para uso com o Log
    FGravarLog: Boolean;        //Para uso com o Log
    FHabilitarLogsSistema: string;
    FLinguagem: string;
    FController : TControllerProduto;
    FTipo: String;
    RegrasDeNegocios: TModelProduto;
    PodeGravar: Boolean;
    FGravacaoSucesso: Boolean;
    qry: TFDQuery;
    CDS: TClientDataSet;
    procedure CarregarConfiguracao;
    procedure PopularDataSet;
    procedure DesabilitaBotoes(const BotaoSet:TBotaoSet);
    function LerSalvarLogsBancoDeDados: Boolean;
    function GravarLogsBancoDeDados: Boolean;
    Procedure CarregarImagemParaStream (const ABitmap: TBitmap; AStream: TStream);
  public
    { Public declarations }
     FSomenteAtivos : string;
     DataSet        : TClientDataSet;
     FBtnUltimo     : string;
     FSemContatos  : string;
     procedure CarregarCores;
     procedure CarregarLinguagem;
     procedure OnDataSetChange;
     procedure PopularProdutos;
     Function CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
  end;

var
  FrmCadastrodeProdutos: TFrmCadastrodeProdutos;

implementation

{$R *.fmx}

procedure TFrmCadastrodeProdutos.BtnAlterarClick(Sender: TObject);
begin
  FTipo:='A';

  TabItemPesquisa.Enabled:=False;

  DesabilitaBotoes([BiGravar]);

  //Ver que aba está selecionada para pode setar o foco no campo correto
  if TabControl1.TabIndex = 0 then
  begin
    if EdtProduto.CanFocus then
      EdtPRoduto.SetFocus;
  end
  else
  if TabControl1.TabIndex = 2 then
  begin
    if EditPesquisa.CanFocus then
      EditPesquisa.SetFocus;
  end;

end;

procedure TFrmCadastrodeProdutos.BtnExcluirClick(Sender: TObject);
begin
  TabItemPesquisa.Enabled:=False;
  FTipo:='E';
  DesabilitaBotoes([BiGravar]);
end;

procedure TFrmCadastrodeProdutos.BtnNovoClick(Sender: TObject);
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
      LogManager.AddLog('Tela - Cadastro de Produtos: Linha 197 - BtnNovoClick - Criou a qry às '  + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
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
    qry.SQL.Text := 'SELECT MAX(idprodutos) + 1 AS NextID FROM produtos';
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
        LogManager.AddLog('Tela - Cadastro de Produtos: Linha 231: BtnNovoClick - Free qry às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
      finally
        LogManager.Free;
      end;
    end;
    qry.Free;
  end;

  // Limpar todos os campos de clientes
  EdtIdProduto.Text          := IntToStr(NextID);
  EdtProduto.Text            := '';
  EdtPreco.Text              := '';
  CBoxAro.ItemIndex          := 0;
  CBoxLancamento.ItemIndex   := 0;
  CBoxFuracao.ItemIndex      := 0;
  CBoxIdFabricante.ItemIndex := 0;
  EdtFabricante.Text         := '';
  CBoxIdLinha.ItemIndex      := 0;
  EdtLinha.Text              := '';
  CBoxIdAcabamento.ItemIndex := 0;
  EdtAcabamento.Text         := '';
  CBoxOffSet.ItemIndex       := 0;
  ImageFoto.MultiResBitmap.Bitmaps[0]:= nil;
  CBAtivo.ItemIndex          := 1;

  // Foco no campo Produto
  if Edtproduto.CanFocus then
    Edtproduto.SetFocus;

  if FGravarLog then
  begin
    LogManager := TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Produtos: Linha 267: BtnNovoClick - Free qry às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
    finally
      LogManager.free;
    end;
  end;

end;

procedure TFrmCadastrodeProdutos.BtnGravarClick(Sender: TObject);
var
  Abortar: Boolean;
  Confirmacao: Integer;
  LogManager: TLogManager;
begin
  DesabilitaBotoes([BiPrimeiro,BiAnterior,BiProximo,BiUltimo,BiNovo,BiAlterar,BiExcluir]);

  TabItemPesquisa.Enabled:=True;

  PopularProdutos;

  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Produtos: Linha : 327 - BtnnGravar - Criou a RegrasdeNegocios às ' +  DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
    finally
      LogManager.Free;
    end;
  end;

  RegrasDeNegocios:= TModelProduto.Create;

  //Testar se os campos foram todos preenchidos
  PodeGravar      := RegrasDeNegocios.TestaSeCamposPreenchidos(FProduto);

  if PodeGravar then //testar preenchimento dos campos
  begin  //Rever regras
    Abortar:= RegrasDeNegocios.ProdutoExiste(FProduto.idprodutos);
    if Abortar then  //cliente Existe
    begin
      ShowMessage('Cliente já existe no Cadastro!');

      if FTipo='A' then //Alterar
      begin
        FGravacaoSucesso := False;
        FGravacaoSucesso := RegrasDeNegocios.AlterarProduto(FProduto);
        PopularDataSet;
        OnDataSetChange;
        if FGravacaoSucesso then
          ShowMessage('Alteracao feita com sucesso!');
        Exit;
      end;

      if FTipo='N' then //Novo Registro
      begin
        FGravacaoSucesso := False;
        FGravacaoSucesso := RegrasDeNegocios.SalvarProduto(FProduto);
        PopularDataSet;
        OnDataSetChange;
        if FGravacaoSucesso then
          ShowMessage('Dados  gravados com sucesso!');
        Exit;
      end;

      if FTipo='E' then //Excluir
      begin
        FGravacaoSucesso := False;
        FGravacaoSucesso := RegrasDeNegocios.RemoverProduto(FProduto);
        PopularDataSet;
        OnDataSetChange;
        if FGravacaoSucesso then
          ShowMessage('Dados excluidos com sucesso!');
        Exit;
      end;

    end
    else //Cadastra o Produto novo
    begin
      RegrasDeNegocios.SalvarProduto(FProduto);
      PopularDataSet;
      OnDataSetChange;
      Exit;
    end;

  end
  else //Não atendeu as regras de negócios e não grava
  begin
    ShowMessage('Não foi possível salvar os dados do produto');

    if EdtProduto.CanFocus then
      EdtProduto.SetFocus;
  end;

  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Produtos: Linha : 406 - BtnnGravar - deu Free na FProduto às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
      FProduto.Free;

      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Produtos: Linha : 412 BtnnGravar - deu Free na RegrasDeNegocios às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
      RegrasDeNegocios.Free;

    finally
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Produtos: Linha : 419 - BtnnGravar - deu Free na LogManager às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
      LogManager.Free;
    end;
  end;


end;

procedure TFrmCadastrodeProdutos.BtnPrimeiroClick(Sender: TObject);
begin
  PopularDataSet;
  DataSet.First;
  OnDataSetChange;
end;

procedure TFrmCadastrodeProdutos.BtnAnteriorClick(Sender: TObject);
begin
  PopularDataSet;
  DataSet.prior;
  OnDataSetChange;
end;

procedure TFrmCadastrodeProdutos.BtnProximoClick(Sender: TObject);
begin
  PopularDataSet;
  DataSet.Next;
  OnDataSetChange;
end;

procedure TFrmCadastrodeProdutos.BtnUltimoClick(Sender: TObject);
begin
  FBtnUltimo:='S';
  PopularDataSet;  //Ver uma forma de aba Contatos Limpar Campos e pegar o proximo IDContato se não tiver registro de contatos daquele cliente.
  DataSet.Last;
  OnDataSetChange;
end;

procedure TFrmCadastrodeProdutos.Button5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    // Carregar a imagem do arquivo selecionado no TImage
    ImageFoto.Bitmap.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TFrmCadastrodeProdutos.CarregarConfiguracao;
var
   IniFile    : TIniFile;
   LogManager : TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Produtos: Linha : 159 - Carregar Configuração - Criou o IniFile às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');

    LogManager.CarregarConfiguracao;
    FSomenteAtivos        := LogManager.FSomenteAtivos;        //Carregar clientes Ativos='S'

    FHabilitarLogsSistema := LogManager.FHabilitarLogsSistema; //Salvar Logs do Sistema
  finally
    LogManager.Free;
  end;


end;

procedure TFrmCadastrodeProdutos.CarregarCores;
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
  for var I := 0 to FrmCadastrodeProdutos.ComponentCount - 1 do
  begin
    if FrmCadastrodeProdutos.Components[I] is TRectangle then
      TRectangle(FrmCadastrodeProdutos.Components[I]).Fill.Color := Cor;
  end;

end;

procedure TFrmCadastrodeProdutos.CarregarImagemParaStream(
  const ABitmap: TBitmap; AStream: TStream);
var
  PNGImage: TPngImage;
  BitMapImagem: TBitMap;
begin
  BitMapImagem := TBitMap.Create;
  try
    BitMapImagem.Assign(ABitmap);
    BitMapImagem.SaveToStream(AStream);
  finally
    BitMapImagem.Free;
  end;
end;

procedure TFrmCadastrodeProdutos.CarregarLinguagem;
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
     TabItemCadastro.Text  := 'Cadastro';
     LblIdProduto.Text     := 'Id.Produto';
     LblProduto.Text       := 'Produto';
     lblPreco.Text         := 'Preço';
     LblAro.Text           := 'Aro';
     lblLancamento.Text    := 'Lançamento';
     lblFuracao.Text       := 'Furação';
     lblIdFabricante.Text  := 'Id Fabricante';
     lblIdLinha.Text       := 'Id Linha';
     lbldAcabamento.Text   := 'Id Acabamento';
     lblOffSet.Text        := 'Desvio(OffSet)';
     LblAtivo.Text         := 'Ativo';

     FrmCadastrodeProdutos.Caption := 'Cadastro de Produtos';
     lblTitulo.Text                := 'Cadastro de Produtos';
   end
   else if FLinguagem = 'Ingles' then
   begin
     TabItemCadastro.Text           := 'Register';
     LblIdProduto.Text     := 'Product Id';
     LblProduto.Text       := 'Product';
     lblPreco.Text         := 'Price';
     LblAro.Text           := 'hoop';
     lblLancamento.Text    := 'Launch';
     lblFuracao.Text       := 'Wheel Drilling';
     lblIdFabricante.Text  := 'Manufacturer Id';
     lblIdLinha.Text       := 'Line ID';
     lbldAcabamento.Text   := 'Finishing ID';
     lblOffSet.Text        := 'OffSet';
     LblAtivo.Text         := 'Active';

     FrmCadastrodeProdutos.Caption  := 'Product Registration';
     lblTitulo.Text                 := 'Product Registration';
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

function TFrmCadastrodeProdutos.CriarDataSet(
  aDadaSet: TClientDataSet): TClientDataSet;
var
  LogManager   : TLogManager;
  ImageStream  : TMemoryStream;
  EncodedImage : string;
begin
  if FGravarLog then
  begin
    LogManager:=TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de PRodutos: Linha : 791 - Criar DataSet - Criou o CDS às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
    finally
      LogManager.Free;
    end;
  end;

  CDS := TClientDataSet.Create(nil);
  try
    CDS.FieldDefs.Add('IDPRODUTOS', ftInteger);
    CDS.FieldDefs.Add('PRODUTO', ftString, 100);
    CDS.FieldDefs.Add('FOTO', ftBlob);
    CDS.FieldDefs.Add('PRECO', ftCurrency);
    CDS.FieldDefs.Add('ARO', ftInteger);
    CDS.FieldDefs.Add('IDFABRICANTE', ftInteger);
    CDS.FieldDefs.Add('DATAINCLUSAO', ftDateTime);
    CDS.FieldDefs.Add('DATAALTERACAO', ftDateTime);
    CDS.FieldDefs.Add('DATAEXCLUSAO', ftDateTime);
    CDS.FieldDefs.Add('ATIVO', ftString,1);
    CDS.FieldDefs.Add('LANCAMENTO',ftString, 1);
    CDS.FieldDefs.Add('FURACAO', ftInteger);
    CDS.FieldDefs.Add('OFFSET_ET', ftInteger);
    CDS.FieldDefs.Add('IDLINHA', ftInteger);
    CDS.FieldDefs.Add('IDACABAMENTO', ftInteger);

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
      LogManager.AddLog('Tela - Cadastro de Produtos: Linha : 648 - Gravou os arquivos de Logs nno Banco de Dados às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
      finally
        LogManager.Free;
      end;
      if (FGravarLog) and (FHabilitarLogsSistema='S') then
      GravarLogsBancoDeDados;
    end;
  end;

end;

procedure TFrmCadastrodeProdutos.DesabilitaBotoes(const BotaoSet: TBotaoSet);
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

procedure TFrmCadastrodeProdutos.FormCreate(Sender: TObject);
begin
  FConexao    := TConnection.CreateConnection;
  FProduto    := TProduto.create;
  FController := TControllerProduto.Create;

  CarregarConfiguracao;
  PopularDataSet;
  CarregarCores;
  CarregarLinguagem;
end;

function TFrmCadastrodeProdutos.GravarLogsBancoDeDados: Boolean;
var
  FLogManager: TLogManager;
begin
  Result:=False;
  FLogManager:= TLogManager.Create;
  try
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Cadastro_de_Clientes.txt', 'Log_Cadastro_de_Clientes.txt' ,'Logs');
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Cadastro_de_Produtos.txt', 'Log_Cadastro_de_Produtos.txt' ,'Logs');
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Entity_Contatos.txt' ,'Log_Entity_Contatos.txt','Logs');
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Model_Clientes.txt', 'Log_Model_Clientes.txt','Logs');
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Model_Contatos.txt', 'Log_Model_Contatos.txt','Logs');
    FLogManager.GravarLogNoBancoDeDados(ExtractFilePath(ParamStr(0)) + '\Log_Tela_de_Login.txt', 'Log_Tela_de_Login.txt','Logs');

  finally
    FLogManager.Free;
    Result:= True;
  end;

end;

function TFrmCadastrodeProdutos.LerSalvarLogsBancoDeDados: Boolean;
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

procedure TFrmCadastrodeProdutos.OnDataSetChange;
var
  ativoProduto: string;
  Index: Integer;
  LogManager: TLogManager;
  ModelFabricante: TModelProduto;
  Stream: TStream;
begin
  if FGravarLog then
  begin
    LogManager:=TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Produtos: Linha : 371 - Entrou no OnDataChange às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
    finally
      LogManager.Free;
    end;
  end;

  EdtIdProduto.Text            := IntToStr(DataSet.FieldByName('idprodutos').AsInteger);
  Edtproduto.Text              := DataSet.FieldByName('produto').AsString;

  //Carregar Imagem no TImage
  Stream := DataSet.CreateBlobStream(DataSet.FieldByName('foto'), bmRead);
  try
    ImageFoto.Bitmap.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;

  ModelFabricante:= TModelProduto.Create;
  try
    EdtPreco.Text                := DataSet.FieldByName('preco').AsString;
    CBoxAro.ITems.Text           := DataSet.FieldByName('aro').AsString;
    CBoxLancamento.Items.Text    := DataSet.FieldByName('lancamento').AsString;
    CBoxFuracao.Items.Text       := IntToStr(DataSet.FieldByName('furacao').AsInteger);
    CBoxIdFabricante.Items.Text  := IntToStr(DataSet.FieldByName('idfabricante').AsInteger);
    EdtFabricante.Text           := ModelFabricante.PesquisaNomeDoFabricante(DataSet.FieldByName('idfabricante').AsInteger);
    CBoxIdLinha.Items.Text       := IntToStr(DataSet.FieldByName('idlinha').AsInteger);
    EdtLinha.Text                := ModelFabricante.PesquisaNomeDaLinha(DataSet.FieldByName('idlinha').AsInteger);// Fazer a pesquisa usando model fabricante para saber o nome da linha
    CBoxIdAcabamento.Items.Text  := IntToStr(DataSet.FieldByName('idacabamento').AsInteger);
    EdtAcabamento.Text           := ModelFabricante.PesquisarNomeAcabamento(DataSet.FieldByName('idacabamento').AsInteger);// Fazer a pesquisa usando model fabricante para saber  o nome do acabamento
    CBoxOffSet.Items.Text        := DataSet.FieldByName('offset_et').AsString;

    // Obter o valor do campo Ativo do DataSet
    ativoProduto := DataSet.FieldByName('Ativo').AsString;
    // Definir o valor do campo Ativo no combobox CBATivo
    if ativoProduto = 'S' then
      CBATivo.ItemIndex := CBATivo.Items.IndexOf('S')
    else if ativoProduto = 'N' then
      CBATivo.ItemIndex := CBATivo.Items.IndexOf('N')
    else
      CBATivo.ItemIndex := -1; // ou algum valor padrão, caso Ativo não seja válido

  finally
     ModelFabricante.Free;
  end;

  PopularProdutos;

end;

procedure TFrmCadastrodeProdutos.PopularDataSet;
var
  Model: TModelProduto;
  LogManager: TLogManager;
  Stream: TStream;
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
  Model         := TModelProduto.create;

  DataSet       := TClientDataset.Create(nil);
  try
    if FBtnUltimo='S' then
      qry := Model.CarregarTodosProdutos(DataSet, FSomenteAtivos, FSemContatos, 'S')
    else
      qry := Model.CarregarTodosProdutos(DataSet, FSomenteAtivos, FSemContatos);

    DataSet := CriarDataSet(DataSet);
    DataSet.Open;
    qry.First;
    while not qry.eof do
    begin
      DataSet.Append;
      DataSet.FieldByName('idprodutos').AsInteger     := Qry.FieldByName('idprodutos').AsInteger;
      DataSet.FieldByName('produto').AsString         := Qry.FieldByName('produto').AsString;

      Stream := CDS.CreateBlobStream(CDS.FieldByName('foto'), bmWrite);
      try
        // Carregar os dados do campo do MySQL no stream do CDS
        Stream.WriteBuffer(Qry.FieldByName('foto').AsBytes[0], Qry.FieldByName('foto').DataSize);
      finally
        Stream.Free;
      end;

       //verificar como faz no chatgpt
      DataSet.FieldByName('preco').AsCurrency         := Qry.FieldByName('preco').AsCurrency;
      DataSet.FieldByName('aro').AsInteger            := Qry.FieldByName('aro').AsInteger;
      DataSet.FieldByName('idfabricante').AsString    := Qry.FieldByName('idfabricante').AsString;
      DataSet.FieldByName('datainclusao').AsDatetime  := Qry.FieldByName('datainclusao').AsDatetime;
      DataSet.FieldByName('dataalteracao').AsDatetime := Qry.FieldByName('dataalteracao').AsDatetime;
      DataSet.FieldByName('dataexclusao').AsDatetime  := Qry.FieldByName('dataexclusao').AsDatetime;
      DataSet.FieldByName('ATIVO').AsString           := Qry.FieldByName('ATIVO').AsString;
      DataSet.FieldByName('lancamento').AsString      := Qry.FieldByName('lancamento').AsString;
      DataSet.FieldByName('furacao').AsInteger        := Qry.FieldByName('furacao').AsInteger;
      DataSet.FieldByName('offset_et').AsInteger      := Qry.FieldByName('offset_et').AsInteger;
      DataSet.FieldByName('idlinha').AsInteger        := Qry.FieldByName('idlinha').AsInteger;
      DataSet.FieldByName('idacabamento').AsInteger   := Qry.FieldByName('idacabamento').AsInteger;

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
        LogManager.AddLog('Tela - Cadastro de Produtos: Linha : 853 - Finalizou a PopularDataSet - Free Model  às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');

        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Produtos: Linha : 858 - Finalizou a PopularDataSet - E não deu free no DadaSet às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
      finally
        LogManager.Free;
      end;

    end;
    Model.Free;

  end;


end;

procedure TFrmCadastrodeProdutos.PopularProdutos;
var
  LogManager: TLogManager;
  Stream: TMemoryStream;
  AroValue: Integer;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Tela - Cadastro de Produtos: Linha : 940 - Entrou na PopularProdutos e Criou FProdutos às ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Cadastro_de_Produtos.txt');
    finally
       LogManager.Free;
    end;
  end;

  try
     if FTIpo<>'N' then
       FProduto.idprodutos   := StrTOInt(EdtIdProduto.Text);

     FProduto.Produto       := EdtProduto.Text;

     Stream := TMemoryStream.Create;
     try
       CarregarImagemParaStream(ImageFoto.Bitmap, Stream);
       Stream.Position := 0; // Certifique-se de que o stream comece do início
       // Agora você pode atribuir o stream à propriedade FProduto.Foto
       FProduto.Foto := Stream;

       // ... Agora você pode salvar os detalhes do produto no banco de dados
     finally
       Stream.Free;
     end;

     FProduto.Preco         := StrToCurr(EdtPreco.Text);

     if TryStrToInt(CBoxAro.Items[CBoxAro.ItemIndex], AroValue) then
     begin
       // Conversão bem-sucedida
       FProduto.aro := AroValue;
     end
     else
     begin
       // Tratar a situação quando a conversão falha
       ShowMessage('Valor inválido para Aro.');
     end;

//     FProduto.aro           := StrToInt(CBoxAro.Items[CBoxAro.ItemIndex]);
     FProduto.idfabricante  := StrToInt(CBoxIdFabricante.Items[CBoxIdFabricante.ItemIndex]);
     FProduto.DataInclusao  := Now;
     FProduto.DataAlteracao := Now;
//     FProduto.DataExclusao  := Now; //O que carregar aqui?
     FProduto.Ativo        := CBAtivo.Items[CBAtivo.ItemIndex];
     FProduto.lancamento   := CBoxLancamento.Items[CBoxLancamento.ItemIndex];
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

end.
