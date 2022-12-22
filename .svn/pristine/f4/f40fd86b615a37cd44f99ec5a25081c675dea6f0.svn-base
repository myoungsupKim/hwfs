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
			
			String SUBINV_CODE 		= in_vl.getString("SUBINV_CODE");		
			String FROM 			= in_vl.getString("FROM");		
			String REQ_DATE 		= nullToBlank(in_vl.getString("REQ_DATE"));		
			String ITEM_CODE 		= nullToBlank(in_vl.getString("ITEM_CODE"));
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT	A.PO_ID,				\n");
		sbSql.append("			A.NEED_DATE,       --입고일자\n");
		sbSql.append("			A.CENTER_CODE,     \n");
		sbSql.append("			A.UPJANG,\n");
		sbSql.append("			A.SUBINV_CODE,\n");
		sbSql.append("			A.CUSTCD,          --업체\n");
		sbSql.append("			B.CUSTNM,\n");
		sbSql.append("			A.ITEM_CODE,\n");
		sbSql.append("			A.ITEM_NAME,\n");
		sbSql.append("			A.ITEM_SIZE,\n");
		sbSql.append("			A.PO_UOM,\n");
		sbSql.append("			TO_CHAR(A.UNDLVY_QTY || '/' || A.DLVY_QTY) TR_STATUS,  --미입고량수량/입고수량\n");
		sbSql.append("			A.PO_QTY,            --발주수량\n");
		sbSql.append("			A.DLVY_QTY,          --입고수량\n");
		sbSql.append("			A.UNDLVY_QTY,        --미입고량수량\n");
		sbSql.append("			A.REQ_QTY,           --요청수량\n");
		sbSql.append("			A.CLAIM_KIND,        --클레임유형\n");
		sbSql.append("			A.REQ_KIND,          --요청사항\n");
		sbSql.append("			DECODE(A.REQ_DATE,'','',SUBSTR(A.REQ_DATE,1,4) || '/' ||SUBSTR(A.REQ_DATE,5,2) || '/' || SUBSTR(A.REQ_DATE,7,2)) REQ_DATE,--요청일자\n");
		sbSql.append("			DECODE(A.REQ_TIME,'','',SUBSTR(A.REQ_TIME,1,2) || ':' ||SUBSTR(A.REQ_TIME,3,2)) REQ_TIME,                        --요청시간\n");
		sbSql.append("			A.CLAIM_MEMO,        --클레임상세\n");
		sbSql.append("			A.PT_MEMO,           --업체처리상세\n");
		sbSql.append("			A.CT_KIND,           --센터처리내역\n");
		sbSql.append("			A.PT_KIND,           --업체처리내역\n");
		sbSql.append("			C.CODE_NAME,         --진행상황 명\n");
		sbSql.append("			DECODE(A.DLVY_TIME,'','',SUBSTR(A.DLVY_TIME,1,2) || ':' ||SUBSTR(A.DLVY_TIME,3,2)) DLVY_TIME,--입고예정시간\n");
		sbSql.append("			A.DLVY_KIND,       --입고상황\n");
		sbSql.append("			A.PRCS_STATUS,--진행상황\n");
		sbSql.append("		    0 CHOICE                --선택\n");
		sbSql.append("		  FROM PO_CLAIM_LIST A, ST_CUST B, PO_CODE C\n");
		sbSql.append("		 WHERE A.CUSTCD = B.CUSTCD\n");
		sbSql.append("		   AND A.PRCS_STATUS = C.CODE\n");
		sbSql.append("		   AND C.GROUP_CODE = 'C00'\n");
		sbSql.append("		   AND A.PRCS_STATUS BETWEEN '06' AND '07' --처리상황(고정)\n");
		sbSql.append("		   AND A.SUBINV_CODE = '"+SUBINV_CODE+"' --창고\n");
		sbSql.append("		   AND A.NEED_DATE = '"+FROM+"'   --입고일\n");
		sbSql.append("		   --입고예정일이 NULL이 아닐경우\n");
		if(!REQ_DATE.equals("") )
		{
			sbSql.append("		   AND A.REQ_DATE = '"+REQ_DATE+"'    --입고예정일\n");
		}
		sbSql.append("		   ----자재가 NULL이 아닐경우\n");
		if(!ITEM_CODE.equals("")  )
		{
			sbSql.append("		   AND A.ITEM_CODE = '"+ITEM_CODE+"' --자재\n");
		}
		sbSql.append("		 ORDER BY ITEM_CODE,A.NEED_DATE\n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_tab1 = this.makeDataSet(rs,"ds_tab1");
		out_dl.add(ds_tab1);

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