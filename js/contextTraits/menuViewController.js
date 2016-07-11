var Trait = require("traits").Trait;
var cop = require("context-traits");
var inquirer = require('inquirer');
var db = require("./DBManager.js");
var PVC = require("./poiViewController.js");
var User = require("./user.js");

TMenuViewControllerOperations = Trait({
  loadTour: function() {
    PVC.PoiViewController.setStrategy(new PVC.PoiViewControllerStrategy());
    PVC.PoiViewController.displayPoi(1);
  },

});

TGuidedTourMenuViewControllerOperations = Trait({
  loadTour: function() {
    GuidedTour.activate();
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
  }
});

TFreeVisitMenuViewControllerOperations = Trait({
  loadTour: function() {
    GuidedTour.deactivate();
    PVC.PoiViewController.displayPoi(1);
  }
});

function MenuViewController() {
  return Object.create(Object.prototype, TMenuViewControllerOperations);
}


module.exports = {
  MenuViewController: MenuViewController,
  TGuidedTourMenuViewControllerOperations: TGuidedTourMenuViewControllerOperations,
  TFreeVisitMenuViewControllerOperations: TFreeVisitMenuViewControllerOperations,
};
