unit UnitGerarContrasenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Samples.Calendar, Vcl.ComCtrls;

type
  TFRMGerarContraSenha = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuery1id: TFDAutoIncField;
    FDQuery1id_chave: TIntegerField;
    FDQuery1chave: TStringField;
    FDQuery1data_inc: TDateField;
    FDQuery1data_exp: TDateField;
    FDQuery1contrasenha: TStringField;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Label4: TLabel;
    FDQuery1ativado: TStringField;
    FDQuery1serialhd: TStringField;
    Label5: TLabel;
    Label6: TLabel;
    FDQuery2: TFDQuery;
    DataSource2: TDataSource;
    FDQuery2razao: TStringField;
    Label7: TLabel;
    EdtData: TEdit;
    MonthCalendar1: TMonthCalendar;
    procedure Button1Click(Sender: TObject);
    function Crypt(Action, Src: String): String;

    procedure MonthCalendar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRMGerarContraSenha: TFRMGerarContraSenha;

implementation

{$R *.dfm}
// Rotina de encriptar

function TFRMGerarContraSenha.Crypt(Action, Src: String): String;
Label Fim;
var
  KeyLen: Integer;
  KeyPos: Integer;
  OffSet: Integer;
  Dest, Key: String;
  SrcPos: Integer;
  SrcAsc: Integer;
  TmpSrcAsc: Integer;
  Range: Integer;
begin
  if (Src = '') Then
  begin
    Result := '';
    Goto Fim;
  end;
  Key := 'AQUI VOCE CRIA SUA CHAVE PARA CRIPTOGRAFAR';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  SrcPos := 0;
  SrcAsc := 0;
  Range := 256;
  if (Action = UpperCase('C')) then
  begin
    Randomize;
    OffSet := Random(Range);
    Dest := Format('%1.2x', [OffSet]);
    for SrcPos := 1 to Length(Src) do
    begin
      Application.ProcessMessages;
      SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
      if KeyPos < KeyLen then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;

      SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x', [SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  Else if (Action = UpperCase('D')) then
  begin
    OffSet := StrToInt('$' + copy(Src, 1, 2));
    // <--------------- adiciona o $ entra as aspas simples
    SrcPos := 3;
    repeat
      SrcAsc := StrToInt('$' + copy(Src, SrcPos, 2));
      // <--------------- adiciona o $ entra as aspas simples
      if (KeyPos < KeyLen) Then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= OffSet then
        TmpSrcAsc := 255 + TmpSrcAsc - OffSet
      else
        TmpSrcAsc := TmpSrcAsc - OffSet;
      Dest := Dest + Chr(TmpSrcAsc);
      OffSet := SrcAsc;
      SrcPos := SrcPos + 2;
    until (SrcPos >= Length(Src));
  end;
  Result := Dest;
Fim:
end;
// fim da rotina de encriptar

procedure TFRMGerarContraSenha.Button1Click(Sender: TObject);
var
  strsql: string;
  strsql2: string;
  contrasenha: string;
  senhafinal: string;
  i: Integer;
const
  str = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%?';
  max = 15;
begin
  if Edit1.Text = '' then
  begin
    ShowMessage('Entre com a chave.');
    Edit1.SetFocus;
  end
  else
  begin
    if EdtData.Text = '' then
    begin
      ShowMessage('Entre com a data de vencimento.');
      EdtData.SetFocus;
    end
    else
    begin
      with FDQuery1 do;
      begin
        strsql := 'select * from registro where chave=' + #39 +
          Edit1.Text + #39;
        strsql := strsql + ' and contrasenha=0';

        strsql2 :=
          'select razao from chaves,registro where chaves.id_chave= registro.id_chave and registro.chave='
          + #39 + Edit1.Text + #39;
        FDQuery2.SQL.Clear;
        FDQuery2.SQL.Add(strsql2);
        FDQuery2.Open();
        Label6.Caption := FDQuery2.FieldByName('razao').AsString;

        // ShowMessage(strsql);
        FDQuery1.SQL.Clear;
        FDQuery1.SQL.Add(strsql);
        FDQuery1.Open();
        if (FDQuery1.RecordCount) = 1 then
        begin
          ShowMessage('Chave encontrada');
          // rotina de gerar a contra-senha
          contrasenha := FDQuery1.FieldByName('chave').AsString;
          // ShowMessage(contrasenha);
          // Gerar contra-senha
          Randomize;
          Label3.Caption := '';
          for i := 1 to max do
          begin
            FDQuery1.Edit;
            Label3.Caption := Label3.Caption + str[Random(Length(str)) + 1];
            FDQuery1.FieldByName('contrasenha').AsString := contrasenha +
              Label3.Caption;
            senhafinal := contrasenha + Label3.Caption;

            Memo1.Lines.Clear;
            Memo1.Lines.Add(senhafinal);

            // Encriptar
            // Memo1.Lines.Add(Crypt('D',senhafinal));
            // fim de encriptar

            FDQuery1.FieldByName('ativado').AsString := 'S';
            FDQuery1.FieldByName('data_exp').AsDateTime :=
              StrToDateTime(EdtData.Text);
            FDQuery1.Post;

          end;
          ShowMessage('Dados gravados com sucesso!');
        end
        else

        begin
          ShowMessage('Chave não encontrada');
          Edit1.Text := '';
          Edit1.SetFocus;
        end;

      end;
    end;
  end;
end;

procedure TFRMGerarContraSenha.MonthCalendar1Click(Sender: TObject);
begin
  EdtData.Text := DateToStr(MonthCalendar1.Date);
end;

end.
