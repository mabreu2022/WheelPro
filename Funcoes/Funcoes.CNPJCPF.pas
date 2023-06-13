unit Funcoes.CNPJCPF;

interface

uses
  System.Classes,
  System.SysUtils;

type
  TCNPJCPF = class
  private

  public
    function ValidarCNPJ(const CNPJ: string): Boolean;
    function ValidarCPF(const CPF: string): Boolean;
end;

implementation

{ TCNPJCPF }

function TCNPJCPF.ValidarCNPJ(const CNPJ: string): Boolean;
var
  Digito, Soma, i, j: Integer;
  CNPJCalc: string;
  Multiplicador: array[1..14] of Integer;
begin
  Result := False;

  // Remove caracteres não numéricos do CNPJ
  CNPJCalc := '';
  for i := 1 to Length(CNPJ) do
    if CharInSet(CNPJ[i], ['0'..'9']) then
      CNPJCalc := CNPJCalc + CNPJ[i];

  // Verifica se o CNPJ possui 14 dígitos
  if Length(CNPJCalc) <> 14 then
    Exit;

  // Verifica se todos os dígitos são iguais
  if (CNPJCalc = '00000000000000') or (CNPJCalc = '11111111111111') or
    (CNPJCalc = '22222222222222') or (CNPJCalc = '33333333333333') or
    (CNPJCalc = '44444444444444') or (CNPJCalc = '55555555555555') or
    (CNPJCalc = '66666666666666') or (CNPJCalc = '77777777777777') or
    (CNPJCalc = '88888888888888') or (CNPJCalc = '99999999999999') then
    Exit;

  // Calcula o primeiro dígito verificador
  Soma := 0;
  Multiplicador[1] := 5;
  Multiplicador[2] := 4;
  Multiplicador[3] := 3;
  Multiplicador[4] := 2;
  Multiplicador[5] := 9;
  Multiplicador[6] := 8;
  Multiplicador[7] := 7;
  Multiplicador[8] := 6;
  Multiplicador[9] := 5;
  Multiplicador[10] := 4;
  Multiplicador[11] := 3;
  Multiplicador[12] := 2;
  for i := 1 to 12 do
    Soma := Soma + (StrToInt(CNPJCalc[i]) * Multiplicador[i]);
  Digito := 11 - (Soma mod 11);
  if Digito >= 10 then
    Digito := 0;
  if Digito <> StrToInt(CNPJCalc[13]) then
    Exit;

  // Calcula o segundo dígito verificador
  Soma := 0;
  Multiplicador[1] := 6;
  Multiplicador[2] := 5;
  Multiplicador[3] := 4;
  Multiplicador[4] := 3;
  Multiplicador[5] := 2;
  Multiplicador[6] := 9;
  Multiplicador[7] := 8;
  Multiplicador[8] := 7;
  Multiplicador[9] := 6;
  Multiplicador[10] := 5;
  Multiplicador[11] := 4;
  Multiplicador[12] := 3;
  Multiplicador[13] := 2;
  for i := 1 to 13 do
    Soma := Soma + (StrToInt(CNPJCalc[i]) * Multiplicador[i]);
  Digito := 11 - (Soma mod 11);
  if Digito >= 10 then
    Digito := 0;
  if Digito <> StrToInt(CNPJCalc[14]) then
    Exit;

  Result := True;

end;

function TCNPJCPF.ValidarCPF(const CPF: string): Boolean;
var
  Digito, Soma, i, j: Integer;
  CPFCalc: string;
  Multiplicador: array[1..11] of Integer;
begin
  Result := False;

  // Remove caracteres não numéricos do CPF
  CPFCalc := '';
  for i := 1 to Length(CPF) do
    if CharInSet(CPF[i], ['0'..'9']) then
      CPFCalc := CPFCalc + CPF[i];

  // Verifica se o CPF possui 11 dígitos
  if Length(CPFCalc) <> 11 then
    Exit;

  // Verifica se todos os dígitos são iguais
  if (CPFCalc = '00000000000') or (CPFCalc = '11111111111') or
    (CPFCalc = '22222222222') or (CPFCalc = '33333333333') or
    (CPFCalc = '44444444444') or (CPFCalc = '55555555555') or
    (CPFCalc = '66666666666') or (CPFCalc = '77777777777') or
    (CPFCalc = '88888888888') or (CPFCalc = '99999999999') then
    Exit;

  // Calcula o primeiro dígito verificador
  Soma := 0;
  Multiplicador[1] := 10;
  Multiplicador[2] := 9;
  Multiplicador[3] := 8;
  Multiplicador[4] := 7;
  Multiplicador[5] := 6;
  Multiplicador[6] := 5;
  Multiplicador[7] := 4;
  Multiplicador[8] := 3;
  Multiplicador[9] := 2;
  for i := 1 to 9 do
    Soma := Soma + (StrToInt(CPFCalc[i]) * Multiplicador[i]);
  Digito := 11 - (Soma mod 11);
  if Digito >= 10 then
    Digito := 0;
  if Digito <> StrToInt(CPFCalc[10]) then
    Exit;

  // Calcula o segundo dígito verificador
  Soma := 0;
  Multiplicador[1] := 11;
  Multiplicador[2] := 10;
  Multiplicador[3] := 9;
  Multiplicador[4] := 8;
  Multiplicador[5] := 7;
  Multiplicador[6] := 6;
  Multiplicador[7] := 5;
  Multiplicador[8] := 4;
  Multiplicador[9] := 3;
  Multiplicador[10] := 2;
  for i := 1 to 10 do
    Soma := Soma + (StrToInt(CPFCalc[i]) * Multiplicador[i]);
  Digito := 11 - (Soma mod 11);
  if Digito >= 10 then
    Digito := 0;
  if Digito <> StrToInt(CPFCalc[11]) then
    Exit;

  Result := True;

end;

end.
