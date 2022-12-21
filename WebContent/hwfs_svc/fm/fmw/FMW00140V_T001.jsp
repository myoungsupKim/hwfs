<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 취급상품 조회
//■ 프로그램ID   : FMW00140V_T001.jsp
//■ 프로그램명   : 취급상품 조회
//■ 작성일자     : 2011.02.21
//■ 작성자       : 문형광
//■ 이력관리     :  
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//입력 데이타
		DataSet ds_Cond     	= in_dl.get("ds_Cond");
	
		String strUpjang 		  = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String strOtcustcd        = nullToBlank(ds_Cond.getString(0, "OTCUSTCD"));
		String strClassCodeS      = nullToBlank(ds_Cond.getString(0, "CLASS_CODE_S"));
		String strItemCode        = nullToBlank(ds_Cond.getString(0, "ITEM_CODE"));
		String strSDATE		      = nullToBlank(ds_Cond.getString(0, "SDATE"));
		
		//out 데이타
		DataSet ds_List;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); 	//내역조회			
        sbSql.append("SELECT A.ITEM_CLASS3                                                                     \n");
        sbSql.append("     , A.OTCUSTCD                                                                        \n");
        sbSql.append("     , B.OTCUSTNM                                                                        \n");
        sbSql.append("     , A.ITEM_CODE                                                                       \n");
        sbSql.append("     , A.ITEM_NAME||';'||A.ITEM_SIZE AS ITEM_NAME                                                                       \n");
        sbSql.append("     , A.ITEM_SIZE_BONG                                                                  \n");
        sbSql.append("     , A.ITEM_SIZE_KG                                                                    \n");
        sbSql.append("     , DECODE(A.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE                   \n");
        sbSql.append("     , ROUND(A.ITEM_SIZE_BOX * A.ITEM_SIZE_BONG * NVL(A.SALE_PRICE_BONG, 0)) AS BOX_PRICE_S \n");
        sbSql.append("     , NVL(A.SALE_PRICE_BONG, 0) AS BONG_PRICE_S                                         \n");
        sbSql.append("     , ROUND(A.ITEM_SIZE_BOX * A.ITEM_SIZE_BONG * NVL(A.UNIT_PRICE_BONG, 0)) AS BOX_PRICE_U   \n");
        sbSql.append("     , NVL(A.UNIT_PRICE_BONG, 0) AS BONG_PRICE_U                                              \n");
        sbSql.append("     , NVL(A.USE_YN, 'N') AS USE_YN                                                      \n");
        sbSql.append("  FROM FMW_ITEM_V A, FMW_OTCUST B                                                                    \n");
        sbSql.append(" WHERE A.OTCUSTCD = B.OTCUSTCD                                                           \n");
        if (! strOtcustcd.equals("0000"))
        {
            sbSql.append("   AND A.UPJANG IN ('0','" + strUpjang + "') \n");
            if (! strOtcustcd.equals(""))
            	sbSql.append("   AND A.OTCUSTCD = '" + strOtcustcd + "' \n");
        }
        else  //매입 업체가 한화호텔&리조트면 모든 등록 상품을 보여 준다.
        {
        	if (! strOtcustcd.equals(""))
        		sbSql.append("   AND A.OTCUSTCD = '" + strOtcustcd + "' \n");	
        }        
        if (! strClassCodeS.equals(""))
        {
        	sbSql.append("   AND SUBSTR(A.ITEM_CLASS3,1,6) = SUBSTR('" + strClassCodeS + "',1,6)     \n");        	
        }
        if (! strItemCode.equals(""))
        {
        	sbSql.append("   AND A.ITEM_CODE = '" + strItemCode + "'           \n");        	
        }
        sbSql.append("  ORDER BY A.ITEM_CLASS3, A.OTCUSTCD, A.ITEM_CODE \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs, "ds_List");

		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		logger.debug(ex.getMessage(), ex);
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}	
	}
	proc_output(response,out,out_vl,out_dl);
%>