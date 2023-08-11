unit Dao.Conexao;

interface

uses
  System.SysUtils,
  System.Classes,
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
  FireDAC.Phys.MySQL,
  Funcoes.Criptografia;

type
  TConnection = class
  private

  public
    class procedure CarregarConfig(Connection: TFDconnection);
    class function  CreateConnection: TFDConnection;

  end;


implementation

{ TConnection }

class function TConnection.CreateConnection: TFDConnection;
var
  FConn: TFDConnection;
begin
  FConn := TFDConnection.Create(nil);
  CarregarConfig(FConn);
  Result := FConn;
end;

class procedure TConnection.CarregarConfig(Connection: TFDconnection);
var
  ini: TIniFile;
  FDPhysDriverLink: TFDPhysDriverLink;
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
   ini := TIniFile.Create(ExtractFileDir(ParamStr(0)) + '\Server.ini');
   Funcao  := TCriptografia.Create;
   try

     Connection.DriverName := ini.ReadString('Banco de Dados', 'DriverID', '');

     with Connection.Params do
     begin
       Clear;
       EncryptedServer   := ini.ReadString('Banco de Dados', 'Server' , '');
       EncryptedPassword := ini.ReadString('Banco de Dados', 'DataBase', '');
       EncryptedDataBase := ini.ReadString('Banco de Dados', 'User_Name', '');
       EncryptedUserName := ini.ReadString('Banco de Dados', 'Password', '');

       Add('DriverID='  + ini.ReadString('Banco de Dados', 'DriverID' , ''));
       Add('DataBase='  + Funcao.DecryptString(ini.ReadString('Banco de Dados', 'DataBase', ''),123));
       Add('User_Name=' + Funcao.DecryptString(ini.ReadString('Banco de Dados', 'User_Name', ''),123));
       Add('PassWord='  + Funcao.DecryptString(ini.ReadString('Banco de Dados', 'Password', ''),123));
       //Add('Initial Catalog' + ini.ReadString('Banco de Dados', 'Initial Catalog',''));
       //Add('Extended Properties="' + ini.ReadString('Banco de Dados', 'Extended Properties', '') + '"');
       Add('Protocol=TCPIP');

       if Funcao.DecryptString(ini.ReadString('Banco de Dados' , 'Server' , '') ,123)<> '' then
         Add('Server=' + Funcao.DecryptString(ini.ReadString('Banco de Dados', 'Server', ''),123));

       if ini.ReadString('Banco de Dados', 'Port', '') <> '' then
         Add('Port=' + ini.ReadString('Banco de Dados', 'Port', ''));

       FDPhysDriverLink:= TFDPhysDriverLink.Create(nil);

       if ini.ReadString('Banco de Dados', 'VendorLib' , '') <> '' then
          FDPhysDriverLink.VendorLib := ini.ReadString('Banco de Dados', 'VendorLib', '');

     end;

     try
        Connection.Connected := True;
     Except on ex:exception do
       raise Exception.Create('Error ao acessar o banco de dados: ' + ex.Message);
     end;

   finally
     if Assigned(ini) then
       ini.DisposeOf;
     FDPhysDriverLink.Free;
     Funcao.Free;
   end;
end;



end.
