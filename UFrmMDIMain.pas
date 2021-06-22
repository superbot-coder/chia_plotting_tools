unit UFrmMDIMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  System.IniFiles, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, sMemo,
  sSkinManager, sLabel, sEdit, Vcl.ComCtrls, sComboBoxes, Vcl.Samples.Spin,
  Winapi.ShellApi, System.ImageList, Vcl.ImgList, GetVer,
  Vcl.ExtCtrls, sPanel, sPageControl, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sToolEdit, sCheckBox, DosCommand, StrUtils, sDialogs, sComboBox, sRadioButton,
  System.Actions, Vcl.ActnList, Vcl.Menus, sStatusBar, acPageScroller, Error,
  sTabControl, Vcl.Tabs;

type
  TFrmMain = class(TForm)
    sSkinManager: TsSkinManager;
    ImageListBtn: TImageList;
    ActionList: TActionList;
    ActExit: TAction;
    ActShowFrmCalculator: TAction;
    sStatusBar: TsStatusBar;
    MainMenu: TMainMenu;
    Main: TMenuItem;
    MM_Exit: TMenuItem;
    ActShowFrmPlotter: TAction;
    Biew: TMenuItem;
    ActCloceAllTask: TAction;
    ActFrmChildCascade: TAction;
    MM_FrmCascade: TMenuItem;
    ActFrmChildHorizontal: TAction;
    MM_FrmChildHorizontal: TMenuItem;
    MM_FrmChildVertical: TMenuItem;
    ActFrmChildVertical: TAction;
    TabSet: TTabSet;
    MM_Help: TMenuItem;
    MM_Update: TMenuItem;
    MM_FrmCalculator: TMenuItem;
    MM_FrmPlotter: TMenuItem;
    MM_Splitter: TMenuItem;
    procedure FormCreate(Sender: TObject);
    function GetPlotter: String;
    procedure GetWalletsKeyID;
    procedure SetingsView;
    procedure ActShowFrmCalculatorExecute(Sender: TObject);
    procedure ActShowFrmPlotterExecute(Sender: TObject);
    procedure ActFrmChildCascadeExecute(Sender: TObject);
    procedure ActFrmChildHorizontalExecute(Sender: TObject);
    procedure ActFrmChildVerticalExecute(Sender: TObject);
    procedure AddLog(StrValue: String);
    procedure TabSetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActExitExecute(Sender: TObject);
    procedure MM_UpdateClick(Sender: TObject);
  private
    { Private declarations }
    FirstActivate: Boolean;
  public
    { Public declarations }
  end;

type
  TPlotsType = (K32, K33, K34);

var
  FrmMain: TFrmMain;
  // aPlots: Array[TPlotsType] of real = (108.9, 224.2, 461.5); // GB
  aPlots: Array [TPlotsType] of Int64 = (
    108900000000,
    224200000000,
    461500000000
  ); // GB
  аPlotsStr: Array [TPlotsType] of String = (
    'K32',
    'K33',
    'K34'
  );
  aPlotsMaxCount: Array [TPlotsType] of DWORD;
  aDefaultRamSz: Array [TPlotsType] of DWORD = (
    3390,
    7400,
    14800
  );
  APPDATA: String; //
  LOCALAPPDATA: String; //
  USERPROFILE: String; //
  PLOTTER: String; // Full path to file plottr
  ConfigDir: String; // Configuration saving directory
  CurrentPath: String; // Current Directory the procramm
  DEBUGS: Boolean;

  ConsolGarbage: array [0 .. 2] of String = (
    '[32m',
    '[33m',
    '[0m'
  );
  aTempLateDrive: array [0 .. 11] of DWORD = (
    931,
    1863,
    2794,
    3725,
    4657,
    5588,
    7451,
    9313,
    11176,
    13039,
    14901,
    16764
  );
  WalChallengeKeyArray: array of string;
  ChildNumber: Word;

const
  CAPTION_MB = 'Chia Plotting Tools';
  ConfigFile = 'Config.ini'; // Name File to configuration save
  MAX_COUNT_PLOTTER = 16;

implementation

USES UFrmMDIChildCalculator, UFrmMDIChildPlotter, UFrmViewLog, UFrmUpdate;

{$R *.dfm}

procedure TFrmMain.ActExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.ActFrmChildCascadeExecute(Sender: TObject);
begin
  Cascade;
end;

procedure TFrmMain.ActFrmChildHorizontalExecute(Sender: TObject);
begin
  TileMode := tbHorizontal;
  Tile;
end;

procedure TFrmMain.ActFrmChildVerticalExecute(Sender: TObject);
begin
  TileMode := tbVertical;
  Tile;
end;

procedure TFrmMain.ActShowFrmCalculatorExecute(Sender: TObject);
var
  NewChild: TFrmMDIChildCalculator;
  i: ShortInt;
begin
  for i := 0 to MDIChildCount - 1 do
    if MDIChildren[i].Name = 'FrmMDIChildCalculator' then
    begin
      MDIChildren[i].WindowState := wsMaximized;
      Exit;
    end;
  NewChild := TFrmMDIChildCalculator.Create(Application);

  i := TabSet.Tabs.Add(NewChild.Caption);
  TabSet.TabIndex := i;
  NewChild.mm.SetFocus;

end;

procedure TFrmMain.ActShowFrmPlotterExecute(Sender: TObject);
var
  NewChild: TFrmMDIChildPlotter;
  i, cnt: ShortInt;
begin

  // FrmCreatePlotting.showmodal;

  cnt := 0;
  for i := 0 to MDIChildCount - 1 do
    if MDIChildren[i] is TFrmMDIChildPlotter then
      inc(cnt);

  if cnt >= MAX_COUNT_PLOTTER then
  begin
    // will crete Message()
    ShowMessage('cnt >= MAX_COUNT_PLOTTER');
    Exit;
  end;

  NewChild := TFrmMDIChildPlotter.Create(Application);
  NewChild.Caption := 'Задание №: ' + IntToStr(ChildNumber);
  inc(ChildNumber);
  NewChild.SavedCaption := NewChild.Caption;
  NewChild.WindowState := wsMaximized;
  i := TabSet.Tabs.Add(NewChild.Caption);
  TabSet.TabIndex := i;
  NewChild.sDirEditTemp.SetFocus;

end;

procedure TFrmMain.AddLog(StrValue: String);
begin
  FrmViewLog.mm.Lines.Add(StrValue);
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: ShortInt;
  DosCount: SmallInt;
begin

  for i := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[i] is TFrmMDIChildPlotter then
      if (MDIChildren[i] as TFrmMDIChildPlotter).DosCmd.IsRunning then
        inc(DosCount);
  end;

  if DosCount > 0 then
  begin
    if MessageBox(Handle, PChar('У приложения выполняются ' + IntToStr(DosCount)
      + ' Активных задания.' + #10#13 +
      'Вы хотите их прервать и завершить работу?' + #10#13 +
      'ДА - Прервать и завершить работу.' + #10#13 +
      'НЕТ - Продолжить работу.'), PChar(CAPTION_MB), MB_ICONWARNING or
      MB_YESNOCANCEL) <> ID_YES then
    begin
      Action := caNone;
      Exit;
    end;
  end;

  for i := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[i] is TFrmMDIChildPlotter then
      if (MDIChildren[i] as TFrmMDIChildPlotter).DosCmd.IsRunning then
        (MDIChildren[i] as TFrmMDIChildPlotter).sBtnStopClick(Nil);
  end;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  i: ShortInt;
begin
  ChildNumber := 1;
  APPDATA := GetEnvironmentVariable('APPDATA');
  LOCALAPPDATA := GetEnvironmentVariable('LOCALAPPDATA');
  USERPROFILE := GetEnvironmentVariable('USERPROFILE');
  PLOTTER := GetPlotter;
  CurrentPath := ExtractFilePath(Application.ExeName);
  // ConfigDir    := IncludeTrailingPathDelimiter(APPDATA) + CAPTION_MB;
  GetWalletsKeyID;

  Constraints.MinHeight := 480;
  Constraints.MinWidth := FrmMain.Width;
  Caption := Caption + ' v.' + GetVertionInfo(Application.ExeName, true);
  SetingsView;
end;

function TFrmMain.GetPlotter: String;
var
  SR: TSearchRec;
  SourcePath: String;
begin
  SourcePath := IncludeTrailingPathDelimiter(LOCALAPPDATA) + 'chia-blockchain\';
  // Find directory
  if FindFirst(SourcePath + '*.*', faAnyFile, SR) = 0 then
    Repeat
      if (SR.Name = '.') or (SR.Name = '..') then
        Continue;
      if (SR.Attr and faDirectory) <> 0 then
        if AnsiContainsStr(AnsiLowerCase(SR.Name), 'app-') then
        begin
          Result := SourcePath + SR.Name +
            '\resources\app.asar.unpacked\daemon\chia.exe';
          Break;
        end;
    until (FindNext(SR) <> 0);
  FindClose(SR);
end;

procedure TFrmMain.GetWalletsKeyID;
var
  SR: TSearchRec;
  SourcePath: String;
  FileMask: String;
  s_temp: String;
begin

  FileMask := 'blockchain_wallet_v1_mainnet_';
  SourcePath := IncludeTrailingPathDelimiter(USERPROFILE) +
    '.chia\mainnet\wallet\db\';

  // ******************** Find file *****************************
  if FindFirst(SourcePath + '*.*', faAnyFile, SR) = 0 then
    Repeat
      if ((SR.Attr and faDirectory) = faDirectory) or (SR.Name = '.') or
        (SR.Name = '..') then
        Continue;

      s_temp := AnsiLowerCase(SR.Name);
      if ExtractFileExt(s_temp) <> '.sqlite' then
        Continue;
      s_temp := StringReplace(s_temp, ExtractFileExt(s_temp), '', []);

      if AnsiContainsStr(s_temp, FileMask) then
      begin
        s_temp := StringReplace(s_temp, FileMask, '', []);
        SetLength(WalChallengeKeyArray, Length(WalChallengeKeyArray) + 1);
        WalChallengeKeyArray[Length(WalChallengeKeyArray) - 1] := s_temp;
      end;

    until (FindNext(SR) <> 0);
  FindClose(SR);

end;

procedure TFrmMain.MM_UpdateClick(Sender: TObject);
begin
  // FrmUpdate.ShowModal;
end;

procedure TFrmMain.SetingsView;
begin
  {
   if Not DEBUGS then Exit;
    with mm.Lines do
    begin
    add('APPDATA = ' + APPDATA);           // := GetEnvironmentVariable('APPDATA');
    add('LOCALAPPDATA = ' + LOCALAPPDATA); // := GetEnvironmentVariable('LOCALAPPDATA');
    add('USERPROFILE = ' + USERPROFILE);   // := GetEnvironmentVariable('USERPROFILE');
    add('PLOTTER = ' + PLOTTER);           // := GetPlotter;
    add('CurrentPath = ' + CurrentPath);   // := ExtractFilePath(Application.ExeName);
    end;
  }
end;

procedure TFrmMain.TabSetClick(Sender: TObject);
var
  i: ShortInt;
begin
  if TabSet.TabIndex = -1 then
    Exit;
  for i := 0 to MDIChildCount - 1 do
    if AnsiContainsStr(MDIChildren[i].Caption, TabSet.Tabs[TabSet.TabIndex])
    then
      MDIChildren[i].BringToFront;
end;

end.
