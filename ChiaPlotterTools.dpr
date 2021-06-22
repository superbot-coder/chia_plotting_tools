program ChiaPlotterTools;

uses
  Vcl.Forms,
  Windows,
  UFrmMDIMain in 'UFrmMDIMain.pas' {FrmMain} ,
  UFrmMDIChildCalculator
    in 'UFrmMDIChildCalculator.pas' {FrmMDIChildCalculator} ,
  UFrmMDIChildPlotter in 'UFrmMDIChildPlotter.pas' {FrmMDIChildPlotter} ,
  UFrmViewLog in 'UFrmViewLog.pas' {FrmViewLog} ,
  UFrmSelectProfile in 'UFrmSelectProfile.pas' {FrmSelectProfile} ,
  UFrmUpdate in 'UFrmUpdate.pas' {FrmUpdate};

{$R *.res}

Var
  HMUTEX: THandle;

begin

  HMUTEX := CreateMutex(Nil, True, 'Chia_Plotting_Tools_Mutex');
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    Exit;
  end;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmViewLog, FrmViewLog);
  Application.CreateForm(TFrmSelectProfile, FrmSelectProfile);
  Application.CreateForm(TFrmUpdate, FrmUpdate);
  // Application.CreateForm(TFrmMDIChildCalculator, FrmMDIChildCalculator);
  // Application.CreateForm(TFrmMDIChildPlotter, FrmMDIChildPlotter);
  Application.Run;

end.
