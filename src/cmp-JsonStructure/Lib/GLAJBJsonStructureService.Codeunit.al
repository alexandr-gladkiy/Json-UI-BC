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

    /// <summary>
    /// GetIndentLevel.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
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
        GetSetOfJsonStructureMap(StructureCode, GlobalJsonStructureMap);
        exit(GlobalJsonStructureMap.Count);
    end;

    /// <summary>
    /// GetSetOfJsonStructureMapByStructureCode.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetSetOfJsonStructureMap(StructureCode: Code[30]; var JsonStructureMap: Record "GLA JB Json Structure Map"): Boolean
    begin
        JsonStructureMap.Reset();
        JsonStructureMap.SetCurrentKey("Structure Code", "Line No.");
        JsonStructureMap.SetRange("Structure Code", StructureCode);
        exit(not JsonStructureMap.IsEmpty());
    end;

    /// <summary>
    /// GetSetOfJsonStructureMapByParentKey.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="ParentKey">Text[50].</param>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetSetOfJsonStructureMapByParentKey(StructureCode: Code[30]; ParentKey: Text[50]; var JsonStructureMap: Record "GLA JB Json Structure Map"): Boolean
    begin
        JsonStructureMap.Reset();
        JsonStructureMap.SetCurrentKey("Structure Code", "Key", "Parent Key");
        JsonStructureMap.SetRange("Structure Code", StructureCode);
        JsonStructureMap.SetRange("Parent Key", ParentKey);
        exit(not JsonStructureMap.IsEmpty());
    end;

    /// <summary>
    /// GetSetOfJsonStructureMapByKey.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="Key">Text[50].</param>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetSetOfJsonStructureMapByKey(StructureCode: Code[30]; "Key": Text[50]; var JsonStructureMap: Record "GLA JB Json Structure Map"): Boolean
    begin
        JsonStructureMap.Reset();
        JsonStructureMap.SetCurrentKey("Structure Code", "Parent Key", "Parent Key");
        JsonStructureMap.SetRange("Structure Code", StructureCode);
        JsonStructureMap.SetRange("Key", "Key");
        exit(not JsonStructureMap.IsEmpty());
    end;

    /// <summary>
    /// CreateJsonAsFile.
    /// </summary>
    /// <param name="JsonStructureCode">Code[30].</param>
    procedure CreateJsonAsFile(JsonStructureCode: Code[30])
    var
        Json: JsonObject;
        TempBlob: Codeunit "Temp Blob";
        oStream: OutStream;
        iStream: InStream;
        jsonTxt: Text;
    begin
        Json := CreateJson(JsonStructureCode);
        Json.WriteTo(jsonTxt);
        Message(jsonTxt);
    end;

    local procedure CreateJson(JsonStructureCode: Code[30]) MainJsonObj: JsonObject
    var
    begin

        if not GetSetOfJsonStructureMapByParentKey(JsonStructureCode, '', GlobalJsonStructureMap) then
            exit; // TODO: Except Error Invalid Settings Structure

        MainJsonObj := GetJObject(GlobalJsonStructureMap);
    end;

    procedure GetJObject(var JsonStructureMap: Record "GLA JB Json Structure Map") RetvalJObject: JsonObject
    var
        JObject: JsonObject;
        LocalJsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        if JsonStructureMap.FindSet(true) then
            repeat
                if GetSetOfJsonStructureMapByParentKey(JsonStructureMap."Structure Code", JsonStructureMap."Key", LocalJsonStructureMap) then begin
                    JObject := GetJObject(LocalJsonStructureMap);
                    RetvalJObject.Add(JsonStructureMap."Key", JObject);
                end else
                    RetvalJObject.Add(JsonStructureMap."Key", JsonStructureMap."Value")
            until JsonStructureMap.Next() = 0;
    end;
}
