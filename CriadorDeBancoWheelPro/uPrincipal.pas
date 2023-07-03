unit uPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.UI,
  FireDAC.Phys.MySQL,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  System.StrUtils;

type
  TFrmPrincipal = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Panel1: TPanel;
    Button1: TButton;
    Memo1: TMemo;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DataSource1: TDataSource;
    Label2: TLabel;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    function ExtractDatabaseNameFromScript(const ScriptText: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.Button1Click(Sender: TObject);
var
  Connection: TFDConnection;
  Query: TFDQuery;
  ScriptFile: TStringList;
  OpenDialog: TOpenDialog;
  ScriptText: string;
  ScriptsPath: string;
  DatabaseName: string;
begin
  ScriptsPath := ExtractFilePath(Application.ExeName) + 'scripts\'; // Caminho para a pasta "scripts" da aplicação

  OpenDialog := TOpenDialog.Create(nil);
  OpenDialog.Filter := 'Arquivos SQL (*.sql)|*.sql'; // Filtro para selecionar apenas arquivos SQL
  OpenDialog.InitialDir := ScriptsPath; // Define a pasta inicial do OpenDialog como a pasta "scripts" da aplicação

  if OpenDialog.Execute then
  begin
    Connection := TFDConnection.Create(nil);
    try
      Connection.DriverName := 'MySQL'; // Driver do FireDAC para MySQL
      Connection.Params.Add('Server=localhost'); // Endereço do servidor MySQL
      Connection.Params.Add('User_Name=root'); // Usuário do MySQL
      Connection.Params.Add('Password=19741974'); // Senha do MySQL

      Connection.Connected := True;

      Query := TFDQuery.Create(nil);
      try
        Query.Connection := Connection;

        ScriptFile := TStringList.Create;
        try
          ScriptFile.LoadFromFile(OpenDialog.FileName); // Carrega o script do arquivo selecionado

          ScriptText := ScriptFile.Text; // Obtém o texto do script

          // Substitui o texto "fulanorodas2" pelo valor do TEdit (Edit1.Text)
          ScriptText := StringReplace(ScriptText, 'fulanorodas2', Edit1.Text, [rfReplaceAll]);

          Query.SQL.Text := ScriptText; // Define o script carregado como texto SQL do Query

          // Procura o nome do banco de dados dentro do script
          DatabaseName := ExtractDatabaseNameFromScript(ScriptText);

          if DatabaseName <> '' then
          begin
            // Adiciona informações ao Memo1.Text
            Memo1.Lines.Add('Criando o banco de dados: ' + DatabaseName);

            // Cria o banco de dados com o nome extraído
            Query.SQL.Text := 'CREATE SCHEMA IF NOT EXISTS `' + DatabaseName + '`';
            Query.ExecSQL;

            Memo1.Lines.Add('Banco de dados criado com sucesso.');

            // Adiciona informações ao Memo1.Text
            Memo1.Lines.Add('Executando o restante do script...');

            // Executa o restante do script
            Query.SQL.Text := ScriptText;
            Query.ExecSQL;

            // Adicionar registro à tabela de login
            Memo1.Lines.Add('Adicionando o usuario admin à tabela de login...');

            Query.SQL.Text :=
              'INSERT INTO login (usuario, senha, email, tipo, ativo, idcliente) ' +
              'VALUES (:usuario, :senha, :email, :tipo, :ativo, :idcliente)';
            Query.Params.ParamByName('usuario').AsString    := 'admin';
            Query.Params.ParamByName('senha').AsString      := '123';
            Query.Params.ParamByName('email').AsString      := Edit2.Text;
            Query.Params.ParamByName('tipo').AsString       := 'A';
            Query.Params.ParamByName('ativo').AsString      := 'S';
            Query.Params.ParamByName('idcliente').AsInteger := 1;
            Query.ExecSQL;

            Memo1.Lines.Add('Banco de dados criado e script executado com sucesso: ' + DatabaseName);

          end
          else
            ShowMessage('Não foi possível encontrar o nome do banco de dados no script.');

        finally
          ScriptFile.Free;
        end;
      finally
        Query.Free;
      end;
    finally
      Connection.Connected := False;
      Connection.Free;
    end;
  end;

  OpenDialog.Free;

end;

function TFrmPrincipal.ExtractDatabaseNameFromScript(const ScriptText: string): string;
var
  SchemaNameStartPos, SchemaNameEndPos: Integer;
  SchemaName: string;
begin
  // Procura a posição inicial do nome do esquema
  SchemaNameStartPos := Pos('CREATE SCHEMA IF NOT EXISTS `', ScriptText);
  if SchemaNameStartPos > 0 then
  begin
    // Avança até o fim do comando CREATE SCHEMA IF NOT EXISTS `
    SchemaNameStartPos := SchemaNameStartPos + Length('CREATE SCHEMA IF NOT EXISTS `');

    // Procura a posição do próximo caractere de crase (`) após o nome do esquema
    SchemaNameEndPos := PosEx('`', ScriptText, SchemaNameStartPos + 1);
    if SchemaNameEndPos > 0 then
    begin
      // Extrai o nome do esquema
      SchemaName := Copy(ScriptText, SchemaNameStartPos, SchemaNameEndPos - SchemaNameStartPos);
      Result := SchemaName;
    end
    else
      Result := '';
  end
  else
    Result := '';
end;

end.

