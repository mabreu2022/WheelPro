unit Interfaces.Clientes;

interface

uses
  Model.Clientes,
  DAO.Clientes;

type
  IClientesDAO = interface
  ['{357A766D-60A4-4FFE-A416-B2E0E39FEC24}']
  function ObterClientePorId(Id: Integer): TClientes;
    procedure SalvarCliente(Cliente: TClientes);
    procedure RemoverCliente(Cliente: TClientes);
  end;

  IClientesView = interface
  ['{CFA9185A-8FC4-44BD-ADCE-7D3C055F6045}']
    procedure ExibirCliente(Cliente: TClientes);
    procedure ExibirMensagem(Mensagem: string);

end;


implementation

end.
