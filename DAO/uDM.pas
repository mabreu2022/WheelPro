unit uDM;

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
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Comp.DataSet,
  Datasnap.DBClient,
  Vcl.Dialogs;

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
    CDS_Permissoes: TClientDataSet;
    CDS_Permissoesidpermissoes: TIntegerField;
    CDS_Permissoesidusuario: TIntegerField;
    CDS_PermissoesidMenu: TIntegerField;
    CDS_Permissoespermitido: TStringField;
    CDS_Permissoesusuario: TStringField;
    CDS_Permissoescaptionmenu: TStringField;
    CDS_Permissoestipo: TStringField;
    DS_Permissoes: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
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

procedure TDM.DataModuleCreate(Sender: TObject);
begin
//  showmessage('Estou no DM on create');
//  FDConnection1.DriverName:='MySQL';
//  ShowMessage('Driver do FDConnection:' + FDConnection1.DriverName);
end;

end.
