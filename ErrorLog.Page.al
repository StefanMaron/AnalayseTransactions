page 50100 ErrorLog
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ErrorLog;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field("Entry No."; Rec.EntryNo)
                {
                }
                field("Error Text"; Rec.ErrorText)
                {
                }
                field(ErrorCallStack; Rec.ErrorCallStack)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LogSimpleError)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ErrorLog: Record ErrorLog;
                begin
                    ErrorLog.LogError('Error text', '');
                end;
            }
            action(RunWithoutError_Tests)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestRunnerProcedureIsolation: Codeunit TestRunnerProcedureIsolation;
                    TestSalesHeaderValidation: Codeunit TestSalesHeaderValidation;
                begin
                    TestSalesHeaderValidation.SetWhatToExecute('WithoutError');
                    if TestRunnerProcedureIsolation.RunWithInterface(TestSalesHeaderValidation) then
                        Codeunit.Run(Codeunit::TestSalesHeaderValidation);
                end;
            }
            action(RunWithError_Tests)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestRunnerProcedureIsolation: Codeunit TestRunnerProcedureIsolation;
                    TestSalesHeaderValidation: Codeunit TestSalesHeaderValidation;
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.FindFirst();
                    SalesHeader.Modify(true);

                    TestSalesHeaderValidation.SetWhatToExecute('WithError');
                    if TestRunnerProcedureIsolation.RunWithInterface(TestSalesHeaderValidation) then
                        TestSalesHeaderValidation.ConditionalRun();
                end;
            }
            action(RunWithoutError)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    OuterCodeunit: Codeunit OuterCodeunit;
                    TestSalesHeaderValidation, TestSalesHeaderValidation2 : Codeunit TestSalesHeaderValidation;
                    ErrorLogger: Codeunit MyErrorLogger;
                    ConditionalRunners: List of [Interface ConditionalRunner];
                begin

                    TestSalesHeaderValidation.SetWhatToExecute('WithoutError');
                    ConditionalRunners.Add(TestSalesHeaderValidation);

                    TestSalesHeaderValidation2.SetWhatToExecute('WithoutError');
                    ConditionalRunners.Add(TestSalesHeaderValidation2);

                    OuterCodeunit.SaveRun(ConditionalRunners, ErrorLogger, false);
                end;
            }
            action(RunWithError)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    OuterCodeunit: Codeunit OuterCodeunit;
                    TestSalesHeaderValidation, TestSalesHeaderValidation2 : Codeunit TestSalesHeaderValidation;
                    ErrorLogger: Codeunit MyErrorLogger;
                    ConditionalRunners: List of [Interface ConditionalRunner];
                begin

                    TestSalesHeaderValidation.SetWhatToExecute('WithError');
                    ConditionalRunners.Add(TestSalesHeaderValidation);

                    TestSalesHeaderValidation2.SetWhatToExecute('WithError');
                    ConditionalRunners.Add(TestSalesHeaderValidation2);

                    OuterCodeunit.SaveRun(ConditionalRunners, ErrorLogger, false);
                end;
            }
        }
    }
}