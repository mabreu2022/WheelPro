unit Entity.Contatos;

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
  Datasnap.DBClient,
  LogManager;

type
  TContato = class
    private
    Femail: string;
    Fidcontato: Integer;
    Fativo: string;
    FdataAlteracao: TDateTime;
    FdataCadastro: TDatetime;
    FNome: String;
    Ftelefone: string;
    FdataExclusao: TDateTime;
    Fidcliente: integer;
    Fcelular: string;
    Fcnpjrevenda: string;
    FConn: TFDConnection;
    LogManager : TLogManager;
    procedure Setativo(const Value: string);
    procedure SetdataAlteracao(const Value: TDateTime);
    procedure SetdataCadastro(const Value: TDatetime);
    procedure Setemail(const Value: string);
    procedure Setidcontato(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure Settelefone(const Value: string);
    procedure SetdataExclusao(const Value: TDateTime);
    procedure Setidcliente(const Value: integer);
    procedure Setcelular(const Value: string);
    procedure Setcnpjrevenda(const Value: string);

    public
      property idcontato: Integer read Fidcontato write Setidcontato;
      property idcliente: integer read Fidcliente write Setidcliente;
      property Nome: String read FNome write SetNome;
      property telefone: string read Ftelefone write Settelefone;
      property celular: string read Fcelular write Setcelular;
      property email:string read Femail write Setemail;
      property cnpjrevenda: string read Fcnpjrevenda write Setcnpjrevenda;
      property ativo: string read Fativo write Setativo;
      property dataCadastro: TDatetime read FdataCadastro write SetdataCadastro;
      property dataAlteracao: TDateTime read FdataAlteracao write SetdataAlteracao;
      property dataExclusao: TDateTime read FdataExclusao write SetdataExclusao;

      constructor create;
      destructor destroy;override;
  end;

implementation

{ TContato }

constructor TContato.create;
begin
  LogManager := TLogManager.Create;
  LogManager.SaveLogToFile('Log_Entity_Contatos.txt');
  LogManager.AddLog('Entrou na Entity_Contatos - Create: Linha 83: e Criou FConn.');
  LogManager.SaveLogToFile('Log_Entity_Contatos.txt');
  FConn := TConnection.CreateConnection;
end;

destructor TContato.destroy;
begin
  FConn.Free;
  LogManager.Free;
  inherited;
end;

procedure TContato.Setativo(const Value: string);
begin
  Fativo := Value;
end;

procedure TContato.Setcelular(const Value: string);
begin
  Fcelular := Value;
end;

procedure TContato.Setcnpjrevenda(const Value: string);
begin
  Fcnpjrevenda := Value;
end;

procedure TContato.SetdataAlteracao(const Value: TDateTime);
begin
  FdataAlteracao := Value;
end;

procedure TContato.SetdataCadastro(const Value: TDatetime);
begin
  FdataCadastro := Value;
end;

procedure TContato.SetdataExclusao(const Value: TDateTime);
begin
  FdataExclusao := Value;
end;

procedure TContato.Setemail(const Value: string);
begin
  Femail := Value;
end;

procedure TContato.Setidcliente(const Value: integer);
begin
  Fidcliente := Value;
end;

procedure TContato.Setidcontato(const Value: Integer);
begin
  Fidcontato := Value;
end;

procedure TContato.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TContato.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

end.
