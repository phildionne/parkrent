$(document).ready( function(){
  $('.js-mapbox').each( function(){
    var map = L.mapbox.map(this, 'examples.map-y7l23tes')
        .setView([$(this).data('lat'), $(this).data('lon')], $(this).data('zoom'));
  });
});
