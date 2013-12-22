define([
    'backbone'
], function( Backbone){
  if (typeof Core === "undefined" ) 
  Core = {};
  Core.Utills = {
	  extTemplateFile: ".html",
    extConfigFile: ".json",
    /**
     * will load template from template folders
     * @param namespace
     * @param templateName
     * @param callback
     */
    LoadTemplate: function(namespace,templateName,callback) {
      var _this = this;
      var uri = "/templates/"+namespace+"/"+templateName+_this.extTemplateFile;
      $.get(uri, function (data) {
        callback(data);
      });
    },
    /**
     * will load configure file of the system
     * @param namespace
     * @param templateName
     * @param callback
     */
    LoadConfig: function(configName,callback) {
      var _this = this;
      var uri = "/backend/main/config/"+configName;
      $.getJSON(uri, function (data) {
        callback(data);
      });
    },
    /**
     * will load localization file of the system
     * @param namespace
     * @param templateName
     * @param callback
     */
    LoadLocalization: function (langName, callback) {
      var _this = this;
      var uri = "/backend/main/localization/"+langName;
      $.getJSON(uri, function (data) {
        callback(data);
      });
    },
    /**
     * will trigger error report
     */
    PrintErrorReport: function (validationObject) {
      var _this = this;
      $('.errorLoginDialog').find(".alert").empty();
      var errorPoints = "<ul>%s</ul>";
      var errorPoint = "<li>%s</li>";
      var bufferOptions = "";
      _.each(validationObject.GetValidatorSummary(),function (errorItem) {
        bufferOptions +=  _.str.sprintf(errorPoint,errorItem)
      });
      $('.errorLoginDialog').find(".alert").append(_.str.sprintf(errorPoints,bufferOptions));
    },
    /**
     * create pop
     * @param width
     * @param height
     * @param uri
     * @return window object
     * @constructor
     */
    CreatePopup: function (width,height,uri) {
      day = new Date();
      id = day.getTime();
      var popupElement = window.open(uri, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width='+width+',height='+height);
      return popupElement;
    },
    /**
     * will check if the value is not empty or null
     * @param value
     * @return boolean
     * @constructor
     */
    IsValueEmpty: function(value) {
      return !(value == null || _.str.trim(value) == '');
    },
    /**
     * check if job data valid
     */
    IsValidJobData: function () {
      var _this = this;
      var cookieWorkingJobId = $.cookie("Using_Job");
      if (!_this.IsValueEmpty(cookieWorkingJobId))
        return true;
      return false;
    },
    /**
     * will save job data
     * @param int workingJobId job id
     * @param boolean override     if set true cookie will override
     */
    SaveJobData: function (workingJobId,override) {
      var _this = this;
      var cookieWorkingJobId = $.cookie("Using_Job");
      try {
        if (!_this.IsValueEmpty(workingJobId)) 
        {
          if (override && parseInt(workingJobId) != 0  && parseInt(workingJobId) != -1)
            $.cookie("Using_Job",override, { expires: 7 });
          else {
            if (_this.IsValueEmpty(cookieWorkingJobId) && parseInt(workingJobId) != 0 && parseInt(workingJobId) != -1) 
              $.cookie("Using_Job",override, { expires: 7 });
          }
        }
      }
      catch(e) {}
    },
    /**
     * check if the page type are within what existed in list
     * @param int selectedPageType the selected page type
     */
    IsMatchExistedPageType: function (selectedPageType) {
      var returnValue = false;
      _.each(StoreFrontObjectViewType,function (item) {
        if (item == selectedPageType)
          returnValue = true;
      });
      return returnValue;
    },
    /**
     * will display Error Message
     * @param {stirng} title error title text
     * @param {string} message error message text
     */
    ShowErrorMessage: function (title,message) {
      var _this = this;
      $('.errorLoginDialog').find(".alert").empty();
      var errorTitle = "<h1>%s</h1>";
      var errorMessage = "<p>%s</p>";
      var bufferOptions = "";
      bufferOptions +=  _.str.sprintf(errorTitle,title);
      bufferOptions +=  _.str.sprintf(errorMessage,message);
      $('.errorLoginDialog').find(".alert").append(bufferOptions);
    }
  }
});