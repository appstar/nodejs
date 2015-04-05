<cfif structKeyExists(url, "id")>
	<cfset doc = entityLoadByPk("helpdocument", url.id)>
	<cfif isNull(doc)>
		<cflocation url="index.cfm" addToken="false">
	</cfif>
	<cfparam name="form.title" default="#doc.getTitle()#">
	<cfparam name="form.body" default="#doc.getBody()#">
	<cfparam name="form.deleted" default="#doc.getDeleted()#">
</cfif>

<cfif structKeyExists(form, "submit")>
	<!--- to do, validation later --->
	<cfif structKeyExists(form, "id")>
		<cfset doc = entityLoadByPk("helpdocument", form.id)>		
	<cfelse>
		<cfset doc = entityNew("helpdocument")>
		<cfset doc.setToken(createUUID())>
	</cfif>

	<cfset doc.setTitle(form.title)>
	<cfset doc.setBody(form.body)>
	<cfset doc.setDeleted(form.deleted)>
	<cfset entitySave(doc)>
	<cflocation url="index.cfm" addToken="false">

</cfif>

<cfparam name="form.title" default="">
<cfparam name="form.body" default="">
<cfparam name="form.deleted" default="false">


<cf_layout>

	<h1>Edit Doc</h1>

	<cfoutput>
	<form class="form-horizontal" method="post" action="edit.cfm">
		<cfif structKeyExists(url, "id")>
			<input type="hidden" name="id" value="#url.id#">
		</cfif>
		<div class="control-group">
		<label class="control-label" for="title">Title</label>
		<div class="controls">
			<input type="text" id="title" name="title" class="input-xlarge" value="#form.title#">
		</div>
		</div>
		<div class="control-group">
		<label class="control-label" for="body">Body</label>
		<div class="controls">
			<textarea id="body" name="body" class="input-xlarge">#form.body#</textarea>
		</div>
		</div>
		<div class="control-group">
		<label class="control-label" for="deleted">Deleted</label>
		<div class="controls">
			<select id="deleted" name="deleted">
				<option value="false" <cfif not form.deleted>selected</cfif>>No</option>
				<option value="true" <cfif form.deleted>selected</cfif>>Yes</option>				
			</select>
		</div>
		</div>
		<div class="form-actions">
            <button type="submit" class="btn btn-primary" name="submit">Save changes</button>
            <a href="index.cfm" class="btn">Cancel</a>
        </div>
	</form>
	</cfoutput>

</cf_layout>