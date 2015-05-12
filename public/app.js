/*
 * This file is generated and updated by Sencha Cmd. You can edit this file as
 * needed for your application, but these edits will have to be merged by
 * Sencha Cmd when upgrading.


 */

Ext.Loader.setConfig({enabled: true});

Ext.Loader.setPath('MyApp', '/js/app');

Ext.application({
    name: 'MyApp',

    appFolder: '/js/app',

    extend: 'MyApp.Application',
    
    autoCreateViewport: 'MyApp.view.main.Main',

    controllers: ['Main']
	
    //-------------------------------------------------------------------------
    // Most customizations should be made to MyApp.Application. If you need to
    // customize this file, doing so below this section reduces the likelihood
    // of merge conflicts when upgrading to new versions of Sencha Cmd.
    //-------------------------------------------------------------------------
});
