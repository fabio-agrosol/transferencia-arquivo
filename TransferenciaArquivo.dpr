program TransferenciaArquivo;

uses
  Vcl.Forms,
  TransferenciaArquivoThread in 'TransferenciaArquivoThread.pas',
  CriadorBD in 'CriadorBD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
