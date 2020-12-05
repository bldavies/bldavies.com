function show_abstract_toggle(id) {
  t = document.getElementById(id.concat('-abstract-toggle'))
  t.style.display = "inline-block"
}

function toggle_abstract(id) {
  var a = document.getElementById(id.concat('-abstract'))
  if (a.style.display == "none") {
    a.style.display = "block";
  } else {
    a.style.display = "none";
  }
  var t = document.getElementById(id.concat('-abstract-toggle'))
  if (t.innerHTML == "abstract [+]") {
    t.innerHTML = "abstract [-]";
  } else {
    t.innerHTML = "abstract [+]";
  }
}
