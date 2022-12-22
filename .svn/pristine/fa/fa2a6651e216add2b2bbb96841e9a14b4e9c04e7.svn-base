<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/식단운영관리/음식물쓰레기 Loss비용관리(관리자)
■ 프로그램ID   : FSM00450V_S002.jsp
■ 프로그램명   : 음식물쓰레기 Loss비용관리(관리자)
■ 작성일자     : 2008.04.21
■ 작성자       : 
■ 이력관리     : 2008.04.21
               박은규 2010-07-26 CSR#(37836) 요청자:이명희(메뉴개발팀)
               계열사구분 조회조건 추가 및 내용추가
-----------------------------------------------------------------------------*/
%>
<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
						
			String MU       	= nullToBlank(in_vl.getString("MU"));		
			String TM 			= nullToBlank(in_vl.getString("TM"));
			String UPJANG 		= nullToBlank(in_vl.getString("UPJANG"));
			String FROM			= nullToBlank(in_vl.getString("FROM"));
			String MGMT1		= nullToBlank(in_vl.getString("MGMT1"));	
			String MGMT			= nullToBlank(in_vl.getString("MGMT"));
			String FEE			= nullToBlank(in_vl.getString("FEE"));
			String REL			= nullToBlank(in_vl.getString("REL"));
			String COMP			= nullToBlank(in_vl.getString("COMP"));
			String CHK_CLOSE	= nullToBlank(in_vl.getString("CHK_CLOSE"));
			
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.TM_NAME                                                                                                           	\n");
		sbSql.append("     , A.JOB_NAME                                                                                                          	\n");
		sbSql.append("     , A.SUB_JOB_NAME                                                                                                      	\n");
//============================================================================================
//(2010-07-26 추가) 시작
// 박은규 2010-07-26 CSR#(37836) 요청자:이명희(메뉴개발팀)
// 계열사구분 조회조건 추가 및 내용추가
//============================================================================================
		sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE  WHERE GROUP_CODE = 'MA0003' AND CODE = A1.RELATED_YN) RELATED_YN --계열구분	\n");
//============================================================================================
//(2010-07-26 추가) 끝
//============================================================================================
		sbSql.append("     , A2.UPJANGNM                                                                                                          	\n");
		sbSql.append("     , B.REMAIN_COMPANY  --처리업체                                                                                        	\n");
		sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE  WHERE GROUP_CODE = 'MA0042' AND CODE = B.MGMT_CD1) MGMT_CD1NM --계약관리주체	\n");
		sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE  WHERE GROUP_CODE = 'MA0037' AND CODE = B.MGMT_CD) MGMT_CDNM --비용부담주체  	\n");
		sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE  WHERE GROUP_CODE = 'MA0039' AND CODE = B.FEE_CD) FEE_CDNM  --요금체계       	\n");
		sbSql.append("     , DECODE(B.FEE_CD, '003', B.ATTR01, TO_CHAR(B.UPRICE)) UPRICE -- 단가                                                                                                    	\n");
		sbSql.append("     , NVL(D.BEFORE_PROC_QTY,0) BEFORE_PROC_QTY  --전처리량                                                                                                   		\n");
		sbSql.append("     , NVL(D.LEAVING_QTY,0) LEAVING_QTY --잔반량                                                                                                              		\n");
		sbSql.append("     , NVL(D.LEFTOVER_QTY,0) LEFTOVER_QTY --잔식량                                                                                                            		\n");
		sbSql.append("     , NVL(D.BEFORE_PROC_QTY,0)+NVL(D.LEAVING_QTY,0)+NVL(D.LEFTOVER_QTY,0) TOT_GARBAGE_QTY --합계                                                                 		\n");
		sbSql.append("     , DECODE(B.FEE_CD,'002','Y','N') FEE_ABLE \n");
		sbSql.append("     , DECODE(B.FEE_CD,'002',NVL(B.UPRICE,0)*(NVL(D.BEFORE_PROC_QTY,0)+NVL(D.LEAVING_QTY,0)+NVL(D.LEFTOVER_QTY,0)),NULL) FEE_EXPENSE --용량제처리비용                          	\n");
		sbSql.append("     , NVL(REAL_MEAL_QTY,0) REAL_MEAL_QTY --실식수                                                                         	\n");
		sbSql.append("     , NVL(E.ADV_AMT,0) ADV_AMT --월처리비용                                                                               	\n");
		sbSql.append("     , DECODE(REAL_MEAL_QTY,NULL,0,0,0, ROUND(NVL(E.ADV_AMT,0)/REAL_MEAL_QTY,1)) PER_EXPENSE --1인처리비용                 	\n");
		sbSql.append("     , NVL(V.SIC_QTY,0) SIC_QTY --식수                                                                               	\n");
		sbSql.append("     , NVL(V.SIC_AMT,0) SIC_AMT --식음매출                                                                               	\n");
		sbSql.append("  FROM MAC_UPJANG_V A, SCO_UPJANG_MST A1, HLDC_ST_UPJANG A2, HLDC_SC_DEPT A3, 	\n");
		sbSql.append("       (SELECT *                                                                                                           	\n");
		sbSql.append("          FROM SCO_UPJANG_REMAINMEAL                                                                                       	\n");
		sbSql.append("         WHERE (1=1)                                                                                                       	\n");
		if(!COMP.equals(""))
		{
		sbSql.append("           AND REMAIN_COMPANY LIKE '"+COMP+"%' --처리업체                                                                          	\n");
		}
		if(!MGMT1.equals(""))
		{
		sbSql.append("           AND MGMT_CD1 = '"+MGMT1+"' --계약관리주체                                                                                	\n");
		}
		if(!MGMT.equals(""))
		{
		sbSql.append("           AND MGMT_CD = '"+MGMT+"' --비용부담주체                                                                                 	\n");
		}
		if(!FEE.equals(""))
		{
		sbSql.append("           AND FEE_CD = '"+FEE+"' --요금체계                                                                                      	\n");
		}
		sbSql.append("       ) B                                                                                                                 	\n");
		sbSql.append("     , (                                                                                                                   	\n");
		sbSql.append("        SELECT UPJANG, NVL(SUM(REAL_MEAL_QTY),0) REAL_MEAL_QTY                                                             	\n");
		sbSql.append("          FROM FSM_REAL_MENU_MST                                                                                           	\n");
		sbSql.append("         WHERE MENU_DATE LIKE '"+FROM+"%'                                                                                    	\n");
		sbSql.append("         GROUP BY UPJANG                                                                                                   	\n");
		sbSql.append("       ) C                                                                                                                 	\n");
		sbSql.append("     , (                                                                                                                   	\n");
		sbSql.append("        SELECT UPJANG \n");
		sbSql.append("             , SUM(LEAVING_QTY) AS LEAVING_QTY \n");
		sbSql.append("             , SUM(LEFTOVER_QTY) AS LEFTOVER_QTY \n");
		sbSql.append("             , SUM(BEFORE_PROC_QTY) AS BEFORE_PROC_QTY \n");
		sbSql.append("          FROM FSM_DAILY_OP_DIARY                                                                                          	\n");
		sbSql.append("         WHERE MENU_DATE LIKE '"+FROM+"%'                                                                                    	\n");
		sbSql.append("         GROUP BY UPJANG                                                                                                   	\n");
		sbSql.append("       ) D                                                                                                                 	\n");
		sbSql.append("     , (                                                                                                                   	\n");		
        sbSql.append("        SELECT UPJANG, NVL(SUM(AMT), 0) ADV_AMT                                                                               \n");
        sbSql.append("               FROM MAP_PREPAY_ADJUST A                                                                                       \n");
        sbSql.append("                  , SCO_UPJANG_MST_V B                                                                                        \n");
        sbSql.append("              WHERE B.DEPT_ID = A.CC_CD                                                                                       \n");
        sbSql.append("                AND A.ACCT_CD = '43211050'                                                                                    \n");
        sbSql.append("                AND A.BASIS_DATE LIKE '" + FROM + "%'                                                                         \n");
        sbSql.append("              GROUP BY UPJANG, SUBSTR(BASIS_DATE,1,6)                                                                         \n");
		sbSql.append("       ) E                                                                                                                 	\n");
		sbSql.append("     , (                                                                                                                   	\n");		
		sbSql.append("        SELECT UPJANG                                                                                                        	\n");
		sbSql.append("             , SUM(SIC_QTY) AS SIC_QTY                                                                                       	\n");
		sbSql.append("             , SUM(SIC_AMT) AS SIC_AMT                                                                                       	\n");
		sbSql.append("          FROM (                                                                                                          	\n");
        sbSql.append("                SELECT V.UPJANG_CD AS UPJANG                                                                                                                              \n");
	    sbSql.append("                     , NVL(DECODE(SALS_CLASS, '1103', TOT_PSN, '1108', TOT_PSN, '2001', TOT_PSN, '2101', TOT_PSN, '2102', TOT_PSN), 0) AS SIC_QTY                         \n");
	    sbSql.append("                     , DECODE(VAT_CLASS,'20',                                                                                                                             \n");
	    sbSql.append("                              ROUND(DECODE(SALS_CLASS, '1103', SAL_AMT, '1108', SAL_AMT, '2001', SAL_AMT, '2101', SAL_AMT, '2102', SAL_AMT, 0)/1.1),                      \n");
	    sbSql.append("                                    DECODE(SALS_CLASS, '1103', SAL_AMT, '1108', SAL_AMT, '2001', SAL_AMT, '2101', SAL_AMT, '2102', SAL_AMT, 0) ) AS SIC_AMT   /* 식음료 */   \n");
	    sbSql.append("                  FROM SLA_IF_UPJANG_SALS_DETAIL V                                                                                                                        \n");
	    sbSql.append("                     , SLA_IF_UPJANG_SALS_MST M                                                                                                                           \n");
	    sbSql.append("                 WHERE V.OCCUR_DATE = M.OCCUR_DATE                                                                                                                        \n");
	    sbSql.append("                   AND V.OCCUR_DATE LIKE '" + FROM + "%'                                                                                                                        \n");
	    sbSql.append("                   AND V.SYS_CLASS = M.SYS_CLASS                                                                                                                          \n");
	    sbSql.append("                   AND V.RECEIPT_NUM = M.RECEIPT_NUM                                                                                                                      \n");
	    sbSql.append("                   AND V.UPJANG_CD = M.UPJANG_CD		                                                                                                                    \n");
	    sbSql.append("                )		                                                                                                                    \n");
	    sbSql.append("          GROUP BY UPJANG		                                                                                                                    \n");
		sbSql.append("       ) V                                                                                                                 	\n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                 	\n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+)                                                                                              	\n");
		sbSql.append("   AND A.UPJANG = D.UPJANG(+)                                                                                              	\n");
		sbSql.append("   AND A.UPJANG = E.UPJANG(+)                                                                                              	\n");
		sbSql.append("   AND A.UPJANG = V.UPJANG(+)                                                                                              	\n");
		sbSql.append("   AND A.UPJANG = A1.UPJANG      				   	\n");
		sbSql.append("   AND A.UPJANG = A2.UPJANG      				   	\n");
		//식재영업 업장 제외한 FC업장 조회대상...(회계상 기준으로 조건 추가 한 것임)
 		sbSql.append("   AND NVL(A2.CUSTCD,0) = 0 \n");		
//		sbSql.append("   AND A.JOB_CD <> '006'  --식재영업 제외(사람이 직접  입력 한 식재영업)  \n");
		sbSql.append("   AND A2.DEPT_ID = A3.DEPT_ID  				   	\n");
		sbSql.append("   AND A3.MU_CD = '"+MU+"'          				   	\n");
		if(!TM.equals(""))
		{
		sbSql.append("   AND A.TM_CD = '"+TM+"'  --운영부서                                                                                         	\n");
		}
		if(!UPJANG.equals(""))
		{
		sbSql.append("   AND A.UPJANG = '"+UPJANG+"'  --업장                                                                                             	\n");
		}
		if(CHK_CLOSE.equals("Y"))
		{
		sbSql.append("   AND A.CLOSE_DATE IS NULL                                             						\n");
		}
//============================================================================================
//(2010-07-26 추가) 시작
// 박은규 2010-07-26 CSR#(37836) 요청자:이명희(메뉴개발팀)
// 계열사구분 조회조건 추가 및 내용추가
//============================================================================================
		if(!REL.equals(""))
		{
		sbSql.append("   AND A1.RELATED_YN = '"+REL+"'  --계열구분                                                                                         	\n");
		}
//============================================================================================
//(2010-07-26 추가) 끝
//============================================================================================
		sbSql.append(" ORDER BY A.TM_NAME                                                                                                        	\n");
		sbSql.append("     , A.JOB_NAME                                                                                                          	\n");
		sbSql.append("     , A.SUB_JOB_NAME                                                                                                      	\n");
		sbSql.append("     , A1.RELATED_YN                                                                                                      	\n");
		sbSql.append("     , A.UPJANGNM                                                                                                          	\n");
	
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
			if(stmt != null) {
				try {
					stmt.close();
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