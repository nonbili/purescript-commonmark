var commonmark = require("commonmark");

exports.newParser_ = function() {
  return new commonmark.Parser();
};

exports.newHtmlRenderer_ = function() {
  return new commonmark.HtmlRenderer();
};

exports.parse_ = function(input, parser) {
  return parser.parse(input);
};

exports.render_ = function(node, renderer) {
  return renderer.render(node);
};

exports.renderString = function(input) {
  var reader = new commonmark.Parser();
  var writer = new commonmark.HtmlRenderer();
  var parsed = reader.parse(input);
  return writer.render(parsed);
};
