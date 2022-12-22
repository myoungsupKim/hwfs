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
            obj = new ImageViewer("ivFPhoto", "absolute", "30.19%", "34", null, "130", "45.74%", null, this);
            obj.set_taborder("6");
            obj.set_stretch("fixaspectratio");
            this.addChild(obj.name, obj);

            obj = new Static("staPhotoT", "absolute", "1.85%", "29", null, "140", "71.85%", null, this);
            obj.set_taborder("7");
            obj.set_text("사진");
            obj.set_cssclass("sta_WF_PopTitle2");
            this.addChild(obj.name, obj);

            obj = new Button("btnCamera", "absolute", "55.19%", "35", null, "45", "26.67%", null, this);
            obj.set_taborder("8");
            obj.set_text("Camera");
            this.addChild(obj.name, obj);

            obj = new Button("btnPicture", "absolute", "77.59%", "184", null, "45", "3.7%", null, this);
            obj.set_taborder("9");
            obj.set_text("Gallery");
            this.addChild(obj.name, obj);

            obj = new Button("btnImgClose", "absolute", "55.19%", "83", null, "45", "36.48%", null, this);
            obj.set_taborder("10");
            obj.set_text("-");
            this.addChild(obj.name, obj);

            obj = new Button("btnCamera00", "absolute", "64.81%", "83", null, "45", "2.22%", null, this);
            obj.set_taborder("11");
            obj.set_text("Upload(미적용)");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto00", "absolute", "9", "184", "128", "128", null, null, this);
            obj.set_taborder("12");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto01", "absolute", "145", "184", "128", "128", null, null, this);
            obj.set_taborder("13");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto02", "absolute", "280", "184", "128", "128", null, null, this);
            obj.set_taborder("14");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto03", "absolute", "1.67%", "320", null, "128", "74.63%", null, this);
            obj.set_taborder("15");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto04", "absolute", "26.85%", "320", null, "128", "49.44%", null, this);
            obj.set_taborder("16");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto05", "absolute", "51.85%", "320", null, "128", "24.44%", null, this);
            obj.set_taborder("17");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto06", "absolute", "1.67%", "456", null, "128", "74.63%", null, this);
            obj.set_taborder("18");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto07", "absolute", "26.85%", "456", null, "128", "49.44%", null, this);
            obj.set_taborder("19");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto08", "absolute", "51.85%", "456", null, "128", "24.44%", null, this);
            obj.set_taborder("20");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "1.48%", "172", null, "1", "2.59%", null, this);
            obj.set_taborder("21");
            obj.style.set_background("black");
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
        this.addIncludeScript("frmSampleGetPicture.xfdl", "lib::sz_fsp_xp.xjs");
        this.addIncludeScript("frmSampleGetPicture.xfdl", "lib::sz_fsp_mobile_xp.xjs");
        this.registerScript("frmSampleGetPicture.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs"
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_mobile_xp.xjs", null, exports); }	//include "lib::sz_fsp_mobile_xp.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.F_sLocalFileName;	//파일url
        this.f_sPhotoName;	//사진파일명
        this.F_iFileLimitSize = 2097152;	// 업로드 파일 용량 제한 (2MB)

        /** 
         * 카메라버튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnCamera_onclick = function(obj,e)
        {
        	// 이미지 정보를 읽어온다. 
        	// 자세한 내용은 https://softzam.atlassian.net/wiki/pages/viewpage.action?pageId=2162885 사이트 참고 
        	var options = {
        		returnType : "F"	// 파일 리턴 유형 F- 파일 / D - byte[]에 대한 문자열 
        		, targetWidth : 1152		// 리턴받을 넓이
        		, targetHeight : 0	// 리턴받을 높이  
        //		, fileName : "test.jpg"	// 파일명
        		, quality : 50 	// 이미지 품질 ( 0 ~ 100 )
        		, deleteFile : "Y" 	// 실제 찍힌 사진 ( 카메라 폴더 )에  저장된 파일 삭제 여부 -> 파일명 지정시 "Y"로 설정 
        	};

        	this.fspmob_getPicture(this, options, "fsp_callbackCamera");
        }

        /** fsp callback 함수 (fsp_callbackCamera)
         * @param
        	errorCode : errorCode
        	message : message
         * @return : 없음
         * @note : fsb 서비스 호출 후 콜백 함수
         * errorCode < 0 경우 해당 message 팝업 처리함
         */
        this.fsp_callbackCamera = function (errorCode,message)
        {
        	if(errorCode != "0")
        	{
        		if(errorCode == 7) //"cancelled."
        		{
        			return false;
        		}
        		// application.goMain.gfn_Msg("ALERT_0", "오류", "["+errorCode+"] "+message, "OK", true, this);
        		application.goMain.gfn_Msg("ALERT_0", "메세지", message, "OK", true, this);		
        		return false;
        	}
        	else
        	{
        		// 파일명 저장
        		this.F_sLocalFileName = message;
        		this.fn_getFileSize(this.F_sLocalFileName);
        	}
        }

        /**
        *	현재 로컬 파일의 사이즈를 가져온다. 
        **/
        this.fn_getFileSize = function(sFileName)
        {
        	// var fileName = this.localFileName;
        	// alert("sFileName:"+sFileName);
        	this.fspmob_execute(this, "file", "getFileSize", [sFileName], "fsp_callbackGetFileSize");
        }

        this.fsp_callbackGetFileSize = function(errorCode,sSize) 
        {
        	if(errorCode != "0")
        	{
        		// application.goMain.gfn_Msg("ALERT_0", "오류", "["+errorCode+"] "+message, "OK", true, this);
        		application.goMain.gfn_Msg("ALERT_0", "메세지", "파일용량 확인에 실패하였습니다.", "OK", true, this);		
        		return false;
        	}
        	else
        	{
        		// alert("파일 사이즈:" + sSize);
        		if(sSize <= this.F_iFileLimitSize)
        		{
        			this.ivFPhoto.set_image("");
        			
        			//this.ivFPhoto.set_image(this.F_sLocalFileName);
        			this.ivFPhoto.set_image( 'url("'+this.F_sLocalFileName+'")' );
        		}
        		else
        		{
        			application.goMain.gfn_Msg("ALERT_0", "메세지", "파일용량이 2MB를 초과하였습니다.", "OK", true, this);		
        			return false;
        		}
        	}
        }

        /** 
         * 앨범(+)버튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnPicture_onclick = function(obj,e)
        {
        	// 이미지 정보를 읽어온다. 
        	// 자세한 내용은 https://softzam.atlassian.net/wiki/pages/viewpage.action?pageId=2162885 사이트 참고 
        	var options = {
        		returnType : "F"	// 파일 리턴 유형 F- 파일 / D - byte[]에 대한 문자열 
        		, targetWidth : 1152		// 리턴받을 넓이
        		, targetHeight : 0	// 리턴받을 높이
        //		, fileName : "move.jpg"	// 파일명
        		, quality : 50 	// 이미지 품질 ( 0 ~ 100 )
        		, deleteFile : "N" 	// 실제 찍힌 사진 ( 카메라 폴더 )에 저장된 파일 삭제 여부 -> 파일명 지정시 "Y"로 설정 
        	};

        	this.fspmob_getPictureFromAlbum(this, options, "fsp_callbackAlbum");	
        }

        /** fsp callback 함수 (fsp_callbackAlbum)
         * @param
        	errorCode : errorCode
        	message : message
         * @return : 없음
         * @note : fsb 서비스 호출 후 콜백 함수 
         * errorCode < 0 경우 해당 message 팝업 처리함
         */
        this.fsp_callbackAlbum = function (errorCode,message)
        {
        	if(errorCode != "0")
        	{
        		if(errorCode == 7) //"cancelled."
        		{
        			return false;
        		}
        		
        		application.goMain.gfn_Msg("ALERT_0", "메세지", message, "OK", true, this);		
        		return false;
        	}
        	else
        	{
        		if (message.length > 9)
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "이미지는 9장까지만 선택가능합니다.", "OK", true, this);
        			return;
        		}
        	
        		// 이미지 뿌려주기
        		var ivImageComp;
        		
        		var i;
        		for (i = 0; i < message.length; i++)
        		{
        			// alert("ImageFile :: "+message[i]);
        			ivImageComp = this.components["ivFPhoto0"+i];
        			ivImageComp.set_visible(true);
        			ivImageComp.set_image("");
        			ivImageComp.set_image( 'url("'+message[i]+'")' );
        		}
        		this.resetScroll();
        		
        		// 파일명 저장 
        		this.F_sLocalFileName = message;
        //		this.fn_getFileSize(this.F_sLocalFileName);
        // 		this.ivFPhoto.set_image("");
        // 		this.ivFPhoto.set_image(message);
        	}
        }

        /** 
         * 삭제(-_버튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnImgClose_onclick = function(obj,e)
        {
        	this.ivFPhoto.set_image("");
        }

        
        /** Message callback 함수
         * @param
        	id : id
        	rtn : type이 "OK" 일 때는 none
        	type이 "YN" 일 때는 "Y" or "N"
         * @return : 없음
         * @note : Alert 이나 Confirm 메시지의 콜백 함수
         *         gfn_Msg(...) 함수를 사용하여 띄운 창을 닫을 때 호출된다.
         */
        this.msg_callback = function (id,rtn)
        {
        	if (id == "ALERT_0") // 조회 시 오류
        	{
        		// 아무 일도 안함.
        	}
        }

        

        

        /*================================================================================
         * 이미지 업로드
         *===============================================================================*/
        this.btnCamera00_onclick = function(obj,e)
        {
        	this.fn_FileUpload();
        }

        
        /** 
         * 파일 업로드 서비스 호출
         * @param  : 없음
         * @return : true, false
         */
        this.fn_FileUpload = function()
        {
        	// 파일을 업로드할 주소 
        //	var svcUrl = "http://192.168.110.197/fileUpload.xpf";
        	var svcUrl = "http://202.30.38.223:9080/mobile/FileUploader";
        	//var svcUrl = "http://203.252.132.167:8080/FileUploader/";
        	
        	var saveFileName = this.ds_max.getColumn(0,"MOVE_NO")+"_"+this.f_sPhotoName;	// 서버에 저장 파일명 -> 지정하지 않을 경우 로컬의 파일명과 동일하게 저장 
        	
        	var jsonArgs = {
        		subDir : "admn/good/gds/"
        	};
        	// 파일 업로드를 호출하여 처리한다. 
        	this.fspmob_fileUpload(this, "fsp_callbackFileUpload", svcUrl, this.F_sLocalFileName, saveFileName, jsonArgs, "", false);
        }

        /** fsp callback 함수 (fsp_callbackFileUpload)
         * @param
        	errorCode : errorCode
        	message : message
         * @return : 없음
         * @note : fsb 서비스 호출 후 콜백 함수 (파일 업로드 처리 결과)
         * errorCode < 0 경우 해당 message 팝업 처리함
         */
        this.fsp_callbackFileUpload = function (errorCode,message)
        {
        	if(errorCode != "0")
        	{
        		// application.goMain.gfn_Msg("ALERT_0", "오류", "["+errorCode+"] "+message, "OK", true, this);
        		application.goMain.gfn_Msg("ALERT_0", "메세지", message, "OK", true, this);		
        		return false;
        	}
        	else
        	{
        // 		trace("fileFolder[message.data.fileSrc1]:"+message.data.fileSrc1
        // 		+"||fileName1[message.data.fileName1]:"+message.data.fileName1
        // 		+"||type1[message.data.type1]:"+message.data.type1
        // 		+"||orgFileName1[message.data.orgFileName1]:"+message.data.orgFileName1);
        		trace("파일업로드성공");
        	}
        }

        

        
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmCalendarTest_onload, this);
            this.btnCamera.addEventHandler("onclick", this.btnCamera_onclick, this);
            this.btnPicture.addEventHandler("onclick", this.btnPicture_onclick, this);
            this.btnImgClose.addEventHandler("onclick", this.btnImgClose_onclick, this);
            this.btnCamera00.addEventHandler("onclick", this.btnCamera00_onclick, this);

        };

        this.loadIncludeScript("frmSampleGetPicture.xfdl", true);

       
    };
}
)();
