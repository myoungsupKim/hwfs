<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���Ű���/���Ž�û/���Ž�û����
�� ���α׷�ID   : FSP00090V_S002.jsp
�� ���α׷���   : ���Ž�û���� ����ȸ
�� �ۼ�����     : 2008-01-28
�� �ۼ���       : �赿ǥ
�� ������       : ����ö
�� �̷°���     : 2015-06-03
1)��ȭ �������� - ���̺�� ����
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    try {
        //�Ⱓ�� �󼼳��� ��ȸ
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();
        
        //�Է� ����Ÿ
        DataSet ds_input = in_dl.get("ds_input");
    
        //�Է� ����Ÿ
        String DATE_TYPE   = nullToBlank(ds_input.getString(0, "DATE_TYPE"));   
        String START_DATE  = nullToBlank(ds_input.getString(0, "START_DATE"));   
        String END_DATE    = nullToBlank(ds_input.getString(0, "END_DATE"));       
        String UPJANG      = nullToBlank(ds_input.getString(0, "UPJANG")); 
        String DEPT_TYPE   = nullToBlank(ds_input.getString(0, "DEPT_TYPE"));     
        String PR_NUM      = nullToBlank(ds_input.getString(0, "PR_NUM")); 
        String RC_DEPT_ID  = nullToBlank(ds_input.getString(0, "RC_DEPT_ID"));
        
        //out ����Ÿ
        DataSet ds_list;

        //sql�� ���ۻ���
        StringBuffer sbSql = new StringBuffer();
        sbSql.delete(0, sbSql.length()); //Ŭ����
        
        sbSql.append("\n SELECT  C.ITEM_CODE                                                                                                             ");
        sbSql.append("\n       , C.ITEM_NAME                                                                                                             ");
        sbSql.append("\n       , C.ITEM_SIZE                                                                                                             ");
        sbSql.append("\n       , A.PO_UOM                                                                                                                ");
        sbSql.append("\n       , DECODE(F.PR_REMARK, NULL, NULL, F.PR_REMARK)  AS PR_REMARK                                                              ");
        sbSql.append("\n       , A.NEED_DATE                                                                                                             ");
        sbSql.append("\n       , A.MARGIN_PRICE                                                                                                          ");
        sbSql.append("\n       , DECODE(SUBSTR(A.ITEM_CODE, 1, 1), 'F', F.PR_QTY, A.PO_QTY) AS  PR_QTY                                                   ");
        sbSql.append("\n       , A.PO_QTY                                                                                                                ");
        sbSql.append("\n       , (A.MARGIN_PRICE * A.PO_QTY) AS MARGIN_PR_PRICE                                                                          ");
        sbSql.append("\n       , D.MU_NM||' '||NVL(A.SUBINV_CODE||' '||B.SUBINV_NAME, D.TM_NM||' '||D.CC_NM) AS SUBINV_NAME                              ");
        sbSql.append("\n       , A.LINE_STATUS                                                                                                           ");
        sbSql.append("\n       , DECODE(A.TAX_CODE,'100','����','210','�鼼','����') AS TAX_CODE                                                         ");
        sbSql.append("\n       , E.VD_NM AS  CUSTNM                                                                                                      ");
        sbSql.append("\n       , TO_CHAR(TO_DATE(A.ORDER_DATE,'YYYYMMDDHH24MISS'),'YYYY-MM-DD HH24:MI') AS PR_TIME                                       ");
        sbSql.append("\n       , NVL((                                                                                                                   ");
        sbSql.append("\n             SELECT DISTINCT 'Y'                                                                                                 ");
        sbSql.append("\n               FROM HLDC_PO_SUBINVENTORY X                                                                                       ");
        sbSql.append("\n              WHERE X.UPJANG = A.RC_UPJANG                                                                                       ");
        sbSql.append("\n                AND OUTVAT_FLAG = 'Y'                                                                                            ");
        sbSql.append("\n             ),'N') SCHOOL_YN                                                                                                    ");
        sbSql.append("\n       , A.SUBINV_CODE                                                                                                           ");
        sbSql.append("\n       , A.RC_UPJANG                                                                                                             ");
        sbSql.append("\n       , C.IMG_YN                                                                                                                ");
        sbSql.append("\n       , C.IMG_PATH                                                                                                              ");
        sbSql.append("\n       , FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.NEED_DATE)                                ");
        sbSql.append("\n                              , (SELECT H.PB_YN FROM FCUS.HLDC_PO_CONTRACT_F H                                                   ");
        sbSql.append("\n                                  WHERE A.ITEM_CODE   = H.ITEM_CODE                                                              ");
        sbSql.append("\n                                    AND A.RC_UPJANG   = H.UPJANG                                                                 ");
        sbSql.append("\n                                    AND A.CENTER_CODE = H.CENTER_CODE                                                            ");
        sbSql.append("\n                                    AND A.NEED_DATE   BETWEEN H.CONTRACT_START AND H.CONTRACT_END)                               ");
        sbSql.append("\n                              , C.ECO_ITEM, C.MANUF_CD ) AS FEATURE_NAME                                                         ");
        sbSql.append("\n       ,  NVL(H.D_DAYS,0) + 1 AS D_DAY                                                        ");
        sbSql.append("\n    FROM HLDC_PO_PO A                                                                                                            ");
        sbSql.append("\n       , HLDC_PO_SUBINVENTORY B                                                                                                  ");
        sbSql.append("\n       , HLDC_PO_ITEM_MST C                                                                                                      ");
        sbSql.append("\n       , HLDC_SC_DEPT_V D                                                                                                        ");
        sbSql.append("\n       , VO_FC_VENDOR E                                                                                                          ");
        sbSql.append("\n       , SO_PR F                                                                                                                 ");
        sbSql.append("\n       , FSI_DUTY_MST G                                                                                                          ");
        sbSql.append("\n       , HLDC_PO_PREORDER_LIST H                                                                                                          ");
        sbSql.append("\n   WHERE A.RC_DEPT_ID  = D.DEPT_ID                                                                                               ");
        sbSql.append("\n     AND A.SUBINV_CODE = B.SUBINV_CODE                                                                                           ");
        sbSql.append("\n     AND A.CUSTCD      = E.VD_CD(+)                                                                                              ");
        sbSql.append("\n     AND A.PO_ID       = F.PR_ID(+)                                                                                               ");
        sbSql.append("\n     AND A.PO_NUM      = F.PR_NUM(+)                                                                                             ");
        sbSql.append("\n     AND A.ITEM_CODE   = C.ITEM_CODE                                                                                             ");
        sbSql.append("\n     AND A.ITEM_CODE   = G.ITEM_CODE(+)                                                                                          ");
        sbSql.append("\n     AND A.CUSTCD      = TO_CHAR(G.CUSTCD(+))                                                                                    ");
        sbSql.append("\n     AND A.CENTER_CODE = H.CENTER_CODE(+)                                                                                        ");                                                        
        sbSql.append("\n     AND A.ITEM_CODE   = H.ITEM_CODE  (+)    																					 ");
        sbSql.append("\n     AND A.CENTER_CODE = G.CENTER_CODE(+)                                                                                        ");
        sbSql.append("\n     AND G.USE_YN (+)  = 'Y'                                                                                                     ");
        sbSql.append("\n     AND A.NEED_DATE   BETWEEN G.START_DATE(+)  AND G.END_DATE(+)                                                                ");
        //sbSql.append("\n     AND DECODE(TRIM(F.ORG_PR_NUM), NULL, A.PO_NUM, F.ORG_PR_NUM) = ?                                             ");
        //�ӵ����� ó�� 20190422 ��ȣ��
        sbSql.append("\n     AND ((F.ORG_PR_NUM = :PR_NUM  ) OR (A.PO_NUM = :PR_NUM   ) )                                   ");
        //�ӵ����� ó�� 20180420 ��ȣ��-�Ϲ�����(���ſ��� ��û) �ȳ��ͼ� ����
        //sbSql.append("\n     AND F.ORG_PR_NUM = '" + PR_NUM + "'                                             ");
        if(DATE_TYPE.equals("1"))
            sbSql.append("\n    AND A.NEED_DATE BETWEEN  :START_DATE   AND :END_DATE                                                          ");
        if(DEPT_TYPE.equals("1"))  //�˼��μ��� ��ȸ üũ�Ǿ��ٸ�....
            sbSql.append("\n    AND A.RC_DEPT_ID  = :RC_DEPT_ID                                                                                    ");
        if(!UPJANG.equals(""))
        	sbSql.append("\n    AND A.RC_UPJANG  = :UPJANG                                                                                          ");

        int idx = 1;
        
 	// 20190422 ��ȣ�� ���� ���� ���ε���� �߰�
				
        npstmt = new NamedParameterStatement(conn, sbSql.toString());

        npstmt.setString("PR_NUM", PR_NUM);
        
        if(DATE_TYPE.equals("1")) {
        	npstmt.setString("START_DATE", START_DATE);		
        	npstmt.setString("END_DATE", END_DATE);
		}
		if(!UPJANG.equals("")) {
			npstmt.setString("UPJANG", UPJANG);
		}	

        rs = npstmt.executeQuery();
        
        /*
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.setString(idx++, PR_NUM);
		pstmt.setString(idx++, PR_NUM);
		if(DATE_TYPE.equals("1")) {
			pstmt.setString(idx++, START_DATE);		
			pstmt.setString(idx++, END_DATE);
			pstmt.setString(idx++, RC_DEPT_ID);
		}
		if(!UPJANG.equals("")) {
			pstmt.setString(idx++, UPJANG);
		}	
		rs = pstmt.executeQuery();                     
		*/
		
        //pstmt = conn.prepareStatement(sbSql.toString());
        //rs = pstmt.executeQuery();
        DataSet ds_grdList2 = this.makeDataSet(rs, "ds_grdList2"); //ds_list

        
        /**����**/
        out_dl.add(ds_grdList2);
        this.setResultMessage(0, "OK", out_vl);
    }
    catch(Exception ex)
    {
        ex.printStackTrace();
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
    }
    proc_output(response,out,out_vl,out_dl);
%>