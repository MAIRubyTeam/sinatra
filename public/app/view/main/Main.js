/**
 * This class is the main view for the application. It is specified in app.js as the
 * "autoCreateViewport" property. That setting automatically applies the "viewport"
 * plugin to promote that instance of this class to the body element.
 *
 * TODO - Replace this content of this view to suite the needs of your application.
 */
Ext.define('Hospital.view.main.Main', {
    extend: 'Ext.container.Container',
    requires: [
        'Hospital.view.main.MainController',
        'Hospital.view.main.MainModel'
    ],

    xtype: 'app-main',
    
    controller: 'main',
    viewModel: {
        type: 'main'
    },

    layout: {
        type: 'card'
    },

    activeItem: 2,

    items: [
        Ext.create("Hospital.view.doctor.Doctor"),
        Ext.create("Hospital.view.pacient.Pacient"),
        Ext.create("Hospital.view.admin.Admin")
    ]
});
