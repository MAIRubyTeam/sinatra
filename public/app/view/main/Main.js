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
        'Hospital.view.main.MainModel',
        'Hospital.view.basegrid.View',
        'Hospital.controller.Routing',
        'Hospital.view.pacient.View',
        'Hospital.view.doctor.View',
        'Hospital.view.admin.Admin',
    ],

    xtype: 'app-main',
    
    controller: 'main',
    viewModel: {
        type: 'main'
    },

    layout: {
        type: 'border'
    },

    items: [
    {
        xtype: 'panel',
        region: 'north',
        height: 20,
        layout: {
            type: 'border'
        },
        items: [
        {
            xtype: 'button',
            text: 'Редактировать личные данные',
            region: 'east' 
        },
        {
            xtype: 'button',
            text: 'Выйти',
            region: 'east'
        },
        {   
            xtype: 'segmentedbutton',         
            region: 'west',
            items: [{
                text: 'Администраторы',
                href: '/index.html#admin',
                hrefTarget: '_self'
            },{
                text: 'Врачи',
                href: '/index.html#doctor',
                hrefTarget: '_self'
            },{
                text: 'Пациенты',
                href: '/index.html#pacient',
                hrefTarget: '_self'
            }],
        }
        ]
    },
    {
        xtype: 'panel',
        reference: 'mainPanel',
        region: 'center',
        layout: { type: 'card'},
        activeItem: 0,
        items: [
        {
            xtype: 'adminPanel',
            itemId: 'admin'
        },
        {
            xtype: 'doctorPanel',
            itemId: 'doctor'
        },
        {
            xtype: 'pacientPanel',
            itemId: 'pacient'
        }
        ]
    }
    ]
});
