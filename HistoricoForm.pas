unit HistoricoForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  THistoricoFrm = class(TForm)
    pnlTopo: TPanel;
    dbgrdLogDownload: TDBGrid;
    dtsrcLogDownload: TDataSource;
    dbnvgrLogDownload: TDBNavigator;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HistoricoFrm: THistoricoFrm;

implementation

uses
  TransfenciaData;

{$R *.dfm}

end.
