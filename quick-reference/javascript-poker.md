
var Hand = {
    FULL_HOUSE: 'Full House',
    FLUSH: 'Flush',
    STRAIGHT: 'Straight',
    THREE_OF_A_KIND: 'Three of a kind.',
    TWO_PAIR: 'Two pair',
    PAIR: 'Pair',
};

var Suit = {
    HEART: 'Heart',
    DIAMOND: 'Diamond',
    SPADE: 'Spade',
    CLUB: 'Club'
};
    
var tests = [
    {
        cards: [
            {value: 1, suit: Suit.SPADE},
            {value: 1, suit: Suit.HEART},
            {value: 3, suit: Suit.DIAMOND},
            {value: 4, suit: Suit.DIAMOND},
            {value: 7, suit: Suit.DIAMOND}
        ],
        hand:  Hand.PAIR,
    }
];

function isFullHouse() {
}

function isFlush() {
}

function isStraight() {
}

function isthreeofakind() {
}

function isTwoPair() {
    
}

function check() {
}

function getHand(cards) {
    if (isFullHouse(cards)) {
        return Hand.FULL_HOUSE;
    } else if (isFlush()) {
        return Hand.FULL_HOUSE;
    }
    return null;
}

function runTests() {

    tests.forEach(function (test, i) {
        console.log('test: ' + i + ' returned ' + (getHand(test.cards) === test.hand ? test.hand : ' ERROR')); 
    });
}


//runTests();


var a = [];

function Game(length, width) {
    /** @type {Array.<Array.<number>} */
    this.board = [];
    this.init(length, width);
}

Game.prototype.init = function (length, width) {
    for (var i = 0; i < width; i++) {
        var row = [];
        for (var j = 0; j < length; j++) {
            console.log(i + ' ' + j);
            row.push(0);
        }
        this.board.push(row);
    }
};

Game.prototype.analyze = function (fn) {
    this.board.forEach(function (row, i) {
        row.forEach(function (col, j) {
            fn(board, i, j);
            
        });
    });
};


function runGame() {
    var game = new Game(4,4);
}

runGame();




