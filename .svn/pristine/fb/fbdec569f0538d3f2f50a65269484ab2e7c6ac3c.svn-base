<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/구매관리/상품정보관리
■ 프로그램ID   : FMP00863P_T001.jsp
■ 프로그램명   : 즐겨찾기 사업장 별 일괄 복사(저장)
■ 작성일자     : 2010-04-05
■ 작성자       : 노규완
■ 이력관리     : 2010-04-05 - 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
	
		//입력 데이타
		DataSet ds_MultiUpj = in_dl.get("ds_MultiUpjang");
		DataSet ds_List   = in_dl.get("ds_con");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
//		String sMainUpjang  = nullToBlank(in_vl.getString("sMainUpjang"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sItem_Code  = nullToBlank(in_vl.getString("sItem_Code"));
		String sGubun  = nullToBlank(in_vl.getString("sGubun"));
		
		 

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String sSql, sSql2, sChk;
	
		
		if (sGubun.equals("1")) //일괄 추가
		{
			//**************************************************************************
			//  1. 선택 상품 일괄 추가 
			//**************************************************************************
			
			sSql = "INSERT INTO FMP_FAVORITE(UPJANG, FAVOR_GROUP, ITEM_CODE, USE_YN, CUSER, CDATE )" +
	        "VALUES (?,?,?,?,?,SYSDATE)";
			for ( int iUpj = 0; iUpj < ds_MultiUpj.getRowCount(); iUpj++ )
			{
				sChk = nullToBlank(ds_MultiUpj.getString(iUpj, "CHK"));
				if (sChk.equals("0")) continue;
				
				sUpjang = nullToBlank(ds_MultiUpj.getString(iUpj, "UPJANG"));
				//기존자료 삭제(즐겨찾기 그룹 먼저 삭제)
				sbSql.delete(0, sbSql.length());
				sbSql.append("DELETE FROM FMP_FAVORITE \n");			
				sbSql.append(" WHERE UPJANG = " + sUpjang + " \n");
				sbSql.append("   AND SUBSTR(FAVOR_GROUP,8,2) = '01' \n");
				sbSql.append("   AND ITEM_CODE = '" + sItem_Code + "' \n");			
	out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();

				//입력
				pstmt = conn.prepareStatement(sSql);
				//for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
				//{
					pstmt.setString(1, sUpjang);          //업장
					pstmt.setString(2, sUpjang.substring(0,6)+"001");    //즐겨찾기 그룹코드
					pstmt.setString(3, sItem_Code);      //즐겨찾기 그룹명				
					pstmt.setString(4, "Y");              //사용유무
					pstmt.setString(5, g_EmpNo);          //등록자				

					//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
					pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
				//}
				pstmt.executeBatch(); //배치처리
				pstmt.close();
			}			
				
		}	
		else  //일괄 삭제
		{
			//**************************************************************************
			//  2. 선택 상품 일괄 삭제 
			//**************************************************************************		
			for ( int iUpj = 0; iUpj < ds_MultiUpj.getRowCount(); iUpj++ )
			{
				sChk = nullToBlank(ds_MultiUpj.getString(iUpj, "CHK"));
				if (sChk.equals("0")) continue;
				
				sUpjang = nullToBlank(ds_MultiUpj.getString(iUpj, "UPJANG"));
				//기존자료 삭제(즐겨찾기 그룹 먼저 삭제)
				sbSql.delete(0, sbSql.length());
				sbSql.append("DELETE FROM FMP_FAVORITE \n");			
				sbSql.append(" WHERE UPJANG = " + sUpjang + " \n");
//				sbSql.append("   AND SUBSTR(FAVOR_GROUP,8,2) = '01' \n");
				sbSql.append("   AND ITEM_CODE = '" + sItem_Code + "' \n");			
	out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}			
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