<%@page import="java.math.BigDecimal"%>
<%
    /*-----------------------------------------------------------------------------
    �� �ý��۸�     : �����ȹ����
    �� ���α׷�ID   : MAP30020E_T003.jsp
    �� ���α׷���   : ������ ���� Ȯ��
    �� �ۼ�����     : 2015-06-19
    �� �ۼ���       : ������
    �� �̷°���     :
    -----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
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

        //�Է� �Ķ����
        String g_Upjang = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));

        //FileLog.println("d:\\b.txt", ds_List);
        //FileLog.println("d:\\a.txt", ds_List_ALL);

        //sql�� ���ۻ���
        StringBuffer sbSql = new StringBuffer();

        // ������ �̷��Է� ȭ�鿡 ����� Ű���� ����
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') ISDATA2 							\n");
        sbSql.append("  FROM DUAL																	\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData2 = rs.getString("ISDATA2");

        // ������ �̷� ���� ����.
        for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            sbSql.delete(0, sbSql.length());
            sbSql.append(" INSERT INTO MAP_MON_PLAN_DTL	A														\n");
            sbSql.append("             ( A.CKEY 																\n");
            sbSql.append("             , A.UPJANG 																\n");
            sbSql.append("             , A.CC_CD																\n");
            sbSql.append("             , A.YY 																	\n");
            sbSql.append("             , A.VER_CD																\n");
            sbSql.append("             , A.ACCT_CD 																\n");
            sbSql.append("             , A.ACCT_NM 																\n");
            sbSql.append("             , A.JOB_GRADE_CD															\n");
            sbSql.append("             , A.JOB_GRADE_NM															\n");
            sbSql.append("             , A.ACCT_CLASS 															\n");
            sbSql.append("             , A.BIZ_CLASS 															\n");
            sbSql.append("             , A.MM_AMT_01 															\n");
            sbSql.append("             , A.MM_AMT_02 															\n");
            sbSql.append("             , A.MM_AMT_03 															\n");
            sbSql.append("             , A.MM_AMT_04 															\n");
            sbSql.append("             , A.MM_AMT_05 															\n");
            sbSql.append("             , A.MM_AMT_06 															\n");
            sbSql.append("             , A.MM_AMT_07 															\n");
            sbSql.append("             , A.MM_AMT_08 															\n");
            sbSql.append("             , A.MM_AMT_09 															\n");
            sbSql.append("             , A.MM_AMT_10 															\n");
            sbSql.append("             , A.MM_AMT_11 															\n");
            sbSql.append("             , A.MM_AMT_12 															\n");
            sbSql.append("             , A.CUSER 																\n");
            sbSql.append("             , A.CDATE 																\n");
            sbSql.append("             , A.UUSER 																\n");
            sbSql.append("             , A.UDATE ) 																\n");
            sbSql.append("      VALUES ( '" + isData2 + "'				 										\n");
            //sbSql.append("      VALUES ( TO_CHAR(SYSDATE, 'YYYYMMDDHH24MI') || ABS(ROUND(DBMS_RANDOM.VALUE(0, 100)))				 					\n");
            //sbSql.append("      VALUES ( (SELECT DECODE(MAX(CKEY), '', 0, MAX(CKEY)+1) FROM MAP_MON_PLAN_DTL)	\n");
            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 					\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 				\n");
            sbSql.append("             , (SELECT VER_CD FROM MAP_BPC_MODIFY_PLAN WHERE PLAN_CLASS = 'MP' AND OPEN_YN = 'Y') \n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_NM")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")) + "' 		\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_NM")) + "' 		\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CLASS")) + "' 			\n");
            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "' 				\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_01")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_02")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_03")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_04")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_05")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_06")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_07")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_08")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_09")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_10")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_11")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_12")) * 1000 + "' 	\n");
            sbSql.append("             , '" + g_EmpNo + "' 														\n");
            sbSql.append("             , SYSDATE 																\n");
            sbSql.append("             , '" + g_EmpNo + "' 														\n");
            sbSql.append("             , SYSDATE 																\n");
            sbSql.append("             ) 																		\n");

            out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
        }

        //�Է�,����
        //for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
        //{
        sbSql.delete(0, sbSql.length());
        sbSql.append("      UPDATE MAP_MON_LOG_MGMT                           								\n");
        sbSql.append("         SET CONFIRM_YN = '" + "Y" + "' 												\n");
        sbSql.append("           , BPC_SEND_YN = '" + "Y" + "'												\n");
        sbSql.append("           , UDATE      = SYSDATE 													\n");
        sbSql.append("           , UUSER      = '" + g_EmpNo + "' 											\n");
        sbSql.append("       WHERE UPJANG     = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'		\n");
        sbSql.append("         AND YY     	  = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'		\n");
        sbSql.append("         AND BIZ_CLASS  = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'	\n");

        out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        pstmt.executeUpdate();
        pstmt.close();
        //}// END FOR

        // ������ BPC�� ������ �����Ͱ� ������ ���� �� �μ�Ʈ �Ѵ�.
        // ȭ�鿡�� ��ȸ�� CC_CD�� �����ϴ°� �ƴ϶� ��ȸ�� �������� CC_CD�� �����Ѵ�!
        //for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ ){
        for (int iRow = 1; iRow < 2; iRow++) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("      DELETE MAP_BPC_BIZ_PLAN_INFO                           							\n");
            sbSql.append("       WHERE CC_CD     = '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "'		\n");
            sbSql.append("         AND PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'		\n");
            sbSql.append("         AND PLAN_CLASS  = '" + "MP" + "'												\n");

            out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
        } // END FOR

        //������ Ȯ������ FC -> BPC�� ���� ����

        List<AcctPlanReqDTO> lst = new ArrayList<AcctPlanReqDTO>();

        for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("      INSERT INTO MAP_BPC_BIZ_PLAN_INFO 		\n");
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
            sbSql.append("      VALUES ( '" + "MP" + "' 														\n");
            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "VER_CD")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "' 				\n");
            //sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 				\n");
            sbSql.append("             , '" + "100000" + "'	 													\n");
            //sbSql.append("             , DECODE('" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")) + "', '', 'N_RANK') \n");
            sbSql.append("             , '" + "N_RANK" + "' 													\n");
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
            acctPlanReqDTO01.setPlanType("MP");
            acctPlanReqDTO01.setPlanYear(nullToBlank(ds_Cond.getString(0, "INPUT_YY")));
            acctPlanReqDTO01.setVerCd(nullToBlank(ds_List.getString(iRow, "VER_CD")));
            acctPlanReqDTO01.setCcCd(nullToBlank(ds_List.getString(iRow, "CC_CD")));
            acctPlanReqDTO01.setJobGradeCd("".equals(nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD"))) ? "N_RANK" : nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")));
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
        } // END FOR

        // EAI ȣ��.
        EAIService eaiService = (EAIService) BeanUtil.getBean("EAIService");
        AcctPlanReqList acctPlanReqList = new AcctPlanReqList();
        acctPlanReqList.setDataList(lst);

        EAIResponse res = eaiService.call(acctPlanReqList);

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