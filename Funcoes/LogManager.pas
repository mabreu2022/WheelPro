unit LogManager;

interface

uses
  Sysutils,
  System.Classes;

type
  TLogManager = class
  private
    FLogList: TStringList;
    //class var FInstance: TLogManager;
    //class function GetInstance: TLogManager;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddLog(const Message: string);
    procedure SaveLogToFile(const FileName: string);
//    class function Instance: TLogManager;

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

//class function TLogManager.GetInstance: TLogManager;
//begin
//  if FInstance = nil then
//    FInstance := TLogManager.Create;
//  Result := FInstance;
//end;

//class function TLogManager.Instance: TLogManager;
//begin
//  if FInstance = nil then
//    FInstance := TLogManager.Create;
//  Result := FInstance;
//end;

procedure TLogManager.SaveLogToFile(const FileName: string);
begin
  FLogList.SaveToFile(FileName);
end;

end.
