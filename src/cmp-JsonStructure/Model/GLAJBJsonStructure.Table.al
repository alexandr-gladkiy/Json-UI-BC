/// <summary>
/// Table GLA JB Json Structure (ID 380000).
/// Component: JsonStructure
/// </summary>
table 380000 "GLA JB Json Structure"
{
    Caption = 'Json Structure';
    DataClassification = ToBeClassified;
    LookupPageId = "GLA JB Json Structure List";
    DrillDownPageId = "GLA JB Json Structure List";

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Status; Enum "GLA JB Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(100; "Count Node"; Integer)
        {
            Caption = 'Count Node';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLA JB Json Structure Map" where("Structure Code" = field("Code")));
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
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
            mJsonStructure.ValidateTblJsonStructureOnInsert(Rec);
        OnAfterOnInsert(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModify(Rec, IsHandled);
        if not IsHandled then
            mJsonStructure.ValidateTblJsonStructureOnModify(Rec);
        OnAfterOnModify(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDelete(Rec, IsHandled);
        if not IsHandled then
            mJsonStructure.ValidateTblJsonStructureOnDelete(Rec);
        OnAfterOnDelete(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRename(Rec, IsHandled);
        if not IsHandled then
            mJsonStructure.ValidateTblJsonStructureOnRename(Rec);
        OnAfterOnRename(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDelete(var Request: Record "GLA JB Json Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsert(var Request: Record "GLA JB Json Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModify(var Request: Record "GLA JB Json Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRename(var Request: Record "GLA JB Json Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var Request: Record "GLA JB Json Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Request: Record "GLA JB Json Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModify(var Request: Record "GLA JB Json Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRename(var Request: Record "GLA JB Json Structure"; var IsHandled: Boolean)
    begin
    end;
}
