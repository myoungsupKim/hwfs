<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
		DataSet in_ds  =  in_dl.get("ds_tab1");
	//	String sCode = in_ds.getString(0, "CD");
			
		String g_EmpNo 			= in_vl.getString("g_EmpNO");
		String GBN 				= in_vl.getString("GBN");
		System.out.println("===>"+g_EmpNo); 
		System.out.println("==>"+GBN); 
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		//-------------------------------------------------
			int RowCnt = in_ds.getRowCount();
			int i;
			int RowStatus;
			RowCnt = in_ds.getRowCount();
		//-------------------------------------------------
		System.out.println(RowCnt); 
		StringBuffer sbSql = new StringBuffer();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus 	= in_ds.getRowType(i);
			System.out.println("**********");
			System.out.println(in_ds.getRowType(i));
			System.out.println(in_ds.getRowType(i));
			System.out.println("***********");
			if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE PO_CLAIM_LIST SET	\n");
				if(GBN.equals("S") )
				{
					sbSql.append("       DLVY_KIND = '업장접수',  -- '저장'버튼클릭시 '업장접수', 확정버튼 클릭시 '처리완료'\n");
				}
				else
				{
					sbSql.append("       DLVY_KIND = '처리완료',  -- '저장'버튼클릭시 '업장접수', 확정버튼 클릭시 '처리완료'\n");
				}
				if(GBN.equals("S") )
				{
					sbSql.append("       PRCS_STATUS = '07',  -- '저장'버튼클릭시 '07', 확정버튼 클릭시 '08'\n");
				}
				else
				{
					sbSql.append("       PRCS_STATUS = '08',  -- '저장'버튼클릭시 '07', 확정버튼 클릭시 '08'\n");
				}
				sbSql.append("       UPDATE_DATE = SYSDATE,\n");
				sbSql.append("       UPDATE_BY = '"+g_EmpNo+"' -- [g_EmpNo] \n");
				sbSql.append(" WHERE \n");
				sbSql.append("      PO_ID = "+in_ds.getString(i,"PO_ID")+"  -- 상단 조회 PO_ID\n");
				
				System.out.println(sbSql.toString());  				
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery(); 
			}
		}
		conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		   ex.printStackTrace();
		   conn.rollback();
	       this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
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
			if(stmt != null) {
				try {
					stmt.close();
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