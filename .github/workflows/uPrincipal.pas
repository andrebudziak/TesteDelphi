unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Vcl.Menus ,System.Generics.Collections,
  uPedido, uDmConexao, uClassCliente,uControllerCliente,uClassProduto,uControllerProduto;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Pedido1: TMenuItem;
    procedure Pedido1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure CriaClientes;
    procedure CriaProdutos;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.CriaClientes;
var
  oLCliente: TObjectList<TCliente>;
  oCliente,oNewCliente : TCliente;
  oControle: TControleCliente;
  i :Integer;
begin
  oLCliente := TObjectList<TCliente>.Create;
  oCliente  := TCliente.Create;
  oControle := TControleCliente.Create;
  try
    oLCliente := oControle.Listar(oCliente);
    if oLCliente.Count = 0 then
    begin
       for i := 0 to 19 do
       begin
         oNewCliente := TCliente.Create;
         oNewCliente.Nome   := 'Teste'+IntToStr(1);
         oNewCliente.Cidade := 'Curitiba';
         oNewCliente.Uf     := 'PR';
         oControle.Salvar(oNewCliente);
         FreeAndNil(oNewCliente);
       end;

    end;
  finally
    FreeAndNil(oCliente);
    FreeAndNil(oLCliente);
    FreeAndNil(oControle);
  end;

end;

procedure TfrmPrincipal.CriaProdutos;
var
  oLProduto: TObjectList<TProduto>;
  oProduto,oNewProduto : TProduto;
  oControle: TControleProduto;
  i :Integer;
  valor : Float32;
begin
  oLProduto := TObjectList<TProduto>.Create;
  oProduto  := TProduto.Create;
  oControle := TControleProduto.Create;
  try
    oLProduto := oControle.Listar(oProduto);
    if oLProduto.Count = 0 then
    begin
       for i := 0 to 19 do
       begin
         valor := i*100+10;
         oNewProduto           := TProduto.Create;
         oNewProduto.Descricao := 'Produto'+IntToStr(1);
         oNewProduto.PrecoVenda:= valor;
         oControle.Salvar(oNewProduto);
         FreeAndNil(oNewProduto);
       end;

    end;
  finally
    FreeAndNil(oProduto);
    FreeAndNil(oLProduto);
    FreeAndNil(oControle);
  end;

end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  CriaClientes;
  CriaProdutos;
end;

procedure TfrmPrincipal.Pedido1Click(Sender: TObject);
 var
 Dlg : TfrmPedido;
begin
  Dlg := TfrmPedido.Create( Self );
  try
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

end.
