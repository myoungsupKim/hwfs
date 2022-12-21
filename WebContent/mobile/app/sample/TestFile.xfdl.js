(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        this.on_create = function()
        {
            // Declare Reference
            var obj = null;
            
            if (Form == this.constructor) {
                this.set_name("Frm_Main");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,541,363);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("Dataset00", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"FILENAME\" type=\"STRING\" size=\"256\"/><Column id=\"SIZE\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_msg", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"MSG\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new FileUpload("FileUpload00", "absolute", "8", "26", "452", "80", null, null, this);
            obj.set_taborder("0");
            obj.getSetter("retry").set("0");
            obj.style.set_itemheight("35");
            obj.style.set_buttonsize("40");
            obj.style.set_buttonbackground("darkorange");
            obj.style.set_buttoncolor("black");
            obj.style.set_buttontext("Find");
            obj.style.set_font("antialias 10 Helvetica");
            obj.set_multiselect("true");
            obj.set_index("0");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 541, 363, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("Frm_Main");
            		p.set_titletext("New Form");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.registerScript("TestFile.xfdl", function(exports) {
        //*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
        // ファイルアップロードダウンロードサンプル
        //
        //   ファイルアップロードダウンロードのコードサンプルになります。
        //   Typedefinitionにnexacro.FileUpload,nexacro.FileDownloadが
        //   追加されていることに留意してください。
        //
        //*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

        
        //************************************************************
        // ファイルアップロードダウンロードサンプルの初期化
        //************************************************************
        //------------------------------------------------------------
        // FormOnloadイベント
        //  
        // サーバーにアップロードされているファイル群をデータセットに取得します。
        //
        //------------------------------------------------------------
        this.Frm_Main_onload = function(obj,e)
        {
        	// PATH : サーバーのファイルの位置をパラメータで指定
        	//this.transaction("getFile", "SVC::fileServer.jsp?PATH=sampleFile","","Dataset00=outds","","fn_callback");
        }

        //************************************************************
        // ファイルアップロード
        //************************************************************
        //------------------------------------------------------------
        // アップロードボタン押下イベント
        //  
        //------------------------------------------------------------
        this.Btn_upload_onclick = function(obj,e)
        {
        	var strLogoFilePath = this.FileUpload00.value;
        	if (this.gfn_IsNull(strLogoFilePath)){
        		this.alert("ファイルを指定してください。");
        		return true;
        	}
        	// URLの指定では引数としてアップロードするパスを渡しています。->PATH
        	this.FileUpload00.set_uploadurl("SVC::fileUpload.jsp?PATH=sampleFile");
        	this.FileUpload00.upload();
        }

        this.FileUpload00_onsuccess = function(obj,e)
        {
        	this.alert("アップロード成功");
        	
        	var dstList = e.datasets;
        	trace(e.datasets.length);
        	trace(e.datasets[0].saveXML());

        	var strFileName = e.datasets[0].getColumn(0, "fileName");
        	var fileSize = e.datasets[0].getColumn(0, "fileSize");
        	var nRow = this.Dataset00.addRow();
        	this.Dataset00.setColumn(nRow, "FILENAME", strFileName);
        	this.Dataset00.setColumn(nRow, "SIZE", fileSize);
        	
        //	this.FileUpload00.deleteItem(0);
        }

        this.FileUpload00_onerror = function(obj,e)
        {
        	this.alert("アップロード失敗");
        }

        //--------------------------------------------------------------------------------
        // ファイルダウンロード関数
        // 　データセットのファイル名情報からファイルダウンロードをする。
        //--------------------------------------------------------------------------------
        this.fn_fileDownload = function(){
        	var curRow = this.Dataset00.rowposition;
        	if (curRow < 0){
        		this.alert("ダウンロードファイルするファイルリストがありません。");
        		return true;
        	}
        	var strFileName = this.Dataset00.getColumn(curRow,"FILENAME");

        	// ファイルダウンロードサービスにパラメータで
        	// ファイルのあるパス(PATH)とファイル名(file)を渡し、
        	// クライアントにファイルを転送してもらう。
        //	this.FileDownload00.set_downloadurl("SVC::fileDownload.jsp?PATH=sampleFile&file="+strFileName);
        	this.FileDownload00.set_downloadurl("SVC::fileDownload2.jsp?PATH=sampleFile&file="+strFileName);
        	var bSucc = this.FileDownload00.download();
        }

        //--------------------------------------------------------------------------------
        // ファイルダウンロードのイベント(FileDownload)
        //--------------------------------------------------------------------------------
        this.FileDownload00_onclick = function(obj,e)
        {
        	this.fn_fileDownload() ;
        }

        //--------------------------------------------------------------------------------
        // ファイルダウンロードのイベント(Button)
        //--------------------------------------------------------------------------------
        this.Btn_download_onclick = function(obj,e)
        {
        	this.fn_fileDownload() ;
        }

        

        this.FileDownload00_onsuccess = function(obj,e)
        {
        	trace(obj.name+":"+e.eventid);
        	this.alert("ダウンロード成功");
        }

        this.FileDownload00_onerror = function(obj,e)
        {
        	trace(obj.name+":"+e.eventid+":"+e.errormsg);
        	var	idx ;
        	idx = this.ds_msg.addRow();
        	this.ds_msg.setColumn(idx,"MSG",e.eventid);

        	idx = this.ds_msg.addRow();
        	this.ds_msg.setColumn(idx,"MSG",e.errormsg);

        	idx = this.ds_msg.addRow();
        	this.ds_msg.setColumn(idx,"MSG",e.errortype);
        	
        }

        
        //------------------------------------------------------------
        // トランザクションコールバック 
        //------------------------------------------------------------
        this.fn_callback = function (strID,strErrCode,strErrMsg)
        {
        	alert(strID + "[" + strErrCode + "] " + strErrMsg);
        	if(strErrCode < 0){
        		return true;
        	}

        	if (strID == "getFile"){
        		trace(this.Dataset00.saveXML());
        		return true;
        	}
        }

        
        //------------------------------------------------------------
        // 統合nullチェック
        //------------------------------------------------------------
        this.gfn_IsNull = function (objValue){
        	if(objValue == undefined) return true;
        	if(objValue == null) return true;
        	if(objValue == "") return true;
        	return false;
        }

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.Frm_Main_onload, this);
            this.FileUpload00.addEventHandler("onsuccess", this.FileUpload00_onsuccess, this);
            this.FileUpload00.addEventHandler("onerror", this.FileUpload00_onerror, this);

        };

        this.loadIncludeScript("TestFile.xfdl", true);

       
    };
}
)();
