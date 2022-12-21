<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : FS�Ĵ�/���Ű��� / ���ã��
�� ���α׷�ID   : FSP90020E_S001.jsp
�� ���α׷���   : ���ã�� ��� ����
�� �ۼ�����     : 2015-07-07
�� �ۼ���       : ����ö
�� �̷°���     : 2015-07-07 ����ö �����ۼ�
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt            = null;
    PreparedStatement pstmt1  = null;
    PreparedStatement pstmt2  = null;
    PlatformRequest platformRequest = this.proc_input(request);
    in_vl = platformRequest.getData().getVariableList();
    in_dl = platformRequest.getData().getDataSetList();

    try {

        //jsp log ���� ����
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //�Է� ����Ÿ
        DataSet ds_favorite_list = in_dl.get("ds_favorite_list");
        
        //�Է� �Ķ����
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"    ));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"     ));
        
        //out ����Ÿ
        DataSet ds_out; 
        
        //sql�� ���ۻ���
        StringBuffer sbSql = new StringBuffer();
        
        sbSql.append("INSERT INTO FSP_FAVORITE( \n");
        sbSql.append("	  UPJANG                 \n");
        sbSql.append("	, FAVOR_GROUP            \n");
        sbSql.append("	, ITEM_CODE              \n");
        sbSql.append("	, CUSER                  \n");
        sbSql.append("	, CDATE                  \n");
        sbSql.append("	, UUSER                  \n");
        sbSql.append("	, UDATE                  \n");
        sbSql.append(" ) VALUES (                \n");
        sbSql.append("	  ?                      \n");
        sbSql.append("	, ?                      \n");
        sbSql.append("	, ?                      \n");
        sbSql.append("	, ?                      \n");
        sbSql.append("	, SYSDATE                \n");
        sbSql.append("	, ?                      \n");
        sbSql.append("	, SYSDATE                \n");
        sbSql.append(" )                       	 \n");
        
        String strItemInsert = sbSql.toString();
        pstmt1 = conn.prepareStatement(strItemInsert);

        sbSql.delete(0, sbSql.length());
        sbSql.append("DELETE FSP_FAVORITE                \n");
        sbSql.append("WHERE FAVOR_GROUP = ?              \n");
        sbSql.append("  AND ITEM_CODE   = ?              \n");
        sbSql.append("  AND UPJANG      = ?              \n");
        
        String strItemUpdate = sbSql.toString();
        pstmt2 = conn.prepareStatement(strItemUpdate);
        
        // �Է�
        int iInsertCnt = 0;
        for(int i=0; i < ds_favorite_list.getRowCount(); i++)
        {
	         pstmt1.setString(1, ds_favorite_list.getString(i,"UPJANG"));
	         pstmt1.setString(2, ds_favorite_list.getString(i,"FAVOR_GROUP"));
	         pstmt1.setString(3, ds_favorite_list.getString(i,"ITEM_CODE"));
	         pstmt1.setString(4, ds_favorite_list.getString(i,"CUSER"));
	         pstmt1.setString(5, ds_favorite_list.getString(i,"UUSER"));
	        
	         pstmt1.addBatch();
	         iInsertCnt++;
 		}
        // ����
        int iDeleteCnt = 0;
	 	for(int i=0; i < ds_favorite_list.getRemovedRowCount(); i++)
        {
	         pstmt2.setString(1, ds_favorite_list.getRemovedStringData(i,"FAVOR_GROUP"));
	         pstmt2.setString(2, ds_favorite_list.getRemovedStringData(i,"ITEM_CODE"));
	         pstmt2.setString(3, ds_favorite_list.getRemovedStringData(i,"UPJANG"));
	         pstmt2.addBatch();
	         iDeleteCnt++;
         }

        if(iInsertCnt > 0) pstmt1.executeBatch();
        if(iDeleteCnt > 0) pstmt2.executeBatch();
        
        conn.commit();
        
        this.setResultMessage(0, "OK",out_vl);

    }
    catch(Exception ex)
    {
        //ex.printStackTrace();
        //jsp �α׳����
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