
<%
    /*-----------------------------------------------------------------------------
    �� �ý��۸�     : �����ȹ����
    �� ���α׷�ID   : MAP30010E_T004.jsp
    �� ���α׷���   : �����ȹ���� ����Ȯ��
    �� �ۼ�����     : 2015-06-21
    �� �ۼ���       : ������
    �� �̷°���     :
    -----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.hwfs.sc.cmn.sap.dto.AcctPlanReqDTO"%>
<%@ page import="com.hwfs.sc.cmn.sap.service.EAIService"%>
<%@ page import="com.hwfs.sc.cmn.sap.list.AcctPlanReqList"%>
<%@ page import="com.hwfs.sc.cmn.util.*"%>
<%@ page import="com.hwfs.sc.cmn.sap.EAIResponse"%>

<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log ���� ����
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //�Է� ����Ÿ
        DataSet ds_Cond = in_dl.get("ds_Cond");
        DataSet ds_List = in_dl.get("ds_List");// ����� ����Ÿ
        DataSet ds_ListDtl = in_dl.get("ds_ListDtl"); // FC -> BPC�� ������ ����Ÿ
        DataSet ds_ListDtl2 = in_dl.get("ds_ListDtl2"); // FC -> BPC�� ������ �ΰǺ� ����Ÿ

        //�Է� �Ķ����
        String g_Upjang = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));

        //FileLog.println("d:\\b.txt", ds_List);
        //FileLog.println("d:\\a.txt", ds_List_ALL);

        //sql�� ���ۻ���
        StringBuffer sbSql = new StringBuffer();

        // �繫�ݾ����� ������ ���� ������ ��ȸ
        double marginRate01 = 100.0;
        double marginRate02 = 100.0;
        double marginRate03 = 100.0;
        double marginRate04 = 100.0;
        double marginRate05 = 100.0;
        double marginRate06 = 100.0;
        double marginRate07 = 100.0;
        double marginRate08 = 100.0;
        double marginRate09 = 100.0;
        double marginRate10 = 100.0;
        double marginRate11 = 100.0;
        double marginRate12 = 100.0;

        // ���⼭�� �������� �ǹ̰� ����
        // ��ȸ �� �̸� U_MM_AMT�� ��Ƽ� �´�.
        sbSql.delete(0, sbSql.length());
        sbSql.append(" SELECT NVL(A.MM_MARGIN_RATE_01, 100) AS MM_MARGIN_RATE_01 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_02, 100) AS MM_MARGIN_RATE_02 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_03, 100) AS MM_MARGIN_RATE_03 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_04, 100) AS MM_MARGIN_RATE_04 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_05, 100) AS MM_MARGIN_RATE_05 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_06, 100) AS MM_MARGIN_RATE_06 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_07, 100) AS MM_MARGIN_RATE_07 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_08, 100) AS MM_MARGIN_RATE_08 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_09, 100) AS MM_MARGIN_RATE_09 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_10, 100) AS MM_MARGIN_RATE_10 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_11, 100) AS MM_MARGIN_RATE_11 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_12, 100) AS MM_MARGIN_RATE_12 \n");
        sbSql.append("   FROM MAP_MARGIN_RATE_MGMT A \n");
        sbSql.append("      , SCO_UPJANG_MST_V B \n");
        sbSql.append("  WHERE A.UPJANG(+) = B.UPJANG \n");
        sbSql.append("    AND A.CLASS(+) = 'P' \n");
        sbSql.append("    AND A.YY(+) = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' \n");
        sbSql.append("    AND B.CLOSE_DATE IS NULL \n");
        //sbSql.append("    AND B.MU_CD = '2002' \n");
        //sbSql.append("    AND (B.TM_CD = 'CDH' OR PT_CD = 'CDH') \n");
        sbSql.append("    AND B.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        while (rs.next()) {
            marginRate01 = rs.getDouble("MM_MARGIN_RATE_01");
            marginRate02 = rs.getDouble("MM_MARGIN_RATE_02");
            marginRate03 = rs.getDouble("MM_MARGIN_RATE_03");
            marginRate04 = rs.getDouble("MM_MARGIN_RATE_04");
            marginRate05 = rs.getDouble("MM_MARGIN_RATE_05");
            marginRate06 = rs.getDouble("MM_MARGIN_RATE_06");
            marginRate07 = rs.getDouble("MM_MARGIN_RATE_07");
            marginRate08 = rs.getDouble("MM_MARGIN_RATE_08");
            marginRate09 = rs.getDouble("MM_MARGIN_RATE_09");
            marginRate10 = rs.getDouble("MM_MARGIN_RATE_10");
            marginRate11 = rs.getDouble("MM_MARGIN_RATE_11");
            marginRate12 = rs.getDouble("MM_MARGIN_RATE_12");
        }
        rs.close();
        pstmt.close();

        //�Է�,����
        //for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
        //{
        sbSql.delete(0, sbSql.length());
        sbSql.append("      UPDATE MAP_BIZ_LOG_MGMT                           								\n");
        sbSql.append("         SET BPC_SEND_YN= '" + "Y" + "' 												\n");
        sbSql.append("           , UDATE      = SYSDATE 													\n");
        sbSql.append("           , UUSER      = '" + g_EmpNo + "' 											\n");
        sbSql.append("       WHERE UPJANG     = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'		\n");
        sbSql.append("         AND YY     	  = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'		\n");
        //sbSql.append("         AND BIZ_CLASS  = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");

        out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        pstmt.executeUpdate();
        pstmt.close();
        //}// END FOR

        // �������� �������� ���°��� 'S'�� �����Ͽ� �ٽ� �������� ���ϰ� �Ѵ�.
        sbSql.delete(0, sbSql.length());
        sbSql.append("      UPDATE MAP_IMPROV_MGT_MST                           							\n");
        sbSql.append("         SET APPROV_YN= '" + "S" + "' 												\n");
        sbSql.append("           , UDATE      = SYSDATE 													\n");
        sbSql.append("           , UUSER      = '" + g_EmpNo + "' 											\n");
        sbSql.append("       WHERE UPJANG     = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'		\n");
        sbSql.append("         AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' BETWEEN APPLY_ST_DT AND APPLY_ND_DT	\n");
        //sbSql.append("         AND YY     	  = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'		\n");
        //sbSql.append("         AND BIZ_CLASS  = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");

        out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        pstmt.executeUpdate();
        pstmt.close();

        // ������ BPC�� ������ �����Ͱ� ������ ���� �� �μ�Ʈ �Ѵ�.
        // ȭ�鿡�� ��ȸ�� CC_CD�� �����ϴ°� �ƴ϶� ��ȸ�� �������� CC_CD�� �����Ѵ�!
        //for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ ){
        for (int iRow = 0; iRow < 1; iRow++) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("      DELETE MAP_BPC_BIZ_PLAN_INFO	                           						\n");
            sbSql.append("       WHERE CC_CD     = '" + nullToBlank(ds_List.getString(0, "CC_CD")) + "'			\n");
            sbSql.append("         AND PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'			\n");
            sbSql.append("         AND PLAN_CLASS  = '" + "AP" + "'												\n");

            out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
        } // END FOR

        //�����ȹ(����PL ����) FC -> BPC�� ����PL ���� ���� (���� �ݾ��� �繫�ݾ����� ��ȯ�ؼ� ����)
        ///*
        List<AcctPlanReqDTO> lst = new ArrayList<AcctPlanReqDTO>();

        for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            // �������� ������ ����. 43102010 43102020 43102030
           // if (!"44000000".equals(ds_List.getString(iRow, "ACCT_CD")) && !"43102010".equals(ds_List.getString(iRow, "ACCT_CD")) && !"43102020".equals(ds_List.getString(iRow, "ACCT_CD")) && !"43102030".equals(ds_List.getString(iRow, "ACCT_CD"))) {
             if (!"44000000".equals(ds_List.getString(iRow, "ACCT_CD"))) { 
        	   sbSql.delete(0, sbSql.length());
                sbSql.append("      INSERT INTO MAP_BPC_BIZ_PLAN_INFO	 	\n");
                sbSql.append("      	   ( PLAN_CLASS 					\n");
                sbSql.append("             , PLAN_YEAR 						\n");
                sbSql.append("             , VER_CD 						\n");
                sbSql.append("             , CC_CD 							\n");
                sbSql.append("             , UPJANG							\n");
                sbSql.append("             , JOB_GRADE_CD 					\n");
                sbSql.append("             , JOB_GRADE_NM 					\n");
                sbSql.append("             , ACCT_CD 						\n");
                sbSql.append("             , ACCT_NM 						\n");
                sbSql.append("             , MM_AMT_01 						\n");
                sbSql.append("             , MM_AMT_02 						\n");
                sbSql.append("             , MM_AMT_03 						\n");
                sbSql.append("             , MM_AMT_04 						\n");
                sbSql.append("             , MM_AMT_05 						\n");
                sbSql.append("             , MM_AMT_06 						\n");
                sbSql.append("             , MM_AMT_07 						\n");
                sbSql.append("             , MM_AMT_08 						\n");
                sbSql.append("             , MM_AMT_09 						\n");
                sbSql.append("             , MM_AMT_10 						\n");
                sbSql.append("             , MM_AMT_11 						\n");
                sbSql.append("             , MM_AMT_12 						\n");
                sbSql.append("             , CUSER 							\n");
                sbSql.append("             , CDATE 							\n");
                sbSql.append("             , UUSER 							\n");
                sbSql.append("             , UDATE ) 						\n");
                sbSql.append("      VALUES ( '" + "AP" + "' 														\n");
                sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 				\n");
                sbSql.append("             , '" + nullToBlank(ds_List.getString(0, "VER_CD")) + "' 					\n");
                sbSql.append("             , '" + nullToBlank(ds_List.getString(0, "CC_CD")) + "' 					\n");
                //sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 					\n");
                sbSql.append("             , '" + "100000" + "' 													\n");
                //sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")) + "' 		\n");
                sbSql.append("             , DECODE('" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")) + "', '', 'N_RANK', '" + ds_List.getString(iRow, "JOB_GRADE_CD") + "') \n");
                sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_NM")) + "' 		\n");
                sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "' 				\n");
                sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_NM")) + "' 				\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_01")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_02")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_03")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_04")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_05")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_06")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_07")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_08")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_09")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_10")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_11")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "U_MM_AMT_12")) * 1000 + "' \n");
                sbSql.append("             , '" + g_EmpNo + "' 														\n");
                sbSql.append("             , SYSDATE 																\n");
                sbSql.append("             , '" + g_EmpNo + "' 														\n");
                sbSql.append("             , SYSDATE 																\n");
                sbSql.append("             ) 																		\n");

                AcctPlanReqDTO acctPlanReqDTO01 = new AcctPlanReqDTO();
                acctPlanReqDTO01.setPlanType("AP");
                acctPlanReqDTO01.setPlanYear(nullToBlank(ds_Cond.getString(0, "INPUT_YY")));
                acctPlanReqDTO01.setVerCd(nullToBlank(ds_List.getString(iRow, "VER_CD")));
                acctPlanReqDTO01.setCcCd(nullToBlank(ds_List.getString(iRow, "CC_CD")));
                acctPlanReqDTO01.setJobGradeCd("".equals(nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD"))) ? "N_RANK" : nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")));
                //acctPlanReqDTO01.setUpjang(100000);
                acctPlanReqDTO01.setUpjang(BigDecimal.valueOf(Long.valueOf(100000)));
                acctPlanReqDTO01.setAcctCd(nullToBlank(ds_List.getString(iRow, "ACCT_CD")));
                acctPlanReqDTO01.setAcctNm(nullToBlank(ds_List.getString(iRow, "ACCT_NM")));
                acctPlanReqDTO01.setJobGradeNm(nullToBlank(ds_List.getString(iRow, "JOB_GRADE_NM")));
                acctPlanReqDTO01.setMmAmt01(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_01")) * 1000));
                acctPlanReqDTO01.setMmAmt02(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_02")) * 1000));
                acctPlanReqDTO01.setMmAmt03(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_03")) * 1000));
                acctPlanReqDTO01.setMmAmt04(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_04")) * 1000));
                acctPlanReqDTO01.setMmAmt05(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_05")) * 1000));
                acctPlanReqDTO01.setMmAmt06(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_06")) * 1000));
                acctPlanReqDTO01.setMmAmt07(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_07")) * 1000));
                acctPlanReqDTO01.setMmAmt08(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_08")) * 1000));
                acctPlanReqDTO01.setMmAmt09(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_09")) * 1000));
                acctPlanReqDTO01.setMmAmt10(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_10")) * 1000));
                acctPlanReqDTO01.setMmAmt11(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_11")) * 1000));
                acctPlanReqDTO01.setMmAmt12(BigDecimal.valueOf(Long.valueOf(ds_List.getString(iRow, "U_MM_AMT_12")) * 1000));

                lst.add(acctPlanReqDTO01);

                out_vl.add("fa_Sql", sbSql.toString());
                //System.out.println(sbSql.toString());
                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();
            }
        } // END FOR

        // ������
        for (int iRow = 0; iRow < ds_ListDtl.getRowCount(); iRow++) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("      INSERT INTO MAP_BPC_BIZ_PLAN_INFO	 	\n");
            sbSql.append("      	   ( PLAN_CLASS 					\n");
            sbSql.append("             , PLAN_YEAR 						\n");
            sbSql.append("             , VER_CD 						\n");
            sbSql.append("             , CC_CD 							\n");
            sbSql.append("             , UPJANG							\n");
            sbSql.append("             , JOB_GRADE_CD 					\n");
            sbSql.append("             , JOB_GRADE_NM 					\n");
            sbSql.append("             , ACCT_CD 						\n");
            sbSql.append("             , ACCT_NM 						\n");
            sbSql.append("             , MM_AMT_01 						\n");
            sbSql.append("             , MM_AMT_02 						\n");
            sbSql.append("             , MM_AMT_03 						\n");
            sbSql.append("             , MM_AMT_04 						\n");
            sbSql.append("             , MM_AMT_05 						\n");
            sbSql.append("             , MM_AMT_06 						\n");
            sbSql.append("             , MM_AMT_07 						\n");
            sbSql.append("             , MM_AMT_08 						\n");
            sbSql.append("             , MM_AMT_09 						\n");
            sbSql.append("             , MM_AMT_10 						\n");
            sbSql.append("             , MM_AMT_11 						\n");
            sbSql.append("             , MM_AMT_12 						\n");
            sbSql.append("             , CUSER 							\n");
            sbSql.append("             , CDATE 							\n");
            sbSql.append("             , UUSER 							\n");
            sbSql.append("             , UDATE ) 						\n");
            sbSql.append("      VALUES ( '" + "AP" + "' 														\n");
            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "VER_CD")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "' 				\n");
            //sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 					\n");
            sbSql.append("             , '" + "100000" + "' 													\n");
            //sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")) + "' 		\n");
            sbSql.append("             , DECODE('" + nullToBlank(ds_ListDtl.getString(iRow, "JOB_GRADE_CD")) + "', '', 'N_RANK2', 'N_RANK', 'N_RANK2', '" + ds_ListDtl.getString(iRow, "JOB_GRADE_CD") + "') \n");
            sbSql.append("             , '" + nullToBlank(ds_ListDtl.getString(iRow, "JOB_GRADE_NM")) + "' 		 \n");
            sbSql.append("             , '" + nullToBlank(ds_ListDtl.getString(iRow, "ACCT_CD")) + "' 			 \n");
            sbSql.append("             , '" + nullToBlank(ds_ListDtl.getString(iRow, "ACCT_NM")) + "' 			 \n");
            if (!"HRCNT".equals(nullToBlank(ds_ListDtl.getString(iRow, "ACCT_CD")))) {
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_01")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_02")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_03")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_04")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_05")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_06")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_07")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_08")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_09")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_10")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_11")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_12")) * 1000 + "' \n");
            } else {
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_01")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_02")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_03")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_04")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_05")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_06")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_07")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_08")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_09")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_10")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_11")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl.getString(iRow, "MM_AMT_12")) + "' \n");
            }

            sbSql.append("             , '" + g_EmpNo + "' 														\n");
            sbSql.append("             , SYSDATE 																\n");
            sbSql.append("             , '" + g_EmpNo + "' 														\n");
            sbSql.append("             , SYSDATE 																\n");
            sbSql.append("             ) 																		\n");
            ///*

            AcctPlanReqDTO acctPlanReqDTO02 = new AcctPlanReqDTO();

            if (!"N_RANK".equals(nullToBlank(ds_ListDtl.getString(iRow, "JOB_GRADE_CD")))) {
                acctPlanReqDTO02.setPlanType("AP");
                acctPlanReqDTO02.setPlanYear(nullToBlank(ds_Cond.getString(0, "INPUT_YY")));
                acctPlanReqDTO02.setVerCd(nullToBlank(ds_List.getString(iRow, "VER_CD")));
                acctPlanReqDTO02.setCcCd(nullToBlank(ds_List.getString(iRow, "CC_CD")));
                acctPlanReqDTO02.setJobGradeCd("".equals(nullToBlank(ds_ListDtl.getString(iRow, "JOB_GRADE_CD"))) ? "N_RANK" : nullToBlank(ds_ListDtl.getString(iRow, "JOB_GRADE_CD")));
                //acctPlanReqDTO02.setUpjang(100000);
                acctPlanReqDTO02.setUpjang(BigDecimal.valueOf(Long.valueOf(100000)));
                acctPlanReqDTO02.setAcctCd(nullToBlank(ds_ListDtl.getString(iRow, "ACCT_CD")));
                acctPlanReqDTO02.setAcctNm(nullToBlank(ds_ListDtl.getString(iRow, "ACCT_NM")));
                acctPlanReqDTO02.setJobGradeNm(nullToBlank(ds_ListDtl.getString(iRow, "JOB_GRADE_NM")));

                if (!"HRCNT".equals(nullToBlank(ds_ListDtl.getString(iRow, "ACCT_CD")))) {
                    acctPlanReqDTO02.setMmAmt01(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_01")) * 1000));
                    acctPlanReqDTO02.setMmAmt02(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_02")) * 1000));
                    acctPlanReqDTO02.setMmAmt03(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_03")) * 1000));
                    acctPlanReqDTO02.setMmAmt04(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_04")) * 1000));
                    acctPlanReqDTO02.setMmAmt05(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_05")) * 1000));
                    acctPlanReqDTO02.setMmAmt06(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_06")) * 1000));
                    acctPlanReqDTO02.setMmAmt07(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_07")) * 1000));
                    acctPlanReqDTO02.setMmAmt08(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_08")) * 1000));
                    acctPlanReqDTO02.setMmAmt09(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_09")) * 1000));
                    acctPlanReqDTO02.setMmAmt10(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_10")) * 1000));
                    acctPlanReqDTO02.setMmAmt11(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_11")) * 1000));
                    acctPlanReqDTO02.setMmAmt12(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_12")) * 1000));
                } else {
                    acctPlanReqDTO02.setMmAmt01(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_01"))));
                    acctPlanReqDTO02.setMmAmt02(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_02"))));
                    acctPlanReqDTO02.setMmAmt03(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_03"))));
                    acctPlanReqDTO02.setMmAmt04(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_04"))));
                    acctPlanReqDTO02.setMmAmt05(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_05"))));
                    acctPlanReqDTO02.setMmAmt06(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_06"))));
                    acctPlanReqDTO02.setMmAmt07(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_07"))));
                    acctPlanReqDTO02.setMmAmt08(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_08"))));
                    acctPlanReqDTO02.setMmAmt09(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_09"))));
                    acctPlanReqDTO02.setMmAmt10(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_10"))));
                    acctPlanReqDTO02.setMmAmt11(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_11"))));
                    acctPlanReqDTO02.setMmAmt12(BigDecimal.valueOf(Long.valueOf(ds_ListDtl.getString(iRow, "MM_AMT_12"))));
                } // else
                lst.add(acctPlanReqDTO02);
            } // end if

            //*/
            out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
        } // END FOR
            //System.out.println("==================================>"+ds_ListDtl2.getRowCount());
            // ������
        for (int iRow = 0; iRow < ds_ListDtl2.getRowCount(); iRow++) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("      INSERT INTO MAP_BPC_BIZ_PLAN_INFO	 	\n");
            sbSql.append("      	   ( PLAN_CLASS 					\n");
            sbSql.append("             , PLAN_YEAR 						\n");
            sbSql.append("             , VER_CD 						\n");
            sbSql.append("             , CC_CD 							\n");
            sbSql.append("             , UPJANG							\n");
            sbSql.append("             , JOB_GRADE_CD 					\n");
            sbSql.append("             , JOB_GRADE_NM 					\n");
            sbSql.append("             , ACCT_CD 						\n");
            sbSql.append("             , ACCT_NM 						\n");
            sbSql.append("             , MM_AMT_01 						\n");
            sbSql.append("             , MM_AMT_02 						\n");
            sbSql.append("             , MM_AMT_03 						\n");
            sbSql.append("             , MM_AMT_04 						\n");
            sbSql.append("             , MM_AMT_05 						\n");
            sbSql.append("             , MM_AMT_06 						\n");
            sbSql.append("             , MM_AMT_07 						\n");
            sbSql.append("             , MM_AMT_08 						\n");
            sbSql.append("             , MM_AMT_09 						\n");
            sbSql.append("             , MM_AMT_10 						\n");
            sbSql.append("             , MM_AMT_11 						\n");
            sbSql.append("             , MM_AMT_12 						\n");
            sbSql.append("             , CUSER 							\n");
            sbSql.append("             , CDATE 							\n");
            sbSql.append("             , UUSER 							\n");
            sbSql.append("             , UDATE ) 						\n");
            sbSql.append("      VALUES ( '" + "AP" + "' 														\n");
            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "VER_CD")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "' 				\n");
            //sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 					\n");
            sbSql.append("             , '" + "100000" + "' 													\n");
            //sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")) + "' 		\n");
            sbSql.append("             , DECODE('" + nullToBlank(ds_ListDtl2.getString(iRow, "JOB_GRADE_CD")) + "', '', 'N_RANK', '" + ds_ListDtl2.getString(iRow, "JOB_GRADE_CD") + "') \n");
            sbSql.append("             , '" + nullToBlank(ds_ListDtl2.getString(iRow, "JOB_GRADE_NM")) + "' 		 \n");
            sbSql.append("             , '" + nullToBlank(ds_ListDtl2.getString(iRow, "ACCT_CD")) + "' 			 \n");
            sbSql.append("             , '" + nullToBlank(ds_ListDtl2.getString(iRow, "ACCT_NM")) + "' 			 \n");

            if (!"HRCNT".equals(nullToBlank(ds_ListDtl2.getString(iRow, "ACCT_CD")))) {
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_01")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_02")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_03")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_04")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_05")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_06")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_07")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_08")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_09")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_10")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_11")) * 1000 + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_12")) * 1000 + "' \n");
            } else {
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_01")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_02")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_03")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_04")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_05")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_06")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_07")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_08")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_09")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_10")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_11")) + "' \n");
                sbSql.append("             , '" + stringToFloat(ds_ListDtl2.getString(iRow, "MM_AMT_12")) + "' \n");
            }
            sbSql.append("             , '" + g_EmpNo + "' 														\n");
            sbSql.append("             , SYSDATE 																\n");
            sbSql.append("             , '" + g_EmpNo + "' 														\n");
            sbSql.append("             , SYSDATE 																\n");
            sbSql.append("             ) 																		\n");

            AcctPlanReqDTO acctPlanReqDTO03 = new AcctPlanReqDTO();
            acctPlanReqDTO03.setPlanType("AP");
            acctPlanReqDTO03.setPlanYear(nullToBlank(ds_Cond.getString(0, "INPUT_YY")));
            acctPlanReqDTO03.setVerCd(nullToBlank(ds_List.getString(iRow, "VER_CD")));
            acctPlanReqDTO03.setCcCd(nullToBlank(ds_List.getString(iRow, "CC_CD")));
            acctPlanReqDTO03.setJobGradeCd("".equals(nullToBlank(ds_ListDtl2.getString(iRow, "JOB_GRADE_CD"))) ? "N_RANK" : nullToBlank(ds_ListDtl2.getString(iRow, "JOB_GRADE_CD")));
            //acctPlanReqDTO03.setJobGradeCd("FS-1486");
            //acctPlanReqDTO03.setUpjang(100000);
            acctPlanReqDTO03.setUpjang(BigDecimal.valueOf(Long.valueOf(100000)));
            acctPlanReqDTO03.setAcctCd(nullToBlank(ds_ListDtl2.getString(iRow, "ACCT_CD")));
            acctPlanReqDTO03.setAcctNm(nullToBlank(ds_ListDtl2.getString(iRow, "ACCT_NM")));
            acctPlanReqDTO03.setJobGradeNm(nullToBlank(ds_ListDtl2.getString(iRow, "JOB_GRADE_NM")));

            if (!"HRCNT".equals(nullToBlank(ds_ListDtl2.getString(iRow, "ACCT_CD")))) {
                acctPlanReqDTO03.setMmAmt01(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_01")) * 1000));
                acctPlanReqDTO03.setMmAmt02(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_02")) * 1000));
                acctPlanReqDTO03.setMmAmt03(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_03")) * 1000));
                acctPlanReqDTO03.setMmAmt04(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_04")) * 1000));
                acctPlanReqDTO03.setMmAmt05(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_05")) * 1000));
                acctPlanReqDTO03.setMmAmt06(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_06")) * 1000));
                acctPlanReqDTO03.setMmAmt07(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_07")) * 1000));
                acctPlanReqDTO03.setMmAmt08(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_08")) * 1000));
                acctPlanReqDTO03.setMmAmt09(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_09")) * 1000));
                acctPlanReqDTO03.setMmAmt10(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_10")) * 1000));
                acctPlanReqDTO03.setMmAmt11(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_11")) * 1000));
                acctPlanReqDTO03.setMmAmt12(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_12")) * 1000));

            } else {
                acctPlanReqDTO03.setMmAmt01(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_01"))));
                acctPlanReqDTO03.setMmAmt02(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_02"))));
                acctPlanReqDTO03.setMmAmt03(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_03"))));
                acctPlanReqDTO03.setMmAmt04(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_04"))));
                acctPlanReqDTO03.setMmAmt05(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_05"))));
                acctPlanReqDTO03.setMmAmt06(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_06"))));
                acctPlanReqDTO03.setMmAmt07(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_07"))));
                acctPlanReqDTO03.setMmAmt08(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_08"))));
                acctPlanReqDTO03.setMmAmt09(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_09"))));
                acctPlanReqDTO03.setMmAmt10(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_10"))));
                acctPlanReqDTO03.setMmAmt11(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_11"))));
                acctPlanReqDTO03.setMmAmt12(BigDecimal.valueOf(Long.valueOf(ds_ListDtl2.getString(iRow, "MM_AMT_12"))));
            }

            lst.add(acctPlanReqDTO03);

            out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
        } // END FOR

        // EAI ȣ��.
        EAIService eaiService = (EAIService) BeanUtil.getBean("EAIService");
        AcctPlanReqList acctPlanReqList = new AcctPlanReqList();
        acctPlanReqList.setDataList(lst);

        EAIResponse res = eaiService.call(acctPlanReqList);

        if (res.isSuccess()) {
            //TODO :: ������ ���Ͽ� ������ �ڵ��ϼ���.
            //list = res.getListMap();
        } else {
            // TODO :: ����� ���ų� ������ ��쿡 �Ʒ��� ������ �ڵ��ϼ���....
            logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
        }

        //*/
        /**����**/
        conn.commit();
        this.setResultMessage(0, "OK", out_vl);
    } catch (Exception ex) {
        conn.rollback();
        //ex.printStackTrace();
        //jsp �α׳����
        logger.debug(ex.getMessage(), ex);
        this.setResultMessage(-1, ex.toString(), out_vl);
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (Exception e) {
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
            }
        }
        //jsp log ���� �ݱ�
        try {
            logger.endIndividualLog();
        } catch (Exception logE) {
            logE.printStackTrace();
        }
    }

    proc_output(response, out, out_vl, out_dl);
%>