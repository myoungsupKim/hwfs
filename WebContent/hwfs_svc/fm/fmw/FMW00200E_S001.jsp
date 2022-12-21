<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 도소매관리/판매내역 일괄처리
//■ 프로그램ID   : FMW00200E_S001.jsp
//■ 프로그램명   : 판매내역 일괄처리
//■ 작성일자     : 2010.01.04
//■ 작성자       : 맹수영
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
		DataSet ds_input     	= in_dl.get("ds_in");
	
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strSUBINV_CODE	= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String strHALL_CODE 	= nullToBlank(ds_input.getString(0, "HALL_CODE"));
		String strDATE		    = nullToBlank(ds_input.getString(0, "DATE"));
		String strGUBUN		    = nullToBlank(ds_input.getString(0, "GUBUN"));
		String strTRANS_NUM		= nullToBlank(ds_input.getString(0, "TRANS_NUM"));
		//String strOTCUSTCD   = nullToBlank(in_vl.getString("g_OTCUSTCD"));
		//String strUPJANG  = nullToBlank(in_vl.getString("g_Upjang"));
		
		//out 데이타
		DataSet ds_cond1;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
		
		
	 
			
		
        sbSql.append("SELECT A.ITEM_CODE ITEM_CODE, A.TRANS_NUM, A.TRANS_ID TRANS_ID, '1' GUBUN,TRANS_TYPE,                                                                                                                                    \n");
        sbSql.append("       A.ITEM_NAME ITEM_NAME, B.ITEM_SIZE,  A.UPJANG,                                                                                                                                                          \n");
        sbSql.append("       (SELECT OTCUSTNM FROM FMW_OTCUST WHERE OTCUSTCD = B.OTCUSTCD) OTCUSTNM,                                                                                                                                                         \n");
        sbSql.append("       DECODE(B.TAX_CODE,'100','과세','210','면세','면세') TAX_CODE,                                                                                                                                  \n");
        //sbSql.append("       SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1)  AMOUNT_BOX,                                                      \n");
        //sbSql.append("       SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1)  AMOUNT_BONG,                                                       \n");
        sbSql.append("       DECODE(TRANS_TYPE,'O001',SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1),-1*SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1))  AMOUNT_BOX, \n");
        sbSql.append("       DECODE(TRANS_TYPE,'O001',SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1),-1*SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1))  AMOUNT_BONG, \n");        
        sbSql.append("       A.TRANS_PRICE TRANS_PRICE,                                                                                                                                                                 \n");
        sbSql.append("       ABS(DECODE(B.TAX_CODE,100,ROUND(A.SALE_AMOUNT/1.1),A.SALE_AMOUNT)) AMT,                                                                                                                           \n");
        sbSql.append("       ABS(DECODE(B.TAX_CODE,100,(A.SALE_AMOUNT -ROUND(A.SALE_AMOUNT/1.1)),0)) VAT,                                                                                                                      \n");
        sbSql.append("       A.SALE_AMOUNT SUM,                                                                                                                                                                         \n");
        sbSql.append("       A.SALE_PRICE PRICE_BONG,                                                                                                                     \n");
        sbSql.append("       (A.SALE_PRICE * B.ITEM_SIZE_BONG) PRICE_BOX,                                                                                                                                                                        \n");        
        sbSql.append("       A.HALL_CODE HALL_CODE, B.ITEM_SIZE_BONG ITEM_SIZE_BONG,                                                                                                                                    \n");
        //조회시에 입력당시의 재고 수량을 확인하기 위해서 현재 조회된 수량을 재고에 더해주기로 함
        //sbSql.append("       SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,(NVL(C.TRANS_QTY,0) + NVL(D.ONHAND_QTY,0) + NVL(A.TRANS_QTY,0))),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,(NVL(C.TRANS_QTY,0) + NVL(D.ONHAND_QTY,0) + NVL(A.TRANS_QTY,0))),',')-1) INV_BOX, \n");
        //sbSql.append("       SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,(NVL(C.TRANS_QTY,0) + NVL(D.ONHAND_QTY,0) + NVL(A.TRANS_QTY,0))),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,(NVL(C.TRANS_QTY,0) + NVL(D.ONHAND_QTY,0) + NVL(A.TRANS_QTY,0))),',')+1) INV_BONG \n");
        sbSql.append("       SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,(NVL(C.TRANS_QTY,0) + NVL(A.TRANS_QTY,0))),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,(NVL(C.TRANS_QTY,0) + NVL(A.TRANS_QTY,0))),',')-1) INV_BOX, \n");
        sbSql.append("       SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,(NVL(C.TRANS_QTY,0) + NVL(A.TRANS_QTY,0))),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,(NVL(C.TRANS_QTY,0)  + NVL(A.TRANS_QTY,0))),',')+1) INV_BONG \n");
        sbSql.append("  FROM FMW_PO_TRANSACTION A,                                                                                                                                                                      \n");
        sbSql.append("       FMW_ITEM_V B,                                                                                                                                                                              \n");
        sbSql.append("        (SELECT B.ITEM_CODE, SUM(B.TRANS_QTY  * PHYSIC_GUBUN) AS TRANS_QTY                                                                                                                                   \n");
        sbSql.append("           FROM FMW_PO_TRANSACTION B                                                                                                                                                              \n");
        sbSql.append("          WHERE B.TRANS_DATE BETWEEN '20110101' AND '" + strDATE + "'      \n");
        sbSql.append("            AND B.SUBINV_CODE = '" + strSUBINV_CODE + "' GROUP BY B.ITEM_CODE) C                                                                                                                               \n");
        //sbSql.append("        (SELECT NVL(ONHAND_QTY,0) ONHAND_QTY,ITEM_CODE                                                                                                                                            \n");
        //sbSql.append("           FROM FMW_ONHAND_MONTH                                                                                                                                                                  \n");
        //sbSql.append("          WHERE ONHAND_YM = (SELECT MAX(ONHAND_YM) FROM FMW_ONHAND_MONTH WHERE  SUBINV_CODE = '" + strSUBINV_CODE + "')) D                                                                                      \n");
        sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                  \n");
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+)                                                                                                                                                               \n");
        //sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+)                                                                                                                                                               \n");
        sbSql.append("   AND A.UPJANG =  '" + strUpjang + "'                                                                                                                                                                        \n");
        sbSql.append("   AND A.SUBINV_CODE =  '" + strSUBINV_CODE + "'   \n");
        sbSql.append("   AND A.TRANS_DATE  =  '" + strDATE + "'   \n");
        
        if (! strHALL_CODE.equals(""))
        	sbSql.append("   AND A.HALL_CODE = '" + strHALL_CODE + "'                                                                                                                   \n");

        if (! strTRANS_NUM.equals(""))
        	sbSql.append("   AND A.TRANS_NUM = '" + strTRANS_NUM + "'                                                                                                                   \n");        
        
        sbSql.append("   AND A.TRANS_TYPE = '" + strGUBUN + "'    \n");
        
        sbSql.append("  ORDER BY A.ITEM_CODE   \n");
       // if (strGUBUN.equals("O001")){
       // 	sbSql.append("   AND A.TRANS_QTY >= 0  \n");	
       // } else if (strGUBUN.equals("O002")){
       // 	sbSql.append("   AND A.TRANS_QTY < 0 \n");
       // }
        //if (! ds_input.getString(0, "OTCUSTCD").equals(""))
		//	sbSql.append("\n     AND OTCUSTCD = '" + nullToBlank(ds_input.getString(0, "OTCUSTCD")) + "'     ");
		
		//if (! ds_input.getString(0, "UPJANG").equals(""))
		//	sbSql.append("\n     AND UPJANG = '" + nullToBlank(ds_input.getString(0, "UPJANG")) + "'         ");

		//sbSql.append("\n  ORDER BY TO_NUMBER(V.ITEM_CODE)      ");		
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_cond1 = this.makeDataSet(rs, "ds_cond1"); //ds_in

		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_cond1);
		//this.setResultMessage(0, "OK", out_vl);

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
