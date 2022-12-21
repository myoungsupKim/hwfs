/*
1. 패키지 선언 관련
- 다른 곳에서 중복 선언시에도 문제가 없도록  typeof 체킹을 한 후 선언합니다.

2. 상수 관련
- 객체 생성 없이 사용할 수 있도록 json 헝태로 정의 합니다. 
- 패키지 구분을 하되 짧은 네임스페이스를 가질 수 있도록 alias를 정의합니다.

3. 공통 유틸리티 정의
- 객체 생성 없이 사용할 수 있도록 json 헝태로 정의합니다.
- 패키지 구분을 하되 짧은 네임스페이스를 가질 수 있도록 alias를 정의합니다.
*/

/* 브라우저 내장 객체에 대한  prototype 확장 */
String.prototype.trim = function() {
    return this.replace(/^\s*(\S*(\s+\S+)*)\s*$/, "$1");
}

/* 패키지 선언 */
if (typeof hanwha == "undefined") {
   function hanwha(){}
}
if (typeof hanwha.ewt == "undefined") {
   hanwha.ewt = function(){}
}
if (typeof hanwha.ewt.commons == "undefined") {
   hanwha.ewt.commons = function(){}
}

/* 공통 유틸리티 정의 */
hanwha.ewt.commons.Utils = Util = {
	isNull : function(strVal) {
		return ( ( strVal == null )
			|| ( strVal == "undefined" )
			|| ( strVal == "null" )
			|| ( strVal == "[]" )
			|| ( strVal.trim() == "" ) );
	},
	escapeFileName: function(name) {
		return name
			.replace(/['']/gi, "′")
			.replace(/[""]/gi, "″")
			.replace(/[&]/gi, "＆")
			.replace(/[<]/gi, "＜")
			.replace(/[>]/gi, "＞")
			.replace(/[*]/gi, "＊")
			.replace(/[:]/gi, "：")
			.replace(/[|]/gi, "ː")
			.replace(/[\\]/gi, "￦")
			.replace(/[/]/gi, "／")
			.replace(/[?]/gi, "？")
			.replace(/[#]/gi, "＃");
	},
	escapeScript: function(text) {
		return text
			.replace(/[<]/gi, "&lt;")
			.replace(/[>]/gi, "&gt;")
			.replace(/[(]/gi, "&#40;")
			.replace(/[)]/gi, "&#41;")
			.replace(/[#]/gi, "&#35;")
			.replace(/[&]/gi, "&#38;");
	}	
}

/* 공통 XML 유틸리티 정의 */
if (window.DOMParser &&
	window.XMLSerializer &&
	window.Node && Node.prototype && Node.prototype.__defineGetter__) {

	Document.prototype.loadXML = function (s) {

		// parse the string to a new doc
		var doc2 = (new DOMParser()).parseFromString(s, "text/xml");

		// remove all initial children
		while (this.hasChildNodes())
			this.removeChild(this.lastChild);

		// insert and import nodes
		for (var i = 0; i < doc2.childNodes.length; i++) {
			this.appendChild(this.importNode(doc2.childNodes[i], true));
		}
	};

	Document.prototype.__defineGetter__("xml", function () {
		return (new XMLSerializer()).serializeToString(this);
	});
	
	Element.prototype.__defineGetter__("xml", function () {
		return (new XMLSerializer()).serializeToString(this);
	});
}
hanwha.ewt.commons.XMLUtils = XMLUtil = {

	/**
	 * @function
	 *    createXML() { return object }
	 * @brief
	 *    Dom 객체를 호출한다.
	 * @usage
	 *    xmlDocument = XMLUtil.createXML();
	 */
	createXML : function() {
		if (document.implementation && document.implementation.createDocument) {
			xmlDoc = document.implementation.createDocument("","",null);
		}
		// Internet Explorer
		else if (typeof ActiveXObject != "undefined") {
			try {
				xmlDoc = new ActiveXObject("Msxml2.DOMDocument");
			} catch (e) {
				xmlDoc = new ActiveXObject("Msxml.DOMDocument");
			}
		}
		
		return xmlDoc;
	},
	/**
	 * @function
	 *    loadXMLDoc(string) { return object }
	 * @brief
	 *    XML 파일로 부터 DOM 객체를 생성한다.
	 * @usage
	 *    xmlDocument = XMLUtil.loadXMLDoc("http://w3schools.com/dom/books.xml");
	 *     or
	 *    xmlDocument = XMLUtil.loadXMLDoc("./books.xml");
	 */
	loadXMLDoc : function(dname) {
		if (window.XMLHttpRequest) {
			xhttp = new XMLHttpRequest();
		}
		// Internet Explorer 5/6
		else {
			xhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xhttp.open("GET", dname, false);
		xhttp.send("");

		return xhttp.responseXML;
	},
	/**
	 * @function
	 *    loadXMLString(string) { return object }
	 * @brief
	 *    XML 문자열로부터 DOM 객체를 생성한다.
	 * @usage
	 *    text = "<bookstore><book>name</book></bookstore>";
	 *    xmlDocument = XMLUtil.loadXMLString(text);
	 */
	loadXMLString : function(text) {
		if (window.DOMParser) {
			parser = new DOMParser();
			xmlDoc = parser.parseFromString(text, "text/xml");
		}
		// Internet Explorer
		else {
			xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
			xmlDoc.async = "false";
			xmlDoc.loadXML(text);
		}

		return xmlDoc;
	},
	/**
	 * @function
	 *    selectNodes(obj, obj, string) { return string }
	 * @brief
	 *    XPath 표현식을 이용하여, XML 노드를 검색합니다.
	 * @usage
	 *    targetNode = XMLUtil.selectNodes(xmlDocument, rootElement, "//flow[@id='0']");
	 * 검색된 노드 추출 방법 1 - IE
	 *	for (i=0;i<xmlNode.length;i++){				
	 *		alert("xmlNode = "+ xmlNode[i].xml);
	 *	}
	 * 검색된 노드 추출 방법 2 - 기타 브라우저
	 *	for ( var i=0 ; i < xmlNode.snapshotLength; i++ ){
  	 *		alert( xmlNode.snapshotItem(i).textContent );
	 *	}
	 */
	selectNodes : function(xml, xmlDoc, elementPath) {
		if (document.implementation && document.implementation.createDocument) {
			var xpe = new XPathEvaluator();
            var nsResolver = xpe.createNSResolver( xmlDoc.ownerDocument == null ? xmlDoc.documentElement : xmlDoc.ownerDocument.documentElement);
			xmlNode = xpe.evaluate(elementPath, xmlDoc, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);			
		}
		// Internet Explorer
		else if (typeof ActiveXObject != "undefined") {
			xmlNode = xmlDoc.selectNodes(elementPath);
		}

		return xmlNode;
	},
	/**
	 * @function
	 *    selectSingleNode(obj, obj, string) { return string }
	 * @brief
	 *    XPath 표현식을 이용하여, XML 노드를 검색합니다.
	 * @usage
	 *    targetNode = XMLUtil.selectSingleNode(xmlDocument, rootElement, "//flow[@id='0']");
	 */
	selectSingleNode : function(xml, xmlDoc, elementPath) {
		if (document.implementation && document.implementation.createDocument) {
			var xpe = new XPathEvaluator();
            var nsResolver = xpe.createNSResolver( xmlDoc.ownerDocument == null ? xmlDoc.documentElement : xmlDoc.ownerDocument.documentElement);
            var results = xpe.evaluate(elementPath,xmlDoc,nsResolver,XPathResult.FIRST_ORDERED_NODE_TYPE, null);
            xmlNode =  results.singleNodeValue; 
		}
		// Internet Explorer
		else if (typeof ActiveXObject != "undefined") {
			xmlNode = xmlDoc.selectSingleNode(elementPath);
		}

		return xmlNode;
	},
	/**
	 * @function
	 *    toXML(obj) { return string }
	 * @brief
	 *    XML 내용을 출력하기 위해 XML 문자열을 읽어온다.
	 * @usage
	 *    alert(XMLUtil.toXML(xmlDocument));
	 *     or
	 *    alert(XMLUtil.toXML(rootElement));
	 */
	toXML : function(obj) {
		if (document.implementation && document.implementation.createDocument) {
			text = (new XMLSerializer()).serializeToString(obj);
		}
		// Internet Explorer
		else if (typeof ActiveXObject != "undefined") {
			text = obj.xml;
		}

		return text;
	}
	
}

/* 
공통 자료구조 정의

---------------------
ArrayList 사용 예
---------------------

var list = new ArrayList();
list.add("k");
list.add(3);

for(var i=0; i<list.size(); i++) {
	alert( list.get(i) );
}

for(var i=list.iterator(); i.hasNext(); ) {
	alert( i.next() );
}

alert( list.toJSON() );

list.remove(0);

for(var i=0; i<list.size(); i++) {
	alert( list.get(i) );
}


---------------------
Hashtable 사용 예
---------------------

var h = new HashMap();
h.put("k", "dddd");
h.put(3, 4444);

alert( h.get("k") );

for(var i=h.keyIterator(); i.hasNext(); ) {
	var key = i.next();
	var value = h.get(key);
	alert( "key:" + key + ",value : " + value );
}

alert( h.toJSON() );

h.remove("k");

for(var i=h.keyIterator(); i.hasNext(); ) {
	var key = i.next();
	var value = h.get(key);
	alert( "key:" + key + ",value : " + value );
}

*/


/* ArrayList */
function ArrayList() {
	this.array = new Array();
}
ArrayList.prototype = {
	add : function(obj) {
		this.array[this.array.length] = obj;
	},
	size : function (){
		return this.array.length;
	},
	get : function (index){
		return this.array[index];
	},
	addAll : function (obj) {
		if (obj instanceof Array){
			for (var i=0;i<obj.length;i++) {
				this.add(obj[i]);
			}
		} else if (obj instanceof ArrayList){
			for (var i=0;i<obj.length();i++) {
				this.add(obj.get(i));
			}
		}
	},
	remove : function (index) {
		if ( this.size() > 0 && index > -1 && index < this.size() )  {
			switch(index) {
				case 0:
					this.array.shift();
					break;
				case this.size() - 1:
					this.array.pop();
					break;
				default:
					var head   = this.array.slice(0, index);
					var tail   = this.array.slice(index+1);
					this.array = head.concat(tail);
					break;
			}
		}
	},
	iterator : function (){
		return new Iterator(this);
	},
	toJSON : function() {
		if ( this.size() == 0 ) return "";
		return $.toJSON(this.array);
	},
	contains : function(obj) {
		var result = 0;
		for(var i=0; i<this.array.length; i++) {
			if( this.array[i] === obj ) {
				result = 1;
				break;
			}
		}
		return result;
	},
	clear : function() {
		this.array = new Array();
	}	
}

/* Iterator */
function Iterator (arrayList){
	this.arrayList = arrayList;
	this.index = 0;
}
Iterator.prototype = {
	hasNext : function () {
		return this.index < this.arrayList.size();
	},
	next : function() {
		return this.arrayList.get(this.index++);
	}
}

/* Hashtable */
function HashMap() {
	this.keys = new ArrayList();
	this.values = new ArrayList();
}

HashMap.prototype = {
	get : function(key){
		for (var index=0; index < this.keys.size(); index++){
			if (key==this.keys.get(index)){
				return this.values.get(index);
			}
		}
		return null;
	},
	put : function(key, value){
		
		if(this.get(key) != null){
			this.remove(key);
		}
		
		this.keys.add(key);
		this.values.add(value);
	},
	containsKey : function(key){
		for (var index=0; index < this.keys.size(); index++){
			if (key==this.keys.get(index)){
				return true;
			}
		}
		return false;
	},
	size : function(){
		return this.keys.size();
	},
	containsValue : function(values){
		for (var index=0; index < this.values.size(); index++){
			if (values==this.values.get(index)){
				return true;
			}
		}
		return false;
	},
	getKeys : function() {
		return this.keys;
	},
	getValues : function() {
		return this.values;
	},
	keyIterator : function() {
		return new Iterator(this.keys);
	},
	valueIterator : function() {
		return new Iterator(this.values);
	},
	remove : function(key) {
		for (var index=0; index < this.keys.size(); index++){
			if (key==this.keys.get(index)){
				this.keys.remove(index);
				this.values.remove(index);
				break;
			}
		}
	},
	toJSON : function() {
		if ( this.size() == 0 ) return ""; 
		var ret = [];
		for(var mIter=this.keyIterator(); mIter.hasNext(); ) {
			var key = mIter.next();
			var value = this.get(key);
			var type = typeof(key);

			var name = "";
		    if (type == "number")
		        name = '"' + key + '"';
		    else if (type == "string")
		        name = $.quoteString(key);
		    else
		        continue;

		    var val = $.toJSON(value);
		    if (typeof(val) != "string") {
		        continue;
		    }

		    ret.push(name + ":" + val);
		}
		return "{" + ret.join(", ") + "}";
	}	
}