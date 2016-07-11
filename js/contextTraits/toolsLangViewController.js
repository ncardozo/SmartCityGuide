var cop = require("context-traits");

//BEHAVIOR
var ToolsLangViewController = function() {
  this.langContexts = [];
};

ToolsLangViewController.prototye.tableView = function(view, index) {
  var newLangContext = langContexts[index];
  eval(newLangContext+".activate()");
};

ToolsLangViewController.prototye.addLangContext = function(lang) {
  this.langContexts.push(lang);
};


module.exports = {
  ToolsLangViewController: ToolsLangViewController,
};
