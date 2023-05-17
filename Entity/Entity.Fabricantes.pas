unit Entity.Fabricantes;

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
  FMX.Dialogs,
  Datasnap.DBClient;

type
  TFabricante = class
    private
      FConn: TFDConnection;
      Fcnpj: string;
      FBairro: string;
      Fativo: string;
      FUF: string;
      FCEP: string;
      Fnumero: integer;
      Frazaosocial: string;
      Fcomplemento: string;
      FCidade: string;
      Fidfabricantes: Integer;
      Fendereco: string;
      procedure Setativo(const Value: string);
      procedure SetBairro(const Value: string);
      procedure SetCEP(const Value: string);
      procedure SetCidade(const Value: string);
      procedure Setcnpj(const Value: string);
      procedure Setcomplemento(const Value: string);
      procedure Setendereco(const Value: string);
      procedure Setidfabricantes(const Value: Integer);
      procedure Setnumero(const Value: integer);
      procedure Setrazaosocial(const Value: string);
      procedure SetUF(const Value: string);
    public
      property idfabricantes: Integer read Fidfabricantes write Setidfabricantes;
      property razaosocial: string read Frazaosocial write Setrazaosocial;
      property cnpj: string read Fcnpj write Setcnpj;
      property endereco: string read Fendereco write Setendereco;
      property numero: integer read Fnumero write Setnumero;
      property complemento: string read Fcomplemento write Setcomplemento;
      property CEP: string read FCEP write SetCEP;
      property Cidade: string read FCidade write SetCidade;
      property Bairro: string read FBairro write SetBairro;
      property UF: string read FUF write SetUF;
      property ativo: string read Fativo write Setativo;

      constructor create;
      destructor destroy;override;

  end;

implementation

{ TFabricante }

constructor TFabricante.create;
begin
  FConn:= TConnection.CreateConnection;
end;

destructor TFabricante.destroy;
begin
  FConn.Free;
  inherited;
end;

procedure TFabricante.Setativo(const Value: string);
begin
  Fativo := Value;
end;

procedure TFabricante.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TFabricante.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TFabricante.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TFabricante.Setcnpj(const Value: string);
begin
  Fcnpj := Value;
end;

procedure TFabricante.Setcomplemento(const Value: string);
begin
  Fcomplemento := Value;
end;

procedure TFabricante.Setendereco(const Value: string);
begin
  Fendereco := Value;
end;

procedure TFabricante.Setidfabricantes(const Value: Integer);
begin
  Fidfabricantes := Value;
end;

procedure TFabricante.Setnumero(const Value: integer);
begin
  Fnumero := Value;
end;

procedure TFabricante.Setrazaosocial(const Value: string);
begin
  Frazaosocial := Value;
end;

procedure TFabricante.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
