unit UCadastroFabricantes;

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
  FMX.Objects,
  FMX.Layouts,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.Controls.Presentation,
  FMX.ListBox,
  FMX.Edit,
  FMX.TabControl,
  System.Rtti,
  FMX.Grid.Style,
  FMX.ScrollBox,
  FMX.Grid,
  Datasnap.DBClient,
  Entity.Fabricantes,
  Model.Fabricantes,
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
  Controller.Fabricantes,
  Dao.Conexao,
  IniFiles,
  System.UIConsts,
  LogManager, FireDAC.FMXUI.Wait, Funcoes.CNPJCPF;

type
  TBotaoIndex = (biAlterar, biExcluir, biPrimeiro, biAnterior, biProximo, biUltimo, biNovo, BiGravar);
  TBotaoSet = set of TBotaoIndex;

  TFrmFabricantes = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    BtnPrimeiro: TButton;
    ShadowEffect2: TShadowEffect;
    BtnAnterior: TButton;
    ShadowEffect3: TShadowEffect;
    BtnProximo: TButton;
    ShadowEffect4: TShadowEffect;
    BtnUltimo: TButton;
    ShadowEffect5: TShadowEffect;
    BtnNovo: TButton;
    ShadowEffect6: TShadowEffect;
    BtnAlterar: TButton;
    ShadowEffect7: TShadowEffect;
    BtnExcluir: TButton;
    ShadowEffect8: TShadowEffect;
    lblTitulo: TLabel;
    ShadowEffect1: TShadowEffect;
    BtnSalvar: TButton;
    ShadowEffect21: TShadowEffect;
    TabControl1: TTabControl;
    TabItemCadastro: TTabItem;
    TabItemPesquisa: TTabItem;
    TabItemContato: TTabItem;
    LblCodCliente: TLabel;
    ShadowEffect32: TShadowEffect;
    EdtCodFabricante: TEdit;
    ShadowEffect22: TShadowEffect;
    LblRazao: TLabel;
    ShadowEffect9: TShadowEffect;
    EdtRazao: TEdit;
    ShadowEffect10: TShadowEffect;
    LblCnpj: TLabel;
    LblEndereco: TLabel;
    ShadowEffect11: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    EdtCnpj: TEdit;
    ShadowEffect13: TShadowEffect;
    EdtEndereco: TEdit;
    ShadowEffect14: TShadowEffect;
    LblNumero: TLabel;
    ShadowEffect15: TShadowEffect;
    EdtNumero: TEdit;
    ShadowEffect16: TShadowEffect;
    LblComplemento: TLabel;
    ShadowEffect17: TShadowEffect;
    EdtComplemento: TEdit;
    ShadowEffect18: TShadowEffect;
    LblCEP: TLabel;
    ShadowEffect19: TShadowEffect;
    EdtCep: TEdit;
    ShadowEffect20: TShadowEffect;
    LblCidade: TLabel;
    ShadowEffect25: TShadowEffect;
    EdtCidade: TEdit;
    ShadowEffect27: TShadowEffect;
    LblBairro: TLabel;
    ShadowEffect29: TShadowEffect;
    EdtBairro: TEdit;
    ShadowEffect28: TShadowEffect;
    LblUF: TLabel;
    ShadowEffect24: TShadowEffect;
    CBUF: TComboBox;
    ShadowEffect26: TShadowEffect;
    LblAtivo: TLabel;
    ShadowEffect23: TShadowEffect;
    CBAtivo: TComboBox;
    ShadowEffect31: TShadowEffect;
    GridFabricante: TStringGrid;
    Panel1: TPanel;
    EditPesquisa: TEdit;
    ShadowEffect33: TShadowEffect;
    LblPesquisar: TLabel;
    ShadowEffect34: TShadowEffect;
    BtnPesquisar: TButton;
    ShadowEffect30: TShadowEffect;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure PopularDataSet;
    procedure FormCreate(Sender: TObject);
    procedure TabItemPesquisaClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtCnpjExit(Sender: TObject);
  private
    { Private declarations }
    qry: TFDQuery;
    FTipo: String;
    FFabricante: TFabricante;
    RegrasDeNegocios: TModelFabricante;
    PodeGravar: Boolean;
    CDS: TClientDataSet;
    FConexao: TFDConnection;
    FController: TControllerFabricante;
    FLinguagem: string;
    CurrentDateTime: TDateTime; //Para uso com o Log
    DateTimeStr: string;        //Para uso com o Log
    FGravarLog: Boolean;        //Para uso com o Log
    FHabilitarLogsSistema: string;
    procedure DesabilitaBotoes(const BotaoSet:TBotaoSet);
    procedure CarregarCores;
    procedure CarregarLinguagem;
    Procedure PopularGridFabricante;
    procedure PreencheDadosEncontradosDoFabricante;
    procedure CarregarConfiguracao;
  public
    { Public declarations }
    DataSet: TClientDataSet;
    FSomenteAtivos: string;
    procedure OnDataSetChange;
    procedure PopularFabricante;
    Function CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
    constructor create;
    destructor destroy; override;
  end;

var
  FrmFabricantes: TFrmFabricantes;

implementation

{$R *.fmx}

procedure TFrmFabricantes.BtnNovoClick(Sender: TObject);
var
  qry: TFDQuery;
  NextID: Integer;
begin
  FTipo:='N';

  DesabilitaBotoes([BiGravar]);//Desabilita todos bot�es menos o bot�o gravar

  qry := TFDQuery.Create(nil); // Crie o objeto TFDQuery

  try
    qry.Connection := TConnection.CreateConnection;

    qry.SQL.Text := 'SELECT MAX(idfabricantes) + 1 AS NextID FROM FAbricantes';
    qry.Open;

    NextID := qry.FieldByName('NextID').AsInteger;

    // Verifique se o valor retornado � NULL (sem registros na tabela)
    if qry.FieldByName('NextID').IsNull then
      NextID := 1;

  finally
    qry.Free;
  end;

  //Limpar todos os campos da tela
  EdtCodFabricante.Text := IntToStr(NextID);
  EdtRazao.Text         := '';
  EdtCnpj.Text          := '';
  EdtEndereco.Text      := '';
  EdtNumero.Text        := '';
  EdtComplemento.Text   := '';
  EdtCep.Text           := '';
  EdtCidade.Text        := '';
  EdtBairro.Text        := '';
  CBUF.Index            := 24;
  CBAtivo.Index         := 1;

  //Foco no campo EdtRazao
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

end;

procedure TFrmFabricantes.BtnPesquisarClick(Sender: TObject);
var
  I, J: Integer;
  TermoPesquisa: string;
begin
  PopularDataSet;
  //Revisar o uso na aba da tela de clientes onde tem o GridFabricante.
  TermoPesquisa := EditPesquisa.Text;

  // Percorra as c�lulas do grid para encontrar correspond�ncias com o termo de pesquisa
  for I := 0 to GridFabricante.RowCount - 1 do
  begin
    for J := 0 to GridFabricante.ColumnCount - 1 do
    begin
      if Pos(UpperCase(TermoPesquisa), UpperCase(GridFabricante.Cells[J, I])) > 0 then
      begin
        // Destaque a c�lula encontrada
        GridFabricante.SelectCell(J, I);

        // Fa�a algo com a c�lula encontrada, como exibir uma mensagem
        ShowMessage('Encontrado em ' + GridFabricante.Cells[J, 0] + ': ' + GridFabricante.Cells[J, I]);

        //Preencher os Edits da Aba Cadastro
        PreencheDadosEncontradosDoFabricante;

        // Voc� pode retornar aqui se desejar encontrar apenas a primeira correspond�ncia
        // Exit;
      end;

    end;
  end;

end;

procedure TFrmFabricantes.BtnPrimeiroClick(Sender: TObject);
begin
  DataSet.First;
  OnDataSetChange;
end;

procedure TFrmFabricantes.BtnAlterarClick(Sender: TObject);
begin
  FTipo:='A';

  DesabilitaBotoes([BiGravar]);

  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

end;

procedure TFrmFabricantes.BtnAnteriorClick(Sender: TObject);
begin
  DataSet.prior;
  OnDataSetChange;
end;

procedure TFrmFabricantes.BtnExcluirClick(Sender: TObject);
begin
  FTipo:='E';
  DesabilitaBotoes([BiGravar]);
end;

procedure TFrmFabricantes.BtnSalvarClick(Sender: TObject);
var
  Abortar: Boolean;
  Confirmacao: Integer;
begin
  PopularFabricante;
  try
     //Testar se os campos foram todos preenchidos
     RegrasDeNegocios:= TModelFabricante.Create;
     PodeGravar :=  RegrasDeNegocios.TestaSeCamposPreenchidos(FFabricante);

     if PodeGravar then //testar preenchimento dos campos
     begin

       Abortar:= RegrasDeNegocios.FabricanteExiste(FFabricante.cnpj);
       if Abortar then  //cliente Existe
       begin
         ShowMessage('Fabricante j� existe no Cadastro!');

         if FTipo='A' then //Alterar
         begin
           RegrasDeNegocios.AlterarFabricante(FFabricante);
           PopularDataSet;
           OnDataSetChange;
           Exit;
         end;

         if FTipo='N' then //Novo Registro
         begin
           RegrasDeNegocios.SalvarFabricante(FFabricante);
           PopularDataSet;
           OnDataSetChange;
           Exit;
         end;

         if FTipo='E' then //Excluir
         begin
           RegrasDeNegocios.RemoverFabricante(FFabricante);
           PopularDataSet;
           OnDataSetChange;
           Exit;
         end;

       end;

     end
     else //N�o atendeu as regras de neg�cios e n�o grava
     begin
       ShowMessage('N�o foi poss�vel salvar os dados do fabricante');

       if EdtRazao.CanFocus then
         EdtRazao.SetFocus;
     end;

     DesabilitaBotoes([BiPrimeiro,BiAnterior,BiProximo,BiUltimo,BiNovo,BiAlterar,BiExcluir,BiGravar]);
  finally
    FFabricante.Free;
    RegrasDeNegocios.Free;
  end;


end;

procedure TFrmFabricantes.BtnProximoClick(Sender: TObject);
begin
  DataSet.Next;
  OnDataSetChange;
end;

procedure TFrmFabricantes.BtnUltimoClick(Sender: TObject);
begin
  DataSet.Last;
  OnDataSetChange;
end;

procedure TFrmFabricantes.CarregarConfiguracao;
var
   IniFile    : TIniFile;
   LogManager : TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela - Cadastro de Fabricantes: Linha : 378 - Carregar Configura��o - Criou o IniFile �s ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Cadastro_de_Fabricantes.txt');

    LogManager.CarregarConfiguracao;
    FSomenteAtivos        := LogManager.FSomenteAtivos;        //Carregar categorias Ativos='S'
    FHabilitarLogsSistema := LogManager.FHabilitarLogsSistema; //Salvar Logs do Sistema

  finally
    LogManager.Free;
  end;

end;

procedure TFrmFabricantes.CarregarCores;
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

  for var I := 0 to FrmFabricantes.ComponentCount - 1 do
  begin
    if FrmFabricantes.Components[I] is TRectangle then
      TRectangle(FrmFabricantes.Components[I]).Fill.Color := Cor;
  end;

end;

procedure TFrmFabricantes.CarregarLinguagem;
var
  IniFile: TIniFile;
  I: Integer;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    FLinguagem :=IniFile.ReadString('Traducao', 'Linguagem', '');

   if FLinguagem = 'Portuguese' then
   begin
     LblCodCliente.Text      := 'Cod. Fabricante';
     LblRazao.Text           := 'Raz�o Social / Nome';
     LblCnpj.Text            := 'CNPJ / CPF';
     LblEndereco.Text        := 'Endere�o';
     LblNumero.Text          := 'N�mero';
     LblComplemento.Text     := 'Complemento';
     LblCEP.Text             := 'CEP';
     LblCidade.Text          := 'Cidade';
     LblCEP.Text             := 'CEP';
     LblUF.Text              := 'UF';
     LblAtivo.Text           := 'Ativo';
     LblPesquisar.Text       := 'Pesquisar';
     BtnNovo.Text            := '&Novo';
     BtnAlterar.Text         := '&Alterar';
     BtnExcluir.Text         := '&Excluir';
     BtnSalvar.Text          := '&Salvar';
     TabItemCadastro.Text    := 'Cadastro';
     TabItemPesquisa.Text    := 'Pesquisa';
     TabItemContato.Text     := 'Contato';
     lblTitulo.Text          := 'Cadastro do Fabricantes';
     FrmFabricantes.Caption  := 'Cadastro do Fabricantes';

   end
   else if FLinguagem = 'Ingles' then
   begin
     LblCodCliente.Text      := 'Id. Manufacturer';
     LblRazao.Text           := 'Corporate Name / Name';
     LblCnpj.Text            := 'Tax Identification Number - TIN';
     LblEndereco.Text        := 'Address';
     LblNumero.Text          := 'Number';
     LblComplemento.Text     := 'Complement';
     LblCidade.Text          := 'City';
     LblCEP.Text             := 'Zip Code';
     LblUF.Text              := 'State';
     LblAtivo.Text           := 'Active';
     LblPesquisar.Text       := 'Search';
     BtnNovo.Text            := '&New';
     BtnAlterar.Text         := '&Alter';
     BtnExcluir.Text         := '&Delete';
     BtnSalvar.Text          := '&Save';
     TabItemCadastro.Text    := 'Register';
     TabItemPesquisa.Text    := 'Search';
     TabItemContato.Text     := 'Contact';
     lblTitulo.Text          := 'Manufacturer Registration';
     FrmFabricantes.Caption  := 'Manufacturer Registration';
   end;

  finally
    IniFile.Free;
  end;

end;

constructor TFrmFabricantes.create;
begin
  FConexao    := TConnection.CreateConnection;
  FFabricante := TFabricante.create;
  FController := TControllerFabricante.Create;
end;

function TFrmFabricantes.CriarDataSet(aDadaSet: TClientDataSet): TClientDataSet;
begin
  CDS := TClientDataSet.Create(nil);
  try
    CDS.FieldDefs.Add('IDFABRICANTES', ftInteger);
    CDS.FieldDefs.Add('RAZAO', ftString, 100);
    CDS.FieldDefs.Add('CNPJ', ftString, 18);
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

procedure TFrmFabricantes.DesabilitaBotoes(const BotaoSet: TBotaoSet);
var
  TodosOsBotoes: array[TBotaoIndex] of TButton;
  Botao: TBotaoIndex;
begin
  // Mapeia os bot�es para seus �ndices correspondentes
  TodosOsBotoes[biAlterar]  := BtnAlterar;
  TodosOsBotoes[biExcluir]  := BtnExcluir;
  TodosOsBotoes[biPrimeiro] := BtnPrimeiro;
  TodosOsBotoes[biAnterior] := BtnAnterior;
  TodosOsBotoes[biProximo]  := BtnProximo;
  TodosOsBotoes[biUltimo]   := BtnUltimo;
  TodosOsBotoes[biNovo]     := BtnNovo;
  TodosOsBotoes[biGravar]   := BtnSalvar;

  // Desabilita todos os bot�es
  for Botao := Low(TBotaoIndex) to High(TBotaoIndex) do
    TodosOsBotoes[Botao].Enabled := False;

  // Habilita apenas os bot�es do conjunto do par�metro
  for Botao in BotaoSet do
    TodosOsBotoes[Botao].Enabled := True;

end;

destructor TFrmFabricantes.destroy;
begin
  FConexao.Free;
  FFabricante.Free;
  Fcontroller.Free;
  //FFabricante.Free;
  inherited
end;

procedure TFrmFabricantes.EdtCnpjExit(Sender: TObject);
var
  Funcoes: TCNPJCPF;
begin
  Funcoes:= TCNPJCPF.Create;
  try
    if not Funcoes.ValidarCNPJ(EdtCNPJ.Text) then
    begin
      ShowMessage('CNPJ inv�lido');
      EdtCnpj.SetFocus;
      BtnSalvar.Enabled:= False;
    end
    else
      BtnSalvar.Enabled:= True;;

    if not Funcoes.ValidarCPF(EdtCnpj.Text) then
    begin
      ShowMessage('CPF inv�lido');
      EdtCnpj.SetFocus;
      BtnSalvar.Enabled:= False;
    end
    else
      BtnSalvar.Enabled:= True;

  finally
    Funcoes.Free;
  end;

end;

procedure TFrmFabricantes.FormCreate(Sender: TObject);
begin
  FConexao     := TConnection.CreateConnection;
  FFabricante  := TFabricante.create;
  PopularDataSet;
  CarregarCores;
  CarregarLinguagem;
  CarregarConfiguracao;
  FController:= TControllerFabricante.Create;
end;

procedure TFrmFabricantes.FormShow(Sender: TObject);
begin
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

  BtnSalvar.Enabled:= False;

  TabControl1.ActiveTab:=TabItemCadastro;
end;

procedure TFrmFabricantes.OnDataSetChange;
var
  uffabricante: string;
  ativofabricante: string;
  Index: Integer;
begin
  EdtCodFabricante.Text := IntToStr(DataSet.FieldByName('idfabricantes').AsInteger);
  EdtRazao.Text         := DataSet.FieldByName('razao').AsString;
  EdtCnpj.Text          := DataSet.FieldByName('cnpj').AsString;
  EdtEndereco.Text      := DataSet.FieldByName('endereco').AsString;
  EdtNumero.Text        := IntToStr(DataSet.FieldByName('numero').AsInteger);
  EdtComplemento.Text   := DataSet.FieldByName('complemento').AsString;
  EdtCep.Text           := DataSet.FieldByName('CEP').AsString;
  EdtCidade.Text        := DataSet.FieldByName('Cidade').AsString;
  EdtBairro.Text        := DataSet.FieldByName('Bairro').AsString;

  // Definir o valor do campo UF no combobox CBUF
  // Obter o valor dos campos UF e Ativo do DataSet
  uffabricante    := DataSet.FieldByName('uf').AsString;
  ativofabricante := DataSet.FieldByName('Ativo').AsString;

  // Definir o valor do campo UF no combobox CBUF
  if CBUF.Items.IndexOf(uffabricante) > -1 then
    CBUF.ItemIndex := CBUF.Items.IndexOf(uffabricante)
  else
    CBUF.ItemIndex := -1; // ou algum valor padr�o, caso UF n�o seja v�lido

  // Definir o valor do campo Ativo no combobox CBATivo
  if ativofabricante = 'S' then
    CBATivo.ItemIndex := CBATivo.Items.IndexOf('S')
  else if ativofabricante = 'N' then
    CBATivo.ItemIndex := CBATivo.Items.IndexOf('N')
  else
    CBATivo.ItemIndex := -1; // ou algum valor padr�o, caso Ativo n�o seja v�lido

  PopularFabricante;  //Popula a vari�vel FFabricante

end;

procedure TFrmFabricantes.PopularDataSet;
var
  Model: TModelFabricante;
begin
  Model := TModelFabricante.create;
  DataSet := TClientDataset.Create(nil);
  try
    qry := Model.CarregarTodosFabricantes(DataSet);
    DataSet := CriarDataSet(DataSet);
    DataSet.Open;
    qry.First;
    while not qry.eof do
    begin
      DataSet.Append;
      DataSet.FieldByName('idfabricantes').AsInteger := Qry.FieldByName('idfabricantes').AsInteger;
      DataSet.FieldByName('razao').AsString          := Qry.FieldByName('razao').AsString;
      DataSet.FieldByName('cnpj').AsString           := Qry.FieldByName('cnpj').AsString;
      DataSet.FieldByName('endereco').AsString       := Qry.FieldByName('endereco').AsString;
      DataSet.FieldByName('numero').AsInteger        := Qry.FieldByName('numero').AsInteger;
      DataSet.FieldByName('complemento').AsString    := Qry.FieldByName('complemento').AsString;
      DataSet.FieldByName('CEP').AsString            := Qry.FieldByName('CEP').AsString;
      DataSet.FieldByName('Cidade').AsString         := Qry.FieldByName('Cidade').AsString;
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

procedure TFrmFabricantes.PopularFabricante;
begin
  FFabricante := TFabricante.Create;
  try
     FFabricante.idfabricantes   := StrTOInt(EdtCodfabricante.Text);
     FFabricante.razaosocial     := EdtRazao.Text;
     FFabricante.cnpj            := EdtCnpj.Text;
     FFabricante.Endereco        := EdtEndereco.Text;
     FFabricante.Numero          := StrToInt(EdtNumero.Text);
     FFabricante.Complemento     := EdtComplemento.Text;
     FFabricante.Cep             := EdtCep.Text;
     FFabricante.Cidade          := EdtCidade.Text;
     FFabricante.Bairro          := EdtBairro.Text;
     FFabricante.UF              := CBUF.Items[CBUF.ItemIndex];
     FFabricante.Ativo           := CBAtivo.Items[CBAtivo.ItemIndex];
  finally
    //FFabricante.Free;
  end;
end;

procedure TFrmFabricantes.PopularGridFabricante;
var
  I, J: Integer;

begin
  //Est� pulando um registro ao dar o Proximo na View.

  // Limpar as colunas existentes
  while GridFabricante.ColumnCount > 0 do
    GridFabricante.RemoveObject(GridFabricante.Columns[0]);


  // Configurar as colunas do grid
  GridFabricante.RowCount := DataSet.RecordCount + 1;

  for I := 0 to DataSet.FieldCount - 1 do
  begin
    GridFabricante.AddObject(TStringColumn.Create(GridFabricante));
    GridFabricante.Columns[I].Header := DataSet.Fields[I].FieldName;
  end;

  // Populando as c�lulas do grid com os dados do dataset
  DataSet.First;
  I := 0;

  while not DataSet.Eof do
  begin
    Inc(I);
    for J := 0 to DataSet.FieldCount - 1 do
      GridFabricante.Cells[J, I] := DataSet.Fields[J].AsString;

    DataSet.Next;

  end;


end;

procedure TFrmFabricantes.PreencheDadosEncontradosDoFabricante;
var
  SelectedRow: Integer;
begin
  if GridFabricante.Selected >= 0 then
  begin
    SelectedRow := GridFabricante.Selected;
    EdtCodFabricante.Text  := GridFabricante.Cells[0, SelectedRow];
    EdtRazao.Text       := GridFabricante.Cells[1, SelectedRow];
    EdtCnpj.Text        := GridFabricante.Cells[2, SelectedRow];
    EdtEndereco.Text    := GridFabricante.Cells[3, SelectedRow];
    EdtNumero.Text      := GridFabricante.Cells[4, SelectedRow];
    EdtComplemento.Text := GridFabricante.Cells[5, SelectedRow];
    EdtCep.Text         := GridFabricante.Cells[6, SelectedRow];
    EdtCidade.Text      := GridFabricante.Cells[7, SelectedRow];
    EdtBairro.Text      := GridFabricante.Cells[8, SelectedRow];
    CBUF.ItemIndex      := CBUF.Items.IndexOf(GridFabricante.Cells[9, SelectedRow]);
    CBAtivo.ItemIndex   := CBAtivo.Items.IndexOf(GridFabricante.Cells[10, SelectedRow]);
  end;

end;

procedure TFrmFabricantes.TabItemPesquisaClick(Sender: TObject);
begin
  PopularGridFabricante;
end;

end.
