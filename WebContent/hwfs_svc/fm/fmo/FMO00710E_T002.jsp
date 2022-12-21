<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FMO00710E_T002.jsp
■ 프로그램명   : 근태관리
■ 작성일자     : 2012-08-21
■ 작성자       : 박용대
■ 이력관리     : 2012-08-21 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//리퀘스트 객체
	PlatformRequest platformRequest = this.proc_input(request);

	in_vl = platformRequest.getData().getVariableList();	//파라미터 받는 객체
	in_dl = platformRequest.getData().getDataSetList();	//데이터셋 받는 객체
	
	//입력 데이타셋
	DataSet ds_list   = in_dl.get("inds_List");

	//입력 파라미터
	String g_EmpNo    = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		int sRowStatus;
		String checkFlag	= "";

		//입력,수정
		for ( int i = 0 ; i < ds_list.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			sRowStatus = ds_list.getRowType(i);
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{
				sbSql.delete(0, sbSql.length());
				
		        sbSql.append("INSERT INTO FMO_KUNTAE(                                   \n");
		        sbSql.append("    SABUN,                                                \n");
		        sbSql.append("    DL_DATE,                                              \n");
		        sbSql.append("    UPJANG,                                               \n");
		        sbSql.append("    DL_GB,                                                \n");
		        sbSql.append("    WORK_REP,                                             \n");
		        sbSql.append("    WORK_TMA,                                             \n");
		        sbSql.append("    WORK_TMB,                                             \n");
		        sbSql.append("    WORK_TMC,                                             \n");
		        sbSql.append("    OTHH,                                                 \n");
		        sbSql.append("    NIGHT_OTHH,                                           \n");
		        sbSql.append("    HOLI,                                                 \n");
		        sbSql.append("    CUSER,                                                \n");
		        sbSql.append("    CDATE,                                                \n");
		        sbSql.append("    UUSER,                                                \n");
		        sbSql.append("    UDATE                                                 \n");
		        sbSql.append(")VALUES(                                                  \n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"SABUN"))+"',      \n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DL_DATE"))+"',    \n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"UPJANG"))+"',     \n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DL_GB"))+"',      \n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"WORK_REP"))+"',   \n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"WORK_TMA"))+"',   \n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"WORK_TMB"))+"',   \n");
		        sbSql.append("    '"+nullToZero(ds_list.getString(i,"WORK_TMC"))+"',    \n");
		        sbSql.append("    '"+nullToZero(ds_list.getString(i,"OTHH"))+"',        \n");
		        sbSql.append("    '"+nullToZero(ds_list.getString(i,"NIGHT_OTHH"))+"',  \n");
		        sbSql.append("    '"+nullToZero(ds_list.getString(i,"HOLI"))+"',        \n");
		        sbSql.append("    '"+g_EmpNo+"',                                        \n");
		        sbSql.append("    SYSDATE,                                              \n");
		        sbSql.append("    '"+g_EmpNo+"',                                        \n");
		        sbSql.append("    SYSDATE                                               \n");
		        sbSql.append(")                                                         \n");
			
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.delete(0, sbSql.length());
				
		        sbSql.append("UPDATE FMO_KUNTAE                                                         \n");
		        sbSql.append("   SET DL_GB      = '"+nullToBlank(ds_list.getString(i,"DL_GB"))+"',      \n");
		        sbSql.append("       WORK_REP   = '"+nullToBlank(ds_list.getString(i,"WORK_REP"))+"',   \n");
		        sbSql.append("       WORK_TMA   = '"+nullToBlank(ds_list.getString(i,"WORK_TMA"))+"',   \n");
		        sbSql.append("       WORK_TMB   = '"+nullToBlank(ds_list.getString(i,"WORK_TMB"))+"',   \n");
		        sbSql.append("       WORK_TMC   = '"+nullToBlank(ds_list.getString(i,"WORK_TMC"))+"',   \n");
		        sbSql.append("       OTHH       = '"+nullToBlank(ds_list.getString(i,"OTHH"))+"',       \n");
		        sbSql.append("       NIGHT_OTHH = '"+nullToBlank(ds_list.getString(i,"NIGHT_OTHH"))+"', \n");
		        sbSql.append("       HOLI       = '"+nullToBlank(ds_list.getString(i,"HOLI"))+"',       \n");
		        sbSql.append("       UUSER      = '"+g_EmpNo+"',                                        \n");
		        sbSql.append("       UDATE      = SYSDATE                                               \n");
		        sbSql.append(" WHERE 1 = 1                                                              \n");
		        sbSql.append("   AND SABUN      = '"+nullToBlank(ds_list.getString(i,"SABUN"))+"'       \n");
		        sbSql.append("   AND DL_DATE    = '"+nullToBlank(ds_list.getString(i,"DL_DATE"))+"'     \n");

		        pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}
		}

		//삭제
		for ( int i = 0 ; i < ds_list.getRemovedRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

	        sbSql.append("DELETE FROM FMO_KUNTAE                                     \n");
	        sbSql.append(" WHERE SABUN   = '"+ds_list.getRemovedData(i,"SABUN")+"'   \n");
	        sbSql.append("   AND DL_DATE = '"+ds_list.getRemovedData(i,"DL_DATE")+"' \n");
			
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
		ex.printStackTrace();
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
	}

	proc_output(response,out,out_vl,out_dl);

%>
