
Ext.define("Hospital.view.basegrid.View",{
    extend: "Ext.panel.Panel",
    alias: 'widget.basegrid',

    requires:[
    'Hospital.view.basegrid.ViewController',
    'Hospital.view.basegrid.ViewModel'],

    controller: "basegrid-view",
    viewModel: {
        type: "basegrid-view"
    },

    layout:{
    	type: 'border'
    },

    items:[
    {
    	xtype: 'panel',
    	region: 'north',
    	height: 200,
    	bind:
    	{
    		html: '{infoHtml}'
    	}
    },
    {
    	xtype: 'panel',
    	region: 'center',
    	layout: {type: 'border'},
    	items:[
    	{
    		xtype: 'textfield',
    		region: 'north',
    		bind:
    		{
    			fieldLabel: '{searchLabel}'
    		},
    		height: 25	
    	},
        {
            xtype: 'panel',
            region: 'north',
            height: 25,
            layout: { type: 'hbox'},
            items: [
            {
                xtype: 'button',
                text: 'Добавить',
                flex:1
            },
            {
                xtype: 'button',
                text: 'Удалить',
                flex:1
            },
            {
                flex: 4
            }]
        },
    	{
    		xtype: 'grid',
    		region: 'center',
    		bind:
    		{
                store: '{storeType}',
    			columns: '{columnsArray}'
    		},
            selModel: 'rowmodel',
            plugins: {
                ptype: 'rowediting'
            }
    	}]
    }]
});
