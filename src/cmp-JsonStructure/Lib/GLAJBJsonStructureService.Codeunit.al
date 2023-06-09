/// <summary>
/// Codeunit GLA JB Json Structure Service (ID 380001).
/// Component: Json Structure
/// </summary>
codeunit 380001 "GLA JB Json Structure Service"
{
    var
        GlobalJsonStructureMap: Record "GLA JB Json Structure Map";

        HasJsonStructureMap: Boolean;
        ErrorRecordMustBeTemporary: Label 'Record %1 must be temporary.';
        ErrorJsonStructureMapIsNotSetUp: Label 'Json Structure Map is not setup. Use SetSource function first.';

    /// <summary>
    /// SetStructureMap.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="LineNo">Integer.</param>
    procedure SetStructureMap(StructureCode: Code[30]; LineNo: Integer)
    begin
        GlobalJsonStructureMap.Get(StructureCode, LineNo);
        HasJsonStructureMap := true;
    end;

    procedure GetIndentLevel(): Integer
    begin
        if HasJsonStructureMap then
            exit(GlobalJsonStructureMap."Indent Level");
    end;

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
        JsonStructureMap.SetCurrentKey("Structure Code", "Line No.");
        JsonStructureMap.SetRange("Structure Code", StructureCode);
        exit(not JsonStructureMap.IsEmpty());
    end;
}
