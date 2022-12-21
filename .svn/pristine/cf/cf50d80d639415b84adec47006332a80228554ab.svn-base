<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));	
		
		DataSet in_ds  =  in_dl.get("ds_Input");
		
		String FROM_DT1 = in_ds.getString(0, "FROM_DT1");
		String TO_DT1   = in_ds.getString(0, "TO_DT1");
		String MU_CD   	= nullToBlank(in_ds.getString(0, "MU_CD"));
		String TM_CD   	= nullToBlank(in_ds.getString(0, "TM_CD"));
		String UPJANG 	= nullToBlank(in_ds.getString(0, "UPJANG"));
		String PO_TYPE 	= nullToBlank(in_ds.getString(0, "PO_TYPE"));
		String CENTER 	= nullToBlank(in_ds.getString(0, "CENTER"));
		String CUSTCD 	= nullToBlank(in_ds.getString(0, "CUSTCD"));
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("\nSELECT E.SUBINV_NAME UPJANG_SUBINV");
		sbSql.append("\n     , TO_CHAR(A.UPDATE_DATE,'YYYY-MM-DD HH24:MI') RETURN_DATETIME");
		sbSql.append("\n     , A.NEED_DATE"	);
		sbSql.append("\n     , A.PO_TYPE"	); 
		sbSql.append("\n     , A.ITEM_CODE"	);
		sbSql.append("\n     , A.ITEM_NAME"	);
		sbSql.append("\n     , A.ITEM_SIZE"	);
		sbSql.append("\n     , A.PO_UOM"	);
		sbSql.append("\n     , A.PR_QTY"	);
		sbSql.append("\n     , C.VD_NM AS CUSTNM"	);
		sbSql.append("\n     , A.PR_REMARK"	);
		sbSql.append("\n     , A.RC_UPJANG"	);
		sbSql.append("\n     , F.MU_NM"	    );
		sbSql.append("\n     , F.TM_NM"	    );
		sbSql.append("\n     , B.UPJANGNM"  );
		sbSql.append("\n     , A.LINE_STATUS"  );
		sbSql.append("\n  FROM SO_PR A"					 );
		sbSql.append("\n     , ST_UPJANG B"				 );
		sbSql.append("\n     , VO_FC_VENDOR C"				 );
		sbSql.append("\n     , HLDC_PO_SUBINVENTORY E"	 );
		sbSql.append("\n     , HLDC_SC_DEPT_V F"	 );
		sbSql.append("\n WHERE A.RC_UPJANG   = B.UPJANG" );
		sbSql.append("\n   AND A.CUSTCD      = C.VD_CD" );
		sbSql.append("\n   AND A.SUBINV_CODE = E.SUBINV_CODE(+)");
		sbSql.append("\n   AND A.PR_DEPT_ID  = F.DEPT_ID"      );
		if( !UPJANG.equals("")) 
			sbSql.append("\n   AND A.RC_UPJANG   = '"+UPJANG+"'");
		sbSql.append("\n   AND A.NEED_DATE BETWEEN '"+FROM_DT1 +"' AND '"+TO_DT1+"'");
		sbSql.append("\n   AND A.LINE_STATUS   IN('003', 'PR', 'PD')");
		sbSql.append("\n   AND A.PO_TYPE     = DECODE('"+ PO_TYPE +"', '%', A.PO_TYPE, '"+ PO_TYPE +"')");

		if( !CENTER.equals("")) 
			sbSql.append("\n   AND A.CENTER_CODE = '"+ CENTER +"' --센터코드");
		if( !CUSTCD.equals("") ) 
			sbSql.append("\n   AND A.CUSTCD = '"+CUSTCD +"' -- 업체");
		sbSql.append("\n   AND F.MU_CD = '"+MU_CD +"'\n");
		if( !TM_CD.equals("") )
			sbSql.append("\n   AND F.TM_CD = '"+TM_CD +"'\n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		DataSet ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);

		rs.close();
		pstmt.close();
		
	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		//ex.printStackTrace();
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