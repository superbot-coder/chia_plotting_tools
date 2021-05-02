unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, sMemo,
  sSkinManager, sLabel, sEdit, Vcl.ComCtrls, sComboBoxes, Vcl.Samples.Spin,
  Winapi.ShellApi, System.ImageList, Vcl.ImgList, sSpinEdit, sGroupBox;

type
  TFrmMain = class(TForm)
    sSkinManager: TsSkinManager;
    mm: TsMemo;
    sBtnCalculate: TsButton;
    sLabel1: TsLabel;
    SpEdDiskSpace: TSpinEdit;
    sCmBoxExSelDisk: TsComboBoxEx;
    LblSelectDisk: TsLabel;
    ImageListDrive: TImageList;
    sLblAdmissibleSpace: TsLabel;
    sGrBox: TsGroupBox;
    sSpEdLow: TsSpinEdit;
    sLblLow: TsLabel;
    sLblHigh: TsLabel;
    sSpEdHigh: TsSpinEdit;
    procedure sBtnCalculateClick(Sender: TObject);
    procedure ScanDrive;
    function AddAssociatedIcon(FileName: String; ImageList: TImageList): Integer;
    procedure FormCreate(Sender: TObject);
    procedure sCmBoxExSelDiskSelect(Sender: TObject);
    procedure sSpEdLowChange(Sender: TObject);
    procedure sSpEdHighChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type TPlotsType = (K32, K33, K34);

var
  FrmMain: TFrmMain;
  aPlots: Array[TPlotsType] of real = (101.4, 208.8, 429.8);
  аPlotsStr: Array[TPlotsType] of String = ('K32','K33','K34');
  aPlotsMaxCount: Array[TPlotsType] of DWORD;
  SELECT_DISK_FREE_SZ: UInt64;

const
  CAPTION_MB = 'Chia Plotter Calculator';

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

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  ScanDrive;
  Constraints.MinHeight := 480;
  Constraints.MinWidth  := 640;
end;

procedure TFrmMain.sBtnCalculateClick(Sender: TObject);
var
  N32, N33, N34: integer;
  Sum: Real;      // Summa
  Rem: Real;      // Remainder
  SmallRem: real; // Small Remainder
  LastDescription : string;
  DescriptStr     : String;
begin

  if SpEdDiskSpace.Value < aPlots[K32] then
  begin
    MessageBox(Handle, PChar('Указанный размер не соответсвуе требуемому минимальному размеру диска 209 Gb'),
               PChar(CAPTION_MB), MB_ICONWARNING);
    exit;
  end;

  mm.Lines.Clear;
  aPlotsMaxCount[K32] := Trunc(SpEdDiskSpace.Value / aPlots[K32]);
  aPlotsMaxCount[K33] := Trunc(SpEdDiskSpace.Value / aPlots[K33]);
  aPlotsMaxCount[K34] := Trunc(SpEdDiskSpace.Value / aPlots[K34]);

  SmallRem := aPlots[K32]; // размер самого малого "плота"

  mm.Lines.Add('Другие приближенные значения:');
  for N34 := 0 to aPlotsMaxCount[K34] do
  begin
    for N33 := 0 to aPlotsMaxCount[K33] do
    begin
      For N32 := 0 to aPlotsMaxCount[K32] do
      begin
        sum := aPlots[K34] * N34 + aPlots[K33] * N33 + aPlots[K32] * N32;
        if (sum < SpEdDiskSpace.Value) then
        begin
          Rem := SpEdDiskSpace.Value - sum;
          // Что бы показать и другие приближенные значения к миниму. 1/4 от минимального плота
          if (Rem < sSpEdHigh.Value) and (Rem > sSpEdLow.Value) then
          begin
            DescriptStr := аPlotsStr[K34] + 'x' + IntToStr(N34) +
                           ' + ' + аPlotsStr[K33] + 'x' + IntToStr(N33) +
                           ' + ' + аPlotsStr[K32] + 'x' + IntToStr(N32);
            DescriptStr := DescriptStr + ' = ' + FloatToStrF(sum, ffFixed, 8, 2) +
                           'Gb free Size = ' + FloatToStrF(rem, ffFixed, 8,2) + 'Gb';
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
  mm.Lines.Add('Найден самый оптимальный вариант: ' + LastDescription);
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

procedure TFrmMain.sSpEdHighChange(Sender: TObject);
begin
  if sSpEdHigh.Value <= sSpEdLow.Value then sSpEdLow.Value := sSpEdHigh.Value - 1;
end;

procedure TFrmMain.sSpEdLowChange(Sender: TObject);
begin
  if sSpEdLow.Value >= sSpEdHigh.Value then sSpEdHigh.Value := sSpEdLow.Value + 1;
end;

end.
