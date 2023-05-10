unit Model.Clientes;

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
  Dao.Clientes,
  FireDAC.Comp.Client;

type
  TRegrasDeNegocio = class
    private

    public
      class function TestaseTemEndereco(aCliente: TClientes): Boolean;
      class function ClientejaExiste(aCNPJ: String): Boolean;

  end;


implementation

{ TRegrasDeNegocio }

class function TRegrasDeNegocio.ClientejaExiste(aCNPJ: String): Boolean;
var
  Cliente: TClientes;
begin
  Cliente:= TClientes.create;
  try
    Cliente.ClienteExiste(aCNPJ);
  finally
    Cliente.Free;
  end;
end;

class function TRegrasDeNegocio.TestaseTemEndereco(aCliente: TClientes): Boolean;
begin
  Result:=False;

  if aCliente.CEP.Length < 8  then
  begin
    raise Exception.Create('O CEP n�o pode ser menor que 8 caracteres.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.CEP) ='' then
  begin
    raise Exception.Create('O CEP n�o pode vazio.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Endereco) = '' then
  begin
    raise Exception.Create('� necess�rio prencher o Endere�o.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.uf) = '' then
  begin
    raise Exception.Create('� necess�rio preencher a UF.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Cidade) = '' then
  begin
    raise Exception.Create('� necess�rio preencher a Cidade.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Bairro) = '' then
  begin
    raise Exception.Create('� necess�rio preencher o Bairro.');
    Result:= False;
    exit;
  end;

  //Testar se o cliente j� existe no Cadastro e n�o deixar incluir se sim.


  Result:= True;
end;

end.
