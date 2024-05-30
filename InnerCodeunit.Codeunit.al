codeunit 50103 InnerCodeunit
{
    var
        ConditionalRunner: Interface ConditionalRunner;
        ConditionalCodeWasSuccessful: Boolean;

    trigger OnRun()
    begin
        ConditionalCodeWasSuccessful := false;

        RunCodeWithoutCommits();

        ConditionalCodeWasSuccessful := true;

        Error('');
    end;

    [CommitBehavior(CommitBehavior::Ignore)]
    local procedure RunCodeWithoutCommits()
    begin
        ConditionalRunner.ConditionalRun();
    end;

    procedure GetWasSuccessful(): Boolean
    begin
        exit(ConditionalCodeWasSuccessful);
    end;

    procedure SetInterface(ConditionalRunnerIn: Interface ConditionalRunner)
    begin
        ConditionalRunner := ConditionalRunnerIn;
    end;
}