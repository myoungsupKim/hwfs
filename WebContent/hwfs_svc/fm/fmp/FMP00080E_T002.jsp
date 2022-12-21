<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00080E_T002.jsp
■ 프로그램명   : 상품발주 주간발주/즐겨찾기 상품 등록
■ 작성일자     : 2008.01.21
■ 작성자       : 박은규
■ 이력관리     : 2008.01.21
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
		//DataSet ds_iud      = in_dl.get("ds_IUD");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sFavGroup    = nullToBlank(in_vl.getString("sFavGroup"));
		String sItemCode    = nullToBlank(in_vl.getString("sItemCode"));
		String sGB          = nullToBlank(in_vl.getString("sGB"));


		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//기존 등록코드 여부
		sbSql.delete(0, sbSql.length());

		sbSql.append("SELECT 1 FROM CHK \n");
		if (sGB.equals("0"))
			sbSql.append("  FROM FMP_FAVORITE \n");
		else
			sbSql.append("  FROM FMP_WEEKLY_ITEM \n");
		sbSql.append(" WHERE UPJANG = " + sUpjang + " \n");
		sbSql.append("   AND ITEM_CODE = '" + sItemCode + "' \n");
		if (sGB.equals("0"))
			sbSql.append("   AND FAVOR_GROUP = '" + sFavGroup + "' \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		if(rs.next())
		{
			out_vl.add("fa_Chk", "이미 등록된 상품입니다!");
			this.setResultMessage(0, "OK", out_vl);
			proc_output(response,out,out_vl,out_dl);
			if (true) return;
		}
		rs.close();
		pstmt.close();

		//입력
		sbSql.delete(0, sbSql.length());

		if (sGB.equals("0"))
			sbSql.append("INSERT INTO FMP_FAVORITE \n");
		else
			sbSql.append("INSERT INTO FMP_WEEKLY_ITEM \n");
		sbSql.append("      UPJANG \n");
		if (sGB.equals("0"))
			sbSql.append("    , FAVOR_GROUP \n");
		sbSql.append("    , ITEM_CODE \n");
		sbSql.append("    , CREATE_BY \n");
		sbSql.append("    , CREATE_DATE \n");
		sbSql.append("    , UPDATE_BY \n");
		sbSql.append("    , UPDATE_DATE \n");
		sbSql.append(" ) VALUES ( \n");
		sbSql.append("	" + sUpjang + " \n");
		if (sGB.equals("0"))
			sbSql.append("	, '" + sFavGroup + "' \n");
		sbSql.append("	, '" + sItemCode + "' \n");
		sbSql.append("	, '" + g_EmpNo + "' \n");
		sbSql.append("	, SYSDATE \n");
		sbSql.append("	, '" + g_EmpNo + "' \n");
		sbSql.append("	, SYSDATE \n");
		sbSql.append(" ) \n");
					
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();

		/**종료**/
		conn.commit();
		//out_vl.add("fa_Chk", "등록되었습니다.");
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
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