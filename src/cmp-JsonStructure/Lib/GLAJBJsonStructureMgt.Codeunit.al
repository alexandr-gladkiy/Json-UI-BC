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
    /// ValidateFldJsonStructureMapOnValue.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    procedure ValidateFldJsonStructureMapOnValue(var JsonStructureMap: Record "GLA JB Json Structure Map")
    begin
        if JsonStructureMap."Value" <> '' then
            JsonStructureMap.TestField("Has Children", false);

        ConvertValueByDataType(JsonStructureMap);
    end;

    /// <summary>
    /// ValidateFldJsonStructureMapOnDataType.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    procedure ValidateFldJsonStructureMapOnDataType(var JsonStructureMap: Record "GLA JB Json Structure Map")
    begin
        if not JsonStructureMap."Has Children" then
            ConvertValueByDataType(JsonStructureMap);
    end;

    local procedure ConvertValueByDataType(var JsonStructureMap: Record "GLA JB Json Structure Map")
    var
        DataType: Enum "GLA JB Data Type";
        ValuePattern: Text;
        Regex: Codeunit Regex;
        Matches: Record Matches temporary;
    begin
        case JsonStructureMap."Data Type" of
            DataType::Integer, DataType::Biginteger, DataType::Option, DataType::Enum:
                begin
                    ValuePattern := '[0-9]+';
                    if not Regex.IsMatch(JsonStructureMap.Value, ValuePattern) then
                        JsonStructureMap.Value := '0';
                    exit;

                end;

            DataType::Decimal:
                begin
                    ValuePattern := '[0-9]+,[0-9]+';
                    if not Regex.IsMatch(JsonStructureMap.Value, ValuePattern) then
                        JsonStructureMap.Value := '0,0';
                    exit;
                end;

            DataType::Boolean:
                begin
                    ValuePattern := '[true,false,0,1]';
                    if not Regex.IsMatch(JsonStructureMap.Value, ValuePattern) then
                        JsonStructureMap.Value := 'false';
                    exit;
                end;
            DataType::Code:
                JsonStructureMap.Value := JsonStructureMap.Value.ToUpper();
        end;
    end;
}
