unit UFrmUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, sLabel, sMemo,
  Vcl.ComCtrls, sListView, sSkinProvider, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TFrmUpdate = class(TForm)
    sLV: TsListView;
    mmInfo: TsMemo;
    sLblInfo: TsLabel;
    sBtnDownload: TsButton;
    sSkinProvider: TsSkinProvider;
    sLblAuthor: TsLabel;
    sLblResource: TsLabel;
    sLblResourceLink: TsLabel;
    sLblLoadStatus: TsLabel;
    IdHTTP: TIdHTTP;
    sBtnDownloadTest: TsButton;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    Function AddLVItems: Integer;
    procedure sBtnDownloadTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUpdate: TFrmUpdate;

const
  URLSource =
    'https://api.github.com/repos/superbot-coder/ChiaPloterCalculator/releases';
  UserAgent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.17';

implementation

{$R *.dfm}
{ TFrmUpdate }

function TFrmUpdate.AddLVItems: Integer;
begin
  with sLV.Items.Add do
  begin
    Caption := IntToStr(Index + 1);
    Result := Index;
    SubItems.Add('');
  end;
end;

procedure TFrmUpdate.sBtnDownloadTestClick(Sender: TObject);
var
  ResultJson: String;
  IdHTTPUpdate: TIdHTTP;
  IOSSLUpdate: TIdSSLIOHandlerSocketOpenSSL;
begin
  IOSSLUpdate  := TIdSSLIOHandlerSocketOpenSSL.Create(OWner);
  IdHTTPUpdate := TIdHTTP.Create(OWner);
  IdHTTPUpdate.IOHandler := IOSSLUpdate;
  IdHTTPUpdate.Request.UserAgent := UserAgent;
  IOSSLUpdate.SSLOptions.Method  := sslvTLSv1;
  IdHTTPUpdate.AllowCookies      := True;
  try
    try
      ResultJson := IdHTTP.Get(URLSource);
      mmInfo.Lines.Add(ResultJson);
    Except
      on E: EIdHTTPProtocolException do
        mmInfo.Lines.Add('ќшибка: ' + E.Message);
    end;
  finally
    IdHTTPUpdate.Free;
    IOSSLUpdate.Free;
  end;
end;

end.
