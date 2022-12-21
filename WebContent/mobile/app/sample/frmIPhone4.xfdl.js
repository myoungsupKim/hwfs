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
                this.set_name("frmIPhone4");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,640,960);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new ImageViewer("ImageViewer00", "absolute", "0", "0", "640", "960", null, null, this);
            obj.set_taborder("0");
            obj.set_image("URL('img::main_all.jpg')");
            obj.set_stretch("fit");
            obj.style.set_border("2 solid #808080ff");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 640, 960, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmIPhone4");
            		p.set_titletext("New Form");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script

        
        // Regist UI Components Event
        this.on_initEvent = function()
        {

        };

        this.loadIncludeScript("frmIPhone4.xfdl", true);

       
    };
}
)();
