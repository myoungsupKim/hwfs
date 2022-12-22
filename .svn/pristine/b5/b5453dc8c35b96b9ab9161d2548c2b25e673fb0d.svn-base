<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/매출통계
■ 프로그램ID   : MAO00020E_T002.jsp
■ 프로그램명   : 매출계획 등록관리(저장)
■ 작성일자     : 2012-03-09
■ 작성자       : 박은규
■ 이력관리     : 2012-03-09 박은규 - 최초개발 (CH201203_00081)
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
		DataSet ds_Cond   = in_dl.get("ds_Cond");
		DataSet ds_List   = in_dl.get("ds_List");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//삭제
		for ( int iRow = 0 ; iRow < ds_List.getRemovedRowCount() ; iRow++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FMB_SALE_PLAN \n");
			sbSql.append(" WHERE PK_ID = " + ds_List.getRemovedData(iRow, "PK_ID").toString() + " \n");	
			out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}

		//입력,수정
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			sbSql.delete(0, sbSql.length());
			if (ds_List.getRowType(iRow) == DataSet.ROW_TYPE_INSERTED)
			{
				/** 신규일경우 삭제후 등록.		**/
				
				sbSql.append(" DELETE FMB_SALE_PLAN \n");
				sbSql.append(" WHERE YYYYMM = '" + nullToBlank(ds_Cond.getString(0, "YYYY")) + nullToBlank(ds_Cond.getString(0, "MM")) + "' \n");
				sbSql.append(" AND TEAM_CODE = '" + ds_List.getString(iRow, "TEAM_CODE").toString() + "' \n");
				sbSql.append(" AND MAIN_UPJANG = '" + ds_List.getString(iRow, "MAIN_UPJANG").toString() + "' \n");
				//2018.03.26 김명섭 파트코드 조회 개선
				//sbSql.append(" AND PART_CODE = '" + ds_List.getString(iRow, "PART_CODE").toString() + "' \n");
				if (!nullToBlank(ds_List.getString(iRow, "PART_CODE")).equals("")){
					sbSql.append(" AND PART_CODE = '" + ds_List.getString(iRow, "PART_CODE").toString() + "' \n");
				}else if (!nullToBlank(ds_List.getString(iRow, "UPJANG")).equals("")){
					sbSql.append(" AND PART_CODE = (SELECT DISTINCT PART_CODE FROM FMS_UPJANG WHERE MAIN_UPJANG = '" + ds_List.getString(iRow, "MAIN_UPJANG").toString() + "' AND UPJANG = '" + ds_List.getString(iRow, "UPJANG").toString() + "') \n");
				}else {
					sbSql.append(" AND PART_CODE = (SELECT DISTINCT PART_CODE FROM FMS_UPJANG WHERE MAIN_UPJANG = '" + ds_List.getString(iRow, "MAIN_UPJANG").toString() + "') \n");
				}
				sbSql.append(" AND SABUN = '" + ds_List.getString(iRow, "SABUN").toString() + "' \n");
				if(! nullToBlank(ds_List.getString(iRow, "UPJANG")).equals(""))
					sbSql.append(" AND UPJANG = '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "' \n");
				
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}
			/**종료**/
			conn.commit();
			this.setResultMessage(0, "OK", out_vl);
		}
		
		//입력,수정
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			sbSql.delete(0, sbSql.length());
			//
			if (ds_List.getRowType(iRow) == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (ds_List.getRowType(iRow) == DataSet.ROW_TYPE_INSERTED)
			{
				sbSql.append("INSERT INTO FMB_SALE_PLAN \n");
				sbSql.append("( PK_ID \n");
				sbSql.append(", YYYYMMDD \n");
				sbSql.append(", YYYYMM	 \n");
				sbSql.append(", TEAM_CODE \n");
				sbSql.append(", PART_CODE \n");
				sbSql.append(", SABUN \n");
				sbSql.append(", UPJANG \n");
				sbSql.append(", MAIN_UPJANG \n");
				sbSql.append(", ITEM_CODE \n");
				sbSql.append(", SALE_AMOUNT \n");
				sbSql.append(", MARGIN_AMOUNT \n");
				sbSql.append(", MARGIN_RATE \n");
				sbSql.append(", CONTENTS \n");
				sbSql.append(", CUSER \n");
				sbSql.append(", CDATE \n");
				sbSql.append(", UUSER \n");
				sbSql.append(", UDATE \n");
				sbSql.append(") VALUES \n");
				sbSql.append("( FMB_SALE_PLAN_S.NEXTVAL \n");
				sbSql.append(", '" + nullToBlank(ds_Cond.getString(0, "YYYY")) + nullToBlank(ds_Cond.getString(0, "MM")) + nullToBlank(ds_List.getString(iRow, "DD")) + "' \n");
				sbSql.append(", '" + nullToBlank(ds_Cond.getString(0, "YYYY")) + nullToBlank(ds_Cond.getString(0, "MM")) + "' \n");
				sbSql.append(", '" + nullToBlank(ds_List.getString(iRow, "TEAM_CODE")) + "' \n");
				//2018.03.26 김명섭 파트코드 조회 개선
				//sbSql.append(", '" + nullToBlank(ds_List.getString(iRow, "PART_CODE")) + "' \n");
				if (!nullToBlank(ds_List.getString(iRow, "PART_CODE")).equals("")){
					sbSql.append(", '" + nullToBlank(ds_List.getString(iRow, "PART_CODE")) + "' \n");
				}else if (!nullToBlank(ds_List.getString(iRow, "UPJANG")).equals("")){
					sbSql.append(", (SELECT DISTINCT PART_CODE FROM FMS_UPJANG WHERE MAIN_UPJANG = '" + ds_List.getString(iRow, "MAIN_UPJANG").toString() + "' AND UPJANG = '" + ds_List.getString(iRow, "UPJANG").toString() + "') \n");
				}else {
					sbSql.append(", (SELECT DISTINCT PART_CODE FROM FMS_UPJANG WHERE MAIN_UPJANG = '" + ds_List.getString(iRow, "MAIN_UPJANG").toString() + "') \n");
				}
				sbSql.append(", '" + nullToBlank(ds_List.getString(iRow, "SABUN")) + "' \n");
				sbSql.append(", '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "' \n");
				sbSql.append(", '" + nullToBlank(ds_List.getString(iRow, "MAIN_UPJANG")) + "' \n");
				sbSql.append(", '" + nullToBlank(ds_List.getString(iRow, "ITEM_CODE")) + "' \n");
				sbSql.append(", " + nullToZero(ds_List.getString(iRow, "SALE_AMOUNT")) + " \n");
				sbSql.append(", " + nullToZero(ds_List.getString(iRow, "MARGIN_AMOUNT")) + " \n");
				sbSql.append(", DECODE(" + nullToZero(ds_List.getString(iRow, "SALE_AMOUNT")) + ", 0, 0, ROUND(100*" + nullToZero(ds_List.getString(iRow, "MARGIN_AMOUNT")) + "/" + nullToZero(ds_List.getString(iRow, "SALE_AMOUNT")) + ", 2)) \n");
				sbSql.append(", '" + nullToBlank(ds_List.getString(iRow, "CONTENTS")) + "' \n");
				sbSql.append(", '" + g_EmpNo + "' \n");
				sbSql.append(", SYSDATE \n");
				sbSql.append(", '" + g_EmpNo + "' \n");
				sbSql.append(", SYSDATE \n");
				sbSql.append(") \n");
			}
			else if (ds_List.getRowType(iRow) == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.append("UPDATE FMB_SALE_PLAN A \n");
				sbSql.append("   SET A.YYYYMMDD = '" + nullToBlank(ds_Cond.getString(0, "YYYY")) + nullToBlank(ds_Cond.getString(0, "MM")) + nullToBlank(ds_List.getString(iRow, "DD")) + "' \n");
				sbSql.append("     , A.TEAM_CODE = '" + nullToBlank(ds_List.getString(iRow, "TEAM_CODE")) + "' \n");
				//2018.03.26 김명섭 파트코드 조회 개선
				//sbSql.append("     , A.PART_CODE = '" + nullToBlank(ds_List.getString(iRow, "PART_CODE")) + "' \n");
				sbSql.append("     , A.PART_CODE = NVL('" + nullToBlank(ds_List.getString(iRow, "PART_CODE")) + "',(SELECT DISTINCT PART_CODE FROM FMS_UPJANG WHERE MAIN_UPJANG = '" + ds_List.getString(iRow, "MAIN_UPJANG").toString() + "')) \n");
				sbSql.append("     , A.SABUN = '" + nullToBlank(ds_List.getString(iRow, "SABUN")) + "' \n");
				sbSql.append("     , A.MAIN_UPJANG = '" + nullToBlank(ds_List.getString(iRow, "MAIN_UPJANG")) + "' \n");
				sbSql.append("     , A.UPJANG = '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "' \n");
				sbSql.append("     , A.SALE_AMOUNT = " + nullToZero(ds_List.getString(iRow, "SALE_AMOUNT")) + " \n");
				sbSql.append("     , A.MARGIN_AMOUNT = " + nullToZero(ds_List.getString(iRow, "MARGIN_AMOUNT")) + " \n");
				sbSql.append("     , A.MARGIN_RATE = DECODE(" + nullToZero(ds_List.getString(iRow, "SALE_AMOUNT")) + ", 0, 0, ROUND(100*" + nullToZero(ds_List.getString(iRow, "MARGIN_AMOUNT")) + "/" + nullToZero(ds_List.getString(iRow, "SALE_AMOUNT")) + ", 2)) \n");
				sbSql.append("     , A.CONTENTS = '" + nullToBlank(ds_List.getString(iRow, "CONTENTS")) + "' \n");
				sbSql.append("     , A.UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , A.UDATE = SYSDATE \n");
				sbSql.append(" WHERE A.PK_ID = " + nullToBlank(ds_List.getString(iRow, "PK_ID")) + " \n");
			}
	
			out_vl.add("fa_Sql", sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}

		/**종료**/
		conn.commit();
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