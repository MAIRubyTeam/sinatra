Ext.define('Hospital.view.doctor.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.doctor-view',
    data: {
        name: 'Hospital',
        infoHtml: '<h2>Информация о враче</h2>',
        searchLabel: 'Найти:',
        columnsArray: [
                { text: 'ID', dataIndex: 'id'},
                { text: 'ФИО', dataIndex: 'name', flex: 1}
            ],
        storeType: {
            fields: ['id', 'name'],
            data: [{id: '1111', name: 'TestGuy'}],
            proxy: {type: 'memory'}
        }
    }

});
