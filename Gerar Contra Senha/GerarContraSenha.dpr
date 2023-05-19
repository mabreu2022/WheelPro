program GerarContraSenha;

uses
  Vcl.Forms,
  UnitGerarContrasenha in 'UnitGerarContrasenha.pas' {FRMGerarContraSenha};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFRMGerarContraSenha, FRMGerarContraSenha);
  Application.Run;
end.
