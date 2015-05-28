
Ext.define("Hospital.view.doctor.View",{
    extend: "Ext.panel.Panel",
    alias: 'widget.doctorPanel',

    requires:[
    'Hospital.view.doctor.ViewModel',
    'Hospital.view.doctor.ViewController',
    'Hospital.view.basegrid.View'],

    controller: "doctor-view",
    viewModel: {
        type: "doctor-view"
    },

    layout: { type: 'border'},

    items:[
    {
    	xtype: 'basegrid',
        columns: [
            { text: 'Полис', dataIndex: 'pacient_policy', editor: {xtype: 'textfield'}},
            { text: 'ФИО', dataIndex: 'pacient_name', flex: 1, editor: {xtype: 'textfield'}}
        ],
        bind: {store: '{doctorStore}'}
    }]
});
