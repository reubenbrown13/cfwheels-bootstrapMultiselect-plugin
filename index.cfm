<h1>Bootstrap Multiselect integration</h1>
<p>this creates a hasManySelect() function and over-rides the formValue() function that is standard in cfwheels.</p>
<h2>Setup</h2>
<p>Depends on Bootstrap 4, jQuery, and popper.js to be loaded.<br />
Popper.js is currently loaded in this plugin using a CDN.<br />
jQuery on the default cfWheels site might be loaded at the bottom of the page and it needs to be moved to the head.  Check your /views/layout.cfm to confirm this.</p>
<h2>Usage</h2>
<p>This automatically takes effect.  To use the feature, call the hasManySelect() function in your pages/forms.<br />
EX : ##hasManySelect(objectName="post", property="postCategory", multiple="multiple", options=model("category").findAll(), valueField="id", textField="name", label=local.Label)##
</p>
<h2>Support</h2>
