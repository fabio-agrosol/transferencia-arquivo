unit TransfenciaData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdtmdlTransferencia = class(TDataModule)
    fdcnctnTransferencia: TFDConnection;
    fdqryLogDownload: TFDQuery;
    fdqryLogDownloadCODIGO: TFMTBCDField;
    fdqryLogDownloadURL: TStringField;
    fdqryLogDownloadDATAINICIO: TDateField;
    fdqryLogDownloadDATAFIM: TDateField;
    fdqryChave: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function gerarCodigo: Integer;
  public
    { Public declarations }
    function inserir(const URL: string): integer;
    procedure finalizar(codigo: Integer);
  end;

var
  dtmdlTransferencia: TdtmdlTransferencia;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses System.IOUtils, CriadorBD;

{ TdtmdlTransferencia }

procedure TdtmdlTransferencia.DataModuleCreate(Sender: TObject);
var
  nomeArquivo: string;
begin
  nomeArquivo := TPath.Combine(TPath.GetDocumentsPath, 'transferencia.db');
  if not FileExists(nomeArquivo) then
  begin
    TCriadorBD.criar(nomeArquivo);
  end;
  fdcnctnTransferencia.Params.Values['Database'] := nomeArquivo;
  fdcnctnTransferencia.Open();
  fdqryLogDownload.Open();
end;

procedure TdtmdlTransferencia.finalizar(codigo: Integer);
begin
  if fdqryLogDownload.Locate('CODIGO', codigo, []) then
  begin
    fdqryLogDownload.Edit;
    fdqryLogDownloadDATAFIM.Value := Date;
    fdqryLogDownload.Post;
  end;
end;

function TdtmdlTransferencia.gerarCodigo: Integer;
begin
  fdqryChave.Open();
  try
    Result := StrToIntDef(fdqryChave.Fields[0].AsString, 0) + 1;
  finally
    fdqryChave.Close;
  end;
end;

function TdtmdlTransferencia.inserir(const URL: string): integer;
begin
  Result := gerarCodigo;
  fdqryLogDownload.Append;
  fdqryLogDownloadCODIGO.AsInteger := Result;
  fdqryLogDownloadURL.AsString := URL;
  fdqryLogDownloadDATAINICIO.Value := Now;
  fdqryLogDownload.Post;
end;

end.
