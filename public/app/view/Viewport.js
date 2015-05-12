Ext.define('Hospital.view.Viewport', {
    extend: 'Ext.container.Viewport',
    requires:[
        'Ext.layout.container.Fit',
        'Hospital.view.Pacient'
    ],

    layout: {
        type: 'fit'
    },

    items: [{
        xtype: 'app-pacient'
    }]
});