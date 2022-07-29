program TransferenciaArquivo;

uses
  Vcl.Forms,
  TransferenciaArquivoThread in 'TransferenciaArquivoThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
