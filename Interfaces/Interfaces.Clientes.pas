unit Interfaces.Clientes;

interface

uses
  Model.Clientes,
  Entity.Clientes;


type
  iCliente = interface
  ['{357A766D-60A4-4FFE-A416-B2E0E39FEC24}']
  function ObterClientePorId(Id: Integer): iCliente;
  procedure SalvarCliente(Cliente: TClientes);
  procedure RemoverCliente(Cliente: TClientes);

end;


implementation

end.
