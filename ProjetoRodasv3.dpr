program ProjetoRodasv3;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  uDM in 'uDM.pas' {DM: TDataModule},
  UCadastroClientes in 'UCadastroClientes.pas' {FrmCadastroClientes},
  UCadastroCategorias in 'UCadastroCategorias.pas' {FrmCategorias},
  UCadastroVeiculos in 'UCadastroVeiculos.pas' {FrmCadastroVeiculos},
  UCadastroFabricantes in 'UCadastroFabricantes.pas' {FrmFabricantes},
  UCadastroOrcamentos in 'UCadastroOrcamentos.pas' {FrmOrcamentos},
  URegistrar in 'URegistrar.pas' {FrmRegistrar};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmCadastroClientes, FrmCadastroClientes);
  Application.CreateForm(TFrmCategorias, FrmCategorias);
  Application.CreateForm(TFrmCadastroVeiculos, FrmCadastroVeiculos);
  Application.CreateForm(TFrmFabricantes, FrmFabricantes);
  Application.CreateForm(TFrmOrcamentos, FrmOrcamentos);
  Application.CreateForm(TFrmRegistrar, FrmRegistrar);
  Application.Run;
end.
