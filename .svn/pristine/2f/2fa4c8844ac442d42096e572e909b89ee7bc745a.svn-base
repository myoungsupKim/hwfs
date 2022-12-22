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
						
			String FROM 		= nullToBlank(in_vl.getString("FROM"));		
			String TO 			= nullToBlank(in_vl.getString("TO"));
			String GBN 			= nullToBlank(in_vl.getString("GBN"));
			String g_CustCd		= nullToBlank(in_vl.getString("g_CustCd"));
			String CENTER 		= nullToBlank(in_vl.getString("CENTER"));	// 센터	
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append(" SELECT TRANS_DEPT_ID TRANS_UPJANG, MU_NM || ' ' || CC_NM UPJANGNM,                                                                     	\n");
		sbSql.append("	SUM(NOTAX) NOTAX, SUM(TAX) TAX, SUM(VAT) VAT, SUM(TAXALL) TAXALL, SUM(TOTAL) TOTAL,                                             	\n");
		sbSql.append("	BUDDEPT_ID                                                                                                                      	\n");
		sbSql.append(" FROM (                                                                                                                                 	\n");
		sbSql.append(" SELECT A.TRANS_DEPT_ID, C.MU_NM, C.CC_NM, A.ACCTCD, A.BUD_CLS,                                                                         	\n");
		sbSql.append("	ROUND(SUM(DECODE(TAX_CODE, '210',TRANS_UAMOUNT,0))) NOTAX,                                                                      	\n");
		sbSql.append("	ROUND(SUM(DECODE(TAX_CODE, '100',TRANS_UAMOUNT,0))) TAX,                                                                        	\n");
		sbSql.append("	DECODE(D.VAT_CUSTGUBUN,'001',0,'002',0,ROUND(SUM(DECODE(TAX_CODE, '100',(TRANS_UAMOUNT*0.1)+(TRANS_UVAT*TRANS_QTY),0)))) VAT,   	\n");
		sbSql.append("	ROUND(SUM(DECODE(TAX_CODE, '100',TRANS_UAMOUNT,0))) +                                                                           	\n");
		sbSql.append("	DECODE(D.VAT_CUSTGUBUN,'001',0,'002',0,ROUND(SUM(DECODE(TAX_CODE, '100',(TRANS_UAMOUNT*0.1)+(TRANS_UVAT*TRANS_QTY),0)))) TAXALL,	\n");
		sbSql.append("	ROUND(SUM(DECODE(TAX_CODE, '210',TRANS_UAMOUNT,0))) +                                                                           	\n");
		sbSql.append("	ROUND(SUM(DECODE(TAX_CODE, '100',TRANS_UAMOUNT,0))) +                                                                           	\n");
		sbSql.append("	DECODE(D.VAT_CUSTGUBUN,'001',0,'002',0,ROUND(SUM(DECODE(TAX_CODE, '100',(TRANS_UAMOUNT*0.1)+(TRANS_UVAT*TRANS_QTY),0)))) TOTAL, 	\n");
		sbSql.append("	A.BUDDEPT_ID                                                                                                                    	\n");
		sbSql.append(" FROM   ST_CUST D,                                                                                                                      	\n");
		sbSql.append("	SC_DEPT_V C,                                                                                                                    	\n");
		sbSql.append("	ST_UPJANG B,                                                                                                                    	\n");
		sbSql.append("	PO_TRANSACTION A                                                                                                                	\n");
		sbSql.append(" WHERE  A.TRANS_UPJANG = B.UPJANG                                                                                                       	\n");
		sbSql.append(" AND    A.TRANS_DEPT_ID = C.DEPT_ID                                                                                                     	\n");
		sbSql.append(" AND    A.CUSTCD = D.CUSTCD                                                                                                             	\n");
		sbSql.append(" AND    A.TRANS_TYPE = 'I001'                                                                                                           	\n");
		sbSql.append(" AND    A.TRANS_QTY <> 0                                                                                                                	\n");
		sbSql.append(" AND    A.CUSTCD    = "+g_CustCd+"         --[g_CustCd]                                                                                       	\n");
		if(! GBN.equals("5"))
			sbSql.append(" AND    A.ITEM_CODE LIKE '01%'                                                                                                          	\n");
		sbSql.append(" AND    TRANS_DATE  BETWEEN '"+FROM+"' AND '"+TO+"' --[입고일]                                                                        	\n");
		if(!CENTER.equals(""))	
		{
			sbSql.append(" AND    A.CENTER_CODE = "+CENTER+"    --[물류센터권역.CENTER_CODE, 전체도 가능]	\n");
		}
		if( GBN.equals("1"))
		{
			sbSql.append(" AND    TRANS_MU_CD <> 'YA'                                                                                                             	\n");
		} else if( GBN.equals("2"))
		{
			sbSql.append(" AND    TRANS_MU_CD = 'YA'                                                                                                              	\n");
			sbSql.append(" AND    A.SUBINV_CODE NOT LIKE 'S10%'                                                                                                   	\n");
			sbSql.append(" AND    B.SCHOOL_YN = 'N'                                                                                                               	\n");
			sbSql.append(" AND    NVL(A.OUTVAT_FLAG,'N') = 'N'                                                                                                    	\n");
		}else if( GBN.equals("3"))
		{
			sbSql.append(" AND    TRANS_MU_CD = 'YA'                                                                                                              	\n");
			sbSql.append(" AND    A.SUBINV_CODE NOT LIKE 'S10%'                                                                                                   	\n");
			sbSql.append(" AND    B.SCHOOL_YN = 'Y'                                                                                                               	\n");
			sbSql.append(" AND    NVL(A.OUTVAT_FLAG,'N') = 'Y'                                                                                                    	\n");
		} else if( GBN.equals("4"))
		{
			sbSql.append(" AND    TRANS_MU_CD = 'YA'                                                                                                              	\n");
			//sbSql.append(" AND    A.SUBINV_CODE LIKE 'C30%'                                                                                                       	\n");
			sbSql.append(" AND    A.SUBINV_CODE NOT LIKE 'S10%'                                                                                                   	\n");
			sbSql.append(" AND    B.SCHOOL_YN = 'Y'                                                                                                               	\n");
			sbSql.append(" AND    NVL(A.OUTVAT_FLAG,'N') = 'N'                                                                                                    	\n");
		} else if( GBN.equals("5"))
		{
			sbSql.append(" AND    TRANS_MU_CD = 'YA'                                                                                                              	\n");
			//sbSql.append(" AND    SUBSTR(A.SUBINV_CODE,1,3) NOT IN ('C30','S10')                                                                                  	\n");
			//sbSql.append(" AND    B.SCHOOL_YN = 'Y'                                                                                                               	\n");
			sbSql.append(" AND    A.ITEM_CODE LIKE '06%'                                                                                                          	\n");
		} else if( GBN.equals("6"))
		{
			sbSql.append(" AND    TRANS_MU_CD = 'YA'                                                                                                              	\n");
			sbSql.append(" AND    A.SUBINV_CODE LIKE 'S10%'                                                                                                       	\n");
		}
		sbSql.append(" GROUP BY A.TRANS_DEPT_ID, C.MU_NM, C.CC_NM, A.ACCTCD, A.BUD_CLS, D.VAT_CUSTGUBUN, A.BUDDEPT_ID                                         	\n");
		sbSql.append(" )                                                                                                                                      	\n");
		sbSql.append(" GROUP BY TRANS_DEPT_ID, MU_NM, CC_NM, BUDDEPT_ID                                                                                       	\n");
		
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