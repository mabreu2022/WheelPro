unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Funcoes.Criptografia, inifiles;

type
  TFrmPrincipal = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    BtnEncriptar: TButton;
    BtnDesincriptar: TButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdtDadosBancoServer: TEdit;
    EdtDadosBancoDataBase: TEdit;
    EdtDadosBancoUserName: TEdit;
    EdtDadosBancoPassword: TEdit;
    GroupBox4: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    EdtDadosLicenasServer: TEdit;
    EdtDadosLicenasDataBase: TEdit;
    EdtDadosLicencasUserName: TEdit;
    EdtDadosLicencasPassword: TEdit;
    Label16: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EdtEncryptadosBancoServer: TEdit;
    EdtEncryptadosBancoDataBase: TEdit;
    EdtEncryptadosBancoUserName: TEdit;
    EdtEncryptadosBancoPassword: TEdit;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    EdtEncryptadosBancoLicencasServer: TEdit;
    EdtEncryptadosBancoLicencasDataBase: TEdit;
    EdtEncryptadosBancoLicencasUserName: TEdit;
    EdtEncryptadosBancoLicencasPassword: TEdit;
    procedure BtnEncriptarClick(Sender: TObject);
    procedure BtnDesincriptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarEdits;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.BtnDesincriptarClick(Sender: TObject);
begin
  CarregarEdits;
end;

procedure TFrmPrincipal.BtnEncriptarClick(Sender: TObject);
var
  IniFile: TIniFile;
  EncryptedServer   : string;
  EncryptedPassword : string;
  EncryptedDataBase : string;
  EncryptedUserName : string;
  EncryptedServerLicencas   : string;
  EncryptedPasswordLicencas : string;
  EncryptedDataBaseLicencas : string;
  EncryptedUserNameLicencas : string;
  Funcoes: TCriptografia;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Server.ini');
  Funcoes:= TCriptografia.Create;
  try
     EncryptedServer   := Funcoes.EncryptString(EdtEncryptadosBancoServer.Text, 123);
     EncryptedPassword := Funcoes.EncryptString(EdtEncryptadosBancoPassword.Text, 123);
     EncryptedDataBase := Funcoes.EncryptString(EdtEncryptadosBancoDataBase.Text,123);
     EncryptedUserName := Funcoes.EncryptString(EdtEncryptadosBancoUserName.Text,123);

     EncryptedServerLicencas   := Funcoes.EncryptString(EdtEncryptadosBancoLicencasServer.Text,123);
     EncryptedPasswordLicencas := Funcoes.EncryptString(EdtEncryptadosBancoLicencasPassword.Text,123);
     EncryptedDataBaseLicencas := Funcoes.EncryptString(EdtEncryptadosBancoLicencasDataBase.Text,123);
     EncryptedUserNameLicencas := Funcoes.EncryptString(EdtEncryptadosBancoLicencasUserName.Text,123);

     //Escreve no arquivo ini
     IniFile.WriteString('Banco de Dados', 'Server', EncryptedServer);
     IniFile.WriteString('Banco de Dados', 'Password', EncryptedPassword);
     IniFile.WriteString('Banco de Dados', 'Database', EncryptedDataBase);
     IniFile.WriteString('Banco de Dados', 'User_Name', EncryptedUserName);

     IniFile.WriteString('BancoLicenas', 'Server',    EncryptedServerLicencas);
     IniFile.WriteString('BancoLicenas', 'Password',  EncryptedPasswordLicencas);
     IniFile.WriteString('BancoLicenas', 'Database',  EncryptedDataBaseLicencas);
     IniFile.WriteString('BancoLicenas', 'User_Name', EncryptedUserNameLicencas);

     //Preenche os Edits da Aba Encriptada - Banco
     EdtEncryptadosBancoServer.Text   := EncryptedServer;
     EdtEncryptadosBancoPassword.Text := EncryptedPassword;
     EdtEncryptadosBancoDataBase.Text := EncryptedDataBase;
     EdtEncryptadosBancoUserName.Text := EncryptedUserName;

     //Preenche os Edits da Aba Encriptada - Banco Licenças
     EdtEncryptadosBancoLicencasServer.Text   := EncryptedServerLicencas;
     EdtEncryptadosBancoLicencasPassword.Text := EncryptedPasswordLicencas;
     EdtEncryptadosBancoLicencasDataBase.Text := EncryptedDataBaseLicencas;
     EdtEncryptadosBancoLicencasUserName.Text := EncryptedUserNameLicencas;

     inifile.UpdateFile;

  finally
    IniFile.Free;
    Funcoes.Free;
  end;

end;

procedure TFrmPrincipal.CarregarEdits;
var
  IniFile: TIniFile;
  EncryptedServer    : string;
  DecryptedServer    : string;
  EncryptedPassword  : string;
  DecryptedPassword  : string;
  EncryptedDataBase  : string;
  DescryptedDataBase : string;
  EncryptedUserName  : string;
  DescryptedUserName : string;

  EncryptedServerLicencas    : string;
  DecryptedServerLicencas    : string;
  EncryptedPasswordLicencas  : string;
  DecryptedPasswordLicencas  : string;
  EncryptedDataBaseLicencas  : string;
  DescryptedDataBaseLicencas : string;
  EncryptedUserNameLicencas  : string;
  DescryptedUserNameLicencas : string;

  Funcao: TCriptografia;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Server.ini');
  Funcao  := TCriptografia.Create;
  try
    EncryptedServer   := IniFile.ReadString('Banco de Dados', 'Server', '');
    EncryptedPassword := IniFile.ReadString('Banco de Dados', 'Password', '');
    EncryptedDataBase := IniFile.ReadString('Banco de Dados', 'Database', '');
    EncryptedUserName := IniFile.ReadString('Banco de Dados', 'User_Name', '');

    DecryptedServer    := Funcao.DecryptString(EncryptedServer, 123);
    DecryptedPassword  := Funcao.DecryptString(EncryptedPassword, 123);
    DescryptedDataBase := Funcao.DecryptString(EncryptedDataBase, 123);
    DescryptedUserName := Funcao.DecryptString(EncryptedUserName, 123);

    EncryptedServerLicencas   := IniFile.ReadString('BancoLicencas', 'Server', '');
    EncryptedPasswordLicencas := IniFile.ReadString('BancoLicencas', 'Password', '');
    EncryptedDataBaseLicencas := IniFile.ReadString('BancoLicencas', 'Database', '');
    EncryptedUserNameLicencas := IniFile.ReadString('BancoLicencas', 'User_Name', '');

    DecryptedServerLicencas    := Funcao.DecryptString(EncryptedServer, 123);
    DecryptedPasswordLicencas  := Funcao.DecryptString(EncryptedPassword, 123);
    DescryptedDataBaseLicencas := Funcao.DecryptString(EncryptedDataBase, 123);
    DescryptedUserNameLicencas := Funcao.DecryptString(EncryptedUserName, 123);

    // Carregar Edits Aba Banco - GroupBox Banco
    EdtDadosBancoServer.Text   := DecryptedServer;
    EdtDadosBancoPassword.Text := DecryptedPassword;
    EdtDadosBancoDataBase.Text := DescryptedDataBase;
    EdtDadosBancoUserName.Text := DescryptedUserName;

    //Carregar Edits Aba Dados Encryptados - GroupBox Licenças
    EdtEncryptadosBancoLicencasServer.Text   := DecryptedServerLicencas;
    EdtEncryptadosBancoLicencasPassword.Text := DecryptedPasswordLicencas;
    EdtEncryptadosBancoLicencasDataBase.Text := DescryptedDataBaseLicencas;
    EdtEncryptadosBancoLicencasUserName.Text := DescryptedUserNameLicencas;

  finally
    IniFile.Free;
    Funcao.Free;
  end;

end;

end.
