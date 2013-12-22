define([
    'backbone'
],  function(Backbone){
    Workers = {};
    /**
     * Will management the Timer object.
     * its run every 1 secand none stop its active thu the workers poll
     * @type TimerManagement
     */
    TimerManagement = {
        timeIns: null,
        works: [],
        /**
         * will start the timer management
         * @constructor
         */
        Init: function () {
            var based = this;
            based.timeIns = setInterval(function () {
                based.Run();
            },1000);
        },
        /**
         * Add work into the timers polls
         * @param worker object
         * @param worker name
         */
        AddWorker: function (workIns,name) {
            var based = this;
            if (workIns!= null) {
                var obj ={
                    Worker: workIns,
                    Name: name
                };
                workIns.OnStart();//will cal the start on the work
                based.works.push(obj);
            }
        },
        /**
         * will remove the work  based his worker name and remove at from poll
         * @param work name
         */
        RemoveWorker: function (name) {
            var locateObject = _.find(based.works,function (row) { return (row.Name == name);});
            locateObject.OnStop();//will call stop of this work
            var worksObjects = _.filter(based.works,function (row) { return (row.Name == name);});
            based.works = worksObjects;
        },
        /**
         * trigger every 1 second and trigger at all his works poll the DoRun
         */
        Run: function (){
            var based = this;
            _.each(based.works , function (item) {
                item.Worker.DoRun();
            });
        }
    }
});