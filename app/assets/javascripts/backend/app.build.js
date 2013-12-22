({
    baseUrl: "./",
    //Comment out the optimize line if you want
    //the code minified by UglifyJS
    //optimize: "none",
    //The directory path to save the output. If not specified, then
    //the path will default to be a directory called "build" as a sibling
    //to the build file. All relative paths are relative to the build file.
    //dir: "../Build/js/",

    //As of RequireJS 2.0.2, the dir above will be deleted before the
    //build starts again. If you have a big build and are not doing
    //source transforms with onBuildRead/onBuildWrite, then you can
    //set keepBuildDir to true to keep the previous dir. This allows for
    //faster rebuilds, but it could lead to unexpected errors if the
    //built code is transformed in some way.
    keepBuildDir: true,
    mainConfigFile: './main.js',
    //How to optimize all the JS files in the build output directory.
    //Right now only the following values
    //are supported:
    //- "uglify": (default) uses UglifyJS to minify the code.
    //- "none": no minification will be done.
    optimize: "uglify",
    //If using UglifyJS for script optimization, these config options can be
    //used to pass configuration values to UglifyJS.
    //See https://github.com/mishoo/UglifyJS for the possible values.
    uglify: {
        toplevel: true,
        ascii_only: true,
        beautify: false,
        max_line_length: 1000
    },


    //Inlines the text for any text! dependencies, to avoid the separate
    //async XMLHttpRequest calls to load those dependencies.
    inlineText: true,

    //Allow "use strict"; be included in the RequireJS files.
    //Default is false because there are not many browsers that can properly
    //process and give errors on code for ES5 strict mode,
    //and there is a lot of legacy code that will not work in strict mode.
    useStrict: false,


    //Allows namespacing requirejs, require and define calls to a new name.
    //This allows stronger assurances of getting a module space that will
    //not interfere with others using a define/require AMD-based module
    //system. The example below will rename define() calls to foo.define().
    //See http://requirejs.org/docs/faq-advanced.html#rename for a more
    //complete example.
    //namespace: 'foo',

    //Skip processing for pragmas.
    skipPragmas: false,

    //If skipModuleInsertion is false, then files that do not use define()
    //to define modules will get a define() placeholder inserted for them.
    //Also, require.pause/resume calls will be inserted.
    //Set it to true to avoid this. This is useful if you are building code that
    //does not use require() in the built project or in the JS files, but you
    //still want to use the optimization tool from RequireJS to concatenate modules
    //together.
    skipModuleInsertion: false,
    //If it is not a one file optimization, scan through all .js files in the
    //output directory for any plugin resource dependencies, and if the plugin
    //supports optimizing them as separate files, optimize them. Can be a
    //slower optimization. Only use if there are some plugins that use things
    //like XMLHttpRequest that do not work across domains, but the built code
    //will be placed on another domain.
    optimizeAllPluginResources: true,

    //Finds require() dependencies inside a require() or define call. By default
    //this value is false, because those resources should be considered dynamic/runtime
    //calls. However, for some optimization scenarios,
    //Introduced in 1.0.3. Previous versions incorrectly found the nested calls
    //by default.
    findNestedDependencies: true,

    //If you only intend to optimize a module (and its dependencies), with
    //a single file as the output, you can specify the module options inline,
    //instead of using the 'modules' section above. 'exclude',
    //'excludeShallow', 'include' and 'insertRequire' are all allowed as siblings
    //to name. The name of the optimized file is specified by 'out'.
    name: "main",
    out: "../Build/js/optimized-file-backoffice-30.10.2012.js",


    //By default, comments that have a license in them are preserved in the
    //output. However, for a larger built files there could be a lot of
    //comment files that may be better served by having a smaller comment
    //at the top of the file that points to the list of all the licenses.
    //This option will turn off the auto-preservation, but you will need
    //work out how best to surface the license information.
    preserveLicenseComments: false,

    wrap: {
        start: "(function() {",
        end: "}());"
    },
    //Sets the logging level. It is a number. If you want "silent" running,
    //set logLevel to 4. From the logger.js file:
    //TRACE: 0,
    //INFO: 1,
    //WARN: 2,
    //ERROR: 3,
    //SILENT: 4
    //Default is 0.
    logLevel: 0,
})