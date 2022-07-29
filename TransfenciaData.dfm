object dtmdlTransferencia: TdtmdlTransferencia
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 196
  Width = 215
  object fdcnctnTransferencia: TFDConnection
    Params.Strings = (
      'Database=D:\projeto\fusion-teste-1\SQLite\transferencia.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 8
  end
  object fdqryLogDownload: TFDQuery
    Connection = fdcnctnTransferencia
    SQL.Strings = (
      'SELECT *'
      'FROM LOGDOWNLOAD')
    Left = 48
    Top = 64
    object fdqryLogDownloadCODIGO: TFMTBCDField
      DisplayWidth = 7
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Precision = 22
      Size = 0
    end
    object fdqryLogDownloadDATAINICIO: TDateField
      FieldName = 'DATAINICIO'
      Origin = 'DATAINICIO'
      Required = True
    end
    object fdqryLogDownloadDATAFIM: TDateField
      FieldName = 'DATAFIM'
      Origin = 'DATAFIM'
    end
    object fdqryLogDownloadURL: TStringField
      DisplayWidth = 300
      FieldName = 'URL'
      Origin = 'URL'
      Required = True
      Size = 600
    end
  end
  object fdqryChave: TFDQuery
    Connection = fdcnctnTransferencia
    SQL.Strings = (
      'SELECT MAX(CODIGO) AS MAX_CODIGO'
      'FROM LOGDOWNLOAD')
    Left = 48
    Top = 120
  end
end
