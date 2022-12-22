
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//입력 데이타
		DataSet ds_input     	= in_dl.get("ds_input");
	
		
		String strCENTER_CODE   = nullToBlank(ds_input.getString(0, "CENTER_CODE"));
		String strCUSTCD        = nullToBlank(ds_input.getString(0, "CUSTCD"));
		String strCONTRACT_DATE = nullToBlank(ds_input.getString(0, "CONTRACT_DATE")); 
		String strESTIMATE_DATE = nullToBlank(ds_input.getString(0, "ESTIMATE_DATE"));
		String strBANGI_GUBUN   = nullToBlank(ds_input.getString(0, "BANGI_GUBUN"));
	
		String strESTIMATE_START = "";
		String strESTIMATE_END = "";
		String strESTIMATE_ID = "";
		
	
		//상반기
		if(strBANGI_GUBUN.equals("01"))
		{
			 strESTIMATE_START =  "'" + strESTIMATE_DATE.substring(0,6) + "01" + "'" ;
			 strESTIMATE_END   =  "'" + strESTIMATE_DATE.substring(0,6) + "15" + "'";
			 strESTIMATE_ID    =  "'" + strCUSTCD + "-" + strESTIMATE_DATE.substring(0,6) + "-" +"001" + "'";
		}
		//하반기
		if(strBANGI_GUBUN.equals("16"))
		{
			 strESTIMATE_START =  "'" + strESTIMATE_DATE.substring(0,6) + "16" + "'" ;
			 strESTIMATE_END = "TO_CHAR(LAST_DAY(TO_DATE(" + strESTIMATE_START + ",'YYYYMMDD')),'YYYYMMDD')" ; 
			 strESTIMATE_ID =  "'" + strCUSTCD + "-" + strESTIMATE_DATE.substring(0,6) + "-" +"002" + "'" ;
		}
		
	
		
		//IRIS 접속
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();
	
	

		//out 데이타
		DataSet ds_list;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //클리어



		
		sbSql.append("\n SELECT A.ITEM_CODE  \n");
		sbSql.append("     , D.ITEM_NAME  \n");
		sbSql.append("     , D.PO_UOM  \n");
		sbSql.append("     , D.ITEM_SIZE  \n");
		sbSql.append("     , DECODE(D.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE  --과면세  \n");
		sbSql.append("     , D.KEEPING_TYPE --보관방법  \n");
		sbSql.append("     , D.MAKER        --제조원  \n");
		sbSql.append("     , D.ORIGIN_TYPE  --원산지  \n");
		sbSql.append("     , NVL(B.CONTRACT_PRICE,0) CONTRACT_PRICE  \n");
		sbSql.append("     , NVL(C.ESTIMATE_PRICE,0) ESTIMATE_PRICE  \n");
		sbSql.append("     , NVL(DECODE(NVL(B.CONTRACT_PRICE,0),0,0,ROUND(((C.ESTIMATE_PRICE/B.CONTRACT_PRICE)-1)*100,1)),0) AS CHANGE_RATE \n");
		sbSql.append("     , DECODE(C.ESTIMATE_PRICE,NULL,'I','S') AS FLAG \n");
		sbSql.append("     , '"+ strCENTER_CODE    +"' AS CENTER_CODE \n");
		sbSql.append("     , '"+ strCUSTCD	       +"' AS CUSTCD \n");
		sbSql.append("     , "+ strESTIMATE_START +" AS ESTIMATE_START \n");
		sbSql.append("     , "+ strESTIMATE_END   +" AS ESTIMATE_END \n");
		sbSql.append("     , "+ strESTIMATE_ID    +" AS ESTIMATE_ID \n");
		sbSql.append("  FROM  \n");
		sbSql.append("       (  \n");
		sbSql.append("        SELECT ITEM_CODE  \n");
		sbSql.append("          FROM PO_CUSTOM_ITEM  \n");
		sbSql.append("         WHERE CENTER_UPJANG = '" + strCENTER_CODE + "'  \n");
		sbSql.append("           AND CUSTCD = '"+ strCUSTCD +"'  \n");
		sbSql.append("           AND USE_TYPE = '01'  \n");
		sbSql.append("       ) A  \n");
		sbSql.append("     , (  \n");
		sbSql.append("       SELECT ITEM_CODE, CONTRACT_PRICE  \n");
		sbSql.append("         FROM PO_CONTRACT_F  \n");
		sbSql.append("        WHERE CENTER_CODE = '" + strCENTER_CODE + "'  \n");
		sbSql.append("          AND CUSTCD = '" + strCUSTCD + "'  \n");
		sbSql.append("          AND '"+ strCONTRACT_DATE + "' BETWEEN CONTRACT_START AND NVL(CONTRACT_END,'99999999')  \n");
		sbSql.append("       ) B  \n");
		sbSql.append("    ,  (  \n");
		sbSql.append("       SELECT ITEM_CODE, ESTIMATE_PRICE  \n");
		sbSql.append("         FROM PO_ESTIMATE_F  \n");
		sbSql.append("        WHERE CENTER_CODE = '" + strCENTER_CODE + "'  \n");
		sbSql.append("          AND CUSTCD = '" + strCUSTCD + "'  \n");
		sbSql.append("          AND '"+ strESTIMATE_DATE + "' BETWEEN ESTIMATE_START AND ESTIMATE_END  \n");
		sbSql.append("       ) C  \n");
		sbSql.append("     , PO_ITEM_MST D  \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+)  \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+)  \n");
		sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE  \n");
		

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_list = this.makeDataSet(rs, "ds_list"); //ds_list
		
		//FileLog.println("d:\\ds_list.txt", ds_list);


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