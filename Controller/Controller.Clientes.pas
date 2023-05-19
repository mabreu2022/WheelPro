unit Controller.Clientes;

interface

uses
  System.Classes,
  Entity.Clientes,
  Datasnap.DBClient,
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
  Model.Clientes;

type
  TControllerCliente = class
  private

  public

    Fmodel: TModelCliente;
    //create
    function SalvarCliente(aCliente: TClientes): Boolean;

    //Read
    function CarregarClientes(const ACNPJ: String): TClientes;
    function CarregarTodosClientes(aDataSet: TClientDataSet): TFDquery; //ok
    function ObterClientePorId(aId: Integer): TFDQuery;

    //Update
    function AlterarCliente(aCliente: TClientes): Boolean;

    //Delete
    function RemoverCliente(aCliente: TClientes): Boolean;

    //Regras
    function TestaSeCamposPreenchidos(aCliente: TClientes): Boolean;
    function ClienteExiste(aCNPJ: string):Boolean;

    constructor create;
    destructor destroy;override;

end;

implementation

{ TControllerCliente }

function TControllerCliente.AlterarCliente(aCliente: TClientes): Boolean;
begin
  Result := FModel.AlterarCliente(aCliente);
end;

function TControllerCliente.CarregarClientes(const ACNPJ: String): TClientes;
begin
  Result := FModel.CarregarClientes(aCNPJ);
end;

function TControllerCliente.CarregarTodosClientes(
  aDataSet: TClientDataSet): TFDquery;
begin
  Result := FModel.CarregarTodosClientes(aDataSet);
end;

function TControllerCliente.ClienteExiste(aCNPJ: string): Boolean;
begin
  Result := FModel.ClienteExiste(aCNPJ);
end;

constructor TControllerCliente.create;
begin
  FModel := TModelCliente.Create;
end;

destructor TControllerCliente.destroy;
begin
  FModel.Free;
  inherited;
end;

function TControllerCliente.ObterClientePorId(aId: Integer): TFDQuery;
begin
  Result := FModel.ObterClientePorId(aId);
end;

function TControllerCliente.RemoverCliente(aCliente: TClientes): Boolean;
begin
  Result := FModel.RemoverCliente(aCliente);
end;

function TControllerCliente.SalvarCliente(aCliente: TClientes): Boolean;
begin
  Result := FModel.SalvarCliente(aCliente);
end;

function TControllerCliente.TestaSeCamposPreenchidos(
  aCliente: TClientes): Boolean;
begin
  Result := FMOdel.TestaSeCamposPreenchidos(aCliente);
end;

end.
