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
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
		
		String CENTER 		= in_vl.getString("CENTER");				
		String FROM 		= nullToBlank(in_vl.getString("FROM"));		
		String g_CustCd		= nullToBlank(in_vl.getString("g_CustCd"));
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT ROWNUM SEQ, PO_ID, NEED_DATE, UPJANGNM, SUBINV_NAME,                                                                      	\n");
		sbSql.append("       ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM,                                                                                  	\n");
		sbSql.append("       PO_QTY, REQ_QTY, CLAIM_KIND, REQ_KIND, CT_KIND,                                                                           	\n");
		sbSql.append("       REQ_DATE, REQ_TIME, CLAIM_MEMO, ETC_MEMO, PT_MEMO, PRCS_STATUS, CODE                                                      	\n");
		sbSql.append("  FROM (                                                                                                                         	\n");
		sbSql.append("SELECT /*+INDEX_DESC(A PO_CLAIM_LIST_IDX01)*/                                                                                    	\n");
		sbSql.append("       A.PO_ID,                                                                                                                  	\n");
		sbSql.append("       A.NEED_DATE,                                                                                                              	\n");
		sbSql.append("       REPLACE(D.UPJANGNM,'단체급식 ') UPJANGNM,                                                                                 	\n");
		sbSql.append("       E.SUBINV_NAME,                                                                                                            	\n");
		sbSql.append("       A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM,                                                                          	\n");
		sbSql.append("       A.PO_QTY, A.REQ_QTY,                                                                                                      	\n");
		sbSql.append("       A.CLAIM_KIND, A.REQ_KIND, A.CT_KIND,                                                                                      	\n");
		sbSql.append("       DECODE(A.REQ_DATE,'','',SUBSTR(A.REQ_DATE,1,4) || '/' ||SUBSTR(A.REQ_DATE,5,2) || '/' || SUBSTR(A.REQ_DATE,7,2)) REQ_DATE,	\n");
		sbSql.append("       DECODE(A.REQ_TIME,'','',SUBSTR(A.REQ_TIME,1,2) || ':' ||SUBSTR(A.REQ_TIME,3,2)) REQ_TIME,                                 	\n");
		sbSql.append("       A.CLAIM_MEMO, A.ETC_MEMO,                                                                                                 	\n");
		sbSql.append("       A.PT_MEMO,                                                                                                                	\n");
		sbSql.append("       C.CODE_NAME PRCS_STATUS, C.CODE                                                                                           	\n");
		sbSql.append("  FROM PO_CLAIM_LIST A,                                                                                                          	\n");
		sbSql.append("       PO_CODE C,                                                                                                                	\n");
		sbSql.append("       ST_UPJANG D,                                                                                                              	\n");
		sbSql.append("       PO_SUBINVENTORY E                                                                                                         	\n");
		sbSql.append(" WHERE A.PRCS_STATUS = C.CODE                                                                                                    	\n");
		sbSql.append("   AND A.UPJANG = D.UPJANG                                                                                                       	\n");
		sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE                                                                                             	\n");
		sbSql.append("   AND C.GROUP_CODE = 'C00'                                                                                                      	\n");
		sbSql.append("   AND A.PRCS_STATUS >= '05'                                                                                                     	\n");
		sbSql.append("   AND (A.LINK_DEPT IS NULL OR A.LINK_DEPT <> '물류센터')                                                                        	\n");
		sbSql.append("   AND A.NEED_DATE = '"+FROM+"'  --[입고일]                                                                                      	\n");
		sbSql.append("   AND A.REQ_DATE > A.NEED_DATE                                                                                                  	\n");
		sbSql.append("   AND A.CUSTCD = '"+g_CustCd+"'         --[g_CustCd]                                                                             \n");
		if(!CENTER.equals(""))
		{
			sbSql.append("   AND A.CENTER_CODE = '"+CENTER+"'    --[물류센터권역.CENTER_CODE, 전체도 가능]   \n");
		}
		sbSql.append(" ORDER BY D.UPJANGNM, E.SUBINV_NAME                                                                                              	\n");
		sbSql.append(" )                                                                                                                               	\n");
		sbSql.append(" ORDER BY NEED_DATE, UPJANGNM, SUBINV_NAME, ITEM_CODE, CLAIM_KIND                                                                	\n");

		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);

	   	this.setResultMessage(0, "OK",out_vl);
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