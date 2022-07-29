unit PrincipalForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Net.HttpClient,
  Vcl.ComCtrls, TransferenciaArquivoThread, System.Actions, Vcl.ActnList,
  Vcl.ToolWin;

type
  TPrincipalFrm = class(TForm, ITransferenciaObservador)
    edtNomeArquivo: TEdit;
    edtURL: TEdit;
    prgrsbrProgresso: TProgressBar;
    actlstAcao: TActionList;
    actnIniciarDownload: TAction;
    actnExibirMensagem: TAction;
    actnPararDownload: TAction;
    actnExibirHistorico: TAction;
    tlbFerramenta: TToolBar;
    btnIniciarDownload: TToolButton;
    btnExibirMensagem: TToolButton;
    btnPararDownload: TToolButton;
    btnExibirHistorico: TToolButton;
    lblURL: TLabel;
    lblNomeArquivo: TLabel;
    lblProgresso: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actnIniciarDownloadExecute(Sender: TObject);
    procedure actnExibirMensagemExecute(Sender: TObject);
    procedure actnPararDownloadExecute(Sender: TObject);
    procedure actnExibirHistoricoExecute(Sender: TObject);
    procedure edtURLExit(Sender: TObject);
  private
    { Private declarations }
    FCodigo: Integer;
    FParado: Boolean;
    transferencia: TTransferenciaArquivoThread;
    procedure UpdateTransfer(ASubject: TTransferenciaArquivoThread);
    procedure configurarAcoes(habilitado: Boolean);
    procedure TerminateThread(Sender: TObject);
  public
    { Public declarations }
  end;

var
  PrincipalFrm: TPrincipalFrm;

implementation

uses
  System.IOUtils, HistoricoForm, TransfenciaData;

{$R *.dfm}

procedure TPrincipalFrm.actnExibirHistoricoExecute(Sender: TObject);
begin
  HistoricoFrm.Show;
end;

procedure TPrincipalFrm.actnExibirMensagemExecute(Sender: TObject);
begin
  ShowMessage(Format('%.1n%%', [transferencia.QuantidadeLida /
    transferencia.Tamanho * 100]));
end;

procedure TPrincipalFrm.actnIniciarDownloadExecute(Sender: TObject);
begin
  FParado := False;
  // Criar um thread para transferir o arquivo
  transferencia := TTransferenciaArquivoThread.Create(edtURL.Text,
    edtNomeArquivo.Text);
  transferencia.OnTerminate := TerminateThread;
  // Associar o formulário para atualizar a barra de progressso
  transferencia.Attach(Self);
  transferencia.Start;
  configurarAcoes(False);
  FCodigo := dtmdlTransferencia.inserir(edtURL.Text);
end;

procedure TPrincipalFrm.actnPararDownloadExecute(Sender: TObject);
begin
  FParado := True;
  transferencia.Terminate;
  configurarAcoes(True);
end;

procedure TPrincipalFrm.configurarAcoes(habilitado: Boolean);
begin
  actnIniciarDownload.Enabled := habilitado;
  actnExibirMensagem.Enabled := not habilitado;
  actnPararDownload.Enabled := not habilitado;
end;

procedure TPrincipalFrm.edtURLExit(Sender: TObject);
var
  posicao: Integer;
begin
  // Copiar a última parte da URL para o nome do arquivo
  posicao := LastDelimiter('/', edtURL.Text);
  edtNomeArquivo.Text := TPath.Combine(TPath.GetDocumentsPath,
    Copy(edtURL.Text, posicao + 1))
end;

procedure TPrincipalFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  resultado: Integer;
begin
  CanClose := True;
  if Assigned(transferencia) then
  begin
    if not transferencia.Finished then
    begin
      resultado := MessageDlg
        ('Existe um download em andamento, deseja interrompe-lo?',
        mtConfirmation, mbYesNo, 0);
      if resultado = mrYes then
      begin
        // Terminar a thread quando usuário responder Sim
        transferencia.Terminate;
        repeat
          Application.ProcessMessages;
          Sleep(1);
        until (transferencia.Finished);
      end
      else
        CanClose := False;
    end;
  end;
end;

procedure TPrincipalFrm.FormCreate(Sender: TObject);
var
  FNomeArquivo: string;
  FURL: string;
begin
  FURL := 'https://az764295.vo.msecnd.net/stable/78a4c91400152c0f27ba4d363eb56d2835f9903a/VSCodeUserSetup-x64-1.43.0.exe';
  FNomeArquivo := TPath.Combine(TPath.GetDocumentsPath,
    'VSCodeUserSetup-x64-1.43.0.exe');
  edtURL.Text := FURL;
  edtNomeArquivo.Text := FNomeArquivo;
end;

procedure TPrincipalFrm.TerminateThread(Sender: TObject);
begin
  configurarAcoes(True);
  if not FParado then
    dtmdlTransferencia.finalizar(FCodigo);
end;


procedure TPrincipalFrm.UpdateTransfer(ASubject: TTransferenciaArquivoThread);
begin
  // Atualizar barra de progresso
  prgrsbrProgresso.Max := ASubject.Tamanho;
  prgrsbrProgresso.Position := ASubject.QuantidadeLida;
end;

end.
