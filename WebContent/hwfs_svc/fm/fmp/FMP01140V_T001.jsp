
<%
    //-----------------------------------------------------------------------------
    //■ 시스템명     : CS관리 > 센터별자재조회
    //■ 프로그램ID   : FMP01140VV_T001.jsp
    //■ 프로그램명   : 센터별자재조회
    //■ 작성일자     : 2015-10-23
    //■ 작성자       :
    //-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_Cond = in_dl.get("ds_Cond");

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        String sCenterCode = nullToBlank(ds_Cond.getString(0, "CENTER_CODE"));
        String sItemCdNm = nullToBlank(ds_Cond.getString(0, "ITEM_CDNM"));

        /*
        sbSql.append("	SELECT DISTINCT A.ITEM_CD                                                                                           \n");
        sbSql.append("     	 , C.ITEM_NAME                                                                                                  \n");
        sbSql.append("       , C.ITEM_SIZE                                                                                                  \n");
        sbSql.append("       , C.UOM_CODE                                                                                                   \n");
        sbSql.append("       , C.PO_UOM                                                                                                     \n");
        sbSql.append("       , DECODE(C.TAX_CODE,'100','과세','210','면세',C.TAX_CODE) TAX_NAME                                             \n");
        sbSql.append("       , C.KEEPING_TYPE                                                                                               \n");
        sbSql.append("       , CASE WHEN TRIM (TRANSLATE (NVL(C.MULTIPLIER_QTY,0), '1234567890.', ' ')) = '.'                               \n");
        sbSql.append("              THEN 'Y'                                                                                                \n");
        sbSql.append("              ELSE 'N'                                                                                                \n");
        sbSql.append("         END  MULTIPLIER_YN                                                                                           \n");
        sbSql.append("       , (SELECT VD_NM FROM VO_FC_VENDOR Z WHERE Z.VD_SN = D.VD_SN) CUSTNM                                            \n");
        sbSql.append("       , D.PROC_TYP_CD                                                                                                \n");
        sbSql.append("  FROM   EPROCUSR.ESPSSGPITM A                                                                                        \n");
        sbSql.append("       , EPROCUSR.ESPSSGP B                                                                                           \n");
        sbSql.append("       , HLDC_PO_ITEM_MST C                                                                                           \n");
        sbSql.append("       , EPROCUSR.ESPINFO D                                                                                           \n");
        sbSql.append(" WHERE   A.SYS_ID      = B.SYS_ID                                                                                     \n");
        sbSql.append("   AND   A.COMP_CD     = B.COMP_CD                                                                                    \n");
        sbSql.append("   AND   A.SHOP_GRP_CD = B.SHOP_GRP_CD                                                                                \n");
        sbSql.append("   AND   A.ITEM_CD     = C.ITEM_CODE                                                                                  \n");
        sbSql.append("   AND   A.SYS_ID      = D.SYS_ID                                                                                     \n");
        sbSql.append("   AND   A.COMP_CD     = D.COMP_CD                                                                                    \n");
        sbSql.append("   AND   A.PURC_OPER_ORG_SN = D.PURC_OPER_ORG_SN                                                                      \n");
        sbSql.append("   AND   A.ITEM_CD     = D.ITEM_CD                                                                                    \n");
        sbSql.append("   AND   A.APPLY_SD    = D.APPLY_SD                                                                                   \n");
        sbSql.append("   AND   A.SYS_ID      = '100'                                                                                        \n");
        sbSql.append("   AND   A.COMP_CD     = 'HFC'                                                                                        \n");
        sbSql.append("   AND   A.STS         <>'D'                                                                                          \n");
        //sbSql.append("   AND   A.PURC_OPER_ORG_SN = DECODE('" + sCenterCode + "','300001','574', '300002','575', '300004', '577', '300005', '611', '300006', '711', '300007', '811', '576')    \n");
        sbSql.append("   AND   A.PURC_OPER_ORG_SN = DECODE('" + sCenterCode + "','300001','574', '300002','575', '300004', '577', '300005', '611', '300006', '711', '300007', '811', '300008', '911', '576')    \n");
        sbSql.append("   AND   B.SHOP_GRP_TYP_CD  = '02'                                                                                    \n");
        sbSql.append("   AND   A.APPLY_SD    <= TO_CHAR(SYSDATE,'YYYYMMDD')                                                                 \n");
        sbSql.append("   AND   A.APPLY_ED    >= TO_CHAR(SYSDATE,'YYYYMMDD')                                                                 \n");
        sbSql.append("   AND   B.STS         <>'D'                                                                                          \n");
        sbSql.append("   AND   B.USE_YN      = 'Y'                                                                                          \n");
        sbSql.append("   AND   (C.ITEM_NAME LIKE '%" + sItemCdNm + "%' OR A.ITEM_CD LIKE '%" + sItemCdNm + "%')                             \n");
		*/
		
		//입수량 추가(BOX_QTY) 2021.08.26
		sbSql.append("SELECT DISTINCT A.ITEM_CD                                                                                              \n");
		sbSql.append(" 		 , C.ITEM_NAME                                                                                                   \n");
		sbSql.append("       , C.ITEM_SIZE                                                                                                   \n");
		sbSql.append("       , C.UOM_CODE                                                                                                    \n");
		sbSql.append("       , C.PO_UOM                                                                                                      \n");
		sbSql.append("       , DECODE(C.TAX_CODE,'100','과세','210','면세',C.TAX_CODE) TAX_NAME                                                \n");
		sbSql.append("       , C.KEEPING_TYPE                                                                                                \n");
		sbSql.append("       , CASE WHEN TRIM (TRANSLATE (NVL(C.MULTIPLIER_QTY,0), '1234567890.', ' ')) = '.'                                \n");
		sbSql.append("              THEN 'Y'                                                                                                 \n");
		sbSql.append("              ELSE 'N'                                                                                                 \n");
		sbSql.append("         END  MULTIPLIER_YN                                                                                            \n");
		sbSql.append("       , (SELECT VD_NM FROM VO_FC_VENDOR Z WHERE Z.VD_SN = D.VD_SN) CUSTNM                                             \n");
		sbSql.append("       , D.PROC_TYP_CD      																							 \n");
		sbSql.append("       , E.BOX_QTY 																									 \n");
		sbSql.append("       , (SELECT CENTER_NAME FROM HLDC_PO_CENTER WHERE CENTER_CODE = (SZF_GETSSPC05@EXEINTF_P('" + sCenterCode + "', A.ITEM_CD))) AS FROM_CNTR_NM  \n");
		sbSql.append("  FROM   EPROCUSR.ESPSSGPITM A                                                                                         \n");
		sbSql.append("       , EPROCUSR.ESPSSGP B                                                                                            \n");
		sbSql.append("       , HLDC_PO_ITEM_MST C                                                                                            \n");
		sbSql.append("       , EPROCUSR.ESPINFO D    																						 \n");
		sbSql.append("       , EPROCUSR.ESPVDBX E 																							 \n");
		sbSql.append(" WHERE   A.SYS_ID      = B.SYS_ID                                                                                      \n");
		sbSql.append("   AND   A.COMP_CD     = B.COMP_CD                                                                                     \n");
		sbSql.append("   AND   A.SHOP_GRP_CD = B.SHOP_GRP_CD                                                                                 \n");
		sbSql.append("   AND   A.ITEM_CD     = C.ITEM_CODE                                                                                   \n");
		sbSql.append("   AND   A.SYS_ID      = D.SYS_ID                                                                                      \n");
		sbSql.append("   AND   A.COMP_CD     = D.COMP_CD                                                                                     \n");
		sbSql.append("   AND   A.PURC_OPER_ORG_SN = D.PURC_OPER_ORG_SN     																	 \n");
		sbSql.append("   AND   A.PURC_OPER_ORG_SN = E.PURC_OPER_ORG_SN 																		 \n");
		sbSql.append("   AND   D.VD_SN = E.VD_SN 																							 \n");
		sbSql.append("   AND   A.ITEM_CD = E.ITEM_CD 																						 \n");
		sbSql.append("   AND   A.ITEM_CD     = D.ITEM_CD                                                                                     \n");
		sbSql.append("   AND   A.APPLY_SD    = D.APPLY_SD                                                                                    \n");
		sbSql.append("   AND   A.SYS_ID      = '100'                                                                                         \n");
		sbSql.append("   AND   A.COMP_CD     = 'HFC'                                                                                         \n");
		sbSql.append("   AND   A.STS         <>'D'                                                                                           \n");
		//sbSql.append("   AND   A.PURC_OPER_ORG_SN = DECODE('" + sCenterCode + "','300001','574', '300002','575', '300004', '577', '300005', '611', '300006', '711', '300007', '811', '576')    \n");
        sbSql.append("   AND   A.PURC_OPER_ORG_SN = DECODE('" + sCenterCode + "','300001','574', '300002','575', '300004', '577', '300005', '611', '300006', '711', '300007', '811', '300008', '911', '576')    \n");
		sbSql.append("   AND   B.SHOP_GRP_TYP_CD  = '02'                                                                                     \n");
		sbSql.append("   AND   A.APPLY_SD    <= TO_CHAR(SYSDATE,'YYYYMMDD')                                                                  \n");
		sbSql.append("   AND   A.APPLY_ED    >= TO_CHAR(SYSDATE,'YYYYMMDD')                                                                  \n");
		sbSql.append("   AND   B.STS         <>'D'                                                                                           \n");
		sbSql.append("   AND   B.USE_YN      = 'Y'                                                                                           \n");
		sbSql.append("   AND   (C.ITEM_NAME LIKE '%" + sItemCdNm + "%' OR A.ITEM_CD LIKE '%" + sItemCdNm + "%')                              \n");

		
		
        out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_CenterItemList");

        pstmt.close();
        rs.close();

        /**종료**/
        out_dl.add(ds_list);
        this.setResultMessage(0, "OK", out_vl);

    } catch (Exception ex) {
        //ex.printStackTrace();
        //jsp 로그남기기
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
        //jsp log 서비스 닫기
        try {
            logger.endIndividualLog();
        } catch (Exception logE) {
            logE.printStackTrace();
        }
    }

    proc_output(response, out, out_vl, out_dl);
%>
