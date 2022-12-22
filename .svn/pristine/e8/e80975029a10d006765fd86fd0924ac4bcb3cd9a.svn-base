<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/CS진단관리                                                                                                                                                                   
■ 프로그램ID   : FSC00400E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : CS진단양식관리 - 양식 등록                                                                                                                                               
■ 작성일자     : 2015-02-23                                                                                                                                                                           
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
	
		DataSet ds_Cond       = in_dl.get("ds_cond");		    // 조회조건
		DataSet ds_tableList  = in_dl.get("ds_tableList");	    // 점검표
		DataSet ds_hlClassList = in_dl.get("ds_hlClassList");	// 대분류
		DataSet ds_hmClassList = in_dl.get("ds_hmClassList");	// 중분류
		DataSet ds_hsClassList = in_dl.get("ds_hsClassList");	// 소분류

		String g_EmpNo         = in_vl.getString("g_EmpNo");		
		String TABLE_TYPE      = "";
		String FORM_CD         = "";
		String FORM_NM         = "";
		String START_DD        = "";
		String END_DD          = "";
		String USE_YN          = "";
		String CLASS_CD        = "";
		String CLASS_NM        = "";
		String CLASS_TYPE      = "";
		String NOT_FIT_CNT     = "";
		String HL_CLASS_CD     = "";
		String HL_CLASS_NM     = "";
		String HM_CLASS_CD     = "";
		String HM_CLASS_NM     = "";
		String CHK_IDCTR       = ""; 
		String NOT_FIT_SCORE   = ""; 
		String FOCS_ARTICLE_YN = "";

		int RowStatus;
		StringBuffer sbSql = new StringBuffer();
		
		// 대분류 삭제
		int RowCnt = ds_hlClassList.getRemovedRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			TABLE_TYPE    = ds_hlClassList.getRemovedData(i,"TABLE_TYPE").toString(); 
			FORM_CD       = ds_hlClassList.getRemovedData(i,"FORM_CD").toString();
			CLASS_CD      = ds_hlClassList.getRemovedData(i,"CLASS_CD").toString();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FSC_PATL_CLASS                       \n"); 
			sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'      \n");
			sbSql.append("   AND FORM_CD    = '" + FORM_CD + "'         \n");
			sbSql.append("   AND CLASS_CD   = '" + CLASS_CD + "'        \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		// 중분류 삭제
		RowCnt = ds_hmClassList.getRemovedRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			TABLE_TYPE    = ds_hmClassList.getRemovedData(i,"TABLE_TYPE").toString(); 
			FORM_CD       = ds_hmClassList.getRemovedData(i,"FORM_CD").toString();
			CLASS_CD      = ds_hmClassList.getRemovedData(i,"CLASS_CD").toString();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FSC_PATL_CLASS                       \n"); 
			sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'      \n");
			sbSql.append("   AND FORM_CD    = '" + FORM_CD + "'         \n");
			sbSql.append("   AND CLASS_CD   = '" + CLASS_CD + "'        \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		// 소분류 삭제
		RowCnt = ds_hsClassList.getRemovedRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			TABLE_TYPE    = ds_hsClassList.getRemovedData(i,"TABLE_TYPE").toString(); 
			FORM_CD       = ds_hsClassList.getRemovedData(i,"FORM_CD").toString();
			CLASS_CD      = ds_hsClassList.getRemovedData(i,"CLASS_CD").toString();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FSC_PATL_CLASS                       \n"); 
			sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'      \n");
			sbSql.append("   AND FORM_CD    = '" + FORM_CD + "'         \n");
			sbSql.append("   AND CLASS_CD   = '" + CLASS_CD + "'        \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FSC_PATL_FORM_DTL                    \n"); 
			sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'      \n");
			sbSql.append("   AND FORM_CD    = '" + FORM_CD + "'         \n");
			sbSql.append("   AND CLASS_CD   = '" + CLASS_CD + "'        \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		// 점검표 등록, 수정
		RowCnt = ds_tableList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_tableList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				TABLE_TYPE    = nullToBlank(ds_tableList.getString(i,"TABLE_TYPE")); 
				FORM_NM       = nullToBlank(ds_tableList.getString(i,"FORM_NM"));       
				START_DD      = nullToBlank(ds_tableList.getString(i,"START_DD"));      
				END_DD        = nullToBlank(ds_tableList.getString(i,"END_DD"));        
				USE_YN        = nullToBlank(ds_tableList.getString(i,"USE_YN"));        
				
				// FORM_CD 생성
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT TO_CHAR(SYSDATE, 'YYYY') || NVL(DECODE(LENGTH(MAX(SUBSTR(FORM_CD,5,2)+1)),1,'0') || MAX(SUBSTR(FORM_CD,5,2)+1),'01') AS FORM_CD \n");
				sbSql.append("  FROM FSC_PATL_FORM \n");
				sbSql.append(" WHERE TABLE_TYPE = ? \n");
				sbSql.append("   AND SUBSTR(FORM_CD,0,4) = TO_CHAR(SYSDATE,'YYYY') \n");
				
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setString(1, TABLE_TYPE);
				rs = pstmt.executeQuery();
				rs.next();
				FORM_CD = rs.getString("FORM_CD");
				
				rs.close();
				pstmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_PATL_FORM ( \n");
				sbSql.append("       TABLE_TYPE             \n");
				sbSql.append("     , FORM_CD                \n");
				sbSql.append("     , FORM_NM                \n");
				sbSql.append("     , START_DD               \n");
				sbSql.append("     , END_DD                 \n");
				sbSql.append("     , USE_YN                 \n");
				sbSql.append("     , CUSER                  \n");
				sbSql.append("     , CDATE                  \n");
				sbSql.append("     , UUSER                  \n");
				sbSql.append("     , UDATE                  \n");
				sbSql.append(") VALUES (                    \n");
				sbSql.append("       '" + TABLE_TYPE + "'   \n");
				sbSql.append("     , '" + FORM_CD + "'      \n");
				sbSql.append("     , '" + FORM_NM + "'      \n");
				sbSql.append("     , '" + START_DD + "'     \n");
				sbSql.append("     , '" + END_DD + "'       \n");
				sbSql.append("     , '" + USE_YN + "'       \n");
				sbSql.append("     , '" + g_EmpNo + "'      \n");
				sbSql.append("     , SYSDATE                \n");
				sbSql.append("     , '" + g_EmpNo + "'      \n");
				sbSql.append("     , SYSDATE                \n");
				sbSql.append(")                             \n");

				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				TABLE_TYPE    = nullToBlank(ds_tableList.getString(i,"TABLE_TYPE"));
				FORM_CD       = nullToBlank(ds_tableList.getString(i,"FORM_CD"));
				FORM_NM       = nullToBlank(ds_tableList.getString(i,"FORM_NM"));       
				START_DD      = nullToBlank(ds_tableList.getString(i,"START_DD"));      
				END_DD        = nullToBlank(ds_tableList.getString(i,"END_DD"));        
				USE_YN        = nullToBlank(ds_tableList.getString(i,"USE_YN"));        
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_PATL_FORM                   \n"); 
				sbSql.append("   SET FORM_NM   = '" + FORM_NM + "'     \n"); 
				sbSql.append("     , START_DD  = '" + START_DD + "'    \n");
				sbSql.append("     , END_DD    = '" + END_DD + "'      \n");
				sbSql.append("     , USE_YN    = '" + USE_YN + "'      \n");
				sbSql.append("     , UUSER     = '" + g_EmpNo + "'     \n"); 
				sbSql.append("     , UDATE     = SYSDATE               \n"); 
				sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
				sbSql.append("   AND FORM_CD = '" + FORM_CD + "'       \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}
		
		// 대분류 등록, 수정
		RowCnt = ds_hlClassList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_hlClassList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				TABLE_TYPE      = nullToBlank(ds_hlClassList.getString(i,"TABLE_TYPE"));
				if (ds_hlClassList.getString(i,"FORM_CD") != null)
				{
					FORM_CD     = nullToBlank(ds_hlClassList.getString(i,"FORM_CD"));
				}
				CLASS_CD        = nullToBlank(ds_hlClassList.getString(i,"CLASS_CD"));      
				CLASS_NM        = nullToBlank(ds_hlClassList.getString(i,"CLASS_NM"));
				CLASS_TYPE      = nullToBlank(ds_hlClassList.getString(i,"CLASS_TYPE"));
				FOCS_ARTICLE_YN = nullToBlank(ds_hlClassList.getString(i,"FOCS_ARTICLE_YN"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_PATL_CLASS (     \n");
				sbSql.append("       TABLE_TYPE                \n");
				sbSql.append("     , FORM_CD                   \n");
				sbSql.append("     , CLASS_CD                  \n");
				sbSql.append("     , CLASS_NM                  \n");
				sbSql.append("     , CLASS_TYPE                \n");
				sbSql.append("     , FOCS_ARTICLE_YN           \n");
				sbSql.append("     , CUSER                     \n");
				sbSql.append("     , CDATE                     \n");
				sbSql.append("     , UUSER                     \n");
				sbSql.append("     , UDATE                     \n");
				sbSql.append(") VALUES (                       \n");
				sbSql.append("       '" + TABLE_TYPE + "'      \n");
				sbSql.append("     , '" + FORM_CD + "'         \n");
				sbSql.append("     , '" + CLASS_CD + "'        \n");
				sbSql.append("     , '" + CLASS_NM + "'        \n");
				sbSql.append("     , '" + CLASS_TYPE + "'      \n");
				sbSql.append("	   , DECODE('" + FOCS_ARTICLE_YN + "','1','Y','N') \n");				
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append(")                                \n");

				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				TABLE_TYPE      = nullToBlank(ds_hlClassList.getString(i,"TABLE_TYPE")); 
				FORM_CD         = nullToBlank(ds_hlClassList.getString(i,"FORM_CD"));       
				CLASS_CD        = nullToBlank(ds_hlClassList.getString(i,"CLASS_CD"));      
				CLASS_NM        = nullToBlank(ds_hlClassList.getString(i,"CLASS_NM"));
				FOCS_ARTICLE_YN = nullToBlank(ds_hlClassList.getString(i,"FOCS_ARTICLE_YN"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_PATL_CLASS                                \n"); 
				sbSql.append("   SET CLASS_NM        = '" + CLASS_NM + "'          \n"); 
				sbSql.append("     , FOCS_ARTICLE_YN = DECODE('" + FOCS_ARTICLE_YN + "', '1', 'Y', 'N')   \n");
				sbSql.append("     , UUSER       = '" + g_EmpNo + "'               \n"); 
				sbSql.append("     , UDATE       = SYSDATE                         \n"); 
				sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'             \n");
				sbSql.append("   AND FORM_CD = '" + FORM_CD + "'                   \n");
				sbSql.append("   AND CLASS_CD = '" + CLASS_CD + "'                 \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_PATL_FORM_DTL \n");
				sbSql.append("   SET HL_CLASS_NM     = '" + CLASS_NM + "'   \n");
				sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'      \n");
				sbSql.append("   AND FORM_CD    = '" + FORM_CD + "'         \n");
				sbSql.append("   AND HL_CLASS_CD   = '" + CLASS_CD + "'     \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}		
		
		// 중분류 등록, 수정
		RowCnt = ds_hmClassList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_hmClassList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				TABLE_TYPE    = nullToBlank(ds_hmClassList.getString(i,"TABLE_TYPE"));
				if (ds_hmClassList.getString(i,"FORM_CD") != null)
				{
					FORM_CD   = nullToBlank(ds_hmClassList.getString(i,"FORM_CD"));
				}
				CLASS_CD      = nullToBlank(ds_hmClassList.getString(i,"CLASS_CD"));      
				CLASS_NM      = nullToBlank(ds_hmClassList.getString(i,"CLASS_NM"));
				CLASS_TYPE    = nullToBlank(ds_hmClassList.getString(i,"CLASS_TYPE"));
				FOCS_ARTICLE_YN = nullToBlank(ds_hmClassList.getString(i,"FOCS_ARTICLE_YN"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_PATL_CLASS   (\n");
				sbSql.append("       TABLE_TYPE             \n");
				sbSql.append("     , FORM_CD                \n");
				sbSql.append("     , CLASS_CD               \n");
				sbSql.append("     , CLASS_NM               \n");
				sbSql.append("     , CLASS_TYPE             \n");
				sbSql.append("     , FOCS_ARTICLE_YN        \n");
				sbSql.append("     , CUSER                  \n");
				sbSql.append("     , CDATE                  \n");
				sbSql.append("     , UUSER                  \n");
				sbSql.append("     , UDATE                  \n");
				sbSql.append(") VALUES (                    \n");
				sbSql.append("       '" + TABLE_TYPE + "'   \n");
				sbSql.append("     , '" + FORM_CD + "'      \n");
				sbSql.append("     , '" + CLASS_CD + "'     \n");
				sbSql.append("     , '" + CLASS_NM + "'     \n");
				sbSql.append("     , '" + CLASS_TYPE + "'   \n");
				sbSql.append("	   , DECODE('" + FOCS_ARTICLE_YN + "','1','Y','N') \n");
				sbSql.append("     , '" + g_EmpNo + "'      \n");
				sbSql.append("     , SYSDATE                \n");
				sbSql.append("     , '" + g_EmpNo + "'      \n");
				sbSql.append("     , SYSDATE                \n");
				sbSql.append(")                             \n");

				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				TABLE_TYPE    = nullToBlank(ds_hmClassList.getString(i,"TABLE_TYPE")); 
				FORM_CD       = nullToBlank(ds_hmClassList.getString(i,"FORM_CD"));       
				CLASS_CD      = nullToBlank(ds_hmClassList.getString(i,"CLASS_CD"));      
				CLASS_NM      = nullToBlank(ds_hmClassList.getString(i,"CLASS_NM"));
				FOCS_ARTICLE_YN = nullToBlank(ds_hmClassList.getString(i,"FOCS_ARTICLE_YN"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_PATL_CLASS                      \n"); 
				sbSql.append("   SET CLASS_NM    = '" + CLASS_NM + "'    \n"); 
				sbSql.append("     , FOCS_ARTICLE_YN = DECODE('" + FOCS_ARTICLE_YN + "', '1', 'Y', 'N')   \n");
				sbSql.append("     , UUSER       = '" + g_EmpNo + "'     \n"); 
				sbSql.append("     , UDATE       = SYSDATE               \n"); 
				sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'   \n");
				sbSql.append("   AND FORM_CD = '" + FORM_CD + "'         \n");
				sbSql.append("   AND CLASS_CD = '" + CLASS_CD + "'       \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_PATL_FORM_DTL \n");
				sbSql.append("   SET HM_CLASS_NM        = '" + CLASS_NM + "'\n");
				sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'      \n");
				sbSql.append("   AND FORM_CD    = '" + FORM_CD + "'         \n");
				sbSql.append("   AND HM_CLASS_CD   = '" + CLASS_CD + "'     \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}	
		
		// 소분류 등록, 수정
		RowCnt = ds_hsClassList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_hsClassList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				TABLE_TYPE    = nullToBlank(ds_hsClassList.getString(i,"TABLE_TYPE"));
				if (ds_hsClassList.getString(i,"FORM_CD") != null)
				{
					FORM_CD   = nullToBlank(ds_hsClassList.getString(i,"FORM_CD"));
				}
				CLASS_CD        = nullToBlank(ds_hsClassList.getString(i,"CLASS_CD"));
				HL_CLASS_CD     = nullToBlank(ds_hsClassList.getString(i,"HL_CLASS_CD"));
				HL_CLASS_NM     = nullToBlank(ds_hsClassList.getString(i,"HL_CLASS_NM"));
				HM_CLASS_CD     = nullToBlank(ds_hsClassList.getString(i,"HM_CLASS_CD"));
				HM_CLASS_NM     = nullToBlank(ds_hsClassList.getString(i,"HM_CLASS_NM"));
				CLASS_NM        = nullToBlank(ds_hsClassList.getString(i,"CLASS_NM"));
				CLASS_TYPE      = nullToBlank(ds_hsClassList.getString(i,"CLASS_TYPE"));
				CHK_IDCTR       = nullToBlank(ds_hsClassList.getString(i,"CHK_IDCTR"));
				NOT_FIT_SCORE   = nullToBlank(ds_hsClassList.getString(i,"NOT_FIT_SCORE"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_PATL_CLASS (\n");
				sbSql.append("       TABLE_TYPE             \n");
				sbSql.append("     , FORM_CD                \n");
				sbSql.append("     , CLASS_CD               \n");
				sbSql.append("     , CLASS_NM               \n");
				sbSql.append("     , CLASS_TYPE             \n");
				sbSql.append("     , CUSER                  \n");
				sbSql.append("     , CDATE                  \n");
				sbSql.append("     , UUSER                  \n");
				sbSql.append("     , UDATE                  \n");
				sbSql.append(") VALUES (                    \n");
				sbSql.append("       '" + TABLE_TYPE + "'   \n");
				sbSql.append("     , '" + FORM_CD + "'      \n");
				sbSql.append("     , '" + CLASS_CD + "'     \n");
				sbSql.append("     , '" + CLASS_NM + "'     \n");
				sbSql.append("     , '" + CLASS_TYPE + "'   \n");
				sbSql.append("     , '" + g_EmpNo + "'      \n");
				sbSql.append("     , SYSDATE                \n");
				sbSql.append("     , '" + g_EmpNo + "'      \n");
				sbSql.append("     , SYSDATE                \n");
				sbSql.append(")                             \n");

				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_PATL_FORM_DTL( \n");
				sbSql.append("	     TABLE_TYPE                \n");
				sbSql.append("	   , FORM_CD                   \n");
				sbSql.append("	   , CLASS_CD                  \n");
				sbSql.append("	   , HL_CLASS_CD               \n");
				sbSql.append("	   , HL_CLASS_NM               \n");
				sbSql.append("	   , HM_CLASS_CD               \n");
				sbSql.append("	   , HM_CLASS_NM               \n");
				sbSql.append("	   , CLASS_NM                  \n");
				sbSql.append("	   , CHK_IDCTR                 \n");
				sbSql.append("	   , NOT_FIT_SCORE             \n");
				sbSql.append("	   , CUSER                     \n");
				sbSql.append("	   , CDATE                     \n");
				sbSql.append("	   , UUSER                     \n");
				sbSql.append("	   , UDATE                     \n");
				sbSql.append(" ) VALUES (                      \n");
				sbSql.append("	     '" + TABLE_TYPE + "'      \n");
				sbSql.append("	   , '" + FORM_CD + "'         \n");
				sbSql.append("	   , '" + CLASS_CD + "'        \n");
				sbSql.append("	   , '" + HL_CLASS_CD + "'     \n");
				sbSql.append("	   , '" + HL_CLASS_NM + "'     \n");
				sbSql.append("	   , '" + HM_CLASS_CD + "'     \n");
				sbSql.append("	   , '" + HM_CLASS_NM + "'     \n");
				sbSql.append("	   , '" + CLASS_NM + "'        \n");
				sbSql.append("	   , DECODE('" + CHK_IDCTR + "','','0','" + CHK_IDCTR + "') \n");
				sbSql.append("	   , DECODE('" + NOT_FIT_SCORE + "','','0','" + NOT_FIT_SCORE + "') \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append(" ) \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				TABLE_TYPE      = nullToBlank(ds_hsClassList.getString(i,"TABLE_TYPE")); 
				FORM_CD         = nullToBlank(ds_hsClassList.getString(i,"FORM_CD"));       
				CLASS_CD        = nullToBlank(ds_hsClassList.getString(i,"CLASS_CD"));      
				CLASS_NM        = nullToBlank(ds_hsClassList.getString(i,"CLASS_NM"));
				CHK_IDCTR       = nullToBlank(ds_hsClassList.getString(i,"CHK_IDCTR"));
				NOT_FIT_SCORE   = nullToBlank(ds_hsClassList.getString(i,"NOT_FIT_SCORE"));
				FOCS_ARTICLE_YN = nullToBlank(ds_hsClassList.getString(i,"FOCS_ARTICLE_YN"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_PATL_CLASS                    \n"); 
				sbSql.append("   SET CLASS_NM    = '" + CLASS_NM + "'    \n"); 
				sbSql.append("     , UUSER       = '" + g_EmpNo + "'     \n"); 
				sbSql.append("     , UDATE       = SYSDATE               \n"); 
				sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'   \n");
				sbSql.append("   AND FORM_CD = '" + FORM_CD + "'         \n");
				sbSql.append("   AND CLASS_CD = '" + CLASS_CD + "'       \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_PATL_FORM_DTL \n");
				sbSql.append("   SET CLASS_NM        = '" + CLASS_NM + "'        \n");
				sbSql.append("	   , CHK_IDCTR = DECODE('" + CHK_IDCTR + "','','0','" + CHK_IDCTR + "') \n");
				sbSql.append("	   , NOT_FIT_SCORE = DECODE('" + NOT_FIT_SCORE + "','','0','" + NOT_FIT_SCORE + "') \n");
				sbSql.append("     , UUSER           = '" + g_EmpNo + "'         \n"); 
				sbSql.append("     , UDATE           = SYSDATE                   \n"); 
				sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'   \n");
				sbSql.append("   AND FORM_CD    = '" + FORM_CD + "'      \n");
				sbSql.append("   AND CLASS_CD   = '" + CLASS_CD + "'     \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}	
		
		// 양식 마스터 최종 수정자, 수정일 업데이트
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FSC_PATL_FORM                   \n"); 
		sbSql.append("   SET UUSER     = '" + g_EmpNo + "'     \n"); 
		sbSql.append("     , UDATE     = SYSDATE               \n"); 
		sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
		sbSql.append("   AND FORM_CD = '" + FORM_CD + "'       \n");

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