unit LogManager;

interface

uses
  Sysutils,
  System.Classes;

type
  TLogManager = class
  private
    FLogList: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddLog(const Message: string);
    procedure SaveLogToFile(const FileName: string);
    function GravarLogsnoBanco(aIdRevenda: Integer): Boolean;

  end;

implementation

{ TLogManager }

procedure TLogManager.AddLog(const Message: string);
begin
  FLogList.Add(Message);
end;

constructor TLogManager.Create;
begin
  FLogList := TStringList.Create;
end;

destructor TLogManager.Destroy;
begin
  FLogList.Free;
  inherited;
end;

function TLogManager.GravarLogsnoBanco(aIdRevenda: Integer): Boolean;
begin
  //Gravar na tabelaa Logs o arquivo txt via streamig no campo arquivo Blob
end;

procedure TLogManager.SaveLogToFile(const FileName: string);
begin
  FLogList.SaveToFile(FileName);
end;

end.
