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
    /// <returns>Return value of type Boolean.</returns>
    procedure SetStructureMap(StructureCode: Code[30]; LineNo: Integer): Boolean
    begin
        HasJsonStructureMap := GlobalJsonStructureMap.Get(StructureCode, LineNo);
        exit(HasJsonStructureMap);
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
    /// GetKey.
    /// </summary>
    /// <returns>Return value of type Text[50].</returns>
    procedure GetKey(): Text[50]
    begin
        if not HasJsonStructureMap then
            Error(ErrorJsonStructureMapIsNotSetUp);
        exit(GlobalJsonStructureMap."Key");
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
    /// IsStructureMapHasChildren.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsStructureMapHasChildren(): Boolean
    var
        JsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        if not HasJsonStructureMap then
            Error(ErrorJsonStructureMapIsNotSetUp);

        exit(GetSetOfJsonStructureMapByParentKey(GlobalJsonStructureMap."Structure Code", GlobalJsonStructureMap."Key", JsonStructureMap));
    end;

    /// <summary>
    /// GetCountChildren.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetCountChildren(): Integer
    var
        JsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        if not HasJsonStructureMap then
            Error(ErrorJsonStructureMapIsNotSetUp);

        GetSetOfJsonStructureMapByParentKey(GlobalJsonStructureMap."Structure Code", GlobalJsonStructureMap."Key", JsonStructureMap);
        exit(JsonStructureMap.Count);
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
        FileName: Text;
    begin
        if JsonStructureCode = '' then
            exit;

        Json := CreateJson(JsonStructureCode);
        TempBlob.CreateOutStream(oStream);
        Json.WriteTo(oStream);
        TempBlob.CreateInStream(iStream);

        FileName := StrSubstNo('JsonStructure_%1.txt', JsonStructureCode);
        DownloadFromStream(iStream, '', '', '', FileName);
    end;

    /// <summary>
    /// CreateJsonAsText.
    /// </summary>
    /// <param name="JsonStructureCode">Code[30].</param>
    /// <returns>Return variable JsonTxt of type Text.</returns>
    procedure CreateJsonAsText(JsonStructureCode: Code[30]) JsonTxt: Text
    var
        Json: JsonObject;
    begin
        if JsonStructureCode = '' then
            exit;

        Json := CreateJson(JsonStructureCode);
        Json.WriteTo(JsonTxt);
    end;

    local procedure CreateJson(JsonStructureCode: Code[30]) MainJsonObj: JsonObject
    begin
        if not GetSetOfJsonStructureMapByParentKey(JsonStructureCode, '', GlobalJsonStructureMap) then
            exit; // TODO: Except Error Invalid Settings Structure

        MainJsonObj := GetJObject(GlobalJsonStructureMap);
    end;

    /// <summary>
    /// GetJObject.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    /// <returns>Return variable RetvalJObject of type JsonObject.</returns>
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
                    AddValueToJObjectByDataType(JsonStructureMap, RetvalJObject);
            until JsonStructureMap.Next() = 0;
    end;

    local procedure AddValueToJObjectByDataType(JsonStructureMap: Record "GLA JB Json Structure Map"; var JObject: JsonObject)
    var
        DataType: Enum "GLA JB Data Type";
        JValue: JsonValue;
        ValueBool: Boolean;
        ValueInt: Integer;
        ValueBigInt: BigInteger;
    begin
        JValue.SetValue(JsonStructureMap."Value");
        case JsonStructureMap."Data Type" of
            DataType::Code:
                JObject.Add(JsonStructureMap."Key", JValue.AsCode());
            DataType::Biginteger:
                JObject.Add(JsonStructureMap."Key", JValue.AsBigInteger());
            DataType::Integer:
                JObject.Add(JsonStructureMap."Key", JValue.AsInteger());
            DataType::Decimal:
                JObject.Add(JsonStructureMap."Key", JValue.AsDecimal());
            DataType::Boolean:
                JObject.Add(JsonStructureMap."Key", JValue.AsBoolean());
            else
                JObject.Add(JsonStructureMap."Key", JValue.AsText());
        end;
    end;

    /// <summary>
    /// GetConvertStructureMapValueByDataType.
    /// </summary>
    /// <param name="InputValue">Text.</param>
    /// <param name="DataType">Enum "GLA JB Data Type".</param>
    /// <returns>Return variable ConvertValue of type Text.</returns>
    procedure GetConvertStructureMapValueByDataType(InputValue: Text; DataType: Enum "GLA JB Data Type") ConvertValue: Text
    var
        ValuePattern: Text;
        Regex: Codeunit Regex;
        Matches: Record Matches temporary;
    begin
        InputValue := InputValue.Trim();
        case DataType of
            DataType::Integer, DataType::Biginteger, DataType::Option, DataType::Enum:
                begin
                    ValuePattern := '[0-9]+';
                    if not Regex.IsMatch(InputValue, ValuePattern) then
                        ConvertValue := '0';
                    exit;

                end;

            DataType::Decimal:
                begin
                    ValuePattern := '[0-9]+,[0-9]+';
                    if not Regex.IsMatch(InputValue, ValuePattern) then
                        ConvertValue := '0,00';
                    exit;
                end;

            DataType::Boolean:
                begin
                    ValuePattern := '[true,false,0,1]';
                    if not Regex.IsMatch(InputValue, ValuePattern) then
                        ConvertValue := 'false';
                    exit;
                end;
            DataType::Code:
                ConvertValue := InputValue.ToUpper();
        end;
    end;

    /// <summary>
    /// UpdateIndentStructureMapByStructureCode.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    procedure UpdateIndentAndSortingStructureMapByStructureCode(StructureCode: Code[30])
    var
        SortingOrder: Integer;
    begin
        if StructureCode = '' then
            exit;
        SortingOrder := 1;
        SetIndentAndSortingStructureMapByParentKey(StructureCode, '', 0, SortingOrder);
    end;

    local procedure SetIndentAndSortingStructureMapByParentKey(StructureNo: Code[30]; ParentKey: Text[50]; IndentLevel: Integer; var SortingOrder: Integer)
    var
        JsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        if not GetSetOfJsonStructureMapByParentKey(StructureNo, ParentKey, JsonStructureMap) then
            exit;

        JsonStructureMap.FindSet(true);
        repeat
            JsonStructureMap."Indent Level" := IndentLevel;
            JsonStructureMap."Sorting Order" := SortingOrder;
            JsonStructureMap.Modify(true);
            SortingOrder += 1;
            SetIndentAndSortingStructureMapByParentKey(StructureNo, JsonStructureMap."Key", IndentLevel + 1, SortingOrder);
        until JsonStructureMap.Next() = 0;
    end;

    /// <summary>
    /// UpdateStructureMapSortingOrderByStructureCode.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    procedure UpdateStructureMapSortingOrderByStructureCode(StructureCode: Code[30])
    begin
        // TODO: Create function
    end;
}
