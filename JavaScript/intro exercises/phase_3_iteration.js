// Array#bubbleSort
Array.prototype.bubbleSort = function () {
    let isSorted = false;

    while (!isSorted) {
      isSorted = true;
  
      for (let i = 0; i < (this.length - 1); i++) {
        if (this[i] > this[i + 1]) {
          // a crafty bit of array destructuring to avoid a temp variable
          [this[i], this[i + 1]] = [this[i + 1], this[i]];
          isSorted = false;
        }
      }
    }
  
    return this;
};  

[1,4,3,9,2].bubbleSort();

//String#substrings
String.prototype.substrings = function(){
    let subs = [];

    // better
    for(let start = 0; start < this.length; start++){
        for(let end = start + 1; end <= this.length; end++)
            subs.push(this.slice(start, end))
    }
    return subs;
}

"ayyooyaa".substrings();