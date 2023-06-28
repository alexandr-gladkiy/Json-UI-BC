/// <summary>
/// Page GLA JB Json Builder Card (ID 380003).
/// Component: Json Structure/// 
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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Count Node"; Rec."Count Node")
                {
                    ToolTip = 'Specifies the value of the Count Node field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Json)
            {
                Caption = 'Json';
                action("Show To Message")
                {
                    Caption = 'Show To Message';
                    Image = Export;
                    trigger OnAction()
                    begin
                        Message(sJsonStructure.CreateJsonAsText(Rec."Code"))
                    end;
                }
                action("Export To File")
                {
                    Caption = 'Export To File';
                    Image = Export;
                    trigger OnAction()
                    begin
                        sJsonStructure.CreateJsonAsFile(Rec."Code")
                    end;
                }

                action("Import From File")
                {
                    Caption = 'Import From File';
                    Image = Import;
                    trigger OnAction()
                    begin
                        // TODO: Create function create structure from file
                    end;
                }
            }

        }
    }

    var
        sJsonStructure: Codeunit "GLA JB Json Structure Service";
}
