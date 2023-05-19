unit UPrincipal;

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
  FMX.Gestures,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Menus,
  FMX.ListBox,
  FMX.Effects,
  uDM,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Comp.DataSet,
  FMX.Clipboard.Win,
  FMX.Platform,
  FMX.Surfaces,
  Winapi.Windows,
  System.IOUtils,
  FMX.Colors,
  System.UIConsts,
  FMX.Edit,
  UCadastroClientes,
  UCadastroCategorias,
  UCadastroVeiculos,
  UCadastroFabricantes,
  UCadastroOrcamentos,
  URegistrar,
  Dao.Conexao,
  System.Actions,
  FMX.ActnList,
  Vcl.Graphics,
  Vcl.Imaging.pngimage,
  Winapi.ShellAPI,
  FMX.StdActns,
  FMX.MediaLibrary.Actions,
  FMX.BitmapHelper,
  IPPeerClient,
  IPPeerServer,
  System.Tether.Manager,
  System.Tether.AppProfile,
  System.Tether.NetworkAdapter,
  uConfig,
  IniFiles,
  Vcl.Dialogs,
  IdCoderMIME,
  IdGlobal;

type
  TFrmPrincipal = class(TForm)
    Circle1: TCircle;
    Image4: TImage;
    GestureManager1: TGestureManager;
    Layout1: TLayout;
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    MenuItem4: TMenuItem;
    Panel2: TPanel;
    Panel3: TPanel;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    RectangleBottom: TRectangle;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    RectanguleLateralEsquerda: TRectangle;
    Panel4: TPanel;
    BtnCarregarFoto: TButton;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    MenuItem13: TMenuItem;
    Panel5: TPanel;
    Image5: TImage;
    ShadowEffect9: TShadowEffect;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    Panel6: TPanel;
    RectangleTop: TRectangle;
    RectanguleLaretalDireito: TRectangle;
    BtnCopiarFoto: TButton;
    ShadowEffect10: TShadowEffect;
    Rectangle1: TRectangle;
    Panel7: TPanel;
    LblNomeModelo: TLabel;
    ShadowEffect11: TShadowEffect;
    CBMarcas: TComboBox;
    ShadowEffect6: TShadowEffect;
    LblModelos: TLabel;
    CBModelo: TComboBox;
    LblFabricanteRodas: TLabel;
    CBFabricantes: TComboBox;
    LblCategorias: TLabel;
    CBCategorias: TComboBox;
    ShadowEffect8: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    lblMarcas: TLabel;
    Label1: TLabel;
    ShadowEffect7: TShadowEffect;
    Image2: TImage;
    MenuItem18: TMenuItem;
    ShadowEffect14: TShadowEffect;
    VertScrollBoxRodas: TVertScrollBox;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    ShadowEffect13: TShadowEffect;
    CBLinhas: TComboBox;
    LblLinhas: TLabel;
    ShadowEffect15: TShadowEffect;
    CBProdutos: TComboBox;
    LblProdutos: TLabel;
    BtnCopiarRoda: TButton;
    ShadowEffect16: TShadowEffect;
    ComboBox1: TComboBox;
    LblAcabamento: TLabel;
    Edit1: TEdit;
    LblProcurar: TLabel;
    ShadowEffect17: TShadowEffect;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
    ShadowEffect21: TShadowEffect;
    ShadowEffect22: TShadowEffect;
    ShadowEffect23: TShadowEffect;
    ShadowEffect24: TShadowEffect;
    ShadowEffect25: TShadowEffect;
    ShadowEffect26: TShadowEffect;
    ShadowEffect27: TShadowEffect;
    ShadowEffect28: TShadowEffect;
    ShadowEffect29: TShadowEffect;
    GroupBox_CaracTeristicas_Produto: TGroupBox;
    LblProduto: TLabel;
    Lbl_Descricao_Produto: TLabel;
    ShadowEffect20: TShadowEffect;
    LblPreco: TLabel;
    Lbl_Preco: TLabel;
    Label11: TLabel;
    LblFabricante: TLabel;
    Lbl_Fabricante: TLabel;
    Lbl_ValorTotal: TLabel;
    Lbl_VAlor_Total_Cliente: TLabel;
    MenuItem1: TMenuItem;
    Button5: TButton;
    ShadowEffect30: TShadowEffect;
    MenuItem3: TMenuItem;
    ActionList1: TActionList;
    Sair: TAction;
    MenuItem16: TMenuItem;
    LogOff: TAction;
    ActShare: TShowShareSheetAction;
    MediaReceiverManager: TTetheringManager;
    MediaReceiverProfile: TTetheringAppProfile;
    CalloutPanel1: TCalloutPanel;
    Image1: TImage;
    ShadowEffect31: TShadowEffect;
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    EdtWhatsApp: TEdit;
    procedure Circle1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Circle1Click(Sender: TObject);
    procedure Circle1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Circle1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Layout1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure Image4Gesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Circle1DblClick(Sender: TObject);
    procedure Image4DblClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure NewImagemClick(Sender: TObject);
    procedure NewImagemDbClick(Sender: TObject);
    procedure NewImagemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure NewImagemGesture(Sender: TObject;
              const EventInfo: TGestureEventInfo;
              var Handled: Boolean);
    procedure NewImagemMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormShow(Sender: TObject);
    procedure BtnCarregarFotoClick(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure BtnCopiarFotoClick(Sender: TObject);
    procedure Image4MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure TrackBar1Change(Sender: TObject);
    procedure CBMarcasChange(Sender: TObject);
    procedure CBModeloChange(Sender: TObject);
    procedure CBFabricantesChange(Sender: TObject);
    procedure CBCategoriasChange(Sender: TObject);
    procedure CBLinhasChange(Sender: TObject);
    procedure CBProdutosChange(Sender: TObject);
    procedure BtnCopiarRodaClick(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LogOffExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MediaReceiverProfileResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure MediaReceiverManagerRequestManagerPassword(const Sender: TObject;
      const ARemoteIdentifier: string; var Password: string);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);


  private
    { Private declarations }
    MoveObjeto: Boolean;
    OffSet: TPointF;
    NewCircle: TCircle;
    NewImagem: TImage;
    FIdMarcaSelecionada: integer;
    FIdFabricante: integer;
    FIdCategoria: integer;
    FidLinha: integer;
    FMemoryStream: TMemoryStream;
    FBlobStream: TStream;
    FIdProduto: integer;
    FValorTotalOrcamento: Double;
    ProdutoDS: TDataSet;
    qry: TFDQuery;
    FConexao: TFDConnection;

    procedure Modo_Edicao(editar: Boolean);
    procedure Modo_Edicao2(editar: Boolean);
    procedure NewImagemMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure SetidUsuario(const Value: Integer);
    procedure SaveBitmapToFile(Bitmap: TBitmap; const FileName: string);
    procedure EnviarImagemWhatsApp(const FileName: string);
    procedure EnviarAnexoWhatsApp(const FileName: string);
    function ImageToBase64(const FileName: string): string;
    function DesabilitaEdtWhatsApp:Boolean;
    
  public
    { Public declarations }
     FidUsuario: Integer;
     property idUsuario: Integer read FidUsuario write SetidUsuario;
     procedure CarregarCores;
     constructor create;
     destructor destroy;override;

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses Login;
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TFrmPrincipal.SairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrincipal.SaveBitmapToFile(Bitmap: TBitmap;
  const FileName: string);
var
  //Image: TPngImage;
  Image2: TBitMap;
begin
  //Image := TPngImage.Create;
  Image2:= TBitMap.Create;
  try
    //Image.Assign(Bitmap);
    Image2.Assign(BitMap);
    //Image.SaveToFile(FileName);
    Image2.SaveToFile(FileName);
  finally
    //Image.Free;
    Image2.Free;
  end;

end;

procedure TFrmPrincipal.BtnCarregarFotoClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.Filter := 'Arquivos de Imagem|*.bmp;*.jpg;*.jpeg;*.png';
    if OpenDialog.Execute then
    begin
      Image1.Bitmap.LoadFromFile(OpenDialog.FileName);
      LblNomeModelo.Text:= ChangeFileExt(TPath.GetFileName(OpenDialog.FileName), '');
    end;
  finally
    OpenDialog.Free;
  end;

end;

procedure TFrmPrincipal.BtnCopiarFotoClick(Sender: TObject);
var
  PrintScreen: TBitmap;
  DC: HDC;
  NomeArquivo: string;
begin
  keybd_event(VK_MENU, MapVirtualKey(VK_MENU, 0), 0, 0); // Pressiona a tecla Alt
  keybd_event(VK_SNAPSHOT, MapVirtualKey(VK_SNAPSHOT, 0), 0, 0); // Pressiona a tecla Print Screen
  keybd_event(VK_SNAPSHOT, MapVirtualKey(VK_SNAPSHOT, 0), KEYEVENTF_KEYUP, 0); // Libera a tecla Print Screen
  keybd_event(VK_MENU, MapVirtualKey(VK_MENU, 0), KEYEVENTF_KEYUP, 0); // Libera a tecla Alt

  PrintScreen := TBitmap.Create;
  try
    PrintScreen.Width  := Round(Screen.Width);  //1920-1536 = 384
    PrintScreen.Width := PrintScreen.Width + 384;
    PrintScreen.Height := Round(Screen.Height); //1080-864  = 216
    PrintScreen.Height := PrintScreen.Height + 216;
    DC := GetDC(0);
    try
      BitBlt(PrintScreen.Canvas.Handle, 0, 0, PrintScreen.Width, PrintScreen.Height,
        DC, 0, 0, SRCCOPY);
    finally
      ReleaseDC(0, DC);
    end;

    SaveBitmapToFile(PrintScreen, 'printscreen.bmp'); // Salvar em arquivo .png
  finally
    PrintScreen.Free;
  end;

  // Gere o arquivo PrintScreen.png anteriormente
  NomeArquivo := ExtractFilePath(ParamStr(0))+ '\PrintScreen.png';
  EnviarImagemWhatsApp(NomeArquivo);

end;

procedure TFrmPrincipal.BtnCopiarRodaClick(Sender: TObject);
begin
  if MoveObjeto then
    Modo_Edicao(False);

  if NOT Assigned(NewCircle) then
    begin
      // Create a new TCircle component
      NewCircle := TCircle.Create(Self);

      // Copy the properties of the original TCircle component
      NewCircle.Position.X := Circle1.Position.X + 50;
      NewCircle.Position.Y := Circle1.Position.Y + 50;
      NewCircle.Width      := Circle1.Width;
      NewCircle.Height     := Circle1.Height;
      NewCircle.Fill.Color := Circle1.Fill.Color;

      //Criar o TImage dentro do NewCircle
      NewImagem:= TImage.Create(NewCircle);
      NewImagem.Parent:= NewCircle;
      NewImagem.Bitmap.Assign(TImage(Circle1.Children[0]).Bitmap);
      NewImagem.Align:=  TalignLayout.Client;

      // Eventos
      NewImagem.OnClick      :=  NewImagemClick;
      NewImagem.OnDblClick   :=  NewImagemDbClick;
      NewImagem.OnGesture    :=  NewImagemGesture;
      NewImagem.OnMouseDown  :=  NewImagemMouseDown;
      NewImagem.OnMouseUp    :=  NewImagemMouseUp;
      NewImagem.OnMouseWheel :=  NewImagemMouseWheel;

      NewCircle.Parent := Self; //Cria no Formulário Principal
    end
    else //apagar o mesmo ou receber a copia da Matrix Atual
    begin
      //Criar o TImage dentro do NewCircle
      NewImagem.BitMap.Clear($000000);
      NewImagem:= TImage.Create(nil); //NewCircle - original
      NewImagem.Parent:= NewCircle;
      NewImagem.Bitmap.Assign(TImage(Circle1.Children[0]).Bitmap);
      NewImagem.Align:=  TalignLayout.Client;

      // Copy the events from the original TImage to the new TImage
      //NewImagem.OnClick      :=  NewImagemClick; //Ficou com o clique esquerdo sem função
      NewImagem.OnDblClick   :=  NewImagemDbClick;
      NewImagem.OnGesture    :=  NewImagemGesture;
      NewImagem.OnMouseDown  :=  NewImagemMouseDown;
      NewImagem.OnMouseUp    :=  NewImagemMouseUp;
      NewImagem.OnMouseWheel :=  NewImagemMouseWheel;

      //Exit;
    end;
end;

procedure TFrmPrincipal.Button5Click(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.Filter := 'Arquivos de Imagem|*.bmp;*.jpg;*.jpeg;*.png';
    if OpenDialog.Execute then
    begin
      Image4.Bitmap.LoadFromFile(OpenDialog.FileName);
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TFrmPrincipal.CarregarCores;
var
  IniFile: TIniFile;
  Cor: TAlphaColor;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Cor := StringToAlphaColor(IniFile.ReadString('Cores', 'Cor', ''));
  finally
    IniFile.Free;
  end;

  for var I := 0 to FrmPrincipal.ComponentCount - 1 do
  begin
    if FrmPrincipal.Components[I] is TRectangle then
      TRectangle(FrmPrincipal.Components[I]).Fill.Color := Cor;
  end;
end;

procedure TFrmPrincipal.CBCategoriasChange(Sender: TObject);
begin
  FIdCategoria:= Integer(CBCategorias.Items.Objects[CBCategorias.ItemIndex]);

  { Carregar o combobox LINHAS}
   qry:= TFDQuery.Create(nil);
   qry.Connection:= DM.FDConnection1;
   try
     qry.Close;
     qry.SQL.Text:='SELECT L.IDLINHA, L.LINHA, L.IDCATEGORIA '+
                   ' FROM LINHA L ' +
                   ' INNER JOIN CATEGORIAS C ON (L.IDCATEGORIA = C.IDCATEGORIAS)' +
                   ' WHERE L.ATIVO=''S'' ' +
                   '   AND L.IDCATEGORIA = :IDCATEGORIA' +
                   ' ORDER BY L.IDLINHA ASC';

     qry.ParamByName('IDCATEGORIA').DataType   := ftSmallint;
     qry.ParamByName('IDCATEGORIA').AsSmallint := FIdCategoria;
     qry.Open;
     //Showmessage('No Onchange de CBCAtegorias a qtde. de Registros é de: ' +IntToStr(qry.RecordCount));

     //Limpar o CBLinhas
     CBLinhas.Clear;

     qry.First;
     While Not qry.Eof do
     begin
       CBLinhas.Items.Add(qry.FieldByName('LINHA').AsString);
       qry.Next;
     end;
   finally
     qry.Close;
     qry.Free;
   end;

end;

procedure TFrmPrincipal.CBFabricantesChange(Sender: TObject);
begin
 
  {Precisa preencher a variável com o valor do idMarca escolhi no combobox Marcas}
  FIdFabricante:= Integer(CBFabricantes.Items.Objects[CBFabricantes.ItemIndex]);

  { Carregar o combobox CATEGORIAS}
   qry:= TFDQuery.Create(nil);
   qry.Connection:= DM.FDConnection1;
   try
     qry.Close;
     qry.SQL.Text:='SELECT C.IDCATEGORIAS,  C.CATEGORIA FROM CATEGORIAS C ' +
                   ' INNER JOIN FABRICANTES F ON(F.IDFABRICANTES = C.IDFABRICANTE)' +
                   ' WHERE C.ATIVO=''S'' ' +
                   '  AND IDFABRICANTE = :IDFABRICANTE' +
                   '    ORDER BY C.CATEGORIA ASC';

     qry.ParamByName('IDFABRICANTE').DataType   := ftSmallint;
     qry.ParamByName('IDFABRICANTE').AsSmallint := FIdFabricante;
     qry.Open;
     //ShowMessage('No On Change do CBFabricante  a qtde. de Registros é de: ' + IntToStr(qry.RecordCount));

     //Limpar o CBCategorias
     CBCategorias.Clear;

     qry.First;
     While Not qry.Eof do
     begin
       CBCategorias.Items.AddObject(qry.FieldByName('CATEGORIA').AsString, TObject(qry.FieldByName('IDCATEGORIAS').AsInteger));
       qry.Next;
     end;
   finally
     qry.Close;
     qry.Free;
   end;

end;

procedure TFrmPrincipal.CBLinhasChange(Sender: TObject);
begin
  //Colocar a foto na Roda Matrix.
  FidLinha:= FIdCategoria; //Integer(CBLinhas.Items.Objects[CBLinhas.ItemIndex]);  //vem zero

  { Carregar o combobox LINHAS}
   qry:= TFDQuery.Create(nil);
   qry.Connection:= DM.FDConnection1;
   try
     qry.Close;
     qry.SQL.Text:='SELECT P.IDPRODUTOS, P.PRODUTO, P.FOTO, P.PRECO, P.IDFABRICANTE,' +
                   ' P.ARO, P.LANCAMENTO,P.FURACAO, P.OFFSET_ET, P.IDACABAMENTO, P.IDLINHA' +
                   ' FROM PRODUTOS P ' +
                   ' INNER JOIN LINHA L ON(L.IDLINHA = P.IDLINHA)' +
                   ' WHERE P.ATIVO=''S'' ' +
                   '  AND P.IDLINHA = :IDLINHA' +
                   '    ORDER BY P.PRODUTO ASC';

     qry.ParamByName('IDLINHA').DataType   := ftSmallint;
     qry.ParamByName('IDLINHA').AsSmallint := FidLinha;
     qry.Open;
     //Showmessage('No CBLinhas Change a qtde. de Registros é de: ' + IntToStr(qry.RecordCount));

     //Limpar  o CBProdutos
     CBProdutos.Clear;

     qry.First;
     While Not qry.Eof do
     begin
       CBProdutos.Items.AddObject(qry.FieldByName('PRODUTO').AsString, TObject(qry.FieldByName('IDPRODUTOS').AsInteger));
       qry.Next;
     end;
   finally
     qry.Close;
     qry.Free;
   end;

end;

procedure TFrmPrincipal.CBMarcasChange(Sender: TObject);
begin
  {Precisa preencher a variável com o valor do idMarca escolhi no combobox Marcas}
  FIdMarcaSelecionada:= Integer(CBMarcas.Items.Objects[CBMarcas.ItemIndex]);

   { Carregar o combobox Modelos}
   qry:= TFDQuery.Create(nil);
   qry.Connection:= DM.FDConnection1;
   try
     qry.Close;
     qry.SQL.Text:='SELECT MO.IDMARCA,MO.MODELO FROM MODELOS MO ' +
                   ' INNER JOIN MARCA MA ON(MO.IDMARCA = MA.IDMARCA)' +
                   ' WHERE MO.IDMARCA =:IDMARCA' +
                   '    ORDER BY MO.MODELO ASC';

     qry.ParamByName('IDMARCA').DataType   := ftSmallint;
     qry.ParamByName('IDMARCA').AsSmallint := FIdMarcaSelecionada;
     qry.Open;
     qry.SQL.SaveToFile('c:\sql.txt');

     //Limpar o CBModelo
     CBModelo.Clear;

     qry.First;
     While Not qry.Eof do
     begin
       CBModelo.Items.Add(qry.FieldByName('modelo').AsString);
       qry.Next;
     end;
   finally
     qry.Close;
     qry.Free;
   end;
end;

procedure TFrmPrincipal.CBModeloChange(Sender: TObject);
begin
  //Carregar as Rodas Compatíveis com o modelo
end;

procedure TFrmPrincipal.CBProdutosChange(Sender: TObject);
begin
  // CARREGAR A FOTO NA MATRIX DE RODAS
  FIdProduto:= Integer(CBProdutos.Items.Objects[CBProdutos.ItemIndex]);

  qry:= TFDQuery.Create(nil);
  qry.Connection:= DM.FDConnection1;
  try
    qry.Close;
    qry.SQL.Text:='SELECT P.IDPRODUTOS, P.PRODUTO, P.FOTO, P.PRECO, P.IDFABRICANTE, ' +
                  ' P.ARO, P.LANCAMENTO,P.FURACAO, P.OFFSET_ET, P.IDACABAMENTO, P.IDLINHA' +
                  ' FROM PRODUTOS P' +
                  ' WHERE P.IDPRODUTOS =:IDPRODUTOS';
    qry.ParamByName('IDPRODUTOS').DataType   := ftSmallint;
    qry.ParamByName('IDPRODUTOS').AsSmallint := FIdProduto;
    qry.Open;
    //ShowMessage('A qtde. de produto encontrados é de :' + IntToStr(qry.RecordCount));

    ProdutoDS   := qry;
    FMemoryStream := TMemoryStream.Create;
    FBlobStream := ProdutoDS.CreateBlobStream(ProdutoDS.FieldByName('foto'), bmRead);
    try
      FMemoryStream := TMemoryStream.Create;
      try
        FMemoryStream.LoadFromStream(FBlobStream);
        iMAGE4.Bitmap.LoadFromStream(FMemoryStream);

      finally
        FMemoryStream.Free;
      end;
    finally
      FBlobStream.Free;
    end;

    //Preenche as características Técnicas do Produto
    Lbl_Descricao_Produto.Text:= qry.FieldByName('PRODUTO').AsString;
    Lbl_Preco.Text            := FormatFloat('R$ ###,###.00', qry.FieldByName('PRECO').AsFloat);

    //Calcular o Orçamento do Jogo de Rodas/Calotas
    FVAlorTotalOrcamento:=0;
    FValorTotalOrcamento:= FValorTotalOrcamento + qry.FieldByName('PRECO').AsFloat * 4;
    Lbl_VAlor_Total_Cliente.Text:= FormatFloat('R$ ###,###.00', FValorTotalOrcamento);

    Lbl_Fabricante.Text       := CBFabricantes.Items[CBFabricantes.ItemIndex];

  finally
    qry.Close;
    qry.Free;
  end;

end;

procedure TFrmPrincipal.Circle1Click(Sender: TObject);
begin
  if circle1.Tag = 0 then
  begin
    Showmessage('Abrir opções...');
  end;
end;

procedure TFrmPrincipal.Circle1DblClick(Sender: TObject);
begin
  //Aumenta o tamanho da roda em um em um pixel
  Circle1.Width  := Circle1.Width + 1;
  Circle1.Height := Circle1.Height + 1;
end;

procedure TFrmPrincipal.Circle1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin

  if EventInfo.GestureID = igiLongTap then
    Modo_Edicao(true);

  if EventInfo.GestureID = igiDoubleTap then
    Modo_Edicao(False);

end;

procedure TFrmPrincipal.Circle1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin

  //Seta o Layout para capturar o mouse
  if circle1.Tag = 1 then
    layout1.Root.Captured := layout1;

  //Indica que o objeto pode se mover
  MoveObjeto:= True;

  OffSet.X := X;
  OffSet.Y := Y;

  //Botão direito muda o modo edição...
  if Button = TMouseButton.mbRight then
    Modo_Edicao(NOT Circle1.Tag.ToBoolean);

end;

procedure TFrmPrincipal.Circle1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  MoveObjeto:= False;
end;

constructor TFrmPrincipal.create;
begin
  FConexao := TConnection.CreateConnection;
end;

function TFrmPrincipal.DesabilitaEdtWhatsApp: Boolean;
var
  Config: TIniFile;
  WhatsApp: string;
begin
 Result:= False;
 Config := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
 try
    WhatsApp := Config.ReadString('WhatsApp', 'EnviaParaContatoEspecifico', '');
    if WhatsApp='S' then
      EdtWhatsApp.Enabled:=True
    else
      EdtWhatsApp.Enabled:=False;
  finally
    Config.Free;
  end;

end;

destructor TFrmPrincipal.destroy;
begin
  //FConexao.Free;
  inherited;
end;

procedure TFrmPrincipal.EnviarAnexoWhatsApp(const FileName: string);
var
  DestFileName: string;
begin
  DestFileName := IncludeTrailingPathDelimiter(TPath.GetTempPath) + 'WhatsAppAttachment';
  TFile.Copy(FileName, DestFileName);

  ShellExecute(0, 'open',PChar('whatsapp://send?text=Mensagem%20opcional&attachment=' +
    DestFileName), nil, nil, SW_SHOW);

end;

procedure TFrmPrincipal.EnviarImagemWhatsApp(const FileName: string);
var
  TempPath: string;
  TempFileName: string;
  DestFileName: string;

  ImagePath: string;
  Base64String: string;
  Config: TIniFile;
  WhatsApp: String;
begin
  Config := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    WhatsApp := Config.ReadString('WhatsApp', 'EnviaParaContatoEspecifico', '');
  finally
    Config.Free;
  end;

  if WhatsApp ='S' then //Enviar para um contato especifico
  begin
    ImagePath := ExtractFilePath(ParamStr(0)) + 'printscreen.bmp';
    Base64String := ImageToBase64(ImagePath);
    DestFileName:= 'whatsapp://send?phone=+55'+EdtWhatsApp.text+'&text=Olá segue orçamento das Jantes/Calotas -Loja Fulano Rodas!&textmode=auto';
    ShellExecute(0, 'open', PChar(DestFileName), nil, nil, SW_SHOW);
  end
  else if WhatsApp = 'N' then //Enviar para vários contatos
  begin
    TempPath := TPath.GetTempPath;
    TempFileName := ExtractFilePath(ParamStr(0)) + 'printscreen.bmp';
    DestFileName := 'whatsapp://send?text=Fulano%20Rodas%20Orçamento&action=pic' + TempFileName;
    ShellExecute(0, 'open', PChar(DestFileName), nil, nil, SW_SHOW);
  end;

end;

procedure TFrmPrincipal.FormActivate(Sender: TObject);
begin
//  Formulário de Login aparecendo na frente do FormPrincipal já criado
//  Application.CreateForm(TFrmLogin, FrmLogin);
//  FrmLogin.ShowModal;
//  FrmLogin.Destroy;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmLogin.Close;
  //Application.Terminate;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Modo_Edicao(false);
  Modo_Edicao2(False);
  DM.FDConnection1.Connected:= True;
  CarregarCores;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
  I: Integer;
  Index: integer;
  CaptionToFind: string;

  MainMenu: TMainMenu;

begin
   //Testa se é para desabilitar o campo de inserir telefone do Whatsapp
   DesabilitaEdtWhatsApp;

   //Carregar todos os fabricantes no Combobox1
   DM.FDQMarcas.Open;
   DM.FDQMarcas.First;
   While NOT DM.FDQMarcas.Eof do
   begin
     CBMarcas.Items.AddObject(DM.FDQMarcas.FieldByName('marca').AsString, TObject(DM.FDQMarcas.FieldByName('IDMARCA').AsInteger));
     DM.FDQMarcas.Next;
   end;

   //Carregar os Fabricantes das Rodas no CBFabricantes
   DM.FDQFabricantes.Open;
   DM.FDQFabricantes.First;
   while NOT DM.FDQFabricantes.Eof do
   begin
     CBFabricantes.Items.AddObject(DM.FDQFabricantes.FieldByName('razao').AsString, TObject(DM.FDQFabricantes.FieldByName('idfabricantes').AsInteger));
     DM.FDQFabricantes.Next;
   end;

   //Carrega as permissões dos usuários
   try
     FConexao := TConnection.CreateConnection;
     qry:= TFDQuery.Create(Self);
     qry.Connection:= FConexao;
     qry.Close;
     qry.SQL.Add('SELECT p.idpermissoes, p.idusuario, p.idmenu, p.permitido, m.captionmenu ');
     qry.SQL.Add('FROM permissoes p ');
     qry.SQL.Add('JOIN menus m ON (m.idmenus = p.idmenu) ');
     qry.SQL.Add('WHERE p.idusuario = :idusuario');
     qry.ParamByName('idusuario').DataType:= ftInteger;
     qry.ParamByName('idusuario').AsInteger:= FIdUsuario; //vindo 0
     qry.Open;
//     ShowMessage('A quantidade de registros foi de : ' + IntToStr(qry.RecordCount));

     i:=0;
     DM.CDS_Permissoes.EmptyDataSet;
     DM.CDS_Permissoes.Close;
     DM.CDS_Permissoes.Open;
     qry.First;
     while Not qry.Eof do
     begin
       inc(i);
       DM.CDS_Permissoes.Append;
       DM.CDS_Permissoes.FieldByName('IDPERMISSOES').AsInteger := i;
       DM.CDS_Permissoes.FieldByName('IDUSUARIO').AsInteger    := FIdUsuario;//DE ONDE VIRÁ O IDUSUARIO?;
       DM.CDS_Permissoes.FieldByName('IDMENU').AsInteger       := qry.FieldByName('idmenu').AsInteger;
       DM.CDS_Permissoes.FieldByName('PERMITIDO').AsString     := qry.FieldByName('permitido').AsString;
       //DM.CDS_Permissoes.FieldByName('USUARIO').AsString     := qry.FieldByName('USUARIO').AsString;
       DM.CDS_Permissoes.FieldByName('CAPTIONMENU').AsString   := qry.FieldByName('CAPTIONMENU').AsString;
       //DM.CDS_Permissoes.FieldByName('TIPO').AsString          := qry.FieldByName('TIPO').AsString;

       DM.CDS_Permissoes.Post;

       //LER OS ITENS DE MENU QUE BATEM COM O CAPTIONMENU E DESATIVAR OS COM N
       {$IFDEF MSWINDOWS}
        CaptionToFind := DM.CDS_Permissoes.FieldByName('CAPTIONMENU').AsString;

       for I := 0 to MainMenu1.ItemsCount - 1 do
       begin
         if (MainMenu1.Items[i] is TMenuItem) and (
             TMenuItem(MainMenu1.Items[i]).Text = CaptionToFind) then
         begin
           // Salve uma referência aos itens de menu existentes
           //MainMenu := TMainMenu.Create(nil);
           //MainMenu.Clone(MainMenu1);

           // Encontrou o texto correspondente
           if qry.FieldByName('PERMITIDO').AsString = 'N' then
           begin
             TMenuItem(MainMenu1.Items[i]).BeginUpdate;
             TMenuItem(MainMenu1.Items[i]).Enabled:= False;
             TMenuItem(MainMenu1.Items[i]).EndUpdate;
           end
           else
           begin
             TMenuItem(MainMenu1.Items[i]).BeginUpdate;
             TMenuItem(MainMenu1.Items[i]).Enabled:= True;
             TMenuItem(MainMenu1.Items[i]).EndUpdate;
             Break;
           end;
         end;
       end;
       {$ENDIF}
//       {$IFDEF MSWINDOWS}
//        CaptionToFind := DM.CDS_Permissoes.FieldByName('CAPTIONMENU').AsString;
//
//       for I := 0 to MainMenu1.ItemsCount - 1 do
//       begin
//         if (MainMenu1.Items[i] is TMenuItem) and (
//             TMenuItem(MainMenu1.Items[i]).Text = CaptionToFind) then
//         begin
//           // Encontrou o texto correspondente
//           if qry.FieldByName('PERMITIDO').AsString = 'N' then
//             TMenuItem(MainMenu1.Items[i]).Enabled:= False
//           else
//             TMenuItem(MainMenu1.Items[i]).Enabled:= True;
//             Break;
//         end;
//       end;
//       {$ENDIF}
       qry.Next;
     end;

   finally
     qry.Free;
     FConexao.Free;
   end; //Fim das permissões dos Menus

end;



procedure TFrmPrincipal.Image4DblClick(Sender: TObject);
begin
  Circle1.Width  := Circle1.Width + 1;
  Circle1.Height := Circle1.Height + 1;
end;

procedure TFrmPrincipal.Image4Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  if EventInfo.GestureID = igiLongTap then
    Modo_Edicao2(true);

  if EventInfo.GestureID = igiDoubleTap then
    Modo_Edicao2(False);
end;

procedure TFrmPrincipal.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  //Seta o Layout para capturar o mouse
  if circle1.Tag = 1 then
    layout1.Root.Captured := layout1;

  //Indica que o objeto pode se mover
  MoveObjeto:= True;

  OffSet.X := X;
  OffSet.Y := Y;

  //Botão direito muda o modo de edição...
  if Button = TMouseButton.mbRight then
  begin
    Modo_Edicao(NOT Circle1.Tag.ToBoolean);
    if MoveObjeto then   //Desabilita a Edição da Roda 2 quando a Roda Matrix entra em edição
    Modo_Edicao2(False);
  end;

  if Button = TMouseButton.mbMiddle then
  begin
    Circle1.Width  := Circle1.Width - 1;
    Circle1.Height := Circle1.Height - 1;
  end;

end;

procedure TFrmPrincipal.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  MoveObjeto:= False;
end;

procedure TFrmPrincipal.Image4MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
begin
  if Circle1.Tag = 1 then
  begin
    if WheelDelta < 0 then // Rolar para trás diminui
    begin
      Circle1.Width  := Circle1.Width - 3;
      Circle1.Height := Circle1.Height - 3;
    end
    else if WheelDelta > 0 then // Rolar para frente aumenta
    begin
      Circle1.Width  := Circle1.Width + 3;
      Circle1.Height := Circle1.Height + 3;
    end;
  end
  else //Se não estiver em modo de edição cai fora
    Exit;

end;

procedure TFrmPrincipal.Image5Click(Sender: TObject);
var
  Url: string;
begin
  Url := 'https://conectsolutionsti.com.br';

  if ShellExecute(0, 'open', PChar(Url), nil, nil, SW_SHOWNORMAL) <= 32 then
    ShowMessage('Não foi possível abrir o navegador padrão.');

end;

function TFrmPrincipal.ImageToBase64(const FileName: string): string;
var
  ImageStream: TFileStream;
  Encoder: TIdEncoderMIME;
  Base64Stream: TStringStream;
begin
  ImageStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  Encoder := TIdEncoderMIME.Create(nil);
  Base64Stream := TStringStream.Create('');

  try
    Encoder.Encode(ImageStream, Base64Stream);
    Result := Base64Stream.DataString;
  finally
    ImageStream.Free;
    Encoder.Free;
    Base64Stream.Free;
  end;

end;

procedure TFrmPrincipal.NewImagemMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
begin
  if NewCircle.Tag = 1 then
  begin
     if WheelDelta < 0 then // Rolar para trás diminui
    begin
      NewCircle.Width  := NewCircle.Width - 3;
      NewCircle.Height := NewCircle.Height - 3;
    end
    else if WheelDelta > 0 then // Rolar para frente aumenta
    begin
      NewCircle.Width  := NewCircle.Width + 3;
      NewCircle.Height := NewCircle.Height + 3;
    end;
  end
  else //Se não estiver em modo de edição cai fora
    Exit;
end;

procedure TFrmPrincipal.SetidUsuario(const Value: Integer);
begin
  FidUsuario := Value;
end;

procedure TFrmPrincipal.TrackBar1Change(Sender: TObject);
begin
  Image4.Opacity    := TrackBar1.Value / TrackBar1.Max;
  if Assigned(NewImagem) then
    NewImagem.Opacity := TrackBar1.Value / TrackBar1.Max;
end;

procedure TFrmPrincipal.Layout1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if (Circle1.Tag = 1) and (MoveObjeto) and (ssLeft In Shift) then
  begin
    Circle1.Position.X := X - OffSet.X;
    Circle1.Position.Y := Y - OffSet.Y;
  end;
  if Assigned(NewCircle) then
  begin
    if (NewCircle.Tag = 1) and (MoveObjeto) and (ssLeft In Shift) then
    begin
      NewCircle.Position.X := X - OffSet.X;
      NewCircle.Position.Y := Y - OffSet.Y;
    end;
  end;
end;

procedure TFrmPrincipal.LogOffExecute(Sender: TObject);
var
  AppPath: string;
  Confirmation: Integer;
begin
  // Salve o caminho completo do aplicativo atual
  AppPath := ParamStr(0);

  // Exiba uma caixa de diálogo de confirmação
  Confirmation := MessageDlg('Deseja reiniciar a aplicação?', mtConfirmation, [mbYes, mbNo], 0);

  // Verifique a resposta do usuário
  if Confirmation = mrYes then
  begin
    // Encerre a aplicação atual
    Application.Terminate;

    // Execute o aplicativo novamente
    ShellExecute(0, 'open', PChar(AppPath), nil, nil, SW_SHOW);
  end;

end;

procedure TFrmPrincipal.MediaReceiverManagerRequestManagerPassword(
  const Sender: TObject; const ARemoteIdentifier: string; var Password: string);
begin
  Password := '1234';
end;

procedure TFrmPrincipal.MediaReceiverProfileResourceReceived(
  const Sender: TObject; const AResource: TRemoteResource);
begin
  Image1.Bitmap.LoadFromStream(AResource.Value.AsStream);
end;

procedure TFrmPrincipal.MenuItem10Click(Sender: TObject);
begin
// if not Assigned(FrmRegistrar) then
//  begin
    Application.CreateForm(TFrmOrcamentos, FrmOrcamentos);
    FrmOrcamentos.ShowModal;
//  end;
end;

procedure TFrmPrincipal.MenuItem11Click(Sender: TObject);
begin
//  if not Assigned(FrmFabricantes) then
//  begin
    Application.CreateForm(TFrmFabricantes, FrmFabricantes);
    FrmFabricantes.ShowModal;
//  end;
end;

procedure TFrmPrincipal.MenuItem12Click(Sender: TObject);
begin
//  if not Assigned(FrmProdutos) then
//  begin
//    Application.CreateForm(TFrmProdutos, FrmProdutos);
//    FrmProdutos.ShowModal;
//  end;
end;

procedure TFrmPrincipal.MenuItem14Click(Sender: TObject);
begin //O nome do arquivo será: Config.ini dentro do diretório do sistema
//  if not Assigned(FrmConfig) then
//  begin
    Application.CreateForm(TFrmConfig, FrmConfig);
    FrmConfig.ShowModal;
//  end;
end;

procedure TFrmPrincipal.MenuItem15Click(Sender: TObject);
begin
//  if not Assigned(FrmRegistrar) then
//  begin
    Application.CreateForm(TFrmRegistrar, FrmRegistrar);
    FrmRegistrar.ShowModal;
//  end;
end;

procedure TFrmPrincipal.MenuItem16Click(Sender: TObject);
begin
  keybd_event(VK_MENU, MapVirtualKey(VK_MENU, 0), 0, 0); // Pressiona a tecla Alt
  keybd_event(VK_SNAPSHOT, MapVirtualKey(VK_SNAPSHOT, 0), 0, 0); // Pressiona a tecla Print Screen
  keybd_event(VK_SNAPSHOT, MapVirtualKey(VK_SNAPSHOT, 0), KEYEVENTF_KEYUP, 0); // Libera a tecla Print Screen
  keybd_event(VK_MENU, MapVirtualKey(VK_MENU, 0), KEYEVENTF_KEYUP, 0); // Libera a tecla Alt
end;

procedure TFrmPrincipal.MenuItem18Click(Sender: TObject);
begin
  if not Assigned(FrmCadastroVeiculos) then
  begin
    try
      Application.CreateForm(TFrmCadastroVeiculos, FrmCadastroVeiculos);
      FrmCadastroVeiculos.ShowModal;
    finally
      FreeAndNil(FrmCadastroVeiculos);
    end;
  end;
end;

procedure TFrmPrincipal.MenuItem1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCategorias, FrmCategorias);
  FrmCategorias.ShowModal;
end;

procedure TFrmPrincipal.MenuItem8Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroClientes, FrmCadastroClientes);
  FrmCadastroClientes.ShowModal;
end;

procedure TFrmPrincipal.MenuItem9Click(Sender: TObject);
begin
   if not Assigned(FrmRegistrar) then
  begin
    Application.CreateForm(TFrmCadastroVeiculos, FrmCadastroVeiculos);
    FrmCadastroVeiculos.ShowModal;
  end;
end;

procedure TFrmPrincipal.Modo_Edicao(editar: Boolean);
begin
  With FrmPrincipal do
  begin
    if editar then
    begin
      circle1.Stroke.Color := $000000;//$FFFFFFFF; //Branco
      circle1.Stroke.Dash  := TStrokeDash.Dash; //traços
      circle1.Tag:= 1; //indica Sim Modo Edição
      circle1.Opacity:= 0.7;
    end
    else
    begin
      circle1.Stroke.Color := $000000;//$FFFD5872; //vermelho
      circle1.Stroke.Dash  := TStrokeDash.Solid;// linha sólida
      circle1.Tag:= 0; //indica não modo deedição
      circle1.Opacity:= 1;
    end;
  end;
end;

procedure TFrmPrincipal.Modo_Edicao2(editar: Boolean);
begin
  With FrmPrincipal do
  begin
    if Assigned(NewCircle) then
    begin
      if editar then
      begin
        Newcircle.Stroke.Color := $000000;//$FFFFFFFF; //Branco
        Newcircle.Stroke.Dash  := TStrokeDash.Dash; //traços
        Newcircle.Tag:= 1; //indica Sim Modo Edição
        Newcircle.Opacity:= 0.7;
      end
      else
      begin
        Newcircle.Stroke.Color := $000000;//$FFFD5872; //vermelho
        NewCircle.Stroke.Dash  := TStrokeDash.Solid;// linha sólida
        NewCircle.Tag:= 0; //indica não modo de edição
        NewCircle.Opacity:= 1;
      end;
    end;
  end;

end;

procedure TFrmPrincipal.NewImagemClick(Sender: TObject);
begin
//  if MoveObjeto then
//    Modo_Edicao(False);
end;

procedure TFrmPrincipal.NewImagemDbClick(Sender: TObject);
begin
  NewCircle.Width  := NewCircle.Width + 1;
  NewCircle.Height := NewCircle.Height + 1;
end;

procedure TFrmPrincipal.NewImagemGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
   if EventInfo.GestureID = igiLongTap then
    Modo_Edicao2(true);

  if EventInfo.GestureID = igiDoubleTap then
    Modo_Edicao2(False);
end;

procedure TFrmPrincipal.NewImagemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  //Seta o Layout para capturar o mouse
  if Newcircle.Tag = 1 then
    layout1.Root.Captured := layout1;

  //Indica que o objeto pode se mover
  MoveObjeto:= True;

  OffSet.X := X;
  OffSet.Y := Y;

  //Windows: Botão direito muda o modoedição...
  if Button = TMouseButton.mbRight then
  begin
    Modo_Edicao2(NOT NewCircle.Tag.ToBoolean);
    if MoveObjeto then   //Desabilita a Edição da Matrix quando a Roda 2 entra em edição
    Modo_Edicao(False);
  end;

  if Button = TMouseButton.mbMiddle then
  begin
    NewCircle.Width  := NewCircle.Width - 1;
    NewCircle.Height := NewCircle.Height - 1;
  end;

end;

procedure TFrmPrincipal.NewImagemMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  MoveObjeto:= False;
end;

end.
