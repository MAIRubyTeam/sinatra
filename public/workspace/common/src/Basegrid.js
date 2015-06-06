
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
            handler: 'onAddClick',
            iconCls: 'icon-add'
        },
        {
            xtype: 'button',
            text: 'Удалить',
            handler: 'onDeleteClick',
            iconCls: 'icon-delete'
        },
        {
            xtype: 'button',
            text: 'Сохранить',
            handler: 'onSaveClick',
            iconCls: 'icon-save'
        },
        {
            xtype: 'button',
            text: 'Обновить',
            handler: 'onUpdateClick',
            iconCls: 'icon-load'
        }]
});
