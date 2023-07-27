unit Entity.Produtos;

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
  TPRoduto = class
    private
      FConn: TFDConnection;
      Ffuracao: integer;
      Fproduto: string;
      Fidlinha: integer;
      Fidfabricante: integer;
      Faro: Integer;
      Fidprodutos: integer;
      FOffsetEt: integer;
      Fativo: string;
      Fpreco: currency;
      Fdataexclusao: TDateTime;
      Fdataalteracao: TDatetime;
      Ffoto: TStream;   // Utilize TStream ou TObjectList<TByte> para armazenar dados binários (BLOB) da imagem
      Fidacabamento: integer;
      Fdatainclusao: TDateTime;
      Flancamento: string;
    procedure Setaro(const Value: Integer);
    procedure Setativo(const Value: string);
    procedure Setdataalteracao(const Value: TDatetime);
    procedure Setdataexclusao(const Value: TDateTime);
    procedure Setdatainclusao(const Value: TDateTime);
    procedure Setfoto(const Value: TStream);
    procedure Setfuracao(const Value: integer);
    procedure Setidacabamento(const Value: integer);
    procedure Setidfabricante(const Value: integer);
    procedure Setidlinha(const Value: integer);
    procedure Setidprodutos(const Value: integer);
    procedure Setlancamento(const Value: string);
    procedure SetOffsetEt(const Value: integer);
    procedure Setpreco(const Value: currency);
    procedure Setproduto(const Value: string);

    procedure SetFotoData(const AData: TBytes);
    function GetFotoData: TBytes;

    public
      property idprodutos   : integer read Fidprodutos write Setidprodutos;
      property produto      : string read Fproduto write Setproduto;
      property foto         : TStream read Ffoto write Setfoto;
      property preco        : currency read Fpreco write Setpreco;
      property aro          : Integer read Faro write Setaro;
      property idfabricante : integer read Fidfabricante write Setidfabricante;
      property datainclusao : TDateTime read Fdatainclusao write Setdatainclusao;
      property dataalteracao: TDatetime read Fdataalteracao write Setdataalteracao;
      property dataexclusao : TDateTime read Fdataexclusao write Setdataexclusao;
      property ativo        : string read Fativo write Setativo;
      property lancamento   : string read Flancamento write Setlancamento;
      property furacao      : integer read Ffuracao write Setfuracao;
      property OffsetEt     : integer read FOffsetEt write SetOffsetEt;
      property idlinha      : integer read Fidlinha write Setidlinha;
      property idacabamento : integer read Fidacabamento write Setidacabamento;

      constructor create;
      destructor destroy;override;


  end;

implementation

{ TPRoduto }

constructor TPRoduto.create;
begin
  FConn:= TConnection.CreateConnection;
  FFoto := TMemoryStream.Create;
end;

destructor TPRoduto.destroy;
begin
   FConn.Free;
   FFoto.Free;
  inherited;
end;

function TPRoduto.GetFotoData: TBytes;
begin
  // Salvar os dados atuais da imagem em um array de bytes.
  SetLength(Result, FFoto.Size);
  if FFoto.Size > 0 then
    FFoto.Position := 0;
    FFoto.ReadBuffer(Result[0], FFoto.Size);
end;

procedure TPRoduto.Setaro(const Value: Integer);
begin
  Faro := Value;
end;

procedure TPRoduto.Setativo(const Value: string);
begin
  Fativo := Value;
end;

procedure TPRoduto.Setdataalteracao(const Value: TDatetime);
begin
  Fdataalteracao := Value;
end;

procedure TPRoduto.Setdataexclusao(const Value: TDateTime);
begin
  Fdataexclusao := Value;
end;

procedure TPRoduto.Setdatainclusao(const Value: TDateTime);
begin
  Fdatainclusao := Value;
end;

procedure TPRoduto.Setfoto(const Value: TStream);
begin
  Ffoto := Value;
end;

procedure TPRoduto.SetFotoData(const AData: TBytes);
begin
  // Limpar os dados atuais da imagem antes de definir novos dados.
  FFoto.Size := 0;
  FFoto.Position := 0;

  // Escrever os novos dados da imagem no stream.
  if Length(AData) > 0 then
    FFoto.WriteBuffer(AData[0], Length(AData));
end;

procedure TPRoduto.Setfuracao(const Value: integer);
begin
  Ffuracao := Value;
end;

procedure TPRoduto.Setidacabamento(const Value: integer);
begin
  Fidacabamento := Value;
end;

procedure TPRoduto.Setidfabricante(const Value: integer);
begin
  Fidfabricante := Value;
end;

procedure TPRoduto.Setidlinha(const Value: integer);
begin
  Fidlinha := Value;
end;

procedure TPRoduto.Setidprodutos(const Value: integer);
begin
  Fidprodutos := Value;
end;

procedure TPRoduto.Setlancamento(const Value: string);
begin
  Flancamento := Value;
end;

procedure TPRoduto.SetOffsetEt(const Value: integer);
begin
  FOffsetEt := Value;
end;

procedure TPRoduto.Setpreco(const Value: currency);
begin
  Fpreco := Value;
end;

procedure TPRoduto.Setproduto(const Value: string);
begin
  Fproduto := Value;
end;

end.
