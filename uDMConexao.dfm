object DMConexao: TDMConexao
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object fdConnection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'User_Name=root'
      'Password=andre@123'
      #39'Server=localhost'
      'Port=3307'
      'Database=Teste')
    LoginPrompt = False
    Transaction = FDTransaction1
    UpdateTransaction = FDTransaction1
    Left = 42
    Top = 16
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\temp\Teste_Delphi\libmysql.dll'
    Left = 200
    Top = 32
  end
  object FDTransaction1: TFDTransaction
    Connection = fdConnection
    Left = 288
    Top = 144
  end
  object fdManager: TFDManager
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 200
    Top = 176
  end
end
