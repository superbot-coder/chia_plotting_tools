unit UFrmViewLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sMemo;

type
  TFrmViewLog = class(TForm)
    mm: TsMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmViewLog: TFrmViewLog;

implementation

{$R *.dfm}

end.
