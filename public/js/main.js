// activate materialize select_option functionality
$(document).ready(function() {
  $('select').material_select();
});

function capitalize(str) {
  return str.replace(/\w\S*/g, function(txt) {
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
  });
}
