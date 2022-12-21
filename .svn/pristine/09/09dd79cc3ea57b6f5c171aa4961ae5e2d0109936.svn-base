<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS시스템/IFIS/마케팅관리/식재사업 입금안내장
■ 프로그램ID   : MAK10220S_T002.jsp
■ 프로그램명   : 식재사업 입금안내장 출력
■ 작성일자     : 2009.05.13
■ 작성자       : 황승한
■ 이력관리     : 1)식재사업 입금안내장/최고서 관련 체크 및 본사기준조회추가 - 2009.05.15 #CSR 27104 황승한
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
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		String str_Print_Gubun  = nullToBlank(ds_Cond.getString(0, "PRINT_GUBUN"));

		String strDate;
		strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));
			
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List_MainUpjang;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//본사업장목록을 IN조건으로 만든다.
		String sUpjangList = ""; 
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT UPJANG FROM HLDC_ST_UPJANG \n");
		sbSql.append(" WHERE CUSTCD  = " + nullToBlank(ds_Cond.getString(0, "CUSTCD")) + " \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		while (rs.next())
		{
			sUpjangList += ", " + rs.getString("UPJANG");
		}
		if (sUpjangList.equals(""))
			sUpjangList = "(NULL)";
		else
			sUpjangList = "(" + sUpjangList.substring(1) + ")";
		rs.close();
		pstmt.close();
		


		//본사통합 업장내역조회(속도관계상 운영율은 적용하지 않는다.)
		sbSql.delete(0,sbSql.length());
		sbSql.append("/* MAK10220S_T002.jsp */ \n");   
    sbSql.append("    SELECT   UPJANG \n");
    sbSql.append("           , (SELECT UPJANGNM_DISP FROM FMS_UPJANG WHERE UPJANG = V.MAIN_UPJANG) MAIN_UPJANGNM \n");
    sbSql.append("           , V.UPJANGNM_DISP \n");
    sbSql.append("           , (SELECT B.SAUPNO FROM HLDC_ST_UPJANG A, HLDC_ST_CUST B WHERE A.CUSTCD = B.CUSTCD AND A.UPJANG = V.UPJANG) SAUPNO \n");
    sbSql.append("           , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = V.PART_SALES_SABUN) PART_SALES_SABUNNM \n");
    sbSql.append("           , DECODE('" + str_Print_Gubun + "', '입금장',  (CASE WHEN V.UPJANG IN " + sUpjangList + " THEN 'O' ELSE 'X' END), \n");
    sbSql.append("                                                          DECODE((SELECT COUNT(*) FROM MAK_BOND_REQ_B WHERE UPJANG = V.UPJANG AND  REQ_DATE = '" + strDate + "'), 0, 'X', 'O')) PRINT_GUBUN \n");
    sbSql.append("      FROM FMS_UPJANG V \n");
    sbSql.append("      WHERE (V.MAIN_UPJANG IN ( \n");
    sbSql.append("                                SELECT MAIN_UPJANG \n");
    sbSql.append("                                  FROM FMS_UPJANG \n");
    sbSql.append("                                  WHERE UPJANG IN " + sUpjangList + " \n");
    sbSql.append("                                GROUP BY MAIN_UPJANG \n");
    sbSql.append("                            )) \n");
    sbSql.append("      ORDER BY V.MAIN_UPJANG, DECODE(V.UPJANG, V.MAIN_UPJANG, 'A', 'B') \n");

		
		
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List_MainUpjang = this.makeDataSet(rs, "ds_List_MainUpjang");
		rs.close();
		pstmt.close();
		


		/**종료**/

		out_dl.add(ds_List_MainUpjang);
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