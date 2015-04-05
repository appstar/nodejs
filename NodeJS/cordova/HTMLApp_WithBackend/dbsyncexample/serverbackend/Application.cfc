component {

	this.name="phonegapdbsyncdemo";
	this.datasource="phonegapdbsync";
	this.ormenabled=true;
	this.mappings["/model"] = expandPath("./model");
	this.ormsettings = {
		dbcreate="update",
		eventHandler="model.ormevent",
		skipCFCWithErrors=false,
		cfclocation=expandPath("./model")
	};


	public boolean function onRequestStart(required string req) {
		if(structKeyExists(url, "init")) {
			ormReload();
			applicationStop();
			location(url="index.cfm",addToken=false);
		}
		return true;
	}
}