/// <summary>
/// Table GLA JB Json Structure Map (ID 380001).
/// Component: JsonStructure
/// </summary>
table 380001 "GLA JB Json Structure Map"
{
    Caption = 'Json Builder Map';
    DataClassification = ToBeClassified;
    LookupPageId = "GLA JB Json Strucrure Map List";
    DrillDownPageId = "GLA JB Json Strucrure Map List";

    fields
    {
        field(1; "Structure Code"; Code[30])
        {
            Caption = 'Structure Code';
            DataClassification = CustomerContent;
            TableRelation = "GLA JB Json Structure"."Code";
            ValidateTableRelation = true;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; "Key"; Text[50])
        {
            Caption = 'Key';
            DataClassification = CustomerContent;
        }
        field(4; "Value"; Text[1024])
        {
            Caption = 'Value';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                mJsonStructure.ValidateFldJsonStructureMapOnValue(Rec);
            end;
        }
        field(5; "Parent Key"; Text[50])
        {
            Caption = 'Parrent Key';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                mJsonStructure.ValidateFldJsonStructureMapOnParrentKey(Rec);
            end;
        }
        field(6; "Has Children"; Boolean)
        {
            Caption = 'Has Children';
            DataClassification = CustomerContent;
        }
        field(7; Status; Enum "GLA JB Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(8; "Indent Level"; Integer)
        {
            Caption = 'Indent';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Structure Code", "Line No")
        {
            Clustered = true;
        }

        key(UK1; "Key", "Parent Key")
        {
            Unique = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Key", "Value", "Parent Key")
        {

        }
    }

    var
        mJsonStructure: Codeunit "GLA JB Json Structure Mgt.";

    /// <summary>
    /// UpdateIndentation.
    /// </summary>
    procedure UpdateIndentation()
    var
        Parent: Record "GLA JB Json Structure Map";
    begin
        if Parent.Get(Rec."Parent Key") then
            UpdateIndentationTree(Parent."Indent Level" + 1)
        else
            UpdateIndentationTree(0);
    end;

    /// <summary>
    /// UpdateIndentationTree.
    /// </summary>
    /// <param name="Level">Integer.</param>
    procedure UpdateIndentationTree(Level: Integer)
    var
        JsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        Rec."Indent Level" := Level;

        JsonStructureMap.Reset();
        JsonStructureMap.SetRange("Parent Key", Rec."Key");
        if JsonStructureMap.FindSet(true) then
            repeat
                JsonStructureMap.UpdateIndentationTree(Level + 1);
                JsonStructureMap."Has Children" := JsonStructureMap.HasChildren();
                JsonStructureMap.Modify(true);
            until JsonStructureMap.Next() = 0;
    end;

    /// <summary>
    /// HasChildren.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure HasChildren(): Boolean
    var
        JsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        JsonStructureMap.Reset();
        JsonStructureMap.SetCurrentKey("Parent Key");
        JsonStructureMap.SetRange("Parent Key", Rec."Key");
        exit(not JsonStructureMap.IsEmpty)
    end;

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled);
        if not IsHandled then
            mJsonStructure.ValidateTblJsonStructureMapOnInsert(Rec);
        OnAfterOnInsert(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModify(Rec, IsHandled);
        if not IsHandled then
            mJsonStructure.ValidateTblJsonStructureMapOnModify(Rec);
        OnAfterOnModify(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDelete(Rec, IsHandled);
        if not IsHandled then
            mJsonStructure.ValidateTblJsonStructureMapOnDelete(Rec);
        OnAfterOnDelete(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRename(Rec, IsHandled);
        if not IsHandled then
            mJsonStructure.ValidateTblJsonStructureMapOnRename(Rec);
        OnAfterOnRename(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDelete(var JsonStructureMap: Record "GLA JB Json Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsert(var JsonStructureMap: Record "GLA JB Json Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModify(var JsonStructureMap: Record "GLA JB Json Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRename(var JsonStructureMap: Record "GLA JB Json Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var JsonStructureMap: Record "GLA JB Json Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var JsonStructureMap: Record "GLA JB Json Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModify(var JsonStructureMap: Record "GLA JB Json Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRename(var JsonStructureMap: Record "GLA JB Json Structure Map"; var IsHandled: Boolean)
    begin
    end;
}
