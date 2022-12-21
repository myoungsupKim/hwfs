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
                this.set_titletext("주변사업장보기");
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
            obj._setContents("<ColumnInfo><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangNm\" type=\"STRING\" size=\"256\"/><Column id=\"latitude\" type=\"STRING\" size=\"256\"/><Column id=\"longitude\" type=\"STRING\" size=\"256\"/><Column id=\"addr\" type=\"STRING\" size=\"256\"/><Column id=\"distance\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);

            obj = new GeoLocation("obj_geoLocation", this);
            this.addChild(obj.name, obj);
            obj = new GeoLocation("obj_geoLocation_watch", this);
            this.addChild(obj.name, obj);
            obj = new Dataset("ds_listAddedMarker", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"markerId\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Map("Map00", "absolute", "8", "121", "522", "627", null, null, this);
            obj.style.set_border("1 solid #808080");
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

            obj = new Static("Static42", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("6");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Button("btn_gpsOn", "absolute", null, "67", "121", "47", "-151", null, this);
            obj.set_taborder("12");
            obj.set_text("GPS켜기");
            obj.set_cssclass("btn_WF_Function");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_gpsOff", "absolute", null, "67", "121", "47", "-278", null, this);
            obj.set_taborder("13");
            obj.set_text("GPS끄기");
            obj.set_cssclass("btn_WF_Function");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_test", "absolute", null, "67", "139", "47", "-423", null, this);
            obj.set_taborder("14");
            obj.set_text("사업장기준");
            obj.set_cssclass("btn_WF_Function");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("15");
            obj.set_displaynulltext("한촌-강남점");
            obj.set_readonly("true");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("16");
            obj.set_cssclass("btn_WF_EdtSearch");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "4", "70", "404", "42", null, null, this);
            obj.set_taborder("17");
            obj.set_text(" ※ 현재위치 기준 반경 5Km내 가망고객위치를 표시합니다.");
            obj.style.set_color("red");
            obj.style.set_font("bold antialias 11 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendarTest");
            		p.set_titletext("주변사업장보기");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("SurroundWorkplaceView.xfdl", "lib::lib_Com.xjs");
        this.registerScript("SurroundWorkplaceView.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		주변사업장보기
        // [부시스템명]	주변사업장보기 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.05
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.05 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*==========================================================================
         * 1. 변수 선언
         *========================================================================*/
        this.fs_srcLatitude = "";
        this.fs_srcLongitude = "";
        this.fs_srcCampusID = "";
        this.fi_zoom = "";
        this.ds_mapListArg = "";
        this.fs_mapmarkerText = "";
        this.upjang = "";
        this.gubun = "";

        this.upjangLatitude = "";
        this.upjangLongitude = "";
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
        	//필수
        	this.fn_init();
        }

        // 데이터 초기화
        this.fn_init = function ()
        {	
        	this.btn_gpsOn_onclick();
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");
        	
        	//업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;	
        	
        	if(application.g_Mu_Cd == "2004")
        	{
        		this.gubun = "1"
        	}
        	else
        	{
        		this.gubun = "2"
        	}
        	
        	//this.fn_search(1);	//해당 사업장의 위도 경도를 불러온다
        	this.fn_search(2);
        	//this.btnCurrentPosition_onclick();
        }

        /** 
         * 사업장 검색 팝업 호출
         */
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.edt_upjang.value;
        	if(application.g_Mu_Cd == "2004")
        	{
        		arg[2] = "FMS";		
        	}
        	else
        	{
        		if(application.g_AuthLevel == "999" || application.g_AuthLevel == "99")
        		{
        			arg[4] = application.g_RoleSetId1;
        			arg[9] = "exception";
        			arg[10] = "AND A.MU_CD IN ('2002','2003')";
        			arg[11] = application.g_UpjangFlag1;
        			arg[12] = application.g_UpjangFlag2;
        		}
        		else
        		{
        			arg[4] = application.g_RoleSetId2;
        			arg[5] = application.g_AuthLevel;
        			arg[6] = application.g_EmpNo;
        			if(application.g_useTmCd == "Y")
        			{
        				arg[7] = application.g_Tm_Cd;
        			}
        			arg[8] = application.g_Mu_Cd;
        			arg[9] = application.g_UpjangGubun;
        			arg[11] = application.g_UpjangFlag1;
        			arg[12] = application.g_UpjangFlag2;
        		}	
        	}
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  사업장의 위도 경도를 불러온다.
        ********************************************************************************/
        this.fn_search = function(value)
        {	
        	if(value == 1)
        	{
        		var strSvcID   		 = "search1";
        	}
        	else if(value == 2)
        	{
        		this.upjang = "";
        		var strSvcID   		 = "search2";
        	}
        	else
        	{
        		this.upjang = "";
        		var strSvcID   		 = "search3";
        	}
        	
        	var strUrl     		 = "ms/mes/surroundWorkplaceView/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_list=ds_list";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(this.upjang));
        	    strArguments     += " gubun=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(this.gubun));
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        }

        /*******************************************************************************
         * 기      능   : GPS를 ON시킨다
         ********************************************************************************/
        this.btn_gpsOn_onclick = function(obj,e)
        {
        	// 모바일런티임 전환작업 - 20150715 김광호
        	this.obj_geoLocation_watch.watchStart(1, 2000);
        }

        /*******************************************************************************
         * 기      능   : GPS를 OFF시킨다
         ********************************************************************************/
        this.btn_gpsOff_onclick = function(obj,e)
        {
        	// 모바일런타임 전환작업 - 20150715 김광호
        	this.obj_geoLocation_watch.watchStop();
        }

        /*******************************************************************************
         * 기      능   : 현재 사업장 위도경도 기준 주변사업장표시
         ********************************************************************************/
        this.btnMapTest_onclick = function(obj,e)
        {
        	this.ds_listAddedMarker.clearData();
        	this.fn_search(3);	
        }

        this.fn_upjangPosition = function ()
        {
        	this.fs_srcLatitude = this.upjangLatitude;
        	this.fs_srcLongitude = this.upjangLongitude;
        	this.fs_mapmarkerText = "현재위치";
        	this.Map00.removeItem("MapMarker");
        	
        	// 컬럼 속성에 따른 설정 --------------------------
        	var max = this.ds_list.rowcount;
        	
        	var i;
        	for (i = 0; i < max; i++) 
        	{
        		var latitude = this.ds_list.getColumn(i, "latitude");
        		var longitude = this.ds_list.getColumn(i, "longitude");
        		
        		var distance = this.gf_calcDistance(this.fs_srcLatitude,this.fs_srcLongitude,latitude,longitude,"Y");
        		
        		if(distance < 5000){
        			
        			this.Map00.removeItem("MapMarker"+i);
        			
        		}		
        	}
        	
        	this.fn_loadMap(this.fs_srcLatitude, this.fs_srcLongitude, 17);
        	
        	this.fn_addMapmarker(this.fs_mapmarkerText);
        }

        /*******************************************************************************
         * 기      능   : 현재위치를 불러온다.
         ********************************************************************************/
        this.btnCurrentPosition_onclick = function(obj,e)
        {
        	this.fn_addMapmarker(this.fs_mapmarkerText);
        	//this.ds_listAddedMarker.clearData();
        	//this.fn_search(2);	
        }

        /*******************************************************************************
         * 기      능   : 맵을 로드한다.
         ********************************************************************************/
        this.fn_loadMap = function (fs_srcLatitude,fs_srcLongitude,fi_zoom)
        {
        	this.Map00.load(false, fs_srcLatitude, fs_srcLongitude, 0, fi_zoom);
        }

        /*******************************************************************************
         * 기      능   : 맵에 맵마커를 추가한다.
         ********************************************************************************/
        this.fn_addMapmarker = function (fs_mapmarkerText)
        {
           
        	// 맵마커제거 ----------------------------------------
        	var cnt = this.ds_listAddedMarker.rowcount;
        	for (var i=0; i<cnt; i++)
        	{
        		this.Map00.removeItem(this.ds_listAddedMarker.getColumn(i, "markerId"));
        	}
        	//this.ds_listAddedMarker.clearData();
        	//------------------------------------------------------
        	
        	// 사업장 표시  ---------------------------------------
        	var obj_mapmarker;
        	var max = this.ds_list.rowcount;
        	var row;
        	
        	var i;
        	for (i = 0; i < max; i++) 
        	{
        		var latitude = this.ds_list.getColumn(i, "latitude");
        		var longitude = this.ds_list.getColumn(i, "longitude");
        		
        		var distance = this.gf_calcDistance(this.fs_srcLatitude,this.fs_srcLongitude,latitude,longitude,"Y");
        		
        		//5KM내 업장만 보여준다.
        		if(distance < 5000){
        			
        			obj_mapmarker = new nexacro.MapMarker();
        			
        			var markerText  = "고객명:"+ this.ds_list.getColumn(i, "upjangNm")+"\n";
        				markerText += "주소:"+ this.ds_list.getColumn(i, "addr");
        			
        			obj_mapmarker.location.set_latitude(latitude);
        			obj_mapmarker.location.set_longitude(longitude);
        			obj_mapmarker.set_text(markerText);
        			obj_mapmarker.set_visible(true);
        			obj_mapmarker.style.set_image("%USERAPP%HWImage/sta_WF_pin.png");
        			
        			this.Map00.addItem("MapMarker"+i, obj_mapmarker);  //아이템 추가 고유 id값을 부여한다.
        			
        			row = this.ds_listAddedMarker.addRow();
        			this.ds_listAddedMarker.setColumn(row, "markerId", "MapMarker"+i);
        		}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
        		
        		this.ds_list.setColumn(i, "distance", distance);		
        	}
        	
        	// 현재위치 표시 -------------------------------------
        	obj_mapmarker = new nexacro.MapMarker();
        	
        	obj_mapmarker.location.set_latitude(this.fs_srcLatitude);
        	obj_mapmarker.location.set_longitude(this.fs_srcLongitude);
        	
        	obj_mapmarker.set_text("현재위치");
        	obj_mapmarker.set_visible(true);
        	
        	var tempMapMarker = this.Map00.addItem("MapMarker", obj_mapmarker);
        	
        	row = this.ds_listAddedMarker.addRow();
        	this.ds_listAddedMarker.setColumn(row, "markerId", "MapMarker");	
        }

        this.Map00_onload = function(obj,e)
        {
        	trace("맵 onload");
        }

        this.Map00_onerror = function(obj,e)
        {
        	trace("맵 onerror");
        }

        this.fn_alertResult = function(message){
        	var sTmp = "";
        	
        	for(i in message){
        		sTmp += i +" : " + message[i] +"\n";
        	}
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg)
        {	
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		return;
        	}
        	
            switch(strSvcID)
            {		
        		//해당사업장 위도 경도 호출
                case "search1" :
        			this.upjangLatitude = this.ds_list.getColumn(0, "latitude");  //해당 사업장 위도
        			this.upjangLongitude = this.ds_list.getColumn(0, "longitude"); //해당 사업장 경도	
        			break; 
        		//전체사업장 위도 경도 호출후 gps현재위치값 불러옴
        	    case "search2" :
        			// 모바일런타임 전환 작업 - 20150715 김광호
        			this.obj_geoLocation.getCurrentPosition(0, 10000);
        			break; 
        		//현재사업장 위도경도 기준 주변사업장 표시
        	    case "search3" :
        			this.fn_upjangPosition();	
        			break;			
        			
            }     
            
        }

         /*******************************************************************************
         * 기      능   : 현재위치 콜백 함수
         ********************************************************************************/
        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        // 현재위치 콜백
        this.obj_geoLocation_onrecvsuccess = function(obj,e)
        {
        	this.fn_alertResult(e.coords);
        	
        	this.fs_srcLatitude = nexacro.toNumber(e.coords.latitude);
        	this.fs_srcLongitude = nexacro.toNumber(e.coords.longitude);
        	this.fs_mapmarkerText = "현재위치";
        	
        	this.fn_loadMap(this.fs_srcLatitude, this.fs_srcLongitude, 17);
        	
        	this.fn_addMapmarker(this.fs_mapmarkerText);	
        	
        }

        this.obj_geoLocation_onrecverror = function(obj,e)
        {
        	 this.alert("GPS가 정상적이지 않습니다. GPS 기능을 확인하거나 위치를 이동해주세요.");
        	
        }

        // 위치 켜기 콜백
        this.obj_geoLocation_watch_onrecvsuccess = function(obj,e)
        {
        	this.fn_alertResult(e.coords);
        }

        this.obj_geoLocation_watch_onrecverror = function(obj,e)
        {

        }

        /** 
         * 팝업 callBack
         * @param  : popname - 팝업을 구분짓는 id
         rtn : 팝업이 닫히면서 전달된 값
         * @return : 없음
         */
        this.fn_callbackPOP = function (popname,rtn)
        {
        	switch (popname)
        	{
        		case "upjangNm":
        			this.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];			
        			this.fn_search(1);
        			break;				
        	}
        }

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.obj_geoLocation.addEventHandler("onrecvsuccess", this.obj_geoLocation_onrecvsuccess, this);
            this.obj_geoLocation.addEventHandler("onrecverror", this.obj_geoLocation_onrecverror, this);
            this.obj_geoLocation_watch.addEventHandler("onrecverror", this.obj_geoLocation_watch_onrecverror, this);
            this.obj_geoLocation_watch.addEventHandler("onrecvsuccess", this.obj_geoLocation_watch_onrecvsuccess, this);
            this.addEventHandler("onload", this.form_onload, this);
            this.Map00.addEventHandler("onload", this.Map00_onload, this);
            this.Map00.addEventHandler("onerror", this.Map00_onerror, this);
            this.btn_currentPosition.addEventHandler("onclick", this.fn_addMapmarker, this);
            this.btn_gpsOn.addEventHandler("onclick", this.btn_gpsOn_onclick, this);
            this.btn_gpsOff.addEventHandler("onclick", this.btn_gpsOff_onclick, this);
            this.btn_test.addEventHandler("onclick", this.btnMapTest_onclick, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);

        };

        this.loadIncludeScript("SurroundWorkplaceView.xfdl", true);

       
    };
}
)();
