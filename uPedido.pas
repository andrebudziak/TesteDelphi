unit uPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmConexao, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uClassPedido,uControllerPedido, uClassPedidoItem, uControllerPedidoItem,
  System.Generics.Collections, Data.Bind.Components, Data.Bind.ObjectScope,
  Data.Bind.Controls, Datasnap.DBClient, Data.Bind.DBScope, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Bind.Navigator, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.DBCtrls,System.RTTI,
  uClassCliente, uControllerCliente, uClassProduto, uControllerProduto ;

type
  TfrmPedido = class(TForm)
    PCPedido: TPageControl;
    tsLista: TTabSheet;
    tsEdicao: TTabSheet;
    dbgDados: TDBGrid;
    pnBottom: TPanel;
    PCPedidoItem: TPageControl;
    TsPedidoItemDados: TTabSheet;
    TsEdicaoPedidoItem: TTabSheet;
    dbgPedidoItem: TDBGrid;
    Label1: TLabel;
    edNumero: TEdit;
    Label2: TLabel;
    lblNomeCliente: TLabel;
    lblValorTotal: TLabel;
    Label5: TLabel;
    dsPedido: TDataSource;
    cdsPedido: TClientDataSet;
    dsPedidoItem: TDataSource;
    cdsPedidoItem: TClientDataSet;
    DBNavigatorPedido: TDBNavigator;
    Label6: TLabel;
    edCodigoCliente: TEdit;
    dtpDataEmissao: TDateTimePicker;
    cdsPedidoNumero: TIntegerField;
    cdsPedidoCodigo_Cliente: TIntegerField;
    cdsPedidoData_Emissao: TDateField;
    cdsPedidoValor_Total: TFloatField;
    cdsPedidoCodigo: TIntegerField;
    Label3: TLabel;
    edCodigoProduto: TEdit;
    Label4: TLabel;
    edValorItem: TEdit;
    Label7: TLabel;
    edQtdItem: TEdit;
    lblDescricaoProduto: TLabel;
    cdsPedidoItemCodigo: TIntegerField;
    cdsPedidoItemCodigo_Pedido: TIntegerField;
    cdsPedidoItemCodigo_Produto: TIntegerField;
    cdsPedidoItemQtd: TIntegerField;
    cdsPedidoItemValor: TFloatField;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    cdsPedidoItemTotal: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure cdsPedidoAfterScroll(DataSet: TDataSet);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure cdsPedidoItemAfterScroll(DataSet: TDataSet);
    procedure edCodigoClienteExit(Sender: TObject);
    procedure cdsPedidoNewRecord(DataSet: TDataSet);
    procedure cdsPedidoItemNewRecord(DataSet: TDataSet);
    procedure edCodigoProdutoExit(Sender: TObject);
    procedure dbgPedidoItemDblClick(Sender: TObject);
    procedure cdsPedidoBeforePost(DataSet: TDataSet);
    procedure cdsPedidoItemCalcFields(DataSet: TDataSet);
    procedure cdsPedidoItemBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    oLPedido: TObjectList<TPedido>;
    oPedido : TPedido;
    oControlePedido: TControlePedido;
    oLPedidoItem: TObjectList<TPedidoItem>;
    oPedidoItem : TPedidoItem;
    oControlePedidoItem: TControlePedidoItem;
    procedure PreencherDataSetPedido;
    procedure PreencherCamposPedido(Pedido: TPedido);
    procedure PreencherDataSetPedidoItem;
    procedure PreencherCamposPedidoItem(PedidoItem: TPedidoItem);

  public
    { Public declarations }

  end;

var
  frmPedido: TfrmPedido;

implementation

{$R *.dfm}

procedure TfrmPedido.cdsPedidoAfterScroll(DataSet: TDataSet);
begin
  if cdsPedido.RecNo > -1 then
    PreencherCamposPedido(oLPedido[Pred(cdsPedido.RecNo)]);
end;

procedure TfrmPedido.cdsPedidoBeforePost(DataSet: TDataSet);
var
  oPedido :TPedido;
  oControler :TControlePedido;
begin
  oPedido   := TPedido.Create;
  oControler := TControlePedido.Create;
  try
    oPedido.Codigo         := cdsPedidoCodigo.AsInteger;
    oPedido.Codigo_Cliente := cdsPedidoCodigo_Cliente.AsInteger;
    oPedido.Numero         := cdsPedidoNumero.AsInteger;
    oPedido.Data_Emissao   := cdsPedidoData_Emissao.AsDateTime;
    oPedido.ValorTotal     := cdsPedidoValor_Total.AsFloat;
    oControler.Salvar(oPedido);
  finally
    FreeAndNil(oPedido);
    FreeAndNil(oControler);
  end;
end;

procedure TfrmPedido.cdsPedidoItemAfterScroll(DataSet: TDataSet);
begin
  if cdsPedidoItem.RecNo > -1 then
    PreencherCamposPedidoItem(oLPedidoItem[Pred(cdsPedidoItem.RecNo)]);
end;

procedure TfrmPedido.cdsPedidoItemBeforePost(DataSet: TDataSet);
var
  oPedidoItem :TPedidoItem;
  oControler :TControlePedidoItem;
begin
  oPedidoItem := TPedidoItem.Create;
  oControler  := TControlePedidoItem.Create;
  try
    cdsPedido.Edit;
    cdsPedidoValor_Total.AsFloat := cdsPedidoItemTotal.AsFloat;

    oPedidoItem.Codigo         := cdsPedidoItemCodigo.AsInteger;
    oPedidoItem.Codigo_Produto := cdsPedidoItemCodigo_Produto.AsInteger;
    oPedidoItem.Quantidade     := cdsPedidoItemQtd.AsInteger;
    oPedidoItem.Valor          := cdsPedidoItemValor.AsFloat;
    oControler.Salvar(oPedidoItem);
  finally
    FreeAndNil(oPedido);
    FreeAndNil(oControler);
  end;
end;

procedure TfrmPedido.cdsPedidoItemCalcFields(DataSet: TDataSet);
begin
  cdsPedidoItemTotal.AsFloat := cdsPedidoItemTotal.AsFloat + (cdsPedidoItemValor.AsFloat * cdsPedidoItemQtd.AsInteger);
end;

procedure TfrmPedido.cdsPedidoItemNewRecord(DataSet: TDataSet);
var
  oPedidoItem :TPedidoItem;
  oControler :TControlePedidoItem;
begin
  oPedidoItem   := TPedidoItem.Create;
  oControler := TControlePedidoItem.Create;
  try
    oPedidoItem.Codigo_Pedido := cdsPedidoCodigo.AsInteger;
    cdsPedidoItemCodigo.AsInteger := oControler.BuscarNovoPedido(oPedidoItem);
  finally
    FreeAndNil(oPedido);
    FreeAndNil(oControler);
  end;
end;

procedure TfrmPedido.cdsPedidoNewRecord(DataSet: TDataSet);
var
  oPedido :TPedido;
  oControler :TControlePedido;
begin
  oPedido   := TPedido.Create;
  oControler := TControlePedido.Create;
  try
    cdsPedidoCodigo.AsInteger := oControler.BuscarNovoPedido(oPedido);
    cdsPedidoNumero.AsInteger := oControler.BuscarNovoNumero(oPedido);
  finally
    FreeAndNil(oPedido);
    FreeAndNil(oControler);
  end;
end;

procedure TfrmPedido.dbgDadosDblClick(Sender: TObject);
begin
  edNumero.Text        := cdsPedidoNumero.AsString;
  edCodigoCliente.Text := cdsPedidoCodigo_Cliente.AsString;
  dtpDataEmissao.Date  := cdsPedidoData_Emissao.AsDateTime;
  lblValorTotal.Caption:= cdsPedidoValor_Total.AsString;

  oPedidoItem  := TPedidoItem.Create;
  oControlePedidoItem := TControlePedidoItem.Create;
  oLPedidoItem := TObjectList<TPedidoItem>.Create;
  try
    oPedidoItem.Codigo_Pedido := cdsPedidoCodigo.AsInteger;
    oLPedidoItem := oControlePedidoItem.Buscar(oPedidoItem);
    PreencherDataSetPedidoItem;
  finally
  end;

  tsEdicao.Show;
end;

procedure TfrmPedido.dbgPedidoItemDblClick(Sender: TObject);
begin
  edCodigoProduto.Text := cdsPedidoItemCodigo_Produto.AsString;
  edValorItem.Text     := cdsPedidoItemValor.AsString;
  edQtdItem.Text       := cdsPedidoItemQtd.AsString;
  TsEdicaoPedidoItem.Show;
end;

procedure TfrmPedido.edCodigoClienteExit(Sender: TObject);
var
  oCliente,oRCliente :TCliente;
  oControler :TControleCliente;
  oLCliente  :TObjectList<TCliente>;
begin
  oCliente   := TCliente.Create;
  oRCliente   := TCliente.Create;
  oControler := TControleCliente.Create;
  try
    oCliente.Codigo := StrToIntDef(edCodigoCliente.Text,0);
    oRCliente := oControler.Buscar(oCliente);
    if oRCliente.Codigo = 0 then
    begin
      raise Exception.Create('Cliente não encontrado');
    end
    else
    begin
      edCodigoCliente.Text   := IntToStr(oRCliente.Codigo);
      lblNomeCliente.Caption := oRCliente.Nome;
    end;
  finally
    FreeAndNil(oCliente);
    FreeAndNil(oRCliente);
    FreeAndNil(oControler);
  end;
end;

procedure TfrmPedido.edCodigoProdutoExit(Sender: TObject);
var
  oProduto,oRProduto :TProduto;
  oControler :TControleProduto;
  oLProduto  :TObjectList<TProduto>;
begin
  oProduto   := TProduto.Create;
  oRProduto   := TProduto.Create;
  oControler := TControleProduto.Create;
  try
    oProduto.Codigo := StrToIntDef(edCodigoProduto.Text,0);
    oRProduto := oControler.Buscar(oProduto);
    if oRProduto.Codigo = 0 then
    begin
      raise Exception.Create('Produto não encontrado');
    end
    else
    begin
      edCodigoProduto.Text   := IntToStr(oRProduto.Codigo);
      lblDescricaoProduto.Caption     := oRProduto.Descricao;
    end;
  finally
    FreeAndNil(oProduto);
    FreeAndNil(oRProduto);
    FreeAndNil(oControler);
  end;
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
  oLPedido := TObjectList<TPedido>.Create;
  oPedido  := TPedido.Create;
  oControlePedido := TControlePedido.Create;
  try
    oLPedido := oControlePedido.Listar(oPedido);
    PreencherDataSetPedido;
  finally
  end;
end;

procedure TfrmPedido.PreencherCamposPedido(Pedido: TPedido);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Valor: variant;
  Componente: TComponent;
begin
  Contexto := TRttiContext.Create;
  Tipo := Contexto.GetType(TPedido.ClassInfo);
  try
    for Propriedade in Tipo.GetProperties do
    begin
      Valor := Propriedade.GetValue(Pedido).AsVariant;
      Componente := FindComponent('Campo' + Propriedade.Name);
      if Componente is TEdit then
        (Componente as TEdit).Text := Valor;
      if Componente is TComboBox then
        (Componente as TComboBox).ItemIndex := (Componente as TComboBox).Items.IndexOf(Valor);
      if Componente is TRadioGroup then
        (Componente as TRadioGroup).ItemIndex := (Componente as TRadioGroup).Items.IndexOf(Valor);
      if Componente is TCheckBox then
        (Componente as TCheckBox).Checked := Valor;
      if Componente is TDateTimePicker then
        (Componente as TDateTimePicker).Date := Valor;
    end;
  finally
    Contexto.Free;
  end;
end;

procedure TfrmPedido.PreencherCamposPedidoItem(PedidoItem: TPedidoItem);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Valor: variant;
  Componente: TComponent;
begin
  Contexto := TRttiContext.Create;
  Tipo := Contexto.GetType(TPedido.ClassInfo);
  try
    for Propriedade in Tipo.GetProperties do
    begin
      Valor := Propriedade.GetValue(PedidoItem).AsVariant;
      Componente := FindComponent('Campo' + Propriedade.Name);
      if Componente is TEdit then
        (Componente as TEdit).Text := Valor;
      if Componente is TComboBox then
        (Componente as TComboBox).ItemIndex := (Componente as TComboBox).Items.IndexOf(Valor);
      if Componente is TRadioGroup then
        (Componente as TRadioGroup).ItemIndex := (Componente as TRadioGroup).Items.IndexOf(Valor);
      if Componente is TCheckBox then
        (Componente as TCheckBox).Checked := Valor;
      if Componente is TDateTimePicker then
        (Componente as TDateTimePicker).Date := Valor;
    end;
  finally
    Contexto.Free;
  end;
end;

procedure TfrmPedido.PreencherDataSetPedido;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  pCodigo,pCodigoCliente,pDataEmissao,pValorTotal,pNumero: TRttiProperty;
  Pedido: TPedido;
begin
  Contexto := TRttiContext.Create;
  try
    Tipo := Contexto.GetType(TPedido.ClassInfo);
    pCodigo        := Tipo.GetProperty('Codigo');
    pCodigoCliente := Tipo.GetProperty('Codigo_Cliente');
    pDataEmissao   := Tipo.GetProperty('Data_Emissao');
    pValorTotal    := Tipo.GetProperty('Valor_Total');
    pNumero        := Tipo.GetProperty('Numero');

    for Pedido in oLPedido do
    begin
      cdsPedido.AppendRecord([pCodigo.GetValue(Pedido).AsVariant]);
      cdsPedido.AppendRecord([pCodigoCliente.GetValue(Pedido).AsVariant]);
      cdsPedido.AppendRecord([pDataEmissao.GetValue(Pedido).AsVariant]);
      cdsPedido.AppendRecord([pValorTotal.GetValue(Pedido).AsVariant]);
      cdsPedido.AppendRecord([pNumero.GetValue(Pedido).AsVariant]);
    end;
    if cdsPedido.IsEmpty then
      cdsPedido.CreateDataSet
    else
      cdsPedido.First;
  finally
    Contexto.Free;
  end;
end;

procedure TfrmPedido.PreencherDataSetPedidoItem;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  pCodigo,pCodigoPedido,pCodigoProduto,pValor,pQtd: TRttiProperty;
  PedidoItem: TPedidoItem;
begin
  Contexto := TRttiContext.Create;
  try
    Tipo := Contexto.GetType(TPedidoItem.ClassInfo);
    pCodigo        := Tipo.GetProperty('Codigo');
    pCodigoPedido  := Tipo.GetProperty('Codigo_Pedido');
    pCodigoProduto := Tipo.GetProperty('Codigo_Produto');
    pValor         := Tipo.GetProperty('Valor');
    pQtd           := Tipo.GetProperty('Qtd');

    for PedidoItem in oLPedidoItem do
    begin
      cdsPedido.AppendRecord([pCodigo.GetValue(PedidoItem).AsVariant]);
      cdsPedido.AppendRecord([pCodigoPedido.GetValue(PedidoItem).AsVariant]);
      cdsPedido.AppendRecord([pCodigoProduto.GetValue(PedidoItem).AsVariant]);
      cdsPedido.AppendRecord([pValor.GetValue(PedidoItem).AsVariant]);
      cdsPedido.AppendRecord([pQtd.GetValue(PedidoItem).AsVariant]);
    end;
    if cdsPedidoItem.IsEmpty then
      cdsPedidoItem.CreateDataSet
    else
      cdsPedidoItem.First;
  finally
    Contexto.Free;
  end;
end;

end.
