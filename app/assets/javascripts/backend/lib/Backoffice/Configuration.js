/**
 * this class its loader of the configure files of the system its very impotent class don't alter
 */
define([
    'backbone'
], function( Backbone){
    Configuration = { 
      Configs: {},
      /**
       * will load config to system
       * @param array  nameArr  this is the name of the config example:
       * [
       *     "{config file name only}", // dont add ext file such .json, .php, .whatever
       *     Settings
       * ]
       * 
       * @param Function callback call back
       */
      LoadConfigs: function (nameArr,callback) {
        var _this = this;
        if (_.isArray(nameArr)&& _.size(nameArr)!= 0){
          _.each(nameArr, function(value , key) {
            Core.Utills.LoadConfig(_.str.trim(value), function (response) {
              System.Logger.GetLog().debug(_.str.trim(value));
              if (response == undefined || response == null) {
                System.Logger.GetLog().warn(_.str.sprintf("configure file not found its may cause issue on system configure name is: %s",name));
              } 
              else {
                System.Logger.GetLog().debug(response);
                _this.Configs[_.str.trim(value)] = response;
                if (_.str.trim(_.last(nameArr)) == _.str.trim(value))
                  callback(_this.Configs);
                
              }
            });
          })
            
        }
        else {
          System.Logger.GetLog().info(_.str.sprintf("No configure files found"));
        }
      }
    }
});