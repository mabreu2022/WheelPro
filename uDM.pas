unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDQVeiculos: TFDQuery;
    FDQMarcas: TFDQuery;
    FDQProdutos: TFDQuery;
    FDQFabricantes: TFDQuery;
    DSVeiculos: TDataSource;
    DSMarcas: TDataSource;
    DSProdutos: TDataSource;
    DSFabricantes: TDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DSModelos: TDataSource;
    FDQModelos: TFDQuery;
    FDQCategorias: TFDQuery;
    DSCategorias: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
