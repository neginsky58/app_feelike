define([
  'backbone' 
], function( Backbone){
  BackofficeObject.System || (BackofficeObject.System = {});
  BackofficeObject.System.Events || (BackofficeObject.System.Events = {});


  BackofficeObject.System.Events.Users = {
    /**
     * will do init on the users will check if user is login or not if not check if he is try access any page and redirect him else will just wire the event for login
     */
    Init: function () {
      var _this = this;
      _this._isLogin(function (resposne) {
        if (resposne.Status) {
          if (BackofficeObject.System.BasedView == BackofficeViewType.Login)
            ApplicationRouter.navigate("home/index", {trigger: true});

          _this._unwireLoginEvents();
        }
        else  {
          if (BackofficeObject.System.BasedView != BackofficeViewType.Login)
            ApplicationRouter.navigate("login", {trigger: true});
          else {
            _this._wireLoginEvents();
          }
        }
      });
    },
    Logout: function () {
      function initCall() {
        $.noop();
      }
      function sccuessCall(context ,  response) {
        ApplicationRouter.navigate("login", {trigger: true});
      }
      function failerCall() {
        ApplicationRouter.navigate("login", {trigger: true});
      }
      var CallData = {
        action: "DoLogout"
      };
      NetworkMangaer.RegisterCallback(initCall , sccuessCall, failerCall);
      NetworkMangaer.CreateCall('',NetworkMethods.GET,NetworkTypes.Json ,CallData);
    },
    /**
     * will check with server if user is login and what his status as well remark at with cookie for easy fetch of data
     * @param {funcation} callback will handle after function done
     */
    _isLogin: function (callback) {
      function initCall() {
        $.noop();
      }
      function sccuessCall(context ,  response) {
        if (response.status)
          callback({Status: true})
        else 
          callback({Status: false});
      }
      function failerCall() {
        callback({Status: false})
      }
      var CallData = {
        action: "isLogin"
      }
      NetworkMangaer.RegisterCallback(initCall , sccuessCall, failerCall);
      NetworkMangaer.CreateCall('',NetworkMethods.GET,NetworkTypes.Json ,CallData);
    },
    _unwireLoginEvents: function () {
        var _this = this;
        $("#btnLogin").off("click")
    },
    /**
     * will wire the login page
     */
    _wireLoginEvents: function () {
        var _this = this;
        $("#btnLogin").off("click").on("click" , function (evt){
          var responseData = {
            Status: false
          }
          function initCall() {
            $.noop();
          }
          function sccuessCall(context ,  response) {
            if (response.Success)
              ApplicationRouter.navigate("home/index", {trigger: true});
          }
          function failerCall() {
            $.noop();
          }
          var CallData = {
            action: "DoLogin",
            clientName: $("#txtClientName").val(),
            username: $("#txtUserName").val(),
            password: $("#txtPassword").val()
          };
          NetworkMangaer.RegisterCallback(initCall , sccuessCall, failerCall);
          NetworkMangaer.CreateCall('',NetworkMethods.GET,NetworkTypes.Json ,CallData);
        });
    }
  }
});