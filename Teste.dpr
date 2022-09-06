program Teste;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uClassCliente in 'Model\uClassCliente.pas',
  uControllerCliente in 'Controller\uControllerCliente.pas',
  uClassProduto in 'Model\uClassProduto.pas',
  uClassPedido in 'Model\uClassPedido.pas',
  uClassPedidoItem in 'Model\uClassPedidoItem.pas',
  uControllerProduto in 'Controller\uControllerProduto.pas',
  uControllerPedido in 'Controller\uControllerPedido.pas',
  uControllerPedidoItem in 'Controller\uControllerPedidoItem.pas',
  uPedido in 'uPedido.pas' {frmPedido},
  uDMConexao in 'uDMConexao.pas' {DMConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
