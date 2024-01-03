import { Controller } from "@hotwired/stimulus"
import DataTable from "datatables.net-bs5"

// import DataTable from "datatables.net-bs5"
// window.DataTable = DataTable();

export default class extends Controller {
    static targets = ["reloadTable", "reloadRow"]

    connect()
    {
        alert("Hello! I am an alert box!!");
        var searchText = this.element.getAttribute('data-search')
        this.oTable =  new DataTable($(this.element).find('table'), {
            "destroy": true,
            bProcessing: true,
            "dom": 'lrtip',
            bServerSide: true,
            bLengthChange: false,
            bInfo: true,
            "bDestroy": true,
            language: {search: "Search : ", searchPlaceholder: searchText, zeroRecords: "No Data &nbsp;Available", infoFiltered: ''},
            "ordering": true,
            "order": [],
            "aoColumnDefs": [
                {'bSortable': false, 'aTargets': [-1, "no-sort"]}
            ],
            "fnCreatedRow": function( nRow, aData, iDataIndex ) {
                $(nRow).attr('id', aData['DT_RowId']);
            },
            sAjaxSource: this.element.getAttribute('data-source')
        });
    }

    destroyBeforeRender(){
        new DataTable($(this.element).find('table')).destroy()
    }

    reloadTableTargetConnected(){
        if(this.oTable != undefined)
            this.oTable.ajax.reload( null, false )
    }

    reloadRowTargetConnected(){
        var data = JSON.parse($(this.reloadRowTarget).attr('data-json'))
        this.oTable.row("#"+data['DT_RowId']).data(data).draw();
    }

    customSearch(e) {
        var $input = $(e.target)
        this.oTable.search($input.val()).draw();
    }

    radioChange(e){
        this.oTable.column(1).search(e.target.value).draw();
    }
}
