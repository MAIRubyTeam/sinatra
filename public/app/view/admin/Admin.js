
Ext.define("Hospital.view.admin.Admin",{
    extend: "Ext.panel.Panel",

    requires: [
        'Hospital.view.admin.AdminController',
        'Hospital.view.admin.AdminModel'
    ],

    controller: "admin-admin",
    viewModel: {
        type: "admin-admin"
    },

    layout: {
    	type: 'border'
    },

    items: [
    {
        xtype: 'panel',
        region: 'north',
        height: 20,
        layout: {type: 'border'},
        items: [
        {
            xtype: 'button',
            text: 'Редактировать личные данные',
            region: 'east' 
        },
        {
            xtype: 'button',
            text: 'Выйти',
            region: 'east'
        }]
    },
    {
        xtype: 'panel',
        region: 'center',
        layout: { type: 'border' },
        items: [
        {
            xtype: 'textfield',
            region: 'north',
            fieldLabel: 'Найти'
        },
        {
            xtype: 'panel',
            region: 'north',
            layout: { type: 'border' },
            height: 30,
        },
        {
        xtype: 'tabpanel',
        region: 'center',
        layout: { type: 'border' },
        items: [{
            title: 'Управление сайтом',
            bodyPadding: 70,  
        },{
            title: 'Управление пользователями',
            items: [{
                xtype: 'grid',
                region: 'center',
                store: {
                    fields: ['id', 'login', 'password'],
                    data: [
                        { id: '1', login: 'Яр', password: 'qwerty1'},
                        { id: '2', login: 'Костя', password: 'qwerty2'},
                        { id: '3', login: 'Вова', password: 'qwerty3'},
                        { id: '4', login: 'Игорь', password: 'qwerty4'},
                        { id: '5', login: 'Антон', password: 'qwerty5'},
                    ],
                    proxy: { type: 'memory' }
                },
                columns: [
                    { text: 'Id', dataIndex: 'id'},
                    { text: 'Логин', dataIndex: 'login', flex: 1},
                    { text: 'Пароль', dataIndex: 'password', flex: 1}
                ]  
                }]
            }]
        }]
    },
    {
        xtype: 'panel',
        region: 'south',
        layout: { type: 'hbox', align: 'stretch'},
        items: [{
	        flex: 2,
	        items:[{
	            xtype: 'checkboxgroup',
	            columns: 4,
	            vertical: true,
	            items: [
	                { boxLabel: 'Администраторы', name: 'rb', inputValue: '1', checked: true  },
	                { boxLabel: 'Врачи', name: 'rb', inputValue: '2'},
	                { boxLabel: 'Пациенты', name: 'rb', inputValue: '3' },
	                { boxLabel: 'Онлайн', name: 'rb', inputValue: '4' }
	            ]
	        }]
        },
        {   
	        xtype: 'segmentedbutton',         
	        flex: 3,
	        items: [{
	            text: 'Добавить',
	        },{
	            text: 'Удалить',
	        },{
	              text: 'Изменить'
	        }],
        }]
    }]  
});
