codeunit 50102 TestSalesHeaderValidation implements ConditionalRunner
{

    var
        WhatToExecute: Text;

    procedure SetWhatToExecute(WhatToExecuteIn: Text)
    begin
        WhatToExecute := WhatToExecuteIn;
    end;

    local procedure WithError()
    begin
        WithoutError();
        Error('Some custom Error for function only');
    end;

    local procedure WithoutError()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.FindFirst();
        SalesHeader.Validate("Requested Delivery Date", Today());
        SalesHeader.Modify(true);
    end;

    procedure ConditionalRun()
    begin
        case WhatToExecute of
            'WithError':
                WithError();
            'WithoutError':
                WithoutError();
        end;
    end;

}