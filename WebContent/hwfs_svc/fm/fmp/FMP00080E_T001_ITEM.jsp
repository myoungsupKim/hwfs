<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �ֹ����� > ���ְ��� > ��ǰ����
�� ���α׷�ID   : FMP00080E_T001_ITEM.jsp
�� ���α׷���   : ��ǰ����
�� �ۼ�����     : 2017.09.21
�� �ۼ���       : ������
�� �̷°���     : 
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
        
		DataSet ds_cond = in_dl.get("ds_Cond");		//in dataset
		DataSet ds_list;							//out dataset

        String strPrUpjang	= nullToBlank(in_vl.getString("g_Upjang"));						//������ȣ
        String strMonth		= nullToBlank(in_vl.getString("nMonth"));						//�ֱ� n����
        boolean bOrderable	= in_vl.getBoolean("bOrderable");								//ȭ�鿡�� �ֹ����ɻ�ǰ üũ ����
        
        String strItemName		= nullToBlank(ds_cond.getString(0, "ITEM_NAME"));			//��ȸ �� �Է��� ��ǰ��
        String strCenterCode	= nullToBlank(ds_cond.getString(0, "CENTER_CODE"));			//HLDC_PO_UPJANG_CENTER.CENTER_CODE
        String strUpjang		= nullToBlank(ds_cond.getString(0, "UPJANG"));				//�����
        String strSubinvCode	= nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));			//â��
        String strNeedDate		= nullToBlank(ds_cond.getString(0, "NEED_DATE"));			//�԰�����
        String strConsumYn		= nullToBlank(ds_cond.getString(0, "CONSUM_YN"));			//FMS_SUBINVENTORY.CONSUM_YN
        String strQtyControlYn	= nullToBlank(ds_cond.getString(0, "QTY_CONTROL_YN"));		//������������
        String strItemClass2	= nullToBlank(ds_cond.getString(0, "ITEM_CLASS2"));			//�ߺз�
        String strItemClass3	= nullToBlank(ds_cond.getString(0, "ITEM_CLASS3"));			//�Һз�
        String strItemClass4	= nullToBlank(ds_cond.getString(0, "ITEM_CLASS4"));			//���з�
        String strHolidayChkYn 	= "";

        StringBuffer sbSql = new StringBuffer();
		
        //D-1��ǰ ���� üũ ���� ����_Y��:�Ͽ��� üũ ���ϰ� �Ͽ��� ���� ����
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT HOLIDAY_CHK_YN 		\n");
        sbSql.append("FROM   FMS_UPJANG A 			\n");
        sbSql.append("WHERE  A.UPJANG = :UPJANG 	\n");

        npstmt = new NamedParameterStatement(conn, sbSql.toString());

        npstmt.setString("UPJANG", strUpjang);
        
        rs = npstmt.executeQuery();            

        if(rs != null) {
			rs.next();
			strHolidayChkYn = rs.getString("HOLIDAY_CHK_YN");
        }
        
        if(rs != null) rs.close();
        npstmt.close();
        
        //������ȸ
        sbSql.delete(0, sbSql.length());

		sbSql.append("SELECT ITEM_CODE                                                  \n");
		sbSql.append("     , ITEM_NAME                                                  \n");
		sbSql.append("     , ITEM_SIZE                                                  \n");
		sbSql.append("     , PO_UOM                                                     \n");
		sbSql.append("     , UNIT_PRICE                                                 \n");
		sbSql.append("     , MARGIN_PRICE                                               \n");
		sbSql.append("     , SALE_PRICE                                                 \n");
		sbSql.append("     , PR_QTY                                                     \n");
		sbSql.append("     , SALE_AMOUNT                                                \n");
		sbSql.append("     , LINE_STATUS                                                \n");
		sbSql.append("     , CLS_STATUS                                                 \n");
		sbSql.append("     , PR_REMARK                                                  \n");
		sbSql.append("     , SUBINV_CODE                                                \n");
		sbSql.append("     , NEED_DATE                                                  \n");
		sbSql.append("     , PRE_NEED_DATE                                              \n");
		sbSql.append("     , TAX_CODE                                                   \n");
		sbSql.append("     , CUSTCD                                                     \n");
		sbSql.append("     , CENTER_FLAG                                                \n");
		sbSql.append("     , CENTER_CODE                                                \n");
		sbSql.append("     , POINT_FLAG                                                 \n");
		sbSql.append("     , PR_UPJANG                                                  \n");
		sbSql.append("     , RC_UPJANG                                                  \n");
		sbSql.append("     , INVAT_FLAG                                                 \n");
		sbSql.append("     , OUTVAT_FLAG                                                \n");
		sbSql.append("     , MIN_ORD_QTY                                                \n");
		sbSql.append("     , MAX_ORD_QTY                                                \n");
		sbSql.append("     , MULTIPLIER_QTY                                             \n");
		sbSql.append("     , OTCUSTCD                                                   \n");
		sbSql.append("     , OP_PRICE                                                   \n");
		sbSql.append("     , OP_RATE                                                    \n");
		sbSql.append("     , OP_AMOUNT                                                  \n");
		sbSql.append("     , G_PRICE                                                    \n");
		sbSql.append("     , OP_AMOUNT_OLD                                              \n");
		sbSql.append("     , D_DAYS                                                     \n");
		sbSql.append("     , D_TIMES                                                    \n");
		sbSql.append("     , D_DAY_DISP                                                 \n");
		sbSql.append("     , OTCUSTNM                                                   \n");
		sbSql.append("     , KG_CONVERT_RATE                                            \n");
		sbSql.append("     , FEATURE_NAME_CHK                                           \n");
		sbSql.append("     , IMAGE_PATH                                                 \n");
		sbSql.append("     , IMAGE_YN                                                   \n");
		sbSql.append("     , LIMIT_ITEM                                                 \n");
		sbSql.append("     , LIMIT_REASON                                               \n");
		sbSql.append("     , CONSUM_YN                                                  \n");
		sbSql.append("     , PR_ID                                                      \n");
		sbSql.append("     , KEEPING_TYPE                                               \n");
		sbSql.append("     , APPLY_SD                                                   \n");
		sbSql.append("     , VD_SN                                                      \n");
		sbSql.append("     , ORIGIN_TYPE                                                \n");
		sbSql.append("     , MOBILE_GUBUN                                               \n");
		sbSql.append("     , UPJANG_GRP                                                 \n");
		sbSql.append("     , PO_STATUS                                                  \n");
		sbSql.append("     , UNUSE_YN                                                   \n");
		sbSql.append("     , VAL_STP_YN                                                 \n");
		sbSql.append("     , FMP_STATUS                                                 \n");
		sbSql.append("     , PO_WEEK_STATUS                                             \n");
		sbSql.append("     , DANGA_ITEM_CODE                                            \n");
		sbSql.append("     , MAX_SO_QTY                                                 \n");
		sbSql.append("     , TOT_SO_AMT                                                 \n");
		sbSql.append("     , FEATURE_NAME                                               \n");
		sbSql.append("     , FEATURE_ICON                                               \n");
		sbSql.append("     , WEEK_ITEM_CODE                                             \n");
		sbSql.append("     , DANGAWEEK_STATUS                                           \n");
		sbSql.append("FROM TABLE(FCUS.PKG_ITEM_SEARCH.FT_ITEM_SEARCH_DISP_INFO(         \n");
		sbSql.append("                  :CENTER_CODE									\n"); 
		sbSql.append("                , :UPJANG											\n"); 
		sbSql.append("                , :SUBINV_CODE                      				\n"); 
		sbSql.append("                , :NEED_DATE                          			\n"); 
		sbSql.append("                , :ITEM_NAME                   					\n"); 
		sbSql.append("                , :PR_UPJANG                            			\n"); 
		sbSql.append("                , :ORD_ENABLE_YN                                	\n"); 
		sbSql.append("                , :CONSUM_YN                                      \n"); 
		sbSql.append("                , :HOLIDAY_CHK_YN                              	\n"); 
		sbSql.append("                , :QTY_CONTROL_YN                              	\n"); 
		sbSql.append("                , :ITEM_CLASS2                                    \n"); 
		sbSql.append("                , :ITEM_CLASS3                                    \n"); 
		sbSql.append("                , :ITEM_CLASS4                                    \n"); 
		sbSql.append("                , :AMT_MONTH_CNT       							\n"); 
		sbSql.append("                , NULL						                    \n"); 
		sbSql.append("))																\n"); 
        
		out_vl.add("fa_Sql", sbSql.toString());
		
        npstmt = new NamedParameterStatement(conn, sbSql.toString());

        npstmt.setString("CENTER_CODE"		, strCenterCode);
        npstmt.setString("UPJANG"			, strUpjang);
        npstmt.setString("SUBINV_CODE"		, strSubinvCode);
        npstmt.setString("NEED_DATE"		, strNeedDate);
        npstmt.setString("ITEM_NAME"		, strItemName);
        npstmt.setString("PR_UPJANG"		, strPrUpjang);
        npstmt.setString("ORD_ENABLE_YN"	, bOrderable == true ? "Y" : "N");
        npstmt.setString("CONSUM_YN"		, strConsumYn);
        npstmt.setString("HOLIDAY_CHK_YN"	, strHolidayChkYn);
        npstmt.setString("QTY_CONTROL_YN"	, strQtyControlYn);
        npstmt.setString("ITEM_CLASS2"		, strItemClass2);
        npstmt.setString("ITEM_CLASS3"		, strItemClass3);
        npstmt.setString("ITEM_CLASS4"		, strItemClass4);
        npstmt.setString("AMT_MONTH_CNT"	, strMonth);
        
        rs = npstmt.executeQuery();    
        
        ds_list = this.makeDataSet(rs, "ds_List");

        out_dl.add(ds_list);
        
        this.setResultMessage(0, "OK", out_vl);
    }
    catch(Exception ex) {
        //ex.printStackTrace();
        //jsp �α׳����
        logger.debug(ex.getMessage(), ex);
        this.setResultMessage(-1, ex.toString(),out_vl);
    } finally {
        if(rs != null) {
            try {
                rs.close();
            }catch(Exception e) {}
        }
        if(npstmt != null) {
            try {
                npstmt.close();
            } catch (Exception e) {}
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

    proc_output(response, out, out_vl, out_dl);
%>