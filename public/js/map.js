var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var labelIndex = 0;

function initMap() {

  var portlandCenter = { lat: 45.52, lng: -122.68 };

  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 12,
    center: portlandCenter
  });

  locateUser();
  locateShelters();

  function locateUser() {
    var infoWindow = new google.maps.InfoWindow({map: map});
    var pos;

    // TODO: if no manually entered address/info then autolocate:
    // Try HTML5 geolocation.
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };

        infoWindow.setPosition(pos);
        infoWindow.setContent('Your Current Location');
        map.setCenter(pos);
      }, function() {
        handleLocationError(true, infoWindow, map.getCenter());
      });
    } else {
      // Browser doesn't support Geolocation
      handleLocationError(false, infoWindow, map.getCenter());
    }

    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
      infoWindow.setPosition(pos);
      infoWindow.setContent(browserHasGeolocation ?
                            'Error: The Geolocation service failed.' :
                            'Error: Your browser doesn\'t support geolocation.');
    }
    // } TODO: else use manually entered info for current location {
    //   pos = {
    //     lat: parseFloat(document.getElementById('source_lat').innerHTML),
    //     lng: parseFloat(document.getElementById('source_lng').innerHTML)
    //   };
    //   infoWindow.setPosition(pos);
    //   infoWindow.setContent('Your Current Location');
    //   map.setCenter(pos);
    // }
  }

  function locateShelters() {
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

  function addMarker(location, map, title) {
    var marker = new google.maps.Marker({
      position: location,
      label: labels[labelIndex++ % labels.length],
      title: title,
      map: map,
      animation: google.maps.Animation.DROP
    });
  }
}
