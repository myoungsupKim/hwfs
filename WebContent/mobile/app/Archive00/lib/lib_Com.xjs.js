//XJS=lib_Com.xjs
(function()
{
    return function(path)
    {
        var obj;
    
        // User Script
        this.addIncludeScript(path, "lib::lib_Date.xjs");
        this.addIncludeScript(path, "lib::lib_HW.xjs");
        this.addIncludeScript(path, "lib::lib_POP.xjs");
        this.addIncludeScript(path, "lib::lib_String.xjs");
        this.addIncludeScript(path, "lib::lib_TR.xjs");
        this.addIncludeScript(path, "lib::sz_fsp_mobile_xp.xjs");
        this.addIncludeScript(path, "lib::sz_fsp_xp.xjs");
        this.addIncludeScript(path, "lib::po_common.xjs");
        this.registerScript(path, function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Date.xjs", null, exports); }	//include "lib::lib_Date.xjs";
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_HW.xjs", null, exports); }	//include "lib::lib_HW.xjs";
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_POP.xjs", null, exports); }	//include "lib::lib_POP.xjs";
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_String.xjs", null, exports); }	//include "lib::lib_String.xjs";
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_TR.xjs", null, exports); }	//include "lib::lib_TR.xjs";
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_mobile_xp.xjs", null, exports); }	//include "lib::sz_fsp_mobile_xp.xjs";
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs";
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::po_common.xjs", null, exports); }	//include "lib::po_common.xjs";
        });


    
        this.loadIncludeScript(path, true);
        
        obj = null;
    };
}
)();
