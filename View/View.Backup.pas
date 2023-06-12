unit View.Backup;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects,
  System.IniFiles,
  System.UIConsts,
  FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait,
  FMX.Effects,
  FireDAC.Stan.Intf,
  FireDAC.Comp.UI,
  Model.Backup,
  Dao.Conexao,
  Funcoes.Criptografia;

type
  TFrmBackup = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Rectangle2: TRectangle;
    Button1: TButton;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    lblProgresso: TLabel;
    ShadowEffect3: TShadowEffect;
    Timer1: TTimer;
    recBackPRogress: TRectangle;
    recProgress: TRectangle;
    lytProgress: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private
    { Private declarations }
    FLinguagem: string;
    procedure CarregarCores;
    procedure CarregarLinguagem;
  public
    { Public declarations }
    StepUnit    : Single;
    Step        : Single;
    FBackup     : TBackup;
    FConexao    : TConnection;
    Criptografia: TCriptografia;
  end;

var
  FrmBackup: TFrmBackup;

implementation

{$R *.fmx}

{ TFrmBackup }

procedure TFrmBackup.Button1Click(Sender: TObject);
var
  ini: TIniFile;
  Host,User,Password,Database, BackupPath, DumpFileName:  string;
  DeuCerto: Boolean;
begin
  FBackup:= TBackup.Create;
  try
    ini := TIniFile.Create(ExtractFileDir(ParamStr(0)) + '\Server.ini');
    Criptografia:= TCriptografia.Create;
    try
       Host       := Criptografia.DecryptString(ini.ReadString('Banco de Dados', 'Server', ''),123);
       User       := Criptografia.DecryptString(ini.ReadString('Banco de Dados', 'User_Name', ''),123);
       PassWord   := Criptografia.DecryptString(ini.ReadString('Banco de Dados', 'Password', ''),123);
       Database   := Criptografia.DecryptString(ini.ReadString('Banco de Dados', 'Database', ''),123);
       BackupPath := ExtractFileDir(ParamStr(0))+'\Backup\';

       Step := 0;
       Timer1.Enabled := True;
       StepUnit:= (recBackPRogress.Width / 10);
       recProgress.Width := Step;

       DumpFileName:= 'Backup_' + DateToStr(now)+'.sql';

       DeuCerto := FBackup.BackupMySQLDatabase(Host,User, PassWord, Database, BackupPath, DumpFileName);


    finally
      ini.Free;
      Criptografia.Free;
    end;

  finally
    FBackup.Free;
  end;
end;

procedure TFrmBackup.CarregarCores;
var
  IniFile: TIniFile;
  Cor: TAlphaColor;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Cor := StringToAlphaColor(IniFile.ReadString('Cores', 'Cor', ''));
  finally
    IniFile.UpdateFile;
    IniFile.Free;
  end;

  for var I := 0 to FrmBackup.ComponentCount - 1 do
  begin
    if FrmBackup.Components[I] is TRectangle then
    begin
      if (FrmBackup.Components[I].Name = 'recProgress') then
        Exit
      else
        TRectangle(FrmBackup.Components[I]).Fill.Color := Cor;
    end;
  end;

end;

procedure TFrmBackup.CarregarLinguagem;
var
  IniFile: TIniFile;
  I: Integer;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    FLinguagem :=IniFile.ReadString('Traducao', 'Linguagem', '');

   if FLinguagem = 'Portuguese' then
   begin
     //lblRazao.Text        := 'Razão Social / Nome';

   end
   else if FLinguagem = 'Ingles' then
   begin
     //lblRazao.Text        := 'Corporate Name / Name';

   end;

  finally
    IniFile.Free;
  end;

end;

procedure TFrmBackup.FormCreate(Sender: TObject);
begin
  CarregarCores;
  CarregarLinguagem;
  Step     := 0;
  StepUnit := 0;
  recProgress.Width:= 0;
end;

procedure TFrmBackup.Timer1Timer(Sender: TObject);
begin
  if recProgress.Width >= recBackPRogress.Width then
  begin
    Timer1.Enabled:=False;
    Exit;
  end;

  Step:= Step + StepUnit;
  recProgress.Width  := Step;
end;

end.
