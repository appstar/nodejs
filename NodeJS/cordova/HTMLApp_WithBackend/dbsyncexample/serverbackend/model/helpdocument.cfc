component persistent="true" extends="model.base"  {

	property name="id" fieldtype="id" generator="native";
	property name="title" ormtype="string";
	property name="body" ormtype="string";
	property name="token" ormtype="string";
	property name="deleted" ormtype="boolean";

	function getDeleted() {
		if(isNull(variables.deleted)) return false;
		return variables.deleted;
	}
}