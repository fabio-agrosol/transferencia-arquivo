unit TransferenciaArquivoThreadTest;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTransferenciaArquivoThreadTest = class(TObject)
  public
    [Test]
    procedure TransferirTest;
  end;

implementation

uses
  TransferenciaArquivoThread, System.SysUtils, System.IOUtils;

{ TTransferenciaArquivoThreadTest }

procedure TTransferenciaArquivoThreadTest.TransferirTest;
var
  Transfencia: TTransferenciaArquivoThread;
  URL: string;
  NomeArquivo: string;
  arquivoExiste: Boolean;
begin
  URL := 'https://nl.archive.ubuntu.com/ubuntu-cdimages/20.04/release/SHA256SUMS';
  NomeArquivo := TPath.Combine(TPath.GetDocumentsPath, 'SHA256SUMS');
  Transfencia := TTransferenciaArquivoThread.Create(URL, NomeArquivo);
  try
    Transfencia.Start;
    Transfencia.WaitFor;
    arquivoExiste := FileExists(NomeArquivo);
    Assert.AreEqual(True, arquivoExiste);
  finally
    Transfencia.Free;
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TTransferenciaArquivoThreadTest);

end.
