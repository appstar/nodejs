//NodeJS From Lynda - Exercise Files > Chap02>02>start
var whisper = function(message){
	console.log('Proclaiming: '+message);
};

exports.softly=whisper;
exports.loudly=function(message){
	console.log('Proclaiming: '+message);
};