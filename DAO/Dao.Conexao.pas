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
  FireDAC.Phys.MySQL;

type
  TConnection = class
  private

  public

    class procedure CarregarConfig(Connection: TFDconnection);
    class function  CreateConnection: TFDConnection;

  end;

//  const
//    ARQ_INI = 'C:\Fontes\ProjetoRodas3\Win32\Debug\Server.ini'; //Compilar para testes de programação
    //ARQ_INI = 'C:\Program Files (x86)\WheelPro\Server.Ini'; //Compilar para Cliente final/Maquina da mesma rede


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

begin
   try
     ini := TIniFile.Create(ExtractFileDir(ParamStr(0)) + '\Server.ini');//TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Server.ini');//TIniFile.Create(ARQ_INI);
     Connection.DriverName := ini.ReadString('Banco de Dados', 'DriverID', '');

     with Connection.Params do
     begin
       Clear;
       Add('DriverID='  + ini.ReadString('Banco de Dados', 'DriverID' , ''));
       Add('DataBase='  + ini.ReadString('Banco de Dados', 'DataBase', ''));
       Add('User_Name=' + ini.ReadString('Banco de Dados', 'User_Name', ''));
       Add('PassWord='  + ini.ReadString('Banco de Dados', 'Password', ''));
       //Add('Initial Catalog' + ini.ReadString('Banco de Dados', 'Initial Catalog',''));
       //Add('Extended Properties="' + ini.ReadString('Banco de Dados', 'Extended Properties', '') + '"');
       Add('Protocol=TCPIP');

       if ini.ReadString('Banco de Dados' , 'Server' , '') <> '' then
         Add('Server=' + ini.ReadString('Banco de Dados', 'Server', ''));

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
     //if Assigned(ini) then
           ini.DisposeOf;
     FDPhysDriverLink.Free;
   end;
end;



end.
