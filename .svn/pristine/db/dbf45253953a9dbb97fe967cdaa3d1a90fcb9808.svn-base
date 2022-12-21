<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/CS진단관리                                                                                                                                                                     
■ 프로그램ID   : FSC00410E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 점검결과등록                                                                                                                                               
■ 작성일자     : 2015-02-25                                                                                                                                                                            
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
	
		DataSet ds_resultMst     = in_dl.get("ds_resultMst");	 // 점검결과마스터
		DataSet ds_chkDtlList    = in_dl.get("ds_chkDtlList");   // 점검결과디테일(점검항목)

		String g_EmpNo              = in_vl.getString("g_EmpNo");
		String TABLE_TYPE           = "";
		String FORM_CD              = "";
		String UPJANG               = "";
		String CHK_DD               = "";
		String CLASS_CD             = "";
		String CHK_CLASS            = "";
		String TM_CD                = "";
		String CHARGE_SABUN         = "";
		String TEAM_MST_SABUN       = "";
		String SUBTEAM_MST_SABUN    = "";
		String DUTY_PSN             = "";
		String RESP_USER1           = "";
		String RESP_USER2           = "";
		String RESP_USER3           = "";
		String INSPECTOR            = "";
		String RPT_DD               = "";
		String CHK_START_TIME       = "";
		String CHK_END_TIME         = "";
		String SCORE                = "";
		String CONFIRM_YN           = "";
		String CONFIRM_DD           = "";
		String IMPROV_CONFIRM_YN    = "";
		String IMPROV_CONFIRM_DD    = "";
		String INSPT_REQ_YN         = "";
		String INSPT_REQ_DD         = "";
		String INSPT_REQ_NUM        = "";
		String INSPT_REQ_RESULT     = "";
		String REMARK               = "";
		String USE_YN               = "";
		String CHK_IDCTR            = "";
		String CHK_SCORE            = "";
		String NOT_FIT_SCORE        = "";
		String CHK_RESULT           = "";
		String NA_YN                = "";
		String IMPROV_CHECK         = "";
		String CHK_CONTENTS         = "";
		String IMPROV_MRMT_DD       = "";
		String IMPROV_MRMT_CONTENTS = "";
		String GSCORE               = "";
		String TSCORE               = "";
		
		int RowStatus;
		int RowCnt;
		StringBuffer sbSql = new StringBuffer();
		
		// 점검결과 마스터 등록
		RowCnt = ds_resultMst.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_resultMst.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				TABLE_TYPE        = nullToBlank(ds_resultMst.getString(i, "TABLE_TYPE"        ));
				FORM_CD           = nullToBlank(ds_resultMst.getString(i, "FORM_CD"           ));
				UPJANG            = nullToBlank(ds_resultMst.getString(i, "UPJANG"            ));
				CHK_DD            = nullToBlank(ds_resultMst.getString(i, "CHK_DD"            ));
				CHK_CLASS         = nullToBlank(ds_resultMst.getString(i, "CHK_CLASS"         ));
				TM_CD             = nullToBlank(ds_resultMst.getString(i, "TM_CD"             ));
				CHARGE_SABUN      = nullToBlank(ds_resultMst.getString(i, "CHARGE_SABUN"      ));
				TEAM_MST_SABUN    = nullToBlank(ds_resultMst.getString(i, "TEAM_MST_SABUN"    ));
				SUBTEAM_MST_SABUN = nullToBlank(ds_resultMst.getString(i, "SUBTEAM_MST_SABUN" ));
				DUTY_PSN          = nullToBlank(ds_resultMst.getString(i, "DUTY_PSN"          ));
				RESP_USER1        = nullToBlank(ds_resultMst.getString(i, "RESP_USER1"         ));
				RESP_USER2        = nullToBlank(ds_resultMst.getString(i, "RESP_USER2"         ));
				RESP_USER3        = nullToBlank(ds_resultMst.getString(i, "RESP_USER3"         ));
				INSPECTOR         = nullToBlank(ds_resultMst.getString(i, "INSPECTOR"         ));
				RPT_DD            = nullToBlank(ds_resultMst.getString(i, "RPT_DD"            ));
				CHK_START_TIME    = nullToBlank(ds_resultMst.getString(i, "CHK_START_TIME"    ));
				CHK_END_TIME      = nullToBlank(ds_resultMst.getString(i, "CHK_END_TIME"      ));
				SCORE             = nullToBlank(ds_resultMst.getString(i, "SCORE"             ));
				CONFIRM_YN        = nullToBlank(ds_resultMst.getString(i, "CONFIRM_YN"        ));
				CONFIRM_DD        = nullToBlank(ds_resultMst.getString(i, "CONFIRM_DD"        ));
				IMPROV_CONFIRM_YN = nullToBlank(ds_resultMst.getString(i, "IMPROV_CONFIRM_YN" ));
				IMPROV_CONFIRM_DD = nullToBlank(ds_resultMst.getString(i, "IMPROV_CONFIRM_DD" ));
				INSPT_REQ_YN      = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_YN"      ));
				INSPT_REQ_DD      = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_DD"      ));
				INSPT_REQ_NUM     = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_NUM"     ));
				INSPT_REQ_RESULT  = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_RESULT"  ));
				//REMARK            = nullToBlank(ds_resultMst.getString(i, "REMARK"            ));
				REMARK            = nullToBlank(ds_resultMst.getString(i, "REMARK"            )).replaceAll("'", "''");
				USE_YN            = nullToBlank(ds_resultMst.getString(i, "USE_YN"            ));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_PATL_RESULT (      \n");
				sbSql.append("       TABLE_TYPE                  \n");
				sbSql.append("     , FORM_CD                     \n");
				sbSql.append("     , UPJANG                      \n");
				sbSql.append("     , CHK_DD                      \n");
				sbSql.append("     , CHK_CLASS                   \n");
				sbSql.append("     , TM_CD                       \n");
				sbSql.append("     , CHARGE_SABUN                \n");
				sbSql.append("     , TEAM_MST_SABUN              \n");
				sbSql.append("     , SUBTEAM_MST_SABUN           \n");
				sbSql.append("     , DUTY_PSN                    \n");
				sbSql.append("     , RESP_USER1                  \n");
				sbSql.append("     , RESP_USER2                  \n");
				sbSql.append("     , RESP_USER3                  \n");
				sbSql.append("     , INSPECTOR                   \n");
				sbSql.append("     , RPT_DD                      \n");
				sbSql.append("     , CHK_START_TIME              \n");
				sbSql.append("     , CHK_END_TIME                \n");
				sbSql.append("     , SCORE                       \n");
				sbSql.append("     , CONFIRM_YN                  \n");
				sbSql.append("     , CONFIRM_DD                  \n");
				sbSql.append("     , IMPROV_CONFIRM_YN           \n");
				sbSql.append("     , IMPROV_CONFIRM_DD           \n");
				sbSql.append("     , INSPT_REQ_YN                \n");
				sbSql.append("     , INSPT_REQ_DD                \n");
				sbSql.append("     , INSPT_REQ_NUM               \n");
				sbSql.append("     , INSPT_REQ_RESULT            \n");
				sbSql.append("     , REMARK                      \n");
				sbSql.append("     , USE_YN                      \n");				
				sbSql.append("     , CUSER                       \n");
				sbSql.append("     , CDATE                       \n");
				sbSql.append("     , UUSER                       \n");
				sbSql.append("     , UDATE                       \n");
				sbSql.append(") VALUES (                         \n");
				sbSql.append("       '" + TABLE_TYPE        + "' \n");
				sbSql.append("     , '" + FORM_CD           + "' \n");
				sbSql.append("     , '" + UPJANG            + "' \n");
				sbSql.append("     , '" + CHK_DD            + "' \n");
				sbSql.append("     , '" + CHK_CLASS         + "' \n");
				sbSql.append("     , '" + TM_CD             + "' \n");
				sbSql.append("     , '" + CHARGE_SABUN      + "' \n");
				sbSql.append("     , '" + TEAM_MST_SABUN    + "' \n");
				sbSql.append("     , '" + SUBTEAM_MST_SABUN + "' \n");
				sbSql.append("     , '" + DUTY_PSN          + "' \n");
				sbSql.append("     , '" + RESP_USER1        + "' \n");
				sbSql.append("     , '" + RESP_USER2        + "' \n");
				sbSql.append("     , '" + RESP_USER3        + "' \n");
				sbSql.append("     , '" + INSPECTOR         + "' \n");
				sbSql.append("     , '" + RPT_DD            + "' \n");
				sbSql.append("     , '" + CHK_START_TIME    + "' \n");
				sbSql.append("     , '" + CHK_END_TIME      + "' \n");
				sbSql.append("     , '" + SCORE             + "' \n");
				sbSql.append("     , 'N'                         \n");
				sbSql.append("     , '" + CONFIRM_DD        + "' \n");
				sbSql.append("     , 'N'                         \n");
				sbSql.append("     , '" + IMPROV_CONFIRM_DD + "' \n");
				sbSql.append("     , '" + INSPT_REQ_YN      + "' \n");
				sbSql.append("     , '" + INSPT_REQ_DD      + "' \n");
				sbSql.append("     , '" + INSPT_REQ_NUM     + "' \n");
				sbSql.append("     , '" + INSPT_REQ_RESULT  + "' \n");
				sbSql.append("     , '" + REMARK            + "' \n");
				sbSql.append("     , '" + USE_YN            + "' \n");
				sbSql.append("     , '" + g_EmpNo           + "' \n");
				sbSql.append("     , SYSDATE                     \n");
				sbSql.append("     , '" + g_EmpNo           + "' \n");
				sbSql.append("     , SYSDATE                     \n");
				sbSql.append(")                                  \n");
	
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				TABLE_TYPE        = nullToBlank(ds_resultMst.getString(i, "TABLE_TYPE"        ));
				FORM_CD           = nullToBlank(ds_resultMst.getString(i, "FORM_CD"           ));
				UPJANG            = nullToBlank(ds_resultMst.getString(i, "UPJANG"            ));
				CHK_DD            = nullToBlank(ds_resultMst.getString(i, "CHK_DD"            ));
				CHK_CLASS         = nullToBlank(ds_resultMst.getString(i, "CHK_CLASS"         ));
				TM_CD             = nullToBlank(ds_resultMst.getString(i, "TM_CD"             ));
				CHARGE_SABUN      = nullToBlank(ds_resultMst.getString(i, "CHARGE_SABUN"      ));
				TEAM_MST_SABUN    = nullToBlank(ds_resultMst.getString(i, "TEAM_MST_SABUN"    ));
				SUBTEAM_MST_SABUN = nullToBlank(ds_resultMst.getString(i, "SUBTEAM_MST_SABUN" ));
				DUTY_PSN          = nullToBlank(ds_resultMst.getString(i, "DUTY_PSN"          ));
				RESP_USER1        = nullToBlank(ds_resultMst.getString(i, "RESP_USER1"         ));
				RESP_USER2        = nullToBlank(ds_resultMst.getString(i, "RESP_USER2"         ));
				RESP_USER3        = nullToBlank(ds_resultMst.getString(i, "RESP_USER3"         ));
				INSPECTOR         = nullToBlank(ds_resultMst.getString(i, "INSPECTOR"         ));
				RPT_DD            = nullToBlank(ds_resultMst.getString(i, "RPT_DD"            ));
				CHK_START_TIME    = nullToBlank(ds_resultMst.getString(i, "CHK_START_TIME"    ));
				CHK_END_TIME      = nullToBlank(ds_resultMst.getString(i, "CHK_END_TIME"      ));
				SCORE             = nullToBlank(ds_resultMst.getString(i, "SCORE"             ));
				CONFIRM_YN        = nullToBlank(ds_resultMst.getString(i, "CONFIRM_YN"        ));
				CONFIRM_DD        = nullToBlank(ds_resultMst.getString(i, "CONFIRM_DD"        ));
				IMPROV_CONFIRM_YN = nullToBlank(ds_resultMst.getString(i, "IMPROV_CONFIRM_YN" ));
				IMPROV_CONFIRM_DD = nullToBlank(ds_resultMst.getString(i, "IMPROV_CONFIRM_DD" ));
				INSPT_REQ_YN      = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_YN"      ));
				INSPT_REQ_DD      = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_DD"      ));
				INSPT_REQ_NUM     = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_NUM"     ));
				INSPT_REQ_RESULT  = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_RESULT"  ));
				//REMARK            = nullToBlank(ds_resultMst.getString(i, "REMARK"            ));
				REMARK            = nullToBlank(ds_resultMst.getString(i, "REMARK"            )).replaceAll("'", "''");
				USE_YN            = nullToBlank(ds_resultMst.getString(i, "USE_YN"            ));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_PATL_RESULT                                 \n");
				sbSql.append("   SET TM_CD             = '" + TM_CD             + "' \n");
				sbSql.append("     , CHK_CLASS         = '" + CHK_CLASS         + "' \n");
				sbSql.append("     , CHARGE_SABUN      = '" + CHARGE_SABUN      + "' \n");     
				sbSql.append("     , TEAM_MST_SABUN    = '" + TEAM_MST_SABUN    + "' \n");     
				sbSql.append("     , SUBTEAM_MST_SABUN = '" + SUBTEAM_MST_SABUN + "' \n");     
				sbSql.append("     , DUTY_PSN          = '" + DUTY_PSN          + "' \n");
				sbSql.append("     , RESP_USER1        = '" + RESP_USER1        + "' \n");
				sbSql.append("     , RESP_USER2        = '" + RESP_USER2        + "' \n");
				sbSql.append("     , RESP_USER3        = '" + RESP_USER3        + "' \n");
				sbSql.append("     , INSPECTOR         = '" + INSPECTOR         + "' \n");     
				sbSql.append("     , RPT_DD            = '" + RPT_DD            + "' \n");     
				sbSql.append("     , CHK_START_TIME    = '" + CHK_START_TIME    + "' \n");     
				sbSql.append("     , CHK_END_TIME      = '" + CHK_END_TIME      + "' \n");     
				sbSql.append("     , SCORE             = '" + SCORE             + "' \n");     
				sbSql.append("     , CONFIRM_YN        = '" + CONFIRM_YN        + "' \n");     
				sbSql.append("     , CONFIRM_DD        = '" + CONFIRM_DD        + "' \n");     
				sbSql.append("     , IMPROV_CONFIRM_YN = '" + IMPROV_CONFIRM_YN + "' \n");     
				sbSql.append("     , IMPROV_CONFIRM_DD = '" + IMPROV_CONFIRM_DD + "' \n");     
				sbSql.append("     , INSPT_REQ_YN      = '" + INSPT_REQ_YN      + "' \n");     
				sbSql.append("     , INSPT_REQ_DD      = '" + INSPT_REQ_DD      + "' \n");     
				sbSql.append("     , INSPT_REQ_NUM     = '" + INSPT_REQ_NUM     + "' \n");     
				sbSql.append("     , INSPT_REQ_RESULT  = '" + INSPT_REQ_RESULT  + "' \n");
				sbSql.append("     , REMARK            = '" + REMARK            + "' \n");
				sbSql.append("     , USE_YN            = '" + USE_YN            + "' \n");     
				sbSql.append("     , UUSER            = '" + g_EmpNo            + "' \n"); 
				sbSql.append("     , UDATE            = SYSDATE                      \n"); 
				sbSql.append(" WHERE TABLE_TYPE       = '" + TABLE_TYPE         + "' \n");
				sbSql.append("   AND FORM_CD          = '" + FORM_CD            + "' \n");
				sbSql.append("   AND UPJANG           = '" + UPJANG             + "' \n");
				sbSql.append("   AND CHK_DD           = '" + CHK_DD             + "' \n");
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();			
			}
		}

		// 점검결과 디테일 등록 (점검항목)
		RowCnt = ds_chkDtlList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_chkDtlList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				TABLE_TYPE          = nullToBlank(ds_resultMst.getString(0, "TABLE_TYPE"));       
				FORM_CD             = nullToBlank(ds_resultMst.getString(0, "FORM_CD"));          
				UPJANG              = nullToBlank(ds_resultMst.getString(0, "UPJANG"));           
				CHK_DD              = nullToBlank(ds_resultMst.getString(0, "CHK_DD"));           
				CLASS_CD            = nullToBlank(ds_chkDtlList.getString(i, "CLASS_CD"));             
				CHK_IDCTR           = nullToBlank(ds_chkDtlList.getString(i, "CHK_IDCTR"));            
				NOT_FIT_SCORE       = nullToBlank(ds_chkDtlList.getString(i, "NOT_FIT_SCORE"));        
				CHK_SCORE           = nullToBlank(ds_chkDtlList.getString(i, "CHK_SCORE"));           
				CHK_RESULT          = nullToBlank(ds_chkDtlList.getString(i, "CHK_RESULT"));           
				NA_YN               = nullToBlank(ds_chkDtlList.getString(i, "NA_YN"));
				IMPROV_CHECK        = nullToBlank(ds_chkDtlList.getString(i, "IMPROV_CHECK"));
				CHK_CONTENTS        = nullToBlank(ds_chkDtlList.getString(i, "CHK_CONTENTS")).replaceAll("'","''");         
				IMPROV_MRMT_DD      = nullToBlank(ds_chkDtlList.getString(i, "IMPROV_MRMT_DD"));       
				IMPROV_MRMT_CONTENTS= nullToBlank(ds_chkDtlList.getString(i, "IMPROV_MRMT_CONTENTS")).replaceAll("'","''"); 
				USE_YN              = nullToBlank(ds_chkDtlList.getString(i, "USE_YN"));               
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_PATL_RESULT_DTL (     \n");
				sbSql.append("       TABLE_TYPE                     \n");
				sbSql.append("     , FORM_CD                        \n");
				sbSql.append("     , UPJANG                         \n");
				sbSql.append("     , CHK_DD                         \n");
				sbSql.append("     , CLASS_CD                       \n");
				sbSql.append("     , CHK_IDCTR                      \n");
				sbSql.append("     , NOT_FIT_SCORE                  \n");
				sbSql.append("     , CHK_SCORE                      \n");
				sbSql.append("     , CHK_RESULT                     \n");
				sbSql.append("     , NA_YN                          \n");
				sbSql.append("     , IMPROV_CHECK                   \n");				
				sbSql.append("     , CHK_CONTENTS                   \n");
				sbSql.append("     , IMPROV_MRMT_DD                 \n");
				sbSql.append("     , IMPROV_MRMT_CONTENTS           \n");
				sbSql.append("     , USE_YN                         \n");
				sbSql.append("     , CUSER                          \n");
				sbSql.append("     , CDATE                          \n");
				sbSql.append("     , UUSER                          \n");
				sbSql.append("     , UDATE                          \n");
				sbSql.append(") VALUES (                            \n");
				sbSql.append("       '" + TABLE_TYPE           + "' \n");
				sbSql.append("     , '" + FORM_CD              + "' \n");
				sbSql.append("     , '" + UPJANG               + "' \n");
				sbSql.append("     , '" + CHK_DD               + "' \n");
				sbSql.append("     , '" + CLASS_CD             + "' \n");
				sbSql.append("     , '" + CHK_IDCTR            + "' \n");
				sbSql.append("     , '" + NOT_FIT_SCORE        + "' \n");
				sbSql.append("     , '" + CHK_SCORE            + "' \n");
				sbSql.append("     , '" + CHK_RESULT           + "' \n");
				sbSql.append("     , DECODE('" + NA_YN         + "', 1, 'Y', 'N') \n");
				sbSql.append("     , DECODE('" + IMPROV_CHECK  + "', 1, 'Y', 'N') \n");				
				sbSql.append("     , '" + CHK_CONTENTS         + "' \n");
				sbSql.append("     , '" + IMPROV_MRMT_DD       + "' \n");
				sbSql.append("     , '" + IMPROV_MRMT_CONTENTS + "' \n");
				sbSql.append("     , '" + USE_YN               + "' \n");
				sbSql.append("     , '" + g_EmpNo              + "' \n");
				sbSql.append("     , SYSDATE                        \n");
				sbSql.append("     , '" + g_EmpNo              + "' \n");
				sbSql.append("     , SYSDATE                        \n");
				sbSql.append(")                                     \n");
	
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				TABLE_TYPE          = nullToBlank(ds_chkDtlList.getString(0, "TABLE_TYPE"));       
				FORM_CD             = nullToBlank(ds_chkDtlList.getString(0, "FORM_CD"));          
				UPJANG              = nullToBlank(ds_chkDtlList.getString(0, "UPJANG"));           
				CHK_DD              = nullToBlank(ds_chkDtlList.getString(0, "CHK_DD"));           
				CLASS_CD            = nullToBlank(ds_chkDtlList.getString(i, "CLASS_CD"));             
				CHK_IDCTR           = nullToBlank(ds_chkDtlList.getString(i, "CHK_IDCTR"));            
				NOT_FIT_SCORE       = nullToBlank(ds_chkDtlList.getString(i, "NOT_FIT_SCORE"));        
				CHK_SCORE           = nullToBlank(ds_chkDtlList.getString(i, "CHK_SCORE"));           
				CHK_RESULT          = nullToBlank(ds_chkDtlList.getString(i, "CHK_RESULT"));           
				NA_YN               = nullToBlank(ds_chkDtlList.getString(i, "NA_YN"));
				IMPROV_CHECK        = nullToBlank(ds_chkDtlList.getString(i, "IMPROV_CHECK"));
				CHK_CONTENTS        = nullToBlank(ds_chkDtlList.getString(i, "CHK_CONTENTS")).replaceAll("'","''");         
				IMPROV_MRMT_DD      = nullToBlank(ds_chkDtlList.getString(i, "IMPROV_MRMT_DD"));       
				IMPROV_MRMT_CONTENTS= nullToBlank(ds_chkDtlList.getString(i, "IMPROV_MRMT_CONTENTS")).replaceAll("'","''"); 
				USE_YN              = nullToBlank(ds_chkDtlList.getString(i, "USE_YN"));               
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_PATL_RESULT_DTL                                \n");
				sbSql.append("   SET CHK_IDCTR           = '" + CHK_IDCTR            + "' \n");     
				sbSql.append("     , NOT_FIT_SCORE       = '" + NOT_FIT_SCORE        + "' \n");     
				sbSql.append("     , CHK_SCORE           = '" + CHK_SCORE            + "' \n");     
				sbSql.append("     , CHK_RESULT          = '" + CHK_RESULT           + "' \n");     
				sbSql.append("     , NA_YN               = DECODE('" + NA_YN         + "', 1, 'Y', 'N') \n");
				sbSql.append("     , IMPROV_CHECK        = DECODE('" + IMPROV_CHECK  + "', 1, 'Y', 'N') \n");
				sbSql.append("     , CHK_CONTENTS        = '" + CHK_CONTENTS         + "' \n");     
				sbSql.append("     , IMPROV_MRMT_DD      = '" + IMPROV_MRMT_DD       + "' \n");     
				sbSql.append("     , IMPROV_MRMT_CONTENTS= '" + IMPROV_MRMT_CONTENTS + "' \n");     
				sbSql.append("     , USE_YN              = '" + USE_YN               + "' \n");     
				sbSql.append("     , UUSER               = '" + g_EmpNo               + "' \n"); 
				sbSql.append("     , UDATE               = SYSDATE                     \n"); 
				sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
				sbSql.append("   AND FORM_CD    = '" + FORM_CD    + "' \n");
				sbSql.append("   AND UPJANG     = '" + UPJANG     + "' \n");
				sbSql.append("   AND CHK_DD     = '" + CHK_DD     + "' \n");
				sbSql.append("   AND CLASS_CD   = '" + CLASS_CD   + "' \n");
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();			
			}
		}
		
		
		/*
		// 총점, 점검결과를 마스터에 수정
		sbSql.append("SELECT SUM(NVL(FINAL_SCORE, 0)) + SUM(NVL(FOCS_FINAL_SCORE, 0)) AS SCORE                        \n");
		sbSql.append("     , SUM(NVL(FINAL_SCORE, 0)) AS GSCORE                                                       \n");
		sbSql.append("     , SUM(NVL(FOCS_FINAL_SCORE, 0)) AS TSCORE                                                  \n");
 		sbSql.append("     , CASE WHEN SUM(NVL(FINAL_SCORE, 0)) + SUM(NVL(FOCS_FINAL_SCORE, 0)) < 70 THEN '2'         \n");                  
 		sbSql.append("            ELSE '1'                                                                            \n");
 		sbSql.append("       END AS CHK_RESULT                                                                        \n");
 		sbSql.append("  FROM                                                                                          \n");
 		sbSql.append("  (SELECT T1.HL_CLASS_CD AS CLASS_CD                                                            \n");
 		sbSql.append("        , T2.CLASS_NM                                                                           \n");
 		sbSql.append("        , CASE WHEN SUM(T1.CHK_IDCTR_NA) = 0 THEN 0                                             \n");
 		//환산율 기준변경
 		//sbSql.append("               ELSE ROUND(SUM(T1.CHK_SCORE_NA) / SUM(T1.CHK_IDCTR_NA) * 90, 0)                  \n");
 		sbSql.append("               ELSE SUM(T1.CHK_SCORE_NA)                  \n");
 		sbSql.append("          END AS FINAL_SCORE                                                                    \n");
 		sbSql.append("        , CASE WHEN SUM(T1.FOCS_CHK_IDCTR_NA) = 0 THEN 0                                        \n");
 		//환산율 기준변경
 		//sbSql.append("               ELSE ROUND(SUM(T1.FOCS_CHK_SCORE_NA) / SUM(T1.FOCS_CHK_IDCTR_NA) * 10, 0)        \n");
 		sbSql.append("               ELSE SUM(T1.FOCS_CHK_SCORE_NA)        \n");
 		sbSql.append("          END AS FOCS_FINAL_SCORE                                                               \n");
 		sbSql.append("     FROM (                                                                                     \n");
 		sbSql.append("        SELECT A.TABLE_TYPE                                                                     \n");
 		sbSql.append("             , A.FORM_CD                                                                        \n");
 		sbSql.append("             , B.HL_CLASS_CD                                                                    \n");
 		sbSql.append("             , CASE WHEN FOCS_ARTICLE_YN <> 'Y' AND A.NA_YN = 'N' THEN NVL(A.CHK_IDCTR, 0)      \n");
 		sbSql.append("                    ELSE 0                                                                      \n");
 		sbSql.append("               END AS CHK_IDCTR_NA                                                              \n");
 		sbSql.append("             , CASE WHEN FOCS_ARTICLE_YN <> 'Y' AND A.NA_YN = 'N' THEN NVL(A.CHK_SCORE, 0)      \n");
 		sbSql.append("                    ELSE 0                                                                      \n");
 		sbSql.append("               END AS CHK_SCORE_NA                                                              \n");
 		sbSql.append("             , CASE WHEN FOCS_ARTICLE_YN = 'Y' AND A.NA_YN = 'N' THEN NVL(A.CHK_IDCTR, 0)       \n");
 		sbSql.append("                    ELSE 0                                                                      \n");
 		sbSql.append("               END AS FOCS_CHK_IDCTR_NA                                                         \n");
 		sbSql.append("             , CASE WHEN FOCS_ARTICLE_YN = 'Y' AND A.NA_YN = 'N' THEN NVL(A.CHK_SCORE, 0)       \n");
 		sbSql.append("                    ELSE 0                                                                      \n");
 		sbSql.append("               END AS FOCS_CHK_SCORE_NA                                                         \n");
 		sbSql.append("          FROM FSC_PATL_RESULT_DTL A                                                            \n");
 		sbSql.append("             , FSC_PATL_FORM_DTL B                                                              \n");
 		sbSql.append("             , FSC_PATL_CLASS C                                                                 \n");
 		sbSql.append("         WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                      \n");
 		sbSql.append("           AND A.FORM_CD = B.FORM_CD                                                            \n");
 		sbSql.append("           AND A.TABLE_TYPE = C.TABLE_TYPE                                                      \n");
 		sbSql.append("           AND A.FORM_CD = C.FORM_CD                                                            \n");
 		sbSql.append("           AND B.HL_CLASS_CD = C.CLASS_CD                                                       \n");
		sbSql.append("           AND A.TABLE_TYPE = '" + TABLE_TYPE + "'                                              \n");    
		sbSql.append("           AND A.CLASS_CD = B.CLASS_CD                                                          \n");                    
		sbSql.append("           AND A.FORM_CD = '" + FORM_CD + "'                                                    \n");           
		sbSql.append("           AND A.UPJANG = '" + UPJANG + "'                                                      \n");            
		sbSql.append("           AND A.CHK_DD = '" + CHK_DD + "') T1                                                  \n");              
 		sbSql.append("       , FSC_PATL_CLASS T2                                                                      \n");
 		sbSql.append("   WHERE T1.TABLE_TYPE = T2.TABLE_TYPE                                                          \n");
 		sbSql.append("     AND T1.FORM_CD = T2.FORM_CD                                                                \n");
 		sbSql.append("     AND T1.HL_CLASS_CD = T2.CLASS_CD) 		                                                  \n");
		*/
		
		// 총점, 점검결과를 마스터에 수정 -> 20161111 전민지씨 요청으로 계산 로직 쿼리 변경함  
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT  SUM(WHANSAN1) + SUM(WHANSAN2) SCORE                                                                                                               \n");
        sbSql.append("        , SUM(WHANSAN1) GSCORE                                                                                                                            \n");
        sbSql.append("        , SUM(WHANSAN2) TSCORE                                                                                                                            \n");
        sbSql.append("        , CASE WHEN SUM(NVL(WHANSAN1, 0)) + SUM(NVL(WHANSAN2, 0)) < 70 THEN '2'                                                                           \n");
        sbSql.append("             ELSE '1'                                                                                                                                     \n");
        sbSql.append("         END AS CHK_RESULT                                                                                                                                \n");
        sbSql.append("FROM                                                                                                                                                      \n");
        sbSql.append("(                                                                                                                                                         \n");
        sbSql.append("SELECT TABLE_TYPE, FORM_CD, HL_CLASS_CD,                                                                                                                  \n");
        sbSql.append("        CHK_IDCTR_NA, CHK_SCORE_NA, DECODE(CHK_IDCTR_NA,0,0,ROUND(CHK_SCORE_NA/CHK_IDCTR_NA*100*CHK_IDCTR_NA/NA_TOT,2)) WHANSAN1,                         \n");
        sbSql.append("        FOCS_CHK_IDCTR_NA, FOCS_CHK_SCORE_NA, DECODE(FOCS_CHK_SCORE_NA,0,0,ROUND(FOCS_CHK_SCORE_NA/FOCS_CHK_IDCTR_NA*100*FOCS_CHK_IDCTR_NA/NA_TOT,2)) WHANSAN2, \n");
        sbSql.append("        NA_TOT FROM                                                                                                                                       \n");
        sbSql.append("(                                                                                                                                                         \n");
        sbSql.append("SELECT A.TABLE_TYPE                                                                                                                                       \n");
        sbSql.append("             , A.FORM_CD                                                                                                                                  \n");
        sbSql.append("             , B.HL_CLASS_CD                                                                                                                              \n");
        sbSql.append("             , CASE WHEN FOCS_ARTICLE_YN <> 'Y' AND A.NA_YN = 'N' THEN NVL(A.CHK_IDCTR, 0)                                                                \n");
        sbSql.append("                    ELSE 0                                                                                                                                \n");
        sbSql.append("               END AS CHK_IDCTR_NA                                                                                                                        \n");
        sbSql.append("             , CASE WHEN FOCS_ARTICLE_YN <> 'Y' AND A.NA_YN = 'N' THEN NVL(A.CHK_SCORE, 0)                                                                \n");
        sbSql.append("                    ELSE 0                                                                                                                                \n");
        sbSql.append("               END AS CHK_SCORE_NA                                                                                                                        \n");
        sbSql.append("             , CASE WHEN FOCS_ARTICLE_YN = 'Y' AND A.NA_YN = 'N' THEN NVL(A.CHK_IDCTR, 0)                                                                 \n");
        sbSql.append("                    ELSE 0                                                                                                                                \n");
        sbSql.append("               END AS FOCS_CHK_IDCTR_NA                                                                                                                   \n");
        sbSql.append("             , CASE WHEN FOCS_ARTICLE_YN = 'Y' AND A.NA_YN = 'N' THEN NVL(A.CHK_SCORE, 0)                                                                 \n");
        sbSql.append("                    ELSE 0                                                                                                                                \n");
        sbSql.append("               END AS FOCS_CHK_SCORE_NA                                                                                                                   \n");
        sbSql.append("              , D.NA_TOT                                                                                                                                  \n");
        sbSql.append("          FROM FSC_PATL_RESULT_DTL A                                                                                                                      \n");
        sbSql.append("             , FSC_PATL_FORM_DTL B                                                                                                                        \n");
        sbSql.append("             , FSC_PATL_CLASS C                                                                                                                           \n");
        sbSql.append("             ,( SELECT SUM(CHK_IDCTR) NA_TOT                                                                                                              \n");
        sbSql.append("                 FROM    FSC_PATL_RESULT_DTL D                                                                                                            \n");
        sbSql.append("                 WHERE   D.TABLE_TYPE = '" + TABLE_TYPE + "'                                                                                                              \n");
        sbSql.append("                 AND     D.FORM_CD    = '" + FORM_CD + "'                                                                                                          \n");
        sbSql.append("                 AND     D.UPJANG     = '" + UPJANG + "'                                                                                                          \n");
        sbSql.append("                 AND     D.CHK_DD     = '" + CHK_DD + "'                                                                                                        \n");
        sbSql.append("                 AND     D.NA_YN      = 'N'                                                                                                               \n");
        sbSql.append("                 ) D                                                                                                                                      \n");
        sbSql.append("         WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                                                                                \n");
        sbSql.append("           AND A.FORM_CD = B.FORM_CD                                                                                                                      \n");
        sbSql.append("           AND A.TABLE_TYPE = C.TABLE_TYPE                                                                                                                \n");
        sbSql.append("           AND A.FORM_CD = C.FORM_CD                                                                                                                      \n");
        sbSql.append("           AND B.HL_CLASS_CD = C.CLASS_CD                                                                                                                 \n");
        sbSql.append("           AND A.TABLE_TYPE = '" + TABLE_TYPE + "'                                                                                                                        \n");
        sbSql.append("           AND A.CLASS_CD = B.CLASS_CD                                                                                                                    \n");
        sbSql.append("           AND A.FORM_CD = '" + FORM_CD + "'                                                                                                                       \n");
        sbSql.append("           AND A.UPJANG = '" + UPJANG + "'                                                                                                                        \n");
        sbSql.append("           AND A.CHK_DD = '" + CHK_DD + "'                                                                                                                      \n");
        sbSql.append(")                                                                                                                                                         \n");
        sbSql.append(")                                                                                                                                                         \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery(); 
		rs.next();
		SCORE = rs.getString("SCORE");
		GSCORE = rs.getString("GSCORE");
		TSCORE = rs.getString("TSCORE");
		CHK_RESULT = rs.getString("CHK_RESULT");
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FSC_PATL_RESULT                                \n");
		sbSql.append("   SET SCORE            = '" + SCORE             + "' \n");
		sbSql.append("     , GSCORE           = '" + GSCORE            + "' \n");
		sbSql.append("     , TSCORE           = '" + TSCORE            + "' \n");
		sbSql.append("     , CHK_RESULT       = '" + CHK_RESULT        + "' \n");
		sbSql.append(" WHERE TABLE_TYPE       = '" + TABLE_TYPE        + "' \n");
		sbSql.append("   AND FORM_CD          = '" + FORM_CD           + "' \n");
		sbSql.append("   AND UPJANG           = '" + UPJANG            + "' \n");
		sbSql.append("   AND CHK_DD           = '" + CHK_DD            + "' \n");
		stmt = conn.createStatement();
		stmt.execute(sbSql.toString());
		stmt.close();
		
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