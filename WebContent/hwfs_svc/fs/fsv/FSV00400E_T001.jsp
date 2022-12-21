<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���¾�ü > �����
�� ���α׷�ID   : FSV00400E_T001.jsp
�� ���α׷���   : �����̷°���(��ȸ)
�� �ۼ�����     : 2008-07-01
�� �ۼ���       : ������
�� �̷°���     : 2008-07-01 - �����ۼ� ������ CSR#(28344)
                2009-07-24 ������ CSR#(29350) ��û��:����(����������)
                ������ �������濡 ���� �����׸� ����
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
		
		//�Է� ����Ÿ                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input"); 
		
		String strCnterCode 		= nullToBlank(ds_input.getString(0, "CENTER_CODE"));                                                                                                                                                                                                        
		String strCustCD			= nullToBlank(ds_input.getString(0, "CUSTCD"));
		String strCustNm			= nullToBlank(ds_input.getString(0, "CUSTNM"));
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		//out ����Ÿ                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql�� ���ۻ���                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// Ȯ���ܰ���ȸ
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT B.HIST_ID \n");
		sbSql.append("     , A.ITEM_CODE \n");
		sbSql.append("     , C.ITEM_NAME \n");
		sbSql.append("     , C.PO_UOM \n");
		sbSql.append("     , C.ITEM_SIZE \n");
		sbSql.append("     , DECODE(C.TAX_CODE,'100','����','210','�鼼','����') AS TAX_CODE     --���鼼 \n");
		sbSql.append("     , C.KEEPING_TYPE --������� \n");
		sbSql.append("     , C.ORIGIN_TYPE  --������ \n");
		sbSql.append("     , DECODE(NVL(D.D_DAYS,0), 0, '����', 'D-'||(D.D_DAYS+1)||' '||DECODE(NVL(D.D_TIMES,0),0,NULL,D.D_TIMES||'��')) D_DAY --�������� \n");
		sbSql.append("     , B.ITEM_FEATURE  --����Ư�� \n");
		sbSql.append("     , NVL2(B.DOCU_FILE1,'Y','N') DOCU_YN -- �����ڷ� \n");
		sbSql.append("     , B.NUT_INFO --��������� \n");
		sbSql.append("     , B.MARKET_TREND --���嵿�� \n");
		sbSql.append("     , B.APRV_YN --���ο��� \n");
		sbSql.append("     , B.DOCU_FILE1 \n");
		sbSql.append("     , B.DOCU_FILE2 \n");
		sbSql.append("     , B.DOCU_FILE3 \n");
		sbSql.append("     , B.DOCU_FILE4 \n");
		sbSql.append("     , B.DOCU_FILE5 \n");
		sbSql.append("     , B.SDOCU_FILE1 \n");
		sbSql.append("     , B.SDOCU_FILE2 \n");
		sbSql.append("     , B.SDOCU_FILE3 \n");
		sbSql.append("     , B.SDOCU_FILE4 \n");
		sbSql.append("     , B.SDOCU_FILE5 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE1 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE2 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE3 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE4 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE5 \n");
		//2008.12.18 ������ : �������/����⵵/��ó���۾���/���ο�����/������/��ü�ĺ���ȣ/������� �߰�
//============================================================================================
//(2009-07-24 �߰�) ����
// 2009-07-24 ������ CSR#(29350) ��û��:����(����������)
// ������ �������濡 ���� �����׸� ����
//============================================================================================
		sbSql.append("     , B.ORIGIN_QUALITY, B.ORIGIN_INFO, B.PRODUCT_YEAR, NVL(B.BOXING_QTY,0) AS BOXING_QTY \n");
		sbSql.append("     , B.PREJOB_DATE, B.PART_NAME, B.BLNUMBER \n");
		sbSql.append("     , B.ITEM_GRADE, B.IDNUMBER, B.CONF_NUM, B.BUTCH_NAME \n");
		//
		sbSql.append("     , B.ITEM_PRT_NAME, B.MATERIAL_INFO, B.LIFEDAY_INFO \n");
		sbSql.append("     , B.KEEPING_METHOD, B.ATTENTION_INFO \n");
//============================================================================================
//(2009-07-24 �߰�) ��
//============================================================================================
		sbSql.append("     , B.IMPORT_NUM \n");
	    sbSql.append("     , '" + strCustNm + "' CUSTNM \n");
	    sbSql.append("     , B.PRODUCT_NAME \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("        SELECT CENTER_UPJANG, ITEM_CODE \n");
		//sbSql.append("          FROM PO_CUSTOM_ITEM \n");
		sbSql.append("          FROM PO_CUSTOM_ITEM \n");
		sbSql.append("         WHERE CENTER_UPJANG = " + strCnterCode + " \n");
		sbSql.append("           AND CUSTCD = " + strCustCD + " \n");
		sbSql.append("           AND USE_TYPE = '01' --�ϵ��ڵ� \n");
		sbSql.append("       ) A \n");
		sbSql.append("     , ( \n");
		sbSql.append("        SELECT * \n");
		sbSql.append("          FROM PO_ITEM_HIST \n");
		sbSql.append("         WHERE CENTER_CODE = " + strCnterCode + " \n");
		sbSql.append("           AND CUSTCD = " + strCustCD + " \n");
		sbSql.append("           AND USE_YN = 'Y' \n");
		sbSql.append("       ) B \n");
		sbSql.append("     , PO_ITEM_MST C \n");
		sbSql.append("     , PO_PREORDER_LIST D \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.CENTER_UPJANG = B.CENTER_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("   AND A.CENTER_UPJANG = D.CENTER_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		sbSql.append(" ORDER BY A.ITEM_CODE \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");                                                                                                                                                          
                                                                                                                                                                                                        
		/**����**/                                                                                                                                                                                          
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