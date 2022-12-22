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
                this.set_name("frmSaveSample");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,540,758);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_list", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"USER_ID\" size=\"22\" type=\"STRING\"/><Column id=\"APP_ID\" size=\"2\" type=\"STRING\"/><Column id=\"USER_NM\" size=\"40\" type=\"STRING\"/><Column id=\"ENG_USER_NM\" size=\"50\" type=\"STRING\"/><Column id=\"ORG_ID\" size=\"20\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cond", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"USER_NM\" size=\"255\" type=\"STRING\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Grid("Grid00", "absolute", "10", "80", null, null, "10", "10", this);
            obj.set_taborder("0");
            obj.set_binddataset("ds_list");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"100\"/><Column size=\"100\"/><Column size=\"100\"/><Column size=\"100\"/><Column size=\"100\"/></Columns><Rows><Row size=\"50\" band=\"head\"/><Row size=\"50\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell colspan=\"2\" text=\"User ID\"/><Cell col=\"2\" text=\"APP\"/><Cell col=\"3\" colspan=\"2\" text=\"User 그룹\"/><Cell row=\"1\" colspan=\"3\" text=\"이름 (한)\"/><Cell row=\"1\" col=\"3\" colspan=\"2\" text=\"이름 (영)\"/></Band><Band id=\"body\"><Cell colspan=\"2\" edittype=\"normal\" text=\"bind:USER_ID\"/><Cell col=\"2\" edittype=\"normal\" text=\"bind:APP_ID\"/><Cell col=\"3\" colspan=\"2\" edittype=\"normal\" text=\"bind:ORG_ID\"/><Cell row=\"1\" colspan=\"3\" edittype=\"normal\" text=\"bind:USER_NM\"/><Cell row=\"1\" col=\"3\" colspan=\"2\" edittype=\"normal\" text=\"bind:ENG_USER_NM\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btnSelect", "absolute", "80", "15", "102", "53", null, null, this);
            obj.set_taborder("1");
            obj.set_text("조회");
            this.addChild(obj.name, obj);

            obj = new Button("btnAdd", "absolute", "200", "15", "102", "53", null, null, this);
            obj.set_taborder("2");
            obj.set_text("추가");
            this.addChild(obj.name, obj);

            obj = new Button("btnDel", "absolute", "304", "15", "102", "53", null, null, this);
            obj.set_taborder("3");
            obj.set_text("삭제");
            this.addChild(obj.name, obj);

            obj = new Button("btnSave", "absolute", "424", "15", "102", "53", null, null, this);
            obj.set_taborder("4");
            obj.set_text("저장");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmSelectSample2");
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
            this._addPreloadList("data", "", "ds_list");
            this._addPreloadList("data", "", "ds_cond");
        };
        
        // User Script
        this.addIncludeScript("frmSaveSample.xfdl", "lib::sz_fsp_xp.xjs");
        this.registerScript("frmSaveSample.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs";

        this.frmSaveSample_onload = function (obj,e)
        {
        	this.fsp_init();
        }

        this.btnSelect_onclick = function(obj,e)
        {
        	this.fn_search();
        }

        this.btnAdd_onclick = function(obj,e)
        {
        	this.ds_list.addRow();
        }

        this.btnDel_onclick = function(obj,e)
        {
        	this.ds_list.deleteRow(this.ds_list.rowposition);
        }

        this.btnSave_onclick = function(obj,e)
        {
        	this.fn_save();
        }

        /*******************************************************************************
        * 기      능   : 조회
        * 설      명   : 
        ********************************************************************************/
        this.fn_search = function ()
        {
        	this.fsp_clear();
        	this.fsp_addSearch("sample:fsp_sample_sel", false);
        	// connect the server 
        	this.fsp_callService
        	(
        		""
        		,""
        		,"ds_cond=ds_cond"	// inDs
        		,"ds_list=ds_list"	// outDs
        		,""	// args 
        		,"fn_afterSearch"
        		,true
        	);
        }

        /*******************************************************************************
        * 기      능   : 저장
        * 설      명   : 
        ********************************************************************************/
        this.fn_save = function ()
        {
        	this.fsp_clear();
        	this.fsp_addSave
        	(
        		"sample:fsp_sample_ins"	// insert
        		, "sample:fsp_sample_upd"	// update
        		, "sample:fsp_sample_del"	// delete
        		, ""	// flag column 명
        		, ""	// key sql id
        		, 0	// key 증가 값
        		, "" 
        		, 0 
        		, "B"	// 실행타입
        	);
        	// 서버 호출 
        	this.fsp_callService
        	(
        		""
        		,""
        		,"ds_list=ds_list:U"	// inDs
        		,""	// outDs
        		,""	// args 
        		,"fn_afterSave"
        		,false
        	);
        // fsp_callService(actionName, cmdName, inData, outData [, otherArg [, callBackFnc [, isErrorNotCall [, isNotShow [, isSync [, trId, [svcDataUrl ]]]]]]] );
        }

        /*******************************************************************************
        * 기      능   : search callback
        ********************************************************************************/
        this.fn_afterSearch = function (ErrorCode,ErrorMsg)
        {
        	if(ErrorCode == "0") // 성공
        	{
        //		this.alert("Secc!!!");
        	}
        	else // 실패
        	{
        		this.alert("Error : " + ErrorCode + " : " + ErrorMsg);
        	}
        }

        /*******************************************************************************
        * 기      능   : save callback
        ********************************************************************************/
        this.fn_afterSave = function (ErrorCode,ErrorMsg)
        {
        	if(ErrorCode == "0") // 성공
        	{
        		this.alert("저장이 되었습니다.");
        	}
        	else // 실패
        	{
        		this.alert("Error : " + ErrorCode + " : " + ErrorMsg);
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmSaveSample_onload, this);
            this.btnSelect.addEventHandler("onclick", this.btnSelect_onclick, this);
            this.btnAdd.addEventHandler("onclick", this.btnAdd_onclick, this);
            this.btnDel.addEventHandler("onclick", this.btnDel_onclick, this);
            this.btnSave.addEventHandler("onclick", this.btnSave_onclick, this);

        };

        this.loadIncludeScript("frmSaveSample.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
