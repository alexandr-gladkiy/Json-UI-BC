/// <summary>
/// Page GLA JB Json Builder Card (ID 380003).
/// </summary>
page 380003 "GLA JB Json Structure Card"
{
    ApplicationArea = All;
    Caption = 'Json Structure Card';
    PageType = Card;
    SourceTable = "GLA JB Json Structure";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Count Node"; Rec."Count Node")
                {
                    ToolTip = 'Specifies the value of the Count Node field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            usercontrol(url; UrlHack)
            {
                trigger GetApiKey(ApiKey: Text)
                begin
                    Message(ApiKey);
                end;
            }
        }
    }
}
