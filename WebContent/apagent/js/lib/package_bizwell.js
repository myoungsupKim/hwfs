if (typeof bizwell == "undefined") {
    var bizwell = {};
}
bizwell.namespace = function() {
    var a=arguments, o=null, i, j, d;
    for (i=0; i<a.length; i=i+1) {
        d=a[i].split(".");
        o=bizwell;
        for (j=(d[0] == "bizwell") ? 1 : 0; j<d.length; j=j+1) {
            o[d[j]]=o[d[j]] || {};
            o=o[d[j]];
        }
    }
    return o;
};
(function() {
	bizwell.namespace("approval", "util", "commons");
})();