//XJS=sz_fsp_xp.xjs
(function()
{
    return function(path)
    {
        var obj;
    
        // User Script
        this.registerScript(path, function(exports) {
        this.errorTrace = undefined;
        this.errorSqlStatus = undefined; //sql status code
        this.errorSqlCode = undefined;
        this.FSP_DS_CMD_NM = "fsp_ds_cmd";
        this.FSP_CURR_BIZ = "";
        this.FSP_DS_OBJ = null;
        this.FSP_IS_CREATE_DS = false; //데이터셋 생성 여부

        // 2011/04/11 추가 : 서비스 처리 트레이스 가져오기.
        this.fsp_svcTrace = "";
        /*****************************************************************
         * Action 정보를 보내기 위한 기초 정보 생성
         * @return 없음
         ******************************************************************/
        this.fsp_init = function ()
        {
        	if (this.FSP_IS_CREATE_DS) 
        	{
        		return;
        	}

        	// 데이터 셋 생성
        	var dsObj = new Dataset;
        	this.FSP_IS_CREATE_DS = true;
        	dsObj.set_name(this.FSP_DS_CMD_NM);
        	this.addChild(this.FSP_DS_CMD_NM, dsObj);
        	this.FSP_DS_OBJ = dsObj;
        	
        	dsObj.addColumn("TX_NAME", "string", 100);
        	dsObj.addColumn("TYPE", "string", 10);
        	dsObj.addColumn("SQL_ID", "string", 200);
        	dsObj.addColumn("KEY_SQL_ID", "string", 200);
        	dsObj.addColumn("KEY_INCREMENT", "INT", 10);
        	dsObj.addColumn("CALLBACK_SQL_ID", "STRING", 200);
        	dsObj.addColumn("INSERT_SQL_ID", "STRING", 200);
        	dsObj.addColumn("UPDATE_SQL_ID", "STRING", 200);
        	dsObj.addColumn("DELETE_SQL_ID", "STRING", 200);
        	dsObj.addColumn("SAVE_FLAG_COLUMN", "STRING", 200); //save 처리 시에 flag 처리 컬럼
        	dsObj.addColumn("USE_INPUT", "STRING", 1); //input 으로 사용할지 여부
        	dsObj.addColumn("USE_ORDER", "STRING", 1); //dataset order 사용 여부
        	dsObj.addColumn("KEY_ZERO_LEN", "INT", 10); //key 증가 시 key 의 문자 변환 값의 자리수
        	dsObj.addColumn("BIZ_NAME", "STRING", 100);

        	dsObj.addColumn("PAGE_NO", "INT", 10);
        	dsObj.addColumn("PAGE_SIZE", "INT", 10);
        	dsObj.addColumn("READ_ALL", "STRING", 1); //Y - 또는 N 	( 페이지 단위 처리 시 전체 조회 여부 )

        	// N : 에러 발생 시 전체 rollback 시킴.
        	// N1 : 에러 발생 시 해당 부분의 에러를 무시 하고 계속 수행 -> 뒤의 sql은 처리
        	// N2 : 에러 발생 시 해당 부분 에러 전까지의 처리 결과는 commit 처리 , 뒷 부분은 수행하지 않음.
        	// Exception 은 발생하고 처리는 하지 않음.
        	dsObj.addColumn("EXEC_TYPE", "STRING", 2); //처리 방법 - B ( 배치 ), N( 단건 )

        	// return 되는 정보
        	dsObj.addColumn("EXEC", "STRING", 1); //처리 여부
        	dsObj.addColumn("FAIL", "STRING", 1); //실패 여부
        	dsObj.addColumn("FAIL_MSG", "STRING", 200); //실패 메시지
        	dsObj.addColumn("EXEC_CNT", "INT", 1); //반영건수
        	dsObj.addColumn("MSG", "STRING", 200); //메시지
        }

        /*****************************************************************
         * 자바 코딩 없이 사용할 경우 서버에서 처리하기 위한 Action 호출
         * 정보를 추가
         * @param txType 호출하는 Transaction 타입
         S - Insert, Update , Delete 동시 처리
         M - 주어진 SQL 정보에 대해 Dataset이 존재하는 건 만큼 반복처리
         CSV - 조회용 SQL 만 가능하며, 데이터 조회 후 CSV 형태로 데이터를 넘겨 줌.
         * @param sqlName 처리할 Main SQL ID
         txType이 'S'인 경우에는 해당 sql은 사용되지 않는다.
         * @param keySqlName PK 조회용 SQL ID
         * @param keyIncrement keySqlName이 존재할 경우만 사용되며,
         반복적인 처리 Sql의 경우 다음 정보 key 증가 값
         현재는 integer 형의 숫자형 key만 처리 가능
         * @param callbackSql 처리가 완료된 후 결과로써 반환할 Sql Id
         * @param insertSql  txType이 'S'인 경우 또는 sqlName 파라메터가 존재하면서 해당하는
         main sql에 대해서 master-detail 구조일 경우
         insert를 처리할 SQL ID
         * @param updateSql  txType이 'S'인 경우 또는 sqlName 파라메터가 존재하면서 해당하는
         main sql에 대해서 master-detail 구조일 경우
         update를 처리할 SQL ID
         * @param deleteSql  txType이 'S'인 경우 또는 sqlName 파라메터가 존재하면서 해당하는
         main sql에 대해서 master-detail 구조일 경우
         delete를 처리할 SQL ID
         * @param saveFlagColumn  insertSql, updateSql, deleteSql이 존재하여 신규, 수정, 삭제를
         처리할 경우 기본적으로 Dataset의 getRowStates()로 판단하여 처리
         하나 이를 Flag 컬럼으로 대체하고 싶은 경우 사용
         해당 Flag 컬럼의 값은 신규 - I , 수정 - U , 삭제 - D의 값을
         가져야 한다.
         * @return 없음
         ******************************************************************/
        this.fsp_add = function (txType,sqlName,keySqlName,keyIncrement,callbackSql,insertSql,updateSql,deleteSql,saveFlagColumn,keyZeroLen,execType)
        {
        	var cmdDs = this.FSP_DS_OBJ;
        	var row = cmdDs.addRow();

        	cmdDs.setColumn(row, "TYPE", txType);
        	cmdDs.setColumn(row, "SQL_ID", sqlName);
        	cmdDs.setColumn(row, "KEY_SQL_ID", keySqlName);
        	if (keyIncrement == null || keyIncrement == ""
        		 || keyIncrement < 0) 
        	{
        		keyIncrement = "0";
        	}
        	if (keyZeroLen == null || keyZeroLen == ""
        		 || keyZeroLen < 0) 
        	{
        		keyZeroLen = "0";
        	}

        	cmdDs.setColumn(row, "KEY_INCREMENT", keyIncrement);
        	cmdDs.setColumn(row, "CALLBACK_SQL_ID", callbackSql);
        	cmdDs.setColumn(row, "INSERT_SQL_ID", insertSql);
        	cmdDs.setColumn(row, "UPDATE_SQL_ID", updateSql);
        	cmdDs.setColumn(row, "DELETE_SQL_ID", deleteSql);
        	cmdDs.setColumn(row, "SAVE_FLAG_COLUMN", saveFlagColumn);
        	cmdDs.setColumn(row, "KEY_ZERO_LEN", keyZeroLen);
        	cmdDs.setColumn(row, "BIZ_NAME", this.FSP_CURR_BIZ);

        	if (execType == null || execType.length == 0) 
        	{
        		cmdDs.setColumn(row, "EXEC_TYPE", "B");
        	}
        	else 
        	{
        		cmdDs.setColumn(row, "EXEC_TYPE", execType);
        	}
        }
        /*****************************************************************
         * 조회용 Action 정보 생성 ( 자바 코드 없이 사용할 경우 )
         * @param sqlName 조회할 SQL ID
         * @param isUseInput 조회한 결과는 Input Dataset으로 사용할지 여부
         * @param isNotUseOrder Dataset 컬럼 생성시 정렬할지 여부
         * @return 없음
         ******************************************************************/
        this.fsp_addSearch = function (sqlName,isUseInput,isNotUseOrder,rtnDsId)
        {
        	this.fsp_add("N", sqlName, "", "", "", "", "", "", rtnDsId
        	);

        	if (isUseInput == true) 
        	{
        		var cmdDs = this.FSP_DS_OBJ;
        		cmdDs.setColumn(cmdDs.getRowCount() - 1, "USE_INPUT", "Y");
        	}

        	if (isNotUseOrder == true) 
        	{
        		var cmdDs = this.FSP_DS_OBJ;
        		cmdDs.setColumn(cmdDs.getRowCount() - 1, "USE_ORDER", "N");
        	}
        }
        /*****************************************************************
         * 페이지 단위 조회용 Action 정보 생성 ( 자바 코드 없이 사용할 경우 )
         * @param sqlName 조회할 SQL ID
         * @param pageNo 페이지 번호
         * @param pageSize 페이지 사이즈
         * @param isAllRead 주어진 페이지 이후로 전체 데이터를 읽을지 유무
         * @param isUseInput 조회한 결과는 Input Dataset으로 사용할지 여부
         * @param isNotUseOrder Dataset 컬럼 생성시 정렬할지 여부
         * @return 없음
         ******************************************************************/
        this.fsp_addPageSearch = function (sqlName,pageNo,pageSize,isAllRead,isUseInput,isNotUseOrder)
        {
        	this.fsp_addSearch(sqlName, isUseInput, isNotUseOrder);

        	var cmdDs = this.FSP_DS_OBJ;
        	if (isAllRead) 
        	{
        		cmdDs.setColumn(cmdDs.getRowCount() - 1, "READ_ALL", "Y");
        	}
        	else 
        	{
        		cmdDs.setColumn(cmdDs.getRowCount() - 1, "READ_ALL", "N");
        	}

        	cmdDs.setColumn(cmdDs.getRowCount() - 1, "PAGE_NO", pageNo);
        	cmdDs.setColumn(cmdDs.getRowCount() - 1, "PAGE_SIZE", pageSize);
        }
        /*****************************************************************
         * 조회용 Action 정보 생성 ( 자바 코드 없이 사용할 경우 )
         * CSV 용으로 사용
         * @param sqlName 조회할 SQL ID
         * @param recvCount  전송받을 Count ( 정의하지 않을 경우 기본 : 100 )
         * @return 없음
         ******************************************************************/
        this.fsp_addCSVSearch = function (sqlName,recvCount)
        {
        	this.fsp_add(
        		"CSV", sqlName, "", "", "", "", "", "", "");
        }
        /*****************************************************************
         * 단일 처리 Action 정보 생성
         * @param sqlName 단일 처리 SQL ID
         * @param keySqlName PK 조회용 SQL ID
         * @param keyIncrement keySqlName이 존재할 경우만 사용되며,
         반복적인 처리 Sql의 경우 다음 정보 key 증가 값
         현재는 integer 형의 숫자형 key만 처리 가능
         * @param callbackSql 처리가 완료된 후 결과로써 반환할 Sql Id
         * @param execType 처리해야 하는 실행타입 정의 ( B - 배치 , N - 한건 씩 처리 )
         * @return 없음
         ******************************************************************/
        this.fsp_addSingle = function (sqlName,keySqlName,keyIncrement,callbackSql,execType)
        {
        	this.fsp_add(
        		"N", sqlName, keySqlName, keyIncrement, callbackSql, "", "", "", "", null, execType);
        }
        /*****************************************************************
         * SaveAction 정보 생성 ( getRowType() 또는 주어진 Flat 컬럼의 값을 읽어
         등록, 수정, 삭제를 처리는 SQL 요청 정보 생성 )
         * @param insertSql  txType이 'S'인 경우 또는 sqlName 파라메터가 존재하면서 해당하는
         main sql에 대해서 master-detail 구조일 경우
         insert를 처리할 SQL ID
         * @param updateSql  txType이 'S'인 경우 또는 sqlName 파라메터가 존재하면서 해당하는
         main sql에 대해서 master-detail 구조일 경우
         update를 처리할 SQL ID
         * @param deleteSql  txType이 'S'인 경우 또는 sqlName 파라메터가 존재하면서 해당하는
         main sql에 대해서 master-detail 구조일 경우
         delete를 처리할 SQL ID
         * @param saveFlagColumn  insertSql, updateSql, deleteSql이 존재하여 신규, 수정, 삭제를
         처리할 경우 기본적으로 Dataset의 getRowStates()로 판단하여 처리
         하나 이를 Flag 컬럼으로 대체하고 싶은 경우 사용
         해당 Flag 컬럼의 값은 신규 - I , 수정 - U , 삭제 - D의 값을
         가져야 한다.
         * @param keySqlName PK 조회용 SQL ID
         * @param keyIncrement keySqlName이 존재할 경우만 사용되며,
         반복적인 처리 Sql의 경우 다음 정보 key 증가 값
         현재는 integer 형의 숫자형 key만 처리 가능
         * @param callbackSql 처리가 완료된 후 결과로써 반환할 Sql Id
         * @param keyZeroLen  Key 에 0 채워야 할 경우 0 의 갯수
         * @param execType 처리해야 하는 실행타입 정의 ( B - 배치 , N - 한건 씩 처리 )
         * @return 없음
         ******************************************************************/
        this.fsp_addSave = function (insertSql,updateSql,deleteSql,saveFlagColumn,keySqlName,keyIncrement,callbackSql,keyZeroLen,execType)
        {
        	this.fsp_add(
        		"S", "", keySqlName, keyIncrement, callbackSql, insertSql, updateSql, deleteSql, saveFlagColumn, keyZeroLen, execType);
        }
        /*****************************************************************
         * 주어진 SQL을 Dataset 건수 만큼 반복적으로 처리하는 action 정보 생성
         * @param sqlId  처리할 SQL
         * @param keySqlName  Key SQL이 존재할 경우 SQL ID
         * @param keyIncrement  Key 증가 값
         * @param callbackSql  처리 완료 후 반환할 정보를 조회할 SQL ID
         * @param keyZeroLen  Key 에 0 채워야 할 경우 0 의 갯수
         * @param execType 처리해야 하는 실행타입 정의 ( B - 배치 , N - 한건 씩 처리 )
         * @return 없음
         ******************************************************************/
        this.fsp_addMulti = function (sqlId,keySqlName,keyIncrement,callbackSql,keyZeroLen,execType)
        {
        	this.fsp_add(
        		"M", sqlId, keySqlName, keyIncrement, callbackSql, "", "", "", "", keyZeroLen, execType);
        }
        /*****************************************************************
         * SELECT를 수행한 후 정보 존재 유무에 따라 별도의 SQL을 처리할 수 있는
         Action 정보 생성
         * @param selectSqlId  조회 처리용 SQL
         * @param notFoundSql  조회 결과 없을 경우 처리할 SQL
         * @param foundSql  조회 결과가 존재할 경우 처리할 SQL
         * @param execType 처리해야 하는 실행타입 정의 ( B - 배치 , N - 한건 씩 처리 )
         * @return 없음
         ******************************************************************/
        this.fsp_addSelectExecute = function (selectSqlId,notFoundSql,foundSql,execType)
        {
        	this.fsp_add(
        		"AS", selectSqlId, "", "", "", foundSql, notFoundSql, "", "", "", execType);
        }
        /*****************************************************************
         * 자바 코딩 없이 사용할 경우 Action 호출 정보 초기화하기
         * @return  Action 정보를 저장하고 있는 Dataset이 초기화 된다.
         ******************************************************************/
        this.fsp_clear = function ()
        {
        	this.FSP_CURR_BIZ = "";
        	// this.all(FSP_DS_CMD_NM).clearData();
        	this.FSP_DS_OBJ.clearData();
        }
        /*****************************************************************
         ** quote 붙이기
         ******************************************************************/
        this.fsp_quote = function (str)
        {
        	if (str == null) 
        	{
        		return "\"\"";
        	}

        	return "\"" + str + "\"";
        }
        /****************************************************************
         * 서버 호출
         * @param actionName  서버에서 호출할 Action의 별명
         기본은 defaultAction을 호출하도록 되어있다.
         * @param cmdName  Action 안에서 호출해야 하는 메소드 명
         기본은 execute를 호출하도록 되어있다.
         * @param inData  서버로 전송할 DataSet 객체 Str
         예: ds_select=dst_select:A ds_select2=dst_select2
         * @param outData  서버로부터 전송 받을  DataSet 객체 String
         예:  dst_master=ds_servername
         * @param otherArg  서버로 전송할 기타 Argument 정보 String
         예: key=value key2=value2
         * @param callBackFnc  서버에서 처리가 완료된 후 Callback 받을 Function 명
         메소드 작성은 callBackFnc(errCode, errMsg) 형태로 작성
         * @param isErrorNotCall  에러 발생 시 Callback 함수 호출 여부
         * @param isNotShow  처리중입니다. 메시지 창 보여줄지 여부 설정하기
         * @param isSync  동기식으로 설정할지 여부
         * @param trId  Transaction ID 등 callback에서 넘겨 받을 String을 지정
         * @return 없음
         * 호출 예 : fsp_callService(this, "", "actionName, "search", "dst_master=ds_master");
         ***************************************************************/
        this.fsp_callService = function (formObj
                ,actionName
                ,cmdName
                ,inData
                ,outData
                ,otherArg
                ,callBackFnc
                ,isErrorNotCall 
                ,isNotShow
                ,isSync
                ,trId
                ,svcDataUrl)        
        {
        	// setWaitCursor(true);
        	//뒤로가기 체크를 위한 cnt 추가
        	application.gvWaitCount++;
        	
        	if (isErrorNotCall == undefined || isErrorNotCall == null) 
        	{
        		isErrorNotCall = false;
        	}

        	if (trId == undefined || trId == null) 
        	{
        		trId = "";
        	}
        	
        	//Transaction Start Time
            var objDate = new Date();
            var nStartTime = objDate.getTime(); //Milliseconds

        	//동일 트랜으로 인식해서 Sendbox 방지를 위해... 
            var strRequstTime = Math.random() * 100000000000000000;

        	var param = callBackFnc + "&" + isErrorNotCall + "&" + trId + "&" + nStartTime + "&" + strRequstTime;

        	// Argument 처리
        	var arg = "";
        	actionName = this.fn_getActionName(actionName);
        	arg += "fsp_action=" + this.fsp_quote(actionName);

        	if (cmdName == null || cmdName.length == 0) 
        	{
        		cmdName = "execute";
        	}

        	arg += " fsp_cmd=" + this.fsp_quote(cmdName);

        	// global variable 처리
        	arg += " " + this.fn_getGlobalVariable();

        	// global variable 처리 
        	arg += " g_AuthLevel=" + this.fsp_quote(application.g_AuthLevel);
        	arg += " g_Deptid=" + this.fsp_quote(application.g_Deptid);
        	arg += " g_EmpNo=" + this.fsp_quote(application.g_EmpNo);
        	arg += " g_Name=" + this.fsp_quote(application.g_Name);
        	arg += " g_SystemId=" + this.fsp_quote(application.g_SystemId);
        	arg += " g_Upjang=" + this.fsp_quote(application.g_Upjang);
            arg += " g_UserKind=" + this.fsp_quote(application.g_UserKind);
            arg += " g_UpjangGroup=" + this.fsp_quote(application.g_UpjangGroup);
        	arg += " g_Main_Upjang=" + this.fsp_quote(application.g_Main_Upjang);
        	arg += " g_Tm_Cd=" + this.fsp_quote(application.g_Tm_Cd);
        	arg += " g_Cc_Cd=" + this.fsp_quote(application.g_Cc_Cd);
        	arg += " g_Sc_Cd=" + this.fsp_quote(application.g_Sc_Cd);
        	
        	//[[김재섭:개인정보 보안과 관련된 정보를 추가함.
        	arg += " g_PersInfoAgreeYn=" + this.fsp_quote(application.g_PersInfoAgreeYn); 
        	arg += " g_PersInfoMask=" + this.fsp_quote(application.g_PersInfoMask); 
        	arg += " g_PersInfoProcLevel=" + this.fsp_quote(application.g_PersInfoProcLevel); 
        	//김재섭:개인정보 보안과 관련된 정보를 추가함.]]
        	
        	// log id 처리 
        	var clientId = "all";//ext_GetIPAddress();
        	arg += " fsp_logId=" + this.fsp_quote( clientId );

        	if (otherArg != null && otherArg.length > 0) 
        	{
        		arg += " " + otherArg;
        	}

        	// Local인 경우 Local service 타도록
        	var strDataGroup = "svc";	
        	if( !this.gfn_isNull(svcDataUrl)) {
        		strDataGroup = svcDataUrl;
        	}
        	
        	if (this.FSP_IS_CREATE_DS) 
        	{
        		// 공백부터 시작할 경우 Error 발생
        		if (inData != null && inData.length > 0) 
        		{
        			inData += " fsp_ds_cmd=" + this.FSP_DS_CMD_NM;
        		}
        		else 
        		{
        			inData = "fsp_ds_cmd=" + this.FSP_DS_CMD_NM;
        		}
        		if (outData != null && outData.length > 0) 
        		{
        			outData += " " + this.FSP_DS_CMD_NM + "=fsp_ds_cmd";
        		}
        		else 
        		{
        			outData = this.FSP_DS_CMD_NM + "=fsp_ds_cmd";
        		}
        	}

        	// Application 그룹별 서버 접속 Url 가져오기 
        	var serverUrl = application.services[strDataGroup].url + "XMain";

        	if (isNotShow != undefined && isNotShow != null && isNotShow) 
        	{
        		// 처리중입니다. 메시지 처리
        		application.set_usewaitcursor(false);
        	}

        	var isHttpAsync = true;
        	// 동기식 설정
        	
        	if (isSync != undefined && isSync != null && isSync == true) 
        	{
        		isHttpAsync = false;
        	}    
            
            this.transaction(param, serverUrl, inData, outData, arg, "fsp_result", isHttpAsync);
        }

        /****************************************************************
        ###### JSP를 통해 서버 호출시 Error Code, Sync, 처리중 팝업메세지  처리하는 공통함수 ###########################
        * @param formObj 해당 스크립트를 호출하는 Form 객체 
                         호출 Form에서 보통 this 로 넘김. 
        * @param svcID 서비스 ID
        * @param svcUrl 서비스 URL
        * @param inData  서버로 전송할 DataSet 객체 Str
                         예: ds_select=dst_select:A ds_select2=dst_select2
        * @param outData  서버로부터 전송 받을  DataSet 객체 String
                          예:  dst_master=ds_servername     
        * @param otherArg  서버로 전송할 기타 Argument 정보 String
                           예: key=value key2=value2
        * @param callBackFnc  서버에서 처리가 완료된 후 Callback 받을 Function 명
                              메소드 작성은 callBackFnc(errCode, errMsg) 형태로 작성 
        * @param isErrorNotCall  에러 발생 시 Callback 함수 호출 여부                        
        * @param isNotShow  처리중입니다. 메시지 창 보여줄지 여부 설정하기   
        * @param isSync  동기식으로 설정할지 여부                          
        * @return 없음
        * 호출 예 : jsp_transaction(this,"FSP00030E_T004", "S_FSP::FSP00030E_T004.jsp","ds_potype=ds_potype", "dst_master=ds_master","aa=aa","callback",true,false,false);
        ***************************************************************/
        this.jsp_transaction = function (formObj,svcID,svcUrl,inData,outData,otherArg,callBackFnc,isErrorNotCall,isNotShow,isSync,trId,svcDataUrl) {
        	
        	if ( isErrorNotCall == null ) {
        		isErrorNotCall = false;
        	}

            //Transaction Start Time
            var objDate = new Date();
            var nStartTime = objDate.getTime(); //Milliseconds

        	//동일 트랜으로 인식해서 Sendbox 방지를 위해... 
            var strRequstTime = Math.random() * 100000000000000000;
            
        	var param = callBackFnc + "&" + isErrorNotCall + "&" + svcID + "&" + nStartTime + "&" + strRequstTime;
        	
        	// Argument 처리 
        	var arg = "";
        	
        	// global variable 처리 
        	arg += "g_AuthLevel=" + this.fsp_quote(application.g_AuthLevel);
        	arg += " g_Deptid=" + this.fsp_quote(application.g_Deptid);
        	arg += " g_EmpNo=" + this.fsp_quote(application.g_EmpNo);
        	arg += " g_Name=" + this.fsp_quote(application.g_Name);
        	arg += " g_SystemId=" + this.fsp_quote(application.g_SystemId);
        	arg += " g_Upjang=" + this.fsp_quote(application.g_Upjang);
        	arg += " g_UserKind=" + this.fsp_quote(application.g_UserKind);
        	arg += " g_UpjangGroup=" + this.fsp_quote(application.g_UpjangGroup);
        	arg += " g_Main_Upjang=" + this.fsp_quote(application.g_Main_Upjang);
        	arg += " g_Tm_Cd=" + this.fsp_quote(application.g_Tm_Cd);
        	arg += " g_Cc_Cd=" + this.fsp_quote(application.g_Cc_Cd);
        	arg += " g_Sc_Cd=" + this.fsp_quote(application.g_Sc_Cd);
        	
        	//[[김재섭:개인정보 보안과 관련된 정보를 추가함.
        	arg += " g_PersInfoAgreeYn=" + this.fsp_quote(application.g_PersInfoAgreeYn); 
        	arg += " g_PersInfoMask=" + this.fsp_quote(application.g_PersInfoMask); 
        	arg += " g_PersInfoProcLevel=" + this.fsp_quote(application.g_PersInfoProcLevel); 
        	//김재섭:개인정보 보안과 관련된 정보를 추가함.]]
        	
        	if ( otherArg != null && otherArg.length > 0 ) {
               arg += " " + otherArg;
        	}
        	
            // 메시지 초기화 
            errorTrace = "";
        	
            var isHttpAsync = true;
        	// 동기식 설정
        	if (isSync != undefined && isSync != null && isSync == true) 
        	{
        		isHttpAsync = false;
        	}
            
            this.transaction(param, svcUrl, inData, outData, arg, "fsp_result", isHttpAsync); 	
        }

        /****************************************************************
         * 서버 호출후 전체 공통 Callback 서비스
         * @param param
         * @param errCode 에러 Code
         * @param errMsg  에러 메시지
         * @return 없음
         ******************************************************************/
        this.GV_HTTPCODE = "";
        this.fsp_result = function (param,ErrorCode,ErrorMsg)
        {
        	//뒤로가기 체크를 위한 cnt 추가
        	application.gvWaitCount--;

        	//trace("------ fsp_result" + param + ": " + ErrorCode + ":" + ErrorMsg);
        	
        	// fn_destroyWait();
        	// setWaitCursor(false);

        	// 분석
        	var str = param.split("&");

        	// Http Error
        	if (this.GV_HTTPCODE.length > 0) 
        	{
        		var arrErrorList = this.GV_HTTPCODE.split(this.lookupFunc("chr").call(30));
        		ErrorCode = parseInt(arrErrorList[0]);
        		ErrorMsg = arrErrorList[1];

        		ErrorMsg = ErrorMsg.replace(ErrorCode.toString() + ":", "");

        		if ((ErrorCode == -2085613056) || (ErrorCode == -2085605317)) 
        		{
        			ErrorMsg += "\n\n동일한 현상이 발생할 경우, 시스템 관리자에게 연락하시기 바랍니다.";
        		}
        		else if ((ErrorCode == -2085601264) || (ErrorCode == -2085613056)) 
        		{
        			ErrorMsg = ErrorMsg.split('해당경로에 파일을 찾을수 없습니다').join('네트워크 연결에 실패 하였습니다');
        			ErrorMsg += "\n\n동일한 현상이 발생할 경우, 시스템 관리자에게 연락하시기 바랍니다.";
        		}
        	}
        	
        	if (ErrorCode != 0) 
        	{
        		if (ErrorCode == -100 || ErrorCode == 100) 
                {
                    return true;   
                         
                }else if (ErrorCode == -99) {
        			application.goMainSub.fn_reLogin();
                } 
        		else 
        		{
        			var SYS_MSG = this.errorTrace;
        			// 메시지 초기화
        			this.errorTrace = "";
        			if (SYS_MSG == undefined || SYS_MSG == "") 
        			{
        				if (ErrorMsg == "FAILED") 
        				{
        					ErrorMsg = "서버에 연결하는 동안\n문제가 발생하였습니다.\n관리자에게 문의하여 주십시요.";
        				}
        			}			
        		}
        		
        		// 업무 호출
        		if (str[1] != "true") 
        		{
        			if (str[0].length > 0) 
        			{
        				eval("this." + str[0] + "( ErrorCode, ErrorMsg, str[2] )");
        			}
        		}
        	}
        	else 
        	{
        		if (str[0].length > 0) 
        		{trace("-toh str[0] : " + str[0]);
        			eval("this." + str[0] + "( ErrorCode, ErrorMsg, str[2] )");
        		}
        	}
        }
        /****************************************************************
         * 서버를 호출하여 처리한 서비스에 대한 트레이스를 가져온다.
         * @return 서비스 호출 트레이스
         ******************************************************************/
        this.fsp_getServiceTrace = function ()
        {
        	return this.fsp_svcTrace;
        }
        /****************************************************************
         * action Name 가져오기
         * @param actionName 현재 처리해야 하는 action name
         * @return 없음
         ******************************************************************/
        this.fn_getActionName = function (actionName)
        {
        	//if (actionName.length == 0) 
        	if (actionName == null || actionName.length == 0)  
        	{
        		actionName = "xDefaultAction";
        	}

        	return actionName; 
        }

        /******************************************************
         * 서버에 전송할 Global 변수 정의
         ******************************************************/
        this.fn_getGlobalVariable = function ()
        {
        	return;
        	// "GV_USER_ID='" + GV_USER_ID + "' ";
        }
        /******************************************************
         * 서버에서 처리한 후의 에러 메시지 창 표시
         ******************************************************/
        this.fn_showSysError = function (sMsg)
        {
        	// if ( IsExistFunc("fsp_fn_showSysError") ) {
        	// fsp_fn_showSysError(sMsg);
        	// } else {
        	// this.alert(sMsg);
        	// }
        }
        /******************************************************
         *  로그인이 안되어 있을 경우 처리
         ******************************************************/
        this.fn_notLogin = function ()
        {
        	// if ( IsExistFunc("fsp_fn_notLogin") ) {
        	// fsp_fn_notLogin();
        	// } else {
        	//this.alert("로그아웃 되었습니다.");
        	// }
        }
        /**************************************************************************************
         *  Debug Message 처리
         * @param  obj  debug 메시지를 표시할 객체
         **************************************************************************************/
        this.fsp_debug = function (obj,level)
        {
        }
        /**************************************************************************************
         *  DataSet 전체 내용 보기
         * @param  dsObj  DataSet 객체
         **************************************************************************************/
        this.fsp_debugDs = function (dsObj,isNotTrace)
        {
        	// Dataset ID 출력
        	var tempStr = "Dataset [" + dsObj.name + "]\n";

        	// Column Data 출력
        	for (var i = 0; i < dsObj.getRowCount(); i++) 
        	{
        		tempStr = tempStr + "Row " + i + " [" + dsObj.getRowType(i) + "]\n";

        		for (var j = 0; j < dsObj.getColCount(); j++) 
        		{
        			this.lookupSetter("tempGetColumn", "set_tempGetColumn").set(dsObj.getColumn(i, j));
        			tempStr = tempStr + dsObj.getColID(j) + ":" + this.lookup("tempGetColumn") + "\n";
        		}
        	}

        	// 삭제된 데이터 출력
        	for (var i = 0; i < dsObj.getDeletedRowCount(); i++) 
        	{
        		tempStr = tempStr + "Deleted Row " + i + "\n";

        		for (var j = 0; j < dsObj.getColCount(); j++) 
        		{
        			this.lookupSetter("tempGetColumn", "set_tempGetColumn").set(dsObj.getDeletedColumn(i, j));
        			tempStr = tempStr + dsObj.getColID(j) + ":" + this.lookup("tempGetColumn") + "\n";
        		}
        	}

        	if (isNotTrace) 
        	{
        		return tempStr;
        	}

        	trace(tempStr);
        }
        /**************************************************************************************
         * 기본적으로 MaskEdit등을 사용하여 일자를 표시할 수 없을 경우
         * 문자에 - 등의 Delimiter 로 포맷팅 처리
         * @param  sDate  날짜 ( YYYYMM 또는 YYYYMMDD )
         * @param  sDel  - / 등의 구분자 ( 기본은 - 로 처리 )
         **************************************************************************************/
        this.fsp_formatDate = function (sDate,sDel)
        {
        	if (sDel == null || sDel.length == 0) 
        	{
        		sDel = "-";
        	}

        	var rtn = sDate;
        	var sTime = "";
        	switch (sDate.length) 
        	{
        		case 14:
        			// 시분초 처리
        			sTime = " " + sDate.substr(8, 2) + ":"
        				 + sDate.substr(10, 2) + ":"
        				 + sDate.substr(12, 2);
        		case 8:
        			// 일자 처리
        			rtn = sDate.substr(0, 4) + sDel
        				 + sDate.substr(4, 2) + sDel
        				 + sDate.substr(6, 2);
        			break;
        		case 6:
        			rtn = sDate.substr(0, 4) + sDel + sDate.substr(4, 2);
        			break;
        	}

        	return rtn + sTime;
        }

        
        /**************************************************************************************
         * NULL CHECK
         * 문자에 - 등의 Delimiter 로 포맷팅 처리
         * @param  sDate  날짜 ( YYYYMM 또는 YYYYMMDD )
         * @param  sDel  - / 등의 구분자 ( 기본은 - 로 처리 )
         **************************************************************************************/
        this.tfn_isNull = function (sVal,sDispText,objFocus)
        {
        	if (sVal == undefined || sVal == null || sVal.trim() == "") 
        	{
        		this.alert("[" + sDispText + "] 필수입력 항목입니다.\n입력하여 주십시오.");
        		objFocus.setFocus();
        		return true;
        	}
        	return false;
        }

        
        this.tfn_alert = function (sMsg)
        {
        	this.alert(sMsg);
        }
        // 메시지 정의
        this.MW00001 = "SQL 구문을 작성해 주십시오.";
        this.MW00002 = "[${}] 필수입력 항목입니다.\n입력하여 주십시오.";
        this.MW00003 = "해당 SQL문은 서버에 저장되지 않았습니다.";
        this.MW00004 = "연결 가능한 ${}가 없습니다.";
        this.MW00005 = "동적 SQL문은 해당 기능으로 테스트 불가능 합니다.";
        this.MW00006 = "올바르지 않은 SQL 구문입니다.\nINSERT/UPDATE/SELECT/DELETE 로 시작하는 구문을 작성해 주십시오.";
        this.MW00007 = "하위의 그룹정보를 먼저 삭제하십시오.";
        this.MW00008 = "하위 그룹이 존재할 경우 그룹명은 변경할 수 없습니다.";
        this.MW00009 = "최상위 그룹은 삭제할 수 없습니다.";
        this.MW00010 = "${}을 먼저 입력해 주십시오.";
        this.MW00011 = "해당 화면에 대한 정보가 설정되어 있지 않아 사용 불가능합니다.";

        this.MI00001 = "처리를 완료했습니다.";
        this.MI00002 = "${}를 삭제하시겠습니까?.";
        this.ME00001 = "처리에 실패했습니다.";
        this.MI00003 = "조회를 완료했습니다.";
        this.MI00004 = "SQLMAP이 변경되었습니다.\n화면을 초기화 하시겠습니까?";
        this.MI00005 = "SQLMAP이 변경되었습니다.\n새 탭에 오픈하시겠습니까?";

        /*
         ******************************************************************************************
         * 함  수  명   : gfn_msg
         * 입      력   : msg = 메시지 , arr = 메시지 대체 스트링 또는 배열
         * 반      환   : 변환된 메시지
         * 기      능   : 메시지 가져오기
         * 작  성  자   : 조은영
         * ----------------------------------------------------------------------------------------
         * HISTORY    :
         ******************************************************************************************
         */
        this.tfn_msg = function (msg,arr)
        {
        	// \n 처리
        	msg = msg.split("\\n").join(String.fromCharCode(10));

        	if (arr == undefined || arr == null || arr.length == 0 || this.fsp_isNull(msg)) 
        	{
        		return msg;
        	}

        	// ${} 포함 문자열 대체
        	var sPos = new Array();
        	var oMsg = msg;
        	var cnt = 0;
        	var p = -1;
        	var rMsg = "";
        	while (true) 
        	{
        		p = oMsg.indexOf("${}");
        		if (p == -1) 
        		{
        			break;
        		}
        		rMsg = rMsg + oMsg.substr(0, p);
        		// if ( type(arr) == "ARRAY") {
        		// rMsg = rMsg + arr[cnt];
        		// } else {
        		rMsg = rMsg + arr;
        		// }
        		oMsg = oMsg.substr(p + 3);
        		cnt++;
        	}

        	rMsg = rMsg + oMsg;
        	return rMsg;
        }

        /*
         ******************************************************************************************
         * 함  수  명   : tfn_confirm
         * 입      력   : str = 메시지
         * 반      환   : 없음
         * 기      능   : 메시지 창 띄위기
         * 작  성  자   : 조은영
         * ----------------------------------------------------------------------------------------
         * HISTORY    :
         ******************************************************************************************
         */
        this.tfn_confirm = function (str)
        {
        	return this.confirm(str, "확인", "question");
        }

        this.fsp_isNull = function (sVal)
        {
        	if (sVal == undefined || sVal == null || sVal.trim() == "") 
        	{
        		return true;
        	}
        	return false;
        }
        
        });


    
        this.loadIncludeScript(path, true);
        
        obj = null;
    };
}
)();
