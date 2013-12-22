/**
 * preload class the give waiting element  that give the user knowledge what happens between the calls 
 * @author sivan wolberg
 * 
 */
define([ 
    'backbone',
    'Moment' ,
    'SpinLoader'
], function( Backbone){
    /**
     * class of the preload
     * @constructor
     * @param object options       have this follow object :  
     * {
          MaxTimeout: 120, // max time out for disable
          showPreview: false, // will show preview  perload or use custom
          showBlocker: true // will show the blocker
        }
     * 
     * @param function initCallback   if need do stuff when enable the preload
     * @param function failerCallback if need do stuff when its hit failed
     */
    Preloader  = function (options,initCallback,failerCallback) {
        var _this = this;
        var spinner = null;
        _this.maxTimeoutPerRequest  = (isNaN(options.MaxTimeout)) || 3000;
        _this.errorMessageTest = "Something happen the call been cancel sorry";
        _this.currentTime = null;
        _this.startTime = null;
        var timerIns = null;
        /**
         * will start the preload
         */
        _this.Enable = function() {
            _this.startTime = moment();
            _runLoaderElement();
            initCallback();
            _loadPreloadPanle();
            _startTimer();
        }
        /**
         * will stop the preload
         * @param Boolean hasError let know if call passed the max seconds of the call
         */
        _this.Disable = function (hasError) {
            _unloadPreloadPanle();
            if (hasError) {
                $(".preloader").find("span.waitingText").text(_this.errorMessageTest).delay(5000);
                failerCallback();
            }
            clearInterval(_this.timerIns);
            _this.timerIns = null;
        };
        function  _runLoaderElement() {
            var opts = {
              lines: 9, // The number of lines to draw
              length: 6, // The length of each line
              width: 3, // The line thickness
              radius: 5, // The radius of the inner circle
              rotate: 19, // The rotation offset
              color: '#000', // #rgb or #rrggbb
              speed: 0.8, // Rounds per second
              trail: 41, // Afterglow percentage
              shadow: true, // Whether to render a shadow
              hwaccel: true, // Whether to use hardware acceleration
              className: 'spinner', // The CSS class to assign to the spinner
              zIndex: 2e9, // The z-index (defaults to 2000000000)
              top: 'auto', // Top position relative to parent in px
              left: 'auto' // Left position relative to parent in px
            };
            var target = $(".preloader").find("div.preloaderImage")[0];
            spinner = new Spinner(opts).spin(target);
        }
        /**
         * will display the preload in the ui
         */
        function _loadPreloadPanle() {
            if (options.showPreview)
                $(".preloader").show();
            if (options.showBlocker)
                $(".preloader-blocker").show();
        }
        /**
         * will remove the display of the preload
         */
        function _unloadPreloadPanle() {
            spinner = null;
            $(".preloader").hide();
            $(".preloader-blocker").hide();
        }

        /**
         * will start the timer
         */
        function _startTimer() {
            if (_this.timerIns == undefined || _this.timerIns == null) {
                window.PreloaderIns = _this;
                _this.timerIns = self.setInterval(function () {
                    window.PreloaderIns.currentTime = moment();
                    var seconds = Math.abs(window.PreloaderIns.startTime.diff(window.PreloaderIns.currentTime, 'seconds'));
                    if (seconds > window.PreloaderIns.maxTimeoutPerRequest)
                    {
                        window.PreloaderIns.Disable(true);
                    }
                },1000);
            }
        }
    }
});