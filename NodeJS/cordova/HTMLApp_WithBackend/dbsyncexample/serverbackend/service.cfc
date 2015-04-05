component {
	
	remote array function getupdates(date) {
		writelog(file="application", text="date to check is #arguments.date#");
		var hql = "from helpdocument";
		var params = {};
		if(arguments.date != '') {
			hql &= " where lastupdated > :date";
			params.date = arguments.date;
		}
		hql &= " order by lastupdated asc";
		var ormresults = ormExecuteQuery(hql, params);
		var results = [];
		for(var i=1; i<=arrayLen(ormresults);i++) {
			arrayAppend(results, {"title"=ormresults[i].getTitle(),
								  "body"=ormresults[i].getBody(),
								  "lastupdated"=ormresults[i].getLastUpdated(),
								  "deleted"=ormresults[i].getDeleted(),
								  "token"=ormresults[i].getToken()});
		}
		writelog(file="application", text="total results is #arraylen(results)#");
		return results;
	}
}