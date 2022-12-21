<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00241P_T001.jsp
■ 프로그램명   : 운영율 등록관리/분류별 운영률(조회)
■ 작성일자     : 2008.08.04
■ 작성자       : 박은규
■ 이력관리     : [고도화]_자재코드 관련 수정_김경은
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
		String sClassType  = nullToBlank(in_vl.getString("sClassType"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.CLASS_CODE \n");
		sbSql.append("     , SUBSTR(A.CLASS_CODE,DECODE('" + sClassType + "','M',2,'S',4,'D',6),2)||' '||A.CLASS_NAME AS CLASS_NAME \n");
		sbSql.append("     , B.OP_RATE \n");
		sbSql.append("  FROM HLDC_PO_ITEM_CLASS_HLDC_V A \n");
		sbSql.append("     ,(SELECT A.ITEM_CODE, A.OP_RATE \n");
		sbSql.append("         FROM FMU_OP_RATE A \n");
		sbSql.append("        WHERE A.UPJANG = " + sUpjang + " \n");
		//sbSql.append("          AND A.SDATE = '00000000' \n");
		//SDATE='00000000' 조건으로 되어있어 내역이 안나오는 업장이 많아서 가장 최근 일자 내역이 나오도록 변경 요청자 김진희 20170608
        sbSql.append("          AND (A.ITEM_CODE,A.SDATE  ) IN (  SELECT  ITEM_CODE,MAX(SDATE) \n");
        sbSql.append("                         FROM FMU_OP_RATE A  \n");
        sbSql.append("                         WHERE  upjang = " + sUpjang + "  \n");
        //sbSql.append("                         AND  ATTR01 = 'P'  \n");
        sbSql.append("                         AND  NVL(ATTR01, 'NONE') =   \n");
        sbSql.append("								CASE WHEN (SELECT COUNT(1) FROM FMU_OP_RATE WHERE UPJANG = " + sUpjang + " AND ATTR01 = 'P') = 0 THEN 'NONE'	\n");
        sbSql.append("								ELSE 'P'	\n");
        sbSql.append("								END	\n");
        sbSql.append("                        GROUP BY ITEM_CODE )  \n");
		sbSql.append("      ) B \n");
		sbSql.append(" WHERE A.CLASS_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.CLASS_CODE LIKE 'F%' \n");
		sbSql.append("   AND A.CLASS_TYPE = '" + sClassType + "' \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append("   AND SUBSTR(A.CLASS_CODE, 1, 3) <> 'F28' \n"); // 2015.07.20 김진희매니저요청사항 28 식자재(도매유통) 제외처리
		sbSql.append("   AND SUBSTR(A.CLASS_CODE, 1, 3) <> 'F30' \n"); // 2018.03.12 김진희매니저요청사항 28 식자재(도매유통) 제외처리
		sbSql.append("   AND SUBSTR(A.CLASS_CODE, 1, 3) <> 'F70' \n"); // 2016.12.27 최윤하 요청사항 70 반제품 제외처리
		sbSql.append(" ORDER BY A.CLASS_CODE \n");

		out_vl.add("fa_Sql", sbSql.toString());
		
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

<%--
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
		String sClassType  = nullToBlank(in_vl.getString("sClassType"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.CLASS_CODE \n");
		sbSql.append("     , SUBSTR(A.CLASS_CODE,DECODE('" + sClassType + "','M',3,'S',5,'D',7),2)||' '||A.CLASS_NAME AS CLASS_NAME \n");
		sbSql.append("     , B.OP_RATE \n");
		sbSql.append("  FROM HLDC_PO_ITEM_CLASS_HLDC_V A \n");
		sbSql.append("     ,(SELECT A.ITEM_CODE, A.OP_RATE \n");
		sbSql.append("         FROM FMU_OP_RATE A \n");
		sbSql.append("        WHERE A.UPJANG = " + sUpjang + " \n");
//		if (sClassType.equals("D"))
//			sbSql.append("          AND A.SDATE = '" + sSdate + "' \n");
//		else
			sbSql.append("          AND A.SDATE = '00000000' \n");
		sbSql.append("      ) B \n");
		sbSql.append(" WHERE A.CLASS_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999' \n");
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

--%>
