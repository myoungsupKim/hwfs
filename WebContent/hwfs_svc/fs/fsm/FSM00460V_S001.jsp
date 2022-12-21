<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �޴�����/�Ĵܿ����/���Ĺ������� Loss������(������)
�� ���α׷�ID   : FSM00460V_S001.jsp
�� ���α׷���   : ���Ĺ������� Loss������(������)
�� �ۼ�����     : 2008.04.01
�� �ۼ���       : 
�� �̷°���     : 2008.04.21
               ������ 2010-07-26 CSR#(37836) ��û��:�̸���(�޴�������)
               �迭�籸�� �����߰�
             : ������ 2012-06-25 CSR#(CH201206_00149) ��û��:������(fs������)
               ���ܾ��� �˻����� 4�� �߰�
               ����ļ�, 1�ξ����ⷮ, ����� �߰�
-----------------------------------------------------------------------------*/
%>
<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		String MU          	= nullToBlank(in_vl.getString("MU"));		
		String TM 			= nullToBlank(in_vl.getString("TM"));
		String UPJANG 		= nullToBlank(in_vl.getString("UPJANG"));
		String FROM			= nullToBlank(in_vl.getString("FROM"));
		String TO			= nullToBlank(in_vl.getString("TO"));
		String EXCEPT1		= nullToBlank(in_vl.getString("EXCEPT1"));
		String EXCEPT2		= nullToBlank(in_vl.getString("EXCEPT2"));
		String EXCEPT3		= nullToBlank(in_vl.getString("EXCEPT3"));
		String EXCEPT4		= nullToBlank(in_vl.getString("EXCEPT4"));
		
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT /*+ LEADING(E D A) USE_HASH(E D A) USE_HASH(C) */  B.TM_NAME	--��μ�                                                                                                                          			\n");
		sbSql.append("     , B.JOB_NAME	--����                                                                                                                              			\n");
		sbSql.append("     , B.SUB_JOB_NAME	--������                                                                                                                          		\n");
//============================================================================================
//(2010-07-26 �߰�) ����
// ������ 2010-07-26 CSR#(37836) ��û��:�̸���(�޴�������)
// �迭�籸�� ��ȸ���� �߰� �� �����߰�
//============================================================================================
		sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE  WHERE GROUP_CODE = 'MA0003' AND CODE = C.RELATED_YN) RELATED_YN --�迭����	\n");
//============================================================================================
//(2010-07-26 �߰�) ��
//============================================================================================
		sbSql.append("     , B.UPJANGNM	--�����                                                                                                                            			\n");
		sbSql.append("     , SUM(A.KG_QTY) AS KG_QTY  --�ҿ䷮                                                                                                                     		\n");
		sbSql.append("     , SUM(A.EXPECT_MEAL_QTY) AS EXPECT_MEAL_QTY --����ļ�                                                                                                          		\n");
		sbSql.append("     , SUM(A.REAL_MEAL_QTY) AS REAL_MEAL_QTY --�ǽļ�                                                                                                          		\n");
		sbSql.append("     , SUM(A.SALE_MEAL_QTY) AS SALE_MEAL_QTY --����ļ� \n");
		sbSql.append("     , SUM(A.BEFORE_PROC_QTY) AS BEFORE_PROC_QTY  --��ó����                                                                                                   		\n");
		sbSql.append("     , SUM(A.LEAVING_QTY) AS LEAVING_QTY --�ܹݷ�                                                                                                              		\n");
		sbSql.append("     , SUM(A.LEFTOVER_QTY) AS LEFTOVER_QTY --�ܽķ�                                                                                                            		\n");
		sbSql.append("     , NVL(SUM(A.BEFORE_PROC_QTY),0) + NVL(SUM(A.LEAVING_QTY),0) + NVL(SUM(A.LEFTOVER_QTY),0) AS TOT_GARBAGE_QTY --�հ� \n");
		sbSql.append("     , DECODE(NVL(SUM(A.REAL_MEAL_QTY),0), 0, 0, ROUND((NVL(SUM(A.LEAVING_QTY),0) + NVL(SUM(A.LEFTOVER_QTY),0)) / SUM(A.REAL_MEAL_QTY) * 1000, 1)) AS TOT_GARBAGE_QTY1 --1�� �����ⷮ \n");
		sbSql.append("     , DECODE(NVL(SUM(A.SALE_MEAL_QTY),0), 0, 0, ROUND((NVL(SUM(A.LEAVING_QTY),0) + NVL(SUM(A.LEFTOVER_QTY),0)) / SUM(A.SALE_MEAL_QTY) * 1000, 1)) AS TOT_GARBAGE_QTY2 --1�� �����ⷮ2 \n");
		sbSql.append("     , SUM(A.OUT_AMT) AS OUT_AMT --�������� \n");
		sbSql.append("     , DECODE(NVL(SUM(A.KG_QTY),0),0,0,ROUND(NVL(SUM(BEFORE_PROC_QTY),0)*NVL(SUM(OUT_AMT),0)/NVL(SUM(A.KG_QTY),0),0)) BEFORE_LOSS_AMT --��ó��loss��� = (��ó����*��������) / �ҿ䷮		\n");
		sbSql.append("     , DECODE(NVL(SUM(A.KG_QTY),0),0,0,ROUND(NVL(SUM(LEAVING_QTY),0)*NVL(SUM(OUT_AMT),0)/NVL(SUM(A.KG_QTY),0),0)) LEAVING_LOSS_AMT--�ܹ�loss���   = (�ܹݷ�*��������) / �ҿ䷮      		\n");
		sbSql.append("     , DECODE(NVL(SUM(A.KG_QTY),0),0,0,ROUND(NVL(SUM(LEFTOVER_QTY),0)*NVL(SUM(OUT_AMT),0)/NVL(SUM(A.KG_QTY),0),0)) LEFTOVER_LOSS_AMT--�ܽ�loss���   = (�ܽķ�*��������) / �ҿ䷮    		\n");
		sbSql.append("     , SUM(DECODE(NVL(A.EXPECT_MEAL_QTY,0),0,0,1)) AS EEXI \n");
		sbSql.append("     , SUM(DECODE(NVL(A.BEFORE_PROC_QTY,0) + NVL(A.LEAVING_QTY,0) + NVL(A.LEFTOVER_QTY,0),0,0,1)) AS GEXI \n");
		sbSql.append("  FROM MAC_UPJANG_V B, SCO_UPJANG_MST C, HLDC_ST_UPJANG D, HLDC_SC_DEPT_V E \n");
		sbSql.append("     , (                                                                                                                                                    		\n");
		sbSql.append("        SELECT MENU_DATE AS JDATE \n");
		sbSql.append("             , UPJANG \n");
		sbSql.append("             , SUM(EXPECT_MEAL_QTY) AS EXPECT_MEAL_QTY \n");
		sbSql.append("             , SUM(REAL_MEAL_QTY) AS REAL_MEAL_QTY \n");
		sbSql.append("             , NULL AS SALE_MEAL_QTY \n");
		sbSql.append("             , NULL AS KG_QTY	\n");
		sbSql.append("             , NULL AS OUT_AMT \n");
		sbSql.append("             , NULL AS BEFORE_PROC_QTY                                                                                                       		\n");
		sbSql.append("             , NULL AS LEAVING_QTY                                                                                                               		\n");
		sbSql.append("             , NULL AS LEFTOVER_QTY                                                                                                             		\n");
		sbSql.append("          FROM FSM_REAL_MENU_MST                                                                                                                            		\n");
		sbSql.append("         WHERE MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'  --�Ⱓ[���Ͽ��� ����]                                                                           		\n");
		if(!UPJANG.equals(""))
		{
			sbSql.append("           AND UPJANG = "+UPJANG+" -- [����������]                                                                                                            		\n");
		}
		sbSql.append("         GROUP BY MENU_DATE, UPJANG \n");
		sbSql.append("         UNION ALL \n");
        sbSql.append("         SELECT OCCUR_DATE AS JDATE                                   \n");
        sbSql.append("              , UPJANG_CD AS UPJANG                                   \n");
        sbSql.append("              , NULL AS EXPECT_MEAL_QTY                               \n");
        sbSql.append("              , NULL AS REAL_MEAL_QTY                                 \n");
        sbSql.append("              , SUM(SAL_QUANTITY) AS SALE_MEAL_QTY                    \n");
        sbSql.append("              , NULL AS KG_QTY                                        \n");
        sbSql.append("              , NULL AS OUT_AMT                                       \n");
        sbSql.append("              , NULL AS BEFORE_PROC_QTY                               \n");                                                                            
        sbSql.append("              , NULL AS LEAVING_QTY                                   \n");                                                                                
        sbSql.append("              , NULL AS LEFTOVER_QTY                                  \n");                                                                               
        sbSql.append("           FROM SLA_IF_UPJANG_SALS_DETAIL                             \n");                                                          
        sbSql.append("          WHERE SALS_CLASS IN ('1103', '1104')                        \n");                                                          
        sbSql.append("            AND OCCUR_DATE BETWEEN '" + FROM + "' AND '" + TO + "'    \n");
        sbSql.append("            AND NVL(SUP_AMT_YN, 'N') = 'N'                            \n");
        sbSql.append("            AND RECD_STATUS = 'L'                                     \n");
        
		if(!UPJANG.equals(""))
		{
			sbSql.append("        AND UPJANG_CD = " + UPJANG + " -- [����������]                                                                                                            		\n");
		}
        sbSql.append("          GROUP BY OCCUR_DATE, UPJANG_CD  		                    \n");
		sbSql.append("         UNION ALL \n");
//		sbSql.append("        SELECT /*+ USE_HASH(B) USE_HASH(C) INDEX(A PO_TRANSACTION_PT_I6) */  \n");
//		sbSql.append("               A.TRANS_DATE AS JDATE \n");
//		sbSql.append("             , TO_NUMBER(A.TRANS_UPJANG) AS UPJANG \n");
//		sbSql.append("             , NULL AS EXPECT_MEAL_QTY \n");
//		sbSql.append("             , NULL AS REAL_MEAL_QTY \n");
//		sbSql.append("             , NULL AS SALE_MEAL_QTY \n");
//		sbSql.append("             , SUM(ROUND(A.UOM_QTY / C.UOM_CONVERT_RATE * C.KG_CONVERT_RATE,1)) AS KG_QTY	\n");
//		sbSql.append("             , ROUND(NVL( DECODE(B.OUTVAT_FLAG, 'Y', SUM( MARGIN_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1) ) ), SUM( MARGIN_AMOUNT ) ), 0)) AS OUT_AMT \n");
//		sbSql.append("             , NULL AS BEFORE_PROC_QTY                                                                                                       		\n");
//		sbSql.append("             , NULL AS LEAVING_QTY                                                                                                               		\n");
//		sbSql.append("             , NULL AS LEFTOVER_QTY                                                                                                             		\n");
//		sbSql.append("         FROM HLDC_PO_TRANSACTION A, HLDC_PO_SUBINVENTORY B, HLDC_PO_ITEM_MST C \n");
//		sbSql.append("         WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
//		sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE \n");
//		sbSql.append("           AND A.ACCTCD IN ('42203010', '42203020', '42203030') \n");
//		sbSql.append("           AND A.TRANS_MU_CD = '" + MU + "' \n");
//		sbSql.append("           AND A.TRANS_DATE BETWEEN '"+FROM+"' AND '"+TO+"'   --�Ⱓ[���Ͽ��� ����] \n");
//		if(!UPJANG.equals(""))
//		{
//			sbSql.append("           AND A.TRANS_UPJANG = "+UPJANG+" -- [����������]   		\n");
//		}
//		sbSql.append("           AND A.TRANS_TYPE LIKE 'O%'		\n");
//		sbSql.append("           AND A.TRANS_TYPE <> 'O002'			\n");
//		sbSql.append("           AND C.ITEM_CLASS1 = 'F' 	\n");
//		sbSql.append("           AND A.SUBINV_CODE LIKE 'C%'    	\n");
//		sbSql.append("         GROUP BY A.TRANS_DATE, A.TRANS_UPJANG, B.OUTVAT_FLAG \n");
//Ʃ�� ��
		sbSql.append("        SELECT   \n");
		sbSql.append("              MIHD.INSP_DATE AS JDATE \n");
    	sbSql.append("             ,TO_NUMBER(MIHD.SHOP_CD) AS UPJANG \n");
		sbSql.append("             , NULL AS EXPECT_MEAL_QTY \n");
		sbSql.append("             , NULL AS REAL_MEAL_QTY \n");
		sbSql.append("             , NULL AS SALE_MEAL_QTY \n");
		sbSql.append("             , SUM(ROUND(DECODE(MIDT.CANCEL_YN, 'N', MIDT.GAP_QTY, 0) / D.UOM_CONVERT_RATE * D.KG_CONVERT_RATE,1)) AS KG_QTY	   	\n");
		sbSql.append("             , SUM(ROUND(NVL(DECODE(MIDT.CANCEL_YN, 'N', MIDT.GAP_MGT_AMT, 0), 0) + DECODE(MIDT.CANCEL_YN, 'Y', MIDT.AMEND_MGT_AMT, 0) , 2)) AS OUT_AMT \n");
		sbSql.append("             , NULL AS BEFORE_PROC_QTY                                                                                                       		\n");
		sbSql.append("             , NULL AS LEAVING_QTY                                                                                                               		\n");
		sbSql.append("             , NULL AS LEFTOVER_QTY                                                                                                             		\n");
		sbSql.append("  		FROM EPROCUSR.ESIMIHD MIHD   \n");
		sbSql.append("  		 INNER JOIN EPROCUSR.ESIMIDT MIDT   \n");
		sbSql.append("   			    ON MIHD.SYS_ID = MIDT.SYS_ID   \n");
		sbSql.append("    			   AND MIHD.COMP_CD = MIDT.COMP_CD   \n");
		sbSql.append("     			   AND MIHD.IVT_INSP_NO = MIDT.IVT_INSP_NO   \n");
		sbSql.append(" 			  INNER JOIN EPROCUSR.ESPSWHU SWHU   \n");
		sbSql.append("  		        ON MIHD.SYS_ID = SWHU.SYS_ID   \n");
		sbSql.append("       		   AND MIHD.COMP_CD = SWHU.COMP_CD   \n");
		sbSql.append("       		   AND MIHD.WH_CD = SWHU.WH_CD   \n");
		sbSql.append("   		  INNER JOIN SCO_UPJANG_MST A   \n");
	    sbSql.append("    			    ON TO_NUMBER(SWHU.SHOP_CD) = A.UPJANG   \n");
		sbSql.append("  		  INNER JOIN ST_UPJANG B   \n");
	    sbSql.append("     			    ON A.UPJANG = B.UPJANG   \n");
		sbSql.append("   		  INNER JOIN HLDC_SC_DEPT_V C   \n");
		sbSql.append("      		    ON B.DEPT_ID = C.DEPT_ID   \n");
		sbSql.append("    		  INNER JOIN HLDC_PO_ITEM_MST D   \n");
		sbSql.append("      		    ON D.ITEM_CODE = MIDT.ITEM_CD   \n");
		sbSql.append(" 	      WHERE MIHD.SYS_ID = '100'   \n");
		sbSql.append("   	    AND MIHD.COMP_CD = 'HFC'   \n");
		sbSql.append("          AND     C.MU_CD = '" + MU + "' \n");
		sbSql.append("          AND MIHD.INSP_DATE BETWEEN '"+FROM+"' AND '"+TO+"'   --�Ⱓ[���Ͽ��� ����] \n");
		if(!UPJANG.equals(""))
		{
			sbSql.append("      AND   MIHD.SHOP_CD  = "+UPJANG+" -- [����������]   		\n");
		}
		sbSql.append("          AND MIDT.MG_NO IS NOT NULL 		\n");
		sbSql.append("          AND MIHD.WH_CD LIKE 'C%' 		\n");
		sbSql.append("          AND D.ITEM_CLASS1 = 'F' 	\n");
		sbSql.append("          AND MIDT.JRNL_TYP_CD IN (SELECT JRNL_TYP_CD FROM EPROCUSR.ESIJRNL WHERE SYS_ID = '100' AND COMP_CD = 'HFC' AND DR_ACC_CD IN ('42203010', '42203020', '42203030') AND MG_CLS_CD = 'GI')   	\n");
		sbSql.append("         GROUP BY MIHD.INSP_DATE ,MIHD.SHOP_CD  \n");
		sbSql.append("         UNION ALL \n");
/*
		sbSql.append("        SELECT MENU_DATE AS JDATE \n");
		sbSql.append("             , UPJANG                                                                                                                                       		\n");
		sbSql.append("             , NULL AS EXPECT_MEAL_QTY \n");
		sbSql.append("             , NULL AS REAL_MEAL_QTY \n");
		sbSql.append("             , NULL AS SALE_MEAL_QTY \n");
		sbSql.append("             , NULL AS KG_QTY	\n");
		sbSql.append("             , NULL AS OUT_AMT \n");
		sbSql.append("             , SUM(BEFORE_PROC_QTY) AS BEFORE_PROC_QTY                                                                                                      		\n");
		sbSql.append("             , SUM(LEAVING_QTY) AS LEAVING_QTY                                                                                                             		\n");
		sbSql.append("             , SUM(LEFTOVER_QTY) AS LEFTOVER_QTY                                                                                                            		\n");
		sbSql.append("          FROM FSM_DAILY_OP_DIARY                                                                                                                           		\n");
		sbSql.append("         WHERE MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'  --�Ⱓ[���Ͽ��� ����]                                                                           		\n");
		if(!UPJANG.equals(""))
		{
			sbSql.append("           AND UPJANG = "+UPJANG+" -- [����������]                                                                                                            		\n");
		}
		sbSql.append("         GROUP BY MENU_DATE, UPJANG \n");
*/
		sbSql.append("        SELECT /*+ FULL(FSM_DAILY_OP_DIARY) */ MENU_DATE AS JDATE \n");
		sbSql.append("             , UPJANG                                                                                                                                       		\n");
		sbSql.append("             , NULL AS EXPECT_MEAL_QTY \n");
		sbSql.append("             , NULL AS REAL_MEAL_QTY \n");
		sbSql.append("             , NULL AS SALE_MEAL_QTY \n");
		sbSql.append("             , NULL AS KG_QTY	\n");
		sbSql.append("             , NULL AS OUT_AMT \n");
		sbSql.append("             , BEFORE_PROC_QTY                                                                                                      		\n");
		sbSql.append("             , LEAVING_QTY                                                                                                             		\n");
		sbSql.append("             , LEFTOVER_QTY                                                                                                            		\n");
		sbSql.append("          FROM FSM_DAILY_OP_DIARY                                                                                                                           		\n");
		sbSql.append("         WHERE MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'  --�Ⱓ[���Ͽ��� ����]                                                                           		\n");
		if(!UPJANG.equals(""))
		{
			sbSql.append("           AND UPJANG = "+UPJANG+" -- [����������]                                                                                                            		\n");
		}
		sbSql.append("       ) A                                                                                                                                                 		\n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG \n");
		sbSql.append("   AND A.UPJANG = D.UPJANG \n");
		sbSql.append("   AND D.DEPT_ID = E.DEPT_ID \n");
		//���翵�� ���� ������ FC���� ��ȸ���...(ȸ��� �������� ���� �߰� �� ����)
		sbSql.append("   AND NVL(D.CUSTCD,0) = 0 \n");		
	//  sbSql.append("   AND B.JOB_CD <> '006'  --���翵�� ����(����� ����  �Է� �� ���翵��)    \n");		
		sbSql.append("   AND E.MU_CD = '" + MU + "'   --MU ����     \n");
		if(!TM.equals(""))
		{
			sbSql.append("   AND E.TM_CD = '" + TM + "'    --��μ�                                                                                                                     		\n");
		}
		//============================================================================================
		//(2012-06-25 �߰�) ����
		// ������ 2012-06-25 CSR#(CH201206_00149) ��û��:������(fs������)
		// ���ܾ��� �˻����� 4�� �߰�
		// ����ļ�, 1�ξ����ⷮ, ����� �߰�
		//============================================================================================
		if(EXCEPT1.equals("Y"))
			sbSql.append("   AND C.EXCEPT_FLAG = 'N' \n");
		if(EXCEPT2.equals("Y"))
			sbSql.append("   AND A.JDATE >= NVL(C.OPEN_DATE, 'ZZZZZZZZ') \n");
		if(EXCEPT3.equals("Y"))
			sbSql.append("   AND A.JDATE <= NVL(C.CLOSE_DATE, 'ZZZZZZZZ') \n");
		sbSql.append(" GROUP BY B.TM_NAME, B.JOB_NAME, B.SUB_JOB_NAME, C.RELATED_YN, B.UPJANGNM, B.UPJANG \n");
		if(EXCEPT4.equals("Y"))
			sbSql.append("HAVING SUM(A.KG_QTY) != 0 OR SUM(A.REAL_MEAL_QTY) != 0 OR SUM(A.BEFORE_PROC_QTY) <> 0 OR SUM(A.LEAVING_QTY) <> 0 OR SUM(A.LEFTOVER_QTY) <> 0 \n");
		//============================================================================================
		//(2012-06-25 �߰�) ��
		//============================================================================================

		sbSql.append(" ORDER BY B.TM_NAME, B.JOB_NAME, B.SUB_JOB_NAME, C.RELATED_YN, B.UPJANGNM \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);

	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		   ex.printStackTrace();
	       this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
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