var commonmark = require("commonmark");

exports.renderString_ = function(input) {
  var parser = new commonmark.Parser();
  var renderer = new commonmark.HtmlRenderer();
  var parsed = parser.parse(input);
  return renderer.render(parsed);
};

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
