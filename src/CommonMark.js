var commonmark = require("commonmark");

exports.render = function(input) {
  var reader = new commonmark.Parser();
  var writer = new commonmark.HtmlRenderer();
  var parsed = reader.parse(input);
  return writer.render(parsed);
};
