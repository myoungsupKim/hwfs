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
                this.set_name("frmGalS3");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,720,1230);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new ImageViewer("ImageViewer00", "absolute", "0", "0", "720", "1230", null, null, this);
            obj.set_taborder("0");
            obj.style.set_border("2 solid #808080ff");
            obj.set_image("URL('img::main_all.jpg')");
            obj.set_stretch("fixaspectratio");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 720, 1230, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmGalS3");
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

        this.loadIncludeScript("frmGalS3.xfdl", true);

       
    };
}
)();
