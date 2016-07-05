var inquirer = require('inquirer');
var db = require("./DBManager.js");
var PVC = require("./poiViewController.js");
var User = require("./user.js");

var MenuViewControllerStrategy = function() {};
MenuViewControllerStrategy.prototype.loadTour = function() {
  throw new Error("A tour strategy must be chosen");
};

MenuViewControllerStrategy.prototype.loadTour = function() {
  PVC.PoiViewController.setStrategy(new PVC.PoiViewControllerStrategy());
  PVC.PoiViewController.displayPoi(1);
};

var GuidedTourMenuViewControllerStrategy = function() {};
GuidedTourMenuViewControllerStrategy.prototype.loadTour = function() {
  PVC.PoiViewController.setStrategy(new PVC.GuidedTourPoiViewControllerStrategy());
  var res = db.runQuesry('SELECT id FROM Itinerary WHERE user = %@', User.getId());
  var itineraryId;
  var questions = [{
      type: 'list',
      name: 'toplevel',
      message: 'Select an itinerary',
      choices: res
    }];
  inquirer.prompt(questions).then(function (answers) {
    itineraryId = answers.toplevel;
  });
  PVC.PoiViewController.displayPoi(1, itinerarId);
};

var FreeVisitMenuViewControllerStrategy = function() {};
FreeVisitMenuViewControllerStrategy.prototype.loadTour = function() {
  PVC.POIViewController.setStrategy(new PVC.PoiViewControllerStrategy());
  PVC.PoiViewController.displayPoi(1);
};

var MenuViewController = function(strategy) {
  this.strategy = strategy;
};

MenuViewController.prototype.getStrategy = function() {
  return this.strategy;
};

MenuViewController.prototype.setStrategy = function(strategy) {
  this.strategy = strategy;
};

MenuViewController.prototype.loadTour = function() {
  this.strategy.loadTour();
};


module.exports = {
  MenuViewController: MenuViewController,
  GuidedTourMenuViewControllerStrategy: GuidedTourMenuViewControllerStrategy,
  FreeVisitMenuViewControllerStrategy: FreeVisitMenuViewControllerStrategy,
};
