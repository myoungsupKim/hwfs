<%
///*-----------------------------------------------------------------------------
//�� �ý��۸�     : ��޻�ǰ ���
//�� ���α׷�ID   : FMW00100E_T003.jsp
//�� ���α׷���   : ���Դܰ� ��ȸ
//�� �ۼ�����     : 2011.01.06
//�� �ۼ���       : ������
//�� �̷°���     : 2011.01.06
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//�Է� ����Ÿ		
		String v_Upjang        = nullToBlank(in_vl.getString("v_Upjang"));
		String v_ItemCode      = nullToBlank(in_vl.getString("v_ItemCode"));
	
		//out ����Ÿ
		DataSet ds_List1;
		
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());	
        sbSql.append("SELECT A.SDATE                   					  \n");
        sbSql.append("     , A.EDATE                                      \n");
        sbSql.append("     , A.UNIT_PRICE * B.ITEM_SIZE_BONG AS BOX_PRICE \n");
        sbSql.append("     , A.UNIT_PRICE AS BONG_PRICE                   \n");
        sbSql.append("     , A.UPJANG                                     \n");
        sbSql.append("     , '0' AS CHK_YN                                \n");
        sbSql.append("  FROM FMW_OTCUST_PRICE A, FMW_OTCUST_ITEM B    \n");
        sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE  \n");
        sbSql.append("   AND A.UPJANG = B.UPJANG  \n");
        sbSql.append("   AND A.UPJANG = '" + v_Upjang + "' \n");
        sbSql.append("   AND A.ITEM_CODE = '" + v_ItemCode + "' \n");
        sbSql.append("UNION ALL                                                   \n");
        sbSql.append("SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') AS SDATE                \n");
        sbSql.append("     , '' AS EDATE                \n");
        sbSql.append("     , A.CONTRACT_PRICE_S AS BOX_PRICE                            \n");
        sbSql.append("     , ROUND(A.CONTRACT_PRICE_S / A.ITEM_SIZE_BONG) AS BONG_PRICE \n");
        sbSql.append("     , " + v_Upjang + " AS UPJANG                           \n");
        sbSql.append("     , '0' AS CHK_YN                                        \n");
        sbSql.append("  FROM HLDC_PO_ITEM_FMW A                                   \n");
        sbSql.append(" WHERE A.ITEM_CODE = '" + v_ItemCode + "' \n");
        sbSql.append(" ORDER BY SDATE DESC \n");
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List1 = this.makeDataSet(rs, "ds_List1");			
		pstmt.close();
		rs.close();
		/**����**/
		out_dl.add(ds_List1);
		this.setResultMessage(0, "OK", out_vl);
		//FileLog.println("c:\\aaa.txt",ds_out);
	   	
	    } catch(Exception ex) {
		//ex.printStackTrace();
		//jsp �α׳����
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
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception e) {}
			}
			//jsp log ���� �ݱ� 
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}					
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%>	