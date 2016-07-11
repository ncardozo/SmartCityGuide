var Trait = require("traits").Trait;
var cop = require("context-traits");
var CATEGORY = require("./category.js");

TToolsCategoryViewControllerOperations = Trait({
  tableView: function(view, index) {
    var category = this.categoryList[index];
    console.log(category.getName());
    console.log("Category color Black");
  }
});

//ADAPTATIONS
TColorToolsCategoryViewControlelrOperations = Trait({
  tableView: function(view, index) {
    var category = categoryList[index];

    console.log(category.getName());
    console.log("Category color " + category.getColor());
  }
});

//BEHAVIOR
function ToolsCategoryViewController() {
  return Object.create(Object.prototype, Trait.compose(TToolsCategoryViewControllerOperations, Trait({
    categoryList: []
  })));
}


module.exports = {
  ToolsCategoryViewController: ToolsCategoryViewController,
  TColorToolsCategoryViewControlelrOperations: TColorToolsCategoryViewControlelrOperations
};
