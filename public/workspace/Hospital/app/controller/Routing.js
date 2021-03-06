Ext.define('Hospital.controller.Routing',{
	extend: 'Ext.app.Controller',


	routes : {
		':id' : {
			before : 'beforeNavigate',
			action : 'onNavigate'
		}
	},

	listen : {
		controller : {
			'#' : {
				unmatchedroute : 'onUnmatchedRoute'
			}
		}
	},
	
	onUnmatchedRoute : function(hash) {
		this.redirectTo("/app");
	},

	beforeNavigate : function(id, action) {
		var me = this,
			item = me.cards.items.get(id);
		
		if (item) {
			action.resume();
		} else {
			me.onUnmatchedRoute();
		}
	},

	onNavigate : function(id) {
		var me = this;

		newCard = me.cards.setActiveItem(id);
	},


	onLaunch: function()
	{
		mainView = this.application.getMainView();
		this.cards = mainView.lookupReference('mainPanel');
	}
})