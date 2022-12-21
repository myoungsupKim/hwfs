<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/신청관리
■ 프로그램ID   : FSP00420V_T001.jsp
■ 프로그램명   : 자재구매신청량(관리자용)
■ 작성일자     : 2012-11-05
■ 작성자       : 박은규
■ 이력관리     : 1)박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
               최초작성
-----------------------------------------------------------------------------*/
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
		String MU_CD       = nullToBlank(in_vl.getString("MU_CD"));
		String TM_CD       = nullToBlank(in_vl.getString("TM_CD"));
		String UPJANG      = nullToBlank(in_vl.getString("UPJANG"));
		String CENTER_CODE = nullToBlank(in_vl.getString("CENTER_CODE"));
		String SDATE       = nullToBlank(in_vl.getString("SDATE"));
		String EDATE       = nullToBlank(in_vl.getString("EDATE"));
		String UNIT        = nullToBlank(in_vl.getString("UNIT"));
		String JOB_CD      = nullToBlank(in_vl.getString("JOB_CD"));
		String SUB_JOB_CD  = nullToBlank(in_vl.getString("SUB_JOB_CD"));
		String CUSTCD      = nullToBlank(in_vl.getString("CUSTCD"));
		String CLASS1      = nullToBlank(in_vl.getString("CLASS1"));
		String CLASS2      = nullToBlank(in_vl.getString("CLASS2"));
		String CLASS3      = nullToBlank(in_vl.getString("CLASS3"));
		String CLASS4      = nullToBlank(in_vl.getString("CLASS4"));
		String ITEM        = nullToBlank(in_vl.getString("ITEM"));
		String SC_CD       = nullToBlank(in_vl.getString("SC_CD"));
		String ITEM_CNT    = nullToBlank(in_vl.getString("ITEM_CNT"));
		String TAB_INDEX   = nullToBlank(in_vl.getString("TAB_INDEX"));
		String strItemLst  = nullToBlank(in_vl.getString("strItemLst"));
		String strSCLst    = nullToBlank(in_vl.getString("strSCLst"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		/*
        sbSql.append("SELECT A.ITEM_CLASS1 \n");
        sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS1 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'L') AS CLASS1_NAME \n");
        if (TAB_INDEX.equals("A"))
        {
	        sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME \n");
        }
        if (TAB_INDEX.equals("B"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME \n");
        }
        if (TAB_INDEX.equals("C"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME \n");
        	sbSql.append("     , A.ITEM_CLASS4 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS4 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'D') AS CLASS4_NAME \n");
        }
        if (TAB_INDEX.equals("D1"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME \n");
        	sbSql.append("     , A.ITEM_CLASS4 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS4 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'D') AS CLASS4_NAME \n");
        	sbSql.append("     , A.ITEM_CODE \n");
        	sbSql.append("     , A.ITEM_NAME \n");
        	sbSql.append("     , A.ITEM_SIZE \n");
        	sbSql.append("     , A.PO_UOM \n");
        	sbSql.append("     , A.FEATURE_NAME \n");
        }
        if (TAB_INDEX.equals("D0"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME \n");
        	sbSql.append("     , A.ITEM_CLASS4 \n");
	        sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS4 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'D') AS CLASS4_NAME \n");
    	    sbSql.append("     , A.ITEM_CODE \n");
        	sbSql.append("     , A.ITEM_NAME \n");
	        sbSql.append("     , A.ITEM_SIZE \n");
    	    sbSql.append("     , A.UOM_CODE AS PO_UOM \n");
    	    sbSql.append("     , A.FEATURE_NAME \n");
        }
        if (UNIT.equals("1"))
        {
	        sbSql.append("     , SUM(A.ADJUST_QTY + A.PO_QTY) AS REQ_QTY \n");
    	    sbSql.append("     , SUM(ROUND((A.ADJUST_QTY + A.PO_QTY) * A.UNIT_PRICE)) AS REQ_AMT \n");
        	sbSql.append("     , SUM(A.DELIVERED_QTY) AS IN_QTY \n");
        	sbSql.append("     , SUM(ROUND(A.DELIVERED_QTY * A.UNIT_PRICE)) AS IN_AMT \n");
        }
        if (UNIT.equals("0"))
        {
	        sbSql.append("     , SUM((A.ADJUST_QTY+A.PO_QTY) * A.UOM_CONVERT_RATE) AS REQ_QTY \n");
    	    sbSql.append("     , SUM(ROUND((A.ADJUST_QTY + A.PO_QTY) * A.UNIT_PRICE)) AS REQ_AMT \n");
        	sbSql.append("     , SUM(A.DELIVERED_QTY * A.UOM_CONVERT_RATE) AS IN_QTY \n");
        	sbSql.append("     , SUM(ROUND(A.DELIVERED_QTY * A.UNIT_PRICE)) AS IN_AMT \n");
        }
		sbSql.append("  FROM ( \n");
		sbSql.append("        SELECT A.ITEM_CLASS1 \n");
		sbSql.append("             , A.ITEM_CLASS2 \n");
		sbSql.append("             , A.ITEM_CLASS3 \n");
		sbSql.append("             , A.ITEM_CLASS4 \n");
		sbSql.append("             , A.ITEM_CODE \n");
		sbSql.append("             , A.ITEM_NAME \n");
		sbSql.append("             , A.ITEM_SIZE \n");
		sbSql.append("             , A.PO_UOM \n");
		sbSql.append("             , A.ADJUST_QTY \n");
		sbSql.append("             , A.PO_QTY \n");
		sbSql.append("             , A.UNIT_PRICE \n");
		sbSql.append("             , A.DELIVERED_QTY \n");
        if( TAB_INDEX.equals("D0") || TAB_INDEX.equals("D1") ) 
        {
    		sbSql.append("             , FN_ITEM_FEATURE_ICON( A.DUTY_YN, (SELECT H.PB_YN \n");
    		sbSql.append("                                                   FROM FCUS.HLDC_PO_CONTRACT_F H \n");
    		sbSql.append("                                                  WHERE A.ITEM_CODE   = H.ITEM_CODE \n");
    		sbSql.append("                                                    AND A.RC_UPJANG   = H.UPJANG \n");
    		sbSql.append("                                                    AND A.CENTER_CODE = H.CENTER_CODE \n");
    		sbSql.append("                                                    AND A.NEED_DATE BETWEEN H.CONTRACT_START AND H.CONTRACT_END) \n");
    		sbSql.append("                                    , A.ECO_ITEM, A.MANUF_CD ) AS FEATURE_NAME \n");        
        }
        sbSql.append("          FROM ( \n");
        sbSql.append("                SELECT C.ITEM_CLASS1 \n");
        sbSql.append("                     , C.ITEM_CLASS2 \n");
        sbSql.append("                     , C.ITEM_CLASS3 \n");
        sbSql.append("                     , C.ITEM_CLASS4 \n");
        sbSql.append("                     , A.ITEM_CODE \n");
        sbSql.append("                     , C.ITEM_NAME \n");
        sbSql.append("                     , C.ITEM_SIZE \n");
        sbSql.append("                     , C.PO_UOM \n");
        sbSql.append("                     , C.UOM_CODE \n");
        sbSql.append("                     , A.ADJUST_QTY \n");
        sbSql.append("                     , A.PO_QTY \n");
        sbSql.append("                     , A.UNIT_PRICE \n");
        sbSql.append("                     , A.DELIVERED_QTY \n");
        sbSql.append("                     , C.UOM_CONVERT_RATE \n");
        sbSql.append("                     , A.RC_UPJANG \n");
        sbSql.append("                     , A.CENTER_CODE \n");
        sbSql.append("                     , A.NEED_DATE \n");
        sbSql.append("                     , C.ECO_ITEM \n");
        sbSql.append("                     , C.MANUF_CD \n");
        if( TAB_INDEX.equals("D0") || TAB_INDEX.equals("D1") ) 
        {
            sbSql.append("                     , ( SELECT CASE WHEN COUNT(*) > 0 THEN 'Y' ELSE 'N' END \n");
            sbSql.append("                           FROM FSI_DUTY_MST G \n");
            sbSql.append("                          WHERE TO_CHAR(G.CENTER_CODE) = A.CENTER_CODE \n");
            sbSql.append("                            AND TO_CHAR(G.CUSTCD) = A.CUSTCD \n");
            sbSql.append("                            AND G.ITEM_CODE = A.ITEM_CODE \n");
            sbSql.append("                            AND A.NEED_DATE BETWEEN START_DATE AND END_DATE \n");
            sbSql.append("                            AND G.USE_YN = 'Y' ) AS DUTY_YN \n");        	
        }
        sbSql.append("            FROM HLDC_PO_PO A \n");
        sbSql.append("               , ( \n");
        sbSql.append("                  SELECT A.UPJANG \n");
        sbSql.append("                       , A.UPJANGNM \n");
        sbSql.append("                       , A.DEPT_ID \n");
        sbSql.append("                       , A.SC_CD \n");
        sbSql.append("                       , A.SC_NM \n");
        sbSql.append("                       , A.MU_CD \n");
        sbSql.append("                       , A.TM_CD \n");
        sbSql.append("                       , A.TM_NM \n");
        sbSql.append("                       , A.JOB_CD \n");
        sbSql.append("                       , (SELECT JOB_NAME FROM MAS_JOB Z WHERE A.JOB_CD = Z.JOB_CD) AS JOB_NAME \n");
        sbSql.append("                       , A.SUB_JOB_CD \n");
        sbSql.append("                       , (SELECT SUB_JOB_NAME FROM MAS_JOB_SUB Z WHERE A.JOB_CD = Z.JOB_CD AND A.SUB_JOB_CD = Z.SUB_JOB_CD) AS SUB_JOB_NAME \n");
        sbSql.append("                       , B.CENTER_CODE \n");
        sbSql.append("                       , C.CENTER_NAME \n");
        sbSql.append("                       , A.AP_UNITPRICE_UPJANG \n");
        sbSql.append("                    FROM SCO_UPJANG_MST_V A \n");
        sbSql.append("                       , HLDC_PO_UPJANG_CENTER B \n");
        sbSql.append("                       , HLDC_PO_CENTER C \n");
        sbSql.append("                   WHERE A.AP_UNITPRICE_UPJANG = B.UPJANG \n");
        sbSql.append("                     AND B.CENTER_CODE = C.CENTER_CODE \n");
        sbSql.append("                     AND A.FS_UPJANG = 'Y' \n");
        sbSql.append("                 ) B \n");
        sbSql.append("               , HLDC_PO_ITEM_MST C \n");
        if (! CUSTCD.equals(""))
        {
	        sbSql.append("     , PO_TREAT_UPJANG_V D \n");
        }
        sbSql.append(" WHERE A.RC_UPJANG   = B.UPJANG \n");
        sbSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE \n");
        sbSql.append("   AND A.LINE_STATUS NOT IN ('PD' ,'PR') \n");
        sbSql.append("   AND A.NEED_DATE BETWEEN '" + SDATE + "' AND '" + EDATE + "' \n");
        if (! CENTER_CODE.equals(""))
        {
	        sbSql.append("   AND B.CENTER_CODE = " + CENTER_CODE + " \n");
        }
        if (! SC_CD.equals(""))
        {
	        sbSql.append("   AND B.SC_CD = '" + SC_CD + "' \n");
        }
        if (! MU_CD.equals(""))
        {
	        sbSql.append("   AND B.MU_CD = '" + MU_CD + "' \n");
        }
        if (! TM_CD.equals(""))
        {
	        sbSql.append("   AND B.TM_CD = '" + TM_CD + "' \n");
        }
        if (! UPJANG.equals(""))
        {
	        sbSql.append("   AND B.UPJANG IN (" + UPJANG + ") \n");
        }
        if (! CUSTCD.equals(""))
        {
	        sbSql.append("   AND B.AP_UNITPRICE_UPJANG      = D.UPJANG \n");
    	    sbSql.append("   AND A.ITEM_CODE   = D.ITEM_CODE \n");
        	sbSql.append("   AND D.CUSTCD = " + CUSTCD + " \n");
        }
        if (! JOB_CD.equals(""))
        {
	        sbSql.append("   AND B.JOB_CD = '" + JOB_CD + "' \n");
        }
        if (! SUB_JOB_CD.equals(""))
        {
	        sbSql.append("   AND B.SUB_JOB_CD = '" + SUB_JOB_CD + "' \n");
        }
        if (! CLASS1.equals(""))
        {
	        sbSql.append("   AND C.ITEM_CLASS1 = '" + CLASS1 + "' \n");
        }

        if (! CLASS2.equals(""))
        {
	        sbSql.append("   AND C.ITEM_CLASS2 = '" + CLASS2 + "' \n");
        }
        if (! CLASS3.equals(""))
        {
	        sbSql.append("   AND C.ITEM_CLASS3 = '" + CLASS3 + "' \n");
        }
        if (! CLASS4.equals(""))
        {
	        sbSql.append("   AND C.ITEM_CLASS4 = '" + CLASS4 + "' \n");
        }
        if (! ITEM.equals(""))
        {
	        sbSql.append("   AND ( C.ITEM_CODE LIKE '%" + ITEM + "%'  OR  C.ITEM_NAME LIKE '%" + ITEM + "%' ) \n");
        }
        if (! strItemLst.equals(""))
        {
	        sbSql.append("   AND C.ITEM_CODE IN (" + strItemLst + ") \n");
        }
        if (! strSCLst.equals(""))
        {
	        sbSql.append("   AND B.SC_CD IN (" + strSCLst + ") \n");
        }
		sbSql.append("     ) A \n");
		sbSql.append("  ) A \n");
        sbSql.append(" GROUP BY A.ITEM_CLASS1 \n");
        if (TAB_INDEX.equals("A"))
        {
	        sbSql.append("     , A.ITEM_CLASS2 \n");
        }
        if (TAB_INDEX.equals("B"))
        {
        	 sbSql.append("     , A.ITEM_CLASS2 \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
        }
        if (TAB_INDEX.equals("C"))
        {
        	 sbSql.append("     , A.ITEM_CLASS2 \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , A.ITEM_CLASS4 \n");
        }
        if (TAB_INDEX.equals("D1"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , A.ITEM_CLASS4 \n");
        	sbSql.append("     , A.ITEM_CODE \n");
        	sbSql.append("     , A.ITEM_NAME \n");
        	sbSql.append("     , A.ITEM_SIZE \n");
        	sbSql.append("     , A.PO_UOM \n");
    		sbSql.append("     , A.FEATURE_NAME \n");
        }
        if (TAB_INDEX.equals("D0"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , A.ITEM_CLASS4 \n");
        	sbSql.append("     , A.ITEM_CODE \n");
	        sbSql.append("     , A.ITEM_NAME \n");
    	    sbSql.append("     , A.ITEM_SIZE \n");
        	sbSql.append("     , A.UOM_CODE \n");
    		sbSql.append("     , A.FEATURE_NAME \n");
        }
        sbSql.append(" ORDER BY A.ITEM_CLASS1 \n");
        if (TAB_INDEX.equals("A"))
        {
	        sbSql.append("     , A.ITEM_CLASS2 \n");
        }
        if (TAB_INDEX.equals("B"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , A.ITEM_CLASS3 \n");
        }
        if (TAB_INDEX.equals("C"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , A.ITEM_CLASS4 \n");
        }
        if (TAB_INDEX.equals("D1") || TAB_INDEX.equals("D0"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , A.ITEM_CLASS4 \n");
        	sbSql.append("     , A.ITEM_CODE \n");
        }
        */
        
        sbSql.append("SELECT A.ITEM_CLASS1 \n");
        sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS1 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'L') AS CLASS1_NAME \n");
        if (TAB_INDEX.equals("A"))
        {
	        sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME \n");
        }
        if (TAB_INDEX.equals("B"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME \n");
        }
        if (TAB_INDEX.equals("C"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME \n");
        	sbSql.append("     , A.ITEM_CLASS4 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS4 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'D') AS CLASS4_NAME \n");
        }
        if (TAB_INDEX.equals("D1"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME \n");
        	sbSql.append("     , A.ITEM_CLASS4 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS4 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'D') AS CLASS4_NAME \n");
        	sbSql.append("     , A.ITEM_CODE \n");
        	sbSql.append("     , A.ITEM_NAME \n");
        	sbSql.append("     , A.ITEM_SIZE \n");
        	sbSql.append("     , A.PO_UOM \n");
        	sbSql.append("     , A.FEATURE_NAME \n");
        }
        if (TAB_INDEX.equals("D0"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME \n");
        	sbSql.append("     , A.ITEM_CLASS4 \n");
	        sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE A.ITEM_CLASS4 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'D') AS CLASS4_NAME \n");
    	    sbSql.append("     , A.ITEM_CODE \n");
        	sbSql.append("     , A.ITEM_NAME \n");
	        sbSql.append("     , A.ITEM_SIZE \n");
    	    sbSql.append("     , A.UOM_CODE AS PO_UOM \n");
    	    sbSql.append("     , A.FEATURE_NAME \n");
        }
        if (UNIT.equals("1"))
        {
	        sbSql.append("     , SUM(A.ADJUST_QTY + A.PO_QTY) AS REQ_QTY \n");
    	    sbSql.append("     , SUM(ROUND((A.ADJUST_QTY + A.PO_QTY) * A.UNIT_PRICE)) AS REQ_AMT \n");
        	sbSql.append("     , SUM(A.DELIVERED_QTY) AS IN_QTY \n");
        	sbSql.append("     , SUM(ROUND(A.DELIVERED_QTY * A.UNIT_PRICE)) AS IN_AMT \n");
        }
        if (UNIT.equals("0"))
        {
	        sbSql.append("     , SUM((A.ADJUST_QTY+A.PO_QTY) * A.UOM_CONVERT_RATE) AS REQ_QTY \n");
    	    sbSql.append("     , SUM(ROUND((A.ADJUST_QTY + A.PO_QTY) * A.UNIT_PRICE)) AS REQ_AMT \n");
        	sbSql.append("     , SUM(A.DELIVERED_QTY * A.UOM_CONVERT_RATE) AS IN_QTY \n");
        	sbSql.append("     , SUM(ROUND(A.DELIVERED_QTY * A.UNIT_PRICE)) AS IN_AMT \n");
        }
		sbSql.append("  FROM ( \n");
		sbSql.append("        SELECT C.CATE1_CD AS ITEM_CLASS1 \n");
		sbSql.append("             , C.CATE2_CD AS ITEM_CLASS2 \n");
		sbSql.append("             , C.CATE3_CD AS ITEM_CLASS3 \n");
		sbSql.append("             , C.CATE4_CD AS ITEM_CLASS4  \n");
		sbSql.append("             , A.ITEM_CODE \n");
		sbSql.append("             , C.ITEM_NM || ' ' || C.MAKER_NM AS ITEM_NAME \n");
		sbSql.append("             , C.SPEC AS ITEM_SIZE  \n");
		if (UNIT.equals("1"))
        {
			sbSql.append("             , C.PURC_UNIT_CD AS PO_UOM  \n");
        }
		if (UNIT.equals("0"))
        {
			sbSql.append("             , C.PURC_IO_UNIT_CD AS UOM_CODE  \n");
			sbSql.append("             , C.PURC_UNIT_RATE AS UOM_CONVERT_RATE  \n");
        }
		sbSql.append("             , A.ADJUST_QTY \n");
		sbSql.append("             , A.PO_QTY \n");
		sbSql.append("             , A.UNIT_PRICE \n");
		sbSql.append("             , A.DELIVERED_QTY \n");
        if( TAB_INDEX.equals("D0") || TAB_INDEX.equals("D1") ) 
        {
        	sbSql.append("  , CASE WHEN A.DUTY_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon11.png'																										\n");
        	sbSql.append("                      WHEN (SELECT NVL(PB_FOOD_YN,'N')                                                                                                                        \n");
        	sbSql.append("                                                        FROM EPROCUSR.ESPINFO                                                                                                 \n");
        	sbSql.append("                                                       WHERE SYS_ID = '100'                                                                                                   \n");
        	sbSql.append("                                                         AND COMP_CD = 'HFC'                                                                                                  \n");
        	sbSql.append("                                                         AND A.NEED_DATE BETWEEN APPLY_SD AND APPLY_ED                                                                        \n");
        	sbSql.append("                                                         AND A.PURC_OPER_ORG_SN = PURC_OPER_ORG_SN                                                                            \n");
        	sbSql.append("                                                         AND A.ITEM_CODE = ITEM_CD                                                                                            \n");
        	sbSql.append("                                                         AND STS <> 'D'                                                                                                       \n");
        	sbSql.append("                                                         AND CNTR_TYP_CD IN ('U', 'I', 'P', 'F0','F1','F2','F3','F4')) = 'Y' THEN 'theme://Images/new/grd_WF_Icon09.png'      \n");
        	sbSql.append("                      WHEN LENGTH(TRIM( (SELECT ATTR_VAL                                                                                                                      \n");
        	sbSql.append("                                           FROM EPROCUSR.ESMMTSP                                                                                                              \n");
        	sbSql.append("                                          WHERE SYS_ID  = '100'                                                                                                               \n");
        	sbSql.append("                                            AND ATTR_CD = 'P1251'                                                                                                             \n");
        	sbSql.append("                                            AND STS    <> 'D'                                                                                                                 \n");
        	sbSql.append("                                            AND ITEM_CD = C.ITEM_CD))) > 0 AND TRIM((SELECT ATTR_VAL                                                                          \n");
        	sbSql.append("                                                                                       FROM EPROCUSR.ESMMTSP                                                                  \n");
        	sbSql.append("                                                                                      WHERE SYS_ID  = '100'                                                                   \n");
        	sbSql.append("                                                                                        AND ATTR_CD = 'P1251'                                                                 \n");
        	sbSql.append("                                                                                        AND STS    <> 'D'                                                                     \n");
        	sbSql.append("                                                                                        AND ITEM_CD = C.ITEM_CD)) <> '해당없음' THEN 'theme://Images/new/grd_WF_Icon08.png'   \n");
        	sbSql.append("                      WHEN (SELECT ATTR_VAL                                                                                                                                   \n");
        	sbSql.append("                                           FROM EPROCUSR.ESMMTSP                                                                                                              \n");
        	sbSql.append("                                          WHERE SYS_ID  = '100'                                                                                                               \n");
        	sbSql.append("                                            AND ATTR_CD = 'P10001'                                                                                                            \n");
        	sbSql.append("                                            AND STS    <> 'D'                                                                                                                 \n");
        	sbSql.append("                                            AND ITEM_CD = C.ITEM_CD)= 'Y' THEN 'theme://Images/new/grd_WF_Icon10.png'                                                         \n");
        	sbSql.append("                      ELSE ''                                                                                                                                                 \n");
        	sbSql.append("                      END  AS FEATURE_NAME                                                                                                                                    \n");     
        }
        sbSql.append("          FROM ( \n");
        sbSql.append("     SELECT PODT.ITEM_CD AS ITEM_CODE																																				\n");
        sbSql.append("                              , NVL(PODT.PR_QTY,0) - NVL(PODT.ITEM_QTY,0) AS ADJUST_QTY																							\n");		
        sbSql.append("                              , PODT.ITEM_QTY            AS PO_QTY      -- 발수 수량                                                                                              \n");
        sbSql.append("                              , PODT.BUY_PRICE           AS UNIT_PRICE -- 매입 단가                                                                                               \n");
        sbSql.append("                              , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN NVL(PODT.GR_QTY,0) ELSE NVL(PODT.GR_QTY_WMS,0) END  AS DELIVERED_QTY    --업장입고수량(센터출고)             \n");
        sbSql.append("                              , PODT.SHOP_CD             AS RC_UPJANG   -- 입고업장 코드                                                                                          \n");
        sbSql.append("                              , PODT.WH_CNTR_CD          AS CENTER_CODE -- 물류센터코드                                                                                           \n");
        sbSql.append("                              , PODT.GR_REQ_DATE                AS NEED_DATE -- 입고희망일자                                                                                      \n");
        sbSql.append("                              , PODT.PURC_OPER_ORG_SN       AS PURC_OPER_ORG_SN                                                                                                   \n");
        if( TAB_INDEX.equals("D0") || TAB_INDEX.equals("D1") ) 
        {
        	sbSql.append("     , ( SELECT CASE WHEN COUNT(*) > 0 THEN 'Y' ELSE 'N' END 																						\n");
        	sbSql.append("                                                    FROM FSI_DUTY_MST G                                                                           \n");
        	sbSql.append("                                                   WHERE G.CENTER_CODE = TO_NUMBER(PODT.WH_CNTR_CD)                                               \n");
        	sbSql.append("                                                     AND G.CUSTCD = (SELECT TO_NUMBER(VD_CD) FROM EPROCUSR.ESPPOHD POHD                           \n");
        	sbSql.append("     																								  WHERE POHD.SYS_ID = PODT.SYS_ID               \n");
        	sbSql.append("     																								    AND POHD.COMP_CD = PODT.COMP_CD             \n");
        	sbSql.append("     																									AND POHD.PO_NO = PODT.PO_NO                 \n");
        	sbSql.append("     																									AND POHD.PO_TYP <> 'BP')                    \n");
        	sbSql.append("                                                     AND G.ITEM_CODE = PODT.ITEM_CD                                                               \n");
        	sbSql.append("                                                     AND PODT.GR_REQ_DATE BETWEEN START_DATE AND END_DATE                                         \n");
        	sbSql.append("                                                     AND G.USE_YN = 'Y'                                                                           \n");
        	sbSql.append("                                                     AND ROWNUM <= 1                                                                              \n");
        	sbSql.append("                                                     ) AS DUTY_YN                                                                                 \n");        	
        }
        sbSql.append("     FROM EPROCUSR.ESPPODT PODT    																																			\n");
        sbSql.append("                             LEFT OUTER JOIN EPROCUSR.ESPPRDT PRDT                                                                                                            \n");
        sbSql.append("                                     ON PODT.SYS_ID = PRDT.SYS_ID                                                                                                             \n");
        sbSql.append("                                     AND PODT.COMP_CD = PRDT.COMP_CD                                                                                                          \n");
        sbSql.append("                                     AND PODT.PR_NO = PRDT.PR_NO                                                                                                              \n");
        sbSql.append("                                     AND PODT.PR_LNO = PRDT.PR_LNO                                                                                                            \n");
        sbSql.append("                             INNER JOIN (                                                                                                                                     \n");
        sbSql.append("                                           SELECT A.UPJANG                                                                                                                    \n");
        sbSql.append("                                                , A.UPJANGNM                                                                                                                  \n");
        sbSql.append("                                                , A.DEPT_ID                                                                                                                   \n");
        sbSql.append("                                                , A.SC_CD                                                                                                                     \n");
        sbSql.append("                                                , A.SC_NM                                                                                                                     \n");
        sbSql.append("                                                , A.MU_CD                                                                                                                     \n");
        sbSql.append("                                                , A.TM_CD                                                                                                                     \n");
        sbSql.append("                                                , A.TM_NM                                                                                                                     \n");
        sbSql.append("                                                , A.JOB_CD                                                                                                                    \n");
        sbSql.append("                                                , (SELECT JOB_NAME FROM MAS_JOB Z WHERE A.JOB_CD = Z.JOB_CD) AS JOB_NAME                                                      \n");
        sbSql.append("                                                , A.SUB_JOB_CD                                                                                                                \n");
        sbSql.append("                                                , (SELECT SUB_JOB_NAME FROM MAS_JOB_SUB Z WHERE A.JOB_CD = Z.JOB_CD AND A.SUB_JOB_CD = Z.SUB_JOB_CD) AS SUB_JOB_NAME          \n");
        sbSql.append("                                                , B.CENTER_CODE                                                                                                               \n");
        sbSql.append("                                                , C.CENTER_NAME                                                                                                               \n");
        sbSql.append("                                                , A.AP_UNITPRICE_UPJANG                                                                                                       \n");
        sbSql.append("                                             FROM SCO_UPJANG_MST_V A                                                                                                          \n");
        sbSql.append("                                                , HLDC_PO_UPJANG_CENTER B                                                                                                     \n");
        sbSql.append("                                                , HLDC_PO_CENTER C                                                                                                            \n");
        sbSql.append("                                            WHERE A.AP_UNITPRICE_UPJANG = B.UPJANG                                                                                            \n");
        sbSql.append("                                              AND B.CENTER_CODE = C.CENTER_CODE                                                                                               \n");
        sbSql.append("                                              AND A.FS_UPJANG = 'Y'                                                                                                           \n");
        sbSql.append("                                          ) B                                                                                                                                 \n");
        sbSql.append("                                        ON TO_NUMBER(PODT.SHOP_CD) = B.UPJANG                                                                                                 \n");
        if (! CUSTCD.equals(""))
        {
	        sbSql.append("     , PO_TREAT_UPJANG_V D \n");
        }
        sbSql.append("     WHERE PODT.SYS_ID = '100'																\n");
        sbSql.append("                           AND PODT.COMP_CD = 'HFC'                                           \n");
        sbSql.append("                           AND PODT.PO_CANCEL_YN <> 'Y'             \n");
        sbSql.append("                           AND DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC')) NOT IN ('PD', 'PR')             \n");
        sbSql.append("                           AND PODT.SHOP_TYP_CD = '01'             \n");
        sbSql.append("                           AND PODT.STS <> 'D'             \n");
        sbSql.append("   AND PODT.GR_REQ_DATE BETWEEN '" + SDATE + "' AND '" + EDATE + "' \n");
        if (! CENTER_CODE.equals(""))
        {
	        sbSql.append("   AND B.CENTER_CODE = " + CENTER_CODE + " \n");
        }
        if (! SC_CD.equals(""))
        {
	        sbSql.append("   AND B.SC_CD = '" + SC_CD + "' \n");
        }
        if (! MU_CD.equals(""))
        {
	        sbSql.append("   AND B.MU_CD = '" + MU_CD + "' \n");
        }
        if (! TM_CD.equals(""))
        {
	        sbSql.append("   AND B.TM_CD = '" + TM_CD + "' \n");
        }
        if (! UPJANG.equals(""))
        {
	        sbSql.append("   AND B.UPJANG IN (" + UPJANG + ") \n");
        }
        if (! CUSTCD.equals(""))
        {
	        sbSql.append("   AND B.AP_UNITPRICE_UPJANG      = D.UPJANG \n");
    	    sbSql.append("   AND PODT.ITEM_CD   = D.ITEM_CODE \n");
        	sbSql.append("   AND D.CUSTCD = " + CUSTCD + " \n");
        }
        if (! JOB_CD.equals(""))
        {
	        sbSql.append("   AND B.JOB_CD = '" + JOB_CD + "' \n");
        }
        if (! SUB_JOB_CD.equals(""))
        {
	        sbSql.append("   AND B.SUB_JOB_CD = '" + SUB_JOB_CD + "' \n");
        }
       
        if (! strSCLst.equals(""))
        {
	        sbSql.append("   AND B.SC_CD IN (" + strSCLst + ") \n");
        }
        sbSql.append("     ) A \n");
		sbSql.append("     , EPROCUSR.ESMMTGL C  \n");
		sbSql.append("     WHERE A.ITEM_CODE   = C.ITEM_CD  \n");
		 if (! CLASS1.equals(""))
	        {
		        sbSql.append("   AND C.CATE1_CD = '" + CLASS1 + "' \n");
	        }

	        if (! CLASS2.equals(""))
	        {
		        sbSql.append("   AND C.CATE2_CD = '" + CLASS2 + "' \n");
	        }
	        if (! CLASS3.equals(""))
	        {
		        sbSql.append("   AND C.CATE3_CD = '" + CLASS3 + "' \n");
	        }
	        if (! CLASS4.equals(""))
	        {
		        sbSql.append("   AND C.CATE4_CD = '" + CLASS4 + "' \n");
	        }
	        if (! ITEM.equals(""))
	        {
		        sbSql.append("   AND ( C.ITEM_CD LIKE '%" + ITEM + "%'  OR  (C.ITEM_NM || ' ' || C.MAKER_NM) LIKE '%" + ITEM + "%' ) \n");
	        }
	        if (! strItemLst.equals(""))
	        {
		        sbSql.append("   AND C.ITEM_CD IN (" + strItemLst + ") \n");
	        }
	        
		sbSql.append("  ) A \n");
        sbSql.append(" GROUP BY A.ITEM_CLASS1 \n");
        if (TAB_INDEX.equals("A"))
        {
	        sbSql.append("     , A.ITEM_CLASS2 \n");
        }
        if (TAB_INDEX.equals("B"))
        {
        	 sbSql.append("     , A.ITEM_CLASS2 \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
        }
        if (TAB_INDEX.equals("C"))
        {
        	 sbSql.append("     , A.ITEM_CLASS2 \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , A.ITEM_CLASS4 \n");
        }
        if (TAB_INDEX.equals("D1"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , A.ITEM_CLASS4 \n");
        	sbSql.append("     , A.ITEM_CODE \n");
        	sbSql.append("     , A.ITEM_NAME \n");
        	sbSql.append("     , A.ITEM_SIZE \n");
        	sbSql.append("     , A.PO_UOM \n");
    		sbSql.append("     , A.FEATURE_NAME \n");
        }
        if (TAB_INDEX.equals("D0"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
	        sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , A.ITEM_CLASS4 \n");
        	sbSql.append("     , A.ITEM_CODE \n");
	        sbSql.append("     , A.ITEM_NAME \n");
    	    sbSql.append("     , A.ITEM_SIZE \n");
        	sbSql.append("     , A.UOM_CODE \n");
    		sbSql.append("     , A.FEATURE_NAME \n");
        }
        sbSql.append(" ORDER BY A.ITEM_CLASS1 \n");
        if (TAB_INDEX.equals("A"))
        {
	        sbSql.append("     , A.ITEM_CLASS2 \n");
        }
        if (TAB_INDEX.equals("B"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , A.ITEM_CLASS3 \n");
        }
        if (TAB_INDEX.equals("C"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , A.ITEM_CLASS4 \n");
        }
        if (TAB_INDEX.equals("D1") || TAB_INDEX.equals("D0"))
        {
        	sbSql.append("     , A.ITEM_CLASS2 \n");
        	sbSql.append("     , A.ITEM_CLASS3 \n");
    	    sbSql.append("     , A.ITEM_CLASS4 \n");
        	sbSql.append("     , A.ITEM_CODE \n");
        }
		
		out_vl.add("fa_Sql", sbSql.toString());		
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
		//jsp 로그남기기
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