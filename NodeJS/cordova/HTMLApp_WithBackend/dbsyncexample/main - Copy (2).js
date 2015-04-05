function init() {
    document.addEventListener("deviceready",startup);
    startup();
}

var db;
var updateurl = "http://localhost/testingzone/dbsyncexample/serverbackend/service.cfc?method=getupdates&returnformat=json";

function dbError(e) {
    console.log("SQL ERROR");
    console.dir(e);
}

function startup() {
    console.log("Starting up...");
    db = window.openDatabase("main","1","Main DB",1000000);
    db.transaction(initDB,dbError,dbReady);
}

function initDB(tx) {
    //tx.executeSql("drop table docs");
    tx.executeSql("create table if not exists docs(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, lastupdated DATE, token TEXT)");
}

function dbReady() {
    console.log("DB initialization done.");
    //begin sync process
    syncDB();
}

function syncDB() {
    /**
    * Process is: What is my latest doc? if any
    * Ask server for changes since then
    */
    db.transaction(function(tx) {
        tx.executeSql("select max(lastupdated) as lastdate from docs", [], function(tx,res) {
            console.log("Will get items after "+res.rows.item(0).lastdate);
            var date = res.rows.item(0).lastdate?res.rows.item(0).lastdate:'';
            $.get(updateurl, {date:date}, function(resp,code) {
                console.log("back from getting updates with "+resp.length + " items to process.");
                //Ok, loop through. For each one, we see if it exists, and if so, we update/delete it
                //If it doesn't exist, straight insert
                resp.forEach(function(ob) {
                    console.dir(ob);
                    db.transaction(function(ctx) {
                        ctx.executeSql("select id from docs where token = ?", [ob.token], function(tx,checkres) {
                            if(checkres.rows.length) {
                                console.log("possible update/delete");
                                if(!ob.deleted) {
                                    console.log("updating "+ob.title+ " "+ob.lastupdated);
                                    tx.executeSql("update docs set title=?,body=?,lastupdated=? where token=?", [ob.title,ob.body,ob.lastupdated,ob.token]);
                                } else {
                                    console.log("deleting "+ob.title+ " "+ob.lastupdated);
                                    tx.executeSql("delete from docs where token = ?", [ob.token]);
                                }
                            } else {
                                //only insert if not deleted
                                console.log("possible insert");
                                if(!ob.deleted) {
                                    console.log("inserting "+ob.title+ " "+ob.lastupdated);
                                    tx.executeSql("insert into docs(title,body,lastupdated,token) values(?,?,?,?)", [ob.title,ob.body,ob.lastupdated,ob.token]);
                                }
                            }

                        });
                    });
                });
                
            },"json");
        });

    }, dbError, function() {
        console.log("I'm done with the transaction");
    });
}