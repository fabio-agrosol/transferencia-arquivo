object PrincipalFrm: TPrincipalFrm
  Left = 1
  Top = 1
  Caption = 'Transfer'#234'ncia de Arquivo'
  ClientHeight = 176
  ClientWidth = 864
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    864
    176)
  PixelsPerInch = 96
  TextHeight = 13
  object lblURL: TLabel
    Left = 8
    Top = 30
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object lblNomeArquivo: TLabel
    Left = 8
    Top = 72
    Width = 82
    Height = 13
    Caption = 'Nome do Arquivo'
  end
  object lblProgresso: TLabel
    Left = 8
    Top = 120
    Width = 48
    Height = 13
    Caption = 'Progresso'
  end
  object edtNomeArquivo: TEdit
    Left = 8
    Top = 91
    Width = 847
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    ExplicitWidth = 681
  end
  object edtURL: TEdit
    Left = 8
    Top = 45
    Width = 847
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    OnExit = edtURLExit
    ExplicitWidth = 681
  end
  object prgrsbrProgresso: TProgressBar
    Left = 8
    Top = 136
    Width = 848
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    ExplicitWidth = 682
  end
  object tlbFerramenta: TToolBar
    Left = 0
    Top = 0
    Width = 864
    Height = 24
    ButtonHeight = 21
    ButtonWidth = 147
    Caption = 'tlbFerramenta'
    ShowCaptions = True
    TabOrder = 3
    ExplicitWidth = 698
    object btnIniciarDownload: TToolButton
      Left = 0
      Top = 0
      Action = actnIniciarDownload
    end
    object btnExibirMensagem: TToolButton
      Left = 147
      Top = 0
      Action = actnExibirMensagem
    end
    object btnPararDownload: TToolButton
      Left = 294
      Top = 0
      Action = actnPararDownload
    end
    object btnExibirHistorico: TToolButton
      Left = 441
      Top = 0
      Action = actnExibirHistorico
    end
  end
  object actlstAcao: TActionList
    Left = 624
    Top = 40
    object actnIniciarDownload: TAction
      Caption = 'Iniciar Download'
      OnExecute = actnIniciarDownloadExecute
    end
    object actnExibirMensagem: TAction
      Caption = 'Exibir Mensagem'
      Enabled = False
      OnExecute = actnExibirMensagemExecute
    end
    object actnPararDownload: TAction
      Caption = 'Parar Download'
      Enabled = False
      OnExecute = actnPararDownloadExecute
    end
    object actnExibirHistorico: TAction
      Caption = 'Exibir Hist'#243'rico de Downloads'
      OnExecute = actnExibirHistoricoExecute
    end
  end
end
