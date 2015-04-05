<cfset docs = entityLoad("helpdocument")>

<cf_layout>

      <h1>Current Docs</h1>

      <cfif arrayLen(docs)>
		<table class="table table-bordered table-striped">
			<thead>
			<tr>
				<th>Title</th>
				<th>Deleted</th>
				<th>Updated</th>
			</tr>
			</thead>
			<tbody>
				<cfloop index="doc" array="#docs#">
					<cfoutput>
						<tr>
							<td><a href="edit.cfm?id=#doc.getId()#" title="Edit this doc">#doc.getTitle()#</a></td>
							<td>#doc.getDeleted()?"Yes":"No"#</td>
							<td>#doc.getLastUpdated()#</td>
						</tr>
					</cfoutput>
				</cfloop>
			</tbody>
		</table>
      <cfelse>
      	<p>
      		Sorry, no content yet.
      	</p>
      </cfif>

      <a href="edit.cfm" class="btn btn-primary">Add Content</a>

</cf_layout>