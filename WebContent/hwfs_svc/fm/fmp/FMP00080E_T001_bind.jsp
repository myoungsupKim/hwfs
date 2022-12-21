<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ֹ�����
�� ���α׷�ID   : FMP00080E_T001.jsp
�� ���α׷���   : �ֹ���ǰ ��ȸ
�� �ۼ�����     : 2008.01.21
�� �ۼ���       : ������
�� �̷°���     : 2008.01.21
-----------------------------------------------------------------------------*/
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
        DataSet ds_cond      = in_dl.get("ds_Cond");
        //�Է� �Ķ����
        String g_Upjang      = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo       = nullToBlank(in_vl.getString("g_EmpNo"));
        String g_SystemId    = nullToBlank(in_vl.getString("g_SystemId"));
        //�α����� ������� ������ �ƴ� �ֹ�����ϴ� ������� ������ ����
        //String Holiday_YN   = nullToBlank(in_vl.getString("Holiday_YN"));
        String strIndex      = nullToBlank(in_vl.getString("strIndex"));
        String strOnly       = nullToBlank(in_vl.getString("strOnly"));
        String sType         = nullToBlank(in_vl.getString("sType"));
        //String strThreeMonth = nullToBlank(in_vl.getString("strThreeMonth"));
        String nMonth = nullToBlank(in_vl.getString("nMonth"));		// �ֱ� n����
        String strWeekendTimeCheck = nullToBlank(in_vl.getString("strWeekendTimeCheck"));
        
        //���ε� ������ ���� ���� �Ҵ�
        int iBind = 1;
        String bindString[] = new String[100];

        //sql�� ���ۻ���
        StringBuffer sbSql_tmp = new StringBuffer();
        sbSql_tmp.delete(0,sbSql_tmp.length());
        
        String strKeyword	= "";

        if(!nullToBlank(ds_cond.getString(0, "ITEM_NAME")).equals(""))
        {
            String[] arrSameWord_tmp = nullToBlank(ds_cond.getString(0, "ITEM_NAME")).split(" ");

            sbSql_tmp.append("SELECT LISTAGG(T.ITEM_NAME, ',') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME \n");
            sbSql_tmp.append("  FROM ( SELECT KEYWORD||','||SIM_TXT AS ITEM_NAME                              \n");
            sbSql_tmp.append("              , '1' AS ITEM_GROUP                                               \n");
            sbSql_tmp.append("           FROM EPROCUSR.VO_ITEM_SIM_WORD                                       \n");
            sbSql_tmp.append("          WHERE 1=1 															  \n");
            sbSql_tmp.append("            AND  ( 															  \n");
            for(int i=0; i<arrSameWord_tmp.length; i++) {
                //sbSql_tmp.append("            		KEYWORD LIKE '%' || '"+arrSameWord_tmp[i]+"' || '%'		  \n");
                sbSql_tmp.append("            		KEYWORD = '"+arrSameWord_tmp[i]+"'	  \n");
                if(i < arrSameWord_tmp.length-1) {
                    sbSql_tmp.append("  		OR 															  \n");
                }
            }
            sbSql_tmp.append("    				) 															  \n");
            sbSql_tmp.append("       ) T                                                                      \n");

            out_vl.add("fa_Sql", sbSql_tmp.toString());
            pstmt = conn.prepareStatement(sbSql_tmp.toString());
            rs = pstmt.executeQuery();

            if(rs.next()) {
                strKeyword += nullToBlank(rs.getString("ITEM_NAME"));
                for (int i=0; i<arrSameWord_tmp.length; i++) {
                    if ( strKeyword.indexOf(arrSameWord_tmp[i]) == -1 ) { //�ߺ�����
                        if ( strKeyword.length() > 0 ) {
                            strKeyword += ",";
                        }
                        strKeyword += arrSameWord_tmp[i];
                    }
                }
            }
            rs.close();
            pstmt.close();
        }
        String[] strKeyword_ItemName = strKeyword.split(",");

        //out ����Ÿ
        DataSet ds_list;
        //sql�� ���ۻ���
        StringBuffer sbSql = new StringBuffer();
        String strQtyYn    = nullToBlank(ds_cond.getString(0, "QTY_CONTROL_YN"));
        String strItemName    = nullToBlank(ds_cond.getString(0, "ITEM_NAME"));
        String Holiday_YN = "";

        //D-1��ǰ ���� üũ ���� ����_Y��:�Ͽ��� üũ ���ϰ� �Ͽ��� ���� ����
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT HOLIDAY_CHK_YN \n");
        sbSql.append("  FROM FMS_UPJANG A \n");
        sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        if (rs != null) {
             rs.next();
             Holiday_YN = rs.getString("HOLIDAY_CHK_YN");
        }
        if (rs != null) rs.close();
        pstmt.close();

        //��û���� ��������
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD') AS PR_DATE FROM DUAL\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
        String sPrDate = rs.getString("PR_DATE");
        rs.close();
        pstmt.close();
        
        //�Ͽ��� ������ ���� ���� ��ǰ ���� 
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT DECODE(COUNT(*), 0, 'N', 'Y') AS HOLI_ORDER_YN \n");
        sbSql.append("  FROM SCC_COMMON_CODE A \n");
        sbSql.append(" WHERE A.GROUP_CODE = 'WEEKEND_TIME' \n");
        sbSql.append("   AND A.SET1 = 'Y' \n");
        sbSql.append("   AND TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD'), 'D') = A.CODE \n");
        sbSql.append("   AND SUBSTR(TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDDHH24MI'), 9) BETWEEN A.SET2 AND A.SET3 \n");
        sbSql.append("   AND (TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD'), 'D') = 7 AND TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD')+2 = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') \n"); 
        sbSql.append("       OR (TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD'), 'D') = 1 AND TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD')+1 = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') \n");
        
        pstmt = conn.prepareStatement(sbSql.toString());
        
        rs = pstmt.executeQuery();
        rs.next();
        strWeekendTimeCheck = rs.getString("HOLI_ORDER_YN");
        rs.close();
        pstmt.close();        
                
        //START_������ ���� ���� ��ǰ ����_20151214
        if(strWeekendTimeCheck.equals("N"))
        {
        	sbSql.delete(0, sbSql.length());
            sbSql.append("SELECT DECODE(COUNT(*), 0, 'N', 'Y') AS HOLI_ORDER_YN \n");
            sbSql.append("  FROM SCC_COMMON_CODE A \n");
            sbSql.append(" WHERE A.GROUP_CODE = 'HOLIDAY_TIME' \n");
            //sbSql.append("   AND SET1 = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
            sbSql.append("   AND EXISTS (SELECT SET1 FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'HOLIDAY_TIME' AND SET1 = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') \n");
            sbSql.append("   AND TO_CHAR(SYSDATE, 'YYYYMMDD') = CODE \n");
            /*
            �ʱ⸸�鶧 D-DAY1�ϸ��� ����� ������ ���� �������� �������� �������� ����
            �����Ҷ� �����Ϸ� ������ ������¥�� set1�� �����ϴµ� �׳�¥�� �԰����̸�
            ������ ���� ����. �̷��� ��Ʋ ���� �����ϵ� ���� ������
            */
            
            pstmt = conn.prepareStatement(sbSql.toString());
            rs = pstmt.executeQuery();
            rs.next();
            strWeekendTimeCheck = rs.getString("HOLI_ORDER_YN");
            rs.close();
            pstmt.close();	
        }        
        //END_������ ���� ���� ��ǰ ����_20151214

        //������ȸ
        sbSql.delete(0, sbSql.length());

        sbSql.append("SELECT /*������ �˻�-FMP00080E_T001_bind.jsp*/ \n");
        sbSql.append("       T.* ");
        sbSql.append("     , DECODE(T.FEATURE_NAME_CHK, NULL, U.FEATURE_NAME, T.FEATURE_NAME_CHK||U.FEATURE_NAME) AS FEATURE_NAME ");
        sbSql.append("     , U.FEATURE_ICON ");
        sbSql.append("     , DECODE(T.PO_WEEK_STATUS, 'XR', '', T.ITEM_CODE) AS WEEK_ITEM_CODE ");
        sbSql.append("     , DECODE(T.DANGA_ITEM_CODE, NULL, 'NN', 'FE') AS DANGAWEEK_STATUS ");
        
     	// ǰ��˻����� (0:��ü n:�ֱ�n����)
        if ( !nMonth.equals("0") )	
        {
        	sbSql.append("     , Y.PR_REMARK_RECENT ");
        }
     
        sbSql.append("  FROM ( \n");

        sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.UNIT_PRICE AS MARGIN_PRICE \n");
        sbSql.append("     , A.SALE_PRICE, B.DEF_QTY AS PR_QTY, ROUND(A.SALE_PRICE * B.DEF_QTY) AS SALE_AMOUNT \n");
        //LINE_STATUS �������� ���°��� '002'�� sbSql.append("     , '004' AS LINE_STATUS, '������' AS CLS_STATUS, NULL AS PR_REMARK \n");
        sbSql.append("     , '002' AS LINE_STATUS, '������' AS CLS_STATUS, NULL AS PR_REMARK \n");
        sbSql.append("     , ? AS SUBINV_CODE, A.NEED_DATE, B.PRE_NEED_DATE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
        sbSql.append("     , A.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
        sbSql.append("     , A.CENTER_CODE, A.POINT_FLAG, ? AS PR_UPJANG \n");
        bindString[iBind++] = g_Upjang;
        sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
        sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
        sbSql.append("     , A.OTCUSTCD \n");
        sbSql.append("     , CASE WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL \n");
        sbSql.append("            THEN DECODE(SIGN(NVL(CC.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL), CC.OP_PRICE) \n");
        sbSql.append("            WHEN DD.OP_PRICE IS NOT NULL OR DD.OP_RATE IS NOT NULL \n");
        sbSql.append("            THEN DECODE(SIGN(NVL(DD.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(DD.OP_RATE,0) / 100),DD.CEIL_VAL), DD.OP_PRICE) \n");
        sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE \n");
        sbSql.append("     , DECODE(CC.OP_RATE, NULL, DD.OP_RATE, CC.OP_RATE) AS OP_RATE \n");
        sbSql.append("     , ROUND(CASE WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(CC.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL), CC.OP_PRICE) \n");
        sbSql.append("                  WHEN DD.OP_PRICE IS NOT NULL OR DD.OP_RATE IS NOT NULL \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(DD.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(DD.OP_RATE,0) / 100),DD.CEIL_VAL), DD.OP_PRICE) \n");
        sbSql.append("             ELSE A.SALE_PRICE END * B.DEF_QTY) AS OP_AMOUNT \n");
        sbSql.append("     , ROUND(CASE WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(CC.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL), CC.OP_PRICE) \n");
        sbSql.append("                  WHEN DD.OP_PRICE IS NOT NULL OR DD.OP_RATE IS NOT NULL \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(DD.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(DD.OP_RATE,0) / 100),DD.CEIL_VAL), DD.OP_PRICE) \n");
        sbSql.append("             ELSE A.SALE_PRICE END / A.KG_CONVERT_RATE / 1000,1) AS G_PRICE \n");
        sbSql.append("     , 0 AS OP_AMOUNT_OLD \n");
        
        //�ܽ� SPOON �ý��� ��� �ϴ� ���� �ָ� ���� D-DAY üũ ���� ����.
        //if (g_SystemId.equals("SPOON"))
        if (Holiday_YN.equals("Y"))
        {
            sbSql.append("     , A.D_DAYS, A.D_TIMES \n");
            sbSql.append("     , 'D-'||TO_CHAR(A.D_DAYS) AS D_DAY_DISP \n");
        }
        else
        {
        /////////////////////////////////////////////////////////////////20151008 Ʃ������ �߰�
// 			sbSql.append("     , FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS) AS D_DAYS \n");
            //sbSql.append("     , TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "', 'YYYYMMDD') - TO_DATE(KK.NONHOLI_DATE, 'YYYYMMDD') AS D_DAYS \n");
            sbSql.append("     , FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS') AS D_DAYS \n");
            sbSql.append("     , A.D_TIMES \n");
            // 2015.07.06 ������Ŵ�����û���� D-Day�� ǥ�� sbSql.append("     , 'D-'||TO_CHAR(FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS))||' '||TRIM(TO_CHAR(A.D_TIMES,'0000')) AS D_DAY_DISP \n");
// 			sbSql.append("     , 'D-'||TO_CHAR(FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS)) AS D_DAY_DISP \n");
        /////////////////////////////////////////////////////////////////20151008 Ʃ������ �߰�
            //sbSql.append("     , 'D-'||TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "', 'YYYYMMDD') - TO_DATE(KK.NONHOLI_DATE, 'YYYYMMDD')) AS D_DAY_DISP \n");
            sbSql.append("     , 'D-'||FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS') AS D_DAY_DISP \n");
        }
        //�ܽ� SPOON �ý��� ��� �ϴ� ���� �ָ� ���� D-DAY üũ ���� ����.  //2010-12-30 ���� �߰� BY ��Կ�

        sbSql.append("     , D.OTCUSTNM, A.KG_CONVERT_RATE \n");

         if (strOnly.equals("TRUE"))
             sbSql.append("     , NULL AS FEATURE_NAME_CHK \n");
         else
             sbSql.append("     , DECODE(A.WEEK_ITEM_CODE,NULL,NULL,'(��������)')||DECODE(E.ITEM_CODE,NULL,NULL,'(�ֹ�����)') AS FEATURE_NAME_CHK \n");

        sbSql.append("     , A.IMAGE_PATH, DECODE(A.IMAGE_PATH,NULL,'N','Y') AS IMAGE_YN \n");

        if (! strOnly.equals("TRUE"))
            sbSql.append("     , E.ITEM_CODE AS LIMIT_ITEM, E.LIMIT_REASON \n");

// 		sbSql.append("     , A.WEEK_ITEM_CODE \n");
        sbSql.append("     , A.CONSUM_YN, B.PR_ID, A.KEEPING_TYPE \n");
        sbSql.append("     , A.APPLY_SD, A.VD_SN \n");
        sbSql.append("     , A.ORIGIN_TYPE \n");
        sbSql.append("     , 'P' AS MOBILE_GUBUN \n");
        sbSql.append("     , SCC_SOPR_AGG_FUN(?, A.ITEM_CODE, '1') AS MAX_SO_QTY \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
        sbSql.append("     , SCC_SOPR_AGG_FUN(?, A.ITEM_CODE, '3') AS TOT_SO_AMT \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
        sbSql.append("     , A.UPJANG_GRP \n");
        //sbSql.append("     , CASE WHEN A.PO_STATUS = 'HK' AND A.FMP_STATUS = 'N' THEN '' ELSE A.ITEM_CODE END AS WEEK_ITEM_CODE \n");
        //sbSql.append("     , A.PO_STATUS \n");
        //sbSql.append("     , A.FMP_STATUS \n");
        sbSql.append("     , DECODE(A.OTCUSTCD, '0000', EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS'), FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), ?, ?), 'HK') AS PO_STATUS \n");
        bindString[iBind++] = sPrDate; 
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE")); 
        //�ҿ�����üũ
        sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) AS UNUSE_YN  \n");
        //��������üũ
        sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS VAL_STP_YN \n");
        sbSql.append("     , DECODE(A.OTCUSTCD, '0000', FMP_ORDER_SCHL_FUN(?, A.CUSTCD, A.ITEM_CODE, ?), 'N') AS FMP_STATUS \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("     , DECODE(A.OTCUSTCD, '0000', EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', ?), 'XR') AS PO_WEEK_STATUS , DANGA_ITEM_CODE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));

        //sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS ITEM_STOP \n"); // ���źҿ�����üũ

        sbSql.append("  FROM \n");

        sbSql.append("       ( \n");
        sbSql.append("       SELECT * \n");
        sbSql.append("         FROM FMU_OP_RATE \n");
        sbSql.append("        WHERE UPJANG = ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        sbSql.append("          AND ? BETWEEN SDATE AND EDATE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("          AND USE_YN = 'Y' \n");
        sbSql.append("          AND ITEM_TYPE = 'M' \n");
        sbSql.append("       ) CC \n");
        sbSql.append("      ,( \n");
        sbSql.append("       SELECT * \n");
        sbSql.append("         FROM FMU_OP_RATE \n");
        sbSql.append("        WHERE UPJANG = ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        sbSql.append("          AND ? BETWEEN SDATE AND EDATE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("          AND USE_YN = 'Y' \n");
        sbSql.append("          AND ITEM_TYPE = 'C' \n");
        sbSql.append("       ) DD \n");

        //sbSql.append("     , FMP_OTHER_CUST D , FMP_OTCUST_LINK F, HLDC_PO_CENTER G \n");
        sbSql.append("     , FMP_OTHER_CUST D , FMP_OTCUST_LINK F \n");

        if (! strOnly.equals("TRUE"))
            sbSql.append("     , FMP_ORD_LIMIT E \n");

        sbSql.append("     ,(SELECT 0 AS DEF_QTY, '' AS PR_ID, '' AS PRE_NEED_DATE  FROM DUAL) B \n");
        sbSql.append("     ,(SELECT ? AS UPJANG \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        sbSql.append("            , ? AS NEED_DATE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4 \n");
        sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
        sbSql.append("            , C.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
        sbSql.append("            , A.CENTER_CODE, C.POINT_FLAG \n");
        sbSql.append("            , A.CONTRACT_PRICE AS UNIT_PRICE \n");
        sbSql.append("            , A.SALE_PRICE \n");

        //�������� ���ϴ� ������ ��� �Ҽ������ְ� Y�̸� ������ �ּҹ��ַ�/���ֽ¼����� ������ 0.1�� �����Ͽ� ��ȸ
        if (strQtyYn.equals("N"))
        {
              sbSql.append("            , DECODE(C.POINT_FLAG,'Y',DECODE(C.MIN_ORD_QTY,0,0,0.1),C.MIN_ORD_QTY) AS MIN_ORD_QTY \n");
              sbSql.append("            , C.MAX_ORD_QTY \n");
              sbSql.append("            , DECODE(C.POINT_FLAG,'Y',DECODE(C.MULTIPLIER_QTY,0,0,0.1),C.MULTIPLIER_QTY) AS MULTIPLIER_QTY \n");
          }
        else
              sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");

        sbSql.append("            , '0000' AS OTCUSTCD \n");
        sbSql.append("              --���̳�¥�� �԰����� ������ ��Ÿ���� üũ�Ͽ� �Ѿ����� ���� �Ϸ� �߰� \n");
        sbSql.append(" 	            /* ���� D_DAYS ���(���� +1 ����) */ \n");
        sbSql.append("            , DECODE( SIGN(TO_DATE(?,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) ) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
        sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) AS D_DAYS \n");
        sbSql.append("            , DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100) AS D_TIMES \n");
        sbSql.append("            , C.KG_CONVERT_RATE \n");
        sbSql.append("            , C.IMG_PATH AS IMAGE_PATH \n");
        sbSql.append("            , A.DANGA_ITEM_CODE, A.WEEK_ITEM_CODE, C.KEEPING_TYPE \n");
        sbSql.append("            , A.APPLY_SD, A.VD_SN \n");
        sbSql.append("            , C.ORIGIN_TYPE \n");
        sbSql.append("            , A.UPJANG_GRP \n");
        sbSql.append("         FROM \n");
         
        // ������ ���������(-2:��ü,�ܰ����庰) �ֹ������� ��ǰ�� ��Ÿ���ش�.
        if (strOnly.equals("TRUE"))
        {
        	sbSql.append("             (SELECT A.*, NULL AS DANGA_ITEM_CODE, NULL AS WEEK_ITEM_CODE \n");
            sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
	        sbSql.append("               WHERE 1=1 \n");
        	sbSql.append("               AND (CENTER_CODE, CUSTCD, ITEM_CODE) NOT IN \n");
            sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE(?,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
            sbSql.append("                       UNION ALL \n");
            sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = -2 \n");
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE(?,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
            sbSql.append("                       MINUS \n");
            sbSql.append("                      SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE(?,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y')) \n");
        }
        else
        {
        	sbSql.append("             (SELECT A.*, B.ITEM_CODE AS DANGA_ITEM_CODE, NULL AS WEEK_ITEM_CODE \n");
            sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
            sbSql.append("                   , (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE(?,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
            sbSql.append("                       UNION ALL \n");
            sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = -2 \n");
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE(?,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
            sbSql.append("                       MINUS \n");
            sbSql.append("                      SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE(?,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y') \n");
            sbSql.append("                     ) B \n");
            sbSql.append("               WHERE A.CENTER_CODE = B.CENTER_CODE(+) \n");
            sbSql.append("                 AND A.CUSTCD = B.CUSTCD(+) \n");
            sbSql.append("                 AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
        }
    	sbSql.append("              	   AND A.CENTER_CODE = ? \n");
    	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
    	sbSql.append("              	   AND A.UPJANG = ? \n");
    	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
    	sbSql.append("                     AND ? BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
    	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        // 2015.07.30 ���� �ܰ� ��� ���̺� ����(��������üũ)
    	sbSql.append("                     AND EXISTS (SELECT 1 FROM HLDC_PO_CONTRACT_F WHERE CENTER_CODE = A.CENTER_CODE AND UPJANG = A.UPJANG AND ITEM_CODE = A.ITEM_CODE AND CONTRACT_PRICE > 0 AND ? BETWEEN CONTRACT_START AND CONTRACT_END) \n");
    	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
		sbSql.append("             ) A \n");
        sbSql.append("            , HLDC_PO_ITEM_MST C \n");
        sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
        // FICS �ָ� ���� ���� ����
        if (strWeekendTimeCheck.equals("Y")){
            sbSql.append("            , FMS_WEEKEND_ITEM L \n");
        }
        sbSql.append("        WHERE A.ITEM_CODE = C.ITEM_CODE \n");
        sbSql.append("          AND A.SALE_PRICE > 0 \n");
        sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
        sbSql.append("          AND C.ITEM_CLASS1 = 'F' \n");
        sbSql.append("          AND C.CONSUM_YN = NVL(?,C.CONSUM_YN) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CONSUM_YN"));
        sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
        sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
        // FICS �ָ� ���� ���� ����
        if (strWeekendTimeCheck.equals("Y")){
            sbSql.append("          AND A.ITEM_CODE = L.ITEM_CODE \n");
            sbSql.append("          AND A.CENTER_CODE = L.CENTER_CODE \n");
            sbSql.append("          AND L.USE_YN = 'Y' \n");
        }
        sbSql.append("       ----------- \n");
        sbSql.append("        UNION ALL \n");
        sbSql.append("       ----------- \n");
        sbSql.append("       SELECT ? AS UPJANG, ? AS NEED_DATE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4 \n");
        sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
        sbSql.append("            , C.TAX_CODE, 0 AS CUSTCD, 'N' AS CENTER_FLAG \n");
        sbSql.append("            , '0' AS CENTER_CODE, C.POINT_FLAG \n");
        sbSql.append("            , A.UNIT_PRICE \n");
        sbSql.append("            , A.SALE_PRICE \n");
        sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");
        sbSql.append("            , C.OTCUSTCD \n");
        sbSql.append("              --���̳�¥�� �԰����� ������ ��Ÿ���� üũ�Ͽ� �Ѿ����� ���� �Ϸ� �߰� \n");
        sbSql.append("            , DECODE( SIGN(TO_DATE(?,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("                    , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1) \n");
        sbSql.append("                    , 0 ) + NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
        sbSql.append("            , DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) AS D_TIMES \n");
        sbSql.append("            , C.KG_CONVERT_RATE \n");
        sbSql.append("            , C.SIMAGE_PATH AS IMAGE_PATH \n");
        sbSql.append("            , NULL AS DANGA_ITEM_CODE, NULL AS WEEK_ITEM_CODE, C.KEEPING_TYPE \n");
        sbSql.append("            , '' AS APPLY_SD, '' AS VD_SN \n");
        sbSql.append("            , C.ORIGIN_TYPE \n");
        sbSql.append("            , '' AS UPJANG_GRP \n");
        sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
        sbSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
        sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
        sbSql.append("               WHERE UPJANG = ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "OTCUST_PRICE_UPJANG"));
        sbSql.append("                 AND SDATE <= ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("               GROUP BY UPJANG, ITEM_CODE \n");
        sbSql.append("              ) B \n");
        sbSql.append("            , FMP_OTCUST_ITEM C \n");
        sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
        sbSql.append("          AND A.SDATE = B.SDATE \n");
        sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
        sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
        sbSql.append("          AND A.SALE_PRICE > 0 \n");
        sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
        sbSql.append("          AND C.CONSUM_YN = NVL(?,C.CONSUM_YN) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CONSUM_YN"));
        sbSql.append("      ) A, \n");

        /////////////////////////////////////////////////////////////////20151008 Ʃ������ �߰�
        sbSql.append("      (SELECT ROW_NUMBER() OVER(ORDER BY CD_SY||CD_SM||CD_SD DESC) AS SEQ \n");
        sbSql.append("             ,CD_SY||CD_SM||CD_SD AS NONHOLI_DATE \n");
        sbSql.append("         FROM SCC_CALENDA_DATA \n");
        sbSql.append("        WHERE CD_SY||CD_SM||CD_SD < ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("          AND CD_SY BETWEEN TO_NUMBER(SUBSTR(?,1,4))-1 AND TO_NUMBER(SUBSTR(?,1,4)) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("          AND CD_WEEK NOT IN ('��')) KK \n");


        sbSql.append(" WHERE A.ITEM_CODE = CC.ITEM_CODE(+) \n");
        sbSql.append("   AND A.ITEM_CLASS4 = DD.ITEM_CODE(+) \n");

        /////////////////////////////////////////////////////////////////20151008 Ʃ������ �߰�
        sbSql.append("   AND A.D_DAYS = KK.SEQ(+) \n");

        sbSql.append("   AND A.OTCUSTCD = D.OTCUSTCD \n");

        //�߰�---- 20081211 �з��� ��ȸ �߰�. by Noh Kyu Wan
        sbSql.append("   AND A.ITEM_CLASS2 = NVL(?,A.ITEM_CLASS2) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "ITEM_CLASS2"));
        sbSql.append("   AND A.ITEM_CLASS3 = NVL(?,A.ITEM_CLASS3) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "ITEM_CLASS3"));
        sbSql.append("   AND A.ITEM_CLASS4 = NVL(?,A.ITEM_CLASS4) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "ITEM_CLASS4"));

        //�߰�---- 20081211
        sbSql.append("   AND D.OTCUSTCD = F.OTCUSTCD  \n");

        //����---- 20121214
        sbSql.append("   AND F.UPJANG = ((SELECT Z.MAIN_UPJANG FROM FMS_UPJANG Z WHERE UPJANG = ?)) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        
        sbSql.append("   AND F.USE_YN = 'Y'  \n");

        if (! strOnly.equals("TRUE"))
        {
            sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
            sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
            sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
            sbSql.append("   AND E.USE_YN(+) = 'Y' \n");
        }

        if (! strItemName.equals(""))
        {
            sbSql.append("   AND (		\n");
            sbSql.append("   		A.ITEM_CODE LIKE '%'||?||'%' \n");
            bindString[iBind++] = strItemName;
            sbSql.append("   	OR  A.ITEM_SIZE LIKE '%'||?||'%' \n");
            bindString[iBind++] = strItemName;
            sbSql.append("   	OR  A.ITEM_NAME LIKE '%'||?||'%' \n");
            bindString[iBind++] = strKeyword.replace(" ","").replace(",","%' OR A.ITEM_NAME like '%");
            sbSql.append("   	 ) \n");
        }
        if (strOnly.equals("TRUE"))
        {

            //�ܽ� SPOON �ý��� ��� �ϴ� ���� �ָ� ���� D-DAY üũ ���� ����.
            //if (g_SystemId.equals("SPOON"))
            if (Holiday_YN.equals("Y"))
            {
                sbSql.append("   AND TO_NUMBER(A.D_DAYS) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE(?,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
                bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            }
            else
            {
                //������ �𸣰����� ������ �������� ������ ��� �Լ��� ����� ��������...�׷��� �Լ����� �״�� ����
                //sbSql.append("   AND (FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS)) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
                sbSql.append("   AND (SELECT TO_NUMBER(TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')) \n");
                sbSql.append("          FROM (SELECT ROW_NUMBER() OVER(ORDER BY CD_SY||CD_SM||CD_SD DESC) AS SEQ \n");
                sbSql.append("                     , CD_SY||CD_SM||CD_SD AS NONHOLI_DATE \n");
                sbSql.append("                  FROM SCC_CALENDA_DATA \n");
                sbSql.append("                 WHERE CD_SY||CD_SM||CD_SD < ? \n");
                bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
                sbSql.append("                   AND CD_SY BETWEEN TO_NUMBER(SUBSTR(?,1,4))-1 AND TO_NUMBER(SUBSTR(?,1,4)) \n");
                bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
                bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
                sbSql.append("                   AND CD_WEEK NOT IN ('��')) Z \n");
                sbSql.append("         WHERE Z.SEQ = TO_NUMBER(A.D_DAYS)) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
            }
            //�ܽ� SPOON �ý��� ��� �ϴ� ���� �ָ� ���� D-DAY üũ ���� ����. by ��Կ� 2010-12-30
            sbSql.append("   AND NOT EXISTS \n");
            sbSql.append("      (SELECT 1 FROM FMP_ORD_LIMIT Z \n");
            sbSql.append("        WHERE Z.UPJANG = A.UPJANG \n");
            sbSql.append("          AND Z.ITEM_CODE = A.ITEM_CODE \n");
            sbSql.append("          AND A.NEED_DATE BETWEEN Z.SDATE AND Z.EDATE \n");
            sbSql.append("          AND Z.USE_YN = 'Y') \n");
        }

        sbSql.append("        ) T \n");
        sbSql.append("      , (SELECT /*+ INDEX(B.MR ESPSSGPITM_PK) */A.ITEM_CODE \n");
        sbSql.append("                , CASE WHEN B.DUTY_YN = 'Y' THEN '��ȹ����' \n");
        sbSql.append("                       WHEN A.MANUF_CD IS NOT NULL THEN '��ó��' \n");
        sbSql.append("                       WHEN B.PB_YN = 'Y' THEN 'PB��ǰ' \n");
        sbSql.append("                       WHEN A.ECO_ITEM IN ('�����','�����','�����','���׻���') THEN 'ģȯ��' \n");
        sbSql.append("                       ELSE '' \n");
        sbSql.append("                   END AS FEATURE_NAME \n");
        sbSql.append("                , CASE WHEN B.DUTY_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon11.png' \n");
        sbSql.append("                       WHEN A.MANUF_CD IS NOT NULL THEN 'theme://Images/new/grd_WF_Icon10.png' \n");
        sbSql.append("                       WHEN B.PB_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon09.png' \n");
        sbSql.append("                       WHEN A.ECO_ITEM IN ('�����','�����','�����','���׻���') THEN 'theme://Images/new/grd_WF_Icon08.png' \n");
        sbSql.append("                       ELSE '' \n");
        sbSql.append("                   END AS FEATURE_ICON \n");
        sbSql.append("             FROM EPROCUSR.MV_ITEM_MST3 A, EPROCUSR.VO_CONTRACT_F B \n");
        sbSql.append("            WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
        sbSql.append("              AND A.USE_YN = 'Y' \n");
        sbSql.append("              AND B.UPJANG(+) = ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        sbSql.append("              AND ? BETWEEN B.CONTRACT_START(+) AND B.CONTRACT_END(+) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("        ) U \n");

        
    	// ǰ��˻����� (0:��ü n:�ֱ�n����)
        if ( !nMonth.equals("0") )
        {
        	sbSql.append("		,( SELECT ITEM_CODE,                                                                              								\n");
        	sbSql.append("		                 PR_REMARK AS PR_REMARK_RECENT                                                          					\n");
        	sbSql.append("		         FROM    ( SELECT  ITEM_CODE,                                                         								\n");
        	sbSql.append("		                          ROW_NUMBER() OVER (PARTITION BY ITEM_CODE ORDER BY CREATE_DATE DESC) R,       								\n");
        	sbSql.append("		                          PR_REMARK                                                           								\n");
        	sbSql.append("		                 FROM     SO_PR                                                               								\n");
        	sbSql.append("		                 WHERE    RC_UPJANG = ?	  								\n");
        	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        	sbSql.append("		                 AND      TO_DATE(NEED_DATE, 'YYYYMMDD') BETWEEN ADD_MONTHS(SYSDATE, - ?) AND    SYSDATE 		\n");
        	bindString[iBind++] = nMonth;
        	//sbSql.append("          			 AND	  SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODET")) + "' 						\n");
        	sbSql.append("		                 )                                                                            								\n");
        	sbSql.append("		         WHERE   R = 1                                                                        								\n");
        	sbSql.append("		                                                                                              								\n");
        	sbSql.append("		         UNION ALL                                                                            								\n");
        	sbSql.append("		                                                                                              								\n");
        	sbSql.append("		         SELECT ITEM_CODE,                                                                    								\n");
        	sbSql.append("		                PR_REMARK AS PR_REMARK_RECENT                                                           					\n");
        	sbSql.append("		         FROM   ( SELECT  ITEM_CODE,                                                          								\n");
        	sbSql.append("		                         ROW_NUMBER() OVER (PARTITION BY ITEM_CODE ORDER BY CDATE DESC) R,        								\n");
        	sbSql.append("		                         REMARK AS PR_REMARK                                                  								\n");
        	sbSql.append("		                FROM     FMP_OTCUST_PR A                                                      								\n");
        	sbSql.append("		                WHERE    TO_DATE(A.NEED_DATE, 'YYYYMMDD') BETWEEN ADD_MONTHS(SYSDATE, -?) AND    SYSDATE 		\n");
        	bindString[iBind++] = nMonth;
        	sbSql.append("		                AND      A.UPJANG = ?       								\n");
        	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        	//sbSql.append("          			AND		 A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODET")) + "'						\n");
        	sbSql.append("		                )                                                                             								\n");
        	sbSql.append("		         WHERE  R = 1                                                                         								\n");
        	sbSql.append("		         )                                                                                    								\n");
        	sbSql.append("		         Y                                                                                    								\n");
        }
     
     
        sbSql.append(" WHERE T.ITEM_CODE = U.ITEM_CODE(+) \n");
        if (strOnly.equals("TRUE"))
        {
            sbSql.append("   AND T.PO_STATUS = 'HK' AND T.FMP_STATUS = 'N' AND T.PO_WEEK_STATUS = 'XR' \n"); // ����_������, ����_������, ����_��������
            sbSql.append("   AND T.UNUSE_YN <> 'UK' \n"); // ���� �ҿ����� 
            sbSql.append("   AND T.VAL_STP_YN <> 'TK' \n"); // ���� �������� üũ
        }
        

        // �ֱ� 3���� �ֹ� ���� ���縸 ��ȸ
        //if (strThreeMonth.equals("TRUE")) : OLD 
        // ǰ��˻����� (0:��ü n:�ֱ�n����) : TOBE
        if ( !nMonth.equals("0") )	
        {
            sbSql.append("   AND T.TOT_SO_AMT > 0 \n");
        	sbSql.append("   AND T.ITEM_CODE = Y.ITEM_CODE \n");
        }

        
		sbSql.append(" ORDER BY DECODE(U.FEATURE_NAME, '��ȹ����', '1', ''), NVL(T.TOT_SO_AMT, 0) DESC, T.ITEM_CODE \n");
        
//System.out.println(sbSql.toString());
out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        
        /*���ε� �߰�*/
        for(int i = 1 ; i < iBind ; i++)
        {
        	pstmt.setString(i, bindString[i]);
        }
        
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_List");

        pstmt.close();
        rs.close();

        /**����**/
        out_dl.add(ds_list);
        iBind = 1;
        this.setResultMessage(0, "OK", out_vl);

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