unit Controller.Produtos;

interface

uses
  System.Classes,
  Entity.Produtos,
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
  Model.Produtos;

  type
  TControllerProduto = class
  private

  public

    FModel: TModelProduto;
    //create
    function SalvarProduto(aProduto: TProduto): Boolean;

    //Read
    function CarregarProduto(const AIdProduto: Integer): TProduto;
    function CarregarTodosProdutos(aDataSet: TClientDataSet; aSomenteAtivos: string; aSemContatos: string): TFDquery;
    function ObterProdutoPorId(aIdProduto: Integer): TFDQuery;

    //Update
    function AlterarProduto(aProduto: TProduto): Boolean;

    //Delete
    function RemoverProduto(aProduto: TProduto): Boolean;

    //Regras
    function TestaSeCamposPreenchidos(aProduto: TProduto): Boolean;
    function ProdutoExiste(aIdProduto: Integer):Boolean;

    constructor create;
    destructor destroy;override;

end;

implementation

{ TControllerProduto }

function TControllerProduto.AlterarProduto(aProduto: TProduto): Boolean;
begin
  Result := FModel.AlterarProduto(aProduto);
end;

function TControllerProduto.CarregarProduto(
  const AIdProduto: Integer): TProduto;
begin
  Result := FModel.CarregarProdutos(AIdProduto);
end;

function TControllerProduto.CarregarTodosProdutos(aDataSet: TClientDataSet;
  aSomenteAtivos, aSemContatos: string): TFDquery;
begin
  Result := FModel.CarregarTodosProdutos(aDataSet, aSomenteAtivos, aSemContatos);
end;

constructor TControllerProduto.create;
begin
  FModel := TModelProduto.Create;
end;

destructor TControllerProduto.destroy;
begin
  FModel.Free;
  inherited;
end;

function TControllerProduto.ObterProdutoPorId(aIdProduto: Integer): TFDQuery;
begin
  Result := FModel.ObterProdutoPorId(aIdProduto);
end;

function TControllerProduto.ProdutoExiste(aIdProduto: Integer): Boolean;
begin
  Result := FModel.ProdutoExiste(aIdProduto);
end;

function TControllerProduto.RemoverProduto(aProduto: TProduto): Boolean;
begin
  Result := FModel.RemoverProduto(aProduto);
end;

function TControllerProduto.SalvarProduto(aProduto: TProduto): Boolean;
begin
  Result := FModel.SalvarProduto(aProduto);
end;

function TControllerProduto.TestaSeCamposPreenchidos(
  aProduto: TProduto): Boolean;
begin
   Result := FMOdel.TestaSeCamposPreenchidos(aProduto);
end;

end.
