unit Entity.Categorias;

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
  TCategorias = class
    private
    Fidfabricante: integer;
    Fativo: string;
    Fcategoria: string;
    Ffabricante: string;
    Fidcategorias: integer;
    Fdataexclusao: TDatetime;
    Fdataalteracao: TDateTime;
    Fdatacadastro: TDateTime;
    procedure Setativo(const Value: string);
    procedure Setcategoria(const Value: string);
    procedure Setfabricante(const Value: string);
    procedure Setidcategorias(const Value: integer);
    procedure Setidfabricante(const Value: integer);
    procedure Setdataalteracao(const Value: TDateTime);
    procedure Setdatacadastro(const Value: TDateTime);
    procedure Setdataexclusao(const Value: TDatetime);

    public
      FConn: TFDConnection;
      property idcategorias : integer read Fidcategorias write Setidcategorias;
      property categoria    : string read Fcategoria write Setcategoria;
      property idfabricante : integer read Fidfabricante write Setidfabricante;
      property fabricante   : string read Ffabricante write Setfabricante;
      property ativo        : string read Fativo write Setativo;
      property datacadastro : TDateTime read Fdatacadastro write Setdatacadastro;
      property dataalteracao : TDateTime read Fdataalteracao write Setdataalteracao;
      property dataexclusao  : TDatetime read Fdataexclusao write Setdataexclusao;

      constructor create;
      destructor destroy;override;

  end;

implementation

{ TCategorias }

constructor TCategorias.create;
begin
  FConn:= TConnection.CreateConnection;
end;

destructor TCategorias.destroy;
begin
  FConn.Free;
  inherited;
end;

procedure TCategorias.Setativo(const Value: string);
begin
  Fativo := Value;
end;

procedure TCategorias.Setcategoria(const Value: string);
begin
  Fcategoria := Value;
end;

procedure TCategorias.Setdataalteracao(const Value: TDateTime);
begin
  Fdataalteracao := Value;
end;

procedure TCategorias.Setdatacadastro(const Value: TDateTime);
begin
  Fdatacadastro := Value;
end;

procedure TCategorias.Setdataexclusao(const Value: TDatetime);
begin
  Fdataexclusao := Value;
end;

procedure TCategorias.Setfabricante(const Value: string);
begin
  Ffabricante := Value;
end;

procedure TCategorias.Setidcategorias(const Value: integer);
begin
  Fidcategorias := Value;
end;

procedure TCategorias.Setidfabricante(const Value: integer);
begin
  Fidfabricante := Value;
end;

end.
