<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체단가견적제출
■ 프로그램ID   : FSV00370E_T002.jsp
■ 프로그램명   : 협력업체단가견적제출 조회
■ 작성일자     : 2012.07.20
■ 작성자       : 문형광
■ 이력관리     : 2012.07.20
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//입력 데이타
		DataSet ds_Cond     	 = in_dl.get("ds_Cond");
	
		
		String vCENTER_CODE    = nullToBlank(ds_Cond.getString(0, "CENTER_CODE"));
		String vCUSTCD         = nullToBlank(ds_Cond.getString(0, "CUSTCD")); 
		String vESTIMATE_START = nullToBlank(ds_Cond.getString(0, "ESTIMATE_START"));
		String vESTIMATE_ID    = nullToBlank(ds_Cond.getString(0, "ESTIMATE_ID"));
		
		//IRIS 접속
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //클리어
System.out.println(vESTIMATE_ID);
	    if (vESTIMATE_ID.equals("전체")) 
	    {
	    	sbSql.append("SELECT A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM                                            	\n");
	        sbSql.append("     , DECODE(C.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE                      				\n");
	        sbSql.append("     , C.KEEPING_TYPE												                      				\n");
	        sbSql.append("     , TRIM('신규') AS ESTIMATE_STATUS                                                                       \n");
	        sbSql.append("     , TO_CHAR(TO_DATE(B.CONTRACT_START,'YYYY-MM-DD'),'YYYY-MM-DD') AS CONTRACT_START     			\n");
	        sbSql.append("     , TO_CHAR(TO_DATE(B.CONTRACT_END,'YYYY-MM-DD'),'YYYY-MM-DD') AS CONTRACT_END          			\n");
	        sbSql.append("     , B.CONTRACT_PRICE                                                                   			\n");
	        sbSql.append("     , 0 AS ESTIMATE_PRICE                                                                			\n");
	        sbSql.append("     , 0 AS CONTRACT_RATE                                                                 			\n");
	        sbSql.append("  FROM PO_CUSTOM_ITEM A                                                                  	 			\n");
	        sbSql.append("     , (SELECT X.ITEM_CODE, X.CONTRACT_START, X.CONTRACT_END, X.CONTRACT_PRICE            			\n");
	        sbSql.append("         FROM PO_CONTRACT_F X                                                             			\n");
	        sbSql.append("            , (SELECT Z.CENTER_CODE, Z.CUSTCD, Z.ITEM_CODE, MAX(Z.CONTRACT_START) AS CONTRACT_START   \n");
	        sbSql.append("                 FROM PO_CONTRACT_F Z                                                     			\n");
	        sbSql.append("                WHERE Z.CENTER_CODE = " + vCENTER_CODE + "                                      		\n");
	        sbSql.append("                  AND Z.CUSTCD = " + vCUSTCD + "                                                		\n");
	        sbSql.append("                  AND Z.ITEM_CODE > ' '                                                            	\n");
	        sbSql.append("                  AND Z.CONTRACT_START < '" + vESTIMATE_START + "'                              		\n");
	        sbSql.append("                  AND Z.USE_YN = 'Y'                                            			        	\n");
	        sbSql.append("                GROUP BY Z.CENTER_CODE, Z.CUSTCD, Z.ITEM_CODE) Y                          			\n");
	        sbSql.append("        WHERE X.CENTER_CODE = Y.CENTER_CODE                                               			\n");
	        sbSql.append("          AND X.CUSTCD = Y.CUSTCD                                                         			\n");
	        sbSql.append("          AND X.ITEM_CODE = Y.ITEM_CODE                                                   			\n");
	        sbSql.append("          AND X.CONTRACT_START = Y.CONTRACT_START                                         			\n");
	        sbSql.append("          AND X.USE_YN = 'Y') B                                                           			\n");
	        sbSql.append("     , PO_ITEM_MST C                                                                      			\n");
	        sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                                       			\n");
	        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE                                                          			\n");
	        sbSql.append("   AND A.CENTER_UPJANG = " + vCENTER_CODE + "                                            				\n");
	        sbSql.append("   AND A.CUSTCD = " + vCUSTCD + "                                                               		\n");
	        sbSql.append("   AND A.USE_TYPE = '01'               		                                                    	\n");
	        sbSql.append(" ORDER BY A.ITEM_CODE                                                                                 \n");
	    }
	    else  
	    {
	    	sbSql.append("SELECT A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM                                            							\n");
	        sbSql.append("     , DECODE(C.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE                              								\n");
	        sbSql.append("     , C.KEEPING_TYPE												                      										\n");
	        sbSql.append("     , TRIM(A.ESTIMATE_STATUS) AS ESTIMATE_STATUS                                                                      							\n");
	        sbSql.append("     , TO_CHAR(TO_DATE(B.CONTRACT_START,'YYYY-MM-DD'),'YYYY-MM-DD') AS CONTRACT_START             							\n");
	        sbSql.append("     , TO_CHAR(TO_DATE(B.CONTRACT_END,'YYYY-MM-DD'),'YYYY-MM-DD') AS CONTRACT_END                 							\n");
	        sbSql.append("     , B.CONTRACT_PRICE                                                                           							\n");
	        sbSql.append("     , A.ESTIMATE_PRICE  					                                                        							\n");
	        sbSql.append("     , DECODE(NVL(B.CONTRACT_PRICE,0),0,0,ROUND(((A.ESTIMATE_PRICE/B.CONTRACT_PRICE)-1)*100,1)) AS CONTRACT_RATE  			\n");
	        sbSql.append("  FROM (SELECT Y.ITEM_CODE, Z.ESTIMATE_STATUS, Y.ESTIMATE_PRICE, Y.CONTRACT_PRICE_S                               			\n");
	        sbSql.append("          FROM PO_ESTIMATE_MASTER Z, PO_ESTIMATE_DETAIL Y                                                         			\n");
	        sbSql.append("         WHERE Z.EST_ID = Y.EST_ID                                                                                			\n");
	        sbSql.append("           AND Z.CENTER_CODE = " + vCENTER_CODE + "                                                                                 			\n");
	        sbSql.append("           AND Z.CUSTCD = " + vCUSTCD + "                                                                                      			\n");
	        sbSql.append("           AND Z.ESTIMATE_ID = '" + vESTIMATE_ID + "'                                                                                 			\n");
	        sbSql.append("           AND Z.USE_YN = 'Y') A                                                                                  			\n");
	        sbSql.append("     , (SELECT Z.ITEM_CODE, Z.CONTRACT_START, Z.CONTRACT_END, Z.CONTRACT_PRICE                                    			\n");
	        sbSql.append("          FROM PO_CONTRACT_F Z                                                                                    			\n");
	        sbSql.append("         WHERE Z.CENTER_CODE = " + vCENTER_CODE + "                                                                                  			\n");
	        sbSql.append("           AND Z.CUSTCD = " + vCUSTCD + "                                                                                       			\n");
	        sbSql.append("           AND Z.ITEM_CODE > ' '                                                                                  			\n");
	        sbSql.append("           AND TO_CHAR(TO_DATE('" + vESTIMATE_START + "', 'YYYYMMDD') -1, 'YYYYMMDD') BETWEEN Z.CONTRACT_START AND NVL(Z.CONTRACT_END,'99999999') 	\n");
	        sbSql.append("           AND Z.USE_YN = 'Y') B                                                                                  			\n");
	        sbSql.append("     , PO_ITEM_MST C                                                                                              			\n");
	        sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                                                                  			\n");
	        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE                                                                                  			\n");
	        sbSql.append(" ORDER BY A.ITEM_CODE                                                                                             			\n");
	    }
out_vl.add("fa_Sql", sbSql.toString());	
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_list = this.makeDataSet(rs, "ds_list"); 
		//FileLog.println("d:\\ds_list.txt", ds_list);
		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally
	{
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
	}
	proc_output(response,out,out_vl,out_dl);
%>