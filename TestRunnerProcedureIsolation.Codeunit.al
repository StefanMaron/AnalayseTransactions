codeunit 50101 TestRunnerProcedureIsolation
{
    Subtype = TestRunner;
    TestIsolation = Function;

    var
        ConditionalRunner: Interface ConditionalRunner;
        TestWasSuccessful: Boolean;

    procedure RunWithInterface(ConditionalRunnerIn: Interface ConditionalRunner): Boolean
    var
        TestRunnerProcedureIsolation: Codeunit TestRunnerProcedureIsolation;
    begin
        TestRunnerProcedureIsolation.SetInterface(ConditionalRunnerIn);
        TestRunnerProcedureIsolation.Run();
        exit(TestRunnerProcedureIsolation.GetTestWasSuccessful());
    end;

    procedure SetInterface(ConditionalRunnerIn: Interface ConditionalRunner)
    begin
        ConditionalRunner := ConditionalRunnerIn;
    end;

    procedure GetTestWasSuccessful(): Boolean
    begin
        exit(TestWasSuccessful);
    end;

    trigger OnRun()
    var
        TestCodeunitInIsolation: Codeunit TestCodeunitInIsolation;
    begin
        TestCodeunitInIsolation.SetInterface(ConditionalRunner);
        TestWasSuccessful := TestCodeunitInIsolation.Run();
    end;

    trigger OnAfterTestRun(CodeunitId: Integer; CodeunitName: Text; FunctionName: Text; Permissions: TestPermissions; Success: Boolean)
    var
        ErrorLog: Record ErrorLog;
    begin
        if not Success and (FunctionName <> '') then
            ErrorLog.LogError(GetLastErrorText(), GetLastErrorCallStack());
    end;
}