<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리
■ 프로그램ID   : FMU00280E_T002.jsp
■ 프로그램명   : 업장별 운영율 등록관리(저장)
■ 작성일자     : 2008.04.14
■ 작성자       : 박은규
■ 이력관리     : 2008.04.14
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
		String g_EmpNo    = nullToBlank(in_vl.getString("g_EmpNo"));

		//변수생성
		String strUpjang  = ds_Cond.getString(0, "UPJANG");

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//삭제자료부터 처리
		for ( int iRow = 0 ; iRow < ds_List.getRemovedRowCount() ; iRow++ )
		{
			//현 운영율 이전 운영율의 종료일을 이후 운영율 시작일-1로 세팅
			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE FMU_OP_RATE A \n");
			sbSql.append("  SET A.EDATE = NVL((SELECT /*+ INDEX_ASC(Z FMU_OP_RATE_PK) */ \n");
			sbSql.append("                             TO_CHAR(TO_DATE(Z.SDATE,'YYYYMMDD')-1,'YYYYMMDD') \n");
			sbSql.append("                        FROM FMU_OP_RATE Z \n");
			sbSql.append("                       WHERE Z.UPJANG = " + strUpjang + " \n");
			sbSql.append("                         AND Z.SDATE > '" + ds_List.getRemovedData(iRow, "SDATE").toString() + "' \n");
			sbSql.append("                         AND ROWNUM <= 1), '20291231') \n");
			sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND A.SDATE = (SELECT /*+ INDEX_DESC(Z FMU_OP_RATE_PK) */ \n");
			sbSql.append("                         Z.SDATE \n");
			sbSql.append("                    FROM FMU_OP_RATE Z \n");
			sbSql.append("                   WHERE Z.UPJANG = " + strUpjang + " \n");
			sbSql.append("                     AND Z.SDATE < '" + ds_List.getRemovedData(iRow, "SDATE").toString() + "' \n");
			sbSql.append("                     AND ROWNUM <= 1) \n");
			sbSql.append("   AND A.SDATE <> '00000000' \n");
out_vl.add("fa_Sql", sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();

			//현 운영율 삭제Sql
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FMU_OP_RATE A \n");
			sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND A.SDATE  = '" + ds_List.getRemovedData(iRow, "SDATE").toString() + "' \n");
out_vl.add("fa_Sql", sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}

		int RowStatus;	
		//입력/수정자료 처리
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			RowStatus = ds_List.getRowType(iRow);
			//수정인 경우 초기화...
			if (RowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("DELETE FROM FMU_OP_RATE A \n");
				sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
				sbSql.append("   AND A.SDATE  = '" + ds_List.getString(iRow, "SDATE") + "' \n");
out_vl.add("fa_Sql", sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}

			//입력처리Sql
			sbSql.delete(0, sbSql.length());
			sbSql.append("INSERT INTO FMU_OP_RATE \n");
			sbSql.append("( UPJANG \n");
			sbSql.append(", SDATE \n");
			sbSql.append(", EDATE \n");
			sbSql.append(", ITEM_CODE \n");
			sbSql.append(", OP_RATE \n");
			sbSql.append(", CEIL_VAL \n");
			sbSql.append(", CUSER \n");
			sbSql.append(", CDATE \n");
			sbSql.append(", UUSER \n");
			sbSql.append(", UDATE \n");
			sbSql.append(") \n");
			sbSql.append("SELECT " + strUpjang + " AS UPJANG \n");
			sbSql.append("     , '" + ds_List.getString(iRow, "SDATE") + "' AS SDATE \n");
			//현 운영율 이후 일자의 운영율 조회(종료일 세팅)
			sbSql.append("     , NVL((SELECT /*+ INDEX_ASC(Z FMU_OP_RATE_PK) */ \n");
			sbSql.append("                   TO_CHAR(TO_DATE(Z.SDATE,'YYYYMMDD')-1,'YYYYMMDD') \n");
			sbSql.append("              FROM FMU_OP_RATE Z \n");
			sbSql.append("             WHERE Z.UPJANG = " + strUpjang + " \n");
			sbSql.append("               AND Z.SDATE > '" + ds_List.getString(iRow, "SDATE") + "' \n");
			sbSql.append("               AND ROWNUM <= 1), '20291231') AS EDATE \n");
			sbSql.append("     , A.CLASS_CODE AS ITEM_CODE \n");
			sbSql.append("     , " + ds_List.getString(iRow, "OP_RATE") + " AS OP_RATE \n");
			sbSql.append("     , 1 AS CEIL_VAL \n");
			sbSql.append("     , '" + g_EmpNo + "' AS CUSER \n");
			sbSql.append("     , SYSDATE AS CDATE \n");
			sbSql.append("     , '" + g_EmpNo + "' AS UUSER \n");
			sbSql.append("     , SYSDATE AS UDATE \n");
			sbSql.append("  FROM HLDC_PO_ITEM_CLASS A \n");
			sbSql.append(" WHERE A.CLASS_TYPE = 'D' \n");
			sbSql.append("   AND (A.CLASS_CODE < '0130' OR A.CLASS_CODE LIKE '0190%') \n");
			sbSql.append("   AND A.USE_YN = 'Y' \n");
out_vl.add("fa_Sql", sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		
			//현 운영율 이전 운영율의 종료일을 현 운영율 시작일-1로 세팅
			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE FMU_OP_RATE A \n");
			sbSql.append("   SET A.EDATE = TO_CHAR(TO_DATE('" + ds_List.getString(iRow, "SDATE") + "','YYYYMMDD')-1,'YYYYMMDD') \n");
			sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND A.SDATE = (SELECT /*+ INDEX_DESC(Z FMU_OP_RATE_PK) */ \n");
			sbSql.append("                         Z.SDATE \n");
			sbSql.append("                    FROM FMU_OP_RATE Z \n");
			sbSql.append("                   WHERE Z.UPJANG = " + strUpjang + " \n");
			sbSql.append("                     AND Z.SDATE < '" + ds_List.getString(iRow, "SDATE") + "' \n");
			sbSql.append("                     AND ROWNUM <= 1) \n");
			sbSql.append("   AND A.SDATE <> '00000000' \n");
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