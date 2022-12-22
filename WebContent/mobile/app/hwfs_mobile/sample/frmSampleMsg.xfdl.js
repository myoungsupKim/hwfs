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
                this.set_name("frmCalendarTest");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,540,758);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Button("Button00", "absolute", "408", "40", "120", "50", null, null, this);
            obj.set_taborder("0");
            obj.set_text("Alert");
            this.addChild(obj.name, obj);

            obj = new Edit("edtTitle", "absolute", "121", "40", "271", "49", null, null, this);
            obj.set_taborder("1");
            obj.set_value("Title");
            this.addChild(obj.name, obj);

            obj = new Edit("edtContent", "absolute", "120", "104", "272", "49", null, null, this);
            obj.set_taborder("2");
            obj.set_value("확인하시겠습니까.");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "9", "42", "104", "47", null, null, this);
            obj.set_taborder("3");
            obj.set_text("타이틀");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "9", "98", "104", "47", null, null, this);
            obj.set_taborder("4");
            obj.set_text("내용");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", "408", "104", "120", "50", null, null, this);
            obj.set_taborder("5");
            obj.set_text("Confirm");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendarTest");
            		p.set_titletext("New Form");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("frmSampleMsg.xfdl", "lib::lib_POP.xjs");
        this.registerScript("frmSampleMsg.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_POP.xjs", null, exports); }	//include "lib::lib_POP.xjs";

        this.frmCalendarTest_onload = function(obj,e)
        {
        	
        }

        
        this.Button00_onclick = function(obj,e)
        {
        	application.goMain.gfn_Msg("alertTest", this.edtTitle.value, this.edtContent.value, "OK");
        }

        this.Button01_onclick = function(obj,e)
        {
        	application.goMain.gfn_Msg("confirmTest", this.edtTitle.value, this.edtContent.value, "YN", true, this);
        }

        this.msg_callback = function (id,arg)
        {
        	// msg ID
        	trace(id);
        	// Y or N
        	trace(arg);
        	trace("msgCallback");
        }
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmCalendarTest_onload, this);
            this.Button00.addEventHandler("onclick", this.Button00_onclick, this);
            this.Button01.addEventHandler("onclick", this.Button01_onclick, this);

        };

        this.loadIncludeScript("frmSampleMsg.xfdl", true);

       
    };
}
)();
