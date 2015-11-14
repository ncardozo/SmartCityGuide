var readline = require('readline');


var rl = readline.createInterface(process.stdin, process.stdout);
rl.setPrompt('SCG-JS> ');

//cityPrompt.pause();

function displayOptions() {
	console.log("Mobile City Guide UI -main ");
	console.log("Please select one of the following options (enter -1 to exit the application)");
	console.log("  1. Select Town");
	console.log("  2. Create Itinerary");
	
}

displayOptions();
rl.prompt();

rl.on('line', function(line) {
	switch(line.trim()) {
    	case '1':
			rl.pause();
      		createCityConsole();
      		break;
		case '2':
			rl.pause();
			createItineraryConsole();
			break;
		case '-1':
			rl.close();
    	default:
      		console.log('Unsupported option');
      		break;
  	}
//	displayOptions();
	rl.prompt();
});

rl.on('close', function() {
  //console.log('Have a great day!');
  process.exit(0);
});

function createCityConsole() {
	var cityPrompt = readline.createInterface(process.stdin, process.stdout);
	cityPrompt.setPrompt('SCG-JS_city> ');
	
	console.log("Enter the name of the city (Enter 0 to go back)");
	cityPrompt.prompt();
	
	cityPrompt.on('line', function(name) {
	switch(name.trim()) {
		case '0':
			displayOptions();
			break;
		default:
			console.log("Name entered for city: " + name.trim());
			break;
	}
	});
	cityPrompt.stop();
	rl.resume();
	rl.prompt();
}
