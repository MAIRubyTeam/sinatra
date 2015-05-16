
Ext.define("Hospital.view.doctor.Doctor",{
    extend: "Ext.panel.Panel",

    requires: [
        'Hospital.view.doctor.DoctorController',
        'Hospital.view.doctor.DoctorModel'
    ],

    controller: "doctor-doctor",
    viewModel: {
        type: "doctor-doctor"
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
        items: [{ xtype: 'label', region: 'center', text: 'Информация о враче'}]
    },
    {
        xtype: 'panel',
        region: 'center',
        layout: { type: 'border' },
        items: [
        {
            xtype: 'textfield',
            region: 'north',
            fieldLabel: 'Найти пациента'
        },
        {
            xtype: 'panel',
            region: 'north',
            layout: { type: 'border' },
            height: 30,
            items: [
            {
                xtype: 'button',
                region: 'west',
                text: 'Добавить'
            },
            {
                xtype: 'button',
                region: 'west',
                text: 'Удалить'
            }]
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
                { text: 'Номер полиса', dataIndex: 'number_of_policy'},
                { text: 'ФИО', dataIndex: 'name', flex: 1}
            ]
        }]
    }
    ]
});
