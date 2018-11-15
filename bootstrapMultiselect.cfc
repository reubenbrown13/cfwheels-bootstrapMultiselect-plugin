component displayname="bootstrapMultiselect" output="false" author="Reuben Brown" support="reubenbrown13@gmail.com" {

	public function init(){
		this.version = "2.0";
		return this;
	}

	/**
	 * Builds and returns a string containing a select form control based on the supplied objectName and property.
	 * Note: Pass any additional arguments like class, rel, and id, and the generated tag will also include those values as HTML attributes.
	 *
	 * [section: View Helpers]
	 * [category: Form Object Functions]
	 *
	 * @objectName [see:textField].
	 * @property [see:textField].
	 * @association [see:textField].
	 * @position [see:textField].
	 * @options A collection to populate the select form control with. Can be a query recordset or an array of objects.
	 * @includeBlank Whether to include a blank option in the select form control. Pass true to include a blank line or a string that should represent what display text should appear for the empty value (for example, "- Select One -").
	 * @valueField The column or property to use for the value of each list element. Used only when a query or array of objects has been supplied in the options argument.  Required when specifying `textField`
	 * @textField The column or property to use for the value of each list element that the end user will see. Used only when a query or array of objects has been supplied in the options argument. Required when specifying `valueField`
	 * @label [see:textField].
	 * @labelPlacement [see:textField].
	 * @prepend [see:textField].
	 * @append [see:textField].
	 * @prependToLabel [see:textField].
	 * @appendToLabel [see:textField].
	 * @errorElement [see:textField].
	 * @errorClass [see:textField].
	 * @encode [see:styleSheetLinkTag].
	 */
	public string function hasManySelect(
		required any objectName,
		required string property,
		string association,
		string position,
		any options,
		any includeBlank,
		string valueField,
		string textField,
		string label,
		string labelPlacement,
		string prepend,
		string append,
		string prependToLabel,
		string appendToLabel,
		string errorElement,
		string errorClass,
		any encode
	) {
		$args(name="select", reserved="name", args=arguments);
		arguments.objectName = $objectName(argumentCollection=arguments);
		if (!StructKeyExists(arguments, "id")) {
			arguments.id = $tagId(arguments.objectName, arguments.property);
		}
		local.before = $formBeforeElement(argumentCollection=arguments);
		local.after = $formAfterElement(argumentCollection=arguments);
		arguments.name = $tagName(arguments.objectName, arguments.property);
		if (StructKeyExists(arguments, "multiple") && IsBoolean(arguments.multiple)) {
			if (arguments.multiple) {
				arguments.multiple = "multiple";
			} else {
				StructDelete(arguments, "multiple");
			}
		}
		local.content = $optionsForSelect(argumentCollection=arguments);
		if (!IsBoolean(arguments.includeBlank) || arguments.includeBlank) {
			if (!IsBoolean(arguments.includeBlank)) {
				local.blankOptionText = arguments.includeBlank;
			} else {
				local.blankOptionText = "";
			}
			local.blankOptionAttributes = {value=""};
			local.content = $element(name="option", content=local.blankOptionText, attributes=local.blankOptionAttributes, encode=arguments.encode) & local.content;
		}
		local.encode = IsBoolean(arguments.encode) && !arguments.encode ? false : "attributes";
		cfhtmlhead( text= '<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.5/umd/popper.min.js"></script>
#javaScriptIncludeTag("/plugins/bootstrapMultiselect/javascripts/bootstrap-multiselect.js")#
#styleSheetLinkTag("/plugins/bootstrapMultiselect/stylesheets/bootstrap-multiselect.css")#' );
		local.before = "
<script type='text/javascript'>
$(document).ready(function() {
  $('###objectName#-#property#').multiselect();
});
</script>
" & local.before;
		return local.before & $element(name="select", skip="objectName,property,options,includeBlank,valueField,textField,label,labelPlacement,prepend,append,prependToLabel,appendToLabel,errorElement,errorClass,association,position,encode", skipStartingWith="label", content=local.content, attributes=arguments, encode=local.encode) & local.after;
	}

	/**
	 * Over-rides internal function to allow for multiple option to work.
	 */
	public string function $formValue(required any objectName, required string property) {
		if (IsStruct(arguments.objectName)) {
			local.rv = arguments.objectName[arguments.property];
		} else {
			local.object = $getObject(arguments.objectName);
			if ($get("showErrorInformation") && !IsObject(local.object)) {
				Throw(type="Wheels.IncorrectArguments", message="The `#arguments.objectName#` variable is not an object.");
			}
			if (StructKeyExists(local.object, arguments.property)) {
				if ( isArray( local.object[arguments.property] ) ) {
					// converts array of values to string.
					if ( arrayLen( local.object[arguments.property] ) GT 0 AND isStruct( local.object[arguments.property][1] ) ) {
						local.fkColName = singularize( ReplaceNoCase(local.object[arguments.property][1].tableName(), singularize( local.object.tableName() ), "" ) ) & "id";
						local.rv = "";
						for ( prop IN local.object[arguments.property] ) {
							if ( structKeyExists(prop, local.fkColName) ) {
								local.rv = ListAppend( local.rv, prop[local.fkColName] );
							}
						}
					} else {
						local.rv = ArrayToList( local.object[arguments.property] );
					}
				} else {
					local.rv = local.object[arguments.property];
				}
			} else {
				local.rv = "";
			}
		}
		return local.rv;
	}

}
