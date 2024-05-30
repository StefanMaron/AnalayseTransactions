codeunit 50100 TestCodeunitInIsolation
{
    Subtype = Test;

    var
        ConditionalRunner: Interface ConditionalRunner;

    [Test]
    procedure TryValidateRequestedDeliveryDate()
    begin
        ConditionalRunner.ConditionalRun();
    end;

    procedure SetInterface(ConditionalRunnerIn: Interface ConditionalRunner)
    begin
        ConditionalRunner := ConditionalRunnerIn;
    end;
}