/**
 * this class is the logger system 
 */
define([
  'backbone',
  'lib/logger/log-lib'
], function( Backbone){
  System = {};
  System.Logger = {
    _currentLogger: null,
    _isDebugMode: false,
    Init: function () {
      var _this = this;
      _this._currentLogger = window.debug;
      _this._currentLogger.group( 'System Log' );
    },
    GetLog: function (message , level) {
      var _this = this;
      if (_this._currentLogger == undefined || _this._currentLogger  == null) 
        _this.Init();
      return _this._currentLogger;   
    },
    CanWirteLog: function () {
      var _this = this;
      return _this._isDebugMode;
    },
    ToggleDebugMode: function () {
      var _this = this;
      if (_this._isDebugMode) {
        _this._currentLogger.setLevel(Log4js.Level.OFF);
        _this._isDebugMode  = false;
      }
      else {
        _this._currentLogger.setLevel(Log4js.Level.ALL);
        _this._isDebugMode  = true;
      }
    }
  }
});