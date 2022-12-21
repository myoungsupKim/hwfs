<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/매출등록
■ 프로그램ID   : MAS10080E_T001.jsp
■ 프로그램명   : 매출복사
■ 작성일자     : 2012.11.05
■ 작성자       : 박은규
■ 이력관리     : 2012.11.05
1)박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
최초 작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//입력 데이타
		//DataSet ds_List   = in_dl.get("ds_List");
		//입력 파라메터
		String g_Upjang      = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo       = nullToBlank(in_vl.getString("g_EmpNo"));
		String strUpjang     = nullToBlank(in_vl.getString("strUpjang"));
		String strTrxDate    = nullToBlank(in_vl.getString("strTrxDate"));
		String strTrxDateFrm = nullToBlank(in_vl.getString("strTrxDateFrm"));
		String strTrxTypes   = nullToBlank(in_vl.getString("strTrxTypes"));

		conn.setAutoCommit(false);

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//기 등록여부
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT 1 FROM MAS_TRX \n");
        sbSql.append(" WHERE UPJANG = " + strUpjang + " \n");
        sbSql.append("   AND TRX_DATE = '" + strTrxDate + "' \n");
        sbSql.append("   AND TRX_TYPE IN (" + strTrxTypes + ") \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		if (rs.next())
		{
			this.setResultMessage(-1, "해당 일자에 이미 매출이 등록되어있습니다!", out_vl);
			proc_output(response,out,out_vl,out_dl);
			return;
		}
		
		//복사작업
		sbSql.delete(0, sbSql.length());
		sbSql.append("INSERT INTO MAS_TRX \n");
		sbSql.append("( TRX_ID \n");
		sbSql.append(", UPJANG \n");
		sbSql.append(", SUBINV_CODE \n");
		sbSql.append(", TRX_DATE \n");
		sbSql.append(", TRX_TYPE \n");
		sbSql.append(", CUSTCD \n");
		sbSql.append(", TAX_KIND \n");
		sbSql.append(", PRICE \n");
		sbSql.append(", QTY \n");
		sbSql.append(", AMT \n");
		sbSql.append(", TRX_DESC \n");
		sbSql.append(", DR_ACCTCD \n");
		sbSql.append(", CR_ACCTCD \n");
		sbSql.append(", PARENT_ID \n");
		sbSql.append(", ADITEM1 \n");
		sbSql.append(", ADITEM2 \n");
		sbSql.append(", ADITEM3 \n");
		sbSql.append(", ADITEM4 \n");
		sbSql.append(", ADITEM5 \n");
		sbSql.append(", ADITEM6 \n");
		sbSql.append(", ADITEM7 \n");
		sbSql.append(", ADITEM8 \n");
		sbSql.append(", ATTR04 \n");
		sbSql.append(", ATTR05 \n");
		sbSql.append(", CUSER \n");
		sbSql.append(", CDATE \n");
		sbSql.append(") \n");
		sbSql.append("SELECT MAS_TRX_S.NEXTVAL AS TRX_ID \n");
		sbSql.append("     , UPJANG \n");
		sbSql.append("     , SUBINV_CODE \n");
		sbSql.append("     , '" + strTrxDate + "' AS TRX_DATE \n");
		sbSql.append("     , TRX_TYPE \n");
		sbSql.append("     , CUSTCD \n");
		sbSql.append("     , TAX_KIND \n");
		sbSql.append("     , PRICE \n");
		sbSql.append("     , QTY \n");
		sbSql.append("     , AMT \n");
		sbSql.append("     , TRX_DESC \n");
		sbSql.append("     , DR_ACCTCD \n");
		sbSql.append("     , CR_ACCTCD \n");
		//sbSql.append("     , PARENT_ID \n");
		//고객사 대체로 생성된 것은 그냥 하나의 정상 매출로 등록
		sbSql.append("     , NULL AS PARENT_ID \n");
		sbSql.append("     , ADITEM1 \n");
		sbSql.append("     , ADITEM2 \n");
		sbSql.append("     , ADITEM3 \n");
		sbSql.append("     , ADITEM4 \n");
		sbSql.append("     , ADITEM5 \n");
		sbSql.append("     , ADITEM6 \n");
		sbSql.append("     , ADITEM7 \n");
		sbSql.append("     , ADITEM8 \n");
		sbSql.append("     , '매출복사' AS ATTR04 \n");
		sbSql.append("     , TO_CHAR(TRX_ID) AS ATTR05 \n");
		sbSql.append("     , '" + g_EmpNo + "' AS CUSER \n");
		sbSql.append("     , SYSDATE AS CDATE \n");
		sbSql.append("  FROM MAS_TRX \n");
		sbSql.append(" WHERE UPJANG = " + strUpjang + " \n");
		sbSql.append("   AND TRX_DATE = '" + strTrxDateFrm + "' \n");
		sbSql.append("   AND TRX_TYPE IN (" + strTrxTypes + ") \n");
		//고객사 대체로 생성된 것은 제외
		//sbSql.append("   AND PARENT_ID IS NULL \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();

		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
		ex.printStackTrace();
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
	}

	proc_output(response,out,out_vl,out_dl);

%>