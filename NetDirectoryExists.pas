unit NetDirectoryExists;

interface

type

  TNetDirectoryExists = class
  public
    Function NetDirectoryExists( const dirname: String;
                          timeoutMSecs: Cardinal ): Boolean;
  end;

implementation

uses
  Classes, Sysutils, Windows;


type

   ExceptionClass = Class Of Exception;
   TTestResult = (trNoDirectory, trDirectoryExists, trTimeout );
   TNetDirThread = class(TThread)
   private
     FDirname: String;
     FErr    : String;
     FErrclass: ExceptionClass;
     FResult : Boolean;
   protected
     procedure Execute; override;
   public
     Function TestForDir( const dirname: String; timeoutMSecs: Dword ):TTestResult;
   end;



Function TNetDirectoryExists.NetDirectoryExists(
            const dirname: String; timeoutMSecs: Dword ): Boolean;
 Var
   res: TTestResult;
   thread: TNetDirThread;
 Begin
   Assert( dirname <> '', 'NetDirectoryExists: dirname cannot be empty.' );
   Assert( timeoutMSecs > 0, 'NetDirectoryExists: timeout cannot be 0.' );
   thread:= TNetDirThread.Create( true );
   try
     res:= thread.TestForDir( dirname, timeoutMSecs );
     Result := res = trDirectoryExists;
     If res <> trTimeout Then
       thread.Free;
     {Note: if the thread timed out it will free itself when it finally
      terminates on its own. }
   except
     thread.free;
     raise
   end;
 End;


procedure TNetDirThread.Execute;
 begin
   try
     FResult := DirectoryExists( FDirname );
   except
     On E: Exception Do Begin
       FErr := E.Message;
       FErrclass := ExceptionClass( E.Classtype );
     End;
   end;
 end;


function TNetDirThread.TestForDir(const dirname: String;
   timeoutMSecs: Dword): TTestResult;
 begin
   FDirname := dirname;
   Resume;
   If WaitForSingleObject( Handle, timeoutMSecs ) = WAIT_TIMEOUT
   Then Begin
     Result := trTimeout;
     FreeOnTerminate := true;
   End
   Else Begin
     If Assigned( FErrclass ) Then
       raise FErrClass.Create( FErr );
     If FResult Then
       Result := trDirectoryExists
     Else
       Result := trNoDirectory;
   End;
 end;

end.