<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/식단운영관리/음식물쓰레기 Loss비용관리(관리자)
■ 프로그램ID   : FSM00460V_S001.jsp
■ 프로그램명   : 음식물쓰레기 Loss비용관리(관리자)
■ 작성일자     : 2008.04.01
■ 작성자       : 
■ 이력관리     : 2008.04.21
               박은규 2010-07-26 CSR#(37836) 요청자:이명희(메뉴개발팀)
               계열사구분 내용추가
             : 박은규 2012-06-25 CSR#(CH201206_00149) 요청자:이혜은(fs지원팀)
               제외업장 검색조건 4종 추가
               예상식수, 1인쓰레기량, 등록율 추가
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
		sbSql.append("SELECT /*+ LEADING(E D A) USE_HASH(E D A) USE_HASH(C) */  B.TM_NAME	--운영부서                                                                                                                          			\n");
		sbSql.append("     , B.JOB_NAME	--직군                                                                                                                              			\n");
		sbSql.append("     , B.SUB_JOB_NAME	--상세직군                                                                                                                          		\n");
//============================================================================================
//(2010-07-26 추가) 시작
// 박은규 2010-07-26 CSR#(37836) 요청자:이명희(메뉴개발팀)
// 계열사구분 조회조건 추가 및 내용추가
//============================================================================================
		sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE  WHERE GROUP_CODE = 'MA0003' AND CODE = C.RELATED_YN) RELATED_YN --계열구분	\n");
//============================================================================================
//(2010-07-26 추가) 끝
//============================================================================================
		sbSql.append("     , B.UPJANGNM	--사업장                                                                                                                            			\n");
		sbSql.append("     , SUM(A.KG_QTY) AS KG_QTY  --소요량                                                                                                                     		\n");
		sbSql.append("     , SUM(A.EXPECT_MEAL_QTY) AS EXPECT_MEAL_QTY --예상식수                                                                                                          		\n");
		sbSql.append("     , SUM(A.REAL_MEAL_QTY) AS REAL_MEAL_QTY --실식수                                                                                                          		\n");
		sbSql.append("     , SUM(A.SALE_MEAL_QTY) AS SALE_MEAL_QTY --매출식수 \n");
		sbSql.append("     , SUM(A.BEFORE_PROC_QTY) AS BEFORE_PROC_QTY  --전처리량                                                                                                   		\n");
		sbSql.append("     , SUM(A.LEAVING_QTY) AS LEAVING_QTY --잔반량                                                                                                              		\n");
		sbSql.append("     , SUM(A.LEFTOVER_QTY) AS LEFTOVER_QTY --잔식량                                                                                                            		\n");
		sbSql.append("     , NVL(SUM(A.BEFORE_PROC_QTY),0) + NVL(SUM(A.LEAVING_QTY),0) + NVL(SUM(A.LEFTOVER_QTY),0) AS TOT_GARBAGE_QTY --합계 \n");
		sbSql.append("     , DECODE(NVL(SUM(A.REAL_MEAL_QTY),0), 0, 0, ROUND((NVL(SUM(A.LEAVING_QTY),0) + NVL(SUM(A.LEFTOVER_QTY),0)) / SUM(A.REAL_MEAL_QTY) * 1000, 1)) AS TOT_GARBAGE_QTY1 --1인 쓰레기량 \n");
		sbSql.append("     , DECODE(NVL(SUM(A.SALE_MEAL_QTY),0), 0, 0, ROUND((NVL(SUM(A.LEAVING_QTY),0) + NVL(SUM(A.LEFTOVER_QTY),0)) / SUM(A.SALE_MEAL_QTY) * 1000, 1)) AS TOT_GARBAGE_QTY2 --1인 쓰레기량2 \n");
		sbSql.append("     , SUM(A.OUT_AMT) AS OUT_AMT --사용식재료비 \n");
		sbSql.append("     , DECODE(NVL(SUM(A.KG_QTY),0),0,0,ROUND(NVL(SUM(BEFORE_PROC_QTY),0)*NVL(SUM(OUT_AMT),0)/NVL(SUM(A.KG_QTY),0),0)) BEFORE_LOSS_AMT --전처리loss비용 = (전처리량*사용식재료비) / 소요량		\n");
		sbSql.append("     , DECODE(NVL(SUM(A.KG_QTY),0),0,0,ROUND(NVL(SUM(LEAVING_QTY),0)*NVL(SUM(OUT_AMT),0)/NVL(SUM(A.KG_QTY),0),0)) LEAVING_LOSS_AMT--잔반loss비용   = (잔반량*사용식재료비) / 소요량      		\n");
		sbSql.append("     , DECODE(NVL(SUM(A.KG_QTY),0),0,0,ROUND(NVL(SUM(LEFTOVER_QTY),0)*NVL(SUM(OUT_AMT),0)/NVL(SUM(A.KG_QTY),0),0)) LEFTOVER_LOSS_AMT--잔식loss비용   = (잔식량*사용식재료비) / 소요량    		\n");
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
		sbSql.append("         WHERE MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'  --기간[동일월만 가능]                                                                           		\n");
		if(!UPJANG.equals(""))
		{
			sbSql.append("           AND UPJANG = "+UPJANG+" -- [업장지정시]                                                                                                            		\n");
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
			sbSql.append("        AND UPJANG_CD = " + UPJANG + " -- [업장지정시]                                                                                                            		\n");
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
//		sbSql.append("           AND A.TRANS_DATE BETWEEN '"+FROM+"' AND '"+TO+"'   --기간[동일월만 가능] \n");
//		if(!UPJANG.equals(""))
//		{
//			sbSql.append("           AND A.TRANS_UPJANG = "+UPJANG+" -- [업장지정시]   		\n");
//		}
//		sbSql.append("           AND A.TRANS_TYPE LIKE 'O%'		\n");
//		sbSql.append("           AND A.TRANS_TYPE <> 'O002'			\n");
//		sbSql.append("           AND C.ITEM_CLASS1 = 'F' 	\n");
//		sbSql.append("           AND A.SUBINV_CODE LIKE 'C%'    	\n");
//		sbSql.append("         GROUP BY A.TRANS_DATE, A.TRANS_UPJANG, B.OUTVAT_FLAG \n");
//튜닝 후
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
		sbSql.append("          AND MIHD.INSP_DATE BETWEEN '"+FROM+"' AND '"+TO+"'   --기간[동일월만 가능] \n");
		if(!UPJANG.equals(""))
		{
			sbSql.append("      AND   MIHD.SHOP_CD  = "+UPJANG+" -- [업장지정시]   		\n");
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
		sbSql.append("         WHERE MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'  --기간[동일월만 가능]                                                                           		\n");
		if(!UPJANG.equals(""))
		{
			sbSql.append("           AND UPJANG = "+UPJANG+" -- [업장지정시]                                                                                                            		\n");
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
		sbSql.append("         WHERE MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'  --기간[동일월만 가능]                                                                           		\n");
		if(!UPJANG.equals(""))
		{
			sbSql.append("           AND UPJANG = "+UPJANG+" -- [업장지정시]                                                                                                            		\n");
		}
		sbSql.append("       ) A                                                                                                                                                 		\n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG \n");
		sbSql.append("   AND A.UPJANG = D.UPJANG \n");
		sbSql.append("   AND D.DEPT_ID = E.DEPT_ID \n");
		//식재영업 업장 제외한 FC업장 조회대상...(회계상 기준으로 조건 추가 한 것임)
		sbSql.append("   AND NVL(D.CUSTCD,0) = 0 \n");		
	//  sbSql.append("   AND B.JOB_CD <> '006'  --식재영업 제외(사람이 직접  입력 한 식재영업)    \n");		
		sbSql.append("   AND E.MU_CD = '" + MU + "'   --MU 구분     \n");
		if(!TM.equals(""))
		{
			sbSql.append("   AND E.TM_CD = '" + TM + "'    --운영부서                                                                                                                     		\n");
		}
		//============================================================================================
		//(2012-06-25 추가) 시작
		// 박은규 2012-06-25 CSR#(CH201206_00149) 요청자:이혜은(fs지원팀)
		// 제외업장 검색조건 4종 추가
		// 예상식수, 1인쓰레기량, 등록율 추가
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
		//(2012-06-25 추가) 끝
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