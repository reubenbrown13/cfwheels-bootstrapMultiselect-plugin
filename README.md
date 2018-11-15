# cfwheels-bootstrapMultiselect-plugin
plugin to create hasManySelect() function so you can both select and display selected values in a multiple select box.

Took the basic code for the select() function and added the required parts to allow for the display and selection of multiple options.

EX : hasManySelect(objectName="post", property="postCategory", multiple="multiple", options=model("category").findAll(), valueField="id", textField="name", label=local.Label)

Depends on Bootstrap 4, jQuery, and popper.js to be loaded.
Popper.js is currently loaded in this plugin using a CDN.
jQuery on the default cfWheels site might be loaded at the bottom of the page and it needs to be moved to the head.  Check your /views/layout.cfm to confirm this.
