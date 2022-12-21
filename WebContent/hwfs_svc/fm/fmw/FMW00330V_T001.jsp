<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 실적관리/실적관리
//■ 프로그램ID   : FMW00330V_T001.jsp
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
		String strITEM      	= nullToBlank(ds_Condput.getString(0, "ITEM"));
		
		//out 데이타
		DataSet ds_List;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());

    //내역조회
    sbSql.append("SELECT A.ITEM_CODE, B.ITEM_NAME \n");
    sbSql.append("     , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
    sbSql.append("     , B.ITEM_SIZE_BONG \n");
    sbSql.append("     , SUM(PRE_QTY) AS PRE_QTY \n");
    sbSql.append("     , SUM(PRE_QTY_BOX) AS PRE_QTY_BOX \n");
    sbSql.append("     , SUM(PRE_QTY_BONG) AS PRE_QTY_BONG \n");
    sbSql.append("     , SUM(PRE_AMOUNT) AS PRE_AMOUNT \n");
    sbSql.append("     , SUM(IN_QTY) AS IN_QTY \n");
    sbSql.append("     , SUM(IN_QTY_BOX) AS IN_QTY_BOX \n");
    sbSql.append("     , SUM(IN_QTY_BONG) AS IN_QTY_BONG \n");
    sbSql.append("     , SUM(IN_AMOUNT) AS IN_AMOUNT \n");
    sbSql.append("     , SUM(OUT_QTY) AS OUT_QTY \n");
    sbSql.append("     , SUM(OUT_QTY_BOX) AS OUT_QTY_BOX \n");
    sbSql.append("     , SUM(OUT_QTY_BONG) AS OUT_QTY_BONG \n");
    sbSql.append("     , SUM(OUT_AMOUNT) AS OUT_AMOUNT \n");
    sbSql.append("     , SUM(PRE_QTY) + SUM(IN_QTY) - SUM(OUT_QTY) AS ONHAND_QTY \n");
    sbSql.append("     , SUM(PRE_QTY_BOX) + SUM(IN_QTY_BOX) - SUM(OUT_QTY_BOX) AS ONHAND_QTY_BOX \n");
    sbSql.append("     , SUM(PRE_QTY_BONG) + SUM(IN_QTY_BONG) - SUM(OUT_QTY_BONG) AS ONHAND_QTY_BONG \n");
    sbSql.append("     , SUM(PRE_AMOUNT) + SUM(IN_AMOUNT) - SUM(OUT_AMOUNT) AS ONHAND_AMOUNT \n");
    sbSql.append("  FROM FMW_ITEM_V B, \n");
    sbSql.append("( \n");
    sbSql.append("SELECT A.ITEM_CODE \n");
    sbSql.append("     , SUM(A.TRANS_QTY * A.PHYSIC_GUBUN) AS PRE_QTY \n");
    sbSql.append("     , SUM(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1) * A.PHYSIC_GUBUN) AS PRE_QTY_BOX \n");
    sbSql.append("     , SUM(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1) * A.PHYSIC_GUBUN) AS PRE_QTY_BONG \n");
    sbSql.append("     , SUM(A.AVG_AMOUNT * A.PHYSIC_GUBUN) AS PRE_AMOUNT \n");
    sbSql.append("     , 0 AS IN_QTY \n");
    sbSql.append("     , 0 AS IN_QTY_BOX \n");
    sbSql.append("     , 0 AS IN_QTY_BONG \n");
    sbSql.append("     , 0 AS IN_AMOUNT \n");
    sbSql.append("     , 0 AS OUT_QTY \n");
    sbSql.append("     , 0 AS OUT_QTY_BOX \n");
    sbSql.append("     , 0 AS OUT_QTY_BONG \n");
    sbSql.append("     , 0 AS OUT_AMOUNT \n");
    sbSql.append("  FROM FMW_PO_TRANSACTION A \n");
    sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
    sbSql.append("   AND A.SUBINV_CODE = '" + strSUBINV_CODE + "' \n");
    sbSql.append("   AND A.TRANS_DATE < '" + strDATEF + "' \n");
    sbSql.append(" GROUP BY A.ITEM_CODE \n");
    sbSql.append(" --------- \n");
    sbSql.append(" UNION ALL \n");
    sbSql.append(" --------- \n");
    sbSql.append("SELECT A.ITEM_CODE \n");
    sbSql.append("     , 0 AS PRE_QTY \n");
    sbSql.append("     , 0 AS PRE_QTY_BOX \n");
    sbSql.append("     , 0 AS PRE_QTY_BONG \n");
    sbSql.append("     , 0 AS PRE_AMOUNT \n");
    sbSql.append("     , SUM(DECODE(A.PHYSIC_GUBUN, 1, A.TRANS_QTY, 0)) AS IN_QTY \n");
    sbSql.append("     , SUM(DECODE(A.PHYSIC_GUBUN, 1, SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1), 0)) AS IN_QTY_BOX \n");
    sbSql.append("     , SUM(DECODE(A.PHYSIC_GUBUN, 1, SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1), 0)) AS IN_QTY_BONG \n");
    sbSql.append("     , SUM(DECODE(A.PHYSIC_GUBUN, 1, A.AVG_AMOUNT, 0)) AS IN_AMOUNT \n");
    sbSql.append("     , SUM(DECODE(A.PHYSIC_GUBUN, 1, 0, A.TRANS_QTY)) AS OUT_QTY \n");
    sbSql.append("     , SUM(DECODE(A.PHYSIC_GUBUN, 1, 0, SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1))) AS OUT_QTY_BOX \n");
    sbSql.append("     , SUM(DECODE(A.PHYSIC_GUBUN, 1, 0, SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1))) AS OUT_QTY_BONG \n");
    sbSql.append("     , SUM(DECODE(A.PHYSIC_GUBUN, 1, 0, A.AVG_AMOUNT)) AS OUT_AMOUNT \n");
    sbSql.append("  FROM FMW_PO_TRANSACTION A \n");
    sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
    sbSql.append("   AND A.SUBINV_CODE = '" + strSUBINV_CODE + "' \n");
    sbSql.append("   AND A.TRANS_DATE BETWEEN '" + strDATEF + "' AND '" + strDATET + "' \n");
    sbSql.append(" GROUP BY A.ITEM_CODE \n");
    sbSql.append(") A \n");
    sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
    if (! strITEM.equals(""))
    	sbSql.append("   AND ((B.ITEM_CODE LIKE '%" + strITEM + "%') OR (B.ITEM_NAME LIKE '%" + strITEM + "%')) \n");
    sbSql.append(" GROUP BY A.ITEM_CODE, B.ITEM_NAME, B.TAX_CODE, B.ITEM_SIZE_BONG \n");
    sbSql.append(" ORDER BY A.ITEM_CODE \n");

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