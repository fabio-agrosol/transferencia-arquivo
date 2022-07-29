unit TransferenciaArquivoThread;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TTransferenciaArquivoThread = class;

  ITransferenciaObservador = interface
    // Alterei o nome do método para eliminar aviso de complitação na classe TPrincipalFrm
    // [dcc32 Warning] PrincipalForm.pas(42): W1010 Method 'Update' hides
    // virtual method of base type 'TWinControl'
    procedure UpdateTransfer(ASubject: TTransferenciaArquivoThread);
  end;

  TTransferenciaArquivoThread = class(TThread)
  private
    FObservers: TList<ITransferenciaObservador>;
    FNomeArquivo: string;
    FURL: string;
    FTamanho: Int64;
    FQuantidadeLida: Int64;
    procedure ReceiveDataEvent(const Sender: TObject; AContentLength: Int64;
      AReadCount: Int64; var Abort: Boolean);
  strict protected
    procedure NotifyObservers;
  protected
    procedure Execute; override;
  public
    property Tamanho: Int64 read FTamanho write FTamanho;
    property QuantidadeLida: Int64 read FQuantidadeLida write FQuantidadeLida;
    constructor Create(const URL, NomeArquivo: String);
    destructor Destroy; override;
    // Métodos para conectar/desconectar observadores
    procedure Attach(AObserver: ITransferenciaObservador);
    procedure Detach(AObserver: ITransferenciaObservador);
  end;

implementation


uses System.Net.HttpClient;

{ TBaixaArquivoThread }

procedure TTransferenciaArquivoThread.Attach(AObserver: ITransferenciaObservador);
begin
  FObservers.Add(AObserver);
end;

constructor TTransferenciaArquivoThread.Create(const URL, NomeArquivo: String);
begin
  inherited Create(True);
  FNomeArquivo := NomeArquivo;
  FURL := URL;
  FObservers := TList<ITransferenciaObservador>.Create;
end;

destructor TTransferenciaArquivoThread.Destroy;
begin
  FObservers.Free;
  inherited;
end;

procedure TTransferenciaArquivoThread.Detach(AObserver: ITransferenciaObservador);
var
  idx: Integer;
begin
  idx := FObservers.IndexOf(AObserver);
  If idx <> -1 Then
  begin
    FObservers.Delete(idx);
  end;
end;

procedure TTransferenciaArquivoThread.Execute;
var
  respostaHTTP: IHTTPResponse;
  LStream: TFileStream;
  clienteHTTP: THTTPClient;
begin
  inherited;
  clienteHTTP := THTTPClient.Create;
  try
    clienteHTTP.OnReceiveData := ReceiveDataEvent;
    LStream := TFileStream.Create(FNomeArquivo, fmCreate);
    try
      // Transferir o arquivo solicitado
      respostaHTTP := clienteHTTP.Get(FURL, LStream);
    finally
      LStream.Free;
    end;
  finally
    clienteHTTP.Free;
  end;
end;

procedure TTransferenciaArquivoThread.NotifyObservers;
var
  Current: ITransferenciaObservador;
begin
  for Current in FObservers do
  begin
    Current.UpdateTransfer(self);
  end;
end;

procedure TTransferenciaArquivoThread.ReceiveDataEvent(const Sender: TObject;
  AContentLength, AReadCount: Int64; var Abort: Boolean);
begin
  FTamanho := AContentLength;
  FQuantidadeLida := AReadCount;
  // Abortar a transferência quando o thread for terminando antecipadamente
  Abort := Terminated;
  // Notificar observadores quando ler um pacote de dados para atualizar o progresso
  NotifyObservers;
end;

end.
