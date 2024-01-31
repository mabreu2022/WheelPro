unit UnitGerarSerial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,ActiveX, ComObj, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, FireDAC.Comp.Client, Vcl.ComCtrls, IdComponent, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdBaseComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase,IdMessageClient, IdSMTPBase,
  IdSMTP, Vcl.Buttons, IdAttachmentFile,IdText, IdSSLOpenSSL,
  IdMessage;

type
  TFRMGERARSERIAL = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Gerarserial: TButton;
    Edit1: TEdit;
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery1id: TFDAutoIncField;
    FDQuery1id_chave: TIntegerField;
    FDQuery1chave: TStringField;
    FDQuery1data_inc: TDateField;
    FDQuery1data_exp: TDateField;
    FDQuery1contrasenha: TStringField;
    FDQuery1ativado: TStringField;
    FDQuery1serialhd: TStringField;
    DataSource1: TDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDQuery2: TFDQuery;
    FDQuery2id_chave: TFDAutoIncField;
    FDQuery2razao: TStringField;
    FDQuery2cnpj: TStringField;
    DataSource2: TDataSource;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Button2: TButton;
    FDQuery3: TFDQuery;
    DataSource3: TDataSource;
    FDQuery3id_chave: TFDAutoIncField;
    FDQuery3razao: TStringField;
    FDQuery3cnpj: TStringField;
    FDQuery3IE: TStringField;
    FDQuery3IM: TStringField;
    FDQuery3ENDERECO: TStringField;
    FDQuery3NUMERO: TStringField;
    FDQuery3COMPLEMENTO: TStringField;
    FDQuery3CEP: TStringField;
    FDQuery3TELEFONE: TStringField;
    FDQuery3CONTATO: TStringField;
    FDQuery3TELCONTATO: TStringField;
    FDQuery3EMAIL: TStringField;
    FDQuery3WEBSITE: TStringField;
    Label20: TLabel;
    Edit14: TEdit;
    TabSheet3: TTabSheet;
    Memo1: TMemo;
    IdMessage1: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdSMTP1: TIdSMTP;
    cbtipo: TComboBox;
    Button4: TButton;
    FDQuery2IE: TStringField;
    FDQuery2IM: TStringField;
    FDQuery2ENDERECO: TStringField;
    FDQuery2NUMERO: TStringField;
    FDQuery2COMPLEMENTO: TStringField;
    FDQuery2CEP: TStringField;
    FDQuery2TELEFONE: TStringField;
    FDQuery2CONTATO: TStringField;
    FDQuery2TELCONTATO: TStringField;
    FDQuery2EMAIL: TStringField;
    FDQuery2WEBSITE: TStringField;
    FDConnection2: TFDConnection;
    procedure GerarserialClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
   // procedure Edit1Change(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRMGERARSERIAL: TFRMGERARSERIAL;
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

procedure TFRMGERARSERIAL.GerarserialClick(Sender: TObject);
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
  label5.Caption:=z;
  // Rotina de enviar por e-mail

  // Rotina de encriptar

  with FDQuery1,FDQuery2 do

     //FDQuery1.Edit;
     //Desabilitar botao Geral Serial
     Edit1.Enabled:=False;
     Gerarserial.Enabled:=False;
     Button1.Enabled:=False;
     PageControl1.Pages[1].TabVisible := False;
     // fim

     FDQuery1.Append;
     FDQuery1.FieldByName('chave').AsString := z;
     FDQuery1.FieldByName('Data_inc').AsDateTime := Date;
     Data := Date;
     FDQuery1.FieldByName('Data_exp').AsDateTime:=Data;
     //ShowMessage(DateToStr(Data+30));
     FDQuery1.FieldByName('serialhd').AsString:=y;

     FDQuery1.FieldByName('ID_Chave').AsInteger := FDQuery2.FieldByName('ID_Chave').AsInteger;

     FDQuery1.FieldByName('contrasenha').AsString:='0';
     FDQuery1.FieldByName('ativado').AsString:='N';
     FDQuery1.Post;

end;

      //ShowMessage('O número serial do HD é:'+ x +'E o da Bios do HD é:'+y);
      //rotina de encriptação ou randomizar a string
      //1234 --- banco oline --- encripta - manda para o cliente
      // exe ... desencriptar banco local do cliente - conexao com o banco olinda
      // e ve se é igual...incluindo tb a data.




procedure TFRMGERARSERIAL.Button1Click(Sender: TObject);
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


procedure TFRMGERARSERIAL.Button2Click(Sender: TObject);
begin
    PageControl1.Pages[0].TabVisible := False;
    FRMGERARSERIAL.Button1.Enabled:=True;
    FRMGERARSERIAL.Edit1.Enabled:=True;
    FRMGERARSERIAL.Gerarserial.Enabled:=True;
    FDQuery3.Open;
    FDQuery3.edit;
    FDQuery3.FieldByName('razao').AsString:=Edit2.Text;
    FDQuery3.FieldByName('cnpj').AsString:=Edit3.Text;
    FDQuery3.FieldByName('ie').AsString:=Edit4.Text;
    FDQuery3.FieldByName('im').AsString:=Edit5.Text;
    FDQuery3.FieldByName('endereco').AsString:=Edit6.Text;
    FDQuery3.FieldByName('numero').AsString:=Edit7.Text;
    FDQuery3.FieldByName('complemento').AsString:=Edit8.Text;
    FDQuery3.FieldByName('cep').AsString:=Edit9.Text;
    FDQuery3.FieldByName('telefone').AsString:=Edit10.Text;
    FDQuery3.FieldByName('contato').AsString:=Edit11.Text;
    FDQuery3.FieldByName('telcontato').AsString:=Edit12.Text;
    FDQuery3.FieldByName('website').AsString:=Edit13.Text;
    FDQuery3.FieldByName('email').AsString:=Edit14.Text;

    //Faltaram bairro, cidade, ativo, datacadastro, uf
    FDQuery3.Post;
    ShowMessage('Dados Salvos com sucesso!');

end;

procedure TFRMGERARSERIAL.Button3Click(Sender: TObject);
begin
     Close;
end;
// envio de e-mail
procedure TFRMGERARSERIAL.Button4Click(Sender: TObject);
var
    IdSMTP1: TIdSMTP;
    Idmessage: TIdMessage;
    TextoMsg: TidText;
    IdSSL: TIdSSLIOHandlerSocketOpenSSL;
    contatol:string;
    emaill:string;
    telcontatol:string;
    const
    CRFL = #13#10;

begin
    IdSMTP1                 := TIdSMTP.create(nil);
    IdSMTP1.ConnectTimeout  := 10000;
    IdSMTP1.ReadTimeout     := 10000;

    IdMessage               := TIdMessage.create(nil);
    IdMessage.Clear;
    IdMessage.CharSet       := 'iso-8859-1';
    IdMessage.Encoding      := MeMIME;
    IdMessage.ContentType   := 'multipart/related'   ;
    IdMessage.subject       := 'Novo Serial Gerado do cliente: ' +FDQuery2.FieldByName('razao').AsString ;

    textomsg                := TIdText.Create(IdMessage.MessageParts);
    //textomsg.Body.Text      := 'Se você consegue ler isto então é porque funcionou o teste!';
    contatol    := FDQuery2.FieldByName('contato').AsString;
    emaill      := FDQuery2.FieldByName('email').AsString;
    telcontatol := FDQuery2.FieldByName('telcontato').AsString;
    Memo1.Lines.Add(contatol);
    Memo1.Lines.Add(emaill);
    Memo1.Lines.Add(telcontatol);
    //TextoMsg.Body.Text      :=Memo1.Lines.Text + #13 + 'Serial gerado: '+Label5.Caption;

    //TextoMsg.Body.Text      :=Memo1.Lines.Text;
    TextoMsg.Body.Add('Chave Gerada: '+Label5.Caption+'<br/>');
    TextoMsg.Body.Add(contatol+'<br/>');
    TextoMsg.Body.Add(emaill+'<br/>');
    TextoMsg.Body.Add(telcontatol+'<br/>');


    textomsg.ContentType    := 'text/html';

    if ((cbtipo.itemindex = 0) or (cbtipo.itemindex = 2)) then
    begin
        // GMAIL e YAHOO

        if cbtipo.itemindex = 0 then
        begin
            idSMTP1.Host            := 'smtp.gmail.com';
            idSMTP1.Username        := 'delphi.send@gmail.com';
            idSMTP1.Password        := 'delphi.send12345';
        end
        else begin
            idSMTP1.Host            := 'smtp.mail.yahoo.com';
            idSMTP1.Username        := 'email@yahoo.com.br';
            idSMTP1.Password        := 'senha';
        end;

        IdMessage.from.address              := idSMTP1.Username;
        IdMessage.recipients.emailaddresses := 'conectsolutions@hotmail.com';

        with idSMTP1 do
        begin
            IdSSL := nil;

            try
                port                := 465;
                IdSSL               := TIdSSLIOHandlerSocketOpenSSL.Create( nil );
                IdSMTP1.IOHandler   := IdSSL;
//                UseTLS              := utUseImplicitTLS;
                UseTLS              := utUseExplicitTLS;
            except on E: Exception do
                begin
                    IOHandler       := TIdIOHandler.MakeDefaultIOHandler( nil );
                    UseTLS          := utNoTLSSupport;
                end;
            end;

            if Assigned(IdSSL) then
            begin
                IdSSL.SSLOptions.Method := sslvSSLv3;
                IdSSL.SSLOptions.Mode   := sslmClient;
            end;

            AuthType := satDefault;
        end;
    end;

    //***************************** xxxxxxxxxxxxxxxx ***************************

    if ((cbtipo.itemindex = 1) or (cbtipo.itemindex = 3)) then
    begin
        // HOTMAIL e SERVIDOR PROPRIO

        idSMTP1.Port          := 587;

        if cbtipo.itemindex = 1 then
        begin
            idSMTP1.Host      := 'smtp.live.com';
            idSMTP1.Username  := 'conectsolutions@hotmail.com';
            idSMTP1.Password  := '12031974@';
        end
        else begin
            idSMTP1.Host      := 'smtp.servidorproprio.inf.br';
            idSMTP1.Username  := 'email@servidorproprio.inf.br';
            idSMTP1.Password  := 'senha';
        end;

        IdMessage.from.address              := idSMTP1.Username;
        IdMessage.recipients.emailaddresses := 'conectsolutions@hotmail.com';

        with idSMTP1 do
        begin
            IdSSL := nil;

            try
                IdSSL               := TIdSSLIOHandlerSocketOpenSSL.Create( nil );
                IdSMTP1.IOHandler   := IdSSL;
                UseTLS              := utUseExplicitTLS;

                IdSSL.SSLOptions.Method := sslvTLSv1;
                IdSSL.PassThrough       := true;
            except on E: Exception do
                begin
                    IOHandler   := TIdIOHandler.MakeDefaultIOHandler( nil );
                    UseTLS      := utNoTLSSupport;
                end;
            end;
        end;
    end;

    idSMTP1.Connect;

    try
        idSMTP1.send(IdMessage);
    except
        on E : Exception do
        begin
            Memo1.Lines.Add(e.Message);
        end;
    end;

    idSMTP1.Disconnect;

    IdMessage.Free;
    IdSMTP1.Free;
    ShowMessage('Enviado com sucesso. Aguarde Contra-senha.');
    Application.Terminate;

end;

procedure TFRMGERARSERIAL.Edit1Enter(Sender: TObject);
begin
  Gerarserial.Enabled:=True;
end;

procedure TFRMGERARSERIAL.FormActivate(Sender: TObject);
begin
  //PageControl1.ActivePageIndex:=0;
end;

procedure TFRMGERARSERIAL.FormCloseQuery(Sender: TObject;
var CanClose: Boolean);
begin
  Application.Terminate;
end;

procedure TFRMGERARSERIAL.FormShow(Sender: TObject);
begin
  Gerarserial.Enabled:=False;
  { with FDQuery3 do
   begin
       if FieldByName('contrasenha')<>0 then
          FDQuery
   end;}
   PageControl1.TabIndex:=0;
end;

end.
