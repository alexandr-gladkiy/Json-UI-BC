/// <summary>
/// Enum GLA JB Status (ID 380000).
/// Components: Common
/// </summary>
enum 380000 "GLA JB Status"
{
    Extensible = true;

    value(0; Draft)
    {
        Caption = 'Draft';
    }
    value(1; Active)
    {
        Caption = 'Active';
    }
    value(2; Inactive)
    {
        Caption = 'Inactive';
    }
}
