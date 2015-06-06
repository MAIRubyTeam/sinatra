
Ext.define("basegrid.Basegrid",{
    extend: "Ext.grid.Panel",
    alias: 'widget.basegrid',

    controller: "basegrid-view",
    viewModel: {
        type: "basegrid-view"
    },

    region: 'center',
    selModel: 'rowmodel',
    plugins: {
        ptype: 'rowediting'
    },

    selModel:{
        mode: 'SIMPLE'
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
            xtype: 'button',
            text: 'Сохранить',
            handler: 'onSaveClick'
        },
        {
            xtype: 'button',
            text: 'Обновить',
            handler: 'onUpdateClick'
        }]
});
