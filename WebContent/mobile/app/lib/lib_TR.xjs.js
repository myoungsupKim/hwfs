﻿//XJS=lib_TR.xjs
(function()
{
    return function(path)
    {
        var obj;
    
        // User Script
        this.registerScript(path, function(exports) {

        this.__DELIM__ = "|";

        /**
         * @class 공통 transaction 함수
         * @param objForm         - Form Object(this)
         * @param strSvcID        - 트랜잭션을 구분하기 위한 ID
         * @param strURL          - 트랜잭션을 요청할 주소
         * @param strInDatasets   - 트랜잭션을 요청할 때 입력값으로 보낼 데이터셋의 ID
         * @param strOutDatasets  - 트랜잭션을 처리 결과를 받을 데이터셋의 ID
         * @param strArgument     - 트랜잭션을 위한 인자값
         * @param strCallbackFunc - 트랜잭션의 결과를 돌려줄 함수의 이름
         * @param bAsync          - 비동기 여부(true: Async, false : Sync)
         * @param bProgress       - Wait Cursor 표시여부 (true : 사용, false : 사용안함)
         * @return 없음
         */
        this.gfn_transaction = function (objForm,strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc,bAsync,bProgress) 
        {
        	//트랜잭션 발생시마다 세션 만료시간을 초기화(BottomFrame에서 사용)
        	application.gv_sessionInit = "Y";		//세션 만료시간 초기화 여부
        	
            // Wait Cursor 표시여부
            if ((bProgress != true) && (bProgress != false)) bProgress = true;
            
            // 비동기 여부
            if ((bAsync != true) && (bAsync != false)) bAsync = true;
            
            // Wait Cursor 표시 설정
            try 
            {
                if ( bProgress == true )
                {
                    this.setWaitCursor(true, true);
                }
                else {
        			this.setWaitCursor(false, false);
                }
            } catch(e) {
                this.setWaitCursor(true, true);
            }
            
            try 
            {        
                //Frame ID
                var strFrameId = objForm.getOwnerFrame().name;
                
                //Transaction Start Time
                var objDate = new Date();
                var nStartTime = objDate.getTime(); //Milliseconds
                
                //Transaction ID
                var strTranId = strFrameId + "|" + bProgress.toString() + "|" + strSvcID + "|" + nStartTime + "|" + strCallbackFunc;
                
                // Argument 처리 (Global변수 추가)
                strArgument = strArgument + this.gfn_getGlobalVariable();

        		strURL = application.services["svc"].url + strURL;
        	        
                //전송형태 : 0(XML 타입), 1(Binary 타입), 2(SSV 타입)
                var nDataType = 0;
                
                //통신시 포스트데이터를 압축할지 여부
                var bCompress = false;

        		// 실행모드가 UX Studio 일때 전송형태, 압축여부 변경
        		if ( application.gv_runMode == "L" ) {
        			nDataType = 0;
        			bCompress = false;
        		}
        		
        		//서버에 데이터타입 전송하기 위해 설정 by kksoo
        		application.gv_xp_txdatatype = nDataType;
        		
                this.transaction(strTranId, strURL, strInDatasets, strOutDatasets, strArgument, "gfn_callBack", bAsync, nDataType, bCompress);
                
            } catch(e) {
                this.setWaitCursor(false, true);
                trace(e.message);
            }
        }

        /**
         * @class 공통 Callback 서비스
         * @param strTranId   - Client에서 임의로 생성하는 트랜잭션 ID
         * @param nErrorCode  - 에러코드
         * @param strErrorMag - 에러메시지
         * @return 없음
         */
        this.gfn_callBack = function (strTranId,nErrorCode,strErrorMsg) 
        {    
        	
        	/*** strTranId = strFrameId + "|" + bProgress + "|" + strSvcID + "|" + nStartTime + "|" + strCallbackFunc;  */    
            var arrTranId       = strTranId.split("|");
            var strFrameId      = arrTranId[0];
            var strProgress     = arrTranId[1];
            var strSvcID        = arrTranId[2];
            var nStartTime      = nexacro.toNumber(arrTranId[3]);
            var strCallbackFunc = arrTranId[4];
            
        	//CSRF 토큰 수신 변수를 전연변수에 설정 by kksoo
        	application.gv_savedToken = application.outSavedToken;
        	
            try {
                if ( strProgress == "true" )
                    this.setWaitCursor(false, true);
            } catch(e) {
                this.setWaitCursor(false, true);
            }
            
            if (!this.gfn_chkTransaction(strTranId, nErrorCode, strErrorMsg)) {
                if ( strSvcID == "login" ) 
                {
        			// this.av_close = 'CLOSE_FINISHED';
        			//application.exit(); //kksoo
        		}
                return;
            }
            
            //Transaction End Time
            var objDate    = new Date();
            var nEndTime   = objDate.getTime(); //Milliseconds
            var nElapseSec = (nEndTime - nStartTime) / 1000;
            
            /*
            var strLog  = "FrameID["+strFrameId+"], ServiceID["+strSvcID+"], ErrorCode["+nErrorCode+"], ErrorMsg["+strErrorMsg+"], 처리시간["+nElapseSec+"초]";
            trace(strLog);
            */
            
            if ( application.gfn_IsNull(strCallbackFunc) )    return;
            
            eval("this."+strCallbackFunc + "('" + strSvcID + "', nErrorCode, strErrorMsg)");    
        }

        /**
         * @class Transaction 호출 후 정리 처리등의 메세지 처리
         * @param strTranId   - Client에서 임의로 생성하는 트랜잭션 ID
         * @param nErrorCode  - 에러코드
         * @param strErrorMag - 에러메시지
         * @return 없음
         */
        this.gfn_chkTransaction = function (strTranId,nErrorCode,strErrorMsg) 
        {
        	if (nErrorCode == 0) 
            {
              return true;
            } 
            else {    
        		var arrTranId       = strTranId.split("|");
        		var strSvcID        = arrTranId[2];
        		
        		// 실행모드가 UX Studio 일때만 오류 출력
        		if ( application.gv_runMode == "L" ) {   
        			trace("Svc ID : " + strSvcID); 
        			trace("Error Code : " + nErrorCode); 
        			trace("Error Msg : " + strErrorMsg);
        		} 
        		
        		if ( strSvcID == "login") 
        		{
        			var values = strErrorMsg;
        			
        			if(values.indexOf('재설정') >= 0)
        			{
        				strErrorMsg =  "아이디 또는 비밀번호가 맞지 않습니다.";
        				strErrorMsg += "비밀번호 오류가 5회 이상 발생하여 계정이 잠겨 로그인을 할 수 없습니다.";
        				strErrorMsg += "PC로그인 화면에서 비밀번호를 재설정하셔야 합니다.";
        				strErrorMsg += "문의사항은 각 담당자에게 연락바랍니다.";
        			}
        			
        		}
                // nErrorCode == -100 인경우 Business Logic 에서 Error Check 한 경우
                // Error Code == 0 과 동이하게 단위 업무 화면으로 넘긴다.
                // 에러처리는 단위업무 화면에서 알아서 처리한다.
                if (nErrorCode == -100 || nErrorCode == 100) 
                {
                    return true;        
                } 
                // Session TimeOut 시 로그인팝업창 호출        
                else if (nErrorCode == -99) {
        			application.goButtom.fn_reLogin();
                } 
                // 나머지는 에러메시지 팝업으로 표시        
                else { 
        			//오류팝업 호출전 ARGUMENT 설정
        			var objArg = new Array();
        			
        // 			// 실행모드가 UX Studio 일때만 오류 메시지 보임 처리
        // 			if ( application.gv_runMode == "L" ) {
        // 				objArg[0] = nErrorCode;     // nErrorCode
        // 				objArg[1] = strSvcID + " 서비스에서 아래와 같은 오류가 발생하였습니다.\n\n" + strErrorMsg;    // strErrorMsg
        // 			}
        // 			else {
        // 				objArg[0] ="SYSTEM0001";
        // 				objArg[1] ="시스템에러 - 시스템관리자에게 문의해 주세요.";
        // 			}		
        			
        			objArg[0] = "오류";     // nErrorCode
        			objArg[1] = strErrorMsg;    // strErrorMsg
        			trace(">>>>    Dataset (" + strErrorMsg);
        			
        			if ( strSvcID == "login") 
        			{
        				application.goMain.gfn_Msg("alertLogin", objArg[0], objArg[1], "OK");
        				return true;
        			}
        			else
        			{
        				application.goMain.gfn_Msg("alertTest", objArg[0], objArg[1], "OK");
        				return true;
        			}			
                }
            }

            return true;
        }

        //●●● Need Checking
        this.Transaction = function (strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc)	   
        {
        	//trace("start strSvcID : " + strSvcID + " / strURL : "+ strURL + " / !http.Sync : " + !http.Sync + " / strCallbackFunc : " + strCallbackFunc);

            // 모든 통신시 WaitCursor 적용
            this.setWaitCursor(true, true);
            	
            // 동기일때는 setWaitCursor 표시
            //if(http.Sync) setWaitCursor(true, true);

        	//전송형태 : 0(XML 타입), 1(Binary 타입), 2(SSV 타입)
        	var nDataType = 1;
        	
        	//통신시 포스트데이터를 압축할지 여부
        	var bCompress = true;

        	// 실행모드가 UX Studio 일때 전송형태, 압축여부 변경
        	if ( application.gv_runMode == "L" ) {
        		nDataType = 0;
        		bCompress = false;
        	}
        	
        	// 공통 callback 사용하지 않을때
        	if(strCallbackFunc != "fsp_result")
        	{
        		strSvcID = strCallbackFunc + "&&" + strSvcID + "&&";
        		strCallbackFunc = "Transaction_result";
        	}

        	//Cookie에 Transaction DataType 추가 설정 by kksoo
        	gv_xp_txdatatype=nDataType;
        	   
           //!http.Sync 에 유의		
           this.transaction(strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, !http.Sync, nDataType, bCompress);   
           //trace("end strSvcID : " + strSvcID + " / strURL : "+ strURL);
        }

         /****************************************************************
         * Transaction 서버 호출후 전체 공통 Callback 서비스 
         * @param param 
         * @param errCode 에러 Code  
         * @param errMsg  에러 메시지 
         * @return 없음
        ******************************************************************/
        this.Transaction_result = function (param,ErrorCode,ErrorMsg) 
        {   
        	//trace("Transaction_result : " + param + " / " + ErrorCode + " / " + ErrorMsg);
        	setWaitCursor(false, true);
        	
        	var str = param.split("&");

            if ( ErrorCode != 0 ) 
            {
        		// nErrorCode == -100 인경우 Business Logic 에서 Error Check 한 경우
                if ( ErrorCode == -100 ) 
                {
                    // Business Exception 처리 : 메시지 처리하지 않고, 화면에서 처리
                }
                // Session TimeOut 시 로그인창 호출
                else if ( ErrorCode == -99 ) 
                {
                    application.goButtom.fn_reLogin();            
                } 
            }

        	// 업무 호출 
        	if ( !gfn_isNull(str[0]) ) {
        		if ( str[0].indexOf("(") > -1 ) {
        			var sFunction = str[0].substr(0,str[0].length-2);
        			eval(sFunction + "( str[2], ErrorCode, ErrorMsg )");
        		} else {
        			eval(str[0] + "( str[2], ErrorCode, ErrorMsg )");
        		}
        	}
        }

        /*********************************************************************************************
         * @type   : function
         * @access : public
         * @desc   : LogView에 데이터셋의 구조, 값을 확인한다.(개발자용)
         * @param  : obj - 데이터셋
         * @return :
         *********************************************************************************************/
        this.gfn_dsPrn = function (obj)
        {
        	//  Obj : Dataset 콤포넌트
        	var iColCnt = obj.colcount;
        	var iRowCnt = obj.rowcount;
        	var i, j; 
        	//------------------------------------------------
        	//   Header를 출력한다.
        	//------------------------------------------------ 
        	var sHeadStr="";
        	var sDsName="UnKnown Dataset";
        	 
        	sDsName = obj.id;
        	trace(">>>>    Dataset (" + sDsName + ") Tracing   ");
        	trace(">>>> " + "Col Cnt:" + iColCnt +" /  Row Cnt:" + iRowCnt);
        	 
        	for (j=0;j<iColCnt;j++)
        	{
        		sHeadStr += "[" + obj.getColID(j) +"] ";  
        	}
        	trace(">>>> COL ID : " + sHeadStr);
        	 
        	 //------------------------------------------------
        	 //   내용을 출력한다.
        	 //------------------------------------------------ 
        	var sRowStr="";
        	for (i=0;i<iRowCnt;i++)
        	{
        		sRowStr=obj.getRowType(i) + "::";
        		for (j=0;j<iColCnt;j++)
        		{
        			sRowStr += obj.getColID(j) + "[" + obj.getColumn(i,obj.getColID(j)) +"] ";  
        		}
        		trace(">>>> " + sRowStr);
        	}
        	trace(">>>> " + "---------------------------------------------------");
        }

        /*********************************************************************************************
         * @type   : function
         * @access : public
         * @desc   : Dataset의 데이터가 변경이 되었는지를 체크하는 함수
         * @param  : ds - 데이터셋
         * @return : 변경됨 : true, 변경되지 않음 : false
         *********************************************************************************************/
        this.gfn_getUpdate = function (ds)
        {
        	var nRowCnt = ds.rowcount;
        	var i;
        	var nType;
        	var flag = false;
        	
        	for(i=0; i<nRowCnt; i++)
        	{
        		nType = ds.getRowType(i);
        		
        		if(nType > 1)
        		{
        			flag = true;
        			
        			break;
        		}
        	}
        	
        	return flag;
        }

        /*********************************************************************************************
         * @type   : function
         * @access : public
         * @desc   : 해당 화면의 변경사항 체크
         * @param  : ds - 데이터셋
         * @return : 변경됨 : true, 변경되지 않음 : false
         *********************************************************************************************/
        this.gfn_isDataChange = function ()
        {
        	var bChange = false;
        	
        	var arrDataset = this.gfn_split(v_ds_check, ";");
            for (var i = 0; i < arrDataset.length ; i++ ) 
            {
        		var rtn = this.gfn_dsIsUpdated(eval(arrDataset[i]));
        		
        		if(rtn) 
                {
        			bChange = true;
        			break;
        		}
            }

            return bChange;
        }

        this.gfn_dsIsUpdated = function (objDs)
        {	
        	this.gfn_updateToDataset();
        	
            var bRtn = false;
            var sFilterStr = (objDs.filterstr).toString();
            
            // Filter되어있을 경우 UnFilter해서
            // 필터되어있던 Row에 대해서도 Update가 발생했는지 체크한다
            if(sFilterStr.length>0)    objDs.filter("");
            
            // 삭제건수 확인
            if (objDs.updatecontrol) {
                if (objDs.getDeletedRowCount() > 0) {
                    // 필터가 되어있었을 경우 다시 필터해준다.
                    if(sFilterStr.length>0) objDs.filter(sFilterStr);
                    return true;
                }
            }
            
            var iRowType;
            
            for (var i=0; i<objDs.getRowCount(); i++) {
                iRowType = objDs.getRowType(i);
                
                // insert, update, delete 확인
                if (iRowType == 2 || iRowType == 4 || iRowType == 8) {
                    bRtn = true;
                    break;
                }
            }
            
            // 필터가 되어있었을 경우 다시 필터해준다.
            if(sFilterStr.length > 0) objDs.filter(sFilterStr);
            
            return bRtn;    	
        }

        this.gfn_updateToDataset = function ()
        {
        	var objComp = this.getFocus();
        	
        	if (objComp != null) 
        	{
        		try 
        		{
        			objComp.updateToDataset();
        		}
        		catch (e) 
        		{
        		}
        	}
        }

         /*********************************************************************************************
         * @type   : function
         * @access : public
         * @class 서버에 전송할 Global 변수 정의
         * @param 없음
         * @return strVal
         *********************************************************************************************/
        this.gfn_getGlobalVariable = function () 
        {
        	var strVal  = "";

        	strVal += " sysType=" + nexacro.wrapQuote(application.g_SystemId);    				// Syetem ID
        	strVal += " menuId=" + nexacro.wrapQuote(application.gv_menuId);    				// 메뉴ID        
        	strVal += " prgId=" + nexacro.wrapQuote(application.gv_progrmId);  					// 프로그램 ID
        	strVal += " ktagTokenField=" + nexacro.wrapQuote(application.gv_ktagTokenField);   	// TokenField        	
        	strVal += " savedToken=" + nexacro.wrapQuote(application.gv_savedToken);    		// savedToken    		
        	strVal += " appId=" + nexacro.wrapQuote(application.g_SystemId);    				// appId    		

            return strVal;
        }
        });


    
        this.loadIncludeScript(path, true);
        
        obj = null;
    };
}
)();