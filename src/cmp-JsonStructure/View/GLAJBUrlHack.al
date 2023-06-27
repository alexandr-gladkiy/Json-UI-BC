/// <summary>
/// ControlAddIn UrlHack.
/// </summary>
controladdin UrlHack
{
    MinimumHeight = 1;
    MaximumHeight = 1;
    MinimumWidth = 1;
    MaximumWidth = 1;
    StartupScript = '.\src\cmp-JsonStructure\View\urlScripts.js';
    Scripts = '.\src\cmp-JsonStructure\View\urlScripts.js';

    /// <summary>
    /// GetApiKey.
    /// </summary>
    /// <param name="ApiKey">Text.</param>
    event GetApiKey(ApiKey: Text);
}