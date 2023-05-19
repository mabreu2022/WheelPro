program GerarSerial;

uses
  Vcl.Forms,
  UnitGerarSerial in 'UnitGerarSerial.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFRMGERARSERIAL, FRMGERARSERIAL);
  Application.Run;
end.
