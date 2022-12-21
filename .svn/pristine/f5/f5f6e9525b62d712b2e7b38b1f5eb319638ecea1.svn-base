<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/테스트관리                                                                                                                                                                     
■ 프로그램ID   : FSC91020E_T003.jsp                                                                                                                                                                    
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
		DataSet ds_Master  	= in_dl.get("ds_Master");
		DataSet ds_Detail   = in_dl.get("ds_Detail");
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		int RowCnt;
		int i;
		String strFormCD;
	
		// 1.Master
		RowCnt = ds_Master.getRowCount();
		
		if (RowCnt > 0)
		{

			sbSql.delete(0, sbSql.length());
			sbSql.append(" MERGE INTO FSC_TEST_RESULT_MST \n");
			sbSql.append(" USING DUAL \n");
			sbSql.append(" ON ( \n");
			sbSql.append(" UPJANG = '" + nullToBlank(ds_Master.getString(0,"UPJANG")) 			+ "' \n");
			sbSql.append(" AND TRAINEE = '" + nullToBlank(ds_Master.getString(0,"TRAINEE")) 	+ "' \n");
			sbSql.append(" AND TEST_DATE = '" + nullToBlank(ds_Master.getString(0,"TEST_DATE")) + "' \n");
			sbSql.append(" ) \n");
			sbSql.append(" WHEN MATCHED THEN \n");
			sbSql.append(" UPDATE SET \n");
			sbSql.append("     TEST_TYPE = '"		+	nullToBlank(ds_Master.getString(0,"TEST_TYPE"))			+"' \n");
			sbSql.append("	 , FORM_CD = '"			+	nullToBlank(ds_Master.getString(0,"FORM_CD"))			+"' \n");
			sbSql.append("	 , STATUS = '"			+	nullToBlank(ds_Master.getString(0,"STATUS"))			+"' \n");
			sbSql.append("	 , TM_CD = '"			+	nullToBlank(ds_Master.getString(0,"TM_CD"))				+"' \n");
			sbSql.append("	 , CHARGE_SABUN = '"	+	nullToBlank(ds_Master.getString(0,"CHARGE_SABUN"))		+"' \n");
			sbSql.append("	 , COMPLETEYN = '"		+	nullToBlank(ds_Master.getString(0,"COMPLETEYN"))		+"' \n");
			sbSql.append("	 , SCORE = "			+	ds_Master.getInt(0,"SCORE")								+"  \n");
			sbSql.append("	 , UUSER = '" 			+ 	g_EmpNo 												+ "' \n");
			sbSql.append("	 , UDATE = SYSDATE \n");
			sbSql.append(" WHEN NOT MATCHED THEN \n");
			sbSql.append("INSERT ( \n");
			sbSql.append("	  UPJANG \n");
			sbSql.append("	, TRAINEE \n");
			sbSql.append("	, TEST_DATE \n");
			sbSql.append("	, TEST_TYPE \n");
			sbSql.append("	, FORM_CD \n");
			sbSql.append("	, STATUS \n");
			sbSql.append("	, TM_CD \n");
			sbSql.append("	, CHARGE_SABUN \n");
			sbSql.append("	, COMPLETEYN \n");
			sbSql.append("	, SCORE \n");
			sbSql.append("	, CUSER \n");
			sbSql.append("	, CDATE \n");
			sbSql.append("	, UUSER \n");
			sbSql.append("	, UDATE \n");
			sbSql.append(" ) VALUES ( \n");
			sbSql.append("	  '"	+	nullToBlank(ds_Master.getString(0,"UPJANG"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"TRAINEE"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"TEST_DATE"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"TEST_TYPE"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"FORM_CD"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"STATUS"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"TM_CD"))				+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"CHARGE_SABUN"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"COMPLETEYN"))		+"' \n");
			sbSql.append("	, "		+	ds_Master.getInt(0,"SCORE")								+"  \n");
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
			sbSql.append(" MERGE INTO FSC_TEST_RESULT_DTL \n");
			sbSql.append(" USING DUAL \n");
			sbSql.append(" ON ( \n");
			sbSql.append(" UPJANG = '" + nullToBlank(ds_Detail.getString(i,"UPJANG")) 			+ "' \n");
			sbSql.append(" AND TRAINEE = '" + nullToBlank(ds_Detail.getString(i,"TRAINEE")) 	+ "' \n");
			sbSql.append(" AND TEST_DATE = '" + nullToBlank(ds_Master.getString(0,"TEST_DATE")) + "' \n");
			sbSql.append(" AND STATUS = '" + nullToBlank(ds_Detail.getString(i,"STATUS")) 		+ "' \n");
			sbSql.append(" AND SEQNO = '" + ds_Detail.getInt(i,"SEQNO")		 					+ "' \n");
			sbSql.append(" ) \n");
			sbSql.append(" WHEN MATCHED THEN \n");
			sbSql.append(" UPDATE SET \n");
			sbSql.append("     START_DT = '"	+	nullToBlank(ds_Detail.getString(i,"START_DT"))			+"' \n");
			sbSql.append("   , END_DT = '"	+	nullToBlank(ds_Detail.getString(i,"END_DT"))				+"' \n");
			sbSql.append("   , ATTR01 = '"	+	nullToBlank(ds_Detail.getString(i,"ANSWER"))				+"' \n");
			sbSql.append("	 , UUSER = '" 			+ 	g_EmpNo 											+ "' \n");
			sbSql.append("	 , UDATE = SYSDATE \n");
			sbSql.append(" WHEN NOT MATCHED THEN \n");
			sbSql.append("INSERT ( \n");
			sbSql.append("	  UPJANG \n");
			sbSql.append("	, TRAINEE \n");
			sbSql.append("	, TEST_DATE \n");
			sbSql.append("	, STATUS \n");
			sbSql.append("	, SEQNO \n");
			sbSql.append("	, START_DT \n");
			sbSql.append("	, END_DT \n");
			sbSql.append("	, ATTR01 \n");
			sbSql.append("	, CUSER \n");
			sbSql.append("	, CDATE \n");
			sbSql.append("	, UUSER \n");
			sbSql.append("	, UDATE \n");
			sbSql.append(" ) VALUES ( \n");
			sbSql.append("	  '"	+	nullToBlank(ds_Detail.getString(i,"UPJANG"))				+"' \n");
			sbSql.append("	, '"    +   nullToBlank(ds_Detail.getString(i,"TRAINEE"))				+"' \n");
			sbSql.append("	, '"    +   nullToBlank(ds_Master.getString(0,"TEST_DATE"))				+"' \n");
			sbSql.append("	, '"    +   nullToBlank(ds_Detail.getString(i,"STATUS"))				+"' \n");
			sbSql.append("	,  "    +   ds_Detail.getInt(i,"SEQNO")									+"  \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"START_DT"))				+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"END_DT"))				+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"ANSWER"))				+"' \n");
			sbSql.append("	, '" 	+ 	g_EmpNo 													+"' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append("	, '" 	+ 	g_EmpNo 													+"' \n");
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