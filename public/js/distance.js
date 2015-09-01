function calculateDistances() {
  origin = document.getElementById('source').value; //Get the source string
  destination = document.getElementById('dest').value; //Get the destination string
  var service = new google.maps.DistanceMatrixService(); //initialize the distance service
  service.getDistanceMatrix(
    {
      origins: [origin], //set origin, you can specify multiple sources here
      destinations: [destination],//set destination, you can specify multiple destinations here
      travelMode: google.maps.TravelMode.DRIVING, //set the travelmode
      unitSystem: google.maps.UnitSystem.METRIC,//The unit system to use when displaying distance
      avoidHighways: false,
      avoidTolls: false
    }, calcDistance); // here calcDistance is the call back function
}



function calcDistance(response, status) {
  if (status != google.maps.DistanceMatrixStatus.OK) {
    alert('Error was: ' + status);
  } else {
    var origins = response.originAddresses;
    var destinations = response.destinationAddresses;

    for (var i = 0; i < origins.length; i++) {
      var results = response.rows[i].elements;
     /* addMarker(origins[i], false);*/
      for (var j = 0; j < results.length; j++) {
       /* addMarker(destinations[j], true);*/
        outputDiv.innerHTML = origins[i] + ' to ' + destinations[j]
            + ': ' + results[j].distance.text + ' in '
            + results[j].duration.text + '<br>';
      }
    }
  }
}
