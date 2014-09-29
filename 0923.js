var _ = require('underscore');
var prop = [0.7, 0.3, 0.4, 0.6];

// Number.prototype.next = function() {
// 	return 5;
// }

function Num(val) {
	this.val = val;
}

Num.prototype.next = function() {
	var val = this.val;

	var p0 = [0.7, 0.4];

	if (Math.random() < p0[val]) {
		return new Num(0);
	} else {
		return new Num(1);

	}
};



function getProp(init, max) {
	var n = new Num(init);
	// console.log(n.next().val);
	// var max = 10000;

	var result = [];
	for (var i = 0; i < max; i++) {
		n = n.next();
		result.push(n.val);
	}

	return _.countBy(result, function(num) {
		return num == 0 ? 'zero' : 'one';
	});

}

var a = getProp(0, 1000);
console.log(a["one"] / 1000);


function mutipleChain(init, max, channelAmount) {
	var channel = [];
	for (var i = 0; i < chainAmount; i++) {
		channel.push( getProp(init, max) );
	}
}

// console.log(Math.random());