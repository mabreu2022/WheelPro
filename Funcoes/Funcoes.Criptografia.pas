unit Funcoes.Criptografia;

interface

uses
  Inifiles,
  System.Classes,
  System.SysUtils,
  System.Hash,
  System.NetEncoding;

type
   TCriptografia = class
     private

     public
       function EncryptString(const AValue: string; const AKey: Byte): string;
       function DecryptString(const AValue: string; const AKey: Byte): string;
   end;

implementation

{ TCriptografia }

function TCriptografia.DecryptString(const AValue: string;
  const AKey: Byte): string;
var
  DecodedBytes: TBytes;
  DecodedString: string;
  I: Integer;
begin
  DecodedBytes := TNetEncoding.Base64.DecodeStringToBytes(AValue);
  DecodedString := TEncoding.UTF8.GetString(DecodedBytes);

  SetLength(Result, Length(DecodedString));
  for I := 1 to Length(DecodedString) do
    Result[I] := Chr(Ord(DecodedString[I]) xor AKey);
end;

function TCriptografia.EncryptString(const AValue: string;
  const AKey: Byte): string;
var
  I: Integer;
  EncodedBytes: TBytes;
begin
  SetLength(Result, Length(AValue));
  for I := 1 to Length(AValue) do
    Result[I] := Chr(Ord(AValue[I]) xor AKey);

  EncodedBytes := TNetEncoding.Base64.Encode(TEncoding.UTF8.GetBytes(Result));
  Result := TEncoding.ASCII.GetString(EncodedBytes);
end;

end.
