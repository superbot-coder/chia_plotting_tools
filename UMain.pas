unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.IniFiles, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, sMemo,
  sSkinManager, sLabel, sEdit, Vcl.ComCtrls, sComboBoxes, Vcl.Samples.Spin,
  Winapi.ShellApi, System.ImageList, Vcl.ImgList, sSpinEdit, sGroupBox, GetVer,
  Vcl.ExtCtrls, sPanel, sPageControl, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sToolEdit, sCheckBox, DosCommand, StrUtils, sDialogs, sComboBox, sRadioButton;

type
  TFrmMain = class(TForm)
    sSkinManager: TsSkinManager;
    ImageListDrive: TImageList;
    ImageListBtn: TImageList;
    sPageControl: TsPageControl;
    sTabSheetCalculate: TsTabSheet;
    sTabSheetPlotter: TsTabSheet;
    mm: TsMemo;
    sPnlCalculator: TsPanel;
    sLabel1: TsLabel;
    LblSelectDisk: TsLabel;
    sBtnCalculate: TsButton;
    sGrBox: TsGroupBox;
    sLblLow: TsLabel;
    sLblHigh: TsLabel;
    sLblGb1: TsLabel;
    sLblGb2: TsLabel;
    sSpEdLow: TsSpinEdit;
    sSpEdHigh: TsSpinEdit;
    sCmBoxExSelDisk: TsComboBoxEx;
    sBtnUdateDriveList: TsButton;
    SpEdDiskSpace: TSpinEdit;
    sPnlPlotter: TsPanel;
    sBtnStart: TsButton;
    sBtnStop: TsButton;
    sDirEditTemp: TsDirectoryEdit;
    sDirEditFinal: TsDirectoryEdit;
    sLblDirTemp: TsLabel;
    sLblDirDest: TsLabel;
    sCmBoxExKeyID: TsComboBoxEx;
    sLblWallets: TsLabel;
    sSpEditCPUThred: TsSpinEdit;
    sLblThread: TsLabel;
    mmCnsl: TsMemo;
    sSpEditRam: TsSpinEdit;
    sLblRam: TsLabel;
    sChBoxBitField: TsCheckBox;
    DosCmd: TDosCommand;
    sBtnCreateBatFile: TsButton;
    sSaveDlg: TsSaveDialog;
    sCmBoxPlotsType: TsComboBox;
    sLblPlotType: TsLabel;
    sSpEditBackets: TsSpinEdit;
    sLblBackets: TsLabel;
    sBtnSave: TsButton;
    sLblCount: TsLabel;
    sSpEditCount: TsSpinEdit;
    sRdBtnStile1: TsRadioButton;
    sRdBtnStile2: TsRadioButton;
    sCmBoxExTemplateDrive: TsComboBoxEx;
    sLblЕemplate: TsLabel;
    procedure sBtnCalculateClick(Sender: TObject);
    procedure ScanDrive;
    function AddAssociatedIcon(FileName: String; ImageList: TImageList): Integer;
    procedure FormCreate(Sender: TObject);
    procedure sCmBoxExSelDiskSelect(Sender: TObject);
    procedure sSpEdLowChange(Sender: TObject);
    procedure sSpEdHighChange(Sender: TObject);
    procedure sBtnUdateDriveListClick(Sender: TObject);
    function GetPlotter: String;
    procedure GetWalletsKeyID;
    procedure sBtnStartClick(Sender: TObject);
    procedure sBtnCreateBatFileClick(Sender: TObject);
    procedure SeveConfigPlotter;
    procedure LoadConfigPloter;
    procedure sBtnSaveClick(Sender: TObject);
    function CheckParametrs: Boolean;
    procedure DosCmdTerminated(Sender: TObject);
    procedure DosCmdNewLine(ASender: TObject; const ANewLine: string;
      AOutputType: TOutputType);
    procedure sBtnStopClick(Sender: TObject);
    procedure sRdBtnStile2Click(Sender: TObject);
    procedure sRdBtnStile1Click(Sender: TObject);
    procedure sCmBoxPlotsTypeSelect(Sender: TObject);
    procedure SetingsView;
    procedure sCmBoxExTemplateDriveSelect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type TPlotsType = (K32, K33, K34);

var
  FrmMain: TFrmMain;
  // aPlots: Array[TPlotsType] of real = (108.9, 224.2, 461.5); // GB
  aPlots: Array[TPlotsType] of Int64 = (108900000000, 224200000000, 461500000000); // GB
  аPlotsStr: Array[TPlotsType] of String = ('K32','K33','K34');
  aPlotsMaxCount: Array[TPlotsType] of DWORD;
  aDefaultRamSz: Array[TPlotsType] of DWORD = (3390, 7400, 14800);
  APPDATA      : String; //
  LOCALAPPDATA : String; //
  USERPROFILE  : String; //
  PLOTTER      : String; // Full path to file plottr
  ConfigDir    : String; // Configuration saving directory
  CurrentPath  : String; // Current Directory the procramm
  DEBUGS       : Boolean;
  ConsolGarbage:  array[0..1] of String = ('[32m', '[0m');
  aTempLateDrive: array[0..11] of DWORD =
                 (931, 1863, 2794, 3725, 4657, 5588, 7451, 9313, 11176, 13039, 14901, 16764);

const
  CAPTION_MB = 'Chia Plotter Calculator';
  ConfigFile = 'Config.ini'; // Name File to configuration save

implementation

{$R *.dfm}

function TFrmMain.AddAssociatedIcon(FileName: String;
  ImageList: TImageList): Integer;
var
  icon: Ticon;
  wd: WORD;
begin
  // Add associated Icon
  Result := -1;
  try
    Icon := TIcon.Create;
    wd := 0;
    Icon.Handle := ExtractAssociatedIcon(HInstance, PChar(FileName), wd);
    if icon.HandleAllocated then
      Result := ImageList.AddIcon(icon)
    else
    begin
      //ImageList.GetIcon(wd, icon);
      //ImageList.AddIcon(icon);
    end;

  finally
    Icon.Free;
  end;
end;

function TFrmMain.CheckParametrs: Boolean;
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

  if sCmBoxExKeyID.ItemIndex = -1 then
  begin
    MessageBox(Handle, PChar('На вашем компьютере обнаружено более 1 кошелька Chia' + #13#10
               + 'Вы должны выбрать кошелёк для которого будут создавать плоты.'),
              PChar(CAPTION_MB), MB_ICONWARNING);
    Exit;
  end;

  Result := true;
end;

procedure TFrmMain.DosCmdNewLine(ASender: TObject; const ANewLine: string;
  AOutputType: TOutputType);
var
  AnsiLine: Ansistring;
  garbage: string;

begin

  if AOutputType = otEntireLine then
  begin
    if ANewLine <> '' then
    begin
      SetLength(AnsiLine, Length(ANewLine));
      try
        OemToAnsi(PAnsiChar(AnsiString(ANewLine)), PAnsiChar(AnsiLine));
        for garbage in ConsolGarbage do
          AnsiLine := StringReplace(AnsiLine, garbage, '', [rfReplaceAll, rfIgnoreCase]);
      except
        // hide exception
        // Иногда возникают исключения, когда попадаются какие то не печатные символы
        // как то, Например  '' - отсутсвие символа.
      end;
    end
    else
      AnsiLine := ANewLine;

    mmCnsl.Lines.Add(AnsiLine);
  end;
end;

procedure TFrmMain.DosCmdTerminated(Sender: TObject);
var
  err: Cardinal;
begin
  sBtnStart.Enabled := True;
  mmCnsl.Lines.Add('[PROCCESS STOPED]');
  mmCnsl.Lines.Add('ExitCode: ' + IntToStr(DosCmd.ExitCode));
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var i: ShortInt;
begin
  APPDATA      := GetEnvironmentVariable('APPDATA');
  LOCALAPPDATA := GetEnvironmentVariable('LOCALAPPDATA');
  USERPROFILE  := GetEnvironmentVariable('USERPROFILE');
  PLOTTER      := GetPlotter;
  CurrentPath  := ExtractFilePath(Application.ExeName);
  //ConfigDir    := IncludeTrailingPathDelimiter(APPDATA) + CAPTION_MB;
  GetWalletsKeyID;
  ScanDrive;
  if sCmBoxExKeyID.Items.Count = 1 then sCmBoxExKeyID.ItemIndex := 0;
  for i:= 0 to Length(аPlotsStr) -1 do sCmBoxPlotsType.Items.Add(аPlotsStr[TPlotsType(i)]);
  LoadConfigPloter;
  Constraints.MinHeight := 480;
  Constraints.MinWidth  := FrmMain.Width;
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
    if (SR.Name = '.') or (SR.Name = '..') then Continue;
    if (SR.Attr and faDirectory) <> 0 then
      if AnsiContainsStr(AnsiLowerCase(SR.Name), 'app-') then
      begin
        Result := SourcePath + SR.Name + '\resources\app.asar.unpacked\daemon\chia.exe';
        Break;
      end;
  until (FindNext(SR) <> 0);
  FindClose(SR);
end;

procedure TFrmMain.GetWalletsKeyID;
var
  SR: TSearchRec;
  SourcePath: String;
  FileMask : String;
  s_temp: String;
begin

  FileMask := 'blockchain_wallet_v1_mainnet_';

  SourcePath := IncludeTrailingPathDelimiter(USERPROFILE) + '.chia\mainnet\wallet\db\';

  // ******************** Find file *****************************
  if FindFirst(SourcePath + '*.*', faAnyFile, SR) = 0 then
  Repeat
    if ((SR.Attr and faDirectory) = faDirectory) or (SR.Name = '.') or (SR.Name = '..') then Continue;

    s_temp := AnsiLowerCase(SR.Name);
    if ExtractFileExt(s_temp) <> '.sqlite' then Continue;
    s_temp := StringReplace(s_temp, ExtractFileExt(s_temp), '', []);

    if AnsiContainsStr(s_temp, FileMask) then
    begin
      s_temp := StringReplace(s_temp, FileMask, '', []);
      sCmBoxExKeyID.Items.Add(s_temp);
      sCmBoxExKeyID.ItemsEx[sCmBoxExKeyID.Items.Count-1].ImageIndex := 1;
    end;

  until (FindNext(SR) <> 0);
  FindClose(SR);

end;

procedure TFrmMain.LoadConfigPloter;
var
  INI: TIniFile;
  SECTION: String;
  s: String;
  x: Integer;
begin
  SECTION := 'PLOTTER';

  // Load from ..\Appdata\roaming\ directory
  //if Not FileExists(IncludeTrailingPathDelimiter(ConfigDir) + ConfigFile) then Exit;
  // INI := TIniFile.Create(IncludeTrailingPathDelimiter(ConfigDir) + ConfigFile);

  if Not FileExists(CurrentPath + ConfigFile) then Exit;
  INI := TIniFile.Create(CurrentPath + ConfigFile);
  try
    sDirEditTemp.Text  := INI.ReadString(SECTION, 'TempDir','');
    sDirEditFinal.Text := INI.ReadString(SECTION, 'FinalDir', '');
    sCmBoxPlotsType.ItemIndex := INI.ReadInteger(SECTION, 'PlotType', 0);
    sSpEditBackets.Value   := INI.ReadInteger(SECTION, 'Backets', 128);
    sSpEditCPUThred.Value  := INI.ReadInteger(SECTION, 'CPUThread', 2);
    sSpEditRam.Value       := INI.ReadInteger(SECTION, 'SysRam', 3390);
    sSpEditCount.Value     := INI.ReadInteger(SECTION, 'PlotCount', 1);
    sChBoxBitField.Checked := INI.ReadBool(SECTION, 'BitField', false);
    Debugs                 := INI.ReadBool('APPLICATION', 'Debugs', false);
    x := sCmBoxExKeyID.Items.IndexOf(INI.ReadString(SECTION, 'WalletKeyID', ''));
    if x <> -1 then sCmBoxExKeyID.ItemIndex := x;
  finally
    INI.Free;
  end;

end;

procedure TFrmMain.sBtnCalculateClick(Sender: TObject);
var
  N32, N33, N34: integer;
  Sum: Extended;      // Summa
  Rem: Extended;      // Remainder
  SmallRem: Extended; // Small Remainder
  LastDescription : string;
  DescriptStr     : String;
  DiskSpace       : Int64;
begin

  if SpEdDiskSpace.Value < 101 then
  begin
    MessageBox(Handle, PChar('Указанный размер не соответсвуе требуемому минимальному размеру диска 109 Gb'),
               PChar(CAPTION_MB), MB_ICONWARNING);
    exit;
  end;
  mm.Lines.Clear;
  DiskSpace := SpEdDiskSpace.Value;
  // конвертация из GiB байты
  DiskSpace :=  DiskSpace * 1024 * 1024 * 1024;
  // Здесь вычисляются максимальное количество плотов
  aPlotsMaxCount[K32] := DiskSpace div aPlots[K32];
  aPlotsMaxCount[K33] := DiskSpace div aPlots[K33];
  aPlotsMaxCount[K34] := DiskSpace div aPlots[K34];

  SmallRem := aPlots[K32]; // размер самого малого "плота"

  mm.Lines.Add('Другие приближенные значения:');
  for N34 := 0 to aPlotsMaxCount[K34] do
  begin
    for N33 := 0 to aPlotsMaxCount[K33] do
    begin
      For N32 := 0 to aPlotsMaxCount[K32] do
      begin
        sum := aPlots[K34] * N34 + aPlots[K33] * N33 + aPlots[K32] * N32;
        // if (sum < SpEdDiskSpace.Value) then
        if (sum < DiskSpace) then
        begin
          Rem := DiskSpace - sum;
          // сново конвертирую в GiB
          sum := sum / 1024 / 1024 / 1024;
          rem := rem / 1024 / 1024 / 1024;
          // Что бы показать и другие приближенные значения к миниму, задается диапазоном значений
          if (Rem < sSpEdHigh.Value) and (Rem > sSpEdLow.Value) then
          begin
            DescriptStr := аPlotsStr[K34] + 'x' + IntToStr(N34) +
                           ' + ' + аPlotsStr[K33] + 'x' + IntToStr(N33) +
                           ' + ' + аPlotsStr[K32] + 'x' + IntToStr(N32);
            DescriptStr := DescriptStr + ' = ' + FloatToStrF(sum, ffFixed, 10, 2) +
                           'Gb free Size = ' + FloatToStrF(rem, ffFixed, 8, 2) + 'Gb';
            mm.Lines.Add(DescriptStr);
            if Rem < SmallRem then
            begin
              SmallRem := rem;
              LastDescription := DescriptStr;
            end;
          end;
        end;
      end;
    end;
  end;
  mm.Lines.Add('');
  mm.Lines.Add('Найден самый оптимальный вариант:');
  mm.Lines.Add(LastDescription);
end;

procedure TFrmMain.sBtnCreateBatFileClick(Sender: TObject);
var
  ST: TStrings;
  CmdLine: String;
  SaveFileName: String;
begin

  if Not CheckParametrs then Exit;
  if Not sSaveDlg.Execute then Exit;

  ST := TStringList.Create;
  try
    ST.Add('set Plotter=' + PLOTTER);
    ST.Add('set TempDir=' + sDirEditTemp.Text);
    ST.Add('set FinalDir=' + sDirEditFinal.Text);
    CmdLine := CmdLine + '%Plotter% plots create -'
               + AnsiLowerCase(sCmBoxPlotsType.Items[sCmBoxPlotsType.ItemIndex])
               + ' -n ' + sSpEditCount.Text
               + ' -t %TempDir%'
               + ' -d %FinalDir%'
               + ' -b ' + sSpEditRam.Text
               + ' -r ' + sSpEditCPUThred.Text
               + ' -u ' + sSpEditBackets.Text
               + ' -a ' + sCmBoxExKeyID.Items[sCmBoxExKeyID.ItemIndex];
    if sChBoxBitField.Checked then CmdLine := CmdLine + ' -e';
    ST.Add(CmdLine);
    if ExtractFileExt(sSaveDlg.FileName) = '' then
    begin
      Case sSaveDlg.FilterIndex of
       1: SaveFileName := sSaveDlg.FileName + '.bat';
       2: SaveFileName := sSaveDlg.FileName + '.cmd';
      End;
    end;
    St.SaveToFile(SaveFileName);

  finally
    ST.Free;
  end;
end;

procedure TFrmMain.sBtnSaveClick(Sender: TObject);
begin
  SeveConfigPlotter;
  ShowMessage('OK');
end;

procedure TFrmMain.sBtnStartClick(Sender: TObject);
begin
  if Not CheckParametrs then Exit;
  DosCmd.CommandLine := '';
  DosCmd.CommandLine := DosCmd.CommandLine + Plotter + ' plots create'
             + ' -' + AnsiLowerCase(sCmBoxPlotsType.Items[sCmBoxPlotsType.ItemIndex])
             + ' -n ' + sSpEditCount.Text
             + ' -t ' + sDirEditTemp.Text
             + ' -d ' + sDirEditFinal.Text
             + ' -b ' + sSpEditRam.Text
             + ' -r ' + sSpEditCPUThred.Text
             + ' -u ' + sSpEditBackets.Text
             + ' -a ' + sCmBoxExKeyID.Items[sCmBoxExKeyID.ItemIndex];

  if sChBoxBitField.Checked then DosCmd.CommandLine := DosCmd.CommandLine + ' -e';
  DosCmd.CurrentDir := ExtractFilePath(Plotter);
  mmCnsl.Clear;
  mmCnsl.Lines.Add('[PROCCESS START]');
  mmCnsl.Lines.Add('CommandLine: ' + DosCmd.CommandLine);
  mmCnsl.Lines.Add('');
  DosCmd.Execute;
  if DosCmd.IsRunning then sBtnStart.Enabled := false;
end;

procedure TFrmMain.sBtnStopClick(Sender: TObject);
begin

  if Not DosCmd.IsRunning Then Exit;
  if MessageBox(Handle, PChar('Вы собираетесь прервать процесс создания плота.' + #13#10
                              + 'Для завершения нажмите "ДА"' + #13#10
                              + 'Что бы продожить работу нажмите "Нет"'),
                PChar(CAPTION_MB), MB_ICONWARNING or MB_YESNOCANCEL) <> ID_YES
  then Exit;

  try
    DosCmd.Stop;
  Except
    // Hide Exceptions
  end;

end;

procedure TFrmMain.sBtnUdateDriveListClick(Sender: TObject);
begin
  ScanDrive;
  sCmBoxExSelDisk.Text := '';
  sCmBoxExSelDisk.SetFocus;
end;

procedure TFrmMain.ScanDrive;
var
  Drive: Char;
  index: ShortInt;
begin
  sCmBoxExSelDisk.Items.Clear;
  ImageListDrive.Clear;
  for Drive := 'C' to 'Z' do
  begin
    Case GetDriveType(PWideChar(Drive+':\')) of
      DRIVE_FIXED:
       begin
         index := sCmBoxExSelDisk.Items.Add(Drive + ':\');
         sCmBoxExSelDisk.ItemsEx[index].ImageIndex := AddAssociatedIcon(Drive+':\', ImageListDrive);
       end;

      DRIVE_REMOVABLE:
       begin
         index := sCmBoxExSelDisk.Items.Add(Drive + ':\');
         sCmBoxExSelDisk.ItemsEx[index].ImageIndex := AddAssociatedIcon(Drive+':\', ImageListDrive);
       end;

      DRIVE_REMOTE:
       begin
         index := sCmBoxExSelDisk.Items.Add(Drive + ':\');
         sCmBoxExSelDisk.ItemsEx[index].ImageIndex := AddAssociatedIcon(Drive+':\', ImageListDrive);
       end;

      DRIVE_RAMDISK:
       begin
         index := sCmBoxExSelDisk.Items.Add(Drive + ':\');
         sCmBoxExSelDisk.ItemsEx[index].ImageIndex := AddAssociatedIcon(Drive+':\', ImageListDrive);
       end;
    End;
  end;
end;

procedure TFrmMain.sCmBoxExSelDiskSelect(Sender: TObject);
var  Free_Bytes, TotalSize, FreeSize: Int64;
begin
  GetDiskFreeSpaceEx(PChar(sCmBoxExSelDisk.Text), Free_Bytes, TotalSize, @FreeSize);
  SpEdDiskSpace.Value := (FreeSize div 1024 div 1024 div 1024);
end;

procedure TFrmMain.sCmBoxExTemplateDriveSelect(Sender: TObject);
begin
  if sCmBoxExTemplateDrive.ItemIndex = -1 then Exit;
  SpEdDiskSpace.Value := aTempLateDrive[sCmBoxExTemplateDrive.ItemIndex];
end;

procedure TFrmMain.sCmBoxPlotsTypeSelect(Sender: TObject);
begin
  if sCmBoxPlotsType.ItemIndex = -1 then exit;
  sSpEditRam.Value := aDefaultRamSz[TPlotsType(sCmBoxPlotsType.ItemIndex)];
end;

procedure TFrmMain.SetingsView;
begin
  if Not DEBUGS then Exit;
  with mm.Lines do
  begin
    add('APPDATA = ' + APPDATA);           // := GetEnvironmentVariable('APPDATA');
    add('LOCALAPPDATA = ' + LOCALAPPDATA); // := GetEnvironmentVariable('LOCALAPPDATA');
    add('USERPROFILE = ' + USERPROFILE);   // := GetEnvironmentVariable('USERPROFILE');
    add('PLOTTER = ' + PLOTTER);           // := GetPlotter;
    add('CurrentPath = ' + CurrentPath);   // := ExtractFilePath(Application.ExeName);
  end;
end;

procedure TFrmMain.SeveConfigPlotter;
var
  INI : TINIFile;
  SECTION: String;
begin
  SECTION := 'PLOTTER';

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
    INI.WriteString(SECTION, 'WalletKeyID', sCmBoxExKeyID.Text);
    INI.WriteInteger(SECTION, 'PlotType', sCmBoxPlotsType.ItemIndex);
    INI.WriteInteger(SECTION, 'PlotCount', sSpEditCount.Value);
    INI.WriteInteger(SECTION, 'Backets', sSpEditBackets.Value);
    INI.WriteInteger(SECTION, 'CPUThread', sSpEditCPUThred.Value);
    INI.WriteInteger(SECTION, 'SysRam', sSpEditRam.Value);
    INI.WriteBool(SECTION, 'BitField', sChBoxBitField.Checked);
  finally
    INI.Free;
  end;
end;

procedure TFrmMain.sRdBtnStile1Click(Sender: TObject);
begin
  mmCnsl.Color := clWhite;
  mmCnsl.Font.Color := clBlack;
end;

procedure TFrmMain.sRdBtnStile2Click(Sender: TObject);
begin
  mmCnsl.Color := clBlack;
  mmCnsl.Font.Color := clSilver;
end;

procedure TFrmMain.sSpEdHighChange(Sender: TObject);
begin
  if sSpEdHigh.Value <= sSpEdLow.Value then sSpEdLow.Value := sSpEdHigh.Value - 1;
end;

procedure TFrmMain.sSpEdLowChange(Sender: TObject);
begin
  if sSpEdLow.Value >= sSpEdHigh.Value then sSpEdHigh.Value := sSpEdLow.Value + 1;
  if sSpEdLow.Value < 0 then sSpEdLow.Value := 0;
end;

end.
