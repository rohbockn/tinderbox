# Writing a custom vizualization in JS and deploying to Splunk

- Splunks official tutorial: http://docs.splunk.com/Documentation/Splunk/6.5.0/AdvancedDev/CustomVizTutorial

## Tutorial outline:

### Create the visualization logic:
1. Set up the viz source code
   - visualization_source.js overrides two fns in SplunkVisualizationBase: updateView and getInitialDataParams
2. Add the updateView function

### Add CSS

### Add Configuration Settings
1. Register the visualization
2. Export the visualization

### Try out the visualization
1. Rebuild the visualization
2. Error Handling

#### Handle Data Format Errors
1. Override formatData
2. Best practices for data validation and handling
3. Change rendering on data format errors

### Add user configurable properties
1. Property namespacing
2. Property naming
3. Declare property information
4. Handle property settings

### Implement a format menu
1. Define the format menu
2. Working with formatter.html

## Implementation details from first plotly custom viz:

### npm

When using npm, there are a few key commands to remember:

1. npm install: run when changes are made to the package.json file as npm watch won't catch that because it's downloading new dependencies.  ?The same could be said for webpack.config.js?
2. npm run build: run right after npm install *if* you dont have npm watch running in a separate terminal
3. npm run watch: run this to avoid

make sure that you have chrome set to clear the cache on reload when in dev mode (makes it so that you don't have to restart local splunk for changes to the visualization_source.js)

#### Dependencies
- plotly (plotly-latest.min) and lodash are both src'd in the script.  Instead of running
```
npm install --save lodash
npm install --save plotly
```
, instead go to the packages.json file and enter your dependencies there as a key:value pair in the value with the dependencies key (e.g. "plotly.js": "1.38.0").  Then, when you run ```npm run build```, npm will inline the compiled code(? I think that's the phrase) so that it isn't importing from node_modules at runtime.

- DON'T forget to set AND export the SPLUNK_HOME variable.  Consider adding this to your .bashrc file.

- Don't put your app under app_templates, but under $SPLUNK_HOME/etc/apps

- Along width the web.conf changes to make it so that splunk doesn't have to be reset each time there's an update, in chrome developer tools, there should be a setting to ignore cache while in developer mode, set to true
   - When you go to etc/system/local looking for web.conf, it might not be there, simply create the file.

- Run '''npm run watch''' and each time your source is changed, npm will attempt to rebuild

### Integrating the JavaScript code into Splunk

When adding functions to SplunkVisualizationBase, the first additions should be:
```
getInitialDataParams: function () {
        return ({
            outputMode: SplunkVisualizationBase.RAW_OUTPUT_MODE,
            count: 10000 // limits the amount of data passed
        });
    }, // this addition is what passes the data to the visualization

initialize: function () {
    SplunkVisualizationBase.prototype.initialize.apply(this, arguments);
    this.id = _.uniqueId('standin');
    this.$el = $(this.el);
    this.$el.append('<div id="' + this.id + '" class="splunk-standin"></div>'); // this creates the html div object to draw the plot in
},

formatData: function (data) {
    if (!data || !data.meta) {
        return
    }
    return data.results;
},
_getEscapedProperty: function (name, config) {
    var propertyValue = config[this.getPropertyNamespaceInfo().propertyNamespace + name];
    return vizUtils.escapeHtml(propertyValue);
},
```
where your desired viz name may be substituted for 'standin'

- Note, the initialize function creates the html div object and names it!

Now, instead of executing the plot as in poc.html, we use the following code:
```
var plot_div = this.$el.children('.splunk-standin')[0];
Plotly.newPlot(plot_div, charts, layout, plotly_config);
```

### Formatting

Formatting is configured/setup from three file groups:
1. the ```formatter.html``` file,
2. the `visualization_source.js` file   When the format link is selected in the splunk visualization window, attribute classes are,
3. and the $SPLUNK_HOME/etc/apps/README/savedsearches.conf.spec *AND* $SPLUNK_HOME/etc/apps/default/savedsearches.conf files.

In the Splunk UI itself, the formatting abilities are organized into sections selectable from the left margin of the format dialogue box (e.g. axes, legend, etc.).  To create a new one of these use the below form in the `formatter.html` file:
```
<form class="splunk-formatter-section" section-label="format">
    <!-- Add html here to create formatter options -->
    <p>No Options.</p>
</form>
```
In the above form, the class argument as shown communicates to splunk that you want a new section in the formatting tab, and the section-label will identify that.  Within the form, the notes and no options text may be replaced with blocks of code (splunk-control-group) defining variables and ways to assign values to those vars, e.g.
```
<splunk-control-group label="X Axis Field">
    <splunk-text-input name="{{VIZ_NAMESPACE}}.xaxis_field"></splunk-text-input>
</splunk-control-group>
```
Note the input type is `splunk-text-input` and the name parameter uses the convention of `"{{VIZ_NAMESPACE}}.var_name"`.  Here, `var_name` can be retrieved for use in the visualization script by using the following js:
`var var_name = this._getEscapedProperty('var_name', config);`

In the `savedsearches.conf` file you define the default formatting parameters:
```
[default]
display.visualizations.custom.my_app.viz_dir_name.tooltips=
display.visualizations.custom.my_app.viz_dir_name.y_axis_color=#000000
...
```
where `X` is found in the path to the visualization: `$SPLUNK_HOME/etc/apps/my_package/appserver/static/visualizations/X/...`.  Note, nothing following the `=` is like a None.

#### Important notes on formatting:

- Anytime the formatter.html file is altered, be sure to restart splunk!

### Deploy:

1. CD into the app directory, run the package.sh file, which outputs your <app>.spl file one directory level up from the app directory
2. Go into production Splunk, click on the cog at the top of the left margin containing the apps
3. Click 'Install App from File'
4. Select the <app>.spl file and upload

Other things that should be done:
- Create a .png for the visualization.  Store this int the <app>/appserver/static/visualizations/<viz>

Note:
- If you are updating an existing app, but sure to check the update box when selecting <app>.spl.
