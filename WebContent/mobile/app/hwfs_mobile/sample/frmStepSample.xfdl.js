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
                this.set_name("frmStepSample");
                this.set_titletext("step샘플");
                this._setFormPosition(0,0,520,580);
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
            obj = new Button("Button00", "absolute", "78", "66", "376", "442", null, null, this);
            obj.set_taborder("0");
            obj.set_text("Button00");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", "24", "75", "376", "442", null, null, this);
            obj.set_taborder("1");
            obj.set_text("Button01");
            obj.set_positionstep("1");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "45", "72", "425", "468", null, null, this);
            obj.set_taborder("2");
            obj.set_positionstep("2");
            obj.set_binddataset("ds_list");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row band=\"head\" size=\"24\"/><Row band=\"body\" size=\"24\"/></Rows><Band id=\"head\"><Cell col=\"0\" disptype=\"normal\" text=\"USER_ID\"/><Cell col=\"1\" disptype=\"normal\" text=\"APP_ID\"/><Cell col=\"2\" disptype=\"normal\" text=\"USER_NM\"/><Cell col=\"3\" disptype=\"normal\" text=\"ENG_USER_NM\"/><Cell col=\"4\" disptype=\"normal\" text=\"ORG_ID\"/></Band><Band id=\"body\"><Cell col=\"0\" disptype=\"normal\" text=\"bind:USER_ID\"/><Cell col=\"1\" disptype=\"normal\" text=\"bind:APP_ID\"/><Cell col=\"2\" disptype=\"normal\" text=\"bind:USER_NM\"/><Cell col=\"3\" disptype=\"normal\" text=\"bind:ENG_USER_NM\"/><Cell col=\"4\" disptype=\"normal\" text=\"bind:ORG_ID\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", "64", "64", "376", "442", null, null, this);
            obj.set_taborder("3");
            obj.set_text("Button04");
            obj.set_positionstep("3");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 580, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmSelectSample");
            		p.set_titletext("step샘플");

            	}
            );
            obj.set_stepcount("4");
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
        this.registerScript("frmStepSample.xfdl", function(exports) {

        this.fn_stepTest = function (idx)
        {
        	this.setStepIndex(idx);
        }
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmSelectSample_onload, this);

        };

        this.loadIncludeScript("frmStepSample.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
