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
                this.set_name("frmSelectSample");
                this.set_titletext("사용자 검색");
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
            obj = new Edit("edtName", "absolute", "89", "15", "255", "50", null, null, this);
            obj.set_taborder("0");
            this.addChild(obj.name, obj);

            obj = new Static("staName", "absolute", "14", "14", "102", "50", null, null, this);
            obj.set_taborder("1");
            obj.set_text("이름 : ");
            this.addChild(obj.name, obj);

            obj = new Button("btnSearch", "absolute", "352", "15", "119", "50", null, null, this);
            obj.set_taborder("2");
            obj.set_text("검색");
            this.addChild(obj.name, obj);

            obj = new Grid("grdList", "absolute", "20", "80", null, null, "20", "20", this);
            obj.set_taborder("3");
            obj.set_binddataset("ds_list");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"113\"/><Column size=\"132\"/><Column size=\"171\"/><Column size=\"80\"/></Columns><Rows><Row size=\"60\" band=\"head\"/><Row size=\"60\"/></Rows><Band id=\"head\"><Cell text=\"ID\"/><Cell col=\"1\" text=\"이름(한)\"/><Cell col=\"2\" text=\"이름(영)\"/><Cell col=\"3\" text=\"그룹\"/></Band><Band id=\"body\"><Cell text=\"bind:USER_ID\"/><Cell col=\"1\" text=\"bind:USER_NM\"/><Cell col=\"2\" text=\"bind:ENG_USER_NM\"/><Cell col=\"3\" text=\"bind:ORG_ID\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmSelectSample");
            		p.set_titletext("사용자 검색");

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
        this.addIncludeScript("frmSelectSample.xfdl", "lib::sz_fsp_xp.xjs");
        this.registerScript("frmSelectSample.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs";

        this.frmSelectSample_onload = function(obj,e)
        {
        	this.fsp_init();
        }

        this.btnSearch_onclick = function(obj,e)
        {
        	this.ds_cond.clearData();
        	this.ds_cond.addRow();
        	this.ds_cond.setColumn(0, "USER_NM", this.edtName.value);
        	
        	this.fn_search();

        // 	this.alert(this.ds_cond.rowcount + " : " + this.edtName.value);
        }

        /*******************************************************************************
        * 기      능   : 조회
        * 설      명   : undefined
        ********************************************************************************/
        this.fn_search = function()
        {
        // 	this.alert(this.ds_cond.saveXML());
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
        * 기      능   : search callback
        ********************************************************************************/
        this.fn_afterSearch = function(ErrorCode,ErrorMsg)
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
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmSelectSample_onload, this);
            this.btnSearch.addEventHandler("onclick", this.btnSearch_onclick, this);

        };

        this.loadIncludeScript("frmSelectSample.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
