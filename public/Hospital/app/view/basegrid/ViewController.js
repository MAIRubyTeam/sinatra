Ext.define('Hospital.view.basegrid.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.basegrid-view',

    onAddClick: function()
    {
    	var view = this.getView();
    	view.store.add({});
    },

    onDeleteClick: function()
    {
    	var view = this.getView();
    	view.store.remove(view.getSelection());
    }
    
});
