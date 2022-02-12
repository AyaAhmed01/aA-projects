// Array#myEach(callback)
Array.prototype.myEach = function(callback){
    for(let i = 0; i < this.length; i++){
        callback(this[i])
    }
};

// Array#myMap(callback)
Array.prototype.myMap = function(callback){
    let ans = [];
    this.myEach((e) => {ans.push(callback(e))})
    return ans;
}

[1,2,3].myMap((e) => e + 2);

// Array#myReduce----
Array.prototype.myReduce = function(callback, init){
    arr = this;
    if(init === undefined){
        init = this[0];
        arr = this.slice(1);   // if I take the first ele as acc, start accumlating from second ele
    }

    arr.myEach((ele) => {
        init = callback(init, ele);
    })
    return init;
}

[1, 2, 3].myReduce(function(acc, el) {
    return acc + el;
  }); // => 6
  
  // with initialValue
  [1, 2, 3].myReduce(function(acc, el) {
    return acc + el;
  }, 25); // => 31

