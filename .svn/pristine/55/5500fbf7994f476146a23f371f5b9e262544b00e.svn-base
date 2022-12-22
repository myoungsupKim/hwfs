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
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append(" SELECT TRANS_UPJANG, UPJANGNM, ACCTCD, ACCTNM6,                                                                                         	\n");
		sbSql.append("         SUM(NOTAX) NOTAX, SUM(TAX) TAX, SUM(VAT) VAT, SUM(TAXALL) TAXALL, SUM(TOTAL) TOTAL,                                             	\n");
		sbSql.append("              BUDDEPT_ID                                                                                                                 	\n");
		sbSql.append("  FROM (                                                                                                                                 	\n");
		sbSql.append("  SELECT A.TRANS_DEPT_ID TRANS_UPJANG, E.MU_NM || ' ' || E.CC_NM UPJANGNM, A.BUD_CLS,                                                    	\n");
		sbSql.append("        A.ACCTCD, C.ACCTNM6,                                                                                                             	\n");
		sbSql.append("        ROUND(SUM(DECODE(TAX_CODE, '210',TRANS_UAMOUNT,0))) NOTAX,                                                                       	\n");
		sbSql.append("        ROUND(SUM(DECODE(TAX_CODE, '100',TRANS_UAMOUNT,0))) TAX,                                                                         	\n");
		sbSql.append("        DECODE(D.VAT_CUSTGUBUN,'001',0,'002',0,ROUND(SUM(DECODE(TAX_CODE, '100',(TRANS_UAMOUNT*0.1)+(TRANS_UVAT*TRANS_QTY),0)))) VAT,    	\n");
		sbSql.append("        ROUND(SUM(DECODE(TAX_CODE, '100',TRANS_UAMOUNT,0))) +                                                                            	\n");
		sbSql.append("        DECODE(D.VAT_CUSTGUBUN,'001',0,'002',0,ROUND(SUM(DECODE(TAX_CODE, '100',(TRANS_UAMOUNT*0.1)+(TRANS_UVAT*TRANS_QTY),0)))) TAXALL, 	\n");
		sbSql.append("        ROUND(SUM(DECODE(TAX_CODE, '210',TRANS_UAMOUNT,0))) +                                                                            	\n");
		sbSql.append("        ROUND(SUM(DECODE(TAX_CODE, '100',TRANS_UAMOUNT,0))) +                                                                            	\n");
		sbSql.append("        DECODE(D.VAT_CUSTGUBUN,'001',0,'002',0,ROUND(SUM(DECODE(TAX_CODE, '100',(TRANS_UAMOUNT*0.1)+(TRANS_UVAT*TRANS_QTY),0)))) TOTAL,  	\n");
		sbSql.append("             A.BUDDEPT_ID                                                                                                                	\n");
		sbSql.append(" FROM   ST_CUST D,                                                                                                                       	\n");
		sbSql.append("        SC_DEPT_V E,                                                                                                                     	\n");
		sbSql.append("        ST_ACCOUNT C,                                                                                                                    	\n");
		sbSql.append("        ST_UPJANG B,                                                                                                                     	\n");
		sbSql.append("        PO_TRANSACTION A                                                                                                                 	\n");
		sbSql.append(" WHERE  A.TRANS_UPJANG = B.UPJANG                                                                                                        	\n");
		sbSql.append(" AND    A.ACCTCD = C.ACCTCD                                                                                                              	\n");
		sbSql.append(" AND    A.CUSTCD = D.CUSTCD                                                                                                              	\n");
		sbSql.append(" AND    A.TRANS_DEPT_ID = E.DEPT_ID                                                                                                      	\n");
		sbSql.append(" AND    A.TRANS_TYPE = 'I001'                                                                                                            	\n");
		sbSql.append(" AND    A.TRANS_QTY <> 0                                                                                                                 	\n");
		sbSql.append(" AND    A.CUSTCD    = "+g_CustCd+"         --[g_CustCd]                                                                                        	\n");
		sbSql.append(" AND    TRANS_DATE  BETWEEN '"+FROM+"' AND '"+TO+"' --[¿‘∞Ì¿œ]                                                                         		\n");
		if( GBN.equals("1"))
		{
			sbSql.append(" AND    TRANS_MU_CD <> 'YA'                                                                                                           \n");
			sbSql.append(" AND    A.ITEM_CODE BETWEEN '020000000000' AND '059999999999'                                                                         \n");			
		} else if( GBN.equals("2"))
		{
			sbSql.append(" AND    TRANS_MU_CD = 'YA'                                                                                                            \n");
			sbSql.append(" AND    B.SCHOOL_YN = 'N'                                                                                                             \n");
			sbSql.append(" AND    NVL(A.OUTVAT_FLAG,'N') = 'N'                                                                                                    	\n");
			sbSql.append(" AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'                                                                         \n");		
		} else if( GBN.equals("3"))
		{
			sbSql.append(" AND    TRANS_MU_CD = 'YA'                                                                                                            \n");
			sbSql.append(" AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'                                                                         \n");
			sbSql.append(" AND    NVL(A.OUTVAT_FLAG,'N') = 'Y'                                                                                                    	\n");
			sbSql.append(" AND    B.SCHOOL_YN = 'Y'                                                                                                             \n");
		} else if( GBN.equals("4"))
		{
			sbSql.append(" AND    TRANS_MU_CD = 'YA'                                                                                                            \n");
			sbSql.append(" AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'                                                                         \n");
			sbSql.append(" AND    NVL(A.OUTVAT_FLAG,'N') = 'N'                                                                                                    	\n");
			sbSql.append(" AND    B.SCHOOL_YN = 'Y'                                                                                                             \n");
		} else if( GBN.equals("5"))
		{
			sbSql.append(" AND    TRANS_MU_CD = 'YA'                                                                                                            \n");
			//sbSql.append(" AND    A.SUBINV_CODE LIKE 'A20%'                                                                                                     \n");
			sbSql.append(" AND    A.ITEM_CODE BETWEEN '060000000000' AND '069999999999'                                                                         \n");
		}
		sbSql.append(" GROUP BY A.TRANS_DEPT_ID, E.MU_NM, E.CC_NM, A.BUD_CLS, A.ACCTCD, C.ACCTNM6, D.VAT_CUSTGUBUN, A.BUDDEPT_ID                               	\n");
		sbSql.append(" )                                                                                                                                       	\n");
		sbSql.append(" GROUP BY TRANS_UPJANG, UPJANGNM, ACCTCD, ACCTNM6, BUDDEPT_ID                                                                            	\n");
		
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