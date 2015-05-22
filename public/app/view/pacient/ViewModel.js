Ext.define('Hospital.view.pacient.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.pacient-view',
    data: {
        name: 'Hospital',
        infoHtml: '<h2>Информация о пациенте</h2>',
        searchLabel: 'Найти:',
        columnsArray: [
                { text: 'Дата анализа', dataIndex: 'analysisDate',
                editor: {xtype: 'textfield'}},
                { text: 'Название анализа', dataIndex: 'analysisName', flex: 1,
                editor: {xtype: 'textfield'}}
            ],
        storeType: {
            fields: ['analysisDate', 'analysisName'],
            data: [{analysisDate: '11.11.1111', analysisName: 'TestAnalysis'}],
            proxy: {type: 'memory'}
        }
    }

});
