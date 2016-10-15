function stat_ready() {
   $('#statistics').dataTable({
        bJQueryUI: true,
      bProcessing: true,
      bServerSide: true,
      sAjaxSource: $('#statistics').data('source'),
      paging: false
        });
}
// $(document).ready(stat_ready);

// $(document).on('page:load', stat_ready);

