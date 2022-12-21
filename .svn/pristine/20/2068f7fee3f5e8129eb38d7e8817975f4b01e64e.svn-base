<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/그룹레시피                                                                                                                                                                   
■ 프로그램ID   : FSR90100E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 그룹레시피관리 등록                                                                                                                                               
■ 작성일자     : 2015-02-23                                                                                                                                                                           
■ 작성자       : 김민수                                                                                                                                                                                
■ 이력관리     :                                                                                                                                                                             
-----------------------------------------------------------------------------*/                                                                                                                         
%> 

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;

	try {
	
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo 	   	      = in_vl.getString("g_EmpNo");
		String GRP_SEQ            = nullToBlank(in_vl.getString("GRP_SEQ"));
		String RECIPE_CD          = "";
		String ITEM_CODE          = "";
		String CHK                = "";
		
		DataSet ds_itemList     = in_dl.get("ds_itemList");
		
		StringBuffer sbSql = new StringBuffer();				
		int RowCnt = ds_itemList.getRowCount();

		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			if(ds_itemList.getRowType(i) == DataSet.ROW_TYPE_UPDATED) {
				CHK            = nullToBlank(ds_itemList.getString(i,"CHK"));
				RECIPE_CD      = nullToBlank(ds_itemList.getString(i,"RECIPE_CD"));
				ITEM_CODE      = nullToBlank(ds_itemList.getString(i,"ITEM_CODE"));
				
				if (CHK.equals("")) CHK = "0";
				
				sbSql.delete(0, sbSql.length());	
				sbSql.append("UPDATE FSR_STD_RECIPE_ITEM SET ATTR10 = " + CHK + " WHERE RECIPE_CD = '" + RECIPE_CD + "' AND ITEM_CODE = '" + ITEM_CODE + "'");
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
				
				if(CHK.equals("0")) {
					// 식단에 등록되어 있는 대표자재 해제
					sbSql.delete(0, sbSql.length());
					sbSql.append("UPDATE FSM_REAL_RECIPE_ITEM                         ");
					sbSql.append("   SET ATTR10 = 0                                   ");
					sbSql.append(" WHERE NEED_DATE >= TO_CHAR(SYSDATE, 'YYYYMMDD')    ");
					sbSql.append("   AND NVL(ORDER_YN, 'N') = 'N'                     ");
					sbSql.append("   AND ATTR10 = 1                                   ");
					sbSql.append("   AND RECIPE_CD = '" + RECIPE_CD + "'              ");
					sbSql.append("   AND ITEM_CODE = '" + ITEM_CODE + "'              ");
					stmt = conn.createStatement();
					stmt.execute(sbSql.toString());
					stmt.close();
				}
			}
		}
		
		//트랜잭션 성공
		conn.commit();		
		this.setResultMessage(0, "OK", out_vl);
	
	} catch(Exception ex) {	
		ex.printStackTrace();
		//트랜잭션 실패
		conn.rollback();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		//메세지반환
		this.setResultMessage(-1, ex.toString(),out_vl);
	} finally {
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {}
		}			
		
		if(pstmt != null) {
			try {
				stmt.close();
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