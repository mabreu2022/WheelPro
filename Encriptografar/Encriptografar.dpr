program Encriptografar;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {FrmPrincipal},
  Funcoes.Criptografia in '..\Funcoes\Funcoes.Criptografia.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
