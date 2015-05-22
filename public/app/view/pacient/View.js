
Ext.define("Hospital.view.pacient.View",{
    extend: "Hospital.view.basegrid.View",
    alias: 'widget.pacientPanel',

    requires: [
    'Hospital.view.pacient.ViewModel',
    'Hospital.view.pacient.ViewController'],	

    controller: "pacient-view",
    viewModel: {
        type: "pacient-view"
    },
});
