unit UFrmSelectProfile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sLabel, sEdit, sButton,
  sListBox, Vcl.ComCtrls, sListView, System.IniFiles, Vcl.Menus;

Type
  TFrmModeInit = (fmLoadeProfils, fmSaveProfils);

type
  TFrmSelectProfile = class(TForm)
    sBtnOk: TsButton;
    sEdProfileName: TsEdit;
    sLblProfileName: TsLabel;
    sLVProfile: TsListView;
    PopMenu: TPopupMenu;
    PM_DeleteProfile: TMenuItem;
    procedure sBtnOkClick(Sender: TObject);
    function AddItems: integer;
    function ProfileNameExists(ProfileName: String): Boolean;
    Procedure FrmShohowInit(ModeInit: TFrmModeInit);
    procedure ReadProfilsList;
    procedure sLVProfileClick(Sender: TObject);
    procedure PM_DeleteProfileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Apply: Boolean;
    FrmMode: TFrmModeInit;
  end;

var
  FrmSelectProfile: TFrmSelectProfile;

implementation

USES UFrmMDIMain, UFrmMDIChildPlotter;

{$R *.dfm}

function TFrmSelectProfile.AddItems: integer;
begin
  with sLVProfile.Items.Add do
  begin
    Caption := IntToStr(Index + 1);
    ImageIndex := 5;
    Result := Index;
    SubItems.Add('');
  end;
end;

procedure TFrmSelectProfile.FrmShohowInit(ModeInit: TFrmModeInit);
begin
  ReadProfilsList;
  Case ModeInit of
    fmSaveProfils:
      begin
        sEdProfileName.Enabled := true;
        sEdProfileName.Text := 'NewProfile_' +
          IntToStr(sLVProfile.Items.Count + 1);
        sBtnOk.Caption := 'СОХРАНИТЬ';
      end;
    fmLoadeProfils:
      begin
        sEdProfileName.Text := '';
        sEdProfileName.Enabled := false;
        sBtnOk.Caption := 'ЗАГРУЗИТЬ'; //
      end;
  End;
  FrmMode := ModeInit;
  Apply := false;
  ShowModal;
end;

procedure TFrmSelectProfile.PM_DeleteProfileClick(Sender: TObject);
var
  INI: TIniFile;
begin
  if sLVProfile.Selected = NIL then
    Exit;
  if MessageBox(Handle, PChar('Вы собираетесь удалить профиль "' +
    sLVProfile.Selected.SubItems[0] + '"' + #10#13 + '"Да" - удалить' + #13#10 +
    '"Нет - отменить"'), PChar(CAPTION_MB), MB_ICONWARNING or MB_YESNOCANCEL) <> ID_YES
  then
    Exit;

  // if profile in directory: ..\Appdata\roaming\
  // if Not FileExists(IncludeTrailingPathDelimiter(ConfigDir) + ConfigFile) then Exit;
  // INI := TIniFile.Create(IncludeTrailingPathDelimiter(ConfigDir) + ConfigFile);

  INI := TIniFile.Create(CurrentPath + ConfigFile);
  try
    INI.EraseSection('PLOTTER\' + sLVProfile.Selected.SubItems[0]);
    sLVProfile.Selected.Delete;
  finally
    INI.Free;
  end;

end;

function TFrmSelectProfile.ProfileNameExists(ProfileName: String): Boolean;
var
  i: SmallInt;
begin
  Result := false;
  for i := 0 to sLVProfile.Items.Count - 1 do
  begin
    if sLVProfile.Items[i].SubItems[0] = sEdProfileName.Text then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

procedure TFrmSelectProfile.ReadProfilsList;
var
  INI: TIniFile;
  ST: TStrings;
  i, x: integer;
begin

  {
    // if profile in directory: ..\Appdata\roaming\
    if Not DirectoryExists(ConfigDir) then ForceDirectories(ConfigDir);
    if Not DirectoryExists(ConfigDir) then
    begin
    MessageBox(Handle, PChar('Неудалось найти директорию "'+ ConfigDir +'" с конфигурационным файлом '
    + ' в профиле пользователя.'), PChar(CAPTION_MB), MB_ICONERROR);
    Exit;
    end;
    INI := TIniFile.Create(IncludeTrailingPathDelimiter(ConfigDir) + ConfigFile);
  }

  ST := TStringList.Create;
  INI := TIniFile.Create(CurrentPath + ConfigFile);
  sLVProfile.Clear;
  try
    INI.ReadSubSections('PLOTTER', ST);

    for i := 0 to ST.Count - 1 do
    begin
      x := AddItems;
      sLVProfile.Items[x].SubItems[0] := ST.Strings[i];
    end;

  finally
    ST.Free;
    INI.Free;
  end;

end;

procedure TFrmSelectProfile.sBtnOkClick(Sender: TObject);
begin
  case FrmMode of
    fmSaveProfils:
      begin
        if ProfileNameExists(sEdProfileName.Text) then
          if MessageBox(Handle,
            PChar('Профиль с таким именем ' + sEdProfileName.Text +
            'будет переписан' + #13#10 + 'Для подтверждения нажмите "ДА"' +
            #13#10 + 'Для отмены нажмите "НЕТ"'), PChar(CAPTION_MB),
            MB_ICONWARNING or MB_YESNO) <> ID_YES then
            Exit;
      end;
    fmLoadeProfils:
      begin
        if sLVProfile.Selected = Nil then
        begin
          MessageBox(Handle, PChar('Не выбран ни какой профиль.'),
            PChar(CAPTION_MB), MB_ICONWARNING);
          Exit;
        end;
      end;
  end;

  Apply := true;
  Close;
end;

procedure TFrmSelectProfile.sLVProfileClick(Sender: TObject);
begin
  if sLVProfile.Selected = Nil then
    Exit;
  sEdProfileName.Text := sLVProfile.Selected.SubItems[0];
end;

end.
