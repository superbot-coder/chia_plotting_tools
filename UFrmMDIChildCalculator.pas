unit UFrmMDIChildCalculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.ComCtrls, sComboBoxes, sEdit, sSpinEdit, sGroupBox, sButton,
  sLabel, Vcl.ExtCtrls, sPanel, sMemo, Winapi.ShellApi, System.ImageList,
  Vcl.ImgList, StrUtils;

type
  TFrmMDIChildCalculator = class(TForm)
    sSkinProvider: TsSkinProvider;
    sPnlCalculator: TsPanel;
    sLabel1: TsLabel;
    LblSelectDisk: TsLabel;
    sLblЕemplate: TsLabel;
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
    sCmBoxExTemplateDrive: TsComboBoxEx;
    mm: TsMemo;
    ImageListDrive: TImageList;
    function AddAssociatedIcon(FileName: String; ImageList: TImageList)
      : Integer;
    procedure sBtnCalculateClick(Sender: TObject);
    procedure sBtnUdateDriveListClick(Sender: TObject);
    procedure ScanDrive;
    procedure sSpEdHighChange(Sender: TObject);
    procedure sSpEdLowChange(Sender: TObject);
    procedure sCmBoxExSelDiskSelect(Sender: TObject);
    procedure sCmBoxExTemplateDriveSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FirstActivate: Boolean;
  public
    { Public declarations }
    TabSetID: String;
  end;

var
  FrmMDIChildCalculator: TFrmMDIChildCalculator;

implementation

USES UFrmMDIMain;

{$R *.dfm}

function TFrmMDIChildCalculator.AddAssociatedIcon(FileName: String;
  ImageList: TImageList): Integer;
var
  icon: Ticon;
  wd: WORD;
begin
  // Add associated Icon
  Result := -1;
  try
    icon := Ticon.Create;
    wd := 0;
    icon.Handle := ExtractAssociatedIcon(HInstance, PChar(FileName), wd);
    if icon.HandleAllocated then
      Result := ImageList.AddIcon(icon)
    else
    begin
      // ImageList.GetIcon(wd, icon);
      // ImageList.AddIcon(icon);
    end;

  finally
    icon.Free;
  end;
end;

procedure TFrmMDIChildCalculator.FormActivate(Sender: TObject);
begin
  if Not FirstActivate then
  begin
    FirstActivate := true;
    Exit;
  end;
end;

procedure TFrmMDIChildCalculator.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: ShortInt;
begin

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

procedure TFrmMDIChildCalculator.FormCreate(Sender: TObject);
begin
  ScanDrive;
end;

procedure TFrmMDIChildCalculator.sBtnCalculateClick(Sender: TObject);
var
  N32, N33, N34: Integer;
  Sum: Extended; // Summa
  Rem: Extended; // Remainder
  SmallRem: Extended; // Small Remainder
  LastDescription: string;
  DescriptStr: String;
  DiskSpace: Int64;
  ResultList: TStrings;
  aFilesCount: Array of WORD;
  MinFiles, i: WORD;

  function getMinimumFiles: WORD;
  var
    i: DWORD;
  begin
    if Length(aFilesCount) = 0 then
    begin
      Result := 0;
      Exit;
    end;
    Result := MAXWORD;
    for i := 0 to Length(aFilesCount) - 1 do
      if Result > aFilesCount[i] then
        Result := aFilesCount[i];
  end;

begin

  if SpEdDiskSpace.Value < 101 then
  begin
    MessageBox(Handle,
      PChar('Указанный размер не соответсвуе требуемому минимальному размеру диска 109 Gb'),
      PChar(CAPTION_MB), MB_ICONWARNING);
    Exit;
  end;
  mm.Lines.Clear;
  DiskSpace := SpEdDiskSpace.Value;
  // конвертация из GiB байты
  DiskSpace := DiskSpace * 1024 * 1024 * 1024;
  // Здесь вычисляются максимальное количество плотов
  aPlotsMaxCount[K32] := DiskSpace div aPlots[K32];
  aPlotsMaxCount[K33] := DiskSpace div aPlots[K33];
  aPlotsMaxCount[K34] := DiskSpace div aPlots[K34];

  SmallRem := aPlots[K32]; // размер самого малого "плота"
  ResultList := TStringList.Create;

  mm.Lines.Add('Другие приближенные значения:');
  try
    for N34 := 0 to aPlotsMaxCount[K34] do
    begin
      for N33 := 0 to aPlotsMaxCount[K33] do
      begin
        For N32 := 0 to aPlotsMaxCount[K32] do
        begin
          Sum := aPlots[K34] * N34 + aPlots[K33] * N33 + aPlots[K32] * N32;
          // if (sum < SpEdDiskSpace.Value) then
          if (Sum < DiskSpace) then
          begin
            Rem := DiskSpace - Sum;
            // сново конвертирую в GiB
            Sum := Sum / 1024 / 1024 / 1024;
            Rem := Rem / 1024 / 1024 / 1024;
            // Что бы показать и другие приближенные значения к миниму, задается диапазоном значений
            if (Rem < sSpEdHigh.Value) and (Rem > sSpEdLow.Value) then
            begin
              DescriptStr := аPlotsStr[K34] + 'x' + IntToStr(N34) + ' + ' +
                аPlotsStr[K33] + 'x' + IntToStr(N33) + ' + ' + аPlotsStr[K32] +
                'x' + IntToStr(N32);
              DescriptStr := DescriptStr + ' = ' + FloatToStrF(Sum, ffFixed, 10,
                2) + 'Gb free Size = ' + FloatToStrF(Rem, ffFixed, 8, 2) + 'Gb'
                + ' Files = ' + IntToStr(N34 + N33 + N32);
              // mm.Lines.Add(DescriptStr);
              ResultList.Add(DescriptStr);
              SetLength(aFilesCount, Length(aFilesCount) + 1);
              aFilesCount[Length(aFilesCount) - 1] := N34 + N33 + N32;

              if Rem < SmallRem then
              begin
                SmallRem := Rem;
                LastDescription := DescriptStr;
              end;

            end;
          end;
        end;
      end;
    end;

    MinFiles := getMinimumFiles;
    if Length(aFilesCount) <> 0 then
      for i := 0 to ResultList.Count - 1 do
      begin
        if MinFiles = aFilesCount[i] then
          LastDescription := ResultList.Strings[i];
        if aFilesCount[i] <= (MinFiles + 5) then
          mm.Lines.Add(ResultList.Strings[i]);
      end;

    mm.Lines.Add('');
    mm.Lines.Add('Найден самый оптимальный вариант:');
    mm.Lines.Add(LastDescription);

  finally
    ResultList.Free;
  end;
end;

procedure TFrmMDIChildCalculator.sBtnUdateDriveListClick(Sender: TObject);
begin
  ScanDrive;
  sCmBoxExSelDisk.Text := '';
  sCmBoxExSelDisk.SetFocus;
end;

procedure TFrmMDIChildCalculator.ScanDrive;
var
  Drive: Char;
  index: ShortInt;
begin
  sCmBoxExSelDisk.Items.Clear;
  ImageListDrive.Clear;
  for Drive := 'C' to 'Z' do
  begin
    Case GetDriveType(PWideChar(Drive + ':\')) of
      DRIVE_FIXED:
        begin
          index := sCmBoxExSelDisk.Items.Add(Drive + ':\');
          sCmBoxExSelDisk.ItemsEx[index].ImageIndex :=
            AddAssociatedIcon(Drive + ':\', ImageListDrive);
        end;

      DRIVE_REMOVABLE:
        begin
          index := sCmBoxExSelDisk.Items.Add(Drive + ':\');
          sCmBoxExSelDisk.ItemsEx[index].ImageIndex :=
            AddAssociatedIcon(Drive + ':\', ImageListDrive);
        end;

      DRIVE_REMOTE:
        begin
          index := sCmBoxExSelDisk.Items.Add(Drive + ':\');
          sCmBoxExSelDisk.ItemsEx[index].ImageIndex :=
            AddAssociatedIcon(Drive + ':\', ImageListDrive);
        end;

      DRIVE_RAMDISK:
        begin
          index := sCmBoxExSelDisk.Items.Add(Drive + ':\');
          sCmBoxExSelDisk.ItemsEx[index].ImageIndex :=
            AddAssociatedIcon(Drive + ':\', ImageListDrive);
        end;
    End;
  end;
end;

procedure TFrmMDIChildCalculator.sCmBoxExSelDiskSelect(Sender: TObject);
var
  Free_Bytes, TotalSize, FreeSize: Int64;
begin
  GetDiskFreeSpaceEx(PChar(sCmBoxExSelDisk.Text), Free_Bytes, TotalSize,
    @FreeSize);
  SpEdDiskSpace.Value := (FreeSize div 1024 div 1024 div 1024);
end;

procedure TFrmMDIChildCalculator.sCmBoxExTemplateDriveSelect(Sender: TObject);
begin
  if sCmBoxExTemplateDrive.ItemIndex = -1 then
    Exit;
  SpEdDiskSpace.Value := aTempLateDrive[sCmBoxExTemplateDrive.ItemIndex];
end;

procedure TFrmMDIChildCalculator.sSpEdHighChange(Sender: TObject);
begin
  if sSpEdHigh.Value <= sSpEdLow.Value then
    sSpEdLow.Value := sSpEdHigh.Value - 1;
end;

procedure TFrmMDIChildCalculator.sSpEdLowChange(Sender: TObject);
begin
  if sSpEdLow.Value >= sSpEdHigh.Value then
    sSpEdHigh.Value := sSpEdLow.Value + 1;
  if sSpEdLow.Value < 0 then
    sSpEdLow.Value := 0;
end;

end.
