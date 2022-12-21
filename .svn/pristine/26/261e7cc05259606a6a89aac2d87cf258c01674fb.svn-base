<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/기준정보/공급업체관리
■ 프로그램ID   : FMS00240E_T001.jsp
■ 프로그램명   : 단가사업장 공급업체 예외설정(조회)
■ 작성일자     : 2013-01-28
■ 작성자       : 박은규
■ 이력관리     : 2013-01-28
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();		
	
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		//DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String strType     = nullToBlank(in_vl.getString("strType"));
		String strUpjang   = nullToBlank(in_vl.getString("strUpjang"));
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		if (strType.equals("UpjQry"))
		{
			sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP \n");
			sbSql.append("  FROM FMS_UPJANG A \n");
			sbSql.append(" WHERE A.MAIN_UPJANG = " + strUpjang + " \n");
			//단가계약업장별로 사용불가 공급업체에 등록은 일단 초기화 후 'N'인 것만 등록되므로 본사는 대상에서 빼야한다.
			//안그러면 본사에 등록된 공급업체 다 초기화되어 없어짐
			sbSql.append("   AND A.MAIN_UPJANG <> A.UPJANG \n");
			sbSql.append("   AND A.OTCUST_PRICE_UPJANG = A.UPJANG \n");
			sbSql.append("   AND A.USE_YN = 'Y' \n");
			sbSql.append(" ORDER BY A.UPJANG \n");
		}
		else
		{
			sbSql.append("SELECT A.OTCUSTCD, A.OTCUSTNM \n");
			//sbSql.append("     , SCC_YN_FUN(NVL(C.USE_YN,B.USE_YN),'S') AS USE_YN \n");
			sbSql.append("     -- 단가계약업장별로 사용불가 공급업체에 등록되지 않은 것은 디폴트 사용설정  \n");
			sbSql.append("     , SCC_YN_FUN(NVL(C.USE_YN,'Y'),'S') AS USE_YN \n");
			sbSql.append("  FROM FMP_OTHER_CUST A \n");
			sbSql.append("     -- 본사별로 사용가능 공급업체 조회 \n");
			sbSql.append("     ,(SELECT A.OTCUSTCD, A.USE_YN \n");
			sbSql.append("         FROM FMP_OTCUST_LINK A \n");
			sbSql.append("        WHERE A.UPJANG = (SELECT Z.MAIN_UPJANG FROM FMS_UPJANG Z WHERE Z.UPJANG = " + strUpjang + ") \n");
			sbSql.append("          AND A.USE_YN = 'Y' \n");
			sbSql.append("      ) B \n");
			sbSql.append("     -- 단가계약업장별로 사용불가 공급업체 조회 \n");
			sbSql.append("     ,(SELECT A.OTCUSTCD, A.USE_YN \n");
			sbSql.append("         FROM FMP_OTCUST_LINK A \n");
			sbSql.append("        WHERE A.UPJANG = " + strUpjang + " \n");
			sbSql.append("          AND A.USE_YN = 'N' \n");
			sbSql.append("      ) C \n");
			sbSql.append(" WHERE A.OTCUSTCD = B.OTCUSTCD \n");
			sbSql.append("   AND B.OTCUSTCD = C.OTCUSTCD(+) \n");
			sbSql.append("   -- 당연히 한화호텔앤드리조트는 예외 대상이 아니다. \n");
			sbSql.append("   AND A.OTCUSTCD <> '0000' \n");
		}

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//로그남기기
		logger.debug(sbSql.toString());
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
