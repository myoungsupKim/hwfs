<%
/*
 ******************************************************************************************
 * 시스템구분: IFIS/메뉴관리/식단자재관리
 * 프로그램명: FSI00010E.XML
 * 기ㅡㅡㅡ능: 자재별 영양소 및 폐기율관리
 * 작ㅡ성ㅡ자: 한화S&C 박종세
 * 작성ㅡ일자: 2008-05-13
 * ----------------------------------------------------------------------------------------
 * HISTORY    :
 ******************************************************************************************
 */
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		DataSet in_ds  =  in_dl.get("ds_item_list");
		String g_EmpNo = in_vl.getString("g_EmpNo");
		
		int intRowCnt = 0;
		int intErrCnt = 0;
		String strRtn = "";
		StringBuffer sbSql = new StringBuffer();
		intRowCnt = in_ds.getRowCount();	
		
		String DISUSE_RATE="";
		String ATTR01="";
		String ITEM_CODE="";
		String EXIST_YN = "";
		
		for ( int i = 0 ; i < intRowCnt ; i++ )
		{
			ITEM_CODE   = in_ds.getString(i,"ITEM_CODE");
			DISUSE_RATE = nullToBlank(in_ds.getString(i,"DISUSE_RATE"));
			ATTR01      = nullToBlank(in_ds.getString(i,"ATTR01"));
			EXIST_YN    = nullToBlank(in_ds.getString(i,"EXIST_YN"));
					
			if(DISUSE_RATE.equals(""))
			{
				DISUSE_RATE="NULL";
			}
			if(ATTR01.equals(""))
			{
				ATTR01="NULL";
			}
			
			//////////////////////////////////////////////////////
			/// SELECT로 체크한 후 있으면 Update 없으면 Insert 변경
			//////////////////////////////////////////////////////
			sbSql.delete(0, sbSql.length());
			sbSql.append(" SELECT COUNT(*) AS R_COUNTER \n");
			sbSql.append("  FROM  FSI_ITEM_NUT     \n");
			sbSql.append(" WHERE  ITEM_CODE = '"+  ITEM_CODE +"'      \n");
			
			pstmt = conn.prepareStatement(sbSql.toString());	
			rs = pstmt.executeQuery(); 		
			rs.next();
			
			sbSql.delete(0, sbSql.length());
			if(Integer.parseInt(rs.getString("R_COUNTER"))>0)
			{
				sbSql.append(" UPDATE FSI_ITEM_NUT SET DISUSE_RATE="+ DISUSE_RATE + ",  ATTR01="+ ATTR01 +", UDATE=SYSDATE, UUSER='"+ g_EmpNo +"' WHERE ITEM_CODE='"+ ITEM_CODE + "'" );	
			}
			else
			{
				sbSql.append(" INSERT INTO FSI_ITEM_NUT (ITEM_CODE, DISUSE_RATE, ATTR01, CUSER, CDATE, UUSER, UDATE) VALUES ( '"+ ITEM_CODE +"', "+ DISUSE_RATE +", "+ ATTR01 +", '"+ g_EmpNo +"',  SYSDATE, '"+ g_EmpNo +"', SYSDATE )"  );
			}
			stmt = conn.createStatement();		
			stmt.execute(sbSql.toString());			
			stmt.close();			
			
			rs.close();
			pstmt.close();
		}
	
		//트랜잭션 성공
		conn.commit();		
		this.setResultMessage(0, "OK", out_vl);
		
		
	} catch(Exception ex) {
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