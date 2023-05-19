unit Login;

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
  FMX.StdCtrls,
  FMX.Edit,
  FMX.Objects,
  FMX.Controls.Presentation,
  Dao.Conexao,
  Dao.Login,
  UPrincipal,
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
  FMX.Layouts,
  FMX.Effects,
  System.UIConsts;

type
  TFrmLogin = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Rectangle1: TRectangle;
    Image1: TImage;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    Label1: TLabel;
    EdtUsuario: TEdit;
    Label2: TLabel;
    EdtSenha: TEdit;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    ShadowEffect7: TShadowEffect;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FConexao: TFDConnection;
  public
    { Public declarations }
    procedure CarregarCores;
    constructor create;
    destructor destroy; override;
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

procedure TFrmLogin.Button1Click(Sender: TObject);
Var
  Login: TLogin;
begin

  Login := TLogin.Create;
  try
    if Login.Login(EdtUsuario.Text, EdtSenha.Text) then
    begin
      FrmLogin.CloseModal;
      FrmPrincipal.ShowModal;
    end
    else
    begin
      ShowMessage('usuario ou senha não encontrado');
      EdtUsuario.SetFocus;
    end;
  finally
    Login.Free;
  end;

end;

procedure TFrmLogin.Button2Click(Sender: TObject);
begin
  FrmPrincipal.Close;
end;

procedure TFrmLogin.CarregarCores;
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

  for var I := 0 to FrmLogin.ComponentCount - 1 do
  begin
    if FrmLogin.Components[I] is TRectangle then
      TRectangle(FrmLogin.Components[I]).Fill.Color := Cor;
  end;

end;

constructor TFrmLogin.create;
begin
  FConexao := TConnection.CreateConnection;
end;

destructor TFrmLogin.destroy;
begin
  FConexao.Free;
  inherited;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  CarregarCores;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  if EdtUsuario.CanFocus then
    EdtUsuario.SetFocus;
end;

end.
