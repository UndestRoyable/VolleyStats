Array.prototype.select = function(predicate){
    var r = []
    for(var n = 0; n < this.length; n++) {
        if(predicate(this[n])){
            r.push(this[n]);
        }
    }

    return r;
};