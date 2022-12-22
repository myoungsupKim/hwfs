<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00242P_T001.jsp
■ 프로그램명   : 운영율 등록관리/분류별 운영률(조회)
■ 작성일자     : 2008.08.04
■ 작성자       : 박은규
■ 이력관리     : 2008.08.04
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
		//입력 파라메터
		String g_Upjang    = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo     = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang     = nullToBlank(in_vl.getString("sUpjang"));
		String sSdate      = nullToBlank(in_vl.getString("sSdate"));
		String sEdate      = nullToBlank(in_vl.getString("sEdate"));
		String sClassType  = nullToBlank(in_vl.getString("sClassType"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.CLASS_CODE \n");
		sbSql.append("     , SUBSTR(A.CLASS_CODE,DECODE('" + sClassType + "','M',3,'S',5,'D',7),2)||' '||A.CLASS_NAME AS CLASS_NAME \n");
		sbSql.append("     , B.RATE, B.RATE2 \n");
		sbSql.append("     , NVL(C.INCNT1,0) AS INCNT1, NVL(C.INCNT2,0) AS INCNT2 \n");
		sbSql.append("  FROM HLDC_PO_ITEM_CLASS_HLDC_V A \n");
		sbSql.append("     ,(SELECT X.CLASS_CODE, X.OP_RATE1 AS RATE, X.OP_RATE2 AS RATE2 \n");
		sbSql.append("         FROM FMU_CLASS_OP_RATE X \n");
		sbSql.append("        WHERE X.UPJANG = " + sUpjang + " \n");
		sbSql.append("          AND (X.SDATE, X.EDATE) IN (SELECT MAX(SDATE), MAX(EDATE) \n");
		sbSql.append("                                       FROM FMU_CLASS_OP_RATE \n");
		sbSql.append("                                      WHERE UPJANG = " + sUpjang + " \n");
		sbSql.append("                                        AND SDATE <= '" + sSdate + "' \n");
		sbSql.append("                                        AND EDATE <= '" + sEdate + "')\n");
		sbSql.append("      ) B \n");
		sbSql.append("     ,(SELECT SUBSTR(X.CLASS_CODE,1,DECODE('" + sClassType + "','M',4,'S',6,'D',8)) AS CLASS_CODE \n");
		sbSql.append("            , SUM(DECODE(X.OP_RATE1,NULL,0,1)) AS INCNT1 \n");
		sbSql.append("            , SUM(DECODE(X.OP_RATE2,NULL,0,1)) AS INCNT2 \n");
		sbSql.append("         FROM FMU_CLASS_OP_RATE X \n");
		sbSql.append("        WHERE X.UPJANG = " + sUpjang + " \n");
		sbSql.append("          AND (X.SDATE, X.EDATE) IN (SELECT MAX(SDATE), MAX(EDATE) \n");
		sbSql.append("                                       FROM FMU_CLASS_OP_RATE \n");
		sbSql.append("                                      WHERE UPJANG = " + sUpjang + " \n");
		sbSql.append("                                        AND SDATE <= '" + sSdate + "' \n");
		sbSql.append("                                        AND EDATE <= '" + sEdate + "')\n");
		sbSql.append("          AND SUBSTR(X.CLASS_CODE,7) <> '00' \n");
		sbSql.append("          AND (X.OP_RATE1 >= 0 OR X.OP_RATE2 >= 0) \n");
		sbSql.append("        GROUP BY SUBSTR(X.CLASS_CODE,1,DECODE('" + sClassType + "','M',4,'S',6,'D',8))) C \n");
		sbSql.append(" WHERE A.CLASS_CODE = B.CLASS_CODE(+) \n");
		sbSql.append("   AND SUBSTR(A.CLASS_CODE,1,DECODE('" + sClassType + "','M',4,'S',6,'D',8)) = C.CLASS_CODE(+) \n");
		sbSql.append("   AND A.CLASS_CODE LIKE '01%' \n");
		sbSql.append("   AND A.CLASS_TYPE = '" + sClassType + "' \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY A.CLASS_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close(); 
		pstmt.close();		

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
