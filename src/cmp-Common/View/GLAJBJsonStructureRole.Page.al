/// <summary>
/// Component:      Common
/// </summary>
page 380002 "GLA JB Role Center"
{
    Caption = 'GLA Json Structure Role Center';
    PageType = RoleCenter;
    UsageCategory = None;

    layout
    {
        area(RoleCenter)
        {
            part(Control139; "Headline RC Business Manager")
            {
                //TODO: Headline RC Translation Manager - onboarding tour
                ApplicationArea = All;
            }
            // part("Requests"; "AJE MD Request Statistics")
            // {
            //     ApplicationArea = All;
            // }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = All;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = All;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = All;
            }
            /*
            part(Control46; "Team Member Activities No Msgs")
            {
                ApplicationArea = All;
            }
            */
        }
    }

    actions
    {
        area(Sections)
        {
            group("MainMenu")
            {
                Caption = 'Json Structure';
                action("SubscriberList")
                {
                    ApplicationArea = All;
                    Caption = 'Json Structure';
                    RunObject = Page "GLA JB Json Structure List";
                    RunPageMode = View;
                }
                // action("AttributesList")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Attributes';
                //     RunObject = Page "AJE MD Attribute List";
                //     RunPageMode = View;
                // }
                // action("DataProviderList")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Data Providers';
                //     RunObject = Page "AJE MD Data Provider List";
                //     RunPageMode = View;
                // }
                // action("SourcesList")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Sources';
                //     RunObject = Page "AJE MD Source List";
                //     RunPageMode = View;
                // }
                // action("RequestList")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Requests';
                //     RunObject = Page "AJE MD Request List";
                //     RunPageMode = Edit;
                // }
                // action("ProductList")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Products';
                //     RunObject = Page "AJE MD Product List";
                //     RunPageMode = View;
                // }
            }
            // group(ActionMenuSetup)
            // {
            //     Caption = 'Setup';
            //     ToolTip = 'Setup Master Data';
            //     action(SetupSection)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Setup';
            //         RunObject = Page "AJE MD Setup Card";
            //         RunPageMode = Edit;
            //     }
            //     action("AttributeGroups")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Attribute Groups';
            //         RunObject = Page "AJE MD Attribute Group List";
            //         RunPageMode = Edit;
            //     }
            // }
        }
    }
}
