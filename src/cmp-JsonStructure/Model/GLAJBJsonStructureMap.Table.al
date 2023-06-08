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
            AutoIncrement = true;
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
        }
        field(5; "Parrent Key"; Text[50])
        {
            Caption = 'Parrent Key';
            DataClassification = CustomerContent;
        }
        field(6; Status; Enum "GLA JB Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(7; Indent; Integer)
        {
            Caption = 'Indent';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Structure Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Key", "Value", "Parrent Key")
        {

        }
    }

    var
        mJsonStructure: Codeunit "GLA JB Json Structure Mgt.";

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
