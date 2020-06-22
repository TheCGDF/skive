function getCookie(name) {
  name += "=";
  let cookies = document.cookie.split(';');
  for (let cookie of cookies) {
      cookie = cookie.trim();
      if (cookie.startsWith(name)) {
          return cookie.substring(name.length);
      }
  }
  return null;
}

function setCookie(name, value, hours) {
  let expires = "";
  if (hours) {
      let date = new Date();
      date.setTime(date.getTime() + (hours * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
  }
  document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

function removeCookie(name) {
  document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}