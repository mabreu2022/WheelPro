unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,ActiveX, ComObj,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    Gerarserial: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDQuery1id: TFDAutoIncField;
    FDQuery1id_chave: TIntegerField;
    FDQuery1chave: TStringField;
    FDQuery1data_inc: TDateField;
    FDQuery1data_exp: TDateField;
    Edit1: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    FDQuery2: TFDQuery;
    DataSource2: TDataSource;
    Button1: TButton;
    FDQuery1contrasenha: TStringField;
    FDQuery1ativado: TStringField;
    FDQuery1serialhd: TStringField;
    FDQuery2id_chave: TFDAutoIncField;
    FDQuery2razao: TStringField;
    FDQuery2cnpj: TStringField;
    procedure GerarserialClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
   // procedure Edit1Change(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Button1Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;

implementation

{$R *.dfm}

function  GetWMIstring(const WMIClass, WMIProperty:string): string;
const
wbemFlagForwardOnly = $00000020;
var
FWbemObjectSet: OLEVariant;
FWbemObject   : OLEVariant;
oEnum         : IEnumvariant;
iValue        : LongWord;
begin;
     Result:='';
     FWbemObjectSet:= FWMIService.ExecQuery(Format('Select %s from %s',[WMIProperty, WMIClass]),'WQL',wbemFlagForwardOnly);
     oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
     if oEnum.Next(1, FWbemObject, iValue) = 0 then

        if not VarIsNull(FWbemObject.Properties_.Item(WMIProperty).Value) then
           Result:=FWbemObject.Properties_.Item(WMIProperty).Value;
           FWbemObject:=Unassigned;
end;

procedure TForm1.GerarserialClick(Sender: TObject);
var
x:string;
Y:string;
z:string;
data : TDateTime;
begin
      FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      FWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      X:=Trim(GetWMIstring('Win32_BIOS','SerialNumber'));
      Y:=Trim(GetWMIstring('Win32_PhysicalMedia','SerialNumber'));

      label2.Caption:= x;
      label4.Caption:= y;
      z:=x+y+(DateToStr(date));
      //label5.Caption:=z;
      label5.Caption:='Serial Gerado';
      // Rotina de enviar por e-mail

      // Rotina de encriptar

      with FDQuery1 do

           //FDQuery1.Edit;
           FDQuery1.Append;
           FDQuery1.FieldByName('chave').AsString := z;
           FDQuery1.FieldByName('Data_inc').AsDateTime := Date;
           Data := date;
           FDQuery1.FieldByName('Data_exp').AsDateTime:=Data + 30;
           ShowMessage(DateToStr(Data+30));
           FDQuery1.FieldByName('serialhd').AsString:=y;

           FDQuery1.FieldByName('ID_Chave').AsInteger := FDQuery2.FieldByName('ID_Chave').AsInteger;

           FDQuery1.FieldByName('contrasenha').AsString:='0';
           FDQuery1.Post;
end;

            //ShowMessage('O número serial do HD é:'+ x +'E o da Bios do HD é:'+y);
      //rotina de encriptação ou randomizar a string
      //1234 --- banco oline --- encripta - manda para o cliente
      // exe ... desencriptar banco local do cliente - conexao com o banco olinda
      // e ve se é igual...incluindo tb a data.




procedure TForm1.Button1Click(Sender: TObject);
var
strsql:string;
begin
 with FDQuery2 do;
  begin
    strsql:='select * from chaves where cnpj like' +#39+ '%'+ (Edit1.Text) + #39;
    FDQuery2.SQL.Clear;
    FDQuery2.SQL.Add(strsql);
    FDQuery2.Open();
    if FDQuery2.RecordCount>=1 then
       begin
           ShowMessage('CNPJ encontrado');
           //FDQuery1.FieldByName('ID_Chave').AsInteger := FDQuery2.FieldByName('ID_Chave').AsInteger;
           Gerarserial.Enabled:=True;
           Gerarserial.SetFocus;
       end
    else
       begin
       ShowMessage('CNPJ não encontrado');
       Edit1.Text:='';
       Edit1.SetFocus;
       end;

  end;


end;

{procedure TForm1.Edit1Change(Sender: TObject);
var
strsql:string;
begin

with FDQuery2 do;
  begin
    strsql:='select * from chaves where cnpj like' +#39+ '%'+ (Edit1.Text) + #39;
    FDQuery2.SQL.Clear;
    FDQuery2.SQL.Add(strsql);
    FDQuery2.Open();
    if FDQuery2.RecordCount>=1 then
       begin
           ShowMessage('CNPJ encontrado');
           Gerarserial.Enabled:=True;
       end
    else
       begin
       ShowMessage('CNPJ não encontrado');
       end;

  end;
    Edit1.Text:='';
    Edit1.SetFocus;

end;  }





procedure TForm1.Edit1Enter(Sender: TObject);
begin
Gerarserial.Enabled:=True;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
Gerarserial.Enabled:=False;
  { with FDQuery3 do
   begin
       if FieldByName('contrasenha')<>0 then
          FDQuery
   end;}
end;

end.
