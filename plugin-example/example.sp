// Includes
#include <your_include>

// You should always define the plugin-meta-data as constants so you can use them at any other point later
// So if you have enambed the AUTO_VERSION_REPLACE in your .gitlab-ci.yml it searches for the place-holder
// below and replaces it while building the the current version.
#define EXAMPLE_PLUGIN_VERSION "${-version-}" // Version is replaced by the GitLab-Runner compile script
#define EXAMPLE_PLUGIN_NAME "Example" // The fancy name of your plugin
#define EXAMPLE_PLUGIN_AUTHOR "Your nickname / full name"
#define EXAMPLE_PLUGIN_DESCRIPTION "A meaningfull description shown in-game when you write sm plugins"
#define EXAMPLE_PLUGIN_WEBSITE "https://gitlab.com/PathToYourRepository"


public Plugin myinfo =
{
	name = EXAMPLE_PLUGIN_NAME,
	author = EXAMPLE_PLUGIN_AUTHOR,
	description = EXAMPLE_PLUGIN_DESCRIPTION,
	version = EXAMPLE_PLUGIN_VERSION,
	url = EXAMPLE_PLUGIN_WEBSITE
};

public void OnPluginStart()
{
	PrintToServer("Value of the constat from the include: %s", FANCY_INCLUDE_VALUE);
}