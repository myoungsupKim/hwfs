<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : FS�Ĵ�/���Ű��� / ���ã��
�� ���α׷�ID   : FSP90020E_S001.jsp
�� ���α׷���   : ������ȸ
�� �ۼ�����     : 2015-07-07
�� �ۼ���       : ����ö
�� �̷°���     : 2015-07-07 ����ö �����ۼ�
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt             =  null;
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log ���� ����
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //�Է� ����Ÿ
        DataSet ds_item_cond = in_dl.get("ds_item_cond");
        //�Է� �Ķ����
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"    ));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"     ));

        String MU_CD        = nullToBlank(ds_item_cond.getString(0, "MU_CD"         ));
        String TM_CD        = nullToBlank(ds_item_cond.getString(0, "TM_CD"         ));
        String UPJANG       = nullToBlank(ds_item_cond.getString(0, "UPJANG"        ));
        String SUBINV_CODE  = nullToBlank(ds_item_cond.getString(0, "SUBINV_CODE"   ));
        String ITEM_CLASS1  = nullToBlank(ds_item_cond.getString(0, "ITEM_CLASS1"   ));
        String ITEM_CLASS2  = nullToBlank(ds_item_cond.getString(0, "ITEM_CLASS2"   ));
        String ITEM_CLASS3  = nullToBlank(ds_item_cond.getString(0, "ITEM_CLASS3"   ));
        String ITEM_CLASS4  = nullToBlank(ds_item_cond.getString(0, "ITEM_CLASS4"   ));
        String ITEM_CODE    = nullToBlank(ds_item_cond.getString(0, "ITEM_CODE"     ));

        //out ����Ÿ
        DataSet ds_out;
        //sql�� ���ۻ���
        StringBuffer sbSql = new StringBuffer();
        //������ȸ
        sbSql.delete(0, sbSql.length());
        sbSql.append("\n                                                                                                                        \n");
        sbSql.append("SELECT A.ITEM_CODE            -- ��ǰ�ڵ�                                                                                                \n");
        sbSql.append("     , A.ITEM_NAME            -- ��ǰ��                                                                                                  \n");
        sbSql.append("     , A.ITEM_SIZE            -- �԰�                                                                                                    \n");
        sbSql.append("     , A.ORIGIN_TYPE          -- ������Ÿ��                                                                                              \n");
        sbSql.append("     , A.ORIGIN_NAT           -- ����������                                                                                              \n");
        sbSql.append("     , A.PO_UOM               -- ����                                                                                                    \n");
        sbSql.append("     , B.CONTRACT_PRICE_M     -- �����ܰ�                                                                                                \n");
        sbSql.append("  FROM HLDC_PO_ITEM_MST A                                                                                                 \n");
        sbSql.append("     , HLDC_PO_CONTRACT_F B                                                                                               \n");
        sbSql.append("     , SCO_UPJANG_MST_V C                                                                                                 \n");
        sbSql.append(" WHERE A.ITEM_CODE        = B.ITEM_CODE                                                                                   \n");
        sbSql.append("   AND A.USE_YN           = 'Y'                                                                                           \n");
        sbSql.append("   AND B.UPJANG           = C.UPJANG                                                                                      \n");
        sbSql.append("   AND C.UPJANG           = "  + UPJANG      + "                                                                          \n");
        sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN B.CONTRACT_START AND NVL(B.CONTRACT_END, '99991231')                           \n");
        sbSql.append("   AND B.USE_YN           = 'Y'                                                                                           \n");
        sbSql.append("   AND B.CONTRACT_PRICE_M > 0                                                                                             \n");
        sbSql.append("   AND A.ITEM_CLASS1      = '" + ITEM_CLASS1 + "'                                                                         \n");
        if(!ITEM_CODE.equals(""))
        {   
        	//REGEXP_LIKE �Լ��� �������� 200�� ������ ���� �߻� substr�Լ��� 200�� ���� �߰� ��ȣ�� CH201703_00107
			sbSql.append("   AND (REGEXP_LIKE(A.ITEM_NAME, (SELECT SUBSTR(TRIM(LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP)),0,200) AS ITEM_NAME \n");
			sbSql.append("             FROM																																		   \n");
			sbSql.append("      						  (SELECT REPLACE(REPLACE(REPLACE('" + ITEM_CODE + "', '(', '\\('), ')', '\\)'), ' ', '|') AS ITEM_NAME									   \n");
			sbSql.append("      							      , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM DUAL																										   \n");
			sbSql.append("                                     UNION ALL																										   \n");
			sbSql.append("                                     --���ԽĿ��� ��ȣ�� ���ʸ� ������ ���� �߻��ϱ⶧���� ġȯó��													   \n");
			sbSql.append("   		                                  SELECT REPLACE(REPLACE(REPLACE(KEYWORD||'|'||SIM_TXT, '(', ''), ')', ''), ' ', '|') AS ITEM_NAME			   \n");
			sbSql.append("                                          , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM EPROCUSR.VO_ITEM_SIM_WORD																					   \n");
			sbSql.append("                                      --���� ��ϵ� Ű����� ��ġ�˻����� ����																	   \n");
			sbSql.append("                                      WHERE KEYWORD = REPLACE(REPLACE(REPLACE('" + ITEM_CODE + "', '(', '\\('), ')', '\\)'), ' ', '|')									   \n");
			sbSql.append("                                    ) T																												   \n");
			sbSql.append("                              )																														   \n");	 
			sbSql.append("   			             )																															   \n");
			sbSql.append("   OR REGEXP_LIKE(A.ITEM_CODE, (SELECT SUBSTR(TRIM(LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP)),0,200) AS ITEM_NAME \n");
			sbSql.append("             FROM																																		   \n");
			sbSql.append("      						  (SELECT REPLACE(REPLACE(REPLACE('" + ITEM_CODE + "', '(', '\\('), ')', '\\)'), ' ', '|') AS ITEM_NAME									   \n");
			sbSql.append("      							      , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM DUAL																										   \n");
			sbSql.append("                                     UNION ALL																										   \n");
			sbSql.append("                                     --���ԽĿ��� ��ȣ�� ���ʸ� ������ ���� �߻��ϱ⶧���� ġȯó��													   \n");
			sbSql.append("   		                                  SELECT REPLACE(REPLACE(REPLACE(KEYWORD||'|'||SIM_TXT, '(', ''), ')', ''), ' ', '|') AS ITEM_NAME			   \n");
			sbSql.append("                                          , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM EPROCUSR.VO_ITEM_SIM_WORD																					   \n");
			sbSql.append("                                      --���� ��ϵ� Ű����� ��ġ�˻����� ����																	   \n");
			sbSql.append("                                      WHERE KEYWORD = REPLACE(REPLACE(REPLACE('" + ITEM_CODE + "', '(', '\\('), ')', '\\)'), ' ', '|')									   \n");
			sbSql.append("                                    ) T																												   \n");
			sbSql.append("                              )																														   \n");	 
			sbSql.append("   			             ))																															   \n");	
            /* sbSql.append("   AND (REGEXP_LIKE(A.ITEM_NAME, (SELECT LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME	\n");
            sbSql.append("                                   FROM 																								\n");
            sbSql.append("                                       (SELECT KEYWORD||'|'||SIM_TXT AS ITEM_NAME														\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM EPROCUSR.VO_ITEM_SIM_WORD																\n");
            sbSql.append("                                         WHERE REGEXP_LIKE(KEYWORD, REPLACE('" + ITEM_CODE + "', ' ', '|'))							\n");
            sbSql.append("                                         UNION ALL																					\n");
            sbSql.append("                                        SELECT REPLACE('" + ITEM_CODE + "', ' ', '|') AS ITEM_NAME									\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM DUAL																					\n");
            sbSql.append("                                        ) T																							\n");
            sbSql.append("                                )																										\n");
            sbSql.append("                   )																													\n");
            
            sbSql.append("   OR REGEXP_LIKE(A.ITEM_CODE, (SELECT LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME	\n");
            sbSql.append("                                   FROM 																								\n");
            sbSql.append("                                       (SELECT KEYWORD||'|'||SIM_TXT AS ITEM_NAME														\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM EPROCUSR.VO_ITEM_SIM_WORD																\n");
            sbSql.append("                                         WHERE REGEXP_LIKE(KEYWORD, REPLACE('" + ITEM_CODE + "', ' ', '|'))							\n");
            sbSql.append("                                         UNION ALL																					\n");
            sbSql.append("                                        SELECT REPLACE('" + ITEM_CODE + "', ' ', '|') AS ITEM_NAME									\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM DUAL																					\n");
            sbSql.append("                                        ) T																							\n");
            sbSql.append("                                )																										\n");
            sbSql.append("                   ))																													\n"); */
        }
        else
        {
            if(!ITEM_CLASS2.equals(""))
                sbSql.append("   AND A.ITEM_CLASS2 = '" + ITEM_CLASS2 + "'                                                                      \n");
            if(!ITEM_CLASS3.equals(""))
                sbSql.append("   AND A.ITEM_CLASS3 = '" + ITEM_CLASS3 + "'                                                                      \n");
            if(!ITEM_CLASS4.equals(""))
                sbSql.append("   AND A.ITEM_CLASS4 = '" + ITEM_CLASS4 + "'                                                                      \n");
        }
        sbSql.append(" ORDER BY A.ITEM_NAME                   			                                                                        \n");
        sbSql.append("\n                                                                                                                        \n");

        stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString());
		
		ds_out = this.makeDataSet(rs,"ds_out");
		out_dl.add(ds_out);
		
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