var temp = new Array();
var storesCnt = 0; //스토어개수
var setCnt = 0; //DataSet 개수
var dataSetLst = null;

/**
* xml 로드
*/
function GetXmlDoc(ozData,isFile){
	//var xmlDoc = new ActiveXObject("MsXml2.DOMDocument");
	var xmlDoc = createDocument();  
	xmlDoc.async = false;
	if(isFile) 
		xmlDoc.load(ozData);
	else
		xmlDoc.loadXML(ozData);

	return xmlDoc;
}

function createDocument(){
    var aVersion = ["MSXML2.DOMDocument.6.0","MSXML2.DOMDocument.5.0","MSXML2.DOMDocument.4.0","MSXML2.DOMDocument.3.0","MSXML2.DOMDocument","Microsoft.XmlDom"];
    for(var i=0; i<aVersion.length;i++){
        try{
            var oXmlDom = new ActiveXObject(aVersion[i]);
            return oXmlDom;
        }catch(e){
            alert(aVersion[i]+"에러");
        }
    }
    throw new Error("MSXML is not installed.");
}


function GetOZDataModule(){
	var dm = _GetNewDataModule();
	var ozdata = _GetParamValue("xmlData");//데이터
	var odi = dm.GetMetaODI(); // dm.GetMetaODI("ozp:///category/item.odi");
	var stores = new Array(); //데이터 스토어
	
	odi.GetDataStores(stores);
	storesCnt = stores.length;
	
	//_MessageBox("storesCnt==" + storesCnt);
	//_MessageBox(ozdata);
	
	var isFile = false;
	if(ozdata.substr(0,1)!="<") isFile = true;


	var xmlDoc = GetXmlDoc(ozdata,isFile);
	
	dataSetLst = new DataSetLst(); //그룹데이터 스토어를 생성
	for(var i=0;i<storesCnt;i++){
		AddDataSet(dm,stores[i]); //데이터셋 정보드를 저장한다.
	}

	getXmlElements(dm,xmlDoc);
	
	return dm;
}

function AddDataSet(dm,store){
	var setList = new Array(); //데이터셋
	store.GetDataSets(setList); //셋을 가져온다.

	//_MessageBox("setList.length==" + setList.length);
	var dataSet = null;
	for(var i=0;i<setList.length;i++){
		var setName = setList[i].getAttribute("NAME");
		//_TraceLn("[SDMMAKER] (DEBUG) GET DataSet["+i+"]'s Name is "+ setName);
		//_MessageBox("GET DataSet["+i+"]'s Name is "+ setName);
		var dataSet = setList[i];
		var fields = new Array(); 
		var fieldsNames = new Array();
		var fieldsTypes = new Array();
		dataSet.GetFields(fields);
			//_MessageBox(fields.length + " = " +fields.length);		
		for(var k = 0; k < fields.length ; k++){
			var tmpName = fields[k].getAttribute("NAME");
			var tmpType = dm.ChangeFieldTypeToString(fields[k].getAttribute("TYPE"));
//			_TraceLn(tmpName + " = " +tmpType);
			//_MessageBox(tmpName + " = " +tmpType);
			fieldsNames[k] = tmpName;
			fieldsTypes[k] = tmpType;
		}
		dataSetLst.setLst[setCnt++]= new DataSet(setName,fieldsNames,fieldsTypes);
	}
}


function getXmlElements(dm,xmlDoc){
	try{
		var root = xmlDoc.documentElement; //최상위 노드
		xmlDoc.setProperty("SelectionLanguage", "XPath");	
		var setNode = xmlDoc.selectNodes("//"+root.tagName+"/dataset");
//	_MessageBox(setNode + " = " +setNode);
		for (var i=0;i<setNode.length;i++) {
			var setName = setNode.item(i).attributes.item(0).text;
			var dsInfo = getDataSet(setName);
			_TraceLn("dsInfo :"+dsInfo);
			if(dsInfo!=null){
				AddRow(dm,null,dsInfo,setNode.item(i).childNodes);
			}
		}
	}catch(e){}
}

function AddRow(dm,ms,dsInfo,node){
	try{
		var ds;
		if(ms==null)
			ds = dm.AddDataSet(dsInfo.setName,dsInfo.fieldsNames,dsInfo.fieldsTypes);
		else
			ds = ms.AddDetailSet(dsInfo.setName,dsInfo.fieldsNames,dsInfo.fieldsTypes);
		
		for(var i=0;i<node.length;i++){
			var dataNode = node.item(i).childNodes;
			var data = new Array();
			var detail = new Array();
			for(var j=0;j<dataNode.length;j++){
				var tagName = dataNode.item(j).tagName;
				if(tagName!="DATASET"){ //디테일셋이 아니라면
					data[j] = dataNode.item(j).text;
				}else{
					detail[detail.length]=j;
				}
			}
			ds.AddRow(data);
			for(var j=0;j<detail.length;j++){
				var tmp = getDataSet(dataNode.item(detail[j]).attributes.item(0).text);
				if(tmp!=null){
					AddRow(dm,ds,tmp,dataNode.item(detail[j]).childNodes);
				}
			}
		}
	}catch(e){}
}

function getDataSet(setName){
	var ds = null;
	for(var i=0;i<setCnt;i++){
		if(dataSetLst.setLst[i].setName==setName){
			ds = dataSetLst.setLst[i];
			break;
		}
	}
	return ds;
}

/**
*데이터셋리스트
*/
function DataSetLst(){
	this.setLst = new Array();
}

/**
*데이터셋 객체
*/
function DataSet(setName,fieldsNames,fieldsTypes){
	this.setName=setName;
	this.fieldsNames=fieldsNames;
	this.fieldsTypes=fieldsTypes;
_TraceLn("this.setName==" + this.setName+"[this.fieldsNames :]"+this.fieldsNames) ;

}