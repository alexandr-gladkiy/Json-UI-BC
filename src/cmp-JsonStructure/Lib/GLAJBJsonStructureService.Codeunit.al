/// <summary>
/// Codeunit GLA JB Json Structure Service (ID 380001).
/// Component: Json Structure
/// </summary>
codeunit 380001 "GLA JB Json Structure Service"
{
    var
        GlobalJsonStructureMap: Record "GLA JB Json Structure Map";

    /// <summary>
    /// GetJsonStructureMapLastLineNo.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <returns>Return value of type Integer.</returns>
    procedure GetJsonStructureMapLastLineNo(StructureCode: Code[30]): Integer
    begin
        GetSetOfJsonStructureMapByStructureCode(StructureCode, GlobalJsonStructureMap);
        exit(GlobalJsonStructureMap.Count);
    end;

    /// <summary>
    /// GetSetOfJsonStructureMapByStructureCode.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetSetOfJsonStructureMapByStructureCode(StructureCode: Code[30]; var JsonStructureMap: Record "GLA JB Json Structure Map"): Boolean
    begin
        JsonStructureMap.Reset();
        JsonStructureMap.SetCurrentKey("Structure Code", "Line No");
        JsonStructureMap.SetRange("Structure Code", StructureCode);
        exit(not JsonStructureMap.IsEmpty());
    end;
}
