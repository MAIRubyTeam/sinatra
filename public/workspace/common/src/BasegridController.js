Ext.define('basegrid.BasegridController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.basegrid-view',
    
    onAddClick: function()
    {
        var view = this.getView();
        var store = view.getStore();
        store.add({});
    },
    onSaveClick: function()
    {
    	var store = this.getView().getStore();
    	store.sync({
            failure: function()
            {
                Ext.Msg.alert('Ошибка!', 'Не удалось синхронизировать данные, попробуйте позже.');
            }
        });
    },

    onUpdateClick: function()
    {
        var store = this.getView().getStore();
        store.load({
            callback: function(records, operation, success)
            {   
                if(!success)    
                    Ext.Msg.alert('Ошибка!', 'Не удалось загрузить данные, попробуйте позже.');
            }
        });
    },

    onDeleteClick: function()
    {
        var view = this.getView();
        var store = view.getStore();
        var selmodel = view.getSelectionModel();
        if(selmodel.getCount() != 0)
            store.remove(selmodel.getSelection());
    }
});
