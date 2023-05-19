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
  System.UIConsts;

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
    BtnGravar: TButton;
    ShadowEffect21: TShadowEffect;
    TabControl1: TTabControl;
    TabItemCadastro: TTabItem;
    TabItemPesquisa: TTabItem;
    TabItemContato: TTabItem;
    LblCodCliente: TLabel;
    ShadowEffect32: TShadowEffect;
    EdtCodFabricante: TEdit;
    ShadowEffect22: TShadowEffect;
    Label2: TLabel;
    ShadowEffect9: TShadowEffect;
    EdtRazao: TEdit;
    ShadowEffect10: TShadowEffect;
    Label3: TLabel;
    Label4: TLabel;
    ShadowEffect11: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    EdtCnpj: TEdit;
    ShadowEffect13: TShadowEffect;
    EdtEndereco: TEdit;
    ShadowEffect14: TShadowEffect;
    Label5: TLabel;
    ShadowEffect15: TShadowEffect;
    EdtNumero: TEdit;
    ShadowEffect16: TShadowEffect;
    Label6: TLabel;
    ShadowEffect17: TShadowEffect;
    EdtComplemento: TEdit;
    ShadowEffect18: TShadowEffect;
    Label7: TLabel;
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
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure PopularDataSet;
    procedure FormCreate(Sender: TObject);
    procedure TabItemPesquisaClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
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
    procedure DesabilitaBotoes(const BotaoSet:TBotaoSet);
    procedure CarregarCores;
    Procedure PopularGridFabricante;
    procedure PreencheDadosEncontradosDoFabricante;
  public
    { Public declarations }
    DataSet: TClientDataSet;
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

  DesabilitaBotoes([BiGravar]);//Desabilita todos botões menos o botão gravar

  qry := TFDQuery.Create(nil); // Crie o objeto TFDQuery

  try
    qry.Connection := TConnection.CreateConnection;

    qry.SQL.Text := 'SELECT MAX(idfabricantes) + 1 AS NextID FROM FAbricantes';
    qry.Open;

    NextID := qry.FieldByName('NextID').AsInteger;

    // Verifique se o valor retornado é NULL (sem registros na tabela)
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

  // Percorra as células do grid para encontrar correspondências com o termo de pesquisa
  for I := 0 to GridFabricante.RowCount - 1 do
  begin
    for J := 0 to GridFabricante.ColumnCount - 1 do
    begin
      if Pos(UpperCase(TermoPesquisa), UpperCase(GridFabricante.Cells[J, I])) > 0 then
      begin
        // Destaque a célula encontrada
        GridFabricante.SelectCell(J, I);

        // Faça algo com a célula encontrada, como exibir uma mensagem
        ShowMessage('Encontrado em ' + GridFabricante.Cells[J, 0] + ': ' + GridFabricante.Cells[J, I]);

        //Preencher os Edits da Aba Cadastro
        PreencheDadosEncontradosDoFabricante;

        // Você pode retornar aqui se desejar encontrar apenas a primeira correspondência
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

procedure TFrmFabricantes.BtnGravarClick(Sender: TObject);
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
         ShowMessage('Cliente já existe no Cadastro!');

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
     else //Não atendeu as regras de negócios e não grava
     begin
       ShowMessage('Não foi possível salvar os dados do cliente');

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

destructor TFrmFabricantes.destroy;
begin
  FConexao.Free;
  FFabricante.Free;
  Fcontroller.Free;
  //FFabricante.Free;
  inherited
end;

procedure TFrmFabricantes.FormCreate(Sender: TObject);
begin
  PopularDataSet;
  CarregarCores;
end;

procedure TFrmFabricantes.FormShow(Sender: TObject);
begin
  if EdtRazao.CanFocus then
    EdtRazao.SetFocus;

  BtnGravar.Enabled:= False;

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
    CBUF.ItemIndex := -1; // ou algum valor padrão, caso UF não seja válido

  // Definir o valor do campo Ativo no combobox CBATivo
  if ativofabricante = 'S' then
    CBATivo.ItemIndex := CBATivo.Items.IndexOf('S')
  else if ativofabricante = 'N' then
    CBATivo.ItemIndex := CBATivo.Items.IndexOf('N')
  else
    CBATivo.ItemIndex := -1; // ou algum valor padrão, caso Ativo não seja válido

  PopularFabricante;  //Popula a variável FFabricante

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
  //Está pulando um registro ao dar o Proximo na View.

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

  // Populando as células do grid com os dados do dataset
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
