function locateUser() {
  var pos;

  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      // populate DOM with hidden inputs for pos.lat and pos.lng
      document.getElementById('user_latitude').value = pos.lat;
      document.getElementById('user_longitude').value = pos.lng;

    }, function() {
      // handleLocationError(true, infoWindow, map.getCenter());
      handleLocationError(true);
    });
  } else {
    // Browser doesn't support Geolocation
    handleLocationError(false);
  }

  function handleLocationError(browserHasGeolocation, pos) {
    browserHasGeolocation ? console.log('Error: The Geolocation service failed.') :
                            console.log('Error: Your browser doesn\'t support geolocation.');
  }
}

function initMap() {
 // NO-OP
}

function drawMap() {
  var portlandCenter = { lat: 45.52, lng: -122.68 };
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 13,
    center: portlandCenter
  });

  locateShelters(map);
  addUserToMap(map);
}

function addUserToMap(map) {
  var infoWindow = new google.maps.InfoWindow({map: map});

  pos = {
    lat: parseFloat(document.getElementById('source_lat').innerHTML),
    lng: parseFloat(document.getElementById('source_lng').innerHTML)
  };

  infoWindow.setPosition(pos);
  infoWindow.setContent('Your Current Location');
  map.setCenter(pos);
}

function locateShelters(map) {
  var shelterNameArr = document.getElementsByClassName('shelter_name')
  var latitudeArr = document.getElementsByClassName('lat')
  var longitudeArr = document.getElementsByClassName('lng')

  for(var i = 0; i < latitudeArr.length; i++){
    name = capitalize(shelterNameArr[i].innerHTML);
    lat = parseFloat(latitudeArr[i].innerHTML);
    lng = parseFloat(longitudeArr[i].innerHTML);
    addMarker({lat: lat, lng: lng}, map, name);
  };
}

var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var labelIndex = 0;
function addMarker(location, map, title) {

  var marker = new google.maps.Marker({
    position: location,
    label: labels[labelIndex++ % labels.length],
    title: title,
    map: map,
    animation: google.maps.Animation.DROP
  });
}
