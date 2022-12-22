<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/테스트관리                                                                                                                                                                     
■ 프로그램ID   : FSC91030E_T006.jsp                                                                                                                                                                    
■ 프로그램명   : 테스트관리                                                                                                                                                 
■ 작성일자     : 2019-07-03                                                                                                                                                                            
■ 작성자       : 김명섭                                                                                                                                                                                
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@ page import="java.io.*
    , java.util.*
    , org.springframework.web.context.*
    , org.springframework.web.context.support.WebApplicationContextUtils
    , com.hwfs.cmn.service.PropertiesService
    , hone.core.util.record.*
    , com.hwfs.ls.cmn.util.LimsUtil"%>
<%
	ServletContext sc = pageContext.getServletContext();
	WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

    //propertiesService Bean을 얻는다.
    PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");

    Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_Master  	= in_dl.get("ds_MasterCp");
		DataSet ds_Detail	= in_dl.get("ds_Detail");
		DataSet ds_Detail1	= in_dl.get("ds_Detail1");
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		int RowCnt;
		int i;
		String strFormCD;
		int nSeqno=0;
		
		//시퀀스
		if(ds_Master.getInt(0,"SEQNO") > 0)
		{
			nSeqno = ds_Master.getInt(0,"SEQNO");
		}
		else
		{
			//시퀀스생성
	        sbSql.append("SELECT NVL(MAX(T1.SEQNO),0) + 1 ISDATA							\n");
	        sbSql.append("  FROM FSC_TEST_EXTERNAL_MST T1                                  	\n");
	        sbSql.append(" WHERE T1.UPJANG = '" + ds_Master.getString(0,"UPJANG") + "'     	\n");
	        sbSql.append(" 	 AND T1.VISIT_DT = '" + ds_Master.getString(0,"VISIT_DT") + "' 	\n");
	        pstmt = conn.prepareStatement(sbSql.toString());
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	        	nSeqno = rs.getInt("ISDATA");
	        }
	        if(rs != null) rs.close();
			
		}
	
		// 1.Master
		RowCnt = ds_Master.getRowCount();
		
		if (RowCnt > 0)
		{

			sbSql.delete(0, sbSql.length());
			sbSql.append(" MERGE INTO FSC_TEST_EXTERNAL_MST \n");
			sbSql.append(" USING DUAL \n");
			sbSql.append(" ON ( \n");
			sbSql.append(" UPJANG = '" + ds_Master.getString(0,"UPJANG") + "' \n");
			sbSql.append(" AND VISIT_DT = '" + ds_Master.getString(0,"VISIT_DT") + "' \n");
			sbSql.append(" AND SEQNO = " + nSeqno + " \n");
			sbSql.append(" ) \n");
			sbSql.append(" WHEN MATCHED THEN \n");
			sbSql.append(" UPDATE SET \n");
			sbSql.append("     TM_CD = '"				+	nullToBlank(ds_Master.getString(0,"TM_CD"))					+"' \n");
			sbSql.append("   , TEAM_MST_SABUN = '"		+	nullToBlank(ds_Master.getString(0,"TEAM_MST_SABUN"))		+"' \n");
			sbSql.append("	 , SUBTEAM_MST_SABUN = '"	+	nullToBlank(ds_Master.getString(0,"SUBTEAM_MST_SABUN"))		+"' \n");
			sbSql.append("	 , CHARGE_SABUN = '"		+	nullToBlank(ds_Master.getString(0,"CHARGE_SABUN"))			+"' \n");
			sbSql.append("	 , PERMISSION_TYPE = '"		+	nullToBlank(ds_Master.getString(0,"PERMISSION_TYPE"))		+"' \n");
			sbSql.append("	 , AGENCY_TYPE = '"			+	nullToBlank(ds_Master.getString(0,"AGENCY_TYPE"))			+"' \n");
			sbSql.append("	 , CHECK_TYPE = '"			+	nullToBlank(ds_Master.getString(0,"CHECK_TYPE"))			+"' \n");
			sbSql.append("	 , AGENCY_NM = '"			+	nullToBlank(ds_Master.getString(0,"AGENCY_NM"))							+"' \n");
			sbSql.append("	 , VISIT_NM = '"			+	nullToBlank(ds_Master.getString(0,"VISIT_NM"))							+"' \n");
			sbSql.append("	 , CONFIRM_YN = '"			+	nullToBlank(ds_Master.getString(0,"CONFIRM_YN"))							+"' \n");
			sbSql.append("	 , EXPOSE_YN = '"			+	nullToBlank(ds_Master.getString(0,"EXPOSE_YN"))							+"' \n");
			sbSql.append("	 , PICK_CHECK_YN = '"		+	nullToBlank(ds_Master.getString(0,"PICK_CHECK_YN"))						+"' \n");
			sbSql.append("	 , CHECK_CONTENTS = '"		+	nullToBlank(ds_Master.getString(0,"CHECK_CONTENTS"))						+"' \n");
			sbSql.append("	 , ETC_CONTENTS = '"		+	nullToBlank(ds_Master.getString(0,"ETC_CONTENTS"))						+"' \n");
			sbSql.append("	 , UUSER = '" 				+ 	g_EmpNo 													+"' \n");
			sbSql.append("	 , UDATE = SYSDATE \n");
			sbSql.append(" WHEN NOT MATCHED THEN \n");
			sbSql.append("INSERT ( \n");
			sbSql.append("	  UPJANG \n");
			sbSql.append("	, VISIT_DT \n");
			sbSql.append("	, SEQNO \n");
			sbSql.append("	, TM_CD \n");
			sbSql.append("	, TEAM_MST_SABUN \n");
			sbSql.append("	, SUBTEAM_MST_SABUN \n");
			sbSql.append("	, CHARGE_SABUN \n");
			sbSql.append("	, PERMISSION_TYPE \n");
			sbSql.append("	, AGENCY_TYPE \n");
			sbSql.append("	, CHECK_TYPE \n");
			sbSql.append("	, AGENCY_NM \n");
			sbSql.append("	, VISIT_NM \n");
			sbSql.append("	, CONFIRM_YN \n");
			sbSql.append("	, EXPOSE_YN \n");
			sbSql.append("	, PICK_CHECK_YN \n");
			sbSql.append("	, CHECK_CONTENTS \n");
			sbSql.append("	, ETC_CONTENTS \n");
			sbSql.append("	, CUSER \n");
			sbSql.append("	, CDATE \n");
			sbSql.append("	, UUSER \n");
			sbSql.append("	, UDATE \n");
			sbSql.append(" ) VALUES ( \n");
			sbSql.append("	  '"	+	ds_Master.getString(0,"UPJANG")							+"' \n");
			sbSql.append("	, '"	+	ds_Master.getString(0,"VISIT_DT")						+"' \n");
			sbSql.append("	, "		+	nSeqno													+"  \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"TM_CD"))				+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"TEAM_MST_SABUN"))	+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"SUBTEAM_MST_SABUN"))	+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"CHARGE_SABUN"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"PERMISSION_TYPE"))	+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"AGENCY_TYPE"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"CHECK_TYPE"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"AGENCY_NM"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"VISIT_NM"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"CONFIRM_YN"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"EXPOSE_YN"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"PICK_CHECK_YN"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"CHECK_CONTENTS"))	+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"ETC_CONTENTS"))		+"' \n");
			sbSql.append("	, '" 	+ 	g_EmpNo 												+"' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append("	, '" 	+ 	g_EmpNo 												+"' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append(" ) \n");

			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
		}

		// 2.Detail
		RowCnt = ds_Detail.getRowCount();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{

			sbSql.delete(0, sbSql.length());
			sbSql.append(" MERGE INTO FSC_TEST_EXTERNAL_DTL \n");
			sbSql.append(" USING DUAL \n");
			sbSql.append(" ON ( \n");
			sbSql.append(" UPJANG = '" + ds_Detail.getString(i,"UPJANG") + "' \n");
			sbSql.append(" AND VISIT_DT = '" + ds_Detail.getString(i,"VISIT_DT") + "' \n");
			sbSql.append(" AND SEQNO =  " + nSeqno + " \n");
			sbSql.append(" AND CHECKSEQ =  " + ds_Detail.getInt(i,"CHECKSEQ") + " \n");
			sbSql.append(" ) \n");
			sbSql.append(" WHEN MATCHED THEN \n");
			sbSql.append(" UPDATE SET \n");
			sbSql.append("     CHECKGB = '"			+	nullToBlank(ds_Detail.getString(i,"CHECKGB"))				+"' \n");
			sbSql.append("   , CHECKDTL = '"		+	nullToBlank(ds_Detail.getString(i,"CHECKDTL"))				+"' \n");
			sbSql.append("   , CHECK_CONTENTS = '"	+	nullToBlank(ds_Detail.getString(i,"CHECK_CONTENTS"))		+"' \n");
			sbSql.append("   , IMPRV_CONTENTS = '"	+	nullToBlank(ds_Detail.getString(i,"IMPRV_CONTENTS"))		+"' \n");
			sbSql.append("   , IMPRV_DT = '"		+	nullToBlank(ds_Detail.getString(i,"IMPRV_DT"))				+"' \n");
			sbSql.append("   , MAIN_AGENT = '"		+	nullToBlank(ds_Detail.getString(i,"MAIN_AGENT"))			+"' \n");
			sbSql.append("   , APPEND_FILENM = '"	+	nullToBlank(ds_Detail.getString(i,"APPEND_FILENM"))			+"' \n");
			sbSql.append("   , SERVER_FILENM = '"	+	nullToBlank(ds_Detail.getString(i,"SERVER_FILENM"))			+"' \n");
			sbSql.append("	 , UUSER = '" 			+ 	g_EmpNo 													+ "' \n");
			sbSql.append("	 , UDATE = SYSDATE \n");
			sbSql.append(" WHEN NOT MATCHED THEN \n");
			sbSql.append("INSERT ( \n");
			sbSql.append("	  UPJANG \n");
			sbSql.append("	, VISIT_DT \n");
			sbSql.append("	, SEQNO \n");
			sbSql.append("	, CHECKSEQ \n");
			sbSql.append("	, CHECKGB \n");
			sbSql.append("	, CHECKDTL \n");
			sbSql.append("	, CHECK_CONTENTS \n");
			sbSql.append("	, IMPRV_CONTENTS \n");
			sbSql.append("	, IMPRV_DT \n");
			sbSql.append("	, MAIN_AGENT \n");
			sbSql.append("	, APPEND_FILENM \n");
			sbSql.append("	, SERVER_FILENM \n");
			sbSql.append("	, CUSER \n");
			sbSql.append("	, CDATE \n");
			sbSql.append("	, UUSER \n");
			sbSql.append("	, UDATE \n");
			sbSql.append(" ) VALUES ( \n");
			sbSql.append("	  '"	+	ds_Detail.getString(i,"UPJANG")							+"' \n");
			sbSql.append("	, '" 	+ 	ds_Detail.getString(i,"VISIT_DT")						+"' \n");
			sbSql.append("	,  "    +   nSeqno													+"  \n");
			sbSql.append("	, (SELECT NVL(MAX(CHECKSEQ),0)+1 FROM FSC_TEST_EXTERNAL_DTL "    	+"  \n");
			sbSql.append("      WHERE UPJANG = '" + ds_Detail.getString(i,"UPJANG") 			+"' \n");
			sbSql.append("        AND VISIT_DT = '" + ds_Detail.getString(i,"VISIT_DT") 		+"' \n");
			sbSql.append("        AND SEQNO =  " + nSeqno 										+") \n");
			sbSql.append("	, '"    +   nullToBlank(ds_Detail.getString(i,"CHECKGB"))			+"' \n");
			sbSql.append("	, '"    +   nullToBlank(ds_Detail.getString(i,"CHECKDTL"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"CHECK_CONTENTS"))	+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"IMPRV_CONTENTS"))	+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"IMPRV_DT"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"MAIN_AGENT"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"APPEND_FILENM"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"SERVER_FILENM"))		+"' \n");
			sbSql.append("	, '" 	+ 	g_EmpNo 												+"' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append("	, '" 	+ 	g_EmpNo 												+"' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append(" ) \n");

			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
		}

		// 3.Detail1
		RowCnt = ds_Detail1.getRowCount();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{

			sbSql.delete(0, sbSql.length());
			sbSql.append(" MERGE INTO FSC_TEST_EXTERNAL_DTL_PICK \n");
			sbSql.append(" USING DUAL \n");
			sbSql.append(" ON ( \n");
			sbSql.append(" UPJANG = '" + ds_Detail1.getString(i,"UPJANG") + "' \n");
			sbSql.append(" AND VISIT_DT = '" + ds_Detail1.getString(i,"VISIT_DT") + "' \n");
			sbSql.append(" AND SEQNO =  " + nSeqno + " \n");
			sbSql.append(" AND CHECKSEQ =  " + ds_Detail1.getInt(i,"CHECKSEQ") + " \n");
			sbSql.append(" ) \n");
			sbSql.append(" WHEN MATCHED THEN \n");
			sbSql.append(" UPDATE SET \n");
			sbSql.append("     CHECKGB = '"			+	nullToBlank(ds_Detail1.getString(i,"CHECKGB"))				+"' \n");
			sbSql.append("   , PUMMOK = '"			+	nullToBlank(ds_Detail1.getString(i,"PUMMOK"))				+"' \n");
			sbSql.append("   , STATUS = '"			+	nullToBlank(ds_Detail1.getString(i,"STATUS"))				+"' \n");
			sbSql.append("   , MOVEGB = '"			+	nullToBlank(ds_Detail1.getString(i,"MOVEGB"))				+"' \n");
			sbSql.append("	 , UUSER = '" 			+ 	g_EmpNo 													+ "' \n");
			sbSql.append("	 , UDATE = SYSDATE \n");
			sbSql.append(" WHEN NOT MATCHED THEN \n");
			sbSql.append("INSERT ( \n");
			sbSql.append("	  UPJANG \n");
			sbSql.append("	, VISIT_DT \n");
			sbSql.append("	, SEQNO \n");
			sbSql.append("	, CHECKSEQ \n");
			sbSql.append("	, CHECKGB \n");
			sbSql.append("	, PUMMOK \n");
			sbSql.append("	, STATUS \n");
			sbSql.append("	, MOVEGB \n");
			sbSql.append("	, CUSER \n");
			sbSql.append("	, CDATE \n");
			sbSql.append("	, UUSER \n");
			sbSql.append("	, UDATE \n");
			sbSql.append(" ) VALUES ( \n");
			sbSql.append("	  '"	+	ds_Detail1.getString(i,"UPJANG")						+"' \n");
			sbSql.append("	, '" 	+ 	ds_Detail1.getString(i,"VISIT_DT")						+"' \n");
			sbSql.append("	,  "    +   nSeqno													+"  \n");
			sbSql.append("	, (SELECT NVL(MAX(CHECKSEQ),0)+1 FROM FSC_TEST_EXTERNAL_DTL_PICK " 	+"  \n");
			sbSql.append("      WHERE UPJANG = '" + ds_Detail1.getString(i,"UPJANG") 			+"' \n");
			sbSql.append("        AND VISIT_DT = '" + ds_Detail1.getString(i,"VISIT_DT") 		+"' \n");
			sbSql.append("        AND SEQNO =  " + nSeqno 										+") \n");
			sbSql.append("	, '"    +   nullToBlank(ds_Detail1.getString(i,"CHECKGB"))			+"' \n");
			sbSql.append("	, '"    +   nullToBlank(ds_Detail1.getString(i,"PUMMOK"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"STATUS"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"MOVEGB"))			+"' \n");
			sbSql.append("	, '" 	+ 	g_EmpNo 												+"' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append("	, '" 	+ 	g_EmpNo 												+"' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append(" ) \n");

			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
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