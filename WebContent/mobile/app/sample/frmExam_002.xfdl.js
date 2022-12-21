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
                this.set_name("frmExam_002");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,540,758);
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
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">AAA</Col></Row><Row><Col id=\"Column0\">AAA</Col></Row><Row><Col id=\"Column0\">BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB</Col></Row><Row><Col id=\"Column0\">CCCC</Col></Row><Row><Col id=\"Column0\">DDD</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Grid("Grid00", "absolute", "12", "59", "516", "437", null, null, this);
            obj.set_taborder("0");
            obj.set_binddataset("Dataset00");
            obj.set_autosizingtype("row");
            obj.set_cellsizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"296\"/></Columns><Rows><Row size=\"60\" band=\"head\"/><Row size=\"60\"/><Row size=\"43\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/></Band><Band id=\"body\"><Cell style=\"background2:red;\" text=\"bind:Column0\" wordwrap=\"true\" autosizerow=\"limitmin\"/><Cell row=\"1\" style=\"background2:red;\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "388", "9", "129", "42", null, null, this);
            obj.set_taborder("1");
            obj.set_text("Button00");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmExam_002");
            		p.set_titletext("New Form");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.registerScript("frmExam_002.xfdl", function(exports) {

        this.Button00_onclick = function(obj,e)
        {
        	var n = this.Grid00.getRealRowFullSize();
        	
        	this.alert(n);
        	
        	this.Grid00.set_height(n+3);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.Button00.addEventHandler("onclick", this.Button00_onclick, this);

        };

        this.loadIncludeScript("frmExam_002.xfdl", true);

       
    };
}
)();
