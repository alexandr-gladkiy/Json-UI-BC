/// <summary>
/// Codeunit GLA JB Json Struct Event Subsc (ID 380003).
/// </summary>
codeunit 380003 "GLA JB Json Struct Event Subsc"
{
    var
        sJsonStructure: Codeunit "GLA JB Json Structure Service";

    /// <summary>
    /// JsonSructureMapOnAfterModifyEvent.
    /// </summary>
    /// <param name="JsonStructureMap">VAR Record "GLA JB Json Structure Map".</param>
    /// <param name="xJsonStructureMap">Record "GLA JB Json Structure Map".</param>
    [EventSubscriber(ObjectType::Table, DataBase::"GLA JB Json Structure Map", 'OnAfterOnModify', '', true, true)]
    local procedure JsonSructureMapOnAfterModifyEvent(var JsonStructureMap: Record "GLA JB Json Structure Map"; xJsonStructureMap: Record "GLA JB Json Structure Map")
    begin
        sJsonStructure.UpdateStructureMapSortingOrderByStructureCode(JsonStructureMap."Structure Code");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"GLA JB Json Structure Map", 'OnAfterOnInsert', '', true, true)]
    local procedure JsonSructureMapOnAfterInsertEvent(var JsonStructureMap: Record "GLA JB Json Structure Map"; xJsonStructureMap: Record "GLA JB Json Structure Map")
    begin
        sJsonStructure.UpdateStructureMapSortingOrderByStructureCode(JsonStructureMap."Structure Code");
    end;
}
