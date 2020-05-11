function getCookie(name) {
  name += "=";
  var cookies = document.cookie.split(';');
  for (var cookie of cookies) {
      cookie = cookie.trim();
      if (cookie.startsWith(name)) {
          return cookie.substring(name.length);
      }
  }
  return null;
}

function setCookie(name, value, days) {
  var expires = "";
  if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
  }
  document.cookie = name + "=" + (value || "") + expires + "; path=/";
}