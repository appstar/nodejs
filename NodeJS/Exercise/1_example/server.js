//NodeJS From Lynda - server example - Exercise Files > Chap02>03>

var http=require('http');
var handleRequest=function(req, res){
	res.writeHead(200, {'Content-Type':'text/plain'});
	res.end('Welcome to my Node Server\n');
};
var server=http.createServer(handleRequest);
server.listen(3000, 'localhost');