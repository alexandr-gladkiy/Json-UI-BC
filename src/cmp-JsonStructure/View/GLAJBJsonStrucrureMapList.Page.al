/// <summary>
/// Page GLA JB Json Strucrure Map List (ID 380001).
/// Component: Json Structure
/// </summary>
page 380001 "GLA JB Json Strucrure Map List"
{
    ApplicationArea = All;
    Caption = 'Json Strucrure Map List';
    PageType = List;
    SourceTable = "GLA JB Json Structure Map";
    SourceTableView = sorting("Structure Code", "Sorting Order");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = Rec."Indent Level";
                IndentationControls = "Key";
                //ShowAsTree = true;

                field("Structure Code"; Rec."Structure Code")
                {
                    ToolTip = 'Specifies the value of the Structure Code field.';
                    Visible = false;
                }
                field("Line No"; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No field.';
                    Visible = false;
                }
                field("Key"; Rec."Key")
                {
                    ToolTip = 'Specifies the value of the Key field.';
                }
                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.';
                }
                field("Data Type"; Rec."Data Type")
                {
                    ToolTip = 'Specifies the value of the Data Type field.';
                }
                field("Parent Key"; Rec."Parent Key")
                {
                    ToolTip = 'Specifies the value of the Parrent Key field.';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        LookupParentKey();
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Parent Line No."; Rec."Parent Line No.")
                {
                    ToolTip = 'Specifies the value of the "Parent Line No." field.';
                    Editable = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Has Children"; Rec."Has Children")
                {
                    ToolTip = 'Specifies the value of the "Has Children" field.';
                }
                field(Indent; Rec."Indent Level")
                {
                    ToolTip = 'Specifies the value of the Indent field.';
                }
                field("Sorting Order"; Rec."Sorting Order")
                {
                    ToolTip = 'Specifies the value of the "Sorting Order" field.';
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
                Visible = IsActionGroupJsonVisible;
                action("Show To Message")
                {
                    Caption = 'Show To Message';
                    Image = Export;
                    trigger OnAction()
                    begin
                        Message(sJsonStructure.CreateJsonAsText(Rec.GetFilter("Structure Code")))
                    end;
                }
                action("Export To File")
                {
                    Caption = 'Export To File';
                    Image = Export;
                    trigger OnAction()
                    begin
                        sJsonStructure.CreateJsonAsFile(Rec.GetFilter("Structure Code"));
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
            group("Indent Level")
            {
                Caption = 'Indent Level';
                Image = Indent;

                action("Update")
                {
                    Caption = 'Update';
                    Image = UpdateDescription;
                    trigger OnAction()
                    begin
                        sJsonStructure.UpdateIndentAndSortingStructureMapByStructureCode(Rec.GetFilter("Structure Code"));
                        CurrPage.Update(false);
                    end;
                }
            }

        }
    }
    var
        sJsonStructure: Codeunit "GLA JB Json Structure Service";
        IsActionGroupJsonVisible: Boolean;

    trigger OnOpenPage()
    begin
        IsActionGroupJsonVisible := Rec.GetFilter("Structure Code") <> '';
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage.Update(false);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage.Update(false);
    end;

    local procedure LookupParentKey()
    var
        JsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        if sJsonStructure.GetSetOfJsonStructureMap(Rec."Structure Code", JsonStructureMap) then begin
            JsonStructureMap.SetFilter("Line No.", '<>%1', Rec."Line No.");
            if Page.RunModal(Page::"GLA JB Json Strucrure Map List", JsonStructureMap) = Action::LookupOK then begin
                Rec.Validate("Parent Line No.", JsonStructureMap."Line No.");
                Rec.Validate("Parent Key", JsonStructureMap."Key");
            end;
        end;
    end;
}
