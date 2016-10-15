// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$( 'body' ).on( 'click', '.jinn_popup-blur,.jinn_popup-escape', function(){
      $(this).parents('.jinn_popup').remove()
      $('.jinn_page').toggleClass('jinn_page-blured', !!$( '.jinn_popup' ).size() )
} )

$( window ).on( 'resize', function(){
      $( '.jinn_popup' ).each( function( i, popup ){
                popup= $( popup )
                var head= popup.find( '.jinn_popup-head' )
                var body= popup.find( '.jinn_popup-body' )
                var foot= popup.find( '.jinn_popup-foot' )
                
                var maxHeight= popup.height()
                
                head.css({ maxHeight: maxHeight / 2 + 'px' })
                foot.css({ maxHeight: maxHeight / 2 + 'px' })
                
                var maxBodyHeight= maxHeight - head.height() - foot.height()
                maxBodyHeight= Math.max( 64, maxBodyHeight )
                body.css({ maxHeight: maxBodyHeight })
            } )
} )
        
$( window ).trigger( 'resize' )
