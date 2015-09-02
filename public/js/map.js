var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var labelIndex = 0;

function initialize() {

  // Marker Locations (Placeholders)
  var portlandCenter = { lat: 45.52, lng: -122.68 };
  var epicodus = {lat: 45.521838, lng: -122.675646};
  var providencePark = {lat: 45.521674, lng: -122.690829}
  var pittockMansion = {lat: 45.525219, lng: -122.716309}

  /* Pull the lat/lng from the DOM using something like this:

      for(var i = 0; i < document.getElementsByClassName('lat').length; i++){
        var lat = Number(document.getElementsByClassName('lat')[i].innerHTML)
        var lng = Number(document.getElementsByClassName('lng')[i].innerHTML)
        addMarker({lat: lat, lng: lng}, resourceMap)
      }

  */


  var resourceMap = new google.maps.Map(document.getElementById('map'), {
    zoom: 12,
    center: portlandCenter
  });


  // Marker Pins
  addMarker(epicodus, resourceMap)
  addMarker(providencePark, resourceMap)
  addMarker(pittockMansion, resourceMap)

}

// Adds a marker to the map.
function addMarker(location, map) {
  // Add the marker at the clicked location, and add the next-available label
  // from the array of alphabetical characters.
  var marker = new google.maps.Marker({
    position: location,
    label: labels[labelIndex++ % labels.length],
    map: map
  });
}

google.maps.event.addDomListener(window, 'load', initialize);
