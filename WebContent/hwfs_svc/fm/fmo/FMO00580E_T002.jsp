<%/*-----------------------------------------------------------------------------■ 시스템명     : 식재영업/보조금관리■ 프로그램ID   : FMO00580E_T002.jsp■ 프로그램명   : 친환경 보조금 입력■ 작성일자     : 2010.07.09■ 작성자       : 박은규■ 이력관리     : Ex) 2008.01.21               2009-03-13 박은규 CSR#(25270) 요청자:김진희(식재사업팀)               주문수량이 0인 것은 식단정보에 발주로 처리-----------------------------------------------------------------------------*/%><%@ page contentType="text/html; charset=EUC-KR" %><%@ include file = "../../sc/main/common.jsp" %><%	try	{		PlatformRequest platformRequest = this.proc_input(request);		in_vl = platformRequest.getData().getVariableList();		in_dl = platformRequest.getData().getDataSetList();		//jsp log 서비스 시작 		logger.startIndividualLog(in_vl.getString("titLogId"));					//입력 데이타		DataSet ds_Cond      = in_dl.get("ds_Cond");		DataSet ds_List      = in_dl.get("ds_List");		//입력 파라메터		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));					//sql문 버퍼생성		StringBuffer sbSql = new StringBuffer();				//nullToBlank(ds_Cond.getString(i, "USE_YN"))						for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )		{			            if ( nullToBlank(ds_List.getString(i, "USE_YN")).equals("1"))          	            {	            					sbSql.delete(0, sbSql.length());				        sbSql.append("SELECT 1                                                                                  													\n");			        sbSql.append("  FROM FMS_GREEN_SUB                                                                      													\n");			        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_List.getString(i, "UPJANG")) + "'                                                                 \n");			        sbSql.append("   AND (('" + nullToBlank(ds_List.getString(i, "SUB_START")) + "' BETWEEN SUB_START +1 AND SUB_END) 									\n");			        sbSql.append("	       OR ('" + nullToBlank(ds_List.getString(i, "SUB_END")) + "' BETWEEN SUB_START AND SUB_END -1) 								\n");			        sbSql.append("         OR (SUB_START > '" + nullToBlank(ds_Cond.getString(i, "SUB_START")) + "' )) 													\n");	out_vl.add("fa_Sql", sbSql.toString());					pstmt = conn.prepareStatement(sbSql.toString()); //미리 담아놓는 곳이라네					rs = pstmt.executeQuery(); //쿼리실행한다					if (rs.next()) throw new Exception(i + "보조금 설정 정보가 기존에 있습니다.");										sbSql.delete(0, sbSql.length());					sbSql.append("MERGE INTO FMS_GREEN_SUB A                                                                                                              															    \n");			        sbSql.append("USING (SELECT '" + nullToBlank(ds_List.getString(i, "UPJANG")) + "' AS UPJANG                                                                                                                 \n");			        sbSql.append("            , '" + nullToBlank(ds_List.getString(0, "SUB_START")) + "' AS SUB_START                                                                                                           \n");				    sbSql.append("            , '" + nullToBlank(ds_List.getString(0, "SUB_END")) + "' AS SUB_END                                                                                                               \n");			        sbSql.append("         FROM DUAL) B                                                                                                                   																\n");			        sbSql.append("   ON ((A.UPJANG = B.UPJANG) AND (A.SUB_START = B.SUB_START) AND (A.SUB_END = B.SUB_END))                                                     														\n");			        sbSql.append(" WHEN MATCHED THEN                                                                                                                      																\n");			        sbSql.append("      UPDATE SET A.SUB_RATE = '" + nullToBlank(ds_List.getString(i, "SUB_RATE")) + "'                                                                                                         \n");			        sbSql.append("               , A.SUB_AMOUNT = '" + nullToBlank(ds_List.getString(i, "SUB_AMOUNT")) + "'                                                                                                     \n");			        sbSql.append("               , A.UPDATE_DATE = SYSDATE                                                                                                																\n");			        sbSql.append("               , A.UPDATE_BY   = '" + g_EmpNo + "'                                                                                                       												\n");			        sbSql.append(" WHEN NOT MATCHED THEN                                                                                                                  																\n");			        sbSql.append("      INSERT (A.UPJANG, A.SUB_START, A.SUB_END, A.SUB_RATE, A.SUB_AMOUNT, A.USE_YN, A.CREATE_DATE, A.CREATE_BY, A.UPDATE_DATE, A.UPDATE_BY) 															\n");			        sbSql.append("      VALUES ('" + nullToBlank(ds_List.getString(i, "UPJANG")) + "'                                                                                                                           \n");			        sbSql.append("             ,'" + nullToBlank(ds_List.getString(0, "SUB_START")) + "'                                                                                                                        \n");			        sbSql.append("             ,'" + nullToBlank(ds_List.getString(0, "SUB_END")) + "'                                                                                                                          \n");			        sbSql.append("             ,'" + nullToBlank(ds_List.getString(i, "SUB_RATE")) + "'                                                                                                                         \n");			        sbSql.append("             ,'" + nullToBlank(ds_List.getString(i, "SUB_AMOUNT")) + "'                                                                                                                       \n");			        sbSql.append("             , DECODE ('" + nullToBlank(ds_List.getString(i, "USE_YN")) + "' , 1, 'Y', 'N')                                                                                                   \n");			        sbSql.append("             , SYSDATE                                                                                                                                                                                \n");			        sbSql.append("             ,'" + g_EmpNo + "'                                                                                                                                                                       \n");			        sbSql.append("             ,SYSDATE                                                                                                                                                                                 \n");			        sbSql.append("             , '" + g_EmpNo + "' )                                                                                                                                                                    \n");	out_vl.add("fa_Sql", sbSql.toString());					rs.close();					pstmt.close();					System.out.println(sbSql.toString());					pstmt = conn.prepareStatement(sbSql.toString());					pstmt.executeUpdate();					pstmt.close();            }            		}		conn.commit();	   	this.setResultMessage(0, "OK",out_vl); 		}	catch(Exception ex)	{		conn.rollback();		//ex.printStackTrace();		//jsp 로그남기기		logger.debug(ex.getMessage(), ex);				this.setResultMessage(-1, ex.toString(),out_vl);	}	finally	{		if(rs != null) {			try {				rs.close();			}catch(Exception e) {}		}		if(pstmt != null) {			try {				pstmt.close();			}catch(Exception e) {}		}		if(conn != null) {			try {				conn.close();			}catch(Exception e) {}		}		//jsp log 서비스 닫기 		try {			logger.endIndividualLog();		} catch( Exception logE) {			logE.printStackTrace();		}			}	proc_output(response,out,out_vl,out_dl);%>