
Ext.define("Hospital.view.pacient.Pacient",{
    extend: "Ext.panel.Panel",

    controller: "pacient-pacient",
    viewModel: {
        type: "pacient-pacient"
    },

    layout: {
        type: 'border'
    },

    items: [
    {
        xtype: 'panel',
        region: 'north',
        height: 20,
        layout: {
            type: 'border'
        },
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
        }
        ]
    },
    {
        xtype: 'panel',
        region: 'north',
        height: 200,
        layout: { type: 'border' },
        bodyStyle: { 'background-color': 'white'},
        items: [{ xtype: 'label', region: 'center', text: 'Информация о пациенте'}]
    },
    {
        xtype: 'panel',
        region: 'center',
        layout: { type: 'border' },
        items: [
        {
            xtype: 'textfield',
            region: 'north',
            fieldLabel: 'Найти анализ'
        },
        {
            xtype: 'panel',
            region: 'north',
            layout: { type: 'border' },
            height: 30,
        },
        {
            xtype: 'grid',
            region: 'center',
            store: {
                fields: ['number_of_policy', 'name'],
                data: [
                    { number_of_policy: '111', name: 'Яр'},
                    { number_of_policy: '121', name: 'Костя'},
                    { number_of_policy: '337', name: 'Вова'},
                    { number_of_policy: '445', name: 'Игорь'},
                    { number_of_policy: '00000', name: 'Антон'},
                ],
                proxy: { type: 'memory' }
            },
            columns: [
                { text: 'Дата анализа', dataIndex: 'number_of_policy'},
                { text: 'Название анализа', dataIndex: 'name', flex: 1}
            ]
        }]
    }
    ]
});
