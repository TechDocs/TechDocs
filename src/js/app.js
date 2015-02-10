var riot = require('riot');
var ajax = require('./lib/ajax-get');
require('../components/app.tag');
require('../components/logo.tag');
require('../components/item.tag');
require('../components/footnote.tag');

URL = '/index.json';

ajax(URL, function(data) {
  riot.mount('app', {
    title: 'TechDocs',
    items: JSON.parse(data),
    urls: {
      github: 'https://github.com/TechDocs/TechDocs'
    }
  });
});
