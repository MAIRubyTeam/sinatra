Ext.define('Hospital.view.pacient.ViewModel', {
    extend: 'Ext.app.ViewModel',
    require: ['Hospital.model.Pacient'],
    alias: 'viewmodel.pacient-view',
    data: {
        name: 'Hospital',
    },

    stores: {
        pacientStore:
        {
            type: 'store',
            model: 'Hospital.model.Pacient',
            proxy: {
                type: 'rest',
                url : '/pacients',
                reader: {
                    type: 'json'
                },
                writer: {
                    type: 'json'
                }
            }
        }
    }
});
