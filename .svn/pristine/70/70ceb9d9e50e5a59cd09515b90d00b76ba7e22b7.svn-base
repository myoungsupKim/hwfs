<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/기준정보
■ 프로그램ID   : FMS00200E_T002.jsp
■ 프로그램명   : D-day제외일 저장
■ 작성일자     : 2008.03.04
■ 작성자       : 박은규
■ 이력관리     : 2008.03.04
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
		DataSet ds_List      = in_dl.get("ds_List");
		DataSet ds_ListUpj   = in_dl.get("ds_ListUpj");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));


		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
System.out.println("시작");
		//공통기준일 경우...
		if (ds_ListUpj.getRowCount() == 0)
		{
			//기존자료 삭제
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("DELETE FROM FMS_EXC_DAYS \n");
			sbSql.append(" WHERE UPJANG = -1 \n");
			sbSql.append("   AND EXC_DATE BETWEEN SUBSTR('" + nullToBlank(ds_List.getString(0, "EXC_DATE")) + "',1,6)||'01' \n");
			sbSql.append("                    AND SUBSTR('" + nullToBlank(ds_List.getString(0, "EXC_DATE")) + "',1,6)||'31' \n");
			
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();

			//입력
			for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
			{
				sbSql.delete(0, sbSql.length());

				sbSql.append("INSERT INTO FMS_EXC_DAYS( \n");
				sbSql.append("       UPJANG \n");
				sbSql.append("     , EXC_DATE \n");
				sbSql.append("     , CONTENTS \n");
				sbSql.append("     , USE_YN \n");
				sbSql.append("     , CUSER \n");
				sbSql.append("     , CDATE \n");
				sbSql.append("     , UUSER \n");
				sbSql.append("     , UDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	  -1 \n");
				sbSql.append("	, '" + nullToBlank(ds_List.getString(i, "EXC_DATE")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_List.getString(i, "CONTENTS")) + "' \n");
				sbSql.append("	, SCC_YN_FUN('" + nullToBlank(ds_List.getString(i, "USE_YN")) + "','I') \n");
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
			}
			//conn.commit();
			//오라클 커서초과 에러나서....닫아준다.
			//pstmt.close();
			//pstmt = null;
		}

		//업장별 등록
		String sChk;
		//업장별 기존자료 삭제
		String Sql = "DELETE FROM FMS_EXC_DAYS WHERE UPJANG = ?" +
		             "   AND EXC_DATE BETWEEN SUBSTR(?,1,6)||'01' AND SUBSTR(?,1,6)||'31'";
		pstmt = conn.prepareStatement(Sql);
		for ( int iRow = 0 ; iRow < ds_ListUpj.getRowCount() ; iRow++ )
		{
System.out.println(iRow);
			sChk = nullToBlank(ds_ListUpj.getString(iRow, "CHK"));
			if (sChk.equals("0")) continue;

			pstmt.setString(1, nullToBlank(ds_ListUpj.getString(iRow, "UPJANG")));
			pstmt.setString(2, nullToBlank(ds_List.getString(0, "EXC_DATE")));
			pstmt.setString(3, nullToBlank(ds_List.getString(0, "EXC_DATE")));
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		pstmt.executeBatch(); //배치처리
		pstmt.close();

		//업장별 등록
		Sql = "INSERT INTO FMS_EXC_DAYS(UPJANG, EXC_DATE, CONTENTS, USE_YN, CUSER, CDATE, UUSER, UDATE)" +
              "VALUES (?,?,?,SCC_YN_FUN(?,'I'),?,SYSDATE,?,SYSDATE)";
		pstmt = conn.prepareStatement(Sql);
		for ( int iRow = 0 ; iRow < ds_ListUpj.getRowCount() ; iRow++ )
		{
			sChk = nullToBlank(ds_ListUpj.getString(iRow, "CHK"));
			if (sChk.equals("0")) continue;

			for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
			{
				//입력
				pstmt.setString(1, nullToBlank(ds_ListUpj.getString(iRow, "UPJANG")));
				pstmt.setString(2, nullToBlank(ds_List.getString(i, "EXC_DATE")));
				pstmt.setString(3, nullToBlank(ds_List.getString(i, "CONTENTS")));
				pstmt.setString(4, nullToBlank(ds_List.getString(i, "USE_YN")));
				pstmt.setString(5, g_EmpNo);
				pstmt.setString(6, g_EmpNo);
				//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
				pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
			}
			//conn.commit();
			//오라클 커서초과 에러나서....닫아준다.
			//pstmt.close();
			//pstmt = null;
		}
		pstmt.executeBatch(); //배치처리
		pstmt.close();

		/**종료**/
		conn.commit();
System.out.println("완료");
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