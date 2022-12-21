<%
//*-----------------------------------------------------------------------------
//�� �ý��۸�     : ���ҸŰ���/�Ǹų��� �ϰ�ó��/���ݰ���
//�� ���α׷�ID   : FMW00200E_S002.jsp
//�� ���α׷���   : �Ǹų��� �ϰ�ó��/���ݰ���
//�� �ۼ�����     : 2010.01.06
//�� �ۼ���       : �ͼ���
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
		DataSet ds_input     	= in_dl.get("ds_in");
	
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strHALL_CODE 	= nullToBlank(ds_input.getString(0, "HALL_CODE"));
		String strDATE		    = nullToBlank(ds_input.getString(0, "DATE"));
		
		//out ����Ÿ
		DataSet ds_rcv;

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //������ȸ		

		//���Ϲ̼� : ���ϱ����� ���⿡�� ���ϱ����� ���ݾװ� ��������  �� ������
		//���Ϲ̼� : ���ϱ����� ���⿡�� ���ϱ����� ���ݾװ� �������� �� ������
		//���Ͽ����� : ������ ������ �հ�
		//���� ���ݾ� : ������ ���ݾ� �հ�
		//���ϸ��� : ������ ���� �հ�
        sbSql.append("SELECT BEFORE_MISU,                      \n");
        sbSql.append("       (BEFORE_MISU + TODAY_MISU) TODAY_MISU, \n");
        sbSql.append("       TODAY_MAECHUL,                    \n");
        sbSql.append("       TODAY_DISCOUNT_AMT,               \n");
        sbSql.append("       TODAY_RCV_AMT                     \n");
        sbSql.append("FROM (                                   \n");
		sbSql.append("SELECT                                                                                  \n");
        sbSql.append("       NVL(B.���ϸ���,0) - NVL((SELECT SUM(RCV_AMT)+ SUM(DISCOUNT_AMT) FROM FMW_RCV WHERE RCV_DATE <= TO_CHAR(TO_DATE('" + strDATE + "', 'YYYYMMDD') -1,'YYYYMMDD') AND UPJANG =  '" + strUpjang + "' AND HALL_CODE = '" + strHALL_CODE + "' ),0) BEFORE_MISU, \n");
        sbSql.append("       (NVL(A.���ϸ���,0)) - NVL((SELECT SUM(RCV_AMT)+ SUM(DISCOUNT_AMT) FROM FMW_RCV WHERE RCV_DATE = '" + strDATE + "'  AND UPJANG =  '" + strUpjang + "' AND HALL_CODE = '" + strHALL_CODE + "'),0) TODAY_MISU,                                         \n");
        sbSql.append("       NVL(A.���ϸ���,0) TODAY_MAECHUL,                                                                                                        \n");
        sbSql.append("       NVL((SELECT SUM(DISCOUNT_AMT) FROM FMW_RCV WHERE RCV_DATE = '" + strDATE + "'  AND UPJANG =  '" + strUpjang + "' AND HALL_CODE = '" + strHALL_CODE + "'),0) TODAY_DISCOUNT_AMT,                                          \n");
        sbSql.append("       NVL((SELECT SUM(RCV_AMT) FROM FMW_RCV WHERE RCV_DATE ='" + strDATE + "'  AND UPJANG =  '" + strUpjang + "' AND HALL_CODE = '" + strHALL_CODE + "'),0) TODAY_RCV_AMT                                                     \n");
        sbSql.append("  FROM  (SELECT MAX(UPJANG) UPJANG,                      \n");
        sbSql.append("                MAX(HALL_CODE) HALL_CODE,    \n");
        sbSql.append("                NVL(SUM(SALE_AMOUNT),0) ���ϸ���      \n");
        sbSql.append("           FROM FMW_PO_TRANSACTION                                         \n");
        sbSql.append("          WHERE TRANS_DATE =  '" + strDATE + "' --���ϸ�                          \n");
        sbSql.append("            AND UPJANG =  '" + strUpjang + "'                                \n");
        sbSql.append("            AND HALL_CODE =  '" + strHALL_CODE + "') A   ,                    \n");		
        sbSql.append("         (SELECT NVL(SUM(SALE_AMOUNT),0) ���ϸ���         \n");
        sbSql.append("            FROM FMW_PO_TRANSACTION         \n");
        sbSql.append("           WHERE TRANS_DATE <=  TO_CHAR(TO_DATE('" + strDATE + "' , 'YYYYMMDD') -1,'YYYYMMDD') \n");
        sbSql.append("             AND UPJANG =  '"+  strUpjang +" '                            \n");
        sbSql.append("             AND HALL_CODE =  '" + strHALL_CODE + "') B           \n");
        sbSql.append(")                                 \n"); 
        //System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_rcv = this.makeDataSet(rs, "ds_rcv"); //ds_in

		rs.close();
		pstmt.close();		
		
		/**����**/
		out_dl.add(ds_rcv);
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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
		
	}

	proc_output(response,out,out_vl,out_dl);

%>
