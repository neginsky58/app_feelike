define([
	'backbone', 
	//'views/backend/agent/view',
	'views/backend/home/view'
], 
function( Backbone, mainView){
	var Router = Backbone.Router.extend({
		initialize: function(){
			this.mainView = mainView;
			Backbone.history.start();
		},
		routes: {
			'': 'home',
			'dash': 'home',
			'login':'login',
		},
		'home': function(){
			this.mainView.MainRender();
		},
		'login': function(){
			this.mainView.LoginRender();
		}
	});
	return Router;
});
