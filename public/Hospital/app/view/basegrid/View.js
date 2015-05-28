
Ext.define("Hospital.view.basegrid.View",{
    extend: "Ext.grid.Panel",
    alias: 'widget.basegrid',

    requires:[
    'Hospital.view.basegrid.ViewController',
    'Hospital.view.basegrid.ViewModel'],

    controller: "basegrid-view",
    viewModel: {
        type: "basegrid-view"
    },

    region: 'center',
    selModel: 'rowmodel',
    plugins: {
        ptype: 'rowediting'
    },
    tbar: [
    {
        xtype: 'button',
        text: 'Добавить',
        handler: 'onAddClick'
    },
    {
        xtype: 'button',
        text: 'Удалить',
        handler: 'onDeleteClick'
    },
    {
        xtype: 'textfield',
        emptyText: 'Найти...'
    }]
});
