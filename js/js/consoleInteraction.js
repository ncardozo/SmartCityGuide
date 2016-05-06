var readline = require('readline');
var inquirer = require('inquirer');

function displayOptions() {
	var self = this;
  return inquirer.prompt([{
      type: 'list',
      name: 'toplevel',
      message: 'Mobile City Guide UI \n Please select one of the following options (enter -1 to exit the application)',
      choices: ["1. Create Itinerary", "2. Menu"]
    }, {
			name: 'citylevel',
			type: 'input',
			message: 'Enter the name of the city (Enter 0 to go back)',
			when: function(answers) {
				cityName = 
				return answers.toplevel === "1";
			}
		}, {
			name: 'itinerarylevel',
			message: 'Which POIs do you want to add to your itinerary?',
			choices: [],
			when: function(answers) {
				return answers.toplevel === "1";
			}
		}],
		function(responses) {

		}
  );
}
