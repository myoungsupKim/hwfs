<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 운영관리
■ 프로그램ID   : FSV00470E_S001.jsp
■ 프로그램명   : 축산자재이력정보입력(조회)
■ 작성일자     : 2014-08-01
■ 작성자       : 문형광
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		String vClassify    = nullToBlank(in_vl.getString("vClassify"));
		
		//IRIS DB연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();
		stmt =  conn.createStatement();
	
		//out 데이타       
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 확정단가조회
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT DECODE(SUBSTR(A.SUBINV_CODE,1,3), 'S10', C.SUBINV_NAME                            \n");
        sbSql.append("                                               ,DECODE(SUBSTR(B.UPJANGNM,1,4),'단체급식', SUBSTR(B.UPJANGNM,6), B.UPJANGNM)) UPJANGNM \n");
        sbSql.append("     , DECODE(SUBSTR(A.SUBINV_CODE,1,3), 'S10', NULL                                     \n");
        sbSql.append("                                               ,REPLACE(C.SUBINV_NAME,'식자재_')) AS SUBINV_NAME \n");
        sbSql.append("     , A.ITEM_CODE                                                                       \n");
        sbSql.append("     , A.ITEM_NAME                                                                       \n");
        sbSql.append("     , A.ITEM_SIZE                                                                       \n");
        sbSql.append("     , A.PO_UOM                                                                          \n");
        sbSql.append("     , D.KEEPING_TYPE                                                                    \n");
        sbSql.append("     , A.PO_QTY                                                                          \n");
        sbSql.append("     , A.PO_ID                                                                           \n");
        sbSql.append("     , SUBSTR(A.ITEM_CODE, 5, 2) AS ITEM_CLASS                                           \n");
        sbSql.append("     , SIGN(TO_DATE(A.NEED_DATE, 'YYYYMMDD') - SYSDATE) AS CHK                           \n");
        sbSql.append("     , E.IMPORT_NUM                                                                      \n");
        sbSql.append("     , E.BUTCH_NAME                                                                      \n");
        sbSql.append("  FROM PO_PO A, ST_UPJANG B, PO_SUBINVENTORY C, PO_ITEM_MST D                            \n");
        sbSql.append("     , PO_ANIMAL_HIST E                                                                  \n");
        sbSql.append(" WHERE A.RC_UPJANG = B.UPJANG                                                            \n");
        sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE(+)                                                  \n");
        sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE                                                         \n");
        sbSql.append("   AND A.PO_ID = E.PO_ID(+)                                                              \n");
        sbSql.append("   AND A.LINE_STATUS >= '008'                                                            \n");
        sbSql.append("   AND A.ITEM_CODE BETWEEN '010401000000' AND '010404999999'                             \n");
        sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "'    \n");
        sbSql.append("   AND A.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "  \n");
        sbSql.append("   AND A.CUSTCD = " + nullToBlank(ds_Cond.getString(0, "CUSTCD")) + "            \n");
        if(vClassify.equals("Excel"))
		{
        	sbSql.append("   AND A.PO_ID = '" + nullToBlank(ds_Cond.getString(0, "PO_ID")) + "'            \n");
		}
        sbSql.append(" ORDER BY A.ITEM_CODE, B.UPJANGNM                                                        \n");       
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");                                                                                                                                                          
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_list);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);  
		
	} catch(Exception ex) {
		   ex.printStackTrace();
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