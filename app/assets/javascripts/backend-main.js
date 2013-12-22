// Require.js allows us to configure shortcut alias
require.config({
	baseUrl: '/assets/backend',
	// The shim config allows us to configure dependencies for
	// scripts that do not call define() to register a module
	shim: {
		'backbone': {
			exports: 'Backbone'
		},
		'Logger': {
			exports: "Logger"
		}
	},
	waitSeconds: 60,
	paths: {
		backbone: './lib/backbone/backbone',
		Backoffice: "./lib/Backoffice/loader",
		Logger: "./lib/logger/Logger",
		Moment: "./lib/moment/moment", 
		SpinLoader: "./lib/spin/spin", 
		text: './lib/require/text'
	}
});


require([
	'backbone',
	'app'
	], function(Backbone, app){
		app.init();
});