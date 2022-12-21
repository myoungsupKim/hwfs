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
                this.set_name("frmSelectMaxID");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,540,758);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_max", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"COLSEQ\" size=\"10\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_input", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"COLCONT\" size=\"255\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("btnInsert", "absolute", "384", "92", "140", "46", null, null, this);
            obj.set_taborder("0");
            obj.set_text("입력");
            this.addChild(obj.name, obj);

            obj = new Edit("edtIns", "absolute", "24", "24", "504", "60", null, null, this);
            obj.set_taborder("1");
            obj.set_value("가나다라마바사");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmSelectMaxID");
            		p.set_titletext("New Form");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("data", "", "ds_max");
            this._addPreloadList("data", "", "ds_input");
        };
        
        // User Script
        this.addIncludeScript("frmSelectMaxID.xfdl", "lib::sz_fsp_xp.xjs");
        this.registerScript("frmSelectMaxID.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs"

        this.frmSelectMaxID_onload = function(obj,e)
        {
        	this.fsp_init();
        }

        this.btnInsert_onclick = function(obj,e)
        {
        	this.ds_input.addRow();
        	
        	this.ds_input.setColumn(0, "COLCONT", this.edtIns.text);
        	
        	this.fn_save();
        }

        /*******************************************************************************
        * 기      능   : 저장
        * 설      명   : 
        ********************************************************************************/
        this.fn_save  = function ()
        {
        	this.fsp_clear();
        	this.fsp_addSingle
        	(
        		"sample:TMP_EXERCISE_INSERT",
        		"sample:FSP_GET_MAX",
        		0,
        		""
        	); // 키값 채번용 "emp:TBL_NO_MAXSEARCH"를 입력, '1'은 키값의 증가값을 말한다.
            
            // 서버 호출 
        	this.fsp_callService(
        		""
        		,""
        		,"ds_input=ds_input:U"	// inDs
        		,"ds_max=ds_max"	// outDs
        		,""	// args 
        		,"fn_afterSave"
        		,false
        	);
        }

        /*******************************************************************************
        * 기      능   : save callback
        ********************************************************************************/
        this.fn_afterSave = function (ErrorCode,ErrorMsg)
        {
        	if(ErrorCode == "0")
        	{
        		this.alert("성공!");
        	}
        	else
        	{
        		this.alert(ErrorCode + " : " + ErrorMsg);
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmSelectMaxID_onload, this);
            this.btnInsert.addEventHandler("onclick", this.btnInsert_onclick, this);

        };

        this.loadIncludeScript("frmSelectMaxID.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
