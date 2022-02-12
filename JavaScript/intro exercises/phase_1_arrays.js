// Array#uniq
Array.prototype.uniq = function() {
    let ans = [];
    this.forEach(function(ele){
        if(!ans.includes(ele))
            ans.push(ele)
    });
    return ans;
};

//Array#twoSum
Array.prototype.twoSum = function() {
    const pairs = [];
  
    for (let i = 0; i < this.length; i++) {
      for (let j = (i + 1); j < this.length; j++) {
        if (this[i] + this[j] === 0) {
          pairs.push([i, j]);
        }
      }
    }
  
    return pairs;
};


// reduce to O(N)
Array.prototype.twoSum = function() {
    let pairs = [];
    const indexHash = {};     // hash of: {element:  array of its indices}
    this.forEach((ele, eIdx) => {
        if(indexHash[-1 * ele]){
            let newPairs = indexHash[-1 * ele].map((counterIdx) => [counterIdx, eIdx]);
            pairs.push(newPairs)
        }
        indexHash[ele] ? indexHash[ele].push(eIdx) : indexHash[ele] = [eIdx]; 
    })
  
    return pairs;
};

[1, -1, 1, 0, 2].twoSum()

//Array#transpose
Array.prototype.transpose = function(){
    const tr = Array.from(
        {length: this.length},
        () => Array.from({length: this.length}));

    for(let i = 0; i < this.length; i++){
        for(let j = 0; j < this.length; j++){
            tr[i][j] = this[j][i];
        }
    }
    return tr;
}

arr = [[1,2,3], [5,6,7], [68,54,3]];
arr.transpose();
