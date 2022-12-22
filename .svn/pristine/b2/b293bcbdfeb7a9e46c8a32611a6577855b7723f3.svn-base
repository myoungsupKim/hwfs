<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매신청/재고등록/재고등록 잠금해제/저장
■ 프로그램ID   : FSP00900E_T001.jsp
■ 프로그램명   : 잠금여부 저장
■ 작성일자     : 2015-10-29
■ 작성자       : 정영철
■ 이력관리     : 2015-10-29
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
Statement stmt             =  null;
try	{
	PlatformRequest platformRequest = this.proc_input(request);  
	in_vl = platformRequest.getData().getVariableList();
	in_dl = platformRequest.getData().getDataSetList();
	
	//jsp log 서비스 시작 
	logger.startIndividualLog(in_vl.getString("titLogId"));
	
	//오토커밋 강제 false
	conn.setAutoCommit(false);
	
	//입력 데이타                                                                                                                                                                                         
	DataSet ds_list  	= in_dl.get("ds_list");
	
	String g_EmpNo 		= in_vl.getString("g_EmpNo");
	
	StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
	
	int RowCnt;
	int i;
	int RowStatus;

	// 2.Detail
	RowCnt = ds_list.getRowCount();
	
	for ( i = 0 ; i < RowCnt ; i++ )
	{
		RowStatus 	= ds_list.getRowType(i);
		
		if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE FSP_PHYSICAL_INVENTORY_LOG 														\n");
			sbSql.append("   SET STATUS      = NVL('" +	Integer.parseInt(ds_list.getString(i,"STATUS")) +"', 0)		\n");
			sbSql.append("	   , UPDATE_BY   = '" + g_EmpNo + "' 													\n");
			sbSql.append("	   , UPDATE_DATE = SYSDATE 																\n");
			sbSql.append(" WHERE UPJANG = '" + ds_list.getString(i,"UPJANG") +"' 									\n");
			sbSql.append("   AND SUBINV_CODE = '"	+ ds_list.getString(i,"SUBINV_CODE") +"'						\n");
			
			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
	}
	
	conn.commit();
   	this.setResultMessage(0, "OK",out_vl);
	
} catch(Exception ex) {
	conn.rollback();
	//ex.printStackTrace();
	//jsp 로그남기기
	logger.debug(ex.getMessage(), ex);
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
		
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}
	
  proc_output(response,out,out_vl,out_dl);
%>
