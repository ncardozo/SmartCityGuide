

var DBManager = function() {
    this.db = openDatabase('SmartCityGuide.sqlite', '1.0', 'SmartCityGuide db', 10 * 1024 * 1024);
    this.results = [];
};

DBManager.prototype.runQuery = function(query) {
  var self = this;
  this.db.transaction(function (tx, query) {
    self.results = [];
    tx.executeSql(query, self.results, function(tx, res) {
      var len = res.rows.length, i;
      for (i = 0; i < len; i++) {
        self.results[self.results.length] = res.rows.item(i).text;
      }
    });
  });
  return self.results;
};

module.exports = DBManager;
