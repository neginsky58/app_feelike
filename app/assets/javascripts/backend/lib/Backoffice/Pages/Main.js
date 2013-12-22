define([ 
    'backbone' 
], function( Backbone){
  BackofficeObject.System || (BackofficeObject.System = {});
  BackofficeObject.System.Pages || (BackofficeObject.System.Pages = {});
  BackofficeObject.System.Pages.Main = {
    RenderData: null,
    DataObject: {},
    Init: function (dataObject) {
      var _this = this;
      _this.RenderData = dataObject;
      if (_this.RenderData.SelectPage == "logout") {
        BackofficeObject.System.Events.Users.Logout();
      }
      else {
        _this._loadMenus();
        BackofficeObject.System.Events.Main.Init();
      }
    },
    ChangeBreadcrumb: function(nav) {
      var _this = this;
      var mainElem = $(BackofficeObject.System.Configs.Menus.Breadcrumb.Element);
      if (!_.isArray(nav)|| _.size(nav)== 0){
        nav = BackofficeObject.System.Configs.Menus.Breadcrumb.DefaultBreadcrumb;
      }
      mainElem.empty();
      _.each(nav , function (v,k) {
        if (_.last(nav) != v) 
          mainElem.append(_.str.sprintf('<li><a href="#">%s</a> <span class="divider">/</span></li>',v));
        else
          mainElem.append(_.str.sprintf('<li class="active">%s</li>',v));
      });

    },
    _loadMenus: function () {
      var _this = this;
      _this._handleUserMenu();
      _this._handleMainMenu();
    },//
    _handleUserMenu: function () {
      var _this = this;
      var userElem = $(BackofficeObject.System.Configs.Menus.UserMenu.Element);
      
      userElem.find(".profile a").attr("href", BackofficeObject.System.Configs.Menus.UserMenu.Profile.Link);
      userElem.find(".logout a").attr("href", BackofficeObject.System.Configs.Menus.UserMenu.Logout.Link);
    },
    _handleMainMenu: function () {
      var _this = this;
      var mainElem = $(BackofficeObject.System.Configs.Menus.Main.Element);
      mainElem.empty(); //we clear all main menu from the system if existed
      _.each(BackofficeObject.System.Configs.Menus.Main.Items,function (v,k) {
        var sectionObject = v;
        if (sectionObject.Enable) {
          mainElem.append(_.str.sprintf('<li class="nav-header hidden-tablet">%s</li>',sectionObject.SectionText))
          _.each(sectionObject.Items,function (v1,k1) {
            var itemObject = v1;
            if (itemObject.Enable)
              mainElem.append(_.str.sprintf('<li id="item_%s_%s"><a class="ajax-link" href="javascript:void(0)"><i class="%s"></i><span class="hidden-tablet"> %s</span></a></li>',k,k1,itemObject.Icon,itemObject.ItemText));
            //System.Logger.GetLog().debug( "#item_"+k+"_"+k1);
            $("#item_"+k+"_"+k1).find("a").click(function (evt) {
              ApplicationRouter.navigate( itemObject.Link , true);
            })
          })
        }
      })
      _this.ChangeBreadcrumb();
    },
    LoadCallback: function () {
      return null;
    }
  }
});