var CATEGORY = require("./category.js");

var ToolsCategoryViewControllerStrategy = function() {
  this.categoryList = [];
};

ToolsCategoryViewControllerStrategy.prototye.tableView = function(view, index) {
  var category = this.categoryList[index];
  console.log(category.getName());
  console.log("Category color Black");
};

//ADAPTATIONS
var ColorToolsCategoryViewControlelrStrategy = function() {};
ColorToolsCategoryViewControlelrStrategy.prototye.tableView = function(view, index) {
  var category = categoryList[index];

  console.log(category.getName());
  console.log("Category color " + category.getColor());
};

//
var ToolsCategoryViewController = function(strategy) {
  this.strategy = strategy;
};

ToolsCategoryViewController.prototype.setStrategy = function(strategy) {
  this.strategy = strategy;
};

ToolsCategoryViewController.prototype.getStrategy = function() {
  return this.strategy;
};

ToolsCategoryViewController.prototype.tableView = function(view, index) {
  this.strategy.tableView(view, index);
};


module.exports = {
  ToolsCategoryViewController: ToolsCategoryViewController,
  ToolsCategoryViewControllerStrategy: ToolsCategoryViewControllerStrategy,
  ColorToolsCategoryViewControlelrStrategy: ColorToolsCategoryViewControlelrStrategy
};
