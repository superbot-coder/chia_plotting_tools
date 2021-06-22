unit UFrmMDIChildPlotter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  System.IniFiles, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  sMemo, sRadioButton, sComboBox, sCheckBox, sEdit, sSpinEdit, Vcl.ComCtrls,
  sComboBoxes,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, sButton, sLabel,
  Vcl.ExtCtrls, sPanel,
  sDialogs, DosCommand, sSkinProvider, sListView, Timeformat, StrUtils,
  Vcl.Menus, Vcl.ToolWin, sToolBar, Vcl.Buttons, sSpeedButton, acCoolBar,
  sScrollBox, sFrameBar, sSplitter;

type
  TFrmMDIChildPlotter = class(TForm)
    sPnlPlotter: TsPanel;
    sLblDirTemp: TsLabel;
    sLblDirDest: TsLabel;
    sLblWallets: TsLabel;
    sLblThread: TsLabel;
    sLblRam: TsLabel;
    sLblPlotType: TsLabel;
    sLblBackets: TsLabel;
    sLblCount: TsLabel;
    sBtnStart: TsButton;
    sBtnStop: TsButton;
    sDirEditTemp: TsDirectoryEdit;
    sDirEditFinal: TsDirectoryEdit;
    sCmBoxExWalKey: TsComboBoxEx;
    sSpEditCPUThred: TsSpinEdit;
    sSpEditRam: TsSpinEdit;
    sChBoxBitField: TsCheckBox;
    sBtnCreateBatFile: TsButton;
    sCmBoxPlotsType: TsComboBox;
    sSpEditBackets: TsSpinEdit;
    sBtnSave: TsButton;
    sSpEditCount: TsSpinEdit;
    mmCnsl: TsMemo;
    DosCmd: TDosCommand;
    sSaveDlg: TsSaveDialog;
    sSkinProvider: TsSkinProvider;
    sPnlStatus: TsPanel;
    sLV: TsListView;
    sLblRetsrtData: TsLabel;
    sLblRestartedCount: TsLabel;
    sLblTotalTime: TsLabel;
    sLblTotalTimeData: TsLabel;
    sChBoxSkeepAddFinalDir: TsCheckBox;
    sBtnLoadProfile: TsButton;
    TimerProcess: TTimer;
    sSplitterHeight: TsSplitter;
    sSplitterBottom: TsSplitter;
    function CheckParametrs: Boolean;
    procedure DosCmdNewLine(ASender: TObject; const ANewLine: string;
      AOutputType: TOutputType);
    procedure DosCmdTerminated(Sender: TObject);
    procedure sBtnCreateBatFileClick(Sender: TObject);
    procedure sBtnStartClick(Sender: TObject);
    procedure sBtnStopClick(Sender: TObject);
    procedure sCmBoxPlotsTypeSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveConfigPlotter(ProfileName: String);
    Procedure LoadConfigPloter(ProfileName: String);
    procedure mmStartClick(Sender: TObject);
    procedure sBtnSaveClick(Sender: TObject);
    procedure sBtnLoadProfileClick(Sender: TObject);
    procedure TimerProcessTimer(Sender: TObject);
    Procedure ClearTempFiles(FilesDir, FileMask: String);
    Function AddLVItem: Integer;
    procedure LockControl;
    procedure UnlockControl;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FrmFirstActivate: Boolean;
  public
    SavedCaption: String;
    ProcessTimeBegin: Cardinal;
    PlotTimeBegin: Cardinal;
    Gl_COUNT: SmallInt;
  end;

var
  FrmMDIChildPlotter: TFrmMDIChildPlotter;
  PlotID: string;

const
  lv_plot_id = 0;
  lv_time = 1;
  lv_phasa_1 = 2;
  lv_phasa_2 = 3;
  lv_phasa_3 = 4;
  lv_phasa_4 = 5;
  lv_status = 6;

implementation

USES UFrmMDIMain, UfrmSelectProfile;

{$R *.dfm}
{ TFrmMDIChildPlotter }

function TFrmMDIChildPlotter.AddLVItem: Integer;
var
  i: ShortInt;
begin
  with sLV.Items.Add do
  begin
    Caption := IntToStr(Index + 1);
    for i := 0 to 6 do
      SubItems.Add('');
    Result := Index;
  end;
end;

function TFrmMDIChildPlotter.CheckParametrs: Boolean;
begin
  Result := false;
  if sDirEditTemp.Text = '' then
  begin
    MessageBox(Handle, PChar('Не указана временая директрия.'),
      PChar(CAPTION_MB), MB_ICONWARNING);
    exit;
  end;

  if sDirEditFinal.Text = '' then
  begin
    MessageBox(Handle, PChar('Не указана финальная директория.'),
      PChar(CAPTION_MB), MB_ICONWARNING);
    exit;
  end;

  if sCmBoxExWalKey.ItemIndex = -1 then
  begin
    MessageBox(Handle,
      PChar('На вашем компьютере обнаружено более 1 кошелька Chia' + #13#10 +
      'Вы должны выбрать кошелёк для которого будут создавать плоты.'),
      PChar(CAPTION_MB), MB_ICONWARNING);
    exit;
  end;
  Result := true;

end;

procedure TFrmMDIChildPlotter.ClearTempFiles(FilesDir, FileMask: String);
var
  SR: TSearchRec;
  s_temp: String;
  STFiles: TStrings;
  i: Integer;
  IsDelete: Boolean;
  Atempt: Byte;
begin

  STFiles := TStringList.Create;
  try
    // ******************** Find file *****************************
    if FindFirst(FilesDir + '\' + '*.*', faAnyFile, SR) = 0 then
      Repeat
        if ((SR.Attr and faDirectory) = faDirectory) or (SR.Name = '.') or
          (SR.Name = '..') then
          Continue;
        s_temp := AnsiLowerCase(SR.Name);
        if AnsiContainsStr(s_temp, FileMask) then
        begin
          STFiles.Add(FilesDir + '\' + SR.Name);
        end;
      until (FindNext(SR) <> 0);
    FindClose(SR);

    for i := 0 to STFiles.Count - 1 do
    begin
      Application.ProcessMessages;
      IsDelete := false;
      Atempt := 0;
      while Not IsDelete or (Atempt > 1000) do
      begin
        IsDelete := DeleteFile(STFiles.Strings[i]);
        if IsDelete then
          Break;
        inc(Atempt);
        sleep(100);
        Application.ProcessMessages;
      end;
    end;

  finally
    STFiles.Free;
  end;
end;

procedure TFrmMDIChildPlotter.DosCmdNewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);
var
  AnsiLine: Ansistring;
  garbage, s_temp: string;
  x, pos: SmallInt;
begin

  if AOutputType = otEntireLine then
  begin
    if ANewLine <> '' then
    begin
      SetLength(AnsiLine, Length(ANewLine));
      try
        OemToAnsi(PAnsiChar(Ansistring(ANewLine)), PAnsiChar(AnsiLine));
        for garbage in ConsolGarbage do
          AnsiLine := StringReplace(AnsiLine, garbage, '',
            [rfReplaceAll, rfIgnoreCase]);

      except
        // hide exception
        // Иногда возникают исключения, когда попадаются какие то не печатные символы
        // как то, Например  '' - отсутсвие символа.
      end;
    end
    else
      AnsiLine := ANewLine;

    mmCnsl.Lines.Add(AnsiLine);

    // ****** Extract information from AnsiLine ******

    AnsiLine := AnsiLowerCase(AnsiLine);
    if AnsiContainsStr(AnsiLine, 'id:') then
    begin
      PlotID := Trim(StringReplace(AnsiLine, 'id: ', '', [rfReplaceAll]));
      x := AddLVItem;
      Gl_COUNT := x;
      sLV.Items[x].SubItems[lv_plot_id] := PlotID;
      PlotTimeBegin := GetTickCount;
    end;

    // Status: Starting phase 1/4, 2/4, 3/4, 4/4:
    if AnsiContainsStr(AnsiLine, 'starting phase 1/4:') then
      sLV.Items[Gl_COUNT].SubItems[lv_status] := '1/4';
    if AnsiContainsStr(AnsiLine, 'starting phase 2/4:') then
      sLV.Items[Gl_COUNT].SubItems[lv_status] := '2/4';
    if AnsiContainsStr(AnsiLine, 'starting phase 3/4:') then
      sLV.Items[Gl_COUNT].SubItems[lv_status] := '3/4';
    if AnsiContainsStr(AnsiLine, 'starting phase 4/4:') then
      sLV.Items[Gl_COUNT].SubItems[lv_status] := '4/4';

    // Get time fo phase
    // Time for phase 1-4 = XXXX.XXX seconds. convert to format dd hh mm ss
    for x := 1 to 4 do
    begin
      if AnsiContainsStr(AnsiLine, 'time for phase ' + IntToStr(x) + ' = ') then
      begin
        s_temp := StringReplace(AnsiLine, 'time for phase ' + IntToStr(x) +
          ' = ', '', []);
        pos := AnsiPos('seconds.', s_temp);
        if pos > 0 then
          s_temp := Trim(AnsiLeftStr(s_temp, pos - 1));
        s_temp := StringReplace(s_temp, '.', '', []);
        s_temp := GetMilisecondsFormat(StrToInt(s_temp), TS_DAY, TS_Alfa);
        sLV.Items[Gl_COUNT].SubItems[x + 1] := s_temp;
      end;
    end;

    // Find Final Name file
    {
    pos := AnsiPos('plot-' + AnsiLowerCase
      (аPlotsStr[TPlotsType(sCmBoxPlotsType.ItemIndex)]), AnsiLine);
    if pos > 0 then
    begin
      s_temp := AnsiRightStr(AnsiLine, Length(AnsiLine) - pos - 1);

      if ExtractFileExt(s_temp) = '.plot' then
      begin
        if FileExists(sDirEditFinal.Text + '\' + s_temp) then
          sLV.Items[Gl_COUNT].SubItems[lv_plot_id] := s_temp;
      end;
    end;
    }
  end;
end;

procedure TFrmMDIChildPlotter.DosCmdTerminated(Sender: TObject);
var
  err: Cardinal;
begin
  TimerProcessTimer(Nil);
  TimerProcess.Enabled := false;
  sBtnStart.Enabled := true;
  mmCnsl.Lines.Add('[PROCCESS STOPED]');
  // mmCnsl.Lines.Add('ExitCode: ' + IntToStr(DosCmd.ExitCode));
  UnlockControl;
end;

procedure TFrmMDIChildPlotter.FormActivate(Sender: TObject);
var
  i: ShortInt;
begin

  if Not FrmFirstActivate then
  begin
    FrmFirstActivate := true;
    exit;
  end;

  // Set focus tab TabSet
  if (FrmMain.TabSet.Tabs.Count > 0) then
  begin
    for i := 0 to FrmMain.TabSet.Tabs.Count do
    begin
      if AnsiContainsStr(Caption, FrmMain.TabSet.Tabs[i]) then
      begin
        FrmMain.TabSet.TabIndex := i;
        FrmFirstActivate := true;
        Break;
      end;
    end;
  end;
end;

procedure TFrmMDIChildPlotter.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: ShortInt;
begin

  if DosCmd.IsRunning then
    sBtnStopClick(Sender);
  if DosCmd.IsRunning Then
    exit;

  // Удатение TabSet элемента
  if FrmMain.TabSet.Tabs.Count <> 0 then
  begin
    for i := 0 to FrmMain.TabSet.Tabs.Count do
    begin
      if AnsiContainsStr(Caption, FrmMain.TabSet.Tabs[i]) then
      begin
        FrmMain.TabSet.Tabs.Delete(i);
        Break;
      end;
    end;
  end;

  Action := caFree;
end;

procedure TFrmMDIChildPlotter.FormCreate(Sender: TObject);
var
  i: SmallInt;
begin

  for i := 0 to Length(WalChallengeKeyArray) - 1 do
  begin
    sCmBoxExWalKey.Items.Add(WalChallengeKeyArray[i]);
    sCmBoxExWalKey.ItemsEx[sCmBoxExWalKey.ItemsEx.Count - 1].ImageIndex := 1;
  end;

  if sCmBoxExWalKey.Items.Count = 1 then
    sCmBoxExWalKey.ItemIndex := 0;
  for i := 0 to Length(аPlotsStr) - 1 do
    sCmBoxPlotsType.Items.Add(аPlotsStr[TPlotsType(i)]);

  sLblTotalTimeData.Caption := GetMilisecondsFormat(0, TS_DAY, TS_Alfa);

end;

procedure TFrmMDIChildPlotter.LoadConfigPloter(ProfileName: String);
var
  INI: TIniFile;
  SECTION: String;
  s: String;
  x: Integer;
begin
  SECTION := 'PLOTTER\' + ProfileName;

  // Load from ..\Appdata\roaming\ directory
  // if Not FileExists(IncludeTrailingPathDelimiter(ConfigDir) + ConfigFile) then Exit;
  // INI := TIniFile.Create(IncludeTrailingPathDelimiter(ConfigDir) + ConfigFile);

  if Not FileExists(CurrentPath + ConfigFile) then
    exit;
  INI := TIniFile.Create(CurrentPath + ConfigFile);
  try
    sDirEditTemp.Text := INI.ReadString(SECTION, 'TempDir', '');
    sDirEditFinal.Text := INI.ReadString(SECTION, 'FinalDir', '');
    sCmBoxPlotsType.ItemIndex := INI.ReadInteger(SECTION, 'PlotType', 0);
    sSpEditBackets.Value := INI.ReadInteger(SECTION, 'Backets', 128);
    sSpEditCPUThred.Value := INI.ReadInteger(SECTION, 'CPUThread', 2);
    sSpEditRam.Value := INI.ReadInteger(SECTION, 'SysRam', 3390);
    sSpEditCount.Value := INI.ReadInteger(SECTION, 'PlotCount', 1);
    sChBoxBitField.Checked := INI.ReadBool(SECTION, 'BitField', false);
    Debugs := INI.ReadBool('APPLICATION', 'Debugs', false);
    sChBoxSkeepAddFinalDir.Checked :=
      INI.ReadBool(SECTION, 'SkeepAddFinalDir', true);
    x := sCmBoxExWalKey.Items.IndexOf(INI.ReadString(SECTION,
      'WalletKeyID', ''));
    if x <> -1 then
      sCmBoxExWalKey.ItemIndex := x;
  finally
    INI.Free;
  end;

end;

procedure TFrmMDIChildPlotter.LockControl;
begin
  sDirEditTemp.Enabled := false;
  sDirEditFinal.Enabled := false;
  sCmBoxExWalKey.Enabled := false;
  sCmBoxPlotsType.Enabled := false;
  sSpEditCount.Enabled := false;
  sSpEditRam.Enabled := false;
  sSpEditBackets.Enabled := false;
  sSpEditCPUThred.Enabled := false;
  sChBoxBitField.Enabled := false;
  sChBoxSkeepAddFinalDir.Enabled := false;
  sBtnStart.Enabled := false;
  sBtnLoadProfile.Enabled := false;
end;

procedure TFrmMDIChildPlotter.mmStartClick(Sender: TObject);
begin
  ShowMessage('START');
end;

procedure TFrmMDIChildPlotter.sBtnCreateBatFileClick(Sender: TObject);
var
  ST: TStrings;
  CmdLine: String;
  SaveFileName: String;
begin

  if Not CheckParametrs then
    exit;
  if Not sSaveDlg.Execute then
    exit;

  ST := TStringList.Create;
  try
    ST.Add('set Plotter=' + PLOTTER);
    ST.Add('set TempDir=' + sDirEditTemp.Text);
    ST.Add('set FinalDir=' + sDirEditFinal.Text);
    CmdLine := CmdLine + '%Plotter% plots create -' +
      AnsiLowerCase(sCmBoxPlotsType.Items[sCmBoxPlotsType.ItemIndex]) + ' -n ' +
      sSpEditCount.Text + ' -t %TempDir%' + ' -d %FinalDir%' + ' -b ' +
      sSpEditRam.Text + ' -r ' + sSpEditCPUThred.Text + ' -u ' +
      sSpEditBackets.Text + ' -a ' + sCmBoxExWalKey.Items
      [sCmBoxExWalKey.ItemIndex];
    if sChBoxBitField.Checked then
      CmdLine := CmdLine + ' -e';
    ST.Add(CmdLine);
    if ExtractFileExt(sSaveDlg.FileName) = '' then
    begin
      Case sSaveDlg.FilterIndex of
        1:
          SaveFileName := sSaveDlg.FileName + '.bat';
        2:
          SaveFileName := sSaveDlg.FileName + '.cmd';
      End;
    end;
    ST.SaveToFile(SaveFileName);

  finally
    ST.Free;
  end;
end;

procedure TFrmMDIChildPlotter.sBtnLoadProfileClick(Sender: TObject);
begin
  FrmSelectProfile.FrmShohowInit(fmLoadeProfils);
  if Not FrmSelectProfile.Apply then
    exit;
  LoadConfigPloter(FrmSelectProfile.sEdProfileName.Text);
  Caption := SavedCaption + ' Профиль: ' + FrmSelectProfile.sEdProfileName.Text;
end;

procedure TFrmMDIChildPlotter.sBtnSaveClick(Sender: TObject);
begin
  FrmSelectProfile.FrmShohowInit(fmSaveProfils);
  if FrmSelectProfile.Apply = false then
    exit;
  SaveConfigPlotter(FrmSelectProfile.sEdProfileName.Text);
end;

procedure TFrmMDIChildPlotter.sBtnStartClick(Sender: TObject);
begin
  if Not CheckParametrs then
    exit;
  DosCmd.CommandLine := '';
  DosCmd.CommandLine := DosCmd.CommandLine + PLOTTER + ' plots create' + ' -' +
    AnsiLowerCase(sCmBoxPlotsType.Items[sCmBoxPlotsType.ItemIndex]) + ' -n ' +
    sSpEditCount.Text + ' -t ' + sDirEditTemp.Text + ' -d ' + sDirEditFinal.Text
    + ' -b ' + sSpEditRam.Text + ' -r ' + sSpEditCPUThred.Text + ' -u ' +
    sSpEditBackets.Text + ' -a ' + sCmBoxExWalKey.Items
    [sCmBoxExWalKey.ItemIndex];

  if sChBoxBitField.Checked then
    DosCmd.CommandLine := DosCmd.CommandLine + ' -e';
  if sChBoxSkeepAddFinalDir.Checked then
    DosCmd.CommandLine := DosCmd.CommandLine + ' -x';

  DosCmd.CurrentDir := ExtractFilePath(PLOTTER);
  mmCnsl.Clear;
  mmCnsl.Lines.Add('[PROCCESS START]');
  mmCnsl.Lines.Add('CommandLine: ' + DosCmd.CommandLine);
  mmCnsl.Lines.Add('');
  DosCmd.Execute;
  if DosCmd.IsRunning then
  begin
    sBtnStart.Enabled := false;
    ProcessTimeBegin := GetTickCount;
    TimerProcess.Enabled := true;
    LockControl;
  end;

end;

procedure TFrmMDIChildPlotter.sBtnStopClick(Sender: TObject);
var
  TimeWait: Byte;
begin

  if Not DosCmd.IsRunning Then
    exit;
  if (Sender <> Nil) and
    (MessageBox(Handle, PChar('Вы собираетесь прервать процесс создания плота.'
    + #13#10 + 'Что бы завершить нажмите "ДА"' + #13#10 +
    'Что бы продожить работу нажмите "Нет"'), PChar(CAPTION_MB),
    MB_ICONWARNING or MB_YESNOCANCEL) <> ID_YES) then
    exit;

  try
    DosCmd.Stop;
  Except
    // Hide Exceptions
  end;

  if sLV.Items.Count > 0 then
    ClearTempFiles(sDirEditTemp.Text, sLV.Items[Gl_COUNT].SubItems[lv_plot_id]);

end;

procedure TFrmMDIChildPlotter.sCmBoxPlotsTypeSelect(Sender: TObject);
begin
  if sCmBoxPlotsType.ItemIndex = -1 then
    exit;
  sSpEditRam.Value := aDefaultRamSz[TPlotsType(sCmBoxPlotsType.ItemIndex)];
end;

procedure TFrmMDIChildPlotter.TimerProcessTimer(Sender: TObject);
begin
  // Общее время выполнения
  sLblTotalTimeData.Caption := GetMilisecondsFormat
    (GetTickCount - ProcessTimeBegin, TS_DAY, TS_Alfa);

  // Время выполнения плота
  if sLV.Items.Count <> 0 then
    sLV.Items[Gl_COUNT].SubItems[lv_time] :=
      GetMilisecondsFormat(GetTickCount - PlotTimeBegin, TS_HOUR, TS_Alfa);
end;

procedure TFrmMDIChildPlotter.UnlockControl;
begin
  sDirEditTemp.Enabled := true;
  sDirEditFinal.Enabled := true;
  sCmBoxExWalKey.Enabled := true;
  sCmBoxPlotsType.Enabled := true;
  sSpEditCount.Enabled := true;
  sSpEditRam.Enabled := true;
  sSpEditBackets.Enabled := true;
  sSpEditCPUThred.Enabled := true;
  sChBoxBitField.Enabled := true;
  sChBoxSkeepAddFinalDir.Enabled := true;
  sBtnStart.Enabled := true;
  sBtnLoadProfile.Enabled := true;
end;

procedure TFrmMDIChildPlotter.SaveConfigPlotter(ProfileName: String);
var
  INI: TIniFile;
  SECTION: String;
begin
  SECTION := 'PLOTTER\' + ProfileName;

  {
    //  The save to ..\Appdata\roaming\ directory
    if Not DirectoryExists(ConfigDir) then ForceDirectories(ConfigDir);
    if Not DirectoryExists(ConfigDir) then
    begin
    MessageBox(Handle, PChar('Неудалось сохранить параметры, '
    + 'т.к. не удалось создать директорию в профиле пользователя.'),
    PChar(CAPTION_MB), MB_ICONERROR);
    Exit;
    end;
    INI := TIniFile.Create(IncludeTrailingPathDelimiter(ConfigDir) + ConfigFile);
  }

  INI := TIniFile.Create(CurrentPath + ConfigFile);
  try
    INI.WriteString(SECTION, 'TempDir', sDirEditTemp.Text);
    INI.WriteString(SECTION, 'FinalDir', sDirEditFinal.Text);
    INI.WriteString(SECTION, 'WalletKeyID', sCmBoxExWalKey.Text);
    INI.WriteInteger(SECTION, 'PlotType', sCmBoxPlotsType.ItemIndex);
    INI.WriteInteger(SECTION, 'PlotCount', sSpEditCount.Value);
    INI.WriteInteger(SECTION, 'Backets', sSpEditBackets.Value);
    INI.WriteInteger(SECTION, 'CPUThread', sSpEditCPUThred.Value);
    INI.WriteInteger(SECTION, 'SysRam', sSpEditRam.Value);
    INI.WriteBool(SECTION, 'BitField', sChBoxBitField.Checked);
    INI.WriteBool(SECTION, 'SkeepAddFinalDir', sChBoxSkeepAddFinalDir.Checked);
  finally
    INI.Free;
  end;
  ShowMessage('Сохранено OK');
end;

end.
