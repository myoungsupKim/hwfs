<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/메뉴지도                                                                                                                                                                    
■ 프로그램ID   : FSM00600E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 메뉴지도 신청                                                                                                                                               
■ 작성일자     : 2015-03-20                                                                                                                                                                           
■ 작성자       : 김민수                                                                                                                                                                                
■ 이력관리     :                                                                                                                                                                             
-----------------------------------------------------------------------------*/                                                                                                                         
%> 

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;
	try {
	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);

		DataSet ds_guidReqMst = in_dl.get("ds_guidReqMst");	// 메뉴지도 신청정보

		String g_EmpNo                   = in_vl.getString("g_EmpNo");
		String GUID_YEAR                 = "";
		String GUID_SEQ                  = "";
		String REQ_NUM                   = "";
		String UPJANG                    = "";
		String TM_CD                     = "";
		String CHARGE_SABUN              = "";
		String APPOINT_DD                = "";
		String OPEN_DD                   = "";
		String RECONTRACT_DD             = "";
		String CHARGE_SABUN_UPJANG_A     = "";
		String CHARGE_SABUN_UPJANG_B     = "";
		String CHARGE_SABUN_UPJANG_C     = "";
		String CHARGE_SABUN_DUTY_START_A = "";
		String CHARGE_SABUN_DUTY_START_B = "";
		String CHARGE_SABUN_DUTY_START_C = "";
		String CHARGE_SABUN_DUTY_END_A   = "";
		String CHARGE_SABUN_DUTY_END_B   = "";
		String CHARGE_SABUN_DUTY_END_C   = "";
		String CHARGE_SABUN_JOB_ASSIGN_A = "";
		String CHARGE_SABUN_JOB_ASSIGN_B = "";
		String CHARGE_SABUN_JOB_ASSIGN_C = "";
		String MEAL_UPRICE_A             = "";
		String MEAL_UPRICE_B             = "";
		String MEAL_UPRICE_C             = "";
		String MEAL_UPRICE_D             = "";
		String AVG_MEAL_QTY_A            = "";
		String AVG_MEAL_QTY_B            = "";
		String AVG_MEAL_QTY_C            = "";
		String AVG_MEAL_QTY_D            = "";
		String RATION_METHOD_A           = "";
		String RATION_METHOD_B           = "";
		String RATION_METHOD_C           = "";
		String RATION_METHOD_D           = "";
		String RAW_MTR_RATE_PLAN         = "";
		String RAW_MTR_RATE_ACT          = "";
		String COOKS_A_PSN               = "";
		String COOKS_B_PSN               = "";
		String KTCN_GRIL_YN              = "";
		String KTCN_OVEN_YN              = "";
		String KTCN_ETC_YN               = "";
		String KTCN_ETC_CONTENTS         = "";
		String PATRON_AGES10             = "";
		String PATRON_AGES20             = "";
		String PATRON_AGES30             = "";
		String PATRON_AGES40             = "";
		String PATRON_AGES50             = "";
		String PATRON_AGES60             = "";
		String MAN_PATRON_RATE           = "";
		String WOMAN_PATRON_RATE         = "";
		String MENU_PRFR                 = "";
		String NO_MENU_PRFR              = "";
		String GUID_REQUEST_REASON       = "";
		String UPJANG_SPCL_FACT          = "";
		String STATUS_CD                 = "";
		String RTN_REASON                = "";
		String GUID_PRCG                 = "";
		
		int RowStatus;
		StringBuffer sbSql = new StringBuffer();
		
		// 메뉴지도 신청 등록, 수정
		int RowCnt = ds_guidReqMst.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_guidReqMst.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				GUID_YEAR                 = nullToBlank(ds_guidReqMst.getString(i, "GUID_YEAR"));                
				GUID_SEQ                  = nullToBlank(ds_guidReqMst.getString(i, "GUID_SEQ"));                 
				UPJANG                    = nullToBlank(ds_guidReqMst.getString(i, "UPJANG"));                   
				TM_CD                     = nullToBlank(ds_guidReqMst.getString(i, "TM_CD"));                    
				CHARGE_SABUN              = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN"));             
				APPOINT_DD                = nullToBlank(ds_guidReqMst.getString(i, "APPOINT_DD"));               
				OPEN_DD                   = nullToBlank(ds_guidReqMst.getString(i, "OPEN_DD"));                  
				RECONTRACT_DD             = nullToBlank(ds_guidReqMst.getString(i, "RECONTRACT_DD"));            
				CHARGE_SABUN_UPJANG_A     = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_UPJANG_A"));    
				CHARGE_SABUN_UPJANG_B     = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_UPJANG_B"));    
				CHARGE_SABUN_UPJANG_C     = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_UPJANG_C"));    
				CHARGE_SABUN_DUTY_START_A = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_START_A"));
				CHARGE_SABUN_DUTY_START_B = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_START_B"));
				CHARGE_SABUN_DUTY_START_C = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_START_C"));
				CHARGE_SABUN_DUTY_END_A   = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_END_A"));  
				CHARGE_SABUN_DUTY_END_B   = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_END_B"));  
				CHARGE_SABUN_DUTY_END_C   = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_END_C"));  
				CHARGE_SABUN_JOB_ASSIGN_A = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_JOB_ASSIGN_A"));
				CHARGE_SABUN_JOB_ASSIGN_B = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_JOB_ASSIGN_B"));
				CHARGE_SABUN_JOB_ASSIGN_C = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_JOB_ASSIGN_C"));
				MEAL_UPRICE_A             = nullToBlank(ds_guidReqMst.getString(i, "MEAL_UPRICE_A"));            
				MEAL_UPRICE_B             = nullToBlank(ds_guidReqMst.getString(i, "MEAL_UPRICE_B"));            
				MEAL_UPRICE_C             = nullToBlank(ds_guidReqMst.getString(i, "MEAL_UPRICE_C"));            
				MEAL_UPRICE_D             = nullToBlank(ds_guidReqMst.getString(i, "MEAL_UPRICE_D"));            
				AVG_MEAL_QTY_A            = nullToBlank(ds_guidReqMst.getString(i, "AVG_MEAL_QTY_A"));           
				AVG_MEAL_QTY_B            = nullToBlank(ds_guidReqMst.getString(i, "AVG_MEAL_QTY_B"));           
				AVG_MEAL_QTY_C            = nullToBlank(ds_guidReqMst.getString(i, "AVG_MEAL_QTY_C"));           
				AVG_MEAL_QTY_D            = nullToBlank(ds_guidReqMst.getString(i, "AVG_MEAL_QTY_D"));           
				RATION_METHOD_A           = nullToBlank(ds_guidReqMst.getString(i, "RATION_METHOD_A"));          
				RATION_METHOD_B           = nullToBlank(ds_guidReqMst.getString(i, "RATION_METHOD_B"));          
				RATION_METHOD_C           = nullToBlank(ds_guidReqMst.getString(i, "RATION_METHOD_C"));          
				RATION_METHOD_D           = nullToBlank(ds_guidReqMst.getString(i, "RATION_METHOD_D"));          
				RAW_MTR_RATE_PLAN         = nullToBlank(ds_guidReqMst.getString(i, "RAW_MTR_RATE_PLAN"));        
				RAW_MTR_RATE_ACT          = nullToBlank(ds_guidReqMst.getString(i, "RAW_MTR_RATE_ACT"));         
				COOKS_A_PSN               = nullToBlank(ds_guidReqMst.getString(i, "COOKS_A_PSN"));              
				COOKS_B_PSN               = nullToBlank(ds_guidReqMst.getString(i, "COOKS_B_PSN"));              
				KTCN_GRIL_YN              = nullToBlank(ds_guidReqMst.getString(i, "KTCN_GRIL_YN"));             
				KTCN_OVEN_YN              = nullToBlank(ds_guidReqMst.getString(i, "KTCN_OVEN_YN"));             
				KTCN_ETC_YN               = nullToBlank(ds_guidReqMst.getString(i, "KTCN_ETC_YN"));              
				KTCN_ETC_CONTENTS         = nullToBlank(ds_guidReqMst.getString(i, "KTCN_ETC_CONTENTS"));        
				PATRON_AGES10             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES10"));            
				PATRON_AGES20             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES20"));            
				PATRON_AGES30             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES30"));            
				PATRON_AGES40             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES40"));            
				PATRON_AGES50             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES50"));
				PATRON_AGES60             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES60"));
				MAN_PATRON_RATE           = nullToBlank(ds_guidReqMst.getString(i, "MAN_PATRON_RATE"));          
				WOMAN_PATRON_RATE         = nullToBlank(ds_guidReqMst.getString(i, "WOMAN_PATRON_RATE"));        
				MENU_PRFR                 = nullToBlank(ds_guidReqMst.getString(i, "MENU_PRFR"));                
				NO_MENU_PRFR              = nullToBlank(ds_guidReqMst.getString(i, "NO_MENU_PRFR"));             
				GUID_REQUEST_REASON       = nullToBlank(ds_guidReqMst.getString(i, "GUID_REQUEST_REASON"));      
				UPJANG_SPCL_FACT          = nullToBlank(ds_guidReqMst.getString(i, "UPJANG_SPCL_FACT"));         
				STATUS_CD                 = nullToBlank(ds_guidReqMst.getString(i, "STATUS_CD"));                
				RTN_REASON                = nullToBlank(ds_guidReqMst.getString(i, "RTN_REASON"));               
				GUID_PRCG                 = nullToBlank(ds_guidReqMst.getString(i, "GUID_PRCG"));                
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSM_MENU_GUID_REQ                  \n");
				sbSql.append("(                                              \n");
				sbSql.append("       GUID_YEAR                               \n");
				sbSql.append("     , GUID_SEQ                                \n");
				sbSql.append("     , REQ_NUM                                 \n");
				sbSql.append("     , UPJANG                                  \n");
				sbSql.append("     , TM_CD                                   \n");
				sbSql.append("     , CHARGE_SABUN                            \n");
				sbSql.append("     , APPOINT_DD                              \n");
				sbSql.append("     , OPEN_DD                                 \n");
				sbSql.append("     , RECONTRACT_DD                           \n");
				sbSql.append("     , CHARGE_SABUN_UPJANG_A                   \n");
				sbSql.append("     , CHARGE_SABUN_UPJANG_B                   \n");
				sbSql.append("     , CHARGE_SABUN_UPJANG_C                   \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_START_A               \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_START_B               \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_START_C               \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_END_A                 \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_END_B                 \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_END_C                 \n");
				sbSql.append("     , CHARGE_SABUN_JOB_ASSIGN_A               \n");
				sbSql.append("     , CHARGE_SABUN_JOB_ASSIGN_B               \n");
				sbSql.append("     , CHARGE_SABUN_JOB_ASSIGN_C               \n");
				sbSql.append("     , MEAL_UPRICE_A                           \n");
				sbSql.append("     , MEAL_UPRICE_B                           \n");
				sbSql.append("     , MEAL_UPRICE_C                           \n");
				sbSql.append("     , MEAL_UPRICE_D                           \n");
				sbSql.append("     , AVG_MEAL_QTY_A                          \n");
				sbSql.append("     , AVG_MEAL_QTY_B                          \n");
				sbSql.append("     , AVG_MEAL_QTY_C                          \n");
				sbSql.append("     , AVG_MEAL_QTY_D                          \n");
				sbSql.append("     , RATION_METHOD_A                         \n");
				sbSql.append("     , RATION_METHOD_B                         \n");
				sbSql.append("     , RATION_METHOD_C                         \n");
				sbSql.append("     , RATION_METHOD_D                         \n");
				sbSql.append("     , RAW_MTR_RATE_PLAN                       \n");
				sbSql.append("     , RAW_MTR_RATE_ACT                        \n");
				sbSql.append("     , COOKS_A_PSN                             \n");
				sbSql.append("     , COOKS_B_PSN                             \n");
				sbSql.append("     , KTCN_GRIL_YN                            \n");
				sbSql.append("     , KTCN_OVEN_YN                            \n");
				sbSql.append("     , KTCN_ETC_YN                             \n");
				sbSql.append("     , KTCN_ETC_CONTENTS                       \n");
				sbSql.append("     , PATRON_AGES10                           \n");
				sbSql.append("     , PATRON_AGES20                           \n");
				sbSql.append("     , PATRON_AGES30                           \n");
				sbSql.append("     , PATRON_AGES40                           \n");
				sbSql.append("     , PATRON_AGES50                           \n");
				sbSql.append("     , PATRON_AGES60                           \n");
				sbSql.append("     , MAN_PATRON_RATE                         \n");
				sbSql.append("     , WOMAN_PATRON_RATE                       \n");
				sbSql.append("     , MENU_PRFR                               \n");
				sbSql.append("     , NO_MENU_PRFR                            \n");
				sbSql.append("     , GUID_REQUEST_REASON                     \n");
				sbSql.append("     , UPJANG_SPCL_FACT                        \n");
				sbSql.append("     , STATUS_CD                               \n");
				sbSql.append("     , RTN_REASON                              \n");
				sbSql.append("     , GUID_PRCG                               \n");
				sbSql.append("     , CUSER                                   \n");
				sbSql.append("     , CDATE                                   \n");
				sbSql.append("     , UUSER                                   \n");
				sbSql.append("     , UDATE                                   \n");
				sbSql.append(")                                              \n");
				sbSql.append("VALUES                                         \n");
				sbSql.append("(                                              \n");
				sbSql.append("       '" + GUID_YEAR                     + "' \n");
				sbSql.append("     , '" + GUID_SEQ                      + "' \n");
				sbSql.append("     , (SELECT NVL(MAX(REQ_NUM), 0) + 1        \n");
				sbSql.append("         FROM FSM_MENU_GUID_REQ                \n");
				sbSql.append("        WHERE GUID_YEAR = '" + GUID_YEAR  + "' \n");
				sbSql.append("          AND GUID_SEQ = '" + GUID_SEQ    + "')\n");
				sbSql.append("     , '" + UPJANG                        + "' \n");
				sbSql.append("     , '" + TM_CD                         + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN                  + "' \n");
				sbSql.append("     , '" + APPOINT_DD                    + "' \n");
				sbSql.append("     , '" + OPEN_DD                       + "' \n");
				sbSql.append("     , '" + RECONTRACT_DD                 + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_UPJANG_A         + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_UPJANG_B         + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_UPJANG_C         + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_DUTY_START_A     + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_DUTY_START_B     + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_DUTY_START_C     + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_DUTY_END_A       + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_DUTY_END_B       + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_DUTY_END_C       + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_JOB_ASSIGN_A     + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_JOB_ASSIGN_B     + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN_JOB_ASSIGN_C     + "' \n");
				sbSql.append("     , '" + MEAL_UPRICE_A                 + "' \n");
				sbSql.append("     , '" + MEAL_UPRICE_B                 + "' \n");
				sbSql.append("     , '" + MEAL_UPRICE_C                 + "' \n");
				sbSql.append("     , '" + MEAL_UPRICE_D                 + "' \n");
				sbSql.append("     , '" + AVG_MEAL_QTY_A                + "' \n");
				sbSql.append("     , '" + AVG_MEAL_QTY_B                + "' \n");
				sbSql.append("     , '" + AVG_MEAL_QTY_C                + "' \n");
				sbSql.append("     , '" + AVG_MEAL_QTY_D                + "' \n");
				sbSql.append("     , '" + RATION_METHOD_A               + "' \n");
				sbSql.append("     , '" + RATION_METHOD_B               + "' \n");
				sbSql.append("     , '" + RATION_METHOD_C               + "' \n");
				sbSql.append("     , '" + RATION_METHOD_D        		+ "' \n");				
				sbSql.append("     , '" + RAW_MTR_RATE_PLAN             + "' \n");
				sbSql.append("     , '" + RAW_MTR_RATE_ACT              + "' \n");
				sbSql.append("     , '" + COOKS_A_PSN                   + "' \n");
				sbSql.append("     , '" + COOKS_B_PSN                   + "' \n");
				sbSql.append("     , '" + KTCN_GRIL_YN                  + "' \n");
				sbSql.append("     , '" + KTCN_OVEN_YN                  + "' \n");
				sbSql.append("     , '" + KTCN_ETC_YN                   + "' \n");
				sbSql.append("     , '" + KTCN_ETC_CONTENTS             + "' \n");
				sbSql.append("     , '" + PATRON_AGES10                 + "' \n");
				sbSql.append("     , '" + PATRON_AGES20                 + "' \n");
				sbSql.append("     , '" + PATRON_AGES30                 + "' \n");
				sbSql.append("     , '" + PATRON_AGES40                 + "' \n");
				sbSql.append("     , '" + PATRON_AGES50                 + "' \n");
				sbSql.append("     , '" + PATRON_AGES60                 + "' \n");
				sbSql.append("     , '" + MAN_PATRON_RATE               + "' \n");
				sbSql.append("     , '" + WOMAN_PATRON_RATE             + "' \n");
				sbSql.append("     , '" + MENU_PRFR                     + "' \n");
				sbSql.append("     , '" + NO_MENU_PRFR                  + "' \n");
				sbSql.append("     , '" + GUID_REQUEST_REASON           + "' \n");
				sbSql.append("     , '" + UPJANG_SPCL_FACT              + "' \n");
				sbSql.append("     , '01'                                    \n");
				sbSql.append("     , '" + RTN_REASON                    + "' \n");
				sbSql.append("     , '" + GUID_PRCG                     + "' \n");
				sbSql.append("     , '" + g_EmpNo                       + "' \n");
				sbSql.append("     , SYSDATE                                 \n");
				sbSql.append("     , '" + g_EmpNo                       + "' \n");
				sbSql.append("     , SYSDATE                                 \n");
				sbSql.append(")	                                             \n");
						
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				GUID_YEAR                 = nullToBlank(ds_guidReqMst.getString(i, "GUID_YEAR"));                
				GUID_SEQ                  = nullToBlank(ds_guidReqMst.getString(i, "GUID_SEQ"));                 
				REQ_NUM                   = nullToBlank(ds_guidReqMst.getString(i, "REQ_NUM"));                  
				CHARGE_SABUN_UPJANG_A     = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_UPJANG_A"));    
				CHARGE_SABUN_UPJANG_B     = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_UPJANG_B"));    
				CHARGE_SABUN_UPJANG_C     = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_UPJANG_C"));    
				CHARGE_SABUN_DUTY_START_A = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_START_A"));
				CHARGE_SABUN_DUTY_START_B = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_START_B"));
				CHARGE_SABUN_DUTY_START_C = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_START_C"));
				CHARGE_SABUN_DUTY_END_A   = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_END_A"));  
				CHARGE_SABUN_DUTY_END_B   = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_END_B"));  
				CHARGE_SABUN_DUTY_END_C   = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_DUTY_END_C"));  
				CHARGE_SABUN_JOB_ASSIGN_A = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_JOB_ASSIGN_A"));
				CHARGE_SABUN_JOB_ASSIGN_B = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_JOB_ASSIGN_B"));
				CHARGE_SABUN_JOB_ASSIGN_C = nullToBlank(ds_guidReqMst.getString(i, "CHARGE_SABUN_JOB_ASSIGN_C"));
				MEAL_UPRICE_A             = nullToBlank(ds_guidReqMst.getString(i, "MEAL_UPRICE_A"));            
				MEAL_UPRICE_B             = nullToBlank(ds_guidReqMst.getString(i, "MEAL_UPRICE_B"));            
				MEAL_UPRICE_C             = nullToBlank(ds_guidReqMst.getString(i, "MEAL_UPRICE_C"));            
				MEAL_UPRICE_D             = nullToBlank(ds_guidReqMst.getString(i, "MEAL_UPRICE_D"));            
				AVG_MEAL_QTY_A            = nullToBlank(ds_guidReqMst.getString(i, "AVG_MEAL_QTY_A"));           
				AVG_MEAL_QTY_B            = nullToBlank(ds_guidReqMst.getString(i, "AVG_MEAL_QTY_B"));           
				AVG_MEAL_QTY_C            = nullToBlank(ds_guidReqMst.getString(i, "AVG_MEAL_QTY_C"));           
				AVG_MEAL_QTY_D            = nullToBlank(ds_guidReqMst.getString(i, "AVG_MEAL_QTY_D"));           
				RATION_METHOD_A           = nullToBlank(ds_guidReqMst.getString(i, "RATION_METHOD_A"));          
				RATION_METHOD_B           = nullToBlank(ds_guidReqMst.getString(i, "RATION_METHOD_B"));          
				RATION_METHOD_C           = nullToBlank(ds_guidReqMst.getString(i, "RATION_METHOD_C"));          
				RATION_METHOD_D           = nullToBlank(ds_guidReqMst.getString(i, "RATION_METHOD_D"));          
				RAW_MTR_RATE_PLAN         = nullToBlank(ds_guidReqMst.getString(i, "RAW_MTR_RATE_PLAN"));        
				RAW_MTR_RATE_ACT          = nullToBlank(ds_guidReqMst.getString(i, "RAW_MTR_RATE_ACT"));         
				COOKS_A_PSN               = nullToBlank(ds_guidReqMst.getString(i, "COOKS_A_PSN"));              
				COOKS_B_PSN               = nullToBlank(ds_guidReqMst.getString(i, "COOKS_B_PSN"));              
				KTCN_GRIL_YN              = nullToBlank(ds_guidReqMst.getString(i, "KTCN_GRIL_YN"));             
				KTCN_OVEN_YN              = nullToBlank(ds_guidReqMst.getString(i, "KTCN_OVEN_YN"));             
				KTCN_ETC_YN               = nullToBlank(ds_guidReqMst.getString(i, "KTCN_ETC_YN"));              
				KTCN_ETC_CONTENTS         = nullToBlank(ds_guidReqMst.getString(i, "KTCN_ETC_CONTENTS"));        
				PATRON_AGES10             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES10"));            
				PATRON_AGES20             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES20"));            
				PATRON_AGES30             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES30"));            
				PATRON_AGES40             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES40"));            
				PATRON_AGES50             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES50"));
				PATRON_AGES60             = nullToBlank(ds_guidReqMst.getString(i, "PATRON_AGES60"));
				MAN_PATRON_RATE           = nullToBlank(ds_guidReqMst.getString(i, "MAN_PATRON_RATE"));          
				WOMAN_PATRON_RATE         = nullToBlank(ds_guidReqMst.getString(i, "WOMAN_PATRON_RATE"));        
				MENU_PRFR                 = nullToBlank(ds_guidReqMst.getString(i, "MENU_PRFR"));                
				NO_MENU_PRFR              = nullToBlank(ds_guidReqMst.getString(i, "NO_MENU_PRFR"));             
				GUID_REQUEST_REASON       = nullToBlank(ds_guidReqMst.getString(i, "GUID_REQUEST_REASON"));      
				UPJANG_SPCL_FACT          = nullToBlank(ds_guidReqMst.getString(i, "UPJANG_SPCL_FACT"));
				STATUS_CD                 = nullToBlank(ds_guidReqMst.getString(i, "STATUS_CD"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSM_MENU_GUID_REQ                                               \n"); 
				sbSql.append("   SET CHARGE_SABUN_UPJANG_A     = '" + CHARGE_SABUN_UPJANG_A     + "' \n");
				sbSql.append("     , CHARGE_SABUN_UPJANG_B     = '" + CHARGE_SABUN_UPJANG_B     + "' \n");
				sbSql.append("     , CHARGE_SABUN_UPJANG_C     = '" + CHARGE_SABUN_UPJANG_C     + "' \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_START_A = '" + CHARGE_SABUN_DUTY_START_A + "' \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_START_B = '" + CHARGE_SABUN_DUTY_START_B + "' \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_START_C = '" + CHARGE_SABUN_DUTY_START_C + "' \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_END_A   = '" + CHARGE_SABUN_DUTY_END_A   + "' \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_END_B   = '" + CHARGE_SABUN_DUTY_END_B   + "' \n");
				sbSql.append("     , CHARGE_SABUN_DUTY_END_C   = '" + CHARGE_SABUN_DUTY_END_C   + "' \n");
				sbSql.append("     , CHARGE_SABUN_JOB_ASSIGN_A = '" + CHARGE_SABUN_JOB_ASSIGN_A + "' \n");
				sbSql.append("     , CHARGE_SABUN_JOB_ASSIGN_B = '" + CHARGE_SABUN_JOB_ASSIGN_B + "' \n");
				sbSql.append("     , CHARGE_SABUN_JOB_ASSIGN_C = '" + CHARGE_SABUN_JOB_ASSIGN_C + "' \n");
				sbSql.append("     , MEAL_UPRICE_A             = '" + MEAL_UPRICE_A             + "' \n");
				sbSql.append("     , MEAL_UPRICE_B             = '" + MEAL_UPRICE_B             + "' \n");
				sbSql.append("     , MEAL_UPRICE_C             = '" + MEAL_UPRICE_C             + "' \n");
				sbSql.append("     , MEAL_UPRICE_D             = '" + MEAL_UPRICE_D             + "' \n");
				sbSql.append("     , AVG_MEAL_QTY_A            = '" + AVG_MEAL_QTY_A            + "' \n");
				sbSql.append("     , AVG_MEAL_QTY_B            = '" + AVG_MEAL_QTY_B            + "' \n");
				sbSql.append("     , AVG_MEAL_QTY_C            = '" + AVG_MEAL_QTY_C            + "' \n");
				sbSql.append("     , AVG_MEAL_QTY_D            = '" + AVG_MEAL_QTY_D            + "' \n");
				sbSql.append("     , RATION_METHOD_A           = '" + RATION_METHOD_A           + "' \n");
				sbSql.append("     , RATION_METHOD_B           = '" + RATION_METHOD_B           + "' \n");
				sbSql.append("     , RATION_METHOD_C           = '" + RATION_METHOD_C           + "' \n");
				sbSql.append("     , RATION_METHOD_D           = '" + RATION_METHOD_D           + "' \n");
				sbSql.append("     , RAW_MTR_RATE_PLAN         = '" + RAW_MTR_RATE_PLAN         + "' \n");
				sbSql.append("     , RAW_MTR_RATE_ACT          = '" + RAW_MTR_RATE_ACT          + "' \n");
				sbSql.append("     , COOKS_A_PSN               = '" + COOKS_A_PSN               + "' \n");
				sbSql.append("     , COOKS_B_PSN               = '" + COOKS_B_PSN               + "' \n");
				sbSql.append("     , KTCN_GRIL_YN              = '" + KTCN_GRIL_YN              + "' \n");
				sbSql.append("     , KTCN_OVEN_YN              = '" + KTCN_OVEN_YN              + "' \n");
				sbSql.append("     , KTCN_ETC_YN               = '" + KTCN_ETC_YN               + "' \n");
				sbSql.append("     , KTCN_ETC_CONTENTS         = '" + KTCN_ETC_CONTENTS         + "' \n");
				sbSql.append("     , PATRON_AGES10             = '" + PATRON_AGES10             + "' \n");
				sbSql.append("     , PATRON_AGES20             = '" + PATRON_AGES20             + "' \n");
				sbSql.append("     , PATRON_AGES30             = '" + PATRON_AGES30             + "' \n");
				sbSql.append("     , PATRON_AGES40             = '" + PATRON_AGES40             + "' \n");
				sbSql.append("     , PATRON_AGES50             = '" + PATRON_AGES50             + "' \n");
				sbSql.append("     , PATRON_AGES60             = '" + PATRON_AGES60             + "' \n");
				sbSql.append("     , MAN_PATRON_RATE           = '" + MAN_PATRON_RATE           + "' \n");
				sbSql.append("     , WOMAN_PATRON_RATE         = '" + WOMAN_PATRON_RATE         + "' \n");
				sbSql.append("     , MENU_PRFR                 = '" + MENU_PRFR                 + "' \n");
				sbSql.append("     , NO_MENU_PRFR              = '" + NO_MENU_PRFR              + "' \n");
				sbSql.append("     , GUID_REQUEST_REASON       = '" + GUID_REQUEST_REASON       + "' \n");
				sbSql.append("     , UPJANG_SPCL_FACT          = '" + UPJANG_SPCL_FACT          + "' \n");
				sbSql.append("     , STATUS_CD                 = '" + STATUS_CD                 + "' \n");
				sbSql.append("     , UUSER                     = '" + g_EmpNo                   + "' \n");
				sbSql.append("     , UDATE                     = SYSDATE                             \n");
				sbSql.append(" WHERE GUID_YEAR = '" + GUID_YEAR + "' \n");
				sbSql.append("   AND GUID_SEQ  = '" + GUID_SEQ  + "' \n");
				sbSql.append("   AND REQ_NUM   = '" + REQ_NUM   + "' \n");
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}		
		
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
		
	} catch(Exception ex) {
		ex.printStackTrace();
		conn.rollback();
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);
	} finally {
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			}catch(Exception e) {}
		}
		if(stmt != null) {
			try {
				stmt.close();
			}catch(Exception e) {}
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}
	
    proc_output(response,out,out_vl,out_dl);

%>