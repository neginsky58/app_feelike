/**
 * this class responsible for the system network traffic of the site its as well handle the error if been rise.
 */
define([
    'backbone',
    'Moment' ,
    'SpinLoader'
], function(Backbone){
  NetworkTypes = {
      Json: "JSON",
      Jsonp: "JSONP",
      XML: "XML"
  }
  NetworkMethods = {
      GET: "get",
      POST: "post",
      DELETE: "delete",
      PUT: "put"
  }
  NetworkMangaer = {
    /**
     * number of seconds that call had
     * @type {int}
     */
    DurationCallTime: 0,
    /**
     * start date of the call
     * @type {date}
     */
    StartCallTime: null,
    /**
     * end date of the call
     * @type {date}
     */
    EndCallTime: null,
    /**
     * network caller object
     * @type {networkCaller}
     */
    NetworkIns: null,
    /**
     * set block on the system network (block if set is true)
     * @type boolean
     */
    isNetworkBlocked: false,
    /**
     * call back function before the ajax been called
     * note: default set as empty function
     */
    _initCallback: null,
    /**
     * call back function after the ajax been called and received code 200 (response not been processes)
     * note: default set as empty function
     */
    _successCallback: null,
    /**
     * call back function after the ajax been called and received different code from 200  (response code not  200 / timeout)
     * note: default set as empty function
     */
    _errorCallback: null,
    /**
     * check if there is active call in system / has blocker flag active
     */
    CanCall: function () {
      var _this = this;
      return !(_this.isNetworkBlocked&& _this.NetworkIns != null);
    },
    /**
     * will register the call backs into system
     * @param function initCallback    init function if need do staff before ajax call
     * @param function sccuessCallback when ajax return status 
     * @param function errorCallback   ajax error data
     */
    RegisterCallback: function (initCallback , sccuessCallback , errorCallback) {
      var _this = this;
      _this._initCallback = initCallback;
      _this._successCallback = sccuessCallback;
      _this._errorCallback = errorCallback;
    },
    /**
     * will make the call to the server
     * @param function uri    uri of the ajax
     * @param function method method of the ajax
     * @param function type   type of the ajax
     * @param function data   object of the data
     * @param boolean isByPassBlocker if set to true its will send the call anyhow
     */
    CreateCall: function (uri,method , type , data,isByPassBlocker) {
      var _this = this;
      if (_this.CanCall() || isByPassBlocker) {
        _this._initCallback ();
        _this.NetworkIns = new networkCaller(uri,method , type , data,_this._successCallback,_this._errorCallback);
        _this.NetworkIns.Call();
      }
    }
  }
  var networkCaller = function (uri , method, type, data,sccuessCallback, failerCallback) {
    var _this = this;
    var preloader = $("#preloadingLoginDialog");
    _this.startCallTime = null;
    _this.endCallTime = null;
    _this.durCallTime = null;
    _init();
    /**
     * will init the system
     * @return {[type]} [description]
     */
    function _init() {
      _this.startCallTime = moment();
      preloader.modal({
        keyboard: false,
        backdrop: false,
        show: true
      });
    }
    /**
     * will call 
     */
    _this.Call = function ()  {
      _callAjax();
    } 

    /**
     * well call to the server request for the data
     */
    function _callAjax () {
        var uriAjax = "";
        uri = _.str.trim(uri);
        //make sure there is a uri when the uri line is point to the system so the empty!
        if (uri == "") 
          uriAjax = _.str.sprintf(Configuration.Configs["Settings"].Network.AjaxUriFormat,Configuration.Configs["Settings"].Network.AjaxUri,method);
        try {
          $.ajax({
            type: method,
            url: uriAjax,
            dataType: type,
            data: data,
            statusCode: {
              //happend when server error  404
              404: function () {
                System.Logger.GetLog().info('Service System Is Down (404)', 'Error');
                _this.endCallTime = moment();
                _this.durCallTime = _this.startCallTime.diff(_this.endCallTime,"seconds");
                preloader.modal("hide");
                failerCallback(_this);
              },
              //happend when server error  500
              500: function () {
                System.Logger.GetLog().error('Service System Is Down (500)', 'Error');
                _this.endCallTime = moment();
                _this.durCallTime = _this.startCallTime.diff(_this.endCallTime,"seconds");
                preloader.modal("hide");
                failerCallback(_this);

              },
              //happend when server error  299
              299: function () {
                System.Logger.GetLog().error('Service System Is Down (299)', 'Error');
                _this.endCallTime = moment();
                _this.durCallTime = _this.startCallTime.diff(_this.endCallTime,"seconds");
                preloader.modal("hide");
                failerCallback(_this);

              },
              //happend when server error  403
              403: function () {
                System.Logger.GetLog().error('Service System Is Down (403)', 'Error');
                _this.endCallTime = moment();
                _this.durCallTime = _this.startCallTime.diff(_this.endCallTime,"seconds");
                preloader.modal("hide");
                failerCallback(_this);

              }
            },
            //happend when server code  200 (will be faild on  if happend timeout  ,  error , about  ,  parseerror)
            complete: function (e, xhr, settings) {
              if ( xhr == "parsererror"||xhr == "abort" || xhr == "timeout" || xhr == "error") {
                System.Logger.GetLog().error('Service System Is Down (Bad Response Or Failed Response)', 'Error');
                _this.endCallTime = moment();
                _this.durCallTime = _this.startCallTime.diff(_this.endCallTime,"seconds");
                preloader.modal("hide");
                failerCallback(_this);
              }
            },
            // called when got response from server
            success: function (context) {
              if (context.hasOwnProperty('type') && context.hasOwnProperty('status') && context.hasOwnProperty('code') && context.hasOwnProperty('code') && parseInt(_this,context.code) == 200)
              {
                if (context.type == 'error')
                {
                  System.Logger.GetLog().error('Service System Is Down (Bad Response)', 'Error');
                  _this.endCallTime = moment();
                  _this.durCallTime = _this.startCallTime.diff(_this.endCallTime,"seconds");
                  failerCallback();
                }
                else {
                  if (context.type == 'data') {
                    _this.endCallTime = moment();
                    _this.durCallTime = _this.startCallTime.diff(_this.endCallTime,"seconds");
                    sccuessCallback(_this,context.data);
                  }
                }
              }
              else {
                System.Logger.GetLog().error('Service System Is Down (Bad Response)', 'Error');
                _this.endCallTime = moment();
                _this.durCallTime = _this.startCallTime.diff(_this.endCallTime,"seconds");
                failerCallback();
              }
              preloader.modal("hide");
            },
            //just in case will be trigger under any error that not listed
            failure: function (data) {
              System.Logger.GetLog().error('Service System Action failure', 'Error');
              _this.endCallTime = moment();
              _this.durCallTime = _this.startCallTime.diff(_this.endCallTime,"seconds");
              preloader.modal("hide");
              failerCallback(_this);
            } // When Service call fails
          });
        } catch (e) {
          //happens when syntax error or any time error that its source not network.
          System.Logger.GetLog().error('Service System Action Error ', 'Error');
          _this.endCallTime = moment();
          _this.durCallTime = _this.startCallTime.diff(_this.endCallTime,"seconds");
          preloader.modal("hide");
          failerCallback(_this);
        }
    }
  };

        
});