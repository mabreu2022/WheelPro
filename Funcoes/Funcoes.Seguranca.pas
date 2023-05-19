unit Funcoes.Seguranca;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Hash,
  System.NetEncoding,
  System.IOUtils,
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
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL;


const
   ARQ_INI = 'C:\Fontes\ProjetoRodas3\Win32\Debug\Server.ini'; //Compilar para testes de programação
//      ARQ_INI = 'C:\Program Files (x86)\WheelPro\Server.Ini'; //Compilar para Cliente final/Maquina da mesma rede

   EncryptionKey = 'A1B2C3D4E5F6G7H8';

type
  TSeguranca = class
    private

    public
      class function Encrypt(const AValue: string): string;
      class function Decrypt(const AValue: string): string;
      class procedure SalvarConfig(Connection: TFDConnection);
  end;

implementation

{ TSeguranca }

class function TSeguranca.Decrypt(const AValue: string): string;
var
  Bytes: TBytes;
  KeyBytes: TBytes;
begin
  KeyBytes := TEncoding.UTF8.GetBytes(EncryptionKey);
  Bytes := TNetEncoding.Base64.DecodeStringToBytes(AValue);
  for var I := 0 to Length(Bytes) - 1 do
    Bytes[I] := Bytes[I] xor KeyBytes[I mod Length(KeyBytes)];
  Result := TEncoding.UTF8.GetString(Bytes);
end;

class function TSeguranca.Encrypt(const AValue: string): string;
var
  Bytes: TBytes;
  KeyBytes: TBytes;
begin
  KeyBytes := TEncoding.UTF8.GetBytes(EncryptionKey);
  Bytes := TEncoding.UTF8.GetBytes(AValue);
  for var I := 0 to Length(Bytes) - 1 do
    Bytes[I] := Bytes[I] xor KeyBytes[I mod Length(KeyBytes)];
  Result := TNetEncoding.Base64.EncodeBytesToString(Bytes);
end;

class procedure TSeguranca.SalvarConfig(Connection: TFDConnection);
var
  FileStream: TFileStream;
  StreamWriter: TStreamWriter;
  DriverID, Database, User_Name, Password, Server, Port: string;
begin
  try
    FileStream := TFileStream.Create(ARQ_INI, fmCreate);
    StreamWriter := TStreamWriter.Create(FileStream, TEncoding.UTF8);

    DriverID := Encrypt(Connection.DriverName);
    Database := Encrypt(Connection.Params.Values['Database']);
    User_Name := Encrypt(Connection.Params.Values['User_Name']);
    Password := Encrypt(Connection.Params.Values['Password']);
    Server := Encrypt(Connection.Params.Values['Server']);
    Port := Encrypt(Connection.Params.Values['Port']);

    StreamWriter.WriteLine('[Banco de Dados]');
    StreamWriter.WriteLine('DriverID=' + DriverID);
    StreamWriter.WriteLine('Database=' + Database);
    StreamWriter.WriteLine('User_Name=' + User_Name);
    StreamWriter.WriteLine('Password=' + Password);

    if Server <> '' then
      StreamWriter.WriteLine('Server=' + Server);

    if Port <> '' then
      StreamWriter.WriteLine('Port=' + Port);

  finally
    StreamWriter.Free;
    FileStream.Free;
  end;
end;

end.
