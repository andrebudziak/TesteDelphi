unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt;

type
  TDMConexao = class(TDataModule)
    fdConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDTransaction1: TFDTransaction;
    fdManager: TFDManager;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMConexao.DataModuleCreate(Sender: TObject);
var
  oList: TStringList;
begin
  oList := TStringList.Create;
  oList.Add('DriverID=MySQL');
  oList.Add('User_Name=root');
  oList.Add('Password=andre@123');
  oList.Add('Server=localhost');
  oList.Add('Port=3307');
  oList.Add('Database=Teste');
  fdManager.AddConnectionDef('myconn', 'MySQL', oList);
  fdConnection.ConnectionDefName := 'myconn';
end;

end.
