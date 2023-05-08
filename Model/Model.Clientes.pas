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

  end;


implementation

{ TRegrasDeNegocio }

class function TRegrasDeNegocio.TestaseTemEndereco(aCliente: TClientes): Boolean;
begin
  if aCliente.CEP.Length < 8  then
  begin
    raise Exception.Create('O CEP não pode ser menor que 8 caracteres.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.CEP) ='' then
  begin
    raise Exception.Create('O CEP não pode vazio.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Endereco) = '' then
  begin
    raise Exception.Create('É necessário prencher o Endereço.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.uf) = '' then
  begin
    raise Exception.Create('É necessário preencher a UF.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Cidade) = '' then
  begin
    raise Exception.Create('É necessário preencher a Cidade.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Bairro) = '' then
  begin
    raise Exception.Create('É necessário preencher o Bairro.');
    Result:= False;
    exit;
  end;

  Result:= True;
end;

end.
