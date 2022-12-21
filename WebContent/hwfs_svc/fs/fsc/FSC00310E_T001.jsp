<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/협력업체위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00310E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 협력업체점검결과등록 - 점검결과등록                                                                                                                                               
■ 작성일자     : 2015-02-17                                                                                                                                                                            
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
	
		DataSet ds_resultMst     = in_dl.get("ds_resultMst");	    // 점검결과마스터
		DataSet ds_resultDtlList = in_dl.get("ds_resultDtlList");	// 점검결과디테일

		String g_EmpNo              = in_vl.getString("g_EmpNo");		
		String TABLE_TYPE           = "";
		String FORM_CD              = "";
		String CUSTCD               = "";
		String CHK_DD               = "";
		String CLASS_CD             = "";
		String DEAL_CLASS           = "";
		String CHK_CLASS            = "";
		String TM_CD                = "";
		String DELIVERY_PLCE        = "";
		String INSPECTOR            = "";
		String PASS_CENTER          = "";
		String FOOD_TYPE_MGRP       = "";
		String FOOD_TYPE_MCALSS     = "";
		String FOOD_TYPE_SCLASS     = "";
		String FOOD_TYPE_CLASS      = "";
		String CHK_START_TIME       = "";
		String CHK_END_TIME         = "";
		String SCORE                = "";
		String GRADE_CD             = "";
		String CONFIRM_YN           = "";
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
		String CHK_CONTENTS         = "";
		String IMPROV_MRMT_DD       = "";
		String IMPROV_MRMT_CONTENTS = "";
		String ATTR01               = "";
		String ATTR02               = "";
		String ATTR03               = "";
		String ATTR04               = "";
		String ATTR05               = "";
		String ATTR06               = "";
		String ATTR07               = "";
		String ATTR08               = "";
		String ATTR09               = "";
		String ATTR10               = "";
		String ATTR11               = "";
		String ATTR12               = "";
		String ATTR13               = "";
		String ATTR14               = "";
		String SPECM_TYPE           = "";
		//2018.05.25 김명섭 하위공장명 추가
		String SUB_COMP_NM          = "";
		
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
				TABLE_TYPE       = nullToBlank(ds_resultMst.getString(i, "TABLE_TYPE"));       
				FORM_CD          = nullToBlank(ds_resultMst.getString(i, "FORM_CD"));          
				CUSTCD           = nullToBlank(ds_resultMst.getString(i, "CUSTCD"));           
				CHK_DD           = nullToBlank(ds_resultMst.getString(i, "CHK_DD"));           
				DEAL_CLASS       = nullToBlank(ds_resultMst.getString(i, "DEAL_CLASS"));       
				CHK_CLASS        = nullToBlank(ds_resultMst.getString(i, "CHK_CLASS"));        
				TM_CD            = nullToBlank(ds_resultMst.getString(i, "TM_CD"));            
				DELIVERY_PLCE    = nullToBlank(ds_resultMst.getString(i, "DELIVERY_PLCE"));   
				INSPECTOR        = nullToBlank(ds_resultMst.getString(i, "INSPECTOR"));        
				PASS_CENTER      = nullToBlank(ds_resultMst.getString(i, "PASS_CENTER"));      
				FOOD_TYPE_MGRP   = nullToBlank(ds_resultMst.getString(i, "FOOD_TYPE_MGRP"));   
				FOOD_TYPE_MCALSS = nullToBlank(ds_resultMst.getString(i, "FOOD_TYPE_MCALSS")); 
				FOOD_TYPE_SCLASS = nullToBlank(ds_resultMst.getString(i, "FOOD_TYPE_SCLASS")); 
				FOOD_TYPE_CLASS  = nullToBlank(ds_resultMst.getString(i, "FOOD_TYPE_CLASS"));  
				CHK_START_TIME   = nullToBlank(ds_resultMst.getString(i, "CHK_START_TIME"));   
				CHK_END_TIME     = nullToBlank(ds_resultMst.getString(i, "CHK_END_TIME"));     
				SCORE            = nullToBlank(ds_resultMst.getString(i, "SCORE"));
				CONFIRM_YN       = nullToBlank(ds_resultMst.getString(i, "CONFIRM_YN"));       
				INSPT_REQ_YN     = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_YN"));     
				INSPT_REQ_DD     = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_DD"));     
				INSPT_REQ_NUM    = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_NUM"));    
				INSPT_REQ_RESULT = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_RESULT")); 
				REMARK           = nullToBlank(ds_resultMst.getString(i, "REMARK")).replaceAll("'","''");           
				USE_YN           = nullToBlank(ds_resultMst.getString(i, "USE_YN"));  
				ATTR01           = nullToBlank(ds_resultMst.getString(i, "ATTR01"));
				ATTR02           = nullToBlank(ds_resultMst.getString(i, "ATTR02"));
				ATTR03           = nullToBlank(ds_resultMst.getString(i, "ATTR03"));
				ATTR04           = nullToBlank(ds_resultMst.getString(i, "ATTR04"));
				ATTR05           = nullToBlank(ds_resultMst.getString(i, "ATTR05"));
				ATTR06           = nullToBlank(ds_resultMst.getString(i, "ATTR06"));
				ATTR07           = nullToBlank(ds_resultMst.getString(i, "ATTR07"));
				ATTR08           = nullToBlank(ds_resultMst.getString(i, "ATTR08"));
				ATTR09           = nullToBlank(ds_resultMst.getString(i, "ATTR09"));
				ATTR10           = nullToBlank(ds_resultMst.getString(i, "ATTR10"));
				ATTR11           = nullToBlank(ds_resultMst.getString(i, "ATTR11"));
				ATTR12           = nullToBlank(ds_resultMst.getString(i, "ATTR12"));
				ATTR13           = nullToBlank(ds_resultMst.getString(i, "ATTR13"));
				ATTR14           = nullToBlank(ds_resultMst.getString(i, "ATTR14"));
				SPECM_TYPE       = nullToBlank(ds_resultMst.getString(i, "SPECM_TYPE"));
				//2018.05.25 김명섭 하위공장명 추가
				SUB_COMP_NM      = nullToBlank(ds_resultMst.getString(i, "SUB_COMP_NM"));
				
				//2018.05.25 김명섭 하위공장명 추가
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_CONTRT_RESULT (   \n");
				sbSql.append("       TABLE_TYPE                 \n");
				sbSql.append("     , FORM_CD                    \n");
				sbSql.append("     , CUSTCD                     \n");
				sbSql.append("     , CHK_DD                     \n");
				sbSql.append("     , DEAL_CLASS                 \n");
				sbSql.append("     , CHK_CLASS                  \n");
				sbSql.append("     , TM_CD                      \n");
				sbSql.append("     , DELIVERY_PLCE              \n");
				sbSql.append("     , INSPECTOR                  \n");
				sbSql.append("     , PASS_CENTER                \n");
				sbSql.append("     , FOOD_TYPE_MGRP             \n");
				sbSql.append("     , FOOD_TYPE_MCALSS           \n");
				sbSql.append("     , FOOD_TYPE_SCLASS           \n");
				sbSql.append("     , FOOD_TYPE_CLASS            \n");
				sbSql.append("     , CHK_START_TIME             \n");
				sbSql.append("     , CHK_END_TIME               \n");
				sbSql.append("     , CONFIRM_YN                 \n");
				sbSql.append("     , INSPT_REQ_YN               \n");
				sbSql.append("     , INSPT_REQ_DD               \n");
				sbSql.append("     , INSPT_REQ_NUM              \n");
				sbSql.append("     , INSPT_REQ_RESULT           \n");
				sbSql.append("     , REMARK                     \n");
				sbSql.append("     , USE_YN                     \n");
				sbSql.append("     , CUSER                      \n");
				sbSql.append("     , CDATE                      \n");
				sbSql.append("     , UUSER                      \n");
				sbSql.append("     , UDATE                      \n");
				sbSql.append("     , ATTR01                     \n");
				sbSql.append("     , ATTR02                     \n");
				sbSql.append("     , ATTR03                     \n");
				sbSql.append("     , ATTR04                     \n");
				sbSql.append("     , ATTR05                     \n");
				sbSql.append("     , ATTR06                     \n");
				sbSql.append("     , ATTR07                     \n");
				sbSql.append("     , ATTR08                     \n");
				sbSql.append("     , ATTR09                     \n");
				sbSql.append("     , ATTR10                     \n");
				sbSql.append("     , ATTR11                     \n");
				sbSql.append("     , ATTR12                     \n");
				sbSql.append("     , ATTR13                     \n");
				sbSql.append("     , ATTR14                     \n");
				sbSql.append("     , SPECM_TYPE                 \n");
				sbSql.append("     , SUB_COMP_NM                \n");
				sbSql.append(") VALUES (                        \n");
				sbSql.append("       '" + TABLE_TYPE       + "' \n");
				sbSql.append("     , '" + FORM_CD          + "' \n");
				sbSql.append("     , '" + CUSTCD           + "' \n");
				sbSql.append("     , '" + CHK_DD           + "' \n");
				sbSql.append("     , '" + DEAL_CLASS       + "' \n");
				sbSql.append("     , '" + CHK_CLASS        + "' \n");
				sbSql.append("     , '" + TM_CD            + "' \n");
				sbSql.append("     , '" + DELIVERY_PLCE    + "' \n");
				sbSql.append("     , '" + INSPECTOR        + "' \n");
				sbSql.append("     , '" + PASS_CENTER      + "' \n");
				sbSql.append("     , '" + FOOD_TYPE_MGRP   + "' \n");
				sbSql.append("     , '" + FOOD_TYPE_MCALSS + "' \n");
				sbSql.append("     , '" + FOOD_TYPE_SCLASS + "' \n");
				sbSql.append("     , '" + FOOD_TYPE_CLASS  + "' \n");
				sbSql.append("     , '" + CHK_START_TIME   + "' \n");
				sbSql.append("     , '" + CHK_END_TIME     + "' \n");
				sbSql.append("     , '" + CONFIRM_YN       + "' \n");
				sbSql.append("     , '" + INSPT_REQ_YN     + "' \n");
				sbSql.append("     , '" + INSPT_REQ_DD     + "' \n");
				sbSql.append("     , '" + INSPT_REQ_NUM    + "' \n");
				sbSql.append("     , '" + INSPT_REQ_RESULT + "' \n");
				sbSql.append("     , '" + REMARK           + "' \n");
				sbSql.append("     , '" + USE_YN           + "' \n");
				sbSql.append("     , '" + g_EmpNo          + "' \n");
				sbSql.append("     , SYSDATE                    \n");
				sbSql.append("     , '" + g_EmpNo          + "' \n");
				sbSql.append("     , SYSDATE                    \n");
				sbSql.append("     , '" + ATTR01           + "' \n");
				sbSql.append("     , '" + ATTR02           + "' \n");
				sbSql.append("     , '" + ATTR03           + "' \n");
				sbSql.append("     , '" + ATTR04           + "' \n");
				sbSql.append("     , '" + ATTR05           + "' \n");
				sbSql.append("     , '" + ATTR06           + "' \n");
				sbSql.append("     , '" + ATTR07           + "' \n");
				sbSql.append("     , '" + ATTR08           + "' \n");
				sbSql.append("     , '" + ATTR09           + "' \n");
				sbSql.append("     , '" + ATTR10           + "' \n");
				sbSql.append("     , '" + ATTR11           + "' \n");
				sbSql.append("     , '" + ATTR12           + "' \n");
				sbSql.append("     , '" + ATTR13           + "' \n");
				sbSql.append("     , '" + ATTR14           + "' \n");
				sbSql.append("     , '" + SPECM_TYPE       + "' \n");
				sbSql.append("     , '" + SUB_COMP_NM      + "' \n");
				sbSql.append(")                                 \n");
	
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				TABLE_TYPE       = nullToBlank(ds_resultMst.getString(i, "TABLE_TYPE"));       
				FORM_CD          = nullToBlank(ds_resultMst.getString(i, "FORM_CD"));          
				CUSTCD           = nullToBlank(ds_resultMst.getString(i, "CUSTCD"));           
				CHK_DD           = nullToBlank(ds_resultMst.getString(i, "CHK_DD"));           
				DEAL_CLASS       = nullToBlank(ds_resultMst.getString(i, "DEAL_CLASS"));       
				CHK_CLASS        = nullToBlank(ds_resultMst.getString(i, "CHK_CLASS"));        
				TM_CD            = nullToBlank(ds_resultMst.getString(i, "TM_CD"));            
				DELIVERY_PLCE    = nullToBlank(ds_resultMst.getString(i, "DELIVERY_PLCE"));   
				INSPECTOR        = nullToBlank(ds_resultMst.getString(i, "INSPECTOR"));        
				PASS_CENTER      = nullToBlank(ds_resultMst.getString(i, "PASS_CENTER"));      
				FOOD_TYPE_MGRP   = nullToBlank(ds_resultMst.getString(i, "FOOD_TYPE_MGRP"));   
				FOOD_TYPE_MCALSS = nullToBlank(ds_resultMst.getString(i, "FOOD_TYPE_MCALSS")); 
				FOOD_TYPE_SCLASS = nullToBlank(ds_resultMst.getString(i, "FOOD_TYPE_SCLASS")); 
				FOOD_TYPE_CLASS  = nullToBlank(ds_resultMst.getString(i, "FOOD_TYPE_CLASS"));  
				CHK_START_TIME   = nullToBlank(ds_resultMst.getString(i, "CHK_START_TIME"));   
				CHK_END_TIME     = nullToBlank(ds_resultMst.getString(i, "CHK_END_TIME"));     
				CONFIRM_YN       = nullToBlank(ds_resultMst.getString(i, "CONFIRM_YN"));       
				INSPT_REQ_YN     = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_YN"));     
				INSPT_REQ_DD     = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_DD"));     
				INSPT_REQ_NUM    = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_NUM"));    
				INSPT_REQ_RESULT = nullToBlank(ds_resultMst.getString(i, "INSPT_REQ_RESULT")); 
				REMARK           = nullToBlank(ds_resultMst.getString(i, "REMARK")).replaceAll("'","''");           
				USE_YN           = nullToBlank(ds_resultMst.getString(i, "USE_YN"));           
				ATTR01           = nullToBlank(ds_resultMst.getString(i, "ATTR01"));
				ATTR02           = nullToBlank(ds_resultMst.getString(i, "ATTR02"));
				ATTR03           = nullToBlank(ds_resultMst.getString(i, "ATTR03"));
				ATTR04           = nullToBlank(ds_resultMst.getString(i, "ATTR04"));
				ATTR05           = nullToBlank(ds_resultMst.getString(i, "ATTR05"));
				ATTR06           = nullToBlank(ds_resultMst.getString(i, "ATTR06"));
				ATTR07           = nullToBlank(ds_resultMst.getString(i, "ATTR07"));
				ATTR08           = nullToBlank(ds_resultMst.getString(i, "ATTR08"));
				ATTR09           = nullToBlank(ds_resultMst.getString(i, "ATTR09"));
				ATTR10           = nullToBlank(ds_resultMst.getString(i, "ATTR10"));
				ATTR11           = nullToBlank(ds_resultMst.getString(i, "ATTR11"));
				ATTR12           = nullToBlank(ds_resultMst.getString(i, "ATTR12"));
				ATTR13           = nullToBlank(ds_resultMst.getString(i, "ATTR13"));
				ATTR14           = nullToBlank(ds_resultMst.getString(i, "ATTR14"));
				SPECM_TYPE       = nullToBlank(ds_resultMst.getString(i, "SPECM_TYPE"));
				//2018.05.25 김명섭 하위공장명 추가
				SUB_COMP_NM      = nullToBlank(ds_resultMst.getString(i, "SUB_COMP_NM"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_CONTRT_RESULT                              \n");
				sbSql.append("   SET DEAL_CLASS       = '" + DEAL_CLASS        + "' \n");     
				sbSql.append("     , CHK_CLASS        = '" + CHK_CLASS         + "' \n");     
				sbSql.append("     , TM_CD            = '" + TM_CD             + "' \n");     
				sbSql.append("     , DELIVERY_PLCE    = '" + DELIVERY_PLCE     + "' \n");     
				sbSql.append("     , INSPECTOR        = '" + INSPECTOR         + "' \n");     
				sbSql.append("     , PASS_CENTER      = '" + PASS_CENTER       + "' \n");     
				sbSql.append("     , FOOD_TYPE_MGRP   = '" + FOOD_TYPE_MGRP    + "' \n");     
				sbSql.append("     , FOOD_TYPE_MCALSS = '" + FOOD_TYPE_MCALSS  + "' \n");     
				sbSql.append("     , FOOD_TYPE_SCLASS = '" + FOOD_TYPE_SCLASS  + "' \n");     
				sbSql.append("     , FOOD_TYPE_CLASS  = '" + FOOD_TYPE_CLASS   + "' \n");     
				sbSql.append("     , CHK_START_TIME   = '" + CHK_START_TIME    + "' \n");     
				sbSql.append("     , CHK_END_TIME     = '" + CHK_END_TIME      + "' \n");     
				sbSql.append("     , CONFIRM_YN       = '" + CONFIRM_YN        + "' \n");     
				sbSql.append("     , INSPT_REQ_YN     = '" + INSPT_REQ_YN      + "' \n");     
				sbSql.append("     , INSPT_REQ_DD     = '" + INSPT_REQ_DD      + "' \n");     
				sbSql.append("     , INSPT_REQ_NUM    = '" + INSPT_REQ_NUM     + "' \n");     
				sbSql.append("     , INSPT_REQ_RESULT = '" + INSPT_REQ_RESULT  + "' \n");     
				sbSql.append("     , REMARK           = '" + REMARK            + "' \n");     
				sbSql.append("     , USE_YN           = '" + USE_YN            + "' \n");
				sbSql.append("     , UUSER            = '" + g_EmpNo           + "' \n"); 
				sbSql.append("     , UDATE            = SYSDATE                     \n");
				sbSql.append("     , ATTR01           = '" + ATTR01            + "' \n");
				sbSql.append("     , ATTR02           = '" + ATTR02            + "' \n");
				sbSql.append("     , ATTR03           = '" + ATTR03            + "' \n");
				sbSql.append("     , ATTR04           = '" + ATTR04            + "' \n");
				sbSql.append("     , ATTR05           = '" + ATTR05            + "' \n");
				sbSql.append("     , ATTR06           = '" + ATTR06            + "' \n");
				sbSql.append("     , ATTR07           = '" + ATTR07            + "' \n");
				sbSql.append("     , ATTR08           = '" + ATTR08            + "' \n");
				sbSql.append("     , ATTR09           = '" + ATTR09            + "' \n");
				sbSql.append("     , ATTR10           = '" + ATTR10            + "' \n");
				sbSql.append("     , ATTR11           = '" + ATTR11            + "' \n");
				sbSql.append("     , ATTR12           = '" + ATTR12            + "' \n");
				sbSql.append("     , ATTR13           = '" + ATTR13            + "' \n");
				sbSql.append("     , ATTR14           = '" + ATTR14            + "' \n");
				sbSql.append("     , SPECM_TYPE       = '" + SPECM_TYPE        + "' \n");
				sbSql.append(" WHERE TABLE_TYPE       = '" + TABLE_TYPE        + "' \n");
				sbSql.append("   AND FORM_CD          = '" + FORM_CD           + "' \n");
				sbSql.append("   AND CUSTCD           = '" + CUSTCD            + "' \n");
				sbSql.append("   AND CHK_DD           = '" + CHK_DD            + "' \n");
				sbSql.append("   AND SUB_COMP_NM      = '" + SUB_COMP_NM       + "' \n");
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();			
			}
		}

		// 점검결과 디테일 등록
		RowCnt = ds_resultDtlList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_resultDtlList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				TABLE_TYPE          = nullToBlank(ds_resultMst.getString(0, "TABLE_TYPE"));       
				FORM_CD             = nullToBlank(ds_resultMst.getString(0, "FORM_CD"));          
				CUSTCD              = nullToBlank(ds_resultMst.getString(0, "CUSTCD"));           
				CHK_DD              = nullToBlank(ds_resultMst.getString(0, "CHK_DD"));           
				CLASS_CD            = nullToBlank(ds_resultDtlList.getString(i, "CLASS_CD"));             
				CHK_IDCTR           = nullToBlank(ds_resultDtlList.getString(i, "CHK_IDCTR"));            
				NOT_FIT_SCORE       = nullToBlank(ds_resultDtlList.getString(i, "NOT_FIT_SCORE"));        
				CHK_SCORE           = nullToBlank(ds_resultDtlList.getString(i, "CHK_SCORE"));           
				CHK_RESULT          = nullToBlank(ds_resultDtlList.getString(i, "CHK_RESULT"));           
				NA_YN               = nullToBlank(ds_resultDtlList.getString(i, "NA_YN"));                
				CHK_CONTENTS        = nullToBlank(ds_resultDtlList.getString(i, "CHK_CONTENTS")).replaceAll("'","''");         
				IMPROV_MRMT_DD      = nullToBlank(ds_resultDtlList.getString(i, "IMPROV_MRMT_DD"));       
				IMPROV_MRMT_CONTENTS= nullToBlank(ds_resultDtlList.getString(i, "IMPROV_MRMT_CONTENTS")).replaceAll("'","''"); 
				USE_YN              = nullToBlank(ds_resultDtlList.getString(i, "USE_YN"));               
				//2018.05.25 김명섭 하위공장명 추가
				SUB_COMP_NM         = nullToBlank(ds_resultMst.getString(0, "SUB_COMP_NM"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_CONTRT_RESULT_DTL (   \n");
				sbSql.append("       TABLE_TYPE                     \n");
				sbSql.append("     , FORM_CD                        \n");
				sbSql.append("     , CUSTCD                         \n");
				sbSql.append("     , CHK_DD                         \n");
				sbSql.append("     , CLASS_CD                       \n");
				sbSql.append("     , CHK_IDCTR                      \n");
				sbSql.append("     , NOT_FIT_SCORE                  \n");
				sbSql.append("     , CHK_SCORE                      \n");
				sbSql.append("     , CHK_RESULT                     \n");
				sbSql.append("     , NA_YN                          \n");
				sbSql.append("     , CHK_CONTENTS                   \n");
				sbSql.append("     , IMPROV_MRMT_DD                 \n");
				sbSql.append("     , IMPROV_MRMT_CONTENTS           \n");
				sbSql.append("     , USE_YN                         \n");
				sbSql.append("     , CUSER                          \n");
				sbSql.append("     , CDATE                          \n");
				sbSql.append("     , UUSER                          \n");
				sbSql.append("     , UDATE                          \n");
				sbSql.append("     , SUB_COMP_NM                    \n");
				sbSql.append(") VALUES (                            \n");
				sbSql.append("       '" + TABLE_TYPE           + "' \n");
				sbSql.append("     , '" + FORM_CD              + "' \n");
				sbSql.append("     , '" + CUSTCD               + "' \n");
				sbSql.append("     , '" + CHK_DD               + "' \n");
				sbSql.append("     , '" + CLASS_CD             + "' \n");
				sbSql.append("     , '" + CHK_IDCTR            + "' \n");
				sbSql.append("     , '" + NOT_FIT_SCORE        + "' \n");
				sbSql.append("     , '" + CHK_SCORE            + "' \n");
				sbSql.append("     , '" + CHK_RESULT           + "' \n");
				sbSql.append("     , DECODE('" + NA_YN                + "', 1, 'Y', 'N') \n");
				sbSql.append("     , '" + CHK_CONTENTS         + "' \n");
				sbSql.append("     , '" + IMPROV_MRMT_DD       + "' \n");
				sbSql.append("     , '" + IMPROV_MRMT_CONTENTS + "' \n");
				sbSql.append("     , '" + USE_YN               + "' \n");
				sbSql.append("     , '" + g_EmpNo              + "' \n");
				sbSql.append("     , SYSDATE                        \n");
				sbSql.append("     , '" + g_EmpNo              + "' \n");
				sbSql.append("     , SYSDATE                        \n");
				sbSql.append("     , '" + SUB_COMP_NM          + "' \n");
				sbSql.append(")                                     \n");
	
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				TABLE_TYPE          = nullToBlank(ds_resultDtlList.getString(0, "TABLE_TYPE"));       
				FORM_CD             = nullToBlank(ds_resultDtlList.getString(0, "FORM_CD"));          
				CUSTCD              = nullToBlank(ds_resultDtlList.getString(0, "CUSTCD"));           
				CHK_DD              = nullToBlank(ds_resultDtlList.getString(0, "CHK_DD"));           
				CLASS_CD            = nullToBlank(ds_resultDtlList.getString(i, "CLASS_CD"));             
				CHK_IDCTR           = nullToBlank(ds_resultDtlList.getString(i, "CHK_IDCTR"));            
				NOT_FIT_SCORE       = nullToBlank(ds_resultDtlList.getString(i, "NOT_FIT_SCORE"));        
				CHK_SCORE           = nullToBlank(ds_resultDtlList.getString(i, "CHK_SCORE"));           
				CHK_RESULT          = nullToBlank(ds_resultDtlList.getString(i, "CHK_RESULT"));           
				NA_YN               = nullToBlank(ds_resultDtlList.getString(i, "NA_YN"));                
				CHK_CONTENTS        = nullToBlank(ds_resultDtlList.getString(i, "CHK_CONTENTS")).replaceAll("'","''");         
				IMPROV_MRMT_DD      = nullToBlank(ds_resultDtlList.getString(i, "IMPROV_MRMT_DD"));       
				IMPROV_MRMT_CONTENTS= nullToBlank(ds_resultDtlList.getString(i, "IMPROV_MRMT_CONTENTS")).replaceAll("'","''"); 
				USE_YN              = nullToBlank(ds_resultDtlList.getString(i, "USE_YN"));               
				//2018.05.25 김명섭 하위공장명 추가
				SUB_COMP_NM         = nullToBlank(ds_resultDtlList.getString(i, "SUB_COMP_NM"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_CONTRT_RESULT_DTL                                \n");
				sbSql.append("   SET CHK_IDCTR           = '" + CHK_IDCTR            + "' \n");     
				sbSql.append("     , NOT_FIT_SCORE       = '" + NOT_FIT_SCORE        + "' \n");     
				sbSql.append("     , CHK_SCORE           = '" + CHK_SCORE            + "' \n");     
				sbSql.append("     , CHK_RESULT          = '" + CHK_RESULT           + "' \n");     
				sbSql.append("     , NA_YN               = DECODE('" + NA_YN                + "', 1, 'Y', 'N') \n");     
				sbSql.append("     , CHK_CONTENTS        = '" + CHK_CONTENTS         + "' \n");     
				sbSql.append("     , IMPROV_MRMT_DD      = '" + IMPROV_MRMT_DD       + "' \n");     
				sbSql.append("     , IMPROV_MRMT_CONTENTS= '" + IMPROV_MRMT_CONTENTS + "' \n");     
				sbSql.append("     , USE_YN              = '" + USE_YN               + "' \n");     
				sbSql.append("     , UUSER               = '" + g_EmpNo               + "' \n"); 
				sbSql.append("     , UDATE               = SYSDATE                     \n"); 
				sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
				sbSql.append("   AND FORM_CD    = '" + FORM_CD    + "' \n");
				sbSql.append("   AND CUSTCD     = '" + CUSTCD     + "' \n");
				sbSql.append("   AND CHK_DD     = '" + CHK_DD     + "' \n");
				sbSql.append("   AND CLASS_CD   = '" + CLASS_CD   + "' \n");
				sbSql.append("   AND SUB_COMP_NM= '" + SUB_COMP_NM + "'\n");
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();			
			}
		}
		
		// 총점, 점검결과를 마스터에 수정
		sbSql.delete(0, sbSql.length());
	    sbSql.append("SELECT SCORE                                                                                                \n");
	    sbSql.append("     , CASE WHEN DEAL_CLASS = 'PB' AND SCORE >= 80 THEN 1                                                   \n");
	    sbSql.append("            WHEN DEAL_CLASS = 'NB' AND SCORE >= 70 THEN 1                                                   \n");
	    sbSql.append("            ELSE 2                                                                                          \n");
	    sbSql.append("       END CHK_RESULT                                                                                       \n");
	    sbSql.append("     , (SELECT CODE                                                                                         \n");
	    sbSql.append("          FROM SCC_COMMON_CODE                                                                              \n");
	    sbSql.append("         WHERE GROUP_CODE = 'FS0118'                                                                        \n");
	    sbSql.append("           AND SCORE BETWEEN SET1 AND SET2) AS GRADE_CD                                                     \n");
	    sbSql.append("  FROM (                                                                                                    \n");
	    sbSql.append("        SELECT MAX(DEAL_CLASS) AS DEAL_CLASS                                                                \n");
	    sbSql.append("             , SUM(SCORE) AS SCORE                                                                          \n");
	    sbSql.append("          FROM (                                                                                            \n");
	    sbSql.append("                SELECT B.HL_CLASS_CD                                                                        \n");
	    sbSql.append("                     , MAX(WGT_RATE) / 100 * ROUND(SUM(A.CHK_SCORE) / SUM(A.CHK_IDCTR) * 100, 1) AS SCORE   \n");
	    sbSql.append("                     , MAX(C.DEAL_CLASS) AS DEAL_CLASS                                                      \n");
	    sbSql.append("                  FROM FSC_CONTRT_RESULT_DTL A                                                              \n");
	    sbSql.append("                     , FSC_CONTRT_FORM_DTL B                                                                \n");
	    sbSql.append("                     , FSC_CONTRT_RESULT C                                                                  \n");
	    sbSql.append("                     , FSC_CONTRT_CLASS D                                                                   \n");
	    sbSql.append("                 WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                          \n");
	    sbSql.append("                   AND A.FORM_CD = B.FORM_CD                                                                \n");
	    sbSql.append("                   AND A.CLASS_CD = B.CLASS_CD                                                              \n");
	    sbSql.append("                   AND A.TABLE_TYPE = C.TABLE_TYPE                                                          \n");
	    sbSql.append("                   AND A.FORM_CD = C.FORM_CD                                                                \n");
	    sbSql.append("                   AND A.CUSTCD = C.CUSTCD                                                                  \n");
	    sbSql.append("                   AND A.CHK_DD = C.CHK_DD                                                                  \n");
	    sbSql.append("                   AND B.TABLE_TYPE = D.TABLE_TYPE                                                          \n");
	    sbSql.append("                   AND B.FORM_CD = D.FORM_CD                                                                \n");
	    sbSql.append("                   AND B.HL_CLASS_CD = D.CLASS_CD                                                           \n");
	    sbSql.append("                   AND A.TABLE_TYPE = '" + TABLE_TYPE + "'                                                  \n");
	    sbSql.append("                   AND A.FORM_CD = '" + FORM_CD + "'                                                        \n");
	    sbSql.append("                   AND A.CUSTCD = '" + CUSTCD + "'                                                          \n");
	    sbSql.append("                   AND A.CHK_DD = '" + CHK_DD + "'                                                          \n");
	    sbSql.append("                   AND A.SUB_COMP_NM = '" + SUB_COMP_NM + "'                                                \n");
	    sbSql.append("                   AND A.SUB_COMP_NM = C.SUB_COMP_NM                                                        \n");
	    sbSql.append("                   AND A.NA_YN = 'N'                                                                        \n");
	    sbSql.append("                 GROUP BY HL_CLASS_CD))		                                                              \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery(); 
		rs.next();
		SCORE      = rs.getString("SCORE");
		String CHK_RESULT1 = rs.getString("CHK_RESULT");
		GRADE_CD   = rs.getString("GRADE_CD");
		rs.close();

		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT CASE WHEN COUNT(*) > 0 THEN 2                              \n");
        sbSql.append("            ELSE 1                                                \n");
        sbSql.append("       END AS CHK_RESULT                                          \n");
        sbSql.append("  FROM (                                                          \n");
        sbSql.append("        SELECT B.HL_CLASS_CD                                      \n");                                  
        sbSql.append("             , CASE WHEN COUNT(1) >= MAX(D.NOT_FIT_CNT) THEN 2    \n");
        sbSql.append("                    ELSE 1                                        \n");
        sbSql.append("               END AS CHK_RESULT                                  \n");
        sbSql.append("          FROM FSC_CONTRT_RESULT_DTL A                            \n");                                  
        sbSql.append("             , FSC_CONTRT_FORM_DTL B                              \n");                                  
        sbSql.append("             , FSC_CONTRT_RESULT C                                \n");                                  
        sbSql.append("             , FSC_CONTRT_CLASS D                                 \n");                                  
        sbSql.append("         WHERE A.TABLE_TYPE = B.TABLE_TYPE                        \n");                                  
        sbSql.append("           AND A.FORM_CD = B.FORM_CD                              \n");                                  
        sbSql.append("           AND A.CLASS_CD = B.CLASS_CD                            \n");                                  
        sbSql.append("           AND A.TABLE_TYPE = C.TABLE_TYPE                        \n");                                  
        sbSql.append("           AND A.FORM_CD = C.FORM_CD                              \n");                                  
        sbSql.append("           AND A.CUSTCD = C.CUSTCD                                \n");                                  
        sbSql.append("           AND A.CHK_DD = C.CHK_DD                                \n");                                  
        sbSql.append("           AND B.TABLE_TYPE = D.TABLE_TYPE                        \n");                                  
        sbSql.append("           AND B.FORM_CD = D.FORM_CD                              \n");                                  
        sbSql.append("           AND B.HL_CLASS_CD = D.CLASS_CD                         \n");                                  
        sbSql.append("           AND A.TABLE_TYPE = '" + TABLE_TYPE + "'                \n");                  
        sbSql.append("           AND A.FORM_CD = '" + FORM_CD + "'                      \n");                         
        sbSql.append("           AND A.CUSTCD = '" + CUSTCD + "'                        \n");                          
        sbSql.append("           AND A.CHK_DD = '" + CHK_DD + "'                        \n");                            
	    sbSql.append("           AND A.SUB_COMP_NM = '" + SUB_COMP_NM + "'              \n");
	    sbSql.append("           AND A.SUB_COMP_NM = C.SUB_COMP_NM                      \n");
        sbSql.append("           AND A.NA_YN = 'N'                                      \n");
        sbSql.append("           AND A.CHK_RESULT = '2'                                 \n");                                       
        sbSql.append("         GROUP BY B.HL_CLASS_CD)                                  \n");
        sbSql.append(" WHERE CHK_RESULT = 2		                                        \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery(); 
		rs.next();
		String CHK_RESULT2 = rs.getString("CHK_RESULT");
		rs.close();
		
		if(CHK_RESULT1.equals("2") || CHK_RESULT2.equals("2")) {
			CHK_RESULT = "2";
		} else {
			CHK_RESULT = "1";
		}
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FSC_CONTRT_RESULT                              \n");
		sbSql.append("   SET SCORE            = '" + SCORE             + "' \n");
		sbSql.append("     , GRADE_CD         = '" + GRADE_CD          + "' \n");
		sbSql.append("     , CHK_RESULT       = '" + CHK_RESULT        + "' \n");     
		sbSql.append(" WHERE TABLE_TYPE       = '" + TABLE_TYPE        + "' \n");
		sbSql.append("   AND FORM_CD          = '" + FORM_CD           + "' \n");
		sbSql.append("   AND CUSTCD           = '" + CUSTCD            + "' \n");
		sbSql.append("   AND CHK_DD           = '" + CHK_DD            + "' \n");
		sbSql.append("   AND SUB_COMP_NM      = '" + SUB_COMP_NM       + "' \n");
		stmt = conn.createStatement();
		stmt.execute(sbSql.toString());
		stmt.close();				
		
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
		
	} catch(Exception ex) {
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