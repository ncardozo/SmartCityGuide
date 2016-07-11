var inquirer = require('inquirer');

var questions = [{
    type: 'list',
    name: 'toplevel',
    message: 'Mobile City Guide UI \n Please select one of the following options',
    choices: ["Create Itinerary", "Menu", new inquirer.Separator(),"Exit"]
  }, {
    name: 'citylevel',
    type: 'input',
    message: 'Enter the name of the city',
    when: function(answer) {
      return answer.toplevel == "Create Itinerary";
    },
    filter: function(val) {
      return val;
    },
  }, {
    type: 'checkbox',
    name: 'itinerarylevel',
    message: 'Which POIs do you want to add to your itinerary?',
    choices: [{name: "a"}, {name:"b"}, {name: "c"}, {name: "d"}, {name: "e"}],
    validate: function(answers) {
      if(answers.length < 1) {
        return "You must chose a city";
      }
      return answers;
    }
  }, {
    type: 'list',
    name: 'menuOptions',
    choices: ["Time", "Language", "Visit Type"],
    when: function(answer) {
      return answer.toplevel == "Menu" ;
    }
  }, {
    type: 'checklist',
    name: "TimeOfDay",
    choices: [{name: "Morning"}, {name:"Afternoon"}, {name: "Night"}],
    when: function(answer) {
      return answer.menuOptions == "Time";
    }
  }, {
    type: 'checklist',
    name: "language",
    choices: [{name: "English"}, {name:"French"}, {name: "Dutch"}],
    when: function(answer) {
      return answer.menuOptions == "Language";
    }
  }, {
    type: 'checklist',
    name: "visitType",
    choices: [{name: "GuidedVisit"}, {name:"FreeVisit"}],
    when: function(answer) {
      return answer.menuOptions == "Visit Type";
    }
  }];

function main() {
  inquirer.prompt([{type: 'rawlist', name: "test", message: "Choose", choices: ["a", "b", "c"]}]).then(function (answers) {
    console.log(JSON.stringify(answers, null, '  '));
    if(answers.toplevel == "Menu") {
      if(answers.menuOptions == "Time") {
        eval(answers.TimeOfDay + ".activate()"));
      } else if(answers.menuOptions == "Language") {
        eval(answers.language + ".activate()"));
      } else if(answers.menuOptions == "Visit Type") {
        eval(answers.visitType + ".activate()");
      }
    }
  });
}

main();
