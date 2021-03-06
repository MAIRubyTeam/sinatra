Ext.define('Hospital.view.doctor.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.doctor-view',
    data: {
        name: 'Hospital',
    },

    stores: {
        doctorStore: 
        {
            type: 'store',
            model: 'Hospital.model.Doctor',  
            proxy: {
                type: 'rest',
                url : '/doctors',
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
