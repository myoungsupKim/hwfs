
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
		
		//입력 데이타               
		DataSet ds_input    = in_dl.get("ds_input");		    // 입력마스터값
		DataSet ds_imgeList = in_dl.get("ds_imgeList");
		String g_EmpNo      = in_vl.getString("g_EmpNo");

		String strEvntDate 		= ds_input.getString(0, "EVNT_DATE"); 
		String strSclassCd 		= ds_input.getString(0, "SCLASS_CD");
		String strSeq 			= ds_input.getString(0, "SEQ");          
		String strUpjang 		= ds_input.getString(0, "UPJANG_CD");        
		String strChk 			= ds_input.getString(0, "CHK");
	  	String strMgrpCd 			= ds_input.getString(0, "MGRP_CD");   
	  	String strMclass 			= ds_input.getString(0, "MCLASS_CD");   
	  	String strQuantity 			= ds_input.getString(0, "QUANTITY");   
	  	
	  	String strRequestNm = "";
	  	String strCntcNum = "";
	  	String strAddr = "";
	  	String strEventTitle = "";
	  	String strMealQty = "";	  	

	  	String strCustSatisfac = "";	  	
	  	String strUtensilStatus = "";	  	

	  	String strApprStatus = "";	  	
	  	String strEvntNo = "";	  	
	  	
		String strOrgImge = "";
		String strSvrImge = "";
		String strImprovOrgImge = "";
		String strImprovSvrImge = "";
		
		int RowStatus;
		StringBuffer sbSql 	= new StringBuffer();		//sql문 버퍼생성
		
		int RowCnt = ds_imgeList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_imgeList.getRowType(i);
			//if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			if ( strChk.equals("INSERT") )
			{ 
				strUpjang 		= ds_imgeList.getString(i, "UPJANG_CD");
				
				strRequestNm        = ds_imgeList.getString(i, "REQUEST_NM");
				strCntcNum        = ds_imgeList.getString(i, "CNTC_NUM");
				strAddr        = ds_imgeList.getString(i, "ADDR");
				strEventTitle        = ds_imgeList.getString(i, "EVNT_TITLE");
				strMealQty        = ds_imgeList.getString(i, "MEAL_QTY");
				
				strCustSatisfac        = ds_imgeList.getString(i, "CUST_SATISFAC");
				strUtensilStatus        = ds_imgeList.getString(i, "UTENSIL_STATUS");
				
				strOrgImge        = nullToBlank(ds_imgeList.getString(i, "ORG_IMGE"));          
				strSvrImge        = nullToBlank(ds_imgeList.getString(i, "SVR_IMGE"));
				strImprovOrgImge  = nullToBlank(ds_imgeList.getString(i, "IMPROV_ORG_IMGE"));
				strImprovSvrImge  = nullToBlank(ds_imgeList.getString(i, "IMPROV_SVR_IMGE"));          
				
				sbSql.delete(0, sbSql.length());
				sbSql.append(" INSERT INTO FSE_EVENT_MASTER(                                                \n");
				sbSql.append("       EVNT_NO                                                                \n");
				sbSql.append("       , EVNT_ID                                                            \n");
				sbSql.append("       , UPJANG_CD                                                            \n");
				sbSql.append("       , UTENSIL_ID                                                           \n");
				sbSql.append("       , EVNT_DATE                                                            \n");
				sbSql.append("       , MGRP_CD                                                              \n");
				sbSql.append("       , MCLASS_CD                                                            \n");
				sbSql.append("       , SCLASS_CD                                                            \n");
				sbSql.append("       , SEQ                                                                  \n");
				sbSql.append("       , QUANTITY                                                             \n");
				sbSql.append("       , REQUEST_NM                                                           \n");
				sbSql.append("       , CNTC_NUM                                                             \n");
				sbSql.append("       , ZIP_CODE                                                             \n");
				sbSql.append("       , ADDR                                                                 \n");
				sbSql.append("       , CNTC_NUM_ENC                                                         \n");
				sbSql.append("       , ADDR_ENC                                                             \n");
				sbSql.append("       , BEFORE_IMGE                                                          \n");
				sbSql.append("       , SVR_BEFORE_IMGE                                                      \n");
				sbSql.append("       , AFTER_IMGE                                                           \n");
				sbSql.append("       , SVR_AFTER_IMGE                                                       \n");
				sbSql.append("       , CUST_SATISFAC                                                        \n");
				sbSql.append("       , CUST_RESPONSE_EVAL                                                   \n");
				sbSql.append("       , UTENSIL_STATUS                                                       \n");
				sbSql.append("       , EVNT_TITLE                                                           \n");
				sbSql.append("       , MEAL_QTY                                                             \n");
				sbSql.append("       , APPR_SABUN                                                           \n");
				sbSql.append("       , APPR_STATUS                                                          \n");
				sbSql.append("       , RTN_REASON_CODE                                                      \n");
				sbSql.append("       , RTN_REASON                                                           \n");
				sbSql.append("       , USE_YN                                                               \n");
				sbSql.append("       , CUSER                                                                \n");
				sbSql.append("       , CDATE                                                                \n");
				sbSql.append(" ) VALUES (                                                                   \n");
				sbSql.append("           FSE_EVENT_MASTER_S.NEXTVAL											\n");
				sbSql.append("         , '" + strEvntDate + "' || '" + strSclassCd + "' || '" + strSeq + "' \n");
				sbSql.append("         ,  '" 	+ strUpjang  + "'                                             \n");
				sbSql.append("         ,  '" + strSclassCd + "' || '" + strSeq + "'                         \n");
				sbSql.append("         ,  '" 	+ strEvntDate  + "'                                           \n");
				sbSql.append("         ,  '" 	+ strMgrpCd  + "'                                             \n");
				sbSql.append("         ,  '" 	+ strMclass  + "'                                             \n");
				sbSql.append("         ,  '" 	+ strSclassCd  + "'                                             \n");
				sbSql.append("         ,  '" 	+ strSeq  + "'                                                \n");
				sbSql.append("         ,  '" 	+ strQuantity  + "'                                           \n");
				sbSql.append("         ,  '" 	+ strRequestNm  + "'                                          \n");
				sbSql.append("         ,  '" 	+ strCntcNum  + "'                                            \n");
				sbSql.append("         ,  ''                                                                \n");
				sbSql.append("         ,  '" 	+ strAddr  + "'                                               \n");
				sbSql.append("         ,  ''                                                                \n");
				sbSql.append("         ,  ''                                                                \n");
				sbSql.append("         , '" + strOrgImge       	+ "'                                        \n");
				sbSql.append("         , '" + strSvrImge        + "'                                        \n");
				sbSql.append("         , '" + strImprovOrgImge  + "'                                        \n");
				sbSql.append("         , '" + strImprovSvrImge  + "'                                        \n");
				sbSql.append("         ,  '" 	+ strCustSatisfac  + "'                                       \n");
				sbSql.append("         ,  ''                                                                \n");
				sbSql.append("         ,  '" 	+ strUtensilStatus  + "'                                      \n");
				sbSql.append("         ,  '" 	+ strEventTitle  + "'                                         \n");
				sbSql.append("         ,  '" 	+ strMealQty  + "'                                            \n");
				sbSql.append("         ,  ''                                                                \n");
				sbSql.append("         ,  '10'                                                                \n");
				sbSql.append("         ,  ''                                                                \n");
				sbSql.append("         ,  ''                                                                \n");
				sbSql.append("         ,  'Y'                                                               \n");
				sbSql.append("         ,  '" + g_EmpNo           + "'                                       \n");
				sbSql.append("         ,  SYSDATE                                                           \n");
				sbSql.append(" )                                                                            \n"); 		
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( strChk.equals("SEARCH") ) {
				strRequestNm        = ds_imgeList.getString(i, "REQUEST_NM");
				strCntcNum        = ds_imgeList.getString(i, "CNTC_NUM");
				strAddr        = ds_imgeList.getString(i, "ADDR");
				strEventTitle        = ds_imgeList.getString(i, "EVNT_TITLE");
				strMealQty        = ds_imgeList.getString(i, "MEAL_QTY");
				
				strCustSatisfac        = nullToBlank(ds_imgeList.getString(i, "CUST_SATISFAC"));
				strUtensilStatus        = nullToBlank(ds_imgeList.getString(i, "UTENSIL_STATUS"));

				strApprStatus        = ds_imgeList.getString(i, "APPR_STATUS");

				strEvntNo        = ds_imgeList.getString(i, "EVNT_NO");
				
				strOrgImge        = nullToBlank(ds_imgeList.getString(i, "ORG_IMGE"));          
				strSvrImge        = nullToBlank(ds_imgeList.getString(i, "SVR_IMGE"));
				strImprovOrgImge  = nullToBlank(ds_imgeList.getString(i, "IMPROV_ORG_IMGE"));
				strImprovSvrImge  = nullToBlank(ds_imgeList.getString(i, "IMPROV_SVR_IMGE"));  
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSE_EVENT_MASTER                        \n");
				sbSql.append("   SET REQUEST_NM        = '" + strRequestNm        + "' \n");
				sbSql.append("     , CNTC_NUM        = '" + strCntcNum        + "' \n");
				sbSql.append("     , ADDR        = '" + strAddr        + "' \n");
				sbSql.append("     , EVNT_TITLE        = '" + strEventTitle        + "' \n");
				sbSql.append("     , MEAL_QTY        = '" + strMealQty        + "' \n");
				
				sbSql.append("     , CUST_SATISFAC        = '" + strCustSatisfac        + "' \n");
				sbSql.append("     , UTENSIL_STATUS        = '" + strUtensilStatus        + "' \n");

				sbSql.append("     , APPR_STATUS        = '" + strApprStatus        + "' \n");
				
				sbSql.append("     , BEFORE_IMGE        = '" + strOrgImge        + "' \n");
				sbSql.append("     , SVR_BEFORE_IMGE        = '" + strSvrImge        + "' \n");
				sbSql.append("     , AFTER_IMGE = '" + strImprovOrgImge  + "' \n");
				sbSql.append("     , SVR_AFTER_IMGE = '" + strImprovSvrImge  + "' \n");
				sbSql.append("     , UUSER           = '" + g_EmpNo           + "' \n"); 
				sbSql.append("     , UDATE           = SYSDATE                     \n");
			    sbSql.append(" WHERE EVNT_ID = '" + strEvntDate + "' || '" + strSclassCd + "' || '" + strSeq + "'\n");
				sbSql.append("   AND EVNT_NO = '" + strEvntNo + "'                     \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();				
			}
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK", out_vl);
		
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