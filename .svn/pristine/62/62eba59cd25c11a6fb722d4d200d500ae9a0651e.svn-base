<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/외부기관점검관리                                                                                                                                                                     
■ 프로그램ID   : FSC91030P_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 수검사진관리                                                                                                                                                 
■ 작성일자     : 2019-07-04                                                                                                                                                                            
■ 작성자       : 김명섭                                                                                                                                                                                
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
                                                                                                                                                                    
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ include file = "../../sc/main/common.jsp" %>                                                                                                                                                        
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();  
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		String g_EmpNo      = in_vl.getString("g_EmpNo");                                                                                                                                                                             
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input");           

	  	String strEvntDate 		= ds_input.getString(0, "EVNT_DATE"); 
	  	String strSclassCd 		= ds_input.getString(0, "SCLASS_CD");
	  	String strSeq 			= ds_input.getString(0, "SEQ");          
	  	String strUpjang 		= ds_input.getString(0, "UPJANG_CD");        
	  	String strChk 			= ds_input.getString(0, "CHK");     
	  	String strEvntNo 		= ds_input.getString(0, "EVNT_NO");                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_imgeList;
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        

		if ( strChk.equals("SEARCH") )
		{                     
			sbSql.append("SELECT EVNT_NO,                                   \n");
		    sbSql.append("       EVNT_ID,                                   \n");
		    sbSql.append("       UPJANG_CD,                                 \n");
		    sbSql.append("       SCC_UPJANGNM_FUN(UPJANG_CD) AS UPJANG_NM,                                 \n");
		    sbSql.append("       UTENSIL_ID,                                \n");
		    sbSql.append("       EVNT_DATE,                                 \n");
		    sbSql.append("       MGRP_CD,                                   \n");
		    sbSql.append("       MCLASS_CD,                                 \n");
		    sbSql.append("       SCLASS_CD,                                 \n");
		    sbSql.append("       SEQ,                                       \n");
		    sbSql.append("       QUANTITY,                                  \n");
		    sbSql.append("       REQUEST_NM,                             \n");
		    sbSql.append("       CNTC_NUM,                                  \n");
		    sbSql.append("       ZIP_CODE,                                  \n");
		    sbSql.append("       ADDR,                                      \n");
		    sbSql.append("       CNTC_NUM_ENC,                              \n");
		    sbSql.append("       ADDR_ENC,                                  \n");
		    sbSql.append("       BEFORE_IMGE AS ORG_IMGE,                               \n");
		    sbSql.append("       SVR_BEFORE_IMGE AS SVR_IMGE,                           \n");
			sbSql.append("      '' AS IMG_FILE, \n");
			sbSql.append("      '' AS ISUPLOAD, \n");
		    sbSql.append("       AFTER_IMGE AS IMPROV_ORG_IMGE,                                \n");
		    sbSql.append("       SVR_AFTER_IMGE AS IMPROV_SVR_IMGE,                            \n");
			sbSql.append("      '' AS IMPROV_IMG_FILE, \n");
			sbSql.append("      '' AS IMPROV_ISUPLOAD, \n");
		    sbSql.append("       CUST_SATISFAC,                             \n");
		    sbSql.append("       CUST_RESPONSE_EVAL,                        \n");
		    sbSql.append("       UTENSIL_STATUS,                            \n");
		    sbSql.append("       EVNT_TITLE,                                \n");
		    sbSql.append("       MEAL_QTY,                                  \n");
		    sbSql.append("       APPR_SABUN,                                \n");
		    sbSql.append("       APPR_STATUS,                               \n");
		    sbSql.append("       RTN_REASON_CODE,                           \n");
		    sbSql.append("       RTN_REASON,                                \n");
		    sbSql.append("       USE_YN                                     \n");
		    sbSql.append("       ,(SELECT COUNT(EVNT_ID) FROM FSE_EVENT_MASTER                                 \n");
		    sbSql.append("          WHERE SCLASS_CD = '" + strSclassCd + "'                                 \n");
		    sbSql.append("            AND SEQ = '" + strSeq + "'                                 \n");
		    sbSql.append("            AND APPR_STATUS <> '30') AS ING_CNT                                 \n");
	        sbSql.append("       ,(SELECT COUNT(*)                                \n"); 
            sbSql.append("          FROM (                                \n");
            sbSql.append("             SELECT B.UPJANG                                \n");
            sbSql.append("             FROM   SCC_USERINFO A,                                \n");
            sbSql.append("                    ST_UPJANG B                                \n");
            sbSql.append("             WHERE  B.UPJANG = A.UPJANG                                \n");
            sbSql.append("             AND    A.SABUN = '" + g_EmpNo           + "'                                \n");
            sbSql.append("             UNION                                \n");
            sbSql.append("             SELECT A.UPJANG                                \n");
            sbSql.append("             FROM   ST_UPJANG A,                                \n");
            sbSql.append("                    FMS_USER_UPJANG B                                \n");
            sbSql.append("             WHERE  B.UPJANG = A.UPJANG                                \n");
            sbSql.append("             AND    (B.USE_YN = 'Y' AND NVL(B.ATTR01, TO_CHAR(SYSDATE, 'YYYYMMDD')) <= TO_CHAR(SYSDATE, 'YYYYMMDD') AND NVL(B.ATTR02, TO_CHAR(SYSDATE, 'YYYYMMDD')) >= TO_CHAR(SYSDATE, 'YYYYMMDD'))                                \n");
            sbSql.append("             AND    B.SABUN = '" + g_EmpNo           + "')                                \n");
            sbSql.append("          WHERE    UPJANG = T1.UPJANG_CD) AS UPJANG_YN		                                    \n");
		    sbSql.append("  FROM FCUS.FSE_EVENT_MASTER T1                      \n");
		    sbSql.append(" WHERE EVNT_ID = '" + strEvntDate + "' || '" + strSclassCd + "' || '" + strSeq + "'\n");
			sbSql.append("   AND USE_YN = 'Y'                    \n");
			sbSql.append("   AND APPR_STATUS NOT IN ('40')                     \n"); 
		}
	    else if ( strChk.equals("SEARCHPOP") )
		{                     
			sbSql.append("SELECT EVNT_NO,                                   \n");
		    sbSql.append("       EVNT_ID,                                   \n");
		    sbSql.append("       UPJANG_CD,                                 \n");
		    sbSql.append("       SCC_UPJANGNM_FUN(UPJANG_CD) AS UPJANG_NM,                                 \n");
		    sbSql.append("       UTENSIL_ID,                                \n");
		    sbSql.append("       EVNT_DATE,                                 \n");
		    sbSql.append("       MGRP_CD,                                   \n");
		    sbSql.append("       MCLASS_CD,                                 \n");
		    sbSql.append("       SCLASS_CD,                                 \n");
		    sbSql.append("       SEQ,                                         \n");
		    sbSql.append("       QUANTITY,                                  \n");
		    sbSql.append("       REQUEST_NM,                             \n");
		    sbSql.append("       CNTC_NUM,                                  \n");
		    sbSql.append("       ZIP_CODE,                                  \n");
		    sbSql.append("       ADDR,                                      \n");
		    sbSql.append("       CNTC_NUM_ENC,                              \n");
		    sbSql.append("       ADDR_ENC,                                  \n");
		    sbSql.append("       BEFORE_IMGE AS ORG_IMGE,                               \n");
		    sbSql.append("       SVR_BEFORE_IMGE AS SVR_IMGE,                           \n");
			sbSql.append("      '' AS IMG_FILE, \n");
			sbSql.append("      '' AS ISUPLOAD, \n");
		    sbSql.append("       AFTER_IMGE AS IMPROV_ORG_IMGE,                                \n");
		    sbSql.append("       SVR_AFTER_IMGE AS IMPROV_SVR_IMGE,                            \n");
			sbSql.append("      '' AS IMPROV_IMG_FILE, \n");
			sbSql.append("      '' AS IMPROV_ISUPLOAD, \n");
		    sbSql.append("       CUST_SATISFAC,                             \n");
		    sbSql.append("       CUST_RESPONSE_EVAL,                        \n");
		    sbSql.append("       UTENSIL_STATUS,                            \n");
		    sbSql.append("       EVNT_TITLE,                                \n");
		    sbSql.append("       MEAL_QTY,                                  \n");
		    sbSql.append("       APPR_SABUN,                                \n");
		    sbSql.append("       APPR_STATUS,                               \n");
		    sbSql.append("       RTN_REASON_CODE,                           \n");
		    sbSql.append("       RTN_REASON,                                \n");
		    sbSql.append("       USE_YN                                     \n");
		    sbSql.append("       ,(SELECT COUNT(EVNT_ID) FROM FSE_EVENT_MASTER                                 \n");
		    sbSql.append("          WHERE SCLASS_CD = '" + strSclassCd + "'                                 \n");
		    sbSql.append("            AND SEQ = '" + strSeq + "'                                 \n");
		    sbSql.append("            AND APPR_STATUS <> '30') AS ING_CNT                                 \n");
		    sbSql.append("       ,(SELECT COUNT(*)                                \n");
            sbSql.append("          FROM (                                \n");
            sbSql.append("             SELECT B.UPJANG                                \n");
            sbSql.append("             FROM   SCC_USERINFO A,                                \n");
            sbSql.append("                    ST_UPJANG B                                \n");
            sbSql.append("             WHERE  B.UPJANG = A.UPJANG                                \n");
            sbSql.append("             AND    A.SABUN = '" + g_EmpNo           + "'                                \n");
            sbSql.append("             UNION                                \n");
            sbSql.append("             SELECT A.UPJANG                                \n");
            sbSql.append("             FROM   ST_UPJANG A,                                \n");
            sbSql.append("                    FMS_USER_UPJANG B                                \n");
            sbSql.append("             WHERE  B.UPJANG = A.UPJANG                                \n");
            sbSql.append("             AND    (B.USE_YN = 'Y' AND NVL(B.ATTR01, TO_CHAR(SYSDATE, 'YYYYMMDD')) <= TO_CHAR(SYSDATE, 'YYYYMMDD') AND NVL(B.ATTR02, TO_CHAR(SYSDATE, 'YYYYMMDD')) >= TO_CHAR(SYSDATE, 'YYYYMMDD'))                                \n");
            sbSql.append("             AND    B.SABUN = '" + g_EmpNo           + "')                                \n");
            sbSql.append("          WHERE    UPJANG = T1.UPJANG_CD) AS UPJANG_YN		                                    \n");
	    	sbSql.append("  FROM FCUS.FSE_EVENT_MASTER T1                      \n");
		    sbSql.append(" WHERE EVNT_ID = '" + strEvntDate + "' || '" + strSclassCd + "' || '" + strSeq + "'\n");
			sbSql.append("   AND EVNT_NO = '" + strEvntNo + "'                     \n"); 
		} else
		{  
			sbSql.append("SELECT UPJANG AS UPJANG_CD                                   \n");
		    sbSql.append("       ,UPJANGNM AS UPJANG_NM                                 \n");
		    sbSql.append("       ,(SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = V.CHARGE_SABUN) AS REQUEST_NM                                 \n");
		    sbSql.append("       ,SCC_CRYPTO.MASKAUTH_FUN(V.UPJANG_TEL_ENC,9,'YYYYNNNNNNNNNNN', '0') AS CNTC_NUM                                \n");
		    sbSql.append("       ,(SELECT BASE_ADDR1 FROM SCC_ADDR_INFOV WHERE ADDR_KEY = V.DELIVERY_ADDR_KEY ) AS ADDR                                 \n");
		    sbSql.append("       ,(SELECT COUNT(EVNT_ID) FROM FSE_EVENT_MASTER                                 \n");
		    sbSql.append("          WHERE SCLASS_CD = '" + strSclassCd + "'                                 \n");
		    sbSql.append("            AND SEQ = '" + strSeq + "'                                 \n");
		    sbSql.append("            AND APPR_STATUS <> '30') AS ING_CNT                                 \n");
		    sbSql.append("  FROM SCO_UPJANG_MST_V V                      \n");
		    sbSql.append(" WHERE UPJANG = '" + strUpjang + "' \n");
		}
	    	
	    
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_imgeList = this.makeDataSet(rs, "ds_imgeList"); 
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_imgeList); 
		this.setResultMessage(0, "OK", out_vl);                                                                                                                                                             
                                                                                                                                                                                                        
	}                                                                                                                                                                                                     
	catch(Exception ex)                                                                                                                                                                                   
	{                                                                                                                                                                                                     
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);                                                                                                                                                     
	}                                                                                                                                                                                                     
	finally                                                                                                                                                                                               
	{                                                                                                                                                                                                     
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