program ProjetoRodasv3;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  uDM in 'DAO\uDM.pas' {DM: TDataModule},
  Login in 'View\Login.pas' {FrmLogin},
  Dao.Login in 'DAO\Dao.Login.pas',
  UCadastroClientes in 'View\UCadastroClientes.pas' {FrmCadastroClientes},
  UCadastroCategorias in 'View\UCadastroCategorias.pas' {FrmCategorias},
  UCadastroVeiculos in 'View\UCadastroVeiculos.pas' {FrmCadastroVeiculos},
  UCadastroFabricantes in 'View\UCadastroFabricantes.pas' {FrmFabricantes},
  UCadastroOrcamentos in 'View\UCadastroOrcamentos.pas' {FrmOrcamentos},
  URegistrar in 'View\URegistrar.pas' {FrmRegistrar},
  Dao.Conexao in 'DAO\Dao.Conexao.pas',
  DAO.Clientes in 'DAO\DAO.Clientes.pas',
  Model.Clientes in 'Model\Model.Clientes.pas',
  Interfaces.Clientes in 'Interfaces\Interfaces.Clientes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
