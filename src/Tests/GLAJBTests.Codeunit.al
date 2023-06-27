codeunit 380002 "GLA JB Tests"
{
    Subtype = Test;

    var
        JsonStructureService: Codeunit "GLA JB Json Structure Service";

    [Test]
    procedure Test1()
    var
        JsonStructureMap: Record "GLA JB Json Structure Map";
    begin
        // [GIVEN] Given
        // [WHEN] When
        // [THEN] Then

        if JsonStructureService.GetSetOfJsonStructureMapByStructureCode('TEST', JsonStructureMap) then
            exit;
        //    Error('dfdf');
    end;

}