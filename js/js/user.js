

var User = function() {
  this.currentLocation = "";
  this.id = -1;
};

User.prototype.setId = function(userId) {
  this.id = userId;
};

User.prototype.getId = function() {
  return this.id;
};

User.prototype.getLocation = function() {
  return ;
};

module.exports = {
  User: User
};
