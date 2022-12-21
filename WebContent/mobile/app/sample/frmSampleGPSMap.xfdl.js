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
                this.set_name("frmSampleComboList");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,540,758);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Button("Button00", "absolute", "72.59%", "16", null, "50", "3.7%", null, this);
            obj.set_taborder("0");
            obj.set_text("현재위치");
            this.addChild(obj.name, obj);

            obj = new Map("Map00", "absolute", "9", "73", "512", "608", null, null, this);
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", "42.96%", "16", null, "50", "33.33%", null, this);
            obj.set_taborder("1");
            obj.set_text("MapTest");
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
        this.addIncludeScript("frmSampleGPSMap.xfdl", "lib::sz_fsp_xp.xjs");
        this.addIncludeScript("frmSampleGPSMap.xfdl", "lib::sz_fsp_mobile_xp.xjs");
        this.registerScript("frmSampleGPSMap.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs"
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_mobile_xp.xjs", null, exports); }	//include "lib::sz_fsp_mobile_xp.xjs"
        /*==========================================================================
         * 1. 변수 선언
         *========================================================================*/
        this.fs_srcLatitude = "";
        this.fs_srcLongitude = "";
        this.fs_srcCampusID = "";
        this.fi_zoom = "";
        this.ds_mapListArg = "";
        this.fs_mapmarkerText = "";

        this.Button00_onclick = function(obj,e)
        {
        //	this.fspmob_gpsStart(this, 30, 5, "fn_gpsCallback");

        	this.fspmob_getLocation(this, "fn_callbackGetLocation");
        }

        this.Button01_onclick = function(obj,e)
        {
        	this.Map00.removeItem("MapMarker");
        	this.fn_loadMap("37.576626", "127.025876", 17);
        }

        /*******************************************************************************
         * 기      능   : 맵을 로드한다.
         ********************************************************************************/
        this.fn_loadMap = function (fs_srcLatitude,fs_srcLongitude,fi_zoom)
        {
        	this.Map00.load(false, fs_srcLatitude, fs_srcLongitude, 0, fi_zoom);
        }

        /*******************************************************************************
         * 기      능   : 현재위치 콜백 함수
         ********************************************************************************/
        this.fn_callbackGetLocation = function (errorCode,message)
        {
        	alert("errorCode :: "+errorCode);
        	alert("Latitude :: "+message.lat);
        	this.fs_srcLatitude = message.lat;
        	this.fs_srcLongitude = message.lon;
        	this.fs_mapmarkerText = "현재위치";
        	this.Map00.removeItem("MapMarker");
        	this.fn_loadMap(this.fs_srcLatitude, this.fs_srcLongitude, 17);
        	
        	this.fn_addMapmarker(this.fs_mapmarkerText);

        	if (errorCode == this.fsp.mobile.h.errorCode.OK) 
        	{
        		this.rtnStr = "현재 cellId=" + message.cellId + ",lac=" + message.lac;
        		trace(this.rtnStr);
        	}
        	else 
        	{
        		this.alert("처리에 실패했습니다.\n"
        			 + "errorCode:" + errorCode
        			 + "\nmessage:" + message);
        	}
        	
        //	this.fspmob_gpsStop(this, "fn_gpsCallback");
        }

        this.fn_gpsCallback = function (errorCode,message)
        {
        	trace("message :: "+message);
        //	this.fspmob_getLocation(this, "fn_callbackGetLocation");
        }

        /*******************************************************************************
         * 기      능   : 맵에 맵마커를 추가한다.
         ********************************************************************************/
        this.fn_addMapmarker = function (fs_mapmarkerText)
        {
        	// ex) 맵 마커 텍스트의 예
        // 	var markerText  = "건물코드:"+ this.ds_list.getColumn(0, "BLD_NO")+"<br>";
        // 		markerText += "건물 명 :"+ this.ds_list.getColumn(0, "BLD_NAME")+"<br>";
        // 	    markerText += "건물정보:"+ this.ds_list.getColumn(0, "BLD_COMMENT")+"<br>";
        // 		markerText += "<br>";

        	var obj_mapmarker = new nexacro.MapMarker();
        	var tempMapMarker = this.Map00.addItem("MapMarker", obj_mapmarker);
        	obj_mapmarker.location.latitude = this.fs_srcLatitude;
        	obj_mapmarker.location.longitude = this.fs_srcLongitude;
        	// alert("학과 = "+ds_list.getColumn(0, "HAKGWA"));
        	obj_mapmarker.set_text(fs_mapmarkerText);
        	obj_mapmarker.set_visible(true);
        	obj_mapmarker.style.align.set_halign("left");
        	obj_mapmarker.style.align.set_valign("top");
        	obj_mapmarker.style.set_image(application._getServiceLocation("HWImage::sta_WF_pin.png"));

        	
        	trace("마커표시 = " + tempMapMarker);
        }

        
        this.Map00_onload = function(obj,e)
        {
        	trace("맵 onload");
        }

        this.Map00_onerror = function(obj,e)
        {
        	trace("맵 onerror");
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmSampleComboList_onload, this);
            this.Button00.addEventHandler("onclick", this.Button00_onclick, this);
            this.Map00.addEventHandler("onload", this.Map00_onload, this);
            this.Map00.addEventHandler("onerror", this.Map00_onerror, this);
            this.Button01.addEventHandler("onclick", this.Button01_onclick, this);

        };

        this.loadIncludeScript("frmSampleGPSMap.xfdl", true);

       
    };
}
)();
