function range(st, ed){
    if(st == ed)
        return [st];
    return [st].concat(range(st + 1, ed));
}
range(2,8)

function sumRec(arr){
    if(arr.length == 1)
        return arr[0];
    return arr[0] + sumRec(arr.slice(1));
}
sumRec([4,5,2])

function exponent1(base, exp){  // O(n)
    if(exp == 0)
        return 1;
    return base * exponent1(base, exp - 1);
}

function exponent2(base, exp){  // O(log(n))
    if(exp == 0)
        return 1;
    let halfPow = exponent2(base, Math.floor(exp/2));
    if(exp % 2){
        return base * (halfPow ** 2)
    }
    return halfPow ** 2
}

function fibonacci(n){ // 1 1 2 3 5
    if(n == 1)
        return [1]
    if(n == 2)
        return [1, 1]
    let fibo = fibonacci(n - 1);
    let newE = fibo[n-2] + fibo[n-3];  // last two elements in fibo
    return fibo.concat([newE])
}

// referencing here is like any other language: 
// arr = [1,2,3,4], a = arr
// arr[0] = 44  => a = [44, 2, 3, 4]
// NEEDS deepDup
function deepDup(arr){  // [[3,5], 6, [2,8]]
    if(!(arr instanceof Array))
        return arr;
    return arr.map((el) => deepDup(el));
    }
deepDup( [[3,4,3], 6, [2,8]]);


function bsearch(arr, target){
    if(arr.length === 0)
        return -1;
    mid = Math.floor(arr.length / 2);
    if(arr[mid] === target)
        return mid;
    return Math.max(bsearch(arr.slice(0, mid), target),
      bsearch(arr.slice(mid+1, arr.length), target))
}
bsearch([3,4,6,7], 8)

function merge(left, right){
    let res = [];
    while(left.length && right.length){
        if(left[0] < right[0])
            res.push(left.shift());
        else
            res.push(right.shift());
    }

    return res.concat(left, right);
}

function mergesort(arr){
    if(arr.length <= 1)
        return arr;
    const mid = Math.floor(arr.length / 2);   // NOOOTE: making mid/ left.. global (aka. mid = ...) give WEIRD errors
    const left = mergesort(arr.slice(0, mid));
    const right = mergesort(arr.slice(mid)) 
    return merge(left, right);
}
mergesort([3,1,4,5,2,0])


// subsets
function subsets(array) {
    if (array.length === 0) {
      return [[]];
    }
  
    const first = array[0];
    const withoutFirst = subsets(array.slice(1));
    // remember, we don't want to mutate the subsets without the first element
    // hence, the 'concat'
    const withFirst = withoutFirst.map(sub => [first].concat(sub) );
  
    return withoutFirst.concat(withFirst);
  }
  
  console.log(`subsets([1, 3, 5]) = ${JSON.stringify(subsets([1, 3, 5]))}`);
  