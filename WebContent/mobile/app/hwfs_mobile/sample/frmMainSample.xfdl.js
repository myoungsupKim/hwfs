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
                this.set_name("frmMainSample");
                this.set_titletext("stepMain");
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
            obj = new Button("btnSearch00", "absolute", "10", "16", "119", "50", null, null, this);
            obj.set_taborder("3");
            obj.set_text("1");
            this.addChild(obj.name, obj);

            obj = new Button("btnSearch01", "absolute", "141", "16", "119", "50", null, null, this);
            obj.set_taborder("4");
            obj.set_text("2");
            this.addChild(obj.name, obj);

            obj = new Button("btnSearch02", "absolute", "273", "16", "119", "50", null, null, this);
            obj.set_taborder("5");
            obj.set_text("3");
            this.addChild(obj.name, obj);

            obj = new Button("btnSearch03", "absolute", "401", "16", "119", "50", null, null, this);
            obj.set_taborder("6");
            obj.set_text("4");
            this.addChild(obj.name, obj);

            obj = new Div("Div00", "absolute", "10", "80", "520", "580", null, null, this);
            obj.set_taborder("7");
            obj.set_text("Div00");
            obj.set_url("sample::frmStepSample.xfdl");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmSelectSample2");
            		p.set_titletext("stepMain");

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
            this._addPreloadList("fdl", "sample::frmStepSample.xfdl");
        };
        
        // User Script
        this.registerScript("frmMainSample.xfdl", function(exports) {
        //이 화면만 호출하면 테스트 가능

        this.btnSearch00_onclick = function(obj,e)
        {
        	this.Div00.setStepIndex(0);
        }

        this.btnSearch01_onclick = function(obj,e)
        {
        	this.Div00.setStepIndex(1);
        }

        this.btnSearch02_onclick = function(obj,e)
        {
        	this.Div00.setStepIndex(2);
        }

        this.btnSearch03_onclick = function(obj,e)
        {
        	this.Div00.setStepIndex(3);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.btnSearch00.addEventHandler("onclick", this.btnSearch00_onclick, this);
            this.btnSearch01.addEventHandler("onclick", this.btnSearch01_onclick, this);
            this.btnSearch02.addEventHandler("onclick", this.btnSearch02_onclick, this);
            this.btnSearch03.addEventHandler("onclick", this.btnSearch03_onclick, this);

        };

        this.loadIncludeScript("frmMainSample.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
