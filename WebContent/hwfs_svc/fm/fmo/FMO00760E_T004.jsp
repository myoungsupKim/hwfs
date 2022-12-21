<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/노무관리
■ 프로그램ID   : FMO00760E_T003.jsp
■ 프로그램명   : 직원급여 저장
■ 작성일자     : 2012.09.10
■ 작성자       : 박용대
■ 이력관리     : 
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
	DataSet ds_Cond    = in_dl.get("ds_Cond");
	DataSet ds_Mlist   = in_dl.get("inds_List");
	DataSet ds_Dlist   = in_dl.get("ds_ListDetail");
	String g_EmpNo     = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	//테스트 출력
	System.out.println("======================");
	//ds_Mlist.printDataSet();
	System.out.println("======================");
	//ds_Dlist.printDataSet();
	System.out.println("======================");
	
	try
	{
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		int sRowStatus;
		String checkFlag	= "";
	
		//입력,수정
		for ( int i = 0 ; i < ds_Dlist.getRowCount() ; i++ )
		{
			sRowStatus = ds_Dlist.getRowType(i);
			sbSql.delete(0, sbSql.length());
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{
				sbSql.delete(0, sbSql.length());
				
				sbSql.append("\n\n");
				sbSql.append("INSERT INTO FMO_PAY               \n");
		        sbSql.append("     ( SABUN                      \n");
		        sbSql.append("     , WORK_SDT                   \n");
		        sbSql.append("     , UPJANG                     \n");
		        sbSql.append("     , WORK_EDT                   \n");
		        sbSql.append("     , PAY_GB                     \n");
		        sbSql.append("     , PAY_AMT                    \n");
		        sbSql.append("     , REG_PAY                    \n");
		        sbSql.append("     , REMARK                     \n");
		        sbSql.append("     , CUSER                      \n");
		        sbSql.append("     , CDATE                      \n");
		        sbSql.append("     , UUSER                      \n");
		        sbSql.append("     , UDATE            		    \n");
		        sbSql.append("     ) VALUES                     \n");
		        sbSql.append("     ( '" + nullToBlank(ds_Dlist.getString(i,"SABUN")) + "'                                           \n");
		        sbSql.append("     , '" + nullToBlank(ds_Dlist.getString(i, "WORK_SDT")) + "'   \n");
		        sbSql.append("     , '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'           \n");
		        sbSql.append("     , '" + nullToBlank(ds_Dlist.getString(i, "WORK_EDT")) + "'   \n");
		        sbSql.append("     , '" + nullToBlank(ds_Dlist.getString(i, "PAY_GB")) + "'     \n");
		        sbSql.append("     , '" + nullToBlank(ds_Dlist.getString(i, "PAY_AMT")) + "'    \n");
		        sbSql.append("     , '" + nullToBlank(ds_Dlist.getString(i, "REG_PAY")) + "'    \n");
		        sbSql.append("     , '" + nullToBlank(ds_Dlist.getString(i, "REMARK")) + "'     \n");
		        sbSql.append("     , '" + g_EmpNo + "'                          	                         \n");
		        sbSql.append("     , SYSDATE                   										         \n");
		        sbSql.append("     , '" + g_EmpNo + "'                          					         \n");
		        sbSql.append("     , SYSDATE  \n");
		        sbSql.append(")                         \n");		        
		        sbSql.append("\n\n");
			
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.delete(0, sbSql.length());
				
				sbSql.append("\n\n");
		        sbSql.append("UPDATE FMO_PAY          \n");
		        sbSql.append("   SET SABUN = '"+nullToBlank(ds_Dlist.getString(i,"SABUN"))+"',     \n");
		        sbSql.append("       WORK_SDT = '"+nullToBlank(ds_Dlist.getString(i,"WORK_SDT"))+"',      \n");
		        sbSql.append("       UPJANG = '"+nullToBlank(ds_Cond.getString(i,"UPJANG"))+"',      \n");
		        sbSql.append("       WORK_EDT = '"+nullToBlank(ds_Dlist.getString(i,"WORK_EDT"))+"',      \n");
		        sbSql.append("       PAY_GB = '"+nullToBlank(ds_Dlist.getString(i,"PAY_GB"))+"',      \n");
		        sbSql.append("       PAY_AMT = '"+nullToBlank(ds_Dlist.getString(i,"PAY_AMT"))+"',      \n");
		        sbSql.append("       REG_PAY = '"+nullToBlank(ds_Dlist.getString(i,"REG_PAY"))+"',      \n");
		        sbSql.append("       REMARK = '"+nullToBlank(ds_Dlist.getString(i,"REMARK"))+"',      \n");
		        sbSql.append("       UUSER = '"+ g_EmpNo +"',      \n");
		        sbSql.append("       UDATE = SYSDATE \n");
		        sbSql.append(" WHERE 1 = 1               \n");
		        sbSql.append("   AND SABUN = '"+nullToBlank(ds_Dlist.getString(i,"SABUN"))+"'   \n");
		        sbSql.append("   AND WORK_SDT = '"+nullToBlank(ds_Dlist.getString(i,"WORK_SDT"))+"'  \n");
		        sbSql.append("\n\n");
	
		        pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}
		}
	
		//삭제
		for ( int i = 0 ; i < ds_Dlist.getRemovedRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
	
			sbSql.append("\n\n");
	        sbSql.append("DELETE FROM FMO_PAY   \n");
	        sbSql.append("      WHERE SABUN = '"+ds_Dlist.getRemovedData(i,"SABUN")+"'           \n");
	        sbSql.append("        AND WORK_SDT = '"+ds_Dlist.getRemovedData(i,"WORK_SDT")+"'           \n");
	        sbSql.append("\n\n");
			
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