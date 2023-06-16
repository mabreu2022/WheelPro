unit Dao.Login;

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
  FireDAC.DApt,
  Dao.Conexao,
  DAO.ConexaoLicencas,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  FMX.Forms;

type
  TLogin = class
    private

    procedure Setidusuario(const Value: Integer);

    public
      Fidusuario: Integer;
      class function Login(aUsuario: string; aSenha: string):Boolean;
      class function PesquisaCNPJ(aUsuario: string; aSenha: string): String;
      property idusuario: Integer read Fidusuario write Setidusuario;
      
  end;

implementation

uses
   uPrincipal;

{ TLogin }

class function TLogin.Login(aUsuario, aSenha: string): Boolean;
var
  FConexao   : TFDConnection;
  FDQuery1   : TFDQuery;
  FidUsuario : Integer;
begin

  FConexao            := TConnection.CreateConnection;
  FDQuery1            := TFDQuery.Create(nil);
  FDQuery1.Connection := FConexao;

  try

    FDQuery1.Active:= False;
    FDQuery1.SQL.Clear;
    FDQuery1.SQL.Add('SELECT * FROM LOGIN');
    FDQuery1.SQL.Add('WHERE USUARIO=:USUARIO');
    FDQuery1.SQL.Add('  AND SENHA=:SENHA');
    FDQuery1.ParamByName('USUARIO').DataType := ftString;
    FDQuery1.ParamByName('USUARIO').Value    := aUsuario;
    FDQuery1.ParamByName('SENHA').DataType   := ftString;
    FDQuery1.ParamByName('SENHA').Value      := aSenha;
    FDQuery1.Active:= True;

    //Define o IDUsuario para os direitos de usuário
    FrmPrincipal.FidUsuario := FDQuery1.FieldByName('idlogin').AsInteger;


    if FDQuery1.RecordCount > 0 then
      Result:= True
    else
     Result:= False;
  finally
    FDQuery1.Free;
    FConexao.Free;
  end;


end;

class function TLogin.PesquisaCNPJ(aUsuario: string; aSenha: string): String;
var
  qry                : TFDQuery; //Fulano Rodas
  qry2               : TFDQuery; //Licencas
  IDCliente          : Integer;
  ConexaoLicencas    : TConexaoLicencas;
  ConexaoFulanoRodas : TFDConnection;
begin
  result := '';
  qry := TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('select idcliente from login');
    qry.SQL.Add(' where usuario = :usuario');
    qry.SQL.Add('   and senha = :senha');
    qry.ParamByName('usuario').AsString := aUsuario;
    qry.ParamByName('senha').AsString   := aSenha;
    qry.Open;

    if qry.RecordCount > 0 then
      IDCliente:= qry.FieldByName('idcliente').AsInteger;

    //Pesquisar o CNPJ
    qry2 := TFDQuery.Create(Nil);
    ConexaoLicencas:= TConexaoLicencas.Create;
    qry2.Connection := ConexaoLicencas.CreateConnection;
    try
      qry2.sql.clear;
      qry2.SQL.Add('Select cnpj from chaves');
      qry2.SQL.Add(' where id_chave=:id_chave');
      qry2.ParamByName('id_chave').AsInteger := IDCliente;
      qry2.Open;

      if qry2.RecordCount > 0 then
        Result:= qry2.FieldByName('cnpj').AsString;

    finally
      qry2.Free;
    end;

  finally
    qry.Free;
  end;
end;

procedure TLogin.Setidusuario(const Value: Integer);
begin
  Fidusuario := Value;
end;

end.
