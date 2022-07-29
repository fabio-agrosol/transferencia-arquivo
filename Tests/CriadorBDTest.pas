unit CriadorBDTest;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TCriadorBDTest = class(TObject)
  public
    [Test]
    procedure CriarTest;
  end;

implementation

uses
  CriadorBD, System.SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  System.IOUtils;

procedure TCriadorBDTest.CriarTest;
var
  criador: TCriadorBD;
  nomeArquivo: string;
  arquivoExiste: Boolean;
begin
  nomeArquivo := TPath.Combine(TPath.GetDocumentsPath, 'transferencia.db');
  TCriadorBD.criar(nomeArquivo);
  arquivoExiste := fileexists(nomeArquivo);
  Assert.AreEqual(True, arquivoExiste);
end;

initialization

TDUnitX.RegisterTestFixture(TCriadorBDTest);

end.
