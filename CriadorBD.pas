unit CriadorBD;

interface

type
  TCriadorBD = class
  public
    class procedure criar(const nomeArquivo: string);
  end;

implementation

uses
  FireDAC.Comp.Client;

const
  CREATE_LOG_DOWNLOAD =
    'CREATE TABLE [logdownload]( ' +
    '  [CODIGO] NUMBER(22, 0) PRIMARY KEY NOT NULL, ' +
    '  [URL] VARCHAR2(600) NOT NULL, ' +
    '  [DATAINICIO] DATE NOT NULL, ' +
    '  [DATAFIM] DATE); ';

{ TCriadorBD }

class procedure TCriadorBD.criar(const nomeArquivo: string);
var
  fdcnctnBD: TFDConnection;
begin
  fdcnctnBD := TFDConnection.Create(nil);
  try
    // Criar a base de dados e a tabela logdownload
    fdcnctnBD.Params.Add('Database=' + nomeArquivo);
    fdcnctnBD.Params.Add('DriverID=SQLite');
    fdcnctnBD.LoginPrompt := False;
    fdcnctnBD.Open();
    fdcnctnBD.ExecSQL(CREATE_LOG_DOWNLOAD);
  finally
    fdcnctnBD.Free;
  end;
end;

end.
