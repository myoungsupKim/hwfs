<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/신청관리
■ 프로그램ID   : FSP00420V_T003.jsp
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
		//DataSet ds_ItemList     = in_dl.get("ds_ItemList");
		//입력 파라메터
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
        sbSql.append("SELECT /*+ NO_MERGE(B) LEADING(A B C) USE_HASH(B) INDEX(A PO_PR_I2) */ C.ITEM_CLASS1                                                                                                        \n");
        sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS1 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'L') AS CLASS1_NAME        \n");
        if (TAB_INDEX.equals("A"))
        {
	        sbSql.append("     , C.ITEM_CLASS2                                                                                                             \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME    \n");
        }
        if (TAB_INDEX.equals("B"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                             \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME    \n");
	        sbSql.append("     , C.ITEM_CLASS3                                                                                                             \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME    \n");
        }
        if (TAB_INDEX.equals("C"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                             \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME    \n");
	        sbSql.append("     , C.ITEM_CLASS3                                                                                                             \n");
    	    sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME    \n");
        	sbSql.append("     , C.ITEM_CLASS4                                                                                                             \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS4 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'D') AS CLASS4_NAME    \n");
        }
        if (TAB_INDEX.equals("D1"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                             \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME    \n");
	        sbSql.append("     , C.ITEM_CLASS3                                                                                                             \n");
    	    sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME    \n");
        	sbSql.append("     , C.ITEM_CLASS4                                                                                                        \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS4 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'D') AS CLASS4_NAME    \n");
        	sbSql.append("     , A.ITEM_CODE                                                                                                               \n");
        	sbSql.append("     , C.ITEM_NAME                                                                                                               \n");
        	sbSql.append("     , C.ITEM_SIZE                                                                                                               \n");
        	sbSql.append("     , C.PO_UOM                                                                                                                  \n");
        }
        if (TAB_INDEX.equals("D0"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                             \n");
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS2 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'M') AS CLASS2_NAME    \n");
	        sbSql.append("     , C.ITEM_CLASS3                                                                                                             \n");
    	    sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS3 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'S') AS CLASS3_NAME    \n");
        	sbSql.append("     , C.ITEM_CLASS4                                                                                                             \n");
	        sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE C.ITEM_CLASS4 = Z.CLASS_CODE AND Z.CLASS_TYPE = 'D') AS CLASS4_NAME    \n");
    	    sbSql.append("     , A.ITEM_CODE                                                                                                          \n");
        	sbSql.append("     , C.ITEM_NAME                                                                                                          \n");
	        sbSql.append("     , C.ITEM_SIZE                                                                                                          \n");
    	    sbSql.append("     , C.UOM_CODE AS PO_UOM                                                                                                 \n");
        }
        if (UNIT.equals("1"))
        {
	        sbSql.append("     , SUM(A.PO_QTY) AS REQ_QTY                                                                                \n");
    	    sbSql.append("     , SUM(ROUND(A.PO_QTY*A.MARGIN_PRICE)) AS REQ_AMT                                                          \n");
        	sbSql.append("     , 0 AS IN_QTY                                                                                       \n");
        	sbSql.append("     , 0 AS IN_AMT                                                                   \n");
        }
        if (UNIT.equals("0"))
        {
	        sbSql.append("     , SUM(A.PO_QTY*C.UOM_CONVERT_RATE) AS REQ_QTY                                                           \n");
    	    sbSql.append("     , SUM(ROUND(A.PO_QTY*A.MARGIN_PRICE)) AS REQ_AMT                                                          \n");
        	sbSql.append("     , 0 AS IN_QTY                                                                    \n");
        	sbSql.append("     , 0 AS IN_AMT                                                                   \n");
        }
        sbSql.append("  FROM HLDC_PO_PO A                                                                                                              \n");
        sbSql.append("     , (                                                                                                                    \n");
        sbSql.append("        SELECT A.UPJANG                                                                                                     \n");
        sbSql.append("             , A.UPJANGNM                                                                                                   \n");
        sbSql.append("             , A.DEPT_ID                                                                                                    \n");
        sbSql.append("             , A.SC_CD                                                                                                      \n");
        sbSql.append("             , A.SC_NM                                                                                                      \n");
        sbSql.append("             , A.MU_CD                                                                                                      \n");
        sbSql.append("             , A.TM_CD                                                                                                      \n");
        sbSql.append("             , A.TM_NM                                                                                                      \n");
        sbSql.append("             , A.JOB_CD                                                                                                     \n");
        sbSql.append("             , (SELECT JOB_NAME FROM MAS_JOB Z WHERE A.JOB_CD = Z.JOB_CD) AS JOB_NAME                                  \n");
        sbSql.append("             , A.SUB_JOB_CD                                                                                                 \n");
        sbSql.append("             , (SELECT SUB_JOB_NAME FROM MAS_JOB_SUB Z WHERE A.JOB_CD = Z.JOB_CD AND A.SUB_JOB_CD = Z.SUB_JOB_CD) AS SUB_JOB_NAME \n");
        sbSql.append("             , B.CENTER_CODE                                                                                                \n");
        sbSql.append("             , C.CENTER_NAME                                                                                                \n");
        sbSql.append("             , A.AP_UNITPRICE_UPJANG                                                                                        \n");
        sbSql.append("          FROM SCO_UPJANG_MST_V A                                                                                      \n");
        sbSql.append("             , HLDC_PO_UPJANG_CENTER B                                                                                           \n");
        sbSql.append("             , HLDC_PO_CENTER C                                                                                                  \n");
        sbSql.append("         WHERE A.AP_UNITPRICE_UPJANG = B.UPJANG                                                                             \n");
        sbSql.append("           AND B.CENTER_CODE = C.CENTER_CODE                                                                                \n");
        sbSql.append("           AND A.FS_UPJANG = 'Y'                                                                                            \n");
        sbSql.append("       ) B                                                                                                                  \n");
        sbSql.append("     , HLDC_PO_ITEM_MST C                                                                                                        \n");
        if (! CUSTCD.equals(""))
        {
	        sbSql.append("     , PO_TREAT_UPJANG_V D                                                                                                    \n");
        }
        sbSql.append(" WHERE A.RC_UPJANG   = B.UPJANG                                                                                               \n");
        sbSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE                                                                                          \n");
       
        sbSql.append("   AND A.LINE_STATUS NOT IN ('PD' , 'PR')                                                                                   \n");
        //sbSql.append("   AND C.ITEM_CLASS1 = 'F'                                                                                               \n");
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
	        sbSql.append("   AND B.UPJANG = " + UPJANG + " \n");
        }
        if (! CUSTCD.equals(""))
        {
	        sbSql.append("   AND B.AP_UNITPRICE_UPJANG      = D.UPJANG                                                                                \n");
    	    sbSql.append("   AND A.ITEM_CODE   = D.ITEM_CODE                                                                                          \n");
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
        sbSql.append(" GROUP BY C.ITEM_CLASS1                                                                                                     \n");
        if (TAB_INDEX.equals("A"))
        {
	        sbSql.append("     , C.ITEM_CLASS2                                                                                                        \n");
        }
        if (TAB_INDEX.equals("B"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                        \n");
        	sbSql.append("     , C.ITEM_CLASS3                                                                                                        \n");
        }
        if (TAB_INDEX.equals("C"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                        \n");
        	sbSql.append("     , C.ITEM_CLASS3                                                                                                        \n");
    	    sbSql.append("     , C.ITEM_CLASS4                                                                                                        \n");
        }
        if (TAB_INDEX.equals("D1"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                        \n");
        	sbSql.append("     , C.ITEM_CLASS3                                                                                                        \n");
    	    sbSql.append("     , C.ITEM_CLASS4                                                                                                        \n");
        	sbSql.append("     , A.ITEM_CODE                                                                                                          \n");
        	sbSql.append("     , C.ITEM_NAME                                                                                                          \n");
        	sbSql.append("     , C.ITEM_SIZE                                                                                                          \n");
        	sbSql.append("     , C.PO_UOM                                                                                                             \n");
        }
        if (TAB_INDEX.equals("D0"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                        \n");
        	sbSql.append("     , C.ITEM_CLASS3                                                                                                        \n");
    	    sbSql.append("     , C.ITEM_CLASS4                                                                                                        \n");
        	sbSql.append("     , A.ITEM_CODE                                                                                                          \n");
	        sbSql.append("     , C.ITEM_NAME                                                                                                          \n");
    	    sbSql.append("     , C.ITEM_SIZE                                                                                                          \n");
        	sbSql.append("     , C.UOM_CODE                                                                                                           \n");
        }
        sbSql.append(" ORDER BY C.ITEM_CLASS1                                                                                                     \n");
        if (TAB_INDEX.equals("A"))
        {
	        sbSql.append("     , C.ITEM_CLASS2                                                                                                        \n");
        }
        if (TAB_INDEX.equals("B"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                        \n");
        	sbSql.append("     , C.ITEM_CLASS3                                                                                                        \n");
        }
        if (TAB_INDEX.equals("C"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                        \n");
        	sbSql.append("     , C.ITEM_CLASS3                                                                                                        \n");
    	    sbSql.append("     , C.ITEM_CLASS4                                                                                                        \n");
        }
        if (TAB_INDEX.equals("D1") || TAB_INDEX.equals("D0"))
        {
        	sbSql.append("     , C.ITEM_CLASS2                                                                                                        \n");
        	sbSql.append("     , C.ITEM_CLASS3                                                                                                        \n");
    	    sbSql.append("     , C.ITEM_CLASS4                                                                                                        \n");
        	sbSql.append("     , A.ITEM_CODE                                                                                                          \n");
        }
		
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		ds_List = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\aaa.txt", ds_List);
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