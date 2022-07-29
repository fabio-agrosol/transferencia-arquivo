object HistoricoFrm: THistoricoFrm
  Left = 1
  Top = 270
  Caption = 'Hist'#243'rico'
  ClientHeight = 231
  ClientWidth = 864
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 864
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 700
    object dbnvgrLogDownload: TDBNavigator
      Left = 8
      Top = 8
      Width = 220
      Height = 25
      DataSource = dtsrcLogDownload
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 0
    end
  end
  object dbgrdLogDownload: TDBGrid
    Left = 0
    Top = 41
    Width = 864
    Height = 190
    Align = alClient
    DataSource = dtsrcLogDownload
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dtsrcLogDownload: TDataSource
    DataSet = dtmdlTransferencia.fdqryLogDownload
    Left = 248
    Top = 120
  end
end
