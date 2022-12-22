<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
	
	//	var arg	="CENTER="		+ 	quote(cbo_Center.Value)
	//			+" GBN="		+	quote(cbo_item.Value)
	//			+" FROM="		+	quote(me_From.Value)
	//			+" TO="			+	quote(me_To.Value)
	//			+" g_CustCd="	+	quote(g_CustCd)
	//			+" ORDERBY="	+	quote(cbo_OrderBy.Value)
	//			+" TARGETGBN="	+	quote(cbo_Gbn.Value);
	
	//FROM 		 검색시작일    
	//TO 		 검색종
	//GBN	 자재분류구분
	//g_CustCd   글로벌        
	//ORDERBY	 정렬          
	//TARGETGBN  구분(조회대상)
	//TARGET 
	
			String CENTER 		= nullToBlank(in_vl.getString("CENTER"));	// 센터	
			String FROM 		= nullToBlank(in_vl.getString("FROM"));		// 검색시작일
			String TO 			= nullToBlank(in_vl.getString("TO"));		// 검색종료일
			String GBN 			= nullToBlank(in_vl.getString("GBN"));		// 자재분류구분
			String g_CustCd		= nullToBlank(in_vl.getString("g_CustCd"));	// 글로벌
			String ORDERBY 		= nullToBlank(in_vl.getString("ORDERBY"));	// 정렬
			String TARGETGBN	= nullToBlank(in_vl.getString("TARGETGBN"));	// 구분(조회대상)
			String TARGET		= nullToBlank(in_vl.getString("TARGET"));	
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
			sbSql.delete(0, sbSql.length());
			sbSql.append(" SELECT /*+ INDEX(A PO_TRANSACTION_PT_I6) */ \n");
			sbSql.append("        A.TRANS_DATE, B.NEED_DATE, A.TRANS_UPJANG, REPLACE(C.UPJANGNM,'단체급식 ') || ' ' || REPLACE(D.SUBINV_NAME,'식자재_') UPJANGNM \n");
			sbSql.append("      , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, DECODE(A.TAX_CODE,'100','과세','210','면세','220','영세') TAX \n");
			sbSql.append("      , DECODE(I.SUBINV_CODE, NULL, TRANS_UPRICE, DECODE(A.OUTVAT_FLAG||A.TAX_CODE, 'Y100', ROUND(TRANS_UPRICE*1.1), TRANS_UPRICE)) TRANS_UPRICE \n");
			sbSql.append("      , SUM(TRANS_QTY) TRANS_QTY \n");
			sbSql.append("      , SUM(ROUND(DECODE(I.SUBINV_CODE, NULL, TRANS_UPRICE, DECODE(A.OUTVAT_FLAG||A.TAX_CODE, 'Y100', ROUND(TRANS_UPRICE*1.1), TRANS_UPRICE))*A.TRANS_QTY)) TRANS_AMT \n");
			sbSql.append("      , H.TYPE_NAME, TO_CHAR(A.TRANS_UPJANG) AS UPJANG, A.SUBINV_CODE	\n");
			sbSql.append("   FROM PO_TRANSACTION A, PO_PO B, ST_UPJANG C, PO_SUBINVENTORY D, PO_TYPE H, ST_CUST I	\n");
			sbSql.append("  WHERE A.SOURCE_ID = B.PO_ID	\n");
			sbSql.append("    AND A.TRANS_UPJANG = C.UPJANG	\n");
			sbSql.append("    AND A.SUBINV_CODE = D.SUBINV_CODE(+)	\n");
			sbSql.append("    AND A.PO_TYPE = H.PO_TYPE	\n");
			sbSql.append("    AND A.CUSTCD  = I.CUSTCD	\n");
			sbSql.append("    AND A.TRANS_DATE BETWEEN '"+FROM+"' AND '"+TO+"'  --[검수일]	\n");
			sbSql.append("    AND A.TRANS_TYPE = 'I001'	\n");
			sbSql.append("    AND A.CUSTCD = "+g_CustCd+"         --[g_CustCd]	\n");
			if(!CENTER.equals(""))	
			{
			sbSql.append(" AND    A.CENTER_CODE = "+CENTER+"    --[물류센터권역.CENTER_CODE, 전체도 가능]	\n");
			}
			// if 콤보3:조회대상 <> '전체' &&  콤보2:구분 == '업장'
			if(!TARGETGBN.equals("") && ORDERBY.equals("1"))
			{
			sbSql.append(" AND    A.TRANS_UPJANG like '%"+TARGET+"%' --[콤보4:대상]	\n");  
			}
			if(GBN.equals("1"))
			{
			sbSql.append(" AND    A.ITEM_CODE LIKE '01%'	\n");
			}
			else if(GBN.equals("2"))
			{
			sbSql.append(" AND    A.ITEM_CODE BETWEEN '020000000000' AND '039999999999'	\n");
			}
			else if(GBN.equals("4"))
			{
			sbSql.append(" AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999' \n");
			}
			else if(GBN.equals("6"))
			{
			sbSql.append(" AND    A.ITEM_CODE LIKE '06%'	\n");
			}
			if(TARGETGBN.equals("1")){
			sbSql.append(" AND    A.TRANS_MU_CD <> 'YA'	\n");
			sbSql.append(" AND    A.SUBINV_CODE NOT LIKE 'S10%'                                                                                                   	\n");
			//sbSql.append(" AND    A.ITEM_CODE BETWEEN '020000000000' AND '059999999999'	\n");
			}else if(TARGETGBN.equals("2")){
			sbSql.append(" AND    A.TRANS_MU_CD = 'YA'	\n");
			sbSql.append(" AND    A.SUBINV_CODE NOT LIKE 'S10%'                                                                                                   	\n");
			sbSql.append(" AND    C.SCHOOL_YN = 'N'		\n");
			sbSql.append(" AND    NVL(A.OUTVAT_FLAG,'N') = 'N'	\n");
			//sbSql.append(" AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'	\n");
			}else if(TARGETGBN.equals("3")){
			sbSql.append(" AND    A.TRANS_MU_CD = 'YA'	\n");
			sbSql.append(" AND    A.SUBINV_CODE NOT LIKE 'S10%'                                                                                                   	\n");
			sbSql.append(" AND    C.SCHOOL_YN = 'Y'	\n");
			sbSql.append(" AND    NVL(A.OUTVAT_FLAG,'Y') = 'Y'	\n");
			//sbSql.append(" AND    A.SUBINV_CODE LIKE 'E20%'	\n");
			//sbSql.append(" AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'	\n");
			}else if(TARGETGBN.equals("4")){
			sbSql.append(" AND    A.TRANS_MU_CD = 'YA'	\n");
			sbSql.append(" AND    A.SUBINV_CODE NOT LIKE 'S10%'                                                                                                   	\n");
			sbSql.append(" AND    C.SCHOOL_YN = 'Y'		\n");
			sbSql.append(" AND    NVL(A.OUTVAT_FLAG,'N') = 'N'	\n");
			//sbSql.append(" AND    A.SUBINV_CODE NOT LIKE 'E20%'	\n");
			//sbSql.append(" AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'	\n");
			}else if(TARGETGBN.equals("5")){
			sbSql.append(" AND    A.TRANS_MU_CD = 'YA'	\n");
			sbSql.append(" AND    A.SUBINV_CODE NOT LIKE 'S10%'                                                                                                   	\n");
			sbSql.append(" AND    A.SUBINV_CODE LIKE 'A20%'	\n");
			}else if(TARGETGBN.equals("6")){
			sbSql.append(" AND    A.TRANS_MU_CD = 'YA'	\n");
			sbSql.append(" AND    A.SUBINV_CODE LIKE 'S10%'                                                                                                   	\n");
			}
			if( ORDERBY.equals("1") )	// 업장
				sbSql.append(" GROUP BY A.TRANS_UPJANG, A.TRANS_DATE, B.NEED_DATE, A.SUBINV_CODE, C.UPJANGNM, D.SUBINV_NAME, A.ITEM_CODE, A.ITEM_NAME \n");
			else if( ORDERBY.equals("2") )	// 자재
				sbSql.append(" GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.TRANS_UPJANG, A.TRANS_DATE, B.NEED_DATE, A.SUBINV_CODE, C.UPJANGNM, D.SUBINV_NAME	\n");
			else	// 검수일
				sbSql.append(" GROUP BY A.TRANS_DATE, B.NEED_DATE, A.TRANS_UPJANG, A.SUBINV_CODE, C.UPJANGNM, D.SUBINV_NAME, A.ITEM_CODE, A.ITEM_NAME \n");
			sbSql.append("     ,A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, TRANS_UPRICE, H.TYPE_NAME, A.OUTVAT_FLAG, I.SUBINV_CODE \n");
	
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