const a = [
    {name: 'foo', value: 1},
    {name: 'foo', value: 1},
    //{name: 'bar', value: 2}
];

function total(prev, current) {
    return prev.value + current.value;
}

function sameValue(a, b) {
    return a.value === b.value ? true : false; 
}
//console.log('total: ' + a.reduce(total));
console.log('unique: ' + a.reduce(sameValue));


console.log('hello'.split('').reduce(function (acc, val) {
    if (val === 'l') {
        acc++;
    }
    return acc;
}, 0));

