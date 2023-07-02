/// <summary>
/// Codeunit GLA JB Json Structure Mgt. (ID 380000).
/// Component: Json Structure
/// </summary>
codeunit 380000 "GLA JB Json Structure Mgt."
{
    var
        sJsonStructure: Codeunit "GLA JB Json Structure Service";
        GlobalJsonStructureMap: Record "GLA JB Json Structure Map";

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
    /// ValidateFldJsonStructureMapOnParentKey.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    /// <param name="xJsonStructureMap">Record "GLA JB Json Structure Map".</param>
    procedure ValidateFldJsonStructureMapOnParentKey(var JsonStructureMap: Record "GLA JB Json Structure Map"; xJsonStructureMap: Record "GLA JB Json Structure Map")
    var
        ParentJsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        if JsonStructureMap."Parent Key" = xJsonStructureMap."Parent Key" then
            exit;

        if JsonStructureMap."Parent Key" = '' then begin
            JsonStructureMap."Parent Line No." := 0;

            sJsonStructure.SetStructureMap(JsonStructureMap."Structure Code", xJsonStructureMap."Parent Line No.");

            ParentJsonStructureMap.Get(JsonStructureMap."Structure Code", xJsonStructureMap."Parent Line No.");
            ParentJsonStructureMap.Validate("Has Children", sJsonStructure.GetCountChildren() > 1);
            ParentJsonStructureMap.Modify(true);
            exit;
        end;

        ParentJsonStructureMap.Get(JsonStructureMap."Structure Code", JsonStructureMap."Parent Line No.");
        ParentJsonStructureMap.Validate("Has Children", true);
        ParentJsonStructureMap.Validate("Value", '');
        ParentJsonStructureMap.Validate("Data Type", ParentJsonStructureMap."Data Type"::"None");
        ParentJsonStructureMap.Modify(true);
    end;

    /// <summary>
    /// ValidateFldJsonStructureMapOnKey.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    /// <param name="xJsonStructureMap">Record "GLA JB Json Structure Map".</param>
    procedure ValidateFldJsonStructureMapOnKey(var JsonStructureMap: Record "GLA JB Json Structure Map"; xJsonStructureMap: Record "GLA JB Json Structure Map")
    begin
        if JsonStructureMap."Key" = xJsonStructureMap."Key" then
            exit;

        if JsonStructureMap."Key" = '' then
            Error('Key cannot be empty.');

        if sJsonStructure.SetStructureMap(JsonStructureMap."Structure Code", JsonStructureMap."Line No.") then
            if sJsonStructure.GetSetOfJsonStructureMapByParentKey(JsonStructureMap."Structure Code", xJsonStructureMap."Key", GlobalJsonStructureMap) then
                GlobalJsonStructureMap.ModifyAll("Parent Key", JsonStructureMap."Key", true);
    end;

    /// <summary>
    /// ValidateFldJsonStructureMapOnValue.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    procedure ValidateFldJsonStructureMapOnValue(var JsonStructureMap: Record "GLA JB Json Structure Map")
    begin
        if JsonStructureMap."Value" <> '' then
            JsonStructureMap.TestField("Has Children", false);
        JsonStructureMap."Value" := sJsonStructure.GetConvertStructureMapValueByDataType(JsonStructureMap."Value", JsonStructureMap."Data Type");
    end;

    /// <summary>
    /// ValidateFldJsonStructureMapOnDataType.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    procedure ValidateFldJsonStructureMapOnDataType(var JsonStructureMap: Record "GLA JB Json Structure Map")
    begin
        if JsonStructureMap."Value" <> '' then
            JsonStructureMap.TestField("Has Children", false);
        JsonStructureMap."Value" := sJsonStructure.GetConvertStructureMapValueByDataType(JsonStructureMap."Value", JsonStructureMap."Data Type");
    end;
}
