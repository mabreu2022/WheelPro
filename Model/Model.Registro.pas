unit Model.Registro;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Util,
  FireDAC.Stan.Param,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  Data.DB,
  Entity.Clientes,
  Entity.Contatos,
  System.Generics.Collections,
  Dao.ConexaoLicencas,
  Datasnap.DBClient,
  LogManager,
  FMX.Dialogs,
  System.IniFiles,
  IdSMTP,
  IdMessage,
  IdExplicitTLSClientServerBase,
  IdSSLOpenSSL,
  System.Win.ComObj,
  Winapi.ActiveX,
  System.Variants,
  FMX.Forms;


type
  TModelRegistro = class
    private
      Fconn: TFDConnection;
      qry: TFDQuery;
      Fcnpj: string;
      Femail: string;
      Fbairro: string;
      Fativo: string;
      Fuf: string;
      Fresponsavel: string;
      Fnumero: integer;
      Fcomplemento: string;
      Fcidade: string;
      Fendereco: string;
      Ftelefone: string;
      Frazao: string;
      Fdataregistro: TDatetime;
      FCEP: string;
      Fim: string;
      Fie: string;
      FLinguagem: string;
      Ftelcontato: string;
      Fcontato: string;
      Fserial: string;
      FOnLabel6TextChanged: TNotifyEvent;
      Fserialhd: string;
      FContraSenha: String;
      FData_exp: TDateTime;
      Fid_chave: string;
      procedure Setativo(const Value: string);
      procedure Setbairro(const Value: string);
      procedure Setcidade(const Value: string);
      procedure Setcnpj(const Value: string);
      procedure Setcomplemento(const Value: string);
      procedure Setemail(const Value: string);
      procedure Setendereco(const Value: string);
      procedure Setnumero(const Value: integer);
      procedure Setrazao(const Value: string);
      procedure Setresponsavel(const Value: string);
      procedure Settelefone(const Value: string);
      procedure Setuf(const Value: string);
      procedure Setdataregistro(const Value: TDatetime);
      procedure SetCEP(const Value: string);
      procedure Setie(const Value: string);
      procedure Setim(const Value: string);
      procedure SetLinguagem(const Value: string);
      procedure Setcontato(const Value: string);
      procedure Settelcontato(const Value: string);
      procedure Setserial(const Value: string);
      function  GetWMIstring(const WMIClass, WMIProperty:string): string;
      procedure SetOnLabel6TextChanged(const Value: TNotifyEvent);
      procedure Setserialhd(const Value: string);
      procedure SetContraSenha(const Value: String);
      procedure SetData_exp(const Value: TDateTime);
    procedure Setid_chave(const Value: string);
    public
      property razao       : string    read Frazao write Setrazao;
      property cnpj        : string    read Fcnpj write Setcnpj;
      property ie          : string    read Fie write Setie;
      property im          : string    read Fim write Setim;
      property endereco    : string    read Fendereco write Setendereco;
      property numero      : integer   read Fnumero write Setnumero;
      property complemento : string    read Fcomplemento write Setcomplemento;
      property bairro      : string    read Fbairro write Setbairro;
      property cidade      : string    read Fcidade write Setcidade;
      property uf          : string    read Fuf write Setuf;
      property CEP         : string    read FCEP write SetCEP;
      property ativo       : string    read Fativo write Setativo;
      property responsavel : string    read Fresponsavel write Setresponsavel;
      property contato     : string    read Fcontato write Setcontato;
      property telcontato  : string    read Ftelcontato write Settelcontato;
      property telefone    : string    read Ftelefone write Settelefone;
      property email       : string    read Femail write Setemail;
      property dataregistro: TDatetime read Fdataregistro write Setdataregistro;
      property Linguagem   : string    read FLinguagem write SetLinguagem;
      property serial      : string    read Fserial write Setserial;  //transferir do projeto antigo para esse
      property serialhd    : string    read Fserialhd write Setserialhd;
      property ContraSenha : String    read FContraSenha write SetContraSenha;
      property Data_exp    : TDateTime read FData_exp write SetData_exp;
      property id_chave    : string    read Fid_chave write Setid_chave;

      //Verificar se será necessário criar mais propertys para a tabela Registro
      property OnLabel6TextChanged: TNotifyEvent read FOnLabel6TextChanged write SetOnLabel6TextChanged;
      procedure enviarEmail; //Já chama  aqui a gravação no banco de  licenças
      function GerarSerial: string;
      class function validarDados(aRegistro: TModelRegistro ; aLingua: string) : boolean;
      class function GravarNoBancoLicencas(aRegistro : TModelRegistro): Boolean;  //Tabela Chaves
      class function ValidarLicenca(adata: TDateTime; acnpj: string): Boolean;
      class function GravarRegistro(aRegistro: TModelRegistro; achave: String): Boolean;
      class function GravarContraSenha(aRegistro: TModelRegistro): Boolean;

      constructor create;
      destructor destroy;override;

  end;

  var
  //FRMGERARSERIAL: TFRMGERARSERIAL;
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;

implementation

uses
  URegistrar; //ver se não vai dar problema de integridade referencial

{ TModelRegistro }

constructor TModelRegistro.create;
begin

end;

destructor TModelRegistro.destroy;
begin

  inherited;
end;

procedure TModelRegistro.enviarEmail;
var
  IdMessage      : TIdMessage;
  IdSMTP1        : TIdSMTP;
  IdSSLIOHandler : TIdSSLIOHandlerSocketOpenSSL;
  aRegistro      : TMOdelRegistro;
  Gravou         : Boolean;
begin
  IdSMTP1 := TIdSMTP.Create(nil);
  IdSMTP1.ConnectTimeout  := 10000;
  IdSMTP1.ReadTimeout     := 10000;

  IdSMTP1.Host      := 'smtp.gmail.com';//'smtp.office365.com';//'smtp.live.com';
  IdSMTP1.Port      := 587;
  IdSMTP1.Username  := 'mauricio.magosoft@gmail.com';
  IdSMTP1.Password  := 'arlxynudhkdznasd';
  IdSSLIOHandler    := Nil;
  IdSSLIOHandler    := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdSMTP1.IOHandler := IdSSLIOHandler;
  IdSMTP1.UseTLS    := utUseExplicitTLS;
  IdSMTP1.AuthType  := satDefault;

   if Assigned(IdSSLIOHandler) then
   begin
     IdSSLIOHandler.SSLOptions.Method := sslvSSLv23;
     IdSSLIOHandler.SSLOptions.Mode   := sslmClient;
   end;

  IdMessage := TIdMessage.Create(nil);
  try
    IdMessage.From.Address := 'mauricio.magosoft@gmail.com';
    IdMessage.Recipients.Add.Address := 'comercial@conectsolutionsti.com.br';
    IdMessage.Subject := 'Novo registro do Wheel Pro';

    // Construir o corpo da mensagem com os campos do formulário
    IdMessage.Body.Text :=
      'Razão:       '    + razao            + #13#10 +
      'CNPJ:        '    + cnpj             + #13#10 +
      'IE:          '    + ie               + #13#10 +
      'IM:          '    + im               + #13#10 +
      'Endereço:    '    + endereco         + #13#10 +
      'Número:      '    + IntToStr(numero) + #13#10 +
      'Complemento: '    + complemento      + #13#10 +
      'Bairro:      '    + bairro           + #13#10 +
      'Cidade:      '    + cidade           + #13#10 +
      'UF:          '    + uf               + #13#10 +
      'CEP:         '    + cep              + #13#10 +
      'Ativo:       '    + ativo            + #13#10 +
      'Responsável: '    + contato          + #13#10 +
      'Telefone:    '    + telcontato       + #13#10 +
      'Serial:      '    + Serial           + #13#10 +
      'E-mail:      '    + email;

      //Enviar o Serial do cliente para ser feita a validação na ferramenta externa

    // Envie o e-mail
    try
      IdSMTP1.Connect;
      IdSMTP1.Send(IdMessage);
      ShowMessage('Registro enviado com sucesso');

      aRegistro:= TModelRegistro.create;
      try
        aRegistro.razao       := razao;
        aRegistro.cnpj        := cnpj;
        aRegistro.ie          := ie;
        aRegistro.im          := im;
        aRegistro.endereco    := endereco;
        aRegistro.numero      := numero;
        aRegistro.complemento := complemento;
        aRegistro.bairro      := bairro;
        aRegistro.cidade      := cidade;
        aRegistro.uf          := uf;
        aRegistro.CEP         := cep;
        aRegistro.ativo       := ativo;
        aRegistro.contato     := contato;
        aRegistro.telcontato  := telcontato;
        aRegistro.email       := email;
        aRegistro.Linguagem   := linguagem;
        aRegistro.serial      := Serial;

        Gravou := GravarNoBancoLicencas(aRegistro);

        if Gravou then
        begin
          if linguagem='Portugues' then
            ShowMessage('Registro incluido com sucesso! Aguarde Retorno por E-mail da Conect com a chave do seu registro')
          else
            ShowMessage('Registration successfully added! Wait for an E-mail Return from Conect with your registration key');
        end;
      finally
        aRegistro.Free;
      end;

    Except
      On E: Exception do
      begin
        if linguagem='Portugues' then
          ShowMessage('Ocorreu um erro ao enviar o registro, entre em contato com o suporte comercial@conectsolutionsti.com.br' + e.Message)
        else
          ShowMessage('An error occurred while sending the record' + e.Message);
      end;

    end;

  finally
    IdMessage.Free;
    IdSMTP1.Free;
    IdSSLIOHandler.Free;
  end;

end;

function TModelRegistro.GerarSerial: string;
var
  x:string;
  Y:string;
  z:string;
  data : TDateTime;
  qry, qry2: TFDQuery;
  Registrarfrm: TFrmRegistrar;
begin
  Result:= '';
  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  FWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
  X:=Trim(GetWMIstring('Win32_BIOS','SerialNumber')); //Serial da Bios
  Y:=Trim(GetWMIstring('Win32_PhysicalMedia','SerialNumber')); //Serial do HD

  //label6.Caption:= x;
  //label4.Caption:= y;
  z:=x+y+(DateToStr(date));
  //label5.Caption:=z;
  Result:= z;

  qry:= TFDquery.Create(nil);
  qry.Connection  := TConexaoLicencas.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('select * from registro');
    qry.SQL.Add('');

    qry.ExecSQL;
    qry.Connection.Commit;

    with qry do

     //FDQuery1.Edit;
     //Desabilitar botao Geral Serial
     //Edit1.Enabled:=False;
     //BtnRegistrar.Enabled:=False;
     //Button1.Enabled:=False;
     //PageControl1.Pages[1].TabVisible := False;
     // fim


     qry.FieldByName('chave').AsString      := z;
     qry.FieldByName('Data_inc').AsDateTime := Date;
     Data := date;
     qry.FieldByName('Data_exp').AsDateTime:=Data;
     //ShowMessage(DateToStr(Data+30));
     qry.FieldByName('serialhd').AsString:=y;

     qry.FieldByName('ID_Chave').AsInteger := qry2.FieldByName('ID_Chave').AsInteger;

     qry.FieldByName('contrasenha').AsString:='0';
     qry.FieldByName('ativado').AsString:='N';
     qry.Post;

  finally
     qry.Free;
  end;

end;

function TModelRegistro.GetWMIstring(const WMIClass,
  WMIProperty: string): string;
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

class function TModelRegistro.GravarContraSenha(
  aRegistro: TModelRegistro): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  qry:= TFDQuery.Create(nil);
  qry.Connection := TConexaoLicencas.CreateConnection;
  //Checar se a CONTRASENHA Existe se não avisar ao usuário que a Contra Senha está errada e encerrar o programa?
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('select contrasenha from registro');
    qry.SQL.Add(' where contrasenha = :contrasenha');
    qry.ParamByName('contrasenha').DataType := ftString;
    qry.ParamByName('contrasenha').AsString := aRegistro.ContraSenha;
    qry.Open;

    if qry.RecordCount > 0 then //Encontrou a ContraSenha faz o update
    begin
      qry.Connection.StartTransaction;
      try
        qry.close;
        qry.SQL.Clear;

        qry.SQL.Text:='UPDATE LICENCAS.REGISTRO      ' +
                      'SET                           ' +
                     // 'ID           = :id,           ' +
                     // 'ID_CHAVE     = :ID_CHAVE,     ' +
                     // 'CHAVE        = :CHAVE,        ' +
                      'DATA_INC     = :DATA_INC,     ' +
                      'DATA_EXP     = :DATA_EXP,     ' +
                      'CONTRASENHA  = :CONTRASENHA,  ' +
                      'ATIVADO      = :ATIVADO,      ' +
                    //  'SERIALHD     = :SERIALHD      ' +
                      'WHERE                         ' +
                      'CONTRASENHA     = :CONTRASENHA      ';


        qry.ParamByName('DATA_INC').DataType     := ftDate;
        qry.ParamByName('DATA_INC').AsDateTime   := Now;
        qry.ParamByName('DATA_EXP').DataType     := ftDate;
        qry.ParamByName('DATA_EXP').AsDate       := aRegistro.Data_exp + 30;
        qry.ParamByName('CONTRASENHA').DataType  := ftString;
        qry.ParamByName('CONTRASENHA').AsString  := aRegistro.ContraSenha;
        qry.ParamByName('ATIVADO').DataType      := ftString;
        qry.ParamByName('ATIVADO').AsString      := aRegistro.ativo;

        qry.ExecSQL;
        qry.Connection.Commit;

        Result := True;
      Except
      On E: Exception do
        begin
           Showmessage('Erro ao gravar tabela registro!'+ E.Message);
           qry.Connection.Rollback;
           Result := False;
        end;
      end;
    end
    else //Não encontrou a Contrasenha
    begin
       ShowMessage('Contra senha não existe, favor entrar em contato com o suporte!');
       Application.Terminate;
    end;
  finally
    qry.Free;
  end;

end;

class function TModelRegistro.GravarNoBancoLicencas(
  aRegistro: TModelRegistro): Boolean;
var
  qry   : TFDQuery;
  Ativo : string;
  UF    : string;
  idChave : integer;
begin
  //Testar se a Licença já existe no banco de dados  buscar pelo cnpj  trazer o id e pesquisar na tabela registro
  //Se já existir o cnpj na tabela chaves e estiver aguardando a gravação da contrasenha na tabela registro o que fazer?
  // Informar o usuário que está aguardando a contrasenha e pular fora?
  qry:= TFDquery.Create(nil);
  qry.Connection := TConexaoLicencas.CreateConnection;
  qry.Connection.StartTransaction;
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('Select * from chaves');
    qry.SQL.Add(' where cnpj =:cnpj');
    qry.ParamByName('cnpj').DataType := ftString;
    qry.ParamByName('cnpj').AsString := aRegistro.cnpj;
    qry.Open;

    if qry.RecordCount > 0 then //O registro dos dados do cliente existe na tabela chaves
    begin
      ShowMessage('Registro encontrado');
      idChave:= qry.FieldByName('id_chave').AsInteger;

      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('Select contrasenha from registro');
      qry.SQL.Add(' where id_chave=:id_chave');
      qry.ParamByName('id_chave').DataType  := ftInteger;
      qry.ParamByName('id_chave').AsInteger := idChave;
      qry.Open;

      if (qry.RecordCount > 0) and (qry.fieldbyname('contrasenha').AsString='') then
      begin
          //Gravar no Banco primeiro registro
          qry:= TFDquery.Create(nil);
          qry.Connection := TConexaoLicencas.CreateConnection;
          qry.Connection.StartTransaction;
          try
            qry.Close;
            qry.SQL.Clear;
            qry.SQL.Add('INSERT INTO      ' +
                        ' licencas.chaves ' +
                        '(id_chave,       ' + //1
                        'razao,           ' + //2
                        'cnpj,            ' + //3
                        'ie,              ' + //4
                        'im,              ' + //5
                        'endereco,        ' + //6
                        'numero,          ' + //7
                        'complemento,     ' + //8
                        'bairro,          ' + //9
                        'cidade,          ' + //10
                        'cep,             ' + //11
                        'uf,              ' + //12
                        'ativo,           ' + //13
                        'contato,         ' + //14
                        'telcontato,      ' + //15
                        'email,           ' + //16
                        'datacadastro,    ' + //17
                        'dataalteracao    ' + //18
                       // 'dataexclusao   ' + //19
                        ')                ' +
                        'VALUES (         ' +
                        ':id_chave,       ' + //1 ok
                        ':razao,          ' + //2 ok
                        ':cnpj,           ' + //3 ok
                        ':ie,             ' + //4 ok
                        ':im,             ' + //5 ok
                        ':endereco,       ' + //6 ok
                        ':numero,         ' + //7 ok
                        ':complemento,    ' + //8 ok
                        ':bairro,         ' + //9 ok
                        ':cidade,         ' + //10 ok
                        ':cep,            ' + //11 ok
                        ':uf,             ' + //12 ok
                        ':ativo,          ' + //13 ok
                        ':contato,        ' + //14
                        ':telcontato,     ' + //15
                        ':email,          ' + //16
                        ':datacadastro,   ' + //17 ok
                        ':dataalteracao   ' + //18 ok
                      //  ':dataexclusao, ' + //19 ok
                        ')                ');

             qry.ParamByName('id_chave').DataType    := ftInteger;             //1
             qry.ParamByName('razao').DataType       := ftString;
             qry.ParamByName('razao').AsString       := aRegistro.razao;       //2
             qry.ParamByName('cnpj').DataType        := ftString;
             qry.ParamByName('cnpj').AsString        := aRegistro.cnpj ;       //3
             qry.ParamByName('ie').DataType          := ftString;
             qry.ParamByName('ie').AsString          := aRegistro.ie;          //4
             qry.ParamByName('im').DataType          := ftString;
             qry.ParamByName('im').AsString          := aRegistro.im;          //5
             qry.ParamByName('endereco').DataType    := ftString;
             qry.ParamByName('endereco').AsString    := aRegistro.endereco;    //6
             qry.ParamByName('numero').DataType      := ftInteger;
             qry.ParamByName('numero').AsInteger     := aRegistro.numero;      //7
             qry.ParamByName('complemento').DataType := ftString;
             qry.ParamByName('complemento').AsString := aRegistro.complemento; //8
             qry.ParamByName('cep').DataType         := ftString;
             qry.ParamByName('cep').AsString         := aRegistro.CEP;         //9
             qry.ParamByName('cidade').DataType      := ftString;
             qry.ParamByName('cidade').AsString      := aRegistro.Cidade;      //10
             qry.ParamByName('bairro').DataType      := ftString;
             qry.ParamByName('bairro').AsString      := aRegistro.Bairro;      //11
             qry.ParamByName('uf').DataType          := ftString;
             if Length(aRegistro.UF) > 0 then
               UF := Copy(aRegistro.UF, 1, 2)
             else
               UF := '';

             qry.ParamByName('uf').AsString          := UF;                    //12

             qry.ParamByName('ativo').DataType       := ftString;
             if Length(aRegistro.ativo) > 0 then
               Ativo := Copy(aRegistro.ativo, 1, 1)
             else
               Ativo := '';

             qry.ParamByName('ativo').AsString       := Ativo;                 //13

             qry.ParamByName('contato').DataType     := ftString;
             qry.ParamByName('contato').AsString     := aRegistro.contato;     //14

             qry.ParamByName('telcontato').DataType     := ftString;
             qry.ParamByName('telcontato').AsString     := aRegistro.telcontato; //15

             qry.ParamByName('email').DataType     := ftString;
             qry.ParamByName('email').AsString     := aRegistro.email;           //16

             qry.ParamByName('datacadastro').DataType  := ftDateTime;
             qry.ParamByName('datacadastro').AsDateTime:= Now;                 //17

             qry.ParamByName('dataalteracao').DataType  := ftDateTime;         //18
             qry.ParamByName('dataalteracao').AsDateTime:= Now;

        //     qry.ParamByName('dataexclusao').DataType := ftDateTime;
        //     qry.ParamByName('dataexclusao').AsDateTime:= aCliente.dataExclusao; //19

             qry.ExecSQL;
             qry.Connection.Commit;

             Result := True;
          Except
           On E: Exception do
              begin
                if aRegistro.Linguagem='Portugues' then
                  ShowMessage('Erro ao tentar gravar licença!' + E.Message)
                else
                  ShowMessage('Error trying to write license!!' + E.Message);

                qry.Connection.Rollback;
                qry.Free;
              end;

          end;
//          qry.Free;

          //gravar na tabela Registros
          GravarRegistro(aRegistro, aRegistro.serial);
      end
      else //O Registro existe na Tabela Registro mas está sem contrasenha
      begin
        ShowMessage('Entre em contato com o suporte para verificar a validação da sua licença.');
      end;

    end
    else //Não existe o registro dos dados do cliente na tabela Chaves.
    begin
      //Gravar o primeiro registro e enviar e-mail avisando que o cliente novo se cadastrou

          qry:= TFDquery.Create(nil);
          qry.Connection := TConexaoLicencas.CreateConnection;
          qry.Connection.StartTransaction;
          try
            qry.Close;
            qry.SQL.Clear;
            qry.SQL.Add('INSERT INTO      ' +
                        ' licencas.chaves ' +
                        '(id_chave,       ' + //1
                        'razao,           ' + //2
                        'cnpj,            ' + //3
                        'ie,              ' + //4
                        'im,              ' + //5
                        'endereco,        ' + //6
                        'numero,          ' + //7
                        'complemento,     ' + //8
                        'bairro,          ' + //9
                        'cidade,          ' + //10
                        'cep,             ' + //11
                        'uf,              ' + //12
                        'ativo,           ' + //13
                        'contato,         ' + //14
                        'telcontato,      ' + //15
                        'email,           ' + //16
                        'datacadastro,    ' + //17
                        'dataalteracao    ' + //18
                       // 'dataexclusao   ' + //19
                        ')                ' +
                        'VALUES (         ' +
                        ':id_chave,       ' + //1 ok
                        ':razao,          ' + //2 ok
                        ':cnpj,           ' + //3 ok
                        ':ie,             ' + //4 ok
                        ':im,             ' + //5 ok
                        ':endereco,       ' + //6 ok
                        ':numero,         ' + //7 ok
                        ':complemento,    ' + //8 ok
                        ':bairro,         ' + //9 ok
                        ':cidade,         ' + //10 ok
                        ':cep,            ' + //11 ok
                        ':uf,             ' + //12 ok
                        ':ativo,          ' + //13 ok
                        ':contato,        ' + //14
                        ':telcontato,     ' + //15
                        ':email,          ' + //16
                        ':datacadastro,   ' + //17 ok
                        ':dataalteracao   ' + //18 ok
                      //  ':dataexclusao, ' + //19 ok
                        ')                ');

             qry.ParamByName('id_chave').DataType    := ftInteger;             //1
             qry.ParamByName('razao').DataType       := ftString;
             qry.ParamByName('razao').AsString       := aRegistro.razao;       //2
             qry.ParamByName('cnpj').DataType        := ftString;
             qry.ParamByName('cnpj').AsString        := aRegistro.cnpj ;       //3
             qry.ParamByName('ie').DataType          := ftString;
             qry.ParamByName('ie').AsString          := aRegistro.ie;          //4
             qry.ParamByName('im').DataType          := ftString;
             qry.ParamByName('im').AsString          := aRegistro.im;          //5
             qry.ParamByName('endereco').DataType    := ftString;
             qry.ParamByName('endereco').AsString    := aRegistro.endereco;    //6
             qry.ParamByName('numero').DataType      := ftInteger;
             qry.ParamByName('numero').AsInteger     := aRegistro.numero;      //7
             qry.ParamByName('complemento').DataType := ftString;
             qry.ParamByName('complemento').AsString := aRegistro.complemento; //8
             qry.ParamByName('cep').DataType         := ftString;
             qry.ParamByName('cep').AsString         := aRegistro.CEP;         //9
             qry.ParamByName('cidade').DataType      := ftString;
             qry.ParamByName('cidade').AsString      := aRegistro.Cidade;      //10
             qry.ParamByName('bairro').DataType      := ftString;
             qry.ParamByName('bairro').AsString      := aRegistro.Bairro;      //11
             qry.ParamByName('uf').DataType          := ftString;
             if Length(aRegistro.UF) > 0 then
               UF := Copy(aRegistro.UF, 1, 2)
             else
               UF := '';

             qry.ParamByName('uf').AsString          := UF;                    //12

             qry.ParamByName('ativo').DataType       := ftString;
             if Length(aRegistro.ativo) > 0 then
               Ativo := Copy(aRegistro.ativo, 1, 1)
             else
               Ativo := '';

             qry.ParamByName('ativo').AsString       := Ativo;                 //13

             qry.ParamByName('contato').DataType     := ftString;
             qry.ParamByName('contato').AsString     := aRegistro.contato;     //14

             qry.ParamByName('telcontato').DataType     := ftString;
             qry.ParamByName('telcontato').AsString     := aRegistro.telcontato; //15

             qry.ParamByName('email').DataType     := ftString;
             qry.ParamByName('email').AsString     := aRegistro.email;           //16

             qry.ParamByName('datacadastro').DataType  := ftDateTime;
             qry.ParamByName('datacadastro').AsDateTime:= Now;                 //17

             qry.ParamByName('dataalteracao').DataType  := ftDateTime;         //18
             qry.ParamByName('dataalteracao').AsDateTime:= Now;

        //     qry.ParamByName('dataexclusao').DataType := ftDateTime;
        //     qry.ParamByName('dataexclusao').AsDateTime:= aCliente.dataExclusao; //19

             qry.ExecSQL;
             qry.Connection.Commit;

             Result := True;
          Except
           On E: Exception do
              begin
                if aRegistro.Linguagem='Portugues' then
                  ShowMessage('Erro ao tentar gravar licença!' + E.Message)
                else
                  ShowMessage('Error trying to write license!!' + E.Message);

                qry.Connection.Rollback;
                qry.Free;
              end;

          end;
//          qry.Free;

          //gravar na tabela Registros
          GravarRegistro(aRegistro, aRegistro.serial);

      ShowMessage('Não foram localizados seus dados no sistema.Favor entrar em contato com o suporte comercial@conectsolutionsti.com.br');
    end;

  finally
    qry.Free;
  end;


end;

class function TModelRegistro.GravarRegistro(
  aRegistro: TModelRegistro; achave: String): Boolean;
var
  qry: TFDQuery;
  data: TDateTime;
begin
  qry:= TFDQuery.Create(nil);
  qry.Connection := TConexaoLicencas.CreateConnection;
  qry.Connection.StartTransaction;
  try
     qry.SQL.Clear;
     qry.SQL.Add('INSERT INTO REGISTRO      ' +
                 '(id,                      ' +
                 'id_chave,                 ' +
                 'chave,                    ' +
                 'data_inc,                 ' +
                 'data_exp,                 ' +
                 'contrasenha,              ' +
                 'ativado,                  ' +
                 'serialhd                  ' +
               //  'WHERE id_chave =:id_chave ' +
                 ')                         ' +
                 'VALUES (                  ' +
                 ':id,                      ' +
                 ':id_chave,                ' +
                 ':chave,                   ' +
                 ':data_inc,                ' +
                 ':data_exp,                ' +
                 ':contrasenha,             ' +
                 ':ativado,                 ' +
                 ':serialhd                 ' +
                 ')                         ');

     qry.ParamByName('id').DataType :=ftinteger;
     qry.ParamByName('id_chave').DataType:= ftInteger;

     qry.ParamByName('chave').DataType     := ftString;
     qry.ParamByName('chave').AsString      := aChave;

     qry.ParamByName('Data_inc').DataType   := ftDateTime;
     qry.ParamByName('Data_inc').AsDateTime := Date;

     Data := Date;

     qry.ParamByName('Data_exp').DataType    := ftDateTime;
     qry.ParamByName('Data_exp').AsDateTime  :=Data;

     //ShowMessage(DateToStr(Data+30));
     qry.ParamByName('serialhd').DataType    := ftDateTime;
     qry.ParamByName('serialhd').AsString    :=aRegistro.serialhd;

     qry.ParamByName('contrasenha').AsString :='0';
     qry.ParamByName('ativado').AsString     :='N';

     //Ver como fazer?
     //qry.ParamByName('id_chave').AsInteger := //qry2.FieldByName('ID_Chave').AsInteger;

     qry.ExecSQL;
     qry.Connection.Commit;

     Result := True;
  Except
  On E: Exception do
    begin
       Showmessage('Erro ao gravar tabela registro!'+ E.Message);
       qry.Connection.Rollback;
       Result := False;
    end;
  end;
end;

procedure TModelRegistro.Setativo(const Value: string);
begin
  Fativo := Value;
end;

procedure TModelRegistro.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TModelRegistro.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TModelRegistro.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TModelRegistro.Setcnpj(const Value: string);
begin
  Fcnpj := Value;
end;

procedure TModelRegistro.Setcomplemento(const Value: string);
begin
  Fcomplemento := Value;
end;

procedure TModelRegistro.Setcontato(const Value: string);
begin
  Fcontato := Value;
end;

procedure TModelRegistro.SetContraSenha(const Value: String);
begin
  FContraSenha := Value;
end;

procedure TModelRegistro.Setdataregistro(const Value: TDatetime);
begin
  Fdataregistro := Value;
end;

procedure TModelRegistro.SetData_exp(const Value: TDateTime);
begin
  FData_exp := Value;
end;

procedure TModelRegistro.Setemail(const Value: string);
begin
  Femail := Value;
end;

procedure TModelRegistro.Setendereco(const Value: string);
begin
  Fendereco := Value;
end;

procedure TModelRegistro.Setid_chave(const Value: string);
begin
  Fid_chave := Value;
end;

procedure TModelRegistro.Setie(const Value: string);
begin
  Fie := Value;
end;

procedure TModelRegistro.Setim(const Value: string);
begin
  Fim := Value;
end;

procedure TModelRegistro.SetLinguagem(const Value: string);
begin
  FLinguagem := Value;
end;

procedure TModelRegistro.Setnumero(const Value: integer);
begin
  Fnumero := Value;
end;

procedure TModelRegistro.SetOnLabel6TextChanged(const Value: TNotifyEvent);
begin
  FOnLabel6TextChanged := Value;
end;

procedure TModelRegistro.Setrazao(const Value: string);
begin
  Frazao := Value;
end;

procedure TModelRegistro.Setresponsavel(const Value: string);
begin
  Fresponsavel := Value;
end;

procedure TModelRegistro.Setserial(const Value: string);
begin
  Fserial := Value;
end;

procedure TModelRegistro.Setserialhd(const Value: string);
begin
  Fserialhd := Value;
end;

procedure TModelRegistro.Settelcontato(const Value: string);
begin
  Ftelcontato := Value;
end;

procedure TModelRegistro.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

procedure TModelRegistro.Setuf(const Value: string);
begin
  Fuf := Value;
end;

class function TModelRegistro.validarDados(aRegistro: TModelRegistro ; aLingua: string) : boolean;
begin
   Result := False;

  if Trim(aRegistro.Frazao) = '' then
  begin
    if aLingua='Portugues' then
      raise Exception.Create('a Razão Social não pode ser vazia.')
    else
      raise Exception.Create('the Social Reason cannot be empty.');  //verificar s a tradução para o que seria razão social nos EUA
    Result:= False;
    exit;
  end;

  //se não for ingles nao validar cnpj/cpf
  if aLingua<>'Ingles' then
  begin
    if Trim(aRegistro.cnpj) = '' then
    begin
      raise Exception.Create('o CNPJ/CPF não pode ser vazio.');
      Result:= False;
      exit;
    end;
  end;

  if Trim(aRegistro.Endereco) = '' then
  begin
    if aLingua='Portugues' then
      raise Exception.Create('É necessário prencher o campo Endereço.')
    else
      raise Exception.Create('You must fill in the Address field.');
    Result:= False;
    exit;
  end;

  if Trim(aRegistro.Bairro) = '' then
  begin
    if aLingua='Portugues' then
      raise Exception.Create('É necessário preencher o campo Bairro.')
    else
      raise Exception.Create('You must fill in the District field.');
    Result:= False;
    exit;
  end;

  if Trim(aRegistro.Cidade) = '' then
  begin
    if aLingua='Portugues' then
      raise Exception.Create('É necessário preencher o campo Cidade.')
    else
      raise Exception.Create('You must fill in the City field.');
    Result:= False;
    exit;
  end;

  if aLingua='Portugues' then //pular caso EUA
  begin
    if aRegistro.CEP.Length < 8  then
    begin
      if aLingua='Portugues' then
        raise Exception.Create('O CEP não pode ser menor que 8 caracteres.')
      else
        raise Exception.Create('Zip code cannot be less than 8 characters.');   //qual o tamanho do capo nos EUA???
      Result:= False;
      exit;
    end;
  end;

  if Trim(aRegistro.uf) = '' then
  begin
    raise Exception.Create('É necessário preencher a UF.');
    Result:= False;
    exit;
  end;

  Result:= True;

end;

class function TModelRegistro.ValidarLicenca(adata: TDateTime; acnpj: string): Boolean;
var
  qry       : TFDQuery;
  dataAtual : string;
begin
  Result := False;
  qry:= TFDQuery.Create(nil);
  qry.Connection := TConexaoLicencas.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('Select R.*, C.* from registro R ');
    qry.SQL.Add('join chaves C on(C.id_chave = R.id_chave)' );
    qry.SQL.Add('WHERE C.cnpj = :cnpj');
    qry.SQL.Add(' and  data_exp < :DataAtual');
    qry.SQL.Add(' and  contrasenha<>''0''');
    qry.ParamByName('cnpj').AsString := acnpj;

    // Formate a data atual como uma string no formato 'YYYY/MM/DD'
    dataAtual := FormatDateTime('YYYY/MM/DD', adata);
    qry.ParamByName('DataAtual').AsString := dataAtual;

    qry.Open;

    if Qry.RecordCount > 0 then
      Result:= True  //Sistema Válido
    else
      Result:= False; //Sistema Expirado

  finally
    qry.Free;
  end;
end;

end.
