<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/주간실적관리
■ 프로그램ID   : MAS40010E_T002.jsp
■ 프로그램명   : 월별손익계획삭제
■ 작성일자     : 2013-12-11
■ 작성자       : 김장욱
■ 이력관리     : 
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
		DataSet ds_list     = in_dl.get("ds_list");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//FileLog.println("d:\\aaa.txt", ds_List);

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//입력,수정
		for ( int iRow = 0 ; iRow < ds_list.getRowCount() ; iRow++ )
		{
			//저장
			sbSql.delete(0, sbSql.length());
			sbSql.append(" INSERT INTO MAS_TICKET_MST	\n"); 
			sbSql.append(" (				\n"); 
			sbSql.append(" ,TICKET_SEQ			\n"); 
			sbSql.append(" ,TICKET_GROUP_SEQ		\n"); 
			sbSql.append(" ,UPJANG		\n"); 
			sbSql.append(" ,ITEM_TYPE		\n"); 
			sbSql.append(" ,ITEM_CODE		\n"); 
			sbSql.append(" ,TRANS_DD		\n"); 
			sbSql.append(" ,TRANS_TYPE		\n"); 
			sbSql.append(" ,TRANS_GUBUN		\n"); 
			sbSql.append(" ,UPRICE		\n"); 
		    sbSql.append(" ,QTY		\n"); 
			sbSql.append(" ,REMARK_DESC		\n"); 
			sbSql.append(" ,AUTO_GUBUN		\n"); 
			sbSql.append(" ,TEAM_MST_CONGUBN		\n"); 
			sbSql.append(" ,APPROV_CONGUBN		\n"); 
			sbSql.append(" ,CUSER		\n"); 
			sbSql.append(" ,CDATE		\n"); 
			sbSql.append(" ,UUSER		\n"); 
			sbSql.append(" ,UDATE		\n"); 
			sbSql.append(" ,SUBST_ID		\n"); 
			sbSql.append(" ,SUBUL_YN		\n"); 
			sbSql.append(" ,CONGUBN		\n"); 
			sbSql.append(" ,RECEIPT_NUM		\n"); 
			sbSql.append(" ) VALUES (  		\n"); 
			sbSql.append(" , MAS_TICKET_MST_S.NEXTVAL		\n"); 
			sbSql.append(" , MAS_TICKET_MST_GROUP_S.NEXTVAL		\n"); 
			sbSql.append(" , #UPJANG#		\n"); 
			sbSql.append(" , #ITEM_TYPE#		\n"); 
			sbSql.append(" , #ITEM_CODE#		\n"); 
			sbSql.append(" , #TRANS_DD#		\n"); 
			sbSql.append(" , 'X'		\n"); 
			sbSql.append(" , 'XC'		\n"); 
			sbSql.append(" , #UPRICE#		\n"); 
			sbSql.append(" , #QTY#		\n"); 
			sbSql.append(" , '교환폐기'		\n"); 
			sbSql.append(" , 'N'		\n"); 
			sbSql.append(" , 'N'		\n"); 
			sbSql.append(" , 'N'		\n"); 
			sbSql.append(" , #CUSER#		\n"); 
			sbSql.append(" , SYSDATE		\n"); 
			sbSql.append(" , #UUSER#		\n"); 
			sbSql.append(" , SYSDATE		\n"); 
			sbSql.append(" , 'Y'		\n"); 
			sbSql.append(" , 'Y'		\n"); 
			sbSql.append(" , #CONGUBN#		\n"); 
			sbSql.append(" , 'E_'||#SYSCLASS#||'_'||#TRANS_DD#||'_'||#UPJANG#||'_'||#RECEIPT_NUM#		\n"); 
			sbSql.append(")	;	\n"); 

			
			sbSql.append("       INSERT INTO MAS_TICKET_MST 				\n"); 
			sbSql.append("                ( 		\n"); 
			sbSql.append("                    TICKET_SEQ		\n"); 
			sbSql.append("                  ,TICKET_GROUP_SEQ		\n"); 
			sbSql.append("                  ,UPJANG		\n"); 
			sbSql.append("                  ,ITEM_TYPE		\n"); 
			sbSql.append("                  ,ITEM_CODE		\n"); 
			sbSql.append("                  ,TRANS_DD		\n"); 
			sbSql.append("                  ,TRANS_TYPE		\n"); 
			sbSql.append("                  ,TRANS_GUBUN		\n"); 
			sbSql.append("                  ,UPRICE		\n"); 
			sbSql.append("                  ,QTY		\n"); 
			sbSql.append("                  ,TICKET_STARTNUM		\n"); 
			sbSql.append("                  ,TICKET_ENDNUM		\n"); 
			sbSql.append("                  ,REMARK_DESC		\n"); 
			sbSql.append("                  ,AUTO_GUBUN		\n"); 
			sbSql.append("                  ,SOURCE_ID		\n"); 
			sbSql.append("                  ,TEAM_MST_CONGUBN		\n"); 
			sbSql.append("                  ,APPROV_CONGUBN		\n"); 
			sbSql.append("                  ,CUSER		\n"); 
			sbSql.append("                  ,CDATE		\n"); 
			sbSql.append("                  ,UUSER		\n"); 
			sbSql.append("                  ,UDATE		\n"); 
			sbSql.append("                  ,SUBST_ID		\n"); 
			sbSql.append("                  ,SUBUL_YN		\n"); 
			sbSql.append("                  ,CONGUBN		\n"); 
			sbSql.append("                  ,RECEIPT_NUM		\n"); 
			sbSql.append("                ) VALUES (  		\n"); 
			sbSql.append("                MAS_TICKET_MST_S.NEXTVAL		\n"); 
			sbSql.append("              , MAS_TICKET_MST_GROUP_S.NEXTVAL		\n"); 
			sbSql.append("              , #UPJANG#		\n"); 
			sbSql.append("              , #ITEM_TYPE#		\n"); 
			sbSql.append("              , #ITEM_CODE#		\n"); 
			sbSql.append("              , #TRANS_DD#		\n"); 
			sbSql.append("              , 'O'		\n"); 
			sbSql.append("              , 'OO'		\n"); 
			sbSql.append("              , #UPRICE#		\n"); 
			sbSql.append("              , #QTY#0		\n"); 
			sbSql.append("              , #TICKET_STARTNUM#		\n"); 
			sbSql.append("              , #TICKET_ENDNUM#		\n"); 
			sbSql.append("              , '교환'		\n"); 
			sbSql.append("              , 'N'		\n"); 
			sbSql.append("              , #SOURCE_ID#		\n"); 
			sbSql.append("              , 'N'		\n"); 
			sbSql.append("              , 'N'		\n"); 
			sbSql.append("              , #CUSER#		\n"); 
			sbSql.append("              , SYSDATE		\n"); 
			sbSql.append("              , #UUSER#		\n"); 
			sbSql.append("              , SYSDATE		\n"); 
			sbSql.append("              , 'Y'		\n"); 
			sbSql.append("              , 'Y'		\n"); 
			sbSql.append("              , #CONGUBN#		\n"); 
			sbSql.append("              , 'E_'||#SYSCLASS#||'_'||#TRANS_DD#||'_'||#UPJANG#||'_'||#RECEIPT_NUM#		\n"); 
			sbSql.append("              )		\n"); 
			out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
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