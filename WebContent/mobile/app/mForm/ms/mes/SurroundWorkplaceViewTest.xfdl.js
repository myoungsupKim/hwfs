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
                this.set_name("SurroundWorkplaceView");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,540,758);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_list", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"latitude\" type=\"STRING\" size=\"256\"/><Column id=\"longitude\" type=\"STRING\" size=\"256\"/><Column id=\"distance\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"latitude\">37.575042</Col><Col id=\"longitude\">127.0248</Col><Col id=\"upjang\">한촌설렁탕</Col></Row><Row><Col id=\"latitude\">37.578771</Col><Col id=\"longitude\">127.02325</Col><Col id=\"upjang\">이연에프엔시</Col></Row><Row><Col id=\"longitude\">127.029505</Col><Col id=\"latitude\">37.57684</Col><Col id=\"upjang\">한화건설</Col></Row><Row><Col id=\"upjang\">한촌_신설동점</Col><Col id=\"latitude\">37.576968</Col><Col id=\"longitude\">127.022156</Col></Row><Row><Col id=\"upjang\">맛셈도시락</Col><Col id=\"latitude\">37.576775</Col><Col id=\"longitude\">127.026359</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Map("Map00", "absolute", "8", "121", "522", "627", null, null, this);
            this.addChild(obj.name, obj);

            obj = new Button("btn_currentPosition", "absolute", null, "67", "121", "47", "10", null, this);
            obj.set_taborder("2");
            obj.set_text("현재위치");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_dept", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("5");
            obj.set_displaynulltext("한촌-강남역점");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("6");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "4.63%", "178", null, "62", "74.07%", null, this);
            obj.set_taborder("7");
            obj.set_text("gpsOn");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", "28.33%", "178", null, "62", "50.37%", null, this);
            obj.set_taborder("8");
            obj.set_text("gpsOff");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", "51.48%", "178", null, "62", "25.37%", null, this);
            obj.set_taborder("9");
            obj.set_text("화면잠금");
            this.addChild(obj.name, obj);

            obj = new Button("Button03", "absolute", "36.48%", "279", null, "77", "40.37%", null, this);
            obj.set_taborder("10");
            obj.set_text("배지 설정");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00", "absolute", "6.67%", "275", null, "86", "67.04%", null, this);
            obj.set_taborder("11");
            obj.set_value("3");
            this.addChild(obj.name, obj);

            obj = new Button("btn_gpsOn", "absolute", null, "68", "121", "47", "265", null, this);
            obj.set_taborder("12");
            obj.set_text("GPS켜기");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btn_gpsOff", "absolute", null, "68", "121", "47", "137", null, this);
            obj.set_taborder("13");
            obj.set_text("GPS끄기");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btn_test", "absolute", null, "68", "121", "47", "393", null, this);
            obj.set_taborder("14");
            obj.set_text("테스트");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit01", "absolute", "352", "280", "167", "61", null, null, this);
            obj.set_taborder("15");
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
        this.addIncludeScript("SurroundWorkplaceViewTest.xfdl", "lib::lib_Com.xjs");
        this.addIncludeScript("SurroundWorkplaceViewTest.xfdl", "lib::sz_fsp_xp.xjs");
        this.addIncludeScript("SurroundWorkplaceViewTest.xfdl", "lib::sz_fsp_mobile_xp.xjs");
        this.registerScript("SurroundWorkplaceViewTest.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		기타관리
        // [부시스템명]	기타관리 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.05
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.05 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
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

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        //this.preDate = undefined;

        /*================================================================================
         * 2. Form관련 Script
         *===============================================================================*/
        /** 
         * Form의 모든 컴포넌트가 생성되고, 모든 Object가 Load 되었을 때에 발생하는 Event
         * @param
        	obj : Event가 발생한 Object
        	e : Event Object
         * @return : 없음
         */ 
        this.form_onload = function(obj,e)
        {
        	this.btn_gpsOn_onclick();
        	//this.btnCurrentPosition_onclick();
        	//필수
        	this.fn_init();
        }

        // 데이터 초기화
        this.fn_init = function ()
        {
        	//this.preDate = this.gfn_Today();
        	//this.cal_dtFrom.set_value(this.preDate);	
        }

        /*******************************************************************************
         * 기      능   : GPS를 ON시킨다
         ********************************************************************************/
        this.btn_gpsOn_onclick = function(obj,e)
        {
        	this.fspmob_gpsStart(this,2000,0,"fn_afterGpsStart");
        }

        /*******************************************************************************
         * 기      능   : GPS를 OFF시킨다
         ********************************************************************************/
        this.btn_gpsOff_onclick = function(obj,e)
        {
        	this.fspmob_gpsStop(this, "fn_afterGpsStop" );
        }

        
        this.btnMapTest_onclick = function(obj,e)
        {
        	this.fs_srcLatitude = "37.576683";
        	this.fs_srcLongitude = "127.025591";
        	this.fs_mapmarkerText = "현재위치";
        	this.Map00.removeItem("MapMarker");
        	
        	this.fn_loadMap(this.fs_srcLatitude, this.fs_srcLongitude, 17);
        	
        	this.fn_addMapmarker(this.fs_mapmarkerText);
        	
        	
        	//this.fn_loadMap(_latitude00, _longitude00, 17);
        }

        /*******************************************************************************
         * 기      능   : 현재위치를 불러온다.
         ********************************************************************************/
        this.btnCurrentPosition_onclick = function(obj,e)
        {
        	this.fspmob_getLocation(this, "fn_callbackGetLocation");
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
        	this.fn_alertResult(message);
        	
        	this.fs_srcLatitude = "37.576683";
        	this.fs_srcLongitude = "127.025591";
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
        	
        	// 컬럼 속성에 따른 설정 --------------------------
        	var max = this.ds_list.rowcount;
        	
        	var i;
        	for (i = 0; i < max; i++) 
        	{
        		var latitude = this.ds_list.getColumn(i, "latitude");
        		var longitude = this.ds_list.getColumn(i, "longitude");
        		
        		var distance = this.gf_calcDistance(this.fs_srcLatitude,this.fs_srcLongitude,latitude,longitude);
        		
        		//alert(distance);
        		var distanceReal = distance.replace("m","");
        		
        		if(distanceReal < 500){
        			
        			this.Map00.addItem("MapMarker"+i, obj_mapmarker);
        			
        			obj_mapmarker.location.latitude = latitude;
        			obj_mapmarker.location.longitude = longitude;
        			// alert("학과 = "+ds_list.getColumn(0, "HAKGWA"));
        			
        			alert(obj_mapmarker.location.longitude);
        			alert(obj_mapmarker.location.latitude);
        			
        			obj_mapmarker.set_text(this.ds_list.getColumn(i,"upjang"));
        			obj_mapmarker.set_visible(true);
        			obj_mapmarker.style.align.set_halign("left");
        			obj_mapmarker.style.align.set_valign("top");
        			obj_mapmarker.style.set_image(application._getServiceLocation("HWImage::sta_WF_pin.png"));
        		
        		}
        		
        		this.ds_list.setColumn(i, "distance", distance);		
        	}
        	
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

        this.fn_afterGpsStart = function (errorcode,message){
        	if(errorcode != 0){
        		alert(message);
        		return;
        	}
        	
        	this.fn_alertResult(message);
        }

        this.fn_alertResult = function(message){
        	var sTmp = "";
        	
        	for(i in message){
        		sTmp += i +" : " + message[i] +"\n";
        	}
        	alert(sTmp);
        }

        this.fn_afterGpsStop = function(errorcode,message){
        	if(errorcode != 0){
        		alert(message);
        	}
        }
        this.Button02_onclick = function(obj,e)
        {
        	this.fspmob_lockScreen(this,"1234","fn_afterLockScreen");
        }
        this.fn_afterLockScreen = function (errorcode,message){
        	if(errorcode!=0){
        		alert(message);
        	}
        	this.fn_alertResult(message);
        }
        this.Button03_onclick = function(obj,e)
        {
        	//formObj, apiName, methodName, args, callbackName
        	this.fspmob_execute(this,"notification","setBadgeCount",[this.Edit00.value],"fn_afterSetBadgeCount");
        }

        this.fn_afterSetBadgeCount = function (errorcode,message){
        	alert(message);
        	if(errorcode!=0){
        		alert(message);
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.Map00.addEventHandler("onload", this.Map00_onload, this);
            this.Map00.addEventHandler("onerror", this.Map00_onerror, this);
            this.btn_currentPosition.addEventHandler("onclick", this.btnCurrentPosition_onclick, this);
            this.Button00.addEventHandler("onclick", this.Button00_onclick, this);
            this.Button01.addEventHandler("onclick", this.Button01_onclick, this);
            this.Button02.addEventHandler("onclick", this.Button02_onclick, this);
            this.Button03.addEventHandler("onclick", this.Button03_onclick, this);
            this.btn_gpsOn.addEventHandler("onclick", this.btn_gpsOn_onclick, this);
            this.btn_gpsOff.addEventHandler("onclick", this.btn_gpsOff_onclick, this);
            this.btn_test.addEventHandler("onclick", this.btnMapTest_onclick, this);

        };

        this.loadIncludeScript("SurroundWorkplaceViewTest.xfdl", true);

       
    };
}
)();
