/// <summary>
/// Page GLA JB Json Structure List (ID 380000).
/// Component: Json Structure
/// </summary>
page 380000 "GLA JB Json Structure List"
{
    ApplicationArea = All;
    Caption = 'Json Structure List';
    PageType = List;
    SourceTable = "GLA JB Json Structure";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
        }
    }

    actions
    {
        area(Processing)
        {
            group(Json)
            {
                Caption = 'Json';
                action(ExportJson)
                {
                    Caption = 'Export';
                    Image = Export;
                    trigger OnAction()
                    begin
                        sJsonStructure.CreateJsonAsFile(Rec."Code")
                    end;
                }

                action(ImportJson)
                {
                    Caption = 'Import';
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
