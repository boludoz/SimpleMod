var webPage = require('webpage');
var page = webPage.create();

page.open('https://translate.google.com/#auto/es/perro', function (status) {
  console.log('Stripped down page text:\n' + page.plainText);
  phantom.exit();
});