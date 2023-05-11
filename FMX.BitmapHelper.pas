unit FMX.BitmapHelper;

interface

uses
  System.Classes, FMX.Graphics, System.Net.HttpClient;

type
  TBitmapHelper = class helper for TBitmap
  public
    procedure LoadFromUrl(AUrl: string);

    procedure LoadThumbnailFromUrl(AUrl: string; const AFitWidth, AFitHeight: Integer);
  end;

implementation

uses
  System.SysUtils, System.Types, IdTCPClient, AnonThread;

procedure TBitmapHelper.LoadFromUrl(AUrl: string);
var
  _Thread: TAnonymousThread<tmemorystream>;
begin
  _Thread := TAnonymousThread<tmemorystream>.Create(
    function: TMemoryStream
    var
      Http: THTTPClient;
    begin
      Result := TMemoryStream.Create;
      Http := THTTPClient.Create;
      try
        try
          Http.Get(AUrl, Result);
        except
          Result.Free;
        end;
      finally
        Http.Free;
      end;
    end,
    procedure(AResult: TMemoryStream)
    begin
      if AResult.Size > 0 then
        LoadFromStream(AResult);
      AResult.Free;
    end,
    procedure(AException: Exception)
    begin
    end
  );
end;

procedure TBitmapHelper.LoadThumbnailFromUrl(AUrl: string; const AFitWidth,
  AFitHeight: Integer);
var
  Bitmap: TBitmap;
  scale: Single;
begin
  LoadFromUrl(AUrl);
  scale := RectF(0, 0, Width, Height).Fit(RectF(0, 0, AFitWidth, AFitHeight));
  Bitmap := CreateThumbnail(Round(Width / scale), Round(Height / scale));
  try
    Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
end;

end.
