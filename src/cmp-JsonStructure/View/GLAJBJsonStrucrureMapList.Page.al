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
                field("Data Type"; Rec."Data Type")
                {
                    ToolTip = 'Specifies the value of the Data Type field.';
                }
                field("Parent Key"; Rec."Parent Key")
                {
                    ToolTip = 'Specifies the value of the Parrent Key field.';

                    trigger OnDrillDown()
                    begin
                        LookupParentKey();
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
    var
        sJsonStructure: Codeunit "GLA JB Json Structure Service";

    local procedure LookupParentKey()
    var
        JsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        if sJsonStructure.GetSetOfJsonStructureMap(Rec."Structure Code", JsonStructureMap) then begin
            JsonStructureMap.SetFilter("Line No.", '<>%1', Rec."Line No.");
            if Page.RunModal(Page::"GLA JB Json Strucrure Map List", JsonStructureMap) = Action::LookupOK then begin
                Rec."Parent Key" := JsonStructureMap."Key";
            end;
        end;
    end;
}
