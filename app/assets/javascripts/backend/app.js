// This is the main entry point for the App
define([
	'routers/main'
], function(router){
	var init = function(){
		this.router = new router();
    ApplicationRouter = this.router;
	};
	return { init: init};
});
