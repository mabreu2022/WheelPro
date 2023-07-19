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
  {$R}
  {$R}
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
  Model.Contatos in 'Model\Model.Contatos.pas',
  LogManager in 'Funcoes\LogManager.pas',
  Interfaces.Clientes in 'Interfaces\Interfaces.Clientes.pas',
  Funcoes.PintarJante in 'Funcoes\Funcoes.PintarJante.pas',
  Funcoes.Criptografia in 'Funcoes\Funcoes.Criptografia.pas',
  Model.Registro in 'Model\Model.Registro.pas',
  Model.Backup in 'Model\Model.Backup.pas',
  View.Backup in 'View\View.Backup.pas' {FrmBackup},
  Funcoes.CNPJCPF in 'Funcoes\Funcoes.CNPJCPF.pas',
  DAO.ConexaoLicencas in 'DAO\DAO.ConexaoLicencas.pas',
  Entity.Categorias in 'Entity\Entity.Categorias.pas',
  Model.Categorias in 'Model\Model.Categorias.pas',
  Controller.Categorias in 'Controller\Controller.Categorias.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := (System.DebugHook <> 0);// True;
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmBackup, FrmBackup);
  Application.Run;
end.
