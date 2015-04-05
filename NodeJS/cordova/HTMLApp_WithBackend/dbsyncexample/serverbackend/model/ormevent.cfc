component implements="CFIDE.orm.IEventHandler" {
	
	public void function preInsert(any entity) {
		entity.setLastUpdated(now());
	}

	public void function preUpdate(any entity,struct oldData) {
		entity.setLastUpdated(now());
	}

	public void function preLoad(any entity) {};
	
	public void function postLoad(any entity) {};

	public void function postInsert(any entity) {};
    
    public void function postUpdate(any entity) {};
	
    public void function preDelete(any entity) {};
	
    public void function postDelete(any entity) {};	

}