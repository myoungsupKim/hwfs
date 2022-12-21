<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 운영관리
■ 프로그램ID   : FSV00450E_T001.jsp
■ 프로그램명   : 자재이미지관리(조회)
■ 작성일자     : 2012-04-01
■ 작성자       : 박은규
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
		DataSet ds_input     = in_dl.get("ds_input"); 
		
		String strCnterCode 		= nullToBlank(ds_input.getString(0, "CENTER_CODE"));                                                                                                                                                                                                        
		String strCustCD			= nullToBlank(ds_input.getString(0, "CUSTCD"));
		String vAppPath  	        = in_vl.getString("vAppPath");
		String vMstPath  	        = in_vl.getString("vMstPath");
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt =  conn.createStatement();
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 확정단가조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT B.IMAGE_ID                                                                                           \n");
        sbSql.append("     , A.ITEM_CODE                                                                                          \n");
        sbSql.append("     , A.ITEM_NAME                                                                                          \n");
        sbSql.append("     , A.PO_UOM                                                                                             \n");
        sbSql.append("     , A.ITEM_SIZE                                                                                          \n");
        sbSql.append("     , DECODE(A.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE     --과면세                         \n");
        sbSql.append("     , DECODE(NVL(B.IMAGE_FILE, 'N'), 'N' ,'N', 'Y') AS APP_FILE                                            \n");
        sbSql.append("     , DECODE(B.IMAGE_FILE, NULL, NULL, '" + vAppPath + "'||'/'||B.IMAGE_FILE) AS APP_PATH                                         \n");
        sbSql.append("     , DECODE(NVL(A.IMG_PATH, 'N'), 'N' ,'N', 'Y') AS MST_FILE                                              \n");
        sbSql.append("     , DECODE(A.IMG_PATH, NULL, NULL, '" + vMstPath + "'||'/'||A.IMG_PATH) AS MST_PATH                                           \n");
        sbSql.append("  FROM                                                                                                      \n");
        sbSql.append("       (                                                                                                    \n");
        sbSql.append("        SELECT Z.CENTER_UPJANG, Z.CUSTCD, Z.ITEM_CODE, Y.ITEM_NAME, Y.ITEM_SIZE, Y.PO_UOM, Y.TAX_CODE, Y.IMG_PATH \n");
        sbSql.append("          FROM PO_CUSTOM_ITEM Z, PO_ITEM_MST Y                                                              \n");
        sbSql.append("         WHERE Z.ITEM_CODE = Y.ITEM_CODE                                                                    \n");
        sbSql.append("           AND Z.CENTER_UPJANG = " + strCnterCode + "                                                                      \n");
        sbSql.append("           AND Z.CUSTCD = " + strCustCD + "                                                                            \n");
        sbSql.append("           AND Z.USE_TYPE = '01' --하드코딩                                                                 \n");
        sbSql.append("       ) A                                                                                                  \n");
        sbSql.append("     , (                                                                                                    \n");
        sbSql.append("        SELECT *                                                                                            \n");
        sbSql.append("          FROM PO_ITEM_IMAGE                                                                                \n");
        sbSql.append("         WHERE CENTER_CODE = " + strCnterCode + "                                                                         \n");
        sbSql.append("           AND CUSTCD = " + strCustCD + "                                                                              \n");
        sbSql.append("           AND USE_YN = 'Y'                                                                                 \n");
        sbSql.append("       ) B                                                                                                  \n");
        sbSql.append(" WHERE A.CENTER_UPJANG = B.CENTER_CODE(+)                                                                   \n");
        sbSql.append("   AND A.CUSTCD = B.CUSTCD(+)                                                                               \n");
        sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+)                                                                         \n");
        sbSql.append(" ORDER BY A.ITEM_CODE                                                                                       \n");
        
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