program Encriptografar;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {Form1},
  Funcoes.Criptografia in '..\Funcoes\Funcoes.Criptografia.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
