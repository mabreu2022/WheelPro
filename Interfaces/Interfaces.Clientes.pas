unit Interfaces.Clientes;

interface

uses
  Model.Clientes,
  DAO.Clientes;

type
  IClientesDAO = interface
  function ObterClientePorId(Id: Integer): TClientes;
    procedure SalvarCliente(Cliente: TClientes);
    procedure RemoverCliente(Cliente: TClientes);
  end;

  IClientesView = interface
    procedure ExibirCliente(Cliente: TClientes);
    procedure ExibirMensagem(Mensagem: string);

end;


implementation

end.
