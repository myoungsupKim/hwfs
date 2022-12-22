<%

/*-----------------------------------------------------------------------------

■ 시스템명     : 협력업체/물류계산서 조회

■ 프로그램ID   : FSV00260V_S001.jsp

■ 프로그램명   : 물류계산서 조회

■ 작성일자     : 2008-07-25

■ 작성자       : 박은규

■ 이력관리     : 1) 문형광 2010-02-25 CSR#(34676) 요청자: 최희정사원
               물류계산서 발행사업부정보추가

-----------------------------------------------------------------------------*/

%>

<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
				
			String FROM 		= nullToBlank(in_vl.getString("FROM"));		
			String TO 		= nullToBlank(in_vl.getString("TO"));		
			String g_CustCd		= nullToBlank(in_vl.getString("g_CustCd"));
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT TO_CHAR(TO_DATE(A.SUPDATE,'YYYYMMDD'),'YYYY-MM-DD') AS BILL_DATE   	\n");
//============================================================================================
//2010/02/25 문형광 - 발행사업부정보추가 - 최희정 요청 CSR#(34676) - 시작
//============================================================================================		
		sbSql.append("     , A.TAXNO AS BILL_NO                                                 	\n");

		sbSql.append("     , B.MU_NM 												             	\n");
		
		sbSql.append("     , C.CENTER_NAME  										             	\n");		
		sbSql.append("     , NVL(A.EXE_AMT,0) AS AMT                                            	\n");
		sbSql.append("     , NVL(FLOOR(A.EXE_AMT/10),0) AS VAT                                  	\n");
		sbSql.append("     , NVL(A.EXE_AMT,0)+NVL(FLOOR(A.EXE_AMT/10),0) AS TOTAL               	\n");
		sbSql.append("     , A.SEQ_ID AS BILL_ID                                                	\n");
		sbSql.append("     , NVL(A.ATTR1,'N') ATTR1 -- 출력여부 필드 추가                                 				\n");
		
		sbSql.append("     , A.AUTO_BILL_YN  -- 전자세금계산서 여부 추가                                   				\n");
		//sbSql.append("  FROM PO_CENTERCOST_SALE A, SC_MU B                                         	\n");
		sbSql.append("  FROM PO_CENTERCOST_SALE A, SC_MU B, PO_CENTER C                         	\n");
//============================================================================================
//2010/02/25 문형광 - 발행사업부정보추가 - 최희정 요청 CSR#(34676) - 종료
//============================================================================================		
		sbSql.append(" WHERE A.GAMU = B.MU_CD                               						\n");

		sbSql.append("   AND A.CENTER_GUBUN = C.CENTER_CODE                                 		\n");
		sbSql.append("   AND A.SUPDATE BETWEEN '"+FROM+"' AND '"+TO+"'                        		\n");
		sbSql.append("   AND A.CUSTCD = '"+g_CustCd+"'   --[g_CustCd]								\n");
		sbSql.append("   AND A.TAX_STATUS IN ('C','R')                                            	\n");
		sbSql.append("   AND A.GANO   > 0                                                       	\n");
		sbSql.append(" ORDER BY A.SUPDATE, A.TAXNO                                              	\n");		
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);

	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		   ex.printStackTrace();
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
		}
		
	  proc_output(response,out,out_vl,out_dl);

%>