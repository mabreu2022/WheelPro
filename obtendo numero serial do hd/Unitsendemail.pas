unit Unitsendemail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdComponent,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdBaseComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase,IdMessageClient, IdSMTPBase, IdSMTP, Vcl.ComCtrls,
  Vcl.Buttons, IdAttachmentFile,IdText, IdSSLOpenSSL,IdMessage;


type
  TForm1 = class(TForm)
    Button1: TButton;
    cbtipo: TComboBox;
    Memo1: TMemo;
    IdSMTP1: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdMessage1: TIdMessage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
    IdSMTP1: TIdSMTP;
    Idmessage: TIdMessage;
    TextoMsg: TidText;
    IdSSL: TIdSSLIOHandlerSocketOpenSSL;
begin
    IdSMTP1                 := TIdSMTP.create(nil);
    IdSMTP1.ConnectTimeout  := 10000;
    IdSMTP1.ReadTimeout     := 10000;

    IdMessage               := TIdMessage.create(nil);
    IdMessage.Clear;
    IdMessage.CharSet       := 'iso-8859-1';
    IdMessage.Encoding      := MeMIME;
    IdMessage.ContentType   := 'multipart/related'   ;
    IdMessage.subject       := 'Novo Serial Gerado';

    textomsg                := TIdText.Create(IdMessage.MessageParts);
    //textomsg.Body.Text      := 'Se você consegue ler isto então é porque funcionou o teste!';
    TextoMsg.Body.Text      :=Memo1.Lines.Text;
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
                UseTLS              := utUseImplicitTLS;
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
            idSMTP1.Username  := 'email@hotmail.com';
            idSMTP1.Password  := 'senha';
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
    ShowMessage('Enviado com sucesso!');

end;

end.
