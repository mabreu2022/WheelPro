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
  end;


end;

procedure TLogin.Setidusuario(const Value: Integer);
begin
  Fidusuario := Value;
end;

end.
