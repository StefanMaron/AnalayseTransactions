table 50100 ErrorLog
{
    DataClassification = SystemMetadata;
    InherentPermissions = RIMDX;

    fields
    {
        field(1; EntryNo; Integer)
        {
            AutoIncrement = true;
        }
        field(2; ErrorText; Text[2048])
        {
        }
        field(3; ErrorCallStack; Text[2048])
        {
        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }


    procedure LogError(ErrorTextIn: Text; ErrorCallStackIn: Text)
    begin
        Rec.Init();
        Rec.EntryNo := 0;
        Rec."ErrorText" := CopyStr(ErrorTextIn, 1, MaxStrLen(Rec."ErrorText"));
        Rec.ErrorCallStack := CopyStr(ErrorCallStackIn, 1, MaxStrLen(Rec.ErrorCallStack));
        Rec.Insert();
    end;

    procedure LogLastError()
    begin
        LogError(GetLastErrorText(), GetLastErrorCallStack());
    end;
}