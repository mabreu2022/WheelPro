unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Funcoes.Criptografia, inifiles;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    BtnEncriptar: TButton;
    BtnDesincriptar: TButton;
    TabSheet1: TTabSheet;
    EdtServer: TEdit;
    EdtDataBase: TEdit;
    EdtUserName: TEdit;
    EdtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    Edt1: TEdit;
    Label6: TLabel;
    Edt2: TEdit;
    Label7: TLabel;
    Edt3: TEdit;
    Label8: TLabel;
    Edt4: TEdit;
    procedure BtnEncriptarClick(Sender: TObject);
    procedure BtnDesincriptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarEdits;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnDesincriptarClick(Sender: TObject);
begin
  CarregarEdits;
end;

procedure TForm1.BtnEncriptarClick(Sender: TObject);
var
  IniFile: TIniFile;
  EncryptedServer   : string;
  EncryptedPassword : string;
  EncryptedDataBase : string;
  EncryptedUserName : string;
  Funcoes: TCriptografia;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Server.ini');
  Funcoes:= TCriptografia.Create;
  try
     EncryptedServer   := Funcoes.EncryptString(EdtServer.Text, 123);
     EncryptedPassword := Funcoes.EncryptString(EdtPassword.Text, 123);
     EncryptedDataBase := Funcoes.EncryptString(EdtDataBase.Text,123);
     EncryptedUserName := Funcoes.EncryptString(EdtUserName.Text,123);

     IniFile.WriteString('Banco de Dados', 'Server', EncryptedServer);
     IniFile.WriteString('Banco de Dados', 'Password', EncryptedPassword);
     IniFile.WriteString('Banco de Dados', 'Database', EncryptedDataBase);
     IniFile.WriteString('Banco de Dados', 'User_Name', EncryptedUserName);

     Edt1.Text := EncryptedServer;
     Edt2.Text := EncryptedPassword;
     Edt3.Text := EncryptedDataBase;
     Edt4.Text := EncryptedUserName;

     inifile.UpdateFile;

  finally
    IniFile.Free;
    Funcoes.Free;
  end;

end;

procedure TForm1.CarregarEdits;
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

    // Use os valores descriptografados conforme necessário
    EdtServer.Text   := DecryptedServer;
    EdtPassword.Text := DecryptedPassword;
    EdtDataBase.Text := DescryptedDataBase;
    EdtUserName.Text := DescryptedUserName;

  finally
    IniFile.Free;
    Funcao.Free;
  end;

end;

end.
