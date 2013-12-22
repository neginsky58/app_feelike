define([
  'backbone',
  'Logger',
  'Moment',
  '/assets/jquery.cookie',
  '/assets/fullcalendar.min',
  '/assets/jquery.dataTables.min',
  '/assets/jquery.chosen.min',
  '/assets/jquery.uniform.min',
  '/assets/jquery.colorbox.min',
  '/assets/jquery.cleditor.min',
  '/assets/jquery.noty',
  '/assets/jquery.elfinder.min',
  '/assets/jquery.raty',
  '/assets/jquery.iphone.toggle',
  '/assets/jquery.autogrow-textarea',
  '/assets/jquery.history',
  //'/assets/charisma',
  'lib/Backoffice/main',
  'lib/Backoffice/Configuration',
  //'lib/Vaildatetors/Validateor',
  'lib/Utills/Timer',
  'lib/Utills/Utills',
  'lib/Network/Network',
  'lib/Controls/Preloader',
  'lib/Backoffice/Pages/Login',
  'lib/Backoffice/Pages/Main',
  'lib/Backoffice/Events/Main',
  'lib/Backoffice/Events/Users'
 ], function(Backbone) {
  return {
    Instance:  BackofficeObject.getInstance()
  };
});