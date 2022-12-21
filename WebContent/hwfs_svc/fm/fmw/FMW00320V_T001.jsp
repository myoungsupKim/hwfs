<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 실적관리/실적관리
//■ 프로그램ID   : FMW00320V_T001.jsp
//■ 프로그램명   : 상품 입출고 실적조회
//■ 작성일자     : 2011.02.09
//■ 작성자       : 박은규
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
		DataSet ds_Condput     	= in_dl.get("ds_Cond");
	
		String strUpjang 		  = nullToBlank(ds_Condput.getString(0, "UPJANG"));
		String strSUBINV_CODE	= nullToBlank(ds_Condput.getString(0, "SUBINV_CODE"));
		String strDATEF		    = nullToBlank(ds_Condput.getString(0, "DATEF"));
		String strDATET		    = nullToBlank(ds_Condput.getString(0, "DATET"));
		String strTRANS_TYPE 	= nullToBlank(ds_Condput.getString(0, "TRANS_TYPE"));
		String strITEM      	= nullToBlank(ds_Condput.getString(0, "ITEM"));
		
		//out 데이타
		DataSet ds_List;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());

    //내역조회
    sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS TRANS_DATE \n");
    sbSql.append("     , A.TRANS_TYPE \n");
    sbSql.append("     , (SELECT Z.CONTENTS FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FMW001' AND Z.CODE = A.TRANS_TYPE) AS TRANS_TYPE_NAME \n");
    sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME \n");
    sbSql.append("     , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
    sbSql.append("     , (A.AVG_PRICE * B.ITEM_SIZE_BONG) AS UNIT_PRICE_BOX \n");
    sbSql.append("     , A.AVG_PRICE AS UNIT_PRICE_BONG \n");
    sbSql.append("     , B.ITEM_SIZE_BONG \n");
    sbSql.append("     , A.TRANS_QTY * A.PHYSIC_GUBUN AS TRANS_QTY \n");
    sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1) * A.PHYSIC_GUBUN AS TRANS_QTY_BOX \n");
    sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1) * A.PHYSIC_GUBUN AS TRANS_QTY_BONG \n");
    sbSql.append("     , A.AVG_AMOUNT * A.PHYSIC_GUBUN AS UNIT_AMOUNT \n");
    sbSql.append("     , (SELECT Z.OTCUSTNM FROM FMW_OTCUST Z WHERE Z.OTCUSTCD = B.OTCUSTCD) AS CUSTNM \n");
    sbSql.append("     , (SELECT Z.HALL_NAME FROM FMW_HALL Z WHERE Z.HALL_CODE = A.HALL_CODE AND Z.UPJANG = A.UPJANG) AS HALL_NAME \n");
    sbSql.append("     , (A.SALE_PRICE * B.ITEM_SIZE_BONG) AS SALE_PRICE_BOX \n");
    sbSql.append("     , A.SALE_PRICE AS SALE_PRICE_BONG \n");
    sbSql.append("     , DECODE(B.TAX_CODE,100,ROUND(A.SALE_AMOUNT/1.1),A.SALE_AMOUNT) * A.PHYSIC_GUBUN AS SALE_AMOUNT_GONG \n");
    sbSql.append("     , DECODE(B.TAX_CODE,100,(A.SALE_AMOUNT -ROUND(A.SALE_AMOUNT/1.1)),0) * A.PHYSIC_GUBUN AS SALE_AMOUNT_VAT \n");
    sbSql.append("     , A.SALE_AMOUNT * A.PHYSIC_GUBUN AS SALE_AMOUNT \n");
    sbSql.append("     , A.TRANS_NUM \n");
    sbSql.append("     , A.REMARK \n");
    sbSql.append("  FROM FMW_PO_TRANSACTION A, FMW_ITEM_V B \n");
    sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
    sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
    sbSql.append("   AND A.SUBINV_CODE = '" + strSUBINV_CODE + "' \n");
    sbSql.append("   AND A.TRANS_DATE BETWEEN '" + strDATEF + "' AND '" + strDATET + "' \n");
    if (! strTRANS_TYPE.equals(""))
    	sbSql.append("   AND A.TRANS_TYPE = '" + strTRANS_TYPE + "' \n");
    if (! strITEM.equals(""))
    	sbSql.append("   AND ((B.ITEM_CODE LIKE '%" + strITEM + "%') OR (B.ITEM_NAME LIKE '%" + strITEM + "%')) \n");
    sbSql.append(" ORDER BY A.TRANS_DATE, A.TRANS_TYPE, A.ITEM_CODE \n");

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