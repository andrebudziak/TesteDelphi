object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  WindowState = wsMaximized
  OnShow = FormShow
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 200
    Top = 40
    object N1: TMenuItem
      Caption = 'Cadastro'
      object Pedido1: TMenuItem
        Caption = 'Pedido'
        OnClick = Pedido1Click
      end
    end
  end
end
