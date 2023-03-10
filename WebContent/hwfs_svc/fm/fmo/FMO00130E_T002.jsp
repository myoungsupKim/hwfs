<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/비용관리
■ 프로그램ID   : FMP00130E_T002.jsp
■ 프로그램명   : 비용내역등록(저장)
■ 작성일자     : 2008.02.26
■ 작성자       : 박은규
■ 이력관리     : 2008.02.26
				 2015.04.01 입력시 전도금 부족으로 오류발생건 처리.	
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
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);		
	
		//입력 데이타
		DataSet ds_iud      = in_dl.get("ds_IUD");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
	
		int sRowStatus;
		
		//FileLog.println("d:\\aaa.txt", ds_list);


		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//입력,수정
		for ( int i = 0 ; i < ds_iud.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			sRowStatus = ds_iud.getRowType(i);

			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{
				if (ds_iud.getString(i, "ADV_YN").equals("Y") )
				{
					//회수금액 추가 체크
					sbSql.delete(0, sbSql.length());
			        sbSql.append("SELECT SUM(ADV_AMT) - SUM(OCCUR_AMT) AS ADV_AMT   \n");
			        sbSql.append("  FROM (                                                      \n");
			        sbSql.append("        SELECT SUM(OCCUR_AMT) AS OCCUR_AMT, 0 AS ADV_AMT      \n");
			        sbSql.append("          FROM FMO_ACCT_OCCUR                                 \n");
			        sbSql.append("         WHERE UPJANG = " + ds_iud.getString(i, "UPJANG") + " \n");
			        sbSql.append("           AND OCCUR_DATE <= '" + ds_iud.getString(i, "OCCUR_DATE") + "' \n");
			        sbSql.append("           AND ADV_YN = 'Y'                                   \n");
			        sbSql.append("         UNION ALL                                            \n");
			        sbSql.append("        SELECT 0 AS OCCUR_AMT, SUM(DECODE(ADV_KIND,'회수',ADV_AMOUNT*-1,ADV_AMOUNT)) AS ADV_AMT     \n");
			        sbSql.append("          FROM FMO_ADVANCE                                    \n");
			        sbSql.append("         WHERE UPJANG = " + ds_iud.getString(i, "UPJANG") + " \n");
			        sbSql.append("           AND ADV_DATE <= '" + ds_iud.getString(i, "OCCUR_DATE") + "'   \n");
			        sbSql.append("       )                                                      \n");
			out_vl.add("fa_Sql", sbSql.toString());
					//System.out.println(sbSql.toString());
					pstmt = conn.prepareStatement(sbSql.toString());		
					rs = pstmt.executeQuery();					
					rs.next();
					
					String sAdvAmt = rs.getString("ADV_AMT");
					rs.close();
					
					if (Float.parseFloat(sAdvAmt) - Float.parseFloat(ds_iud.getString(i, "OCCUR_AMT")) < 0)
					{
						out_vl.add("fa_Msg", "전도금 잔액이 부족합니다.\n본사에서 전도금을 추가로 받으신 다음 등록하세요.");
					   	this.setResultMessage(1, "OK",out_vl);	
					   	proc_output(response,out,out_vl,out_dl);
					   	if (true) return;
					}					
				}
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FMO_ACCT_OCCUR( \n");
				sbSql.append("      OCCUR_ID \n");
				sbSql.append("    , OCCUR_DATE \n");
				sbSql.append("    , UPJANG \n");
				sbSql.append("    , ACCTCD \n");
				sbSql.append("    , OCCUR_AMT \n");
				sbSql.append("    , SUPPLIER \n");
				sbSql.append("    , CONTENTS \n");
				sbSql.append("    , ADV_YN \n");
				sbSql.append("    , CUSER \n");
				sbSql.append("    , CDATE \n");
				sbSql.append("    , UUSER \n");
				sbSql.append("    , UDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	FMO_ACCT_OCCUR_S.NEXTVAL \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "OCCUR_DATE")) + "' \n");
				sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "UPJANG")) + " \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ACCTCD")) + "' \n");
				sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "OCCUR_AMT")) + " \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "SUPPLIER")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "CONTENTS")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ADV_YN")) + "' \n");
				sbSql.append("	, '" + g_EmpNo + "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append("	, '" + g_EmpNo + "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");
			}
			else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				if (ds_iud.getString(i, "ADV_YN").equals("Y") )
				{
					//회수금액 추가 체크
					sbSql.delete(0, sbSql.length());
			        sbSql.append("SELECT SUM(ADV_AMT) AS ADV_AMT, SUM(OCCUR_AMT) AS OCCUR_AMT   \n");
			        sbSql.append("  FROM (                                                      \n");
			        sbSql.append("        SELECT SUM(OCCUR_AMT) AS OCCUR_AMT, 0 AS ADV_AMT      \n");
			        sbSql.append("          FROM FMO_ACCT_OCCUR                                 \n");
			        sbSql.append("         WHERE UPJANG = " + ds_iud.getString(i, "UPJANG") + " \n");
			        sbSql.append("           AND OCCUR_DATE <= '" + ds_iud.getString(i, "OCCUR_DATE") + "' \n");
			        sbSql.append("           AND ADV_YN = 'Y'                                   \n");
			        sbSql.append("         UNION ALL                                            \n");
			        sbSql.append("        SELECT 0 AS OCCUR_AMT, SUM(DECODE(ADV_KIND,'회수',ADV_AMOUNT*-1,ADV_AMOUNT)) AS ADV_AMT     \n");
			        sbSql.append("          FROM FMO_ADVANCE                                    \n");
			        sbSql.append("         WHERE UPJANG = " + ds_iud.getString(i, "UPJANG") + " \n");
			        sbSql.append("           AND ADV_DATE <= '" + ds_iud.getString(i, "OCCUR_DATE") + "'   \n");
			        sbSql.append("       )                                                      \n");
			out_vl.add("fa_Sql", sbSql.toString());
					//System.out.println(sbSql.toString());
					pstmt = conn.prepareStatement(sbSql.toString());		
					rs = pstmt.executeQuery();					
					rs.next();
					
					String sOccurAmt = rs.getString("OCCUR_AMT");
					String sAdvAmt = rs.getString("ADV_AMT");
					rs.close();
					
					if (ds_iud.getSavedData(i, "ADV_YN").toString().equals("N"))
					{	
						if (Float.parseFloat(sAdvAmt) - Float.parseFloat(sOccurAmt) - Float.parseFloat(ds_iud.getString(i, "OCCUR_AMT")) < 0)
						{
							out_vl.add("fa_Msg", "전도금 잔액이 부족합니다.\n본사에서 전도금을 추가로 받으신 다음 등록하세요.");
						   	this.setResultMessage(2, "OK",out_vl);	
						   	proc_output(response,out,out_vl,out_dl);
						   	if (true) return;					
						}
					}
					else
					{
						if (Float.parseFloat(sOccurAmt) - Float.parseFloat(ds_iud.getSavedData(i, "OCCUR_AMT").toString()) + Float.parseFloat(ds_iud.getString(i, "OCCUR_AMT")) > Float.parseFloat(sAdvAmt))
						{
							out_vl.add("fa_Msg", "전도금 잔액이 부족합니다.\n본사에서 전도금을 추가로 받으신 다음 등록하세요.");
						   	this.setResultMessage(2, "OK",out_vl);	
						   	proc_output(response,out,out_vl,out_dl);
						   	if (true) return;							
						}
						
					}
				}
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FMO_ACCT_OCCUR \n");
				sbSql.append("   SET OCCUR_DATE = '" + nullToBlank(ds_iud.getString(i, "OCCUR_DATE")) + "' \n");
				sbSql.append("     , ACCTCD = '" + nullToBlank(ds_iud.getString(i, "ACCTCD")) + "' \n");
				sbSql.append("     , OCCUR_AMT = " + nullToBlank(ds_iud.getString(i, "OCCUR_AMT")) + " \n");
				sbSql.append("     , SUPPLIER = '" + nullToBlank(ds_iud.getString(i, "SUPPLIER")) + "' \n");
				sbSql.append("     , CONTENTS = '" + nullToBlank(ds_iud.getString(i, "CONTENTS")) + "' \n");
				sbSql.append("     , ADV_YN = '" + nullToBlank(ds_iud.getString(i, "ADV_YN")) + "' \n");
				sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE OCCUR_ID = " + nullToBlank(ds_iud.getString(i, "OCCUR_ID")) + " \n");
			}
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			
			pstmt.close();
		}
		//삭제
		for ( int i = 0 ; i < ds_iud.getRemovedRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			sbSql.append("DELETE FROM FMO_ACCT_OCCUR \n");
			sbSql.append(" WHERE OCCUR_ID = " + ds_iud.getRemovedData(i, "OCCUR_ID").toString() + " \n");
			
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			
			pstmt.close();
		}

		/**종료**/
		conn.commit();
		out_vl.add("fa_Msg", "");
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
