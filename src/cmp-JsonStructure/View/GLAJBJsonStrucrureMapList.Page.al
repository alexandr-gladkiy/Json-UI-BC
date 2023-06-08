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
                IndentationControls = "Key", "Value";
                //ShowAsTree = true;

                field("Structure Code"; Rec."Structure Code")
                {
                    ToolTip = 'Specifies the value of the Structure Code field.';
                    Visible = false;
                }
                field("Line No"; Rec."Line No")
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
                field("Parrent Key"; Rec."Parent Key")
                {
                    ToolTip = 'Specifies the value of the Parrent Key field.';
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
}
