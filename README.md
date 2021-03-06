# MediaWiki OAuth2 Client
MediaWiki implementation of the PHP League's [OAuth2 Client](https://github.com/thephpleague/oauth2-client) with the option to let a user replace the managed username with a new one at signup.

Requires MediaWiki 1.25+.

## Installation

Clone this repo into the extension directory.

Run [composer](https://getcomposer.org/) in /vendors/oauth2-client to install the library dependency.

```
composer install
```

## Usage

Add the following line to your LocalSettings.php file.

```
wfLoadExtension( 'MW-OAuth2Client' );
```

Required settings to be added to LocalSettings.php

```
$wgOAuth2Client['client']['id']     = ''; // The client ID assigned to you by the provider
$wgOAuth2Client['client']['secret'] = ''; // The client secret assigned to you by the provider

$wgOAuth2Client['configuration']['authorize_endpoint']     = ''; // Authorization URL
$wgOAuth2Client['configuration']['access_token_endpoint']  = ''; // Token URL
$wgOAuth2Client['configuration']['api_endpoint']           = ''; // URL to fetch user JSON
$wgOAuth2Client['configuration']['redirect_uri']           = ''; // URL for OAuth2 server to redirect to

$wgOAuth2Client['configuration']['username'] = 'username'; // JSON path to username
$wgOAuth2Client['configuration']['email'] = 'email'; // JSON path to email
```

The JSON path should be set to point to the appropriate attributes in the JSON.

If the properties you want from your JSON object are nested, you can use periods.

For example, if user JSON is

```
{
    "user": {
        "username": "my username",
        "email": "my email"
    }
}
```

Then your JSON path configuration should be these

```
$wgOAuth2Client['configuration']['username'] = 'user.username'; // JSON path to username
$wgOAuth2Client['configuration']['email'] = 'user.email'; // JSON path to email
```

You can see [Json Helper Test case](./tests/phpunit/JsonHelperTest.php) for more.

The **Redirect URI** for your wiki should be:

```
http://your.wiki.domain/path/to/wiki/Special:OAuth2Client/callback
```

### Creating new usernames

To bypass the username from your auth service and require the user to create their own username when they first login, pass a bool value of `false` to the username field, like:

```
$wgOAuth2Client['configuration']['username'] = false;
```

**Be aware that this means the user's email address will be the single identifying value of each user.** Because of this, it's recommended to prevent users from changing their email via their MediaWiki preferences, and instead delegate such updates to an administrator to perform manually, or to a script that will perform the update multilaterally.

To prevent users from changing their email via their MediaWiki preferences, you can disable the page Special:ChangeEmail by adding this hook to your LocalSettings.php:

```
$wgHooks['SpecialPage_initList'][] = function ( &$list ) {
	unset( $list['ChangeEmail'] );
	return true;
};
```

### Optional further configuration

```
$wgOAuth2Client['configuration']['http_bearer_token'] = 'Bearer'; // Token to use in HTTP Authentication
$wgOAuth2Client['configuration']['query_parameter_token'] = 'auth_token'; // query parameter to use
$wgOAuth2Client['configuration']['scopes'] = 'read_citizen_info'; //Permissions

$wgOAuth2Client['configuration']['service_name'] = 'Citizen Registry'; // the name of your service
$wgOAuth2Client['configuration']['service_login_link_text'] = 'Login with StarMade'; // the text of the login link

```

### Popup Window
To use a popup window to login to the external OAuth2 server, copy the JS from modal.js to the [MediaWiki:Common.js](https://www.mediawiki.org/wiki/Manual:Interface/JavaScript) page on your wiki.

### Extension page
https://www.mediawiki.org/wiki/Extension:OAuth2_Client

## License
LGPL (GNU Lesser General Public License) http://www.gnu.org/licenses/lgpl.html
