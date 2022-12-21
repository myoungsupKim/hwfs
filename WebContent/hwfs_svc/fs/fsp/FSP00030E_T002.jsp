<%
/*-----------------------------------------------------------------------------
�� �ý��۸�	   : ���Ű���/���Ž�û/���Ž�û����ȸ
�� ���α׷�ID   : FSP00032E_T009.jsp
�� ���α׷���   : ���Ž�û(���Ž�û����ȸ)
�� �ۼ�����	   : 2015-06-01
�� �ۼ���	   : ����ö
�� �̷°���	   : 2015-06-01
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_condi_detail = in_dl.get("ds_condi_detail");

		String PR_NUM      = nullToBlank(ds_condi_detail.getString(0, "PR_NUM"));
		String DATE_TYPE   = nullToBlank(ds_condi_detail.getString(0, "DATE_TYPE"));
		String DT_FR       = nullToBlank(ds_condi_detail.getString(0, "DT_FR"));
		String DT_TO       = nullToBlank(ds_condi_detail.getString(0, "DT_TO"));
		String CUSTCD      = nullToBlank(ds_condi_detail.getString(0, "CUSTCD"));
		String SUBINV_CODE = nullToBlank(ds_condi_detail.getString(0, "SUBINV_CODE"));
		String RC_DEPT_ID  = nullToBlank(ds_condi_detail.getString(0, "RC_DEPT_ID"));
		String LINE_STATUS = nullToBlank(ds_condi_detail.getString(0, "LINE_STATUS"));
		String CHK_CUST    = nullToBlank(ds_condi_detail.getString(0, "CHK_CUST"));
		String CHK_DEPT    = nullToBlank(ds_condi_detail.getString(0, "CHK_DEPT"));
		String CHK_STATUS  = nullToBlank(ds_condi_detail.getString(0, "CHK_STATUS"));
		String NEED_DATE  = nullToBlank(ds_condi_detail.getString(0, "NEED_DATE"));

		DataSet ds_detail;
		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.append("\n SELECT A.ITEM_CODE                       AS ITEM_CODE 		/* �����ڵ� */");
		sbSelSql.append("\n      , A.ITEM_NAME                       AS ITEM_NAME 		/* �����   */");
		sbSelSql.append("\n      , A.ITEM_SIZE                       AS ITEM_SIZE		/*  �԰�    */");
		//PB_YN�� ��࿡�� ������ (2015.08.29) 
		sbSelSql.append("\n      , FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.NEED_DATE), TRIM(G.PB_YN), TRIM(F.ECO_ITEM), TRIM(F.MANUF_CD)) AS FEATURE_NAME	/* ����Ư�� */");
		sbSelSql.append("\n      , A.PR_SABUN                        AS PR_SABUN		/* ��û�ڻ�� */");
		sbSelSql.append("\n      , A.PO_UOM                          AS PO_UOM			/*  */");
		sbSelSql.append("\n      , A.TAX_CODE                        AS TAX_CODE		/* �����ڵ� */");
		sbSelSql.append("\n      , A.PR_REMARK                       AS PR_REMARK		/* ��� */");
		sbSelSql.append("\n      , A.NEED_DATE                       AS NEED_DATE		/* �԰����� */");
		sbSelSql.append("\n      , A.MARGIN_PRICE                    AS MARGIN_PRICE	/* �����ܰ� */");
		sbSelSql.append("\n      , A.PR_QTY                          AS PR_QTY			/* ���Ž�û���� */");
		//sbSelSql.append("\n      , (SELECT PO_QTY FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID ) AS PO_QTY"			);
		//PR_ID, PR_NUM���� JOIN�� �������� �����ʿ� 
		sbSelSql.append("\n      , CASE WHEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ COUNT(1) FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID ) > 1");
		sbSelSql.append("\n             THEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ PO_QTY FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID )");
		sbSelSql.append("\n             ELSE (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ PO_QTY FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID )");
		sbSelSql.append("\n        END  AS PO_QTY										/* �Ǳ��Ž�û���� */");
		sbSelSql.append("\n      , (A.MARGIN_PRICE * A.PR_QTY)       AS PR_AMT			/* ���Ž�û���� */");
		sbSelSql.append("\n      , A.SUBINV_CODE||' '||B.SUBINV_NAME AS SUBINV_NAME		/* â���ڵ�||â��� */");
		sbSelSql.append("\n      , D.MU_NM||' '||D.CC_NM             AS CC_NM			/* ������ڵ�||�μ��ڵ� */");
		sbSelSql.append("\n      , A.PR_ID                           AS PR_ID			/* ���Ž�ûID */");
		sbSelSql.append("\n      , A.APPROVE_NUM                     AS APPROVE_NUM 	/* ���ι�ȣ */");
		sbSelSql.append("\n      , A.SUBINV_CODE                     AS SUBINV_CODE		/* â���ڵ� */");
		sbSelSql.append("\n      , A.PR_DATE                         AS PR_DATE			/* ��û���� */");
		sbSelSql.append("\n      , A.PO_TYPE                         AS PO_TYPE			/* �������� */");
		sbSelSql.append("\n      , 'N'                               AS DML				/*  */");
		//sbSelSql.append("\n		, CASE A.LINE_STATUS WHEN '002' THEN (SELECT IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID )");
		//sbSelSql.append("\n		                     ELSE A.LINE_STATUS "				);
		//sbSelSql.append("\n		                     END LINE_STATUS"					);
		//PR_ID, PR_NUM���� JOIN�� �������� �����ʿ�
		sbSelSql.append("\n	  	, CASE A.LINE_STATUS WHEN '002' ");
		sbSelSql.append("\n        THEN CASE WHEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ COUNT(1) FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID ) > 1");
		sbSelSql.append("\n                  THEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID )");
		sbSelSql.append("\n                  ELSE (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID )");
		sbSelSql.append("\n             END");
		sbSelSql.append("\n            ELSE A.LINE_STATUS");
		sbSelSql.append("\n            END LINE_STATUS									/* ���������Ȳ�ڵ� */");
		sbSelSql.append("\n      , E.VD_NM                          AS CUSTNM			/* �ŷ�ó�� */");
		// [�ӵ����� Project ����] 2017. 12. 06. ��ȣ�� ���MD �߰�		
		sbSelSql.append("\n     ,(SELECT MAX(DD.USR_NM)   ");
		sbSelSql.append("\n				FROM EPROCUSR.ESPINFO AA  ");
		sbSelSql.append("\n     			LEFT OUTER JOIN EPROCUSR.ESMVDOG BB ON AA.SYS_ID = BB.SYS_ID AND AA.COMP_CD = BB.COMP_CD AND AA.VD_SN = BB.VD_SN "); 
		sbSelSql.append("\n     											    AND BB.OPER_ORG_SN = '414' --FC�ι���  ");
		sbSelSql.append("\n     			INNER JOIN EPROCUSR.ESPSWHC CC ON AA.SYS_ID = CC.SYS_ID AND AA.COMP_CD = CC.COMP_CD AND AA.PURC_OPER_ORG_SN = CC.OPER_ORG_SN_PURC "); 
		sbSelSql.append("\n     		  	INNER JOIN EPROCUSR.ESAUSER DD ON DD.SYS_ID = '100' AND DD.COMP_CD = 'HFC' AND BB.HFC_CHR_ID = DD.USR_ID  AND DD.STS <> 'D' ");
		sbSelSql.append("\n     					WHERE AA.SYS_ID = '100' AND AA.COMP_CD = 'HFC' AND :NEED_DATE BETWEEN AA.APPLY_SD AND AA.APPLY_ED  --��� �Ⱓ "); 
		sbSelSql.append("\n     						   AND AA.STS <> 'D' --AND SUBSTR(AA.ITEM_CD, 0 , 1) = 'F' --�����縸 "); 
		sbSelSql.append("\n     					       AND BB.VD_SN = A.VD_SN --AND A.CUSTCD = BB.ERP_VD_CD  ");
		sbSelSql.append("\n     					       AND AA.ITEM_CD = A.ITEM_CODE ");
		sbSelSql.append("\n    							   AND CC.WH_CNTR_CD = G.CENTER_CODE ");
		sbSelSql.append("\n       ) AS MD_NAME	/*���MD*/ ");
		// [�ӵ����� Project ��] 2017. 12. 06. ��ȣ�� ���MD �߰�
		sbSelSql.append("\n      , NVL(");
		sbSelSql.append("\n            (");
		sbSelSql.append("\n             SELECT DISTINCT 'Y'");
		sbSelSql.append("\n               FROM HLDC_PO_SUBINVENTORY X ");
		sbSelSql.append("\n              WHERE X.UPJANG = A.RC_UPJANG ");
		sbSelSql.append("\n                AND OUTVAT_FLAG = 'Y' ");
		sbSelSql.append("\n             ),'N')                       AS SCHOOL_YN		/* �ŷ�ó�� �б����� ���� */");
		sbSelSql.append("\n      , A.ORG_PR_NUM                      AS ORG_PR_NUM		/* �������� PR_NUM */");
		sbSelSql.append("\n      , A.PR_NUM                          AS PR_NUM			/* PR_NUM */");
		sbSelSql.append("\n      , A.RC_UPJANG                       AS RC_UPJANG		/* ���Ž�û���� */");
		sbSelSql.append("\n      , (SELECT IA.UPJANGNM  FROM ST_UPJANG IA WHERE IA.UPJANG  = A.RC_UPJANG) AS RC_UPJANG_NM	/* ���Ž�û����� */");
		sbSelSql.append("\n      , F.IMG_YN												/* �̹������� */");
		sbSelSql.append("\n      , NVL(H.D_DAYS,0) + 1 AS D_DAY           ");
		sbSelSql.append("\n   FROM SO_PR A");
		sbSelSql.append("\n      , HLDC_PO_SUBINVENTORY B");
		sbSelSql.append("\n      , HLDC_SC_DEPT_V D");
		sbSelSql.append("\n      , VO_FC_VENDOR E ");
		sbSelSql.append("\n      , HLDC_PO_ITEM_MST F ");
		sbSelSql.append("\n      , HLDC_PO_CONTRACT_F G ");
		sbSelSql.append("\n      , HLDC_PO_PREORDER_LIST H ");
		sbSelSql.append("\n  WHERE A.RC_DEPT_ID  = D.DEPT_ID ");
		sbSelSql.append("\n    AND TO_CHAR(A.CUSTCD)      = E.VD_CD     (+)");
		sbSelSql.append("\n    AND A.SUBINV_CODE = B.SUBINV_CODE");
		sbSelSql.append("\n    AND A.ITEM_CODE   = F.ITEM_CODE (+)");
		sbSelSql.append("\n    AND A.ITEM_CODE   = G.ITEM_CODE (+)");
		sbSelSql.append("\n    AND G.CENTER_CODE = H.CENTER_CODE(+)                                                                                        ");                                                        
		sbSelSql.append("\n    AND G.ITEM_CODE   = H.ITEM_CODE  (+)    																					 ");
		sbSelSql.append("\n    AND A.RC_UPJANG   = G.UPJANG    (+)");
		sbSelSql.append("\n    AND A.NEED_DATE   BETWEEN G.CONTRACT_START(+) AND G.CONTRACT_END(+)");
		//sbSelSql.append("\n    AND A.SUBINV_CODE = '" + SUBINV_CODE + "'");
		//sbSelSql.append("\n    AND A.ORG_PR_NUM  = '" + PR_NUM + "' ");
		
		sbSelSql.append("\n    AND A.SUBINV_CODE = :SUBINV_CODE ");
		sbSelSql.append("\n    AND A.ORG_PR_NUM  = :PR_NUM ");
		
		// �԰��� ���ý�
		if (DATE_TYPE.equals("1"))
			//sbSelSql.append("\n    AND A.NEED_DATE BETWEEN '" + DT_FR + "' AND '" + DT_TO + "' ");
			sbSelSql.append("\n    AND A.NEED_DATE BETWEEN :DT_FR AND :DT_TO ");
		
		// �ŷ�ó����ȸ üũ�ڽ� üũ��
		if (CHK_CUST.equals("Y")) {
			if (CUSTCD.equals(""))
				sbSelSql.append("\n    AND A.CUSTCD      IS NULL ");
			else
				//sbSelSql.append("\n    AND A.CUSTCD      = '" + CUSTCD + "' ");
				sbSelSql.append("\n    AND A.CUSTCD      = :CUSTCD ");
		}
		
		// �˼��μ�����ȸ üũ�ڽ� üũ��
		if (CHK_DEPT.equals("Y"))
			//sbSelSql.append("\n    AND A.RC_DEPT_ID  = " + RC_DEPT_ID + " ");
			sbSelSql.append("\n    AND A.RC_DEPT_ID  = :RC_DEPT_ID ");
		
		// �����Ȳ����ȸ üũ�ڽ� üũ��
		if (CHK_STATUS.equals("Y"))
			//sbSelSql.append("\n    AND A.LINE_STATUS = '" + LINE_STATUS + "' ");
			sbSelSql.append("\n    AND A.LINE_STATUS = :LINE_STATUS ");
		
		// ��Ұ��̸� ������ۼ��ȰǸ� ����
		if (LINE_STATUS.equals("003"))
		{
			sbSelSql.append("\n    AND A.LINE_STATUS     <>'999'        ");
		// ��Ұ��� �ƴϸ� ��ҵȰ� ������ۼ��� �Ѵ� ����
		}
		else
		{
			sbSelSql.append("\n    AND A.LINE_STATUS     NOT IN('999')        ");
		}

		sbSelSql.append(" ORDER BY A.ITEM_CODE                              \n");

		//////
		//stmt = conn.createStatement();		
		//rs = stmt.executeQuery(sbSelSql.toString());
		////
		// [�ӵ����� Project ����] 2017. 12. 06. ��ȣ�� ���� ���� ���ε���� �߰�
				
        npstmt = new NamedParameterStatement(conn, sbSelSql.toString());

        npstmt.setString("NEED_DATE", NEED_DATE);
        npstmt.setString("SUBINV_CODE", SUBINV_CODE);
        npstmt.setString("PR_NUM", PR_NUM);
        if (DATE_TYPE.equals("1")) npstmt.setString("DT_FR", DT_FR);
        if (DATE_TYPE.equals("1")) npstmt.setString("DT_TO", DT_TO);
        if (CHK_CUST.equals("Y")) {
			if (!CUSTCD.equals("")) {
				npstmt.setString("CUSTCD", CUSTCD);
			}
        }
        if (CHK_DEPT.equals("Y")) npstmt.setString("RC_DEPT_ID", RC_DEPT_ID);
        if (CHK_STATUS.equals("Y")) npstmt.setString("LINE_STATUS", LINE_STATUS);
                
        rs = npstmt.executeQuery();
     	// [�ӵ����� Project ��] 2017. 12. 06. ��ȣ�� ���� ���� ���ε���� �߰�

		ds_detail = this.makeDataSet(rs, "ds_detail");

		rs.close();
		npstmt.close();
		//stmt.close();

		out_dl.add(ds_detail);

		this.setResultMessage(0, "OK", out_vl);

	} catch (Exception ex) {
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
		if (npstmt != null) {
			try {
				npstmt.close();
			} catch (Exception e) {
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
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
