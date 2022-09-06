object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  Caption = 'Pedido'
  ClientHeight = 403
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnShow = FormShow
  TextHeight = 15
  object PCPedido: TPageControl
    Left = 0
    Top = 0
    Width = 780
    Height = 363
    ActivePage = tsEdicao
    Align = alClient
    TabOrder = 0
    object tsLista: TTabSheet
      Caption = 'Lista'
      object dbgDados: TDBGrid
        Left = 0
        Top = 0
        Width = 772
        Height = 333
        Align = alClient
        DataSource = dsPedido
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = dbgDadosDblClick
      end
    end
    object tsEdicao: TTabSheet
      Caption = 'Edicao'
      ImageIndex = 1
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 44
        Height = 15
        Caption = 'Numero'
      end
      object Label2: TLabel
        Left = 16
        Top = 74
        Width = 46
        Height = 15
        Caption = 'Emiss'#227'o:'
      end
      object lblNomeCliente: TLabel
        Left = 127
        Top = 45
        Width = 15
        Height = 15
        Caption = '***'
      end
      object lblValorTotal: TLabel
        Left = 72
        Top = 103
        Width = 15
        Height = 15
        Caption = '***'
      end
      object Label5: TLabel
        Left = 16
        Top = 103
        Width = 25
        Height = 15
        Caption = 'Total'
      end
      object Label6: TLabel
        Left = 16
        Top = 45
        Width = 37
        Height = 15
        Caption = 'Cliente'
      end
      object PCPedidoItem: TPageControl
        Left = 0
        Top = 140
        Width = 772
        Height = 193
        ActivePage = TsPedidoItemDados
        Align = alBottom
        TabOrder = 0
        object TsPedidoItemDados: TTabSheet
          Caption = 'Dados Item'
          object dbgPedidoItem: TDBGrid
            Left = 0
            Top = 38
            Width = 764
            Height = 125
            Align = alClient
            DataSource = dsPedidoItem
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnDblClick = dbgPedidoItemDblClick
          end
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 764
            Height = 38
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object DBNavigator1: TDBNavigator
              Left = 0
              Top = 2
              Width = 760
              Height = 35
              DataSource = dsPedidoItem
              TabOrder = 0
            end
          end
        end
        object TsEdicaoPedidoItem: TTabSheet
          Caption = 'Edicao Item'
          ImageIndex = 1
          object Label3: TLabel
            Left = 12
            Top = 24
            Width = 43
            Height = 15
            Caption = 'Produto'
          end
          object Label4: TLabel
            Left = 12
            Top = 53
            Width = 26
            Height = 15
            Caption = 'Valor'
          end
          object Label7: TLabel
            Left = 12
            Top = 82
            Width = 23
            Height = 15
            Caption = 'Qtd.'
          end
          object lblDescricaoProduto: TLabel
            Left = 123
            Top = 24
            Width = 15
            Height = 15
            Caption = '***'
          end
          object edCodigoProduto: TEdit
            Left = 68
            Top = 21
            Width = 49
            Height = 23
            TabOrder = 0
            OnExit = edCodigoProdutoExit
          end
          object edValorItem: TEdit
            Left = 68
            Top = 50
            Width = 93
            Height = 23
            TabOrder = 1
          end
          object edQtdItem: TEdit
            Left = 68
            Top = 79
            Width = 49
            Height = 23
            TabOrder = 2
          end
        end
      end
      object edNumero: TEdit
        Left = 72
        Top = 13
        Width = 49
        Height = 23
        TabOrder = 1
      end
      object edCodigoCliente: TEdit
        Left = 72
        Top = 42
        Width = 49
        Height = 23
        TabOrder = 2
        OnExit = edCodigoClienteExit
      end
      object dtpDataEmissao: TDateTimePicker
        Left = 72
        Top = 71
        Width = 130
        Height = 23
        Date = 44809.000000000000000000
        Time = 0.457387083333742300
        TabOrder = 3
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 363
    Width = 780
    Height = 40
    Align = alBottom
    TabOrder = 1
    object DBNavigatorPedido: TDBNavigator
      Left = 4
      Top = 2
      Width = 770
      Height = 35
      DataSource = dsPedido
      TabOrder = 0
    end
  end
  object dsPedido: TDataSource
    DataSet = cdsPedido
    Left = 260
    Top = 66
  end
  object cdsPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsPedidoBeforePost
    AfterScroll = cdsPedidoAfterScroll
    OnNewRecord = cdsPedidoNewRecord
    Left = 340
    Top = 66
    object cdsPedidoCodigo: TIntegerField
      FieldName = 'Codigo'
      Visible = False
    end
    object cdsPedidoCodigo_Cliente: TIntegerField
      FieldName = 'Codigo_Cliente'
      Visible = False
    end
    object cdsPedidoData_Emissao: TDateField
      FieldName = 'Data_Emissao'
    end
    object cdsPedidoValor_Total: TFloatField
      FieldName = 'Valor_Total'
    end
    object cdsPedidoNumero: TIntegerField
      FieldName = 'Numero'
    end
  end
  object dsPedidoItem: TDataSource
    DataSet = cdsPedidoItem
    Left = 564
    Top = 66
  end
  object cdsPedidoItem: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsPedidoItemBeforePost
    AfterScroll = cdsPedidoItemAfterScroll
    OnCalcFields = cdsPedidoItemCalcFields
    OnNewRecord = cdsPedidoItemNewRecord
    Left = 648
    Top = 66
    object cdsPedidoItemCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsPedidoItemCodigo_Pedido: TIntegerField
      FieldName = 'Codigo_Pedido'
    end
    object cdsPedidoItemCodigo_Produto: TIntegerField
      FieldName = 'Codigo_Produto'
    end
    object cdsPedidoItemQtd: TIntegerField
      FieldName = 'Qtd'
    end
    object cdsPedidoItemValor: TFloatField
      FieldName = 'Valor'
    end
    object cdsPedidoItemTotal: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Total'
      Calculated = True
    end
  end
end
