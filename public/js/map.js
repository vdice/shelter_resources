var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var labelIndex = 0;

function initMap() {

  var portlandCenter = { lat: 45.52, lng: -122.68 };
  var epicodus = {lat: 45.521838, lng: -122.675646};
  var providencePark = {lat: 45.521674, lng: -122.690829}
  var pittockMansion = {lat: 45.525219, lng: -122.716309}

  var resourceMap = new google.maps.Map(document.getElementById('map'), {
    zoom: 12,
    center: portlandCenter
  });


  var latitudeArr = document.getElementsByClassName('lat')
  var longitudeArr = document.getElementsByClassName('lng')

  for(var i = 0; i < latitudeArr.length; i++){
    addMarker({lat: parseFloat(latitudeArr[i].innerHTML), lng: parseFloat(longitudeArr[i].innerHTML)}, resourceMap)
  };



  function addMarker(location, map) {
    var marker = new google.maps.Marker({
      position: location,
      label: labels[labelIndex++ % labels.length],
      map: map
    });
  }

}
