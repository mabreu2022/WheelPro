unit Model.Contatos;

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
  FireDAC.Comp.Client,
  Data.DB,
  Entity.Clientes,
  System.Generics.Collections,
  Dao.Conexao,
  Datasnap.DBClient,
  Entity.Contatos;

type
  TModelContato = class
    private
      Fconn: TFDConnection;
      qry: TFDQuery;
      FSomenteAtivos: string;
    procedure SetSomenteAtivos(const Value: string);
    public
      FContatos: TContato;
      property SomenteAtivos: string read FSomenteAtivos write SetSomenteAtivos;
      //create
      Class function SalvarContato(aContato: TContato): Boolean;

      //Read
//      function CarregarClientes(const ACNPJ: String): TClientes;
//      function CarregarTodosClientes(
//  aDataSet: TClientDataSet; aSomenteAtivos: string): TFDquery; //ok
//      function ObterClientePorId(aId: Integer): TFDQuery;
//
//      //Update
//      class function AlterarCliente(aCliente: TClientes): Boolean;
//
//      //Delete
//      function RemoverCliente(aCliente: TClientes): Boolean;
//
//      //Regras
//      class function TestaSeCamposPreenchidos(aCliente: TClientes): Boolean;
//      class function ClienteExiste(aCNPJ: string):Boolean;
//
//      constructor Create;
//      destructor destroy;override;
  end;

implementation

{ TModelContato }

class function TModelContato.SalvarContato(aContato: TContato): Boolean;
var
  qry   : TFDQuery;
  Ativo : string;
  UF    : string;
begin
  Result:= False;

  qry:=TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  try

    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO '  +
                ' fulanorodas.contatos '    +
                '(idcontatos, ' +
                'idclientes, '  +
                'telefone, '    +
                'celular, '     +
                'email, '       +
                'cnpjrevenda, ' +
                'ativo) '       +
                'VALUES ('      +
                ':idcontatos, ' +
                ':idclientes, ' +
                ':telefone, '   +
                ':celular, '    +
                ':email, '      +
                ':cnpjrevenda, '+
                ':ativo) ');
     qry.ParamByName('idcontatos').DataType    := ftInteger;
     qry.ParamByName('idcontatos').AsInteger   := aContato.idcontato;
     qry.ParamByName('idclientes').DataType    := ftInteger;
     qry.ParamByName('idclientes').AsInteger   := aContato.idcliente;
     qry.ParamByName('telefone').DataType      := ftString;
     qry.ParamByName('telefone').AsString      := aContato.telefone;
     qry.ParamByName('celular').DataType       := ftString;
     qry.ParamByName('celular').AsString       := aContato.celular ;
     qry.ParamByName('email').DataType         := ftString;
     qry.ParamByName('email').AsString         := aContato.email;
     qry.ParamByName('cnpjrevenda').DataType   := ftString;
     qry.ParamByName('cnpjrevenda').AsString   := aContato.cnpjrevenda;

     qry.ParamByName('ativo').DataType         := ftString;
     if Length(aContato.ativo) > 0 then
       Ativo := Copy(aContato.ativo, 1, 1)
     else
       Ativo := '';

     qry.ParamByName('ativo').AsString         := Ativo;

     qry.ExecSQL;
     qry.Connection.Commit;

     Result:=True;

  finally
    qry.Close;
    qry.Free;
  end;


end;

procedure TModelContato.SetSomenteAtivos(const Value: string);
begin
  FSomenteAtivos := Value;
end;

end.
