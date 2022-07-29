program TransferenciaArquivo;

uses
  Vcl.Forms,
  TransferenciaArquivoThread in 'TransferenciaArquivoThread.pas',
  CriadorBD in 'CriadorBD.pas',
  TransfenciaData in 'TransfenciaData.pas' {dtmdlTransferencia: TDataModule},
  HistoricoForm in 'HistoricoForm.pas' {HistoricoFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdtmdlTransferencia, dtmdlTransferencia);
  Application.CreateForm(THistoricoFrm, HistoricoFrm);
  Application.Run;
end.
