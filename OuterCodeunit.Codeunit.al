codeunit 50104 OuterCodeunit
{

    procedure SaveRun(ConditionalRunners: List of [Interface ConditionalRunner]; ErrorLogger: Interface ErrorLogger; SkipCommit: Boolean)
    var
        InnerCodeunit: Codeunit "InnerCodeunit";
        ConditionalRunner: Interface ConditionalRunner;
    begin
        foreach ConditionalRunner in ConditionalRunners do begin
            InnerCodeunit.SetInterface(ConditionalRunner);
            if InnerCodeunit.Run() or (not InnerCodeunit.GetWasSuccessful()) then
                ErrorLogger.Append(GetLastErrorText(), GetLastErrorCallStack());
        end;

        if not ErrorLogger.IsEmpty() then begin
            ErrorLogger.SaveToDatabase();
            exit;
        end;

        foreach ConditionalRunner in ConditionalRunners do
            ConditionalRunner.ConditionalRun();

        if not SkipCommit then
            Commit();
    end;
}