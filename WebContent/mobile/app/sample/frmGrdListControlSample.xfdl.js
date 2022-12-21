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
                this.set_name("frmGrdListControlSample");
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
            obj._setContents("<ColumnInfo><Column id=\"TOTALCNT\" size=\"22\" type=\"STRING\"/><Column id=\"SEQ\" size=\"22\" type=\"STRING\"/><Column id=\"CAMP_FG\" size=\"1\" type=\"STRING\"/><Column id=\"APPLY_NO\" size=\"11\" type=\"STRING\"/><Column id=\"ACCP_TYPE_CD\" size=\"10\" type=\"STRING\"/><Column id=\"ACCP_LN_TYPE_CD\" size=\"10\" type=\"STRING\"/><Column id=\"ACCP_STEP\" size=\"22\" type=\"STRING\"/><Column id=\"ACCP_ID\" size=\"8\" type=\"STRING\"/><Column id=\"ACCP_ID_NM\" size=\"4000\" type=\"STRING\"/><Column id=\"ACCP_DT\" size=\"7\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cond", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"PAGE_CNT\" size=\"255\" type=\"INT\"/><Column id=\"CURRENT_PAGE\" size=\"255\" type=\"INT\"/><Column id=\"APPLY_NO\" size=\"255\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_temp", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"TOTALCNT\" size=\"22\" type=\"STRING\"/><Column id=\"SEQ\" size=\"22\" type=\"STRING\"/><Column id=\"CAMP_FG\" size=\"1\" type=\"STRING\"/><Column id=\"APPLY_NO\" size=\"11\" type=\"STRING\"/><Column id=\"ACCP_TYPE_CD\" size=\"10\" type=\"STRING\"/><Column id=\"ACCP_LN_TYPE_CD\" size=\"10\" type=\"STRING\"/><Column id=\"ACCP_STEP\" size=\"22\" type=\"STRING\"/><Column id=\"ACCP_ID\" size=\"8\" type=\"STRING\"/><Column id=\"ACCP_ID_NM\" size=\"4000\" type=\"STRING\"/><Column id=\"ACCP_DT\" size=\"7\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("btnSearch", "absolute", "416", "10", "112", "47", null, null, this);
            obj.set_taborder("0");
            obj.set_text("조회");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "10", "71", null, "622", "10", null, this);
            obj.set_taborder("1");
            obj.set_binddataset("ds_list");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"100\"/><Column size=\"100\"/><Column size=\"100\"/><Column size=\"100\"/><Column size=\"100\"/><Column size=\"100\"/><Column size=\"100\"/><Column size=\"100\"/><Column size=\"100\"/></Columns><Rows><Row size=\"50\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"SEQ\"/><Cell col=\"1\" text=\"CAMP_FG\"/><Cell col=\"2\" text=\"APPLY_NO\"/><Cell col=\"3\" text=\"ACCP_TYPE_CD\"/><Cell col=\"4\" text=\"ACCP_LN_TYPE_CD\"/><Cell col=\"5\" text=\"ACCP_STEP\"/><Cell col=\"6\" text=\"ACCP_ID\"/><Cell col=\"7\" text=\"ACCP_ID_NM\"/><Cell col=\"8\" text=\"ACCP_DT\"/></Band><Band id=\"body\"><Cell text=\"bind:SEQ\"/><Cell col=\"1\" text=\"bind:CAMP_FG\"/><Cell col=\"2\" text=\"bind:APPLY_NO\"/><Cell col=\"3\" text=\"bind:ACCP_TYPE_CD\"/><Cell col=\"4\" text=\"bind:ACCP_LN_TYPE_CD\"/><Cell col=\"5\" text=\"bind:ACCP_STEP\"/><Cell col=\"6\" text=\"bind:ACCP_ID\"/><Cell col=\"7\" text=\"bind:ACCP_ID_NM\"/><Cell col=\"8\" text=\"bind:ACCP_DT\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btnNext", "absolute", "201", "704", "150", "43", null, null, this);
            obj.set_taborder("2");
            obj.set_text("더 보기");
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
            this._addPreloadList("data", "", "ds_temp");
        };
        
        // User Script
        this.addIncludeScript("frmGrdListControlSample.xfdl", "lib::sz_fsp_xp.xjs");
        this.registerScript("frmGrdListControlSample.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs";

        this.F_nPageCnt = 10;   // 페이지당 최대 건수
        this.F_nTotalPageCnt;   // 총 페이지 수

        this.currentPageNo = 1; // 페이지 번호

        this.frmSelectSample2_onload = function (obj,e)
        {
        	var nRow;
        	
        	this.fsp_init();
        	this.ds_cond.clearData();
        	
        	nRow = this.ds_cond.addRow();
        	
        	this.ds_cond.setColumn(nRow, "PAGE_CNT", this.F_nPageCnt);
        	this.ds_cond.setColumn(nRow, "CURRENT_PAGE", this.currentPageNo);
        }

        this.btnSearch_onclick = function(obj,e)
        {
        	this.currentPageNo = 1;
        	this.ds_list.clearData();
        	
        	this.fn_search();
        }

        this.btnNext_onclick = function(obj,e)
        {
        	this.currentPageNo++;
        	this.ds_cond.setColumn(0, "CURRENT_PAGE", this.currentPageNo);
        	this.fn_search();
        }

        /*******************************************************************************
        * 기      능   : 조회
        * 설      명   : undefined
        ********************************************************************************/
        this.fn_search = function ()
        {
        	this.ds_cond.setColumn(0, "CURRENT_PAGE", this.currentPageNo);

        	this.fsp_clear();
        	this.fsp_addSearch("sample:fsp_sample_sel2", false);
        	// connect the server 
        	this.fsp_callService
        	(
        		""
        		,""
        		,"ds_cond=ds_cond"	// inDs
        		,"ds_temp=ds_temp"	// outDs
        		,""	// args 
        		,"fn_afterSearch"
        		,true
        	);
        }

        /*******************************************************************************
        * 기      능   : search callback
        ********************************************************************************/
        this.fn_afterSearch = function (ErrorCode,ErrorMsg)
        {
        	var nTotalCnt = nexacro.toNumber(this.ds_temp.getColumn(0, "TOTALCNT"));

        	if(ErrorCode != "0") // 성공
        	{
        		this.alert("Error : " + ErrorCode + " : " + ErrorMsg);
        		this.btnNext.set_enable(false);
        		return;
        	}
        	
        	this.ds_list.appendData(this.ds_temp);
        	
        	if(this.ds_list.rowcount == nTotalCnt)
        	{
        		this.btnNext.set_enable(false);
        	}
        	else
        	{
        		this.btnNext.set_enable(true);
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmSelectSample2_onload, this);
            this.btnSearch.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.btnNext.addEventHandler("onclick", this.btnNext_onclick, this);

        };

        this.loadIncludeScript("frmGrdListControlSample.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
