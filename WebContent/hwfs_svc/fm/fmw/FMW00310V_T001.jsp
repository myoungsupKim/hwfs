<%
//*-----------------------------------------------------------------------------
//�� �ý��۸�     : ��������/��������
//�� ���α׷�ID   : FMW00310V_T001.jsp
//�� ���α׷���   : �Ǹų��� ��ȸ
//�� �ۼ�����     : 2011.02.09
//�� �ۼ���       : ������
//�� �̷°���     :  
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//�Է� ����Ÿ
		DataSet ds_Condput     	= in_dl.get("ds_Cond");
	
		String strUpjang 		  = nullToBlank(ds_Condput.getString(0, "UPJANG"));
		String strSUBINV_CODE	= nullToBlank(ds_Condput.getString(0, "SUBINV_CODE"));
		String strDATEF		    = nullToBlank(ds_Condput.getString(0, "DATEF"));
		String strDATET		    = nullToBlank(ds_Condput.getString(0, "DATET"));
		String strHALL_CODE 	= nullToBlank(ds_Condput.getString(0, "HALL"));
		String strITEM      	= nullToBlank(ds_Condput.getString(0, "ITEM"));
		
		//out ����Ÿ
		DataSet ds_List;

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //������ȸ		
				
    sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS TRANS_DATE \n");
    sbSql.append("     , A.UPJANG, A.HALL_CODE \n");
    sbSql.append("     , (SELECT Z.HALL_NAME FROM FMW_HALL Z WHERE Z.HALL_CODE = A.HALL_CODE AND Z.UPJANG = A.UPJANG) AS HALL_NAME \n");
    sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME \n");
    sbSql.append("     , DECODE(B.TAX_CODE,'100','����','210','�鼼','����') AS TAX_CODE \n");
    sbSql.append("     , A.TRANS_QTY \n");
    sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1) AS AMOUNT_BOX \n");
    sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1) AS AMOUNT_BONG \n");
    sbSql.append("     , (A.SALE_PRICE * B.ITEM_SIZE_BONG) AS PRICE_BOX \n");
    sbSql.append("     , A.SALE_PRICE AS PRICE_BONG \n");
    sbSql.append("     , DECODE(B.TAX_CODE,100,ROUND(A.SALE_AMOUNT/1.1),A.SALE_AMOUNT) AS AMT \n");
    sbSql.append("     , DECODE(B.TAX_CODE,100,(A.SALE_AMOUNT -ROUND(A.SALE_AMOUNT/1.1)),0) AS VAT \n");
    sbSql.append("     , A.SALE_AMOUNT AS SUM \n");
    sbSql.append("     , DECODE(A.TRANS_TYPE,'O001','����','O002','��ǰ')||A.TRANS_NUM AS TRANS_NUM \n");
    sbSql.append("     , A.TRANS_TYPE, B.ITEM_SIZE_BONG \n");
    sbSql.append("     , (A.AVG_PRICE * B.ITEM_SIZE_BONG) AS UNIT_PRICE_BOX \n");
    sbSql.append("     , A.AVG_PRICE AS UNIT_PRICE_BONG \n");
    sbSql.append("     , A.AVG_AMOUNT AS UNIT_AMOUNT \n");
    sbSql.append("     , A.SALE_AMOUNT - A.AVG_AMOUNT AS MARGIN_AMOUNT \n");
    sbSql.append("     , DECODE(A.AVG_AMOUNT, 0, 100, ROUND(((A.SALE_AMOUNT - A.AVG_AMOUNT) /A.AVG_AMOUNT) * 100, 1)) AS MARGIN_RATE \n");
    sbSql.append("     , A.REMARK \n");
    sbSql.append("  FROM FMW_PO_TRANSACTION A, FMW_ITEM_V B \n");
    sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
    sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
    sbSql.append("   AND A.SUBINV_CODE = '" + strSUBINV_CODE + "' \n");
    if (! strHALL_CODE.equals(""))
    	sbSql.append("   AND A.HALL_CODE = '" + strHALL_CODE + "' \n");
    if (! strITEM.equals(""))
    	sbSql.append("   AND ((B.ITEM_CODE LIKE '%" + strITEM + "%') OR (B.ITEM_NAME LIKE '%" + strITEM + "%')) \n");
    sbSql.append("   AND A.TRANS_DATE BETWEEN '" + strDATEF + "' AND '" + strDATET + "' \n");
    sbSql.append("   AND A.TRANS_TYPE LIKE 'O%' \n");
    sbSql.append(" ORDER BY A.TRANS_DATE, A.HALL_CODE, A.ITEM_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs, "ds_List");

		rs.close();
		pstmt.close();		
		
		/**����**/
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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
		
	}

	proc_output(response,out,out_vl,out_dl);

%>