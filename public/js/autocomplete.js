$( "#shelterAutoComplete" ).autocomplete({
  source: document.getElementById('shelterArr').innerHTML.split(",")
});
