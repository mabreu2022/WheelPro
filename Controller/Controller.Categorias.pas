unit Controller.Categorias;

interface

uses
  System.Classes,
  Entity.Categorias,
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
  Model.Categorias;

type
  TControllerCategoria = class
  private

  public
    FModel: TModelCategorias;

    Class function SalvarCategoria(aCategoria: TCategorias): Boolean;
    class function AlterarCategoria(aCategoria: TCategorias): Boolean;
    class function TestaSeCamposPreenchidos(aCategoria: TCategorias): Boolean;
    class function CategoriaExiste(aIDCategoria: Integer):Boolean;
    class function PesquisaNomeFabricante(aCodFabricante: Integer): String;

    function CarregarTodasCategorias(aDataSet      : TClientDataSet;
                                     aSomenteAtivos: string;
                                     aNomeBotao    : string  = '';
                                     aIdCategorias : Integer = 0)
                                     : TFDquery;
    //Delete
    function RemoverCategoria(aCategoria: TCategorias): Boolean;

    constructor create;
    destructor destroy;override;
  end;

implementation

{ TControllerCategoria }

class function TControllerCategoria.AlterarCategoria(
  aCategoria: TCategorias): Boolean;
  var
   FModel: TModelCategorias;
begin
  Result := FModel.AlterarCategoria(aCategoria);
end;

function TControllerCategoria.CarregarTodasCategorias(aDataSet: TClientDataSet;
  aSomenteAtivos, aNomeBotao: string; aIdCategorias: Integer): TFDquery;
begin

end;

class function TControllerCategoria.CategoriaExiste(
  aIDCategoria: Integer): Boolean;
begin

end;

constructor TControllerCategoria.create;
begin
  FModel:= TModelCategorias.create;
end;

destructor TControllerCategoria.destroy;
begin
  FModel.Free;
  inherited;
end;

class function TControllerCategoria.PesquisaNomeFabricante(
  aCodFabricante: Integer): String;
begin

end;

function TControllerCategoria.RemoverCategoria(
  aCategoria: TCategorias): Boolean;
begin
  FModel.RemoverCategoria(aCategoria);
end;

class function TControllerCategoria.SalvarCategoria(
  aCategoria: TCategorias): Boolean;
   var
   FModel: TModelCategorias;
begin
  Result := FModel.SalvarCategoria(aCategoria);
end;

class function TControllerCategoria.TestaSeCamposPreenchidos(
  aCategoria: TCategorias): Boolean;
begin

end;

end.
