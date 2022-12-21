<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 운영관리
■ 프로그램ID   : FSV00310V_T001.jsp
■ 프로그램명   : 전자세금계산서담당자관리
■ 작성일자     : 2010-05-20
■ 작성자       : 문형광
■ 이력관리     : 2010-05-20 - 최초작성 문형광 CSR#(00000)
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		
		//입력 파라메터		
		String strCustCD 	 = nullToBlank(ds_Cond.getString(0, "CUSTCD"));
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//IRIS DB연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
        sbSql.append("SELECT A.SEQ                      		  					\n");
        sbSql.append("     , A.CMP_ID                   		  					\n");
        sbSql.append("     , A.CMP_NAME                   		  					\n");
        sbSql.append("     , A.MEM_NAME                   		  					\n");
        sbSql.append("     , SC_CRYPTO_FUN('DEC',A.MEM_TEL_NO_ENC ,4) AS MEM_TEL_NO	\n");
        sbSql.append("     , SC_CRYPTO_FUN('DEC',A.MEM_CP_NO_ENC ,4) AS MEM_CP_NO	\n");
        sbSql.append("     , SC_CRYPTO_FUN('DEC',A.MEM_EMAIL_ENC ,5) AS MEM_EMAIL 	\n");
        sbSql.append("     , A.MEM_DEPT                   							\n");
        sbSql.append("     , C.CRAT_USER AS SABUN          							\n");
        sbSql.append("     , B.NAME                       							\n");
        sbSql.append("     , SC_CRYPTO_FUN('DEC',B.TEL_NO_ENC ,4) AS TEL_NO   		\n");
        sbSql.append("     , SC_CRYPTO_FUN('DEC',B.HP_NO_ENC ,4) AS HP_NO          	\n");
        sbSql.append("     , SC_CRYPTO_FUN('DEC',B.EMAIL_ENC ,5) AS EMAIL   		\n");
        sbSql.append("  FROM IF_CMP_MEM_INFO A            							\n");
        sbSql.append("     , PO_SABUN_INFO B              							\n");
        sbSql.append("     , (SELECT MAX(Z.SEQ) AS SEQ    							\n");
        sbSql.append("             , Z.CMP_ID             							\n");
        sbSql.append("             , Z.CRAT_USER             						\n");
        sbSql.append("          FROM IF_CMP_MEM_INFO Z, ST_CUST Y 					\n");
        sbSql.append("         WHERE Z.CMP_ID = Y.SAUPNO  							\n");
        sbSql.append("           AND Y.CUSTCD = " + strCustCD + "          			\n");
        sbSql.append("         GROUP BY Z.CMP_ID, Z.CRAT_USER) C 					\n");
        sbSql.append(" WHERE A.CRAT_USER = B.SABUN        							\n");
        sbSql.append("   AND A.CMP_ID = C.CMP_ID          							\n");
        sbSql.append("   AND A.SEQ = C.SEQ                							\n");
        sbSql.append("   AND A.CRAT_USER = C.CRAT_USER     							\n");
      
        out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_List);
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
