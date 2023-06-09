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
                field("Parent Key"; Rec."Parent Key")
                {
                    ToolTip = 'Specifies the value of the Parrent Key field.';

                    trigger OnDrillDown()
                    begin
                        LookupParentKey();
                        CurrPage.Update(false);
                    end;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Indent; Rec."Indent Level")
                {
                    ToolTip = 'Specifies the value of the Indent field.';
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
                        // TODO: Create function Create json file from structure
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

    local procedure LookupParentKey()
    var
        JsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        if sJsonStructure.GetSetOfJsonStructureMapByStructureCode(Rec."Structure Code", JsonStructureMap) then begin
            JsonStructureMap.SetFilter("Line No.", '<>%1', Rec."Line No.");
            if Page.RunModal(Page::"GLA JB Json Strucrure Map List", JsonStructureMap) <> Action::OK then
                exit;

            Rec."Parent Line No." := JsonStructureMap."Line No.";
            Rec.CalcFields("Parent Key");
        end;
    end;
}
