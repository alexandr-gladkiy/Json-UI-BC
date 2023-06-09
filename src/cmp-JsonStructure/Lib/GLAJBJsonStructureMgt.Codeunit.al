/// <summary>
/// Codeunit GLA JB Json Structure Mgt. (ID 380000).
/// Component: Json Structure
/// </summary>
codeunit 380000 "GLA JB Json Structure Mgt."
{
    var
        sJsonStructure: Codeunit "GLA JB Json Structure Service";

    /// <summary>
    /// ValidateTblJsonStructureOnInsert.
    /// </summary>
    /// <param name="JsonStructure">VAR Record "GLA JB Json Structure".</param>
    procedure ValidateTblJsonStructureOnInsert(var JsonStructure: Record "GLA JB Json Structure")
    begin

    end;

    /// <summary>
    /// ValidateTblJsonStructureOnModify.
    /// </summary>
    /// <param name="JsonStructure">VAR Record "GLA JB Json Structure".</param>
    procedure ValidateTblJsonStructureOnModify(var JsonStructure: Record "GLA JB Json Structure")
    begin

    end;

    /// <summary>
    /// ValidateTblJsonStructureOnDelete.
    /// </summary>
    /// <param name="JsonStructure">VAR Record "GLA JB Json Structure".</param>
    procedure ValidateTblJsonStructureOnDelete(var JsonStructure: Record "GLA JB Json Structure")
    begin
    end;

    /// <summary>
    /// ValidateTblJsonStructureOnRename.
    /// </summary>
    /// <param name="JsonStructure">VAR Record "GLA JB Json Structure".</param>
    procedure ValidateTblJsonStructureOnRename(var JsonStructure: Record "GLA JB Json Structure")
    begin

    end;

    /// <summary>
    /// ValidateTblJsonStructureMapOnInsert.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    procedure ValidateTblJsonStructureMapOnInsert(var JsonStructureMap: Record "GLA JB Json Structure Map")
    begin
        JsonStructureMap."Line No." := sJsonStructure.GetJsonStructureMapLastLineNo(JsonStructureMap."Structure Code") + 1;
    end;

    /// <summary>
    /// ValidateTblJsonStructureMapOnModify.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    procedure ValidateTblJsonStructureMapOnModify(var JsonStructureMap: Record "GLA JB Json Structure Map")
    begin

    end;

    /// <summary>
    /// ValidateTblJsonStructureMapOnDelete.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    procedure ValidateTblJsonStructureMapOnDelete(var JsonStructureMap: Record "GLA JB Json Structure Map")
    begin
    end;

    /// <summary>
    /// ValidateTblJsonStructureMapOnRename.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    procedure ValidateTblJsonStructureMapOnRename(var JsonStructureMap: Record "GLA JB Json Structure Map")
    begin

    end;

    /// <summary>
    /// ValidateFldJsonStructureMapOnValue.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    procedure ValidateFldJsonStructureMapOnValue(var JsonStructureMap: Record "GLA JB Json Structure Map")
    begin
        if JsonStructureMap."Value" <> '' then
            JsonStructureMap.TestField("Has Children", false);
    end;
}
