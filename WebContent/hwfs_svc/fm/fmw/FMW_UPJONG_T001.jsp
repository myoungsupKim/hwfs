<%
//*-----------------------------------------------------------------------------
//�� �ý��۸�     : ������ȸ
//�� ���α׷�ID   : FMW_UPJONG_T001.jsp
//�� ���α׷���   : ������ȸ
//�� �ۼ�����     : 2011.03.03
//�� �ۼ���       : ������
//�� �̷°���     :  
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		String v_Blank  	= nullToBlank(in_vl.getString("BLANK"));
	
		//out ����Ÿ                                                                                                                                                                                        
		DataSet ds_Upjong;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql�� ���ۻ���                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		sbSql.delete(0, sbSql.length());
		if (v_Blank.equals("A"))
		{
			sbSql.append("SELECT NULL AS UPJONG_CODE, '��ü' AS UPJONG_NAME FROM DUAL \n");
			sbSql.append("UNION ALL \n");
		}
		if (v_Blank.equals("Y"))
		{
			sbSql.append("SELECT NULL AS UPJONG_CODE, '' AS UPJONG_NAME FROM DUAL \n");
			sbSql.append("UNION ALL \n");
		}
		sbSql.append("SELECT CODE AS UPJONG_CODE, CODE_NAME AS UPJONG_NAME \n");
		sbSql.append("  FROM SCC_COMMON_CODE \n");
		sbSql.append(" WHERE GROUP_CODE = 'FMW003' \n");
		sbSql.append("   AND USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY UPJONG_CODE \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_Upjong = this.makeDataSet(rs, "ds_Upjong");                                                                                                                                                          
        
		/**����**/                                                                                                                                                                                          
		out_dl.add(ds_Upjong);                                                                                                                                                          
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