
Ext.define("Hospital.view.doctor.View",{
    extend: "Hospital.view.basegrid.View",
    alias: 'widget.doctorPanel',

    requires:[
    'Hospital.view.doctor.ViewModel',
    'Hospital.view.doctor.ViewController'],

    controller: "doctor-view",
    viewModel: {
        type: "doctor-view"
    },
});
