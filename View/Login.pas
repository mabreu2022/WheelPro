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
  FireDAC.Comp.UI;

type
  TFrmLogin = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    EdtUsuario: TEdit;
    EdtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FConexao: TFDConnection;
  public
    { Public declarations }
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
      FrmPrincipal.ShowModal;
      FrmLogin.Close;
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
  EdtUsuario.Text:= '';
  EdtSenha.Text:='';
  EdtUsuario.SetFocus;
end;

constructor TFrmLogin.create;
begin
  FConexao := TConnection.CreateConnection;
end;

destructor TFrmLogin.destroy;
begin

  inherited;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  if EdtUsuario.CanFocus then
    EdtUsuario.SetFocus;
end;

end.
