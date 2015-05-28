
Ext.define("Hospital.view.pacient.View",{
    extend: "Ext.panel.Panel",
    alias: 'widget.pacientPanel',

    requires: [
    'Hospital.view.pacient.ViewModel',
    'Hospital.view.pacient.ViewController',
    'Hospital.view.basegrid.View'],	

    controller: "pacient-view",
    viewModel: {
        type: "pacient-view"
    },

    layout: { type: 'border'},

    items:[
    {
    	xtype: 'basegrid',
        columns: [
            { text: 'Дата анализа', dataIndex: 'analysis_date',
            editor: {xtype: 'textfield'}},
            { text: 'Название анализа', dataIndex: 'analysis_name', flex: 1,
            editor: {xtype: 'textfield'}}
        ],
        bind: {store: '{pacientStore}'}
    }]
});
