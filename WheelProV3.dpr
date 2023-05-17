program WheelProV3;

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
  Dao.Conexao in 'DAO\Dao.Conexao.pas' {$R *.res},
  Entity.Clientes in 'Entity\Entity.Clientes.pas',
  Model.Clientes in 'Model\Model.Clientes.pas',
  Controller.Clientes in 'Controller\Controller.Clientes.pas',
  FMX.BitmapHelper in 'FMX.BitmapHelper.pas',
  uConfig in 'View\uConfig.pas' {FrmConfig},
  Entity.Fabricantes in 'Entity\Entity.Fabricantes.pas',
  Controller.Fabricantes in 'Controller\Controller.Fabricantes.pas',
  Model.Fabricantes in 'Model\Model.Fabricantes.pas',
  Entity.Contatos in 'Entity\Entity.Contatos.pas',
  Controller.Contatos in 'Controller\Controller.Contatos.pas',
  Model.Contatos in 'Model\Model.Contatos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
