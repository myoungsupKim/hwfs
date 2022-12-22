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
	
	//	var arg	="CENTER="		+ 	quote(cbo_Center.Value)
	//			+" GBN="		+	quote(cbo_item.Value)
	//			+" FROM="		+	quote(me_From.Value)
	//			+" TO="			+	quote(me_To.Value)
	//			+" g_CustCd="	+	quote(g_CustCd)
	//			+" ORDERBY="	+	quote(cbo_OrderBy.Value)
	//			+" TARGETGBN="	+	quote(cbo_Gbn.Value);
	
			String CENTER 		= nullToBlank(in_vl.getString("CENTER"));	// 센터	
			String FROM 		= nullToBlank(in_vl.getString("FROM"));		// 검색시작일
			String TO 			= nullToBlank(in_vl.getString("TO"));		// 검색종료일
			String GBN 			= nullToBlank(in_vl.getString("GBN"));		// 자재분류구분
			String g_CustCd		= nullToBlank(in_vl.getString("g_CustCd"));	// 글로벌
			String ORDERBY 		= nullToBlank(in_vl.getString("ORDERBY"));	// 정렬
			String TARGETGBN	= nullToBlank(in_vl.getString("TARGETGBN"));	// 구분(조회대상)
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
//=========================================================================================================================
		if( ORDERBY.equals("1") )	// 업장
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("		SELECT DISTINCT A.TRANS_UPJANG , C.UPJANGNM					\n");
			sbSql.append("		FROM   PO_TRANSACTION A, ST_UPJANG C						\n");
			sbSql.append("		WHERE  A.TRANS_UPJANG = C.UPJANG						\n");
			sbSql.append("		AND    A.TRANS_DATE BETWEEN '"+FROM+"' AND '"+TO+"'  --[검수일]			\n");
			sbSql.append("		AND    A.TRANS_TYPE = 'I001'							\n");
			sbSql.append("		AND    A.CUSTCD = "+g_CustCd+"         --[g_CustCd]				\n");
						if(!CENTER.equals(""))
						{
			sbSql.append("		AND    A.CENTER_CODE = "+CENTER+"    --[물류센터권역.CENTER_CODE, 전체도 가능]	\n");
						}
					if(GBN.equals("1"))
						{
			sbSql.append("		AND    A.ITEM_CODE LIKE '01%'							\n");
						}
						else if(GBN.equals("2"))
						{
			sbSql.append("		AND    A.ITEM_CODE BETWEEN '020000000000' AND '039999999999'			\n");
						}
						else if(GBN.equals("4"))
						{
			sbSql.append("		AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'			\n");
						} 
						else if(GBN.equals("6"))
						{
			sbSql.append("		AND    A.ITEM_CODE LIKE '06%'							\n");
						}
						if(TARGETGBN.equals("1")){
			sbSql.append("		AND    A.TRANS_MU_CD <> 'YA'							\n");
			//sbSql.append("		AND    A.ITEM_CODE BETWEEN '020000000000' AND '059999999999'			\n");
						}else if(TARGETGBN.equals("2")){
			sbSql.append("		AND    A.TRANS_MU_CD = 'YA'							\n");
			sbSql.append("		AND    C.SCHOOL_YN = 'N'							\n");
			sbSql.append("		AND    (A.OUTVAT_FLAG = 'N' OR A.OUTVAT_FLAG IS NULL)				\n");
			//sbSql.append("		AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'			\n");
						}else if(TARGETGBN.equals("3")){		
			sbSql.append("		AND    A.TRANS_MU_CD = 'YA'							\n");
			sbSql.append("		AND    A.SUBINV_CODE LIKE 'E20%'						\n");
			//sbSql.append("		AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'			\n");
			sbSql.append("		AND    (A.OUTVAT_FLAG = 'Y' OR A.OUTVAT_FLAG IS NULL)				\n");
			sbSql.append("		AND    C.SCHOOL_YN = 'Y'							\n");
						}else if(TARGETGBN.equals("4")){
			sbSql.append("		AND    A.TRANS_MU_CD = 'YA'							\n");
			sbSql.append("		AND    A.SUBINV_CODE NOT LIKE 'E20%'						\n");
			//sbSql.append("		AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'			\n");
			sbSql.append("		AND    A.OUTVAT_FLAG = 'N'							\n");
			sbSql.append("		AND    C.SCHOOL_YN = 'Y'							\n");
						}else if(TARGETGBN.equals("5")){
			sbSql.append("		AND    A.TRANS_MU_CD = 'YA'							\n");
			sbSql.append("		AND    A.SUBINV_CODE LIKE 'A20%'						\n");
						}
			sbSql.append("		ORDER BY 2									\n");
		}
		else	// equals("2") 자재 
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT DISTINCT A.ITEM_CODE TRANS_UPJANG , A.ITEM_NAME || '(' || A.ITEM_SIZE || ')' UPJANGNM  \n"); 
			sbSql.append("FROM   PO_TRANSACTION A, ST_UPJANG C                                                         \n"); 
			sbSql.append("WHERE  A.TRANS_UPJANG = C.UPJANG                                                             \n"); 
			sbSql.append("AND    A.TRANS_DATE BETWEEN '"+FROM+"' AND '"+TO+"'  --[검수일]                              \n"); 
			sbSql.append("AND    A.TRANS_TYPE = 'I001'                                                                 \n"); 
			sbSql.append("AND    A.CUSTCD = "+g_CustCd+"         --[g_CustCd]                                          \n"); 
			if(!CENTER.equals(""))                                                                             
			{                                                                                                  
			sbSql.append("AND    A.CENTER_CODE = "+CENTER+"    --[물류센터권역.CENTER_CODE, 전체도 가능]               \n"); 
			}                                                                                                  
			if(GBN.equals("1"))                                                                                
			{                                                                                                  
			sbSql.append("AND    A.ITEM_CODE LIKE '01%'                                                                \n"); 
			}                                                                                                  
			else if(GBN.equals("2"))                                                                           
			{                                                                                                  
			sbSql.append("AND    A.ITEM_CODE BETWEEN '020000000000' AND '039999999999'                                 \n"); 
			}                                                                                                 
			else if(GBN.equals("4"))                                                                           
			{                                                                                                  
			sbSql.append("AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'                                 \n"); 
			}                                                                                                  
			else if(GBN.equals("6"))                                                                           
			{                                                                                                  
			sbSql.append("AND    A.ITEM_CODE LIKE '06%'                                                                \n"); 
			}                                                                                                  
			if(TARGETGBN.equals("1")){                                                                         
			sbSql.append("AND    A.TRANS_MU_CD <> 'YA'                                                                 \n"); 
			//sbSql.append("AND    A.ITEM_CODE BETWEEN '020000000000' AND '059999999999'                                 \n"); 
			}else if(TARGETGBN.equals("2")){                                                                   
			sbSql.append("AND    A.TRANS_MU_CD = 'YA'                                                                  \n"); 
			sbSql.append("AND    C.SCHOOL_YN = 'N'                                                                     \n"); 
			sbSql.append("AND    (A.OUTVAT_FLAG = 'N' OR A.OUTVAT_FLAG IS NULL)                                        \n"); 
			//sbSql.append("AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'                                 \n"); 
			}else if(TARGETGBN.equals("3")){                                                                   
			sbSql.append("AND    A.TRANS_MU_CD = 'YA'                                                                  \n"); 
			sbSql.append("AND    A.SUBINV_CODE LIKE 'E20%'                                                             \n"); 
			//sbSql.append("AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'                                 \n"); 
			sbSql.append("AND    (A.OUTVAT_FLAG = 'Y' OR A.OUTVAT_FLAG IS NULL)                                        \n"); 
			sbSql.append("AND    C.SCHOOL_YN = 'Y'                                                                     \n"); 
			}else if(TARGETGBN.equals("4")){                                                                   
			sbSql.append("AND    A.TRANS_MU_CD = 'YA'                                                                  \n"); 
			sbSql.append("AND    A.SUBINV_CODE NOT LIKE 'E20%'                                                         \n"); 
			//sbSql.append("AND    A.ITEM_CODE BETWEEN '040000000000' AND '059999999999'                                 \n"); 
			sbSql.append("AND    A.OUTVAT_FLAG = 'N'                                                                   \n"); 
			sbSql.append("AND    C.SCHOOL_YN = 'Y'                                                                     \n"); 
			}else if(TARGETGBN.equals("5")){                                                                   
			sbSql.append("AND    A.TRANS_MU_CD = 'YA'                                                                  \n"); 
			sbSql.append("AND    A.SUBINV_CODE LIKE 'A20%'                                                             \n"); 
			}  
			sbSql.append("ORDER BY 2										   \n"); 
		}
	
//=========================================================================================================================	
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_Target = this.makeDataSet(rs,"ds_Target");
		out_dl.add(ds_Target);

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