define([
    'backbone'
], function(Backbone){
  BackofficeViewType = {
    Login: 0,
    Main: 1
  };
  BackofficeObject = function (){
    initBackoffice();
    function initBackoffice() {
      //init log system
      System.Logger.Init();
    }
    /**
     * will load the configs
     * @param  Function callback call back function
     */
    function _loadConfigLoginSetup (callback) {
      var configFilesToLoad = [
        "Settings",
        "Menus"
      ];
      Configuration.LoadConfigs(configFilesToLoad,callback);
    }
    /** load of locatliztion **/
    function _loadLocazitionPack(langName,callback) {
      Core.Utills.LoadLocalization(langName,function (response) { callback(response); });
    }  
    /**pre fillter actions **/
    function _preLoadingActions() {
      //links fix for #!
      $(document).ready(function (evt) {
        $(document).on("click", "a[href^='/']", function(event) {
          var href, passThrough, url;
          href = $(event.currentTarget).attr('href');
          passThrough = href.indexOf('logout') >= 0;
          if (!passThrough && !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey) {
            event.preventDefault();
            url = href.replace(/^\//, '').replace('\#\!\/', '');
            ApplicationRouter.navigate(url, {
              trigger: true
            });
            return false;
          }
        });
      });
      //BackofficeObject.System.Events.Users.Init();
    }
    function _postLoadingActions() {
      if (BackofficeObject.System.BasedView != BackofficeViewType.Login) {
        var menuElement  = $("ul#MainMenu");
        menuElement.find("li").eq(BackofficeObject.System.BasedView-1).addClass("active");
      }
    }
    return {
      Render: function (menuView,template , data,pageType) {
        var _this = this;
        $(document).ready(function () {
          var extrnalData = {
              MainMenu: menuView
          }; 
          var callbackAfterRender = null;
          var selectedLang = $.cookie("selectedLang");
          if (_.str.trim(selectedLang) == "")
            selectedLang = 'en';
          _loadLocazitionPack(selectedLang,function _loadingLang(localizationPackResponse) {
            BackofficeObject.System.Localiztion = localizationPackResponse;
            _loadConfigLoginSetup(function _loadConfig(ConfigObject) {
              _preLoadingActions();
              BackofficeObject.System.Configs = ConfigObject;
              switch (pageType) {
                case BackofficeViewType.Login: 
                  BackofficeObject.System.Pages.Login.Init();
                break;
                case BackofficeViewType.Main: 
                  BackofficeObject.System.Pages.Main.Init(data);
                  extrnalData = _.extend(extrnalData,BackofficeObject.System.Pages.Main.DataObject);
                break;
                case BackofficeViewType.Product: 
                  BackofficeObject.System.Pages.Product.Init(data);
                  extrnalData = _.extend(extrnalData,BackofficeObject.System.Pages.Product.DataObject);
                break;
                case BackofficeViewType.Shop: 
                  BackofficeObject.System.Pages.Shop.Init(data);
                  extrnalData = _.extend(extrnalData,BackofficeObject.System.Pages.Shop.DataObject);
                break;
                case BackofficeViewType.Categories: 
                  BackofficeObject.System.Pages.Categoires.Init(data);
                  extrnalData = _.extend(extrnalData,BackofficeObject.System.Pages.Categoires.DataObject);
                break;
                case BackofficeViewType.Order: 
                  BackofficeObject.System.Pages.Orders.Init(data);
                  extrnalData = _.extend(extrnalData,BackofficeObject.System.Pages.Orders.DataObject);
                break;
                case BackofficeViewType.Promotions: 
                  BackofficeObject.System.Pages.Promotions.Init(data);
                  extrnalData = _.extend(extrnalData,BackofficeObject.System.Pages.Orders.DataObject);
                break;
              }
            });
            BackofficeObject.System.BasedView = pageType;
            extrnalData = _.extend(extrnalData,data);
            extrnalData.Localiztion = BackofficeObject.System.Localiztion;
            _this.RenderMainElemetn(template,extrnalData,callbackAfterRender);
          })
        });
      },
      RenderMainElemetn: function (template , data,callback) {
        var _this = this;
        data.MainMenu = _.template( data.MainMenu, data );
        template = _.template( template, data );
        $(BackofficeObject.ElementCore ).html( template ); 
        if (callback!= null && _.isFunction(callback))
          callback();
        _postLoadingActions();
      }
    }
  };
  BackofficeObject.ElementCore = "#main";
  BackofficeObject.instance = null;
  BackofficeObject.System = {};
  BackofficeObject.System.BasedView = null;
  BackofficeObject.System.Configs = null;
  BackofficeObject.getInstance = function() {
    if (BackofficeObject.instance == null) {
      BackofficeObject.instance = new BackofficeObject();
    }
    return BackofficeObject.instance;
  }
});