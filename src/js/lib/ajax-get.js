module.exports = function (url, fn) {
  var req = new XMLHttpRequest();

  req.onreadystatechange = function() {
    if (req.readyState == 4 && req.status == 200) fn(req.responseText);
  }
  req.open('GET', url, true);
  req.send('');
}
