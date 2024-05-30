codeunit 50105 MyErrorLogger implements ErrorLogger
{
    var
        TempErrorLog: Record ErrorLog temporary;
        LastErrorLogEntryNo: Integer;

    procedure Append(LastErrorMessage: Text; LastErrorCallStack: Text)
    begin
        LastErrorLogEntryNo += 1;

        TempErrorLog.Init();
        TempErrorLog.EntryNo := LastErrorLogEntryNo;
        TempErrorLog."ErrorText" := CopyStr(LastErrorMessage, 1, MaxStrLen(TempErrorLog."ErrorText"));
        TempErrorLog.ErrorCallStack := CopyStr(LastErrorCallStack, 1, MaxStrLen(TempErrorLog.ErrorCallStack));
        TempErrorLog.Insert();
    end;

    procedure SaveToDatabase();
    var
        ErrorLog: Record ErrorLog;
    begin
        if TempErrorLog.FindSet() then
            repeat
                ErrorLog.Init();
                ErrorLog := TempErrorLog;
                ErrorLog.EntryNo := 0;
                ErrorLog.Insert();
            until TempErrorLog.Next() = 0;
    end;

    procedure IsEmpty(): Boolean;
    begin
        exit(TempErrorLog.IsEmpty());
    end;

}