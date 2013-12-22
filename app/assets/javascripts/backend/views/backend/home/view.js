define([ 
		'backbone',
		'Backoffice',
    'text!/templates/common/menu.html',
		'text!/templates/home/main.html',
		'text!/templates/home/login.html'], 
function( Backbone,   BackofficeObject,menuView,templateMain,templateLogin){
	var View = Backbone.View.extend({
		el: '#main',
		initialize: function(){
		},
		MainRender: function(){
      BackofficeObject.Instance.Render(menuView,templateMain,{SelectPage: ''},BackofficeViewType.Main);
		},
		LoginRender: function(){
			BackofficeObject.Instance.Render(menuView,templateLogin,{},BackofficeViewType.Login);
		},
		PageRender: function (selectorPage) {
      BackofficeObject.Instance.Render(menuView,templateMain,{SelectPage: selectorPage},BackofficeViewType.Main);
		}
	});
	
	return new View();
});
