<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt           =  null;
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	PreparedStatement pstmt3 = null;
	PreparedStatement pstmt4 = null;
	PreparedStatement pstmt5 = null;
	PreparedStatement pstmt6 = null;
	PreparedStatement pstmt7 = null;
	PreparedStatement pstmt8 = null;
	PreparedStatement pstmt9 = null;
	PreparedStatement pstmt10 = null;
	PreparedStatement pstmt11 = null;
	PreparedStatement pstmt12 = null;
	
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		DataSet ds_input  	= in_dl.get("ds_PrItem");
		DataSet dsPoLineStatus  	= in_dl.get("dsPoLineStatus");
		DataSet dsPoType  	= in_dl.get("dsPoType");
		DataSet ds_potype  	= in_dl.get("ds_potype");
		DataSet ds_DelItem 	= in_dl.get("ds_DelItem");
		
		String p_NeedDate 		= in_vl.getString("p_NeedDate");
		String p_PrDate 		= in_vl.getString("p_PrDate");
		String g_Deptid 		= in_vl.getString("g_Deptid");
		String g_Upjang 		= in_vl.getString("g_Upjang");
		String g_EmpNo 			= in_vl.getString("g_EmpNo");
		String p_AprEmpNo		= in_vl.getString("p_AprEmpNo");
		String p_PoType 		= in_vl.getString("p_PoType");
		String p_Status 		= in_vl.getString("p_Status");
		String p_SubinvCode		= nullToBlank(in_vl.getString("p_SubinvCode"));
		String p_PrNum			= nullToBlank(in_vl.getString("p_PrNum"));
		String p_Type			= nullToBlank(in_vl.getString("p_Type"));
		String p_BudPrNum			= nullToBlank(in_vl.getString("p_BudPrNum"));
		
/* 		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		conn.setAutoCommit(false); */
		
		DataSet ds_budget;
		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();
		
		// 임시 구매신청번호 생성
		String strPrNum = p_BudPrNum;
		
		// 임시 구매승인번호 생성
		String strAprNum = p_BudPrNum;
		
		
		// 신청정보 저장
		sbInsSql.delete(0, sbInsSql.length());
		
		sbInsSql.append("INSERT INTO PO_PR \n");
		sbInsSql.append("( PR_ID               \n");
		sbInsSql.append(", PR_NUM              \n");
		sbInsSql.append(", PR_DATE             \n");
		sbInsSql.append(", PR_DEPT_ID          \n");
		sbInsSql.append(", PR_UPJANG           \n");
		sbInsSql.append(", PR_SABUN            \n");
		sbInsSql.append(", APPROVER            \n");
		sbInsSql.append(", APPROVE_TIME        \n");
		sbInsSql.append(", APPROVE_NUM         \n");
		sbInsSql.append(", PO_TYPE             \n");
		sbInsSql.append(", DOCU_SOURCE         \n");
		sbInsSql.append(", CUSTCD              \n");
		sbInsSql.append(", SUBINV_CODE         \n");
		sbInsSql.append(", RC_MU_CD            \n");
		sbInsSql.append(", RC_DEPT_ID          \n");
		sbInsSql.append(", RC_UPJANG           \n");
		sbInsSql.append(", CENTER_CODE         \n");
		sbInsSql.append(", ITEM_CODE           \n");
		sbInsSql.append(", ITEM_NAME           \n");
		sbInsSql.append(", ITEM_SIZE           \n");
		sbInsSql.append(", PO_UOM              \n");
		sbInsSql.append(", TAX_CODE            \n");
		sbInsSql.append(", BUDDEPT_ID          \n");
		sbInsSql.append(", ACCTCD              \n");
		sbInsSql.append(", BUD_CLS             \n");
		sbInsSql.append(", CENTER_FLAG         \n");
		sbInsSql.append(", UNIT_PRICE          \n");
		sbInsSql.append(", MARGIN_PRICE        \n");
		sbInsSql.append(", SALE_PRICE          \n");
		sbInsSql.append(", PR_QTY              \n");
		sbInsSql.append(", PO_QTY              \n");
		sbInsSql.append(", NEED_DATE           \n");
		sbInsSql.append(", INVAT_FLAG          \n");
		sbInsSql.append(", OUTVAT_FLAG         \n");
		sbInsSql.append(", MENU_QTY            \n");
		sbInsSql.append(", PR_REMARK           \n");
		sbInsSql.append(", LINE_STATUS         \n");
		sbInsSql.append(", CREATE_BY           \n");
		sbInsSql.append(", UPDATE_BY  \n");
		sbInsSql.append("  ) VALUES (  \n");
		//sbInsSql.append(" PO_PR_S.NEXTVAL \n");
		sbInsSql.append("  ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n"); 
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", 0 \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(")   \n");
		
		//logger.debug(sbInsSql.toString());
		String strPrInsert = sbInsSql.toString();
		pstmt8 = conn.prepareStatement(strPrInsert);
		
		int iPrCnt = 0;
		
		for(int i = 0; i < ds_input.getRowCount(); i++)
		{
			// PR_ID 생성 (식단에 PR_ID 저장을 위해 분리..속도가 느리거나 불필요하면 INSERT문에 포함 가능)
			sbSelSql.delete(0, sbSelSql.length());
			
			sbSelSql.append("SELECT TO_CHAR(PO_PR_S.NEXTVAL) PR_ID FROM DUAL \n");
	
			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sbSelSql.toString()); 			
			
			rs.next();
			
			String strPrID = rs.getString("PR_ID");	
			
			rs.close();
			stmt.close();
			
			pstmt8.setLong(1, Long.parseLong(strPrID));
			pstmt8.setString(2, strPrNum);
			pstmt8.setString(3, p_PrDate);
			pstmt8.setDouble(4,Double.parseDouble(g_Deptid));
			pstmt8.setDouble(5,Double.parseDouble(g_Upjang));
			pstmt8.setString(6, g_EmpNo);
			
			if( p_Status.equals(dsPoLineStatus.getString(0,"PRApprove"))){
				pstmt8.setString(7, p_AprEmpNo);
				pstmt8.setString(8, strAprNum);
			}
			else
			{
				pstmt8.setString(7, "");
				pstmt8.setString(8, "");				
			}
			pstmt8.setString(9, p_PoType);	
			pstmt8.setString(10, "01 BO");
			if(nullToBlank(ds_input.getString(i,"CUSTCD")).equals(""))
			{
				pstmt8.setString(11,null);
			}
			else
			{
				pstmt8.setString(11,ds_input.getString(i,"CUSTCD"));
				//pstmt8.setDouble(11,Double.parseDouble(ds_input.getString(i,"CUSTCD")));
			}
			pstmt8.setString(12, ds_input.getString(i,"SUBINV_CODE"));
			pstmt8.setString(13, ds_input.getString(i,"MU_CD"));
			pstmt8.setDouble(14,Double.parseDouble(ds_input.getString(i,"DEPT_ID")));
			pstmt8.setDouble(15,Double.parseDouble(ds_input.getString(i,"UPJANG")));
			pstmt8.setDouble(16,Double.parseDouble(ds_input.getString(i,"CENTER_CODE")));
			pstmt8.setString(17, ds_input.getString(i,"ITEM_CODE"));
			pstmt8.setString(18, ds_input.getString(i,"ITEM_NAME"));
			pstmt8.setString(19, nullToBlank(ds_input.getString(i,"ITEM_SIZE")));
			pstmt8.setString(20, nullToBlank(ds_input.getString(i,"PO_UOM")));
			pstmt8.setString(21, nullToBlank(ds_input.getString(i,"TAX_CODE")));
			pstmt8.setDouble(22, Double.parseDouble(ds_input.getString(i,"BUDDEPT_ID")));
			pstmt8.setString(23, nullToBlank(ds_input.getString(i,"ACCTCD")));
			
			if(nullToBlank(ds_input.getString(i,"BUD_CLS")).equals(""))
				pstmt8.setString(24, " ");	
			else
				pstmt8.setString(24, nullToBlank(ds_input.getString(i,"BUD_CLS")));
				
			pstmt8.setString(25, nullToBlank(ds_input.getString(i,"CENTER_FLAG")));
			pstmt8.setDouble(26, Double.parseDouble(ds_input.getString(i,"UNIT_PRICE")));
			pstmt8.setDouble(27, Double.parseDouble(ds_input.getString(i,"MARGIN_PRICE")));
			pstmt8.setDouble(28, Double.parseDouble(ds_input.getString(i,"PR_QTY")));
			pstmt8.setDouble(29, Double.parseDouble(ds_input.getString(i,"PR_QTY")));
			pstmt8.setString(30, nullToBlank(ds_input.getString(i,"NEED_DATE")));
			pstmt8.setString(31, nullToBlank(ds_input.getString(i,"INVAT_FLAG")));
			pstmt8.setString(32, nullToBlank(ds_input.getString(i,"OUTVAT_FLAG")));
			pstmt8.setDouble(33, Double.parseDouble(nullToZero(ds_input.getString(i,"KG_QTY"))));
			pstmt8.setString(34, nullToBlank(ds_input.getString(i,"REMARK")));
			pstmt8.setString(35, p_Status);
			pstmt8.setString(36, g_EmpNo);
			pstmt8.setString(37, g_EmpNo);
			
			pstmt8.addBatch();
			iPrCnt++;
		}
		
		if(iPrCnt > 0) pstmt8.executeBatch();
		
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT BDGT_YM, DEPT_NAME, ACCT_NAME, PROJECT_NAME, BUDCLS_NAME \n");
		sbSelSql.append("     , REMAINDER, OFFER_AMT, AMT, REMAINDER-OFFER_AMT-AMT BALANCE_AMT \n");
		sbSelSql.append("     , DECODE(ACCEPTABLE,'Y',DECODE(SIGN(REMAINDER-OFFER_AMT-AMT),-1,'신청가능(무통제)','신청가능'),'신청불가') PR_YN \n");
		sbSelSql.append("     , BUD_CLS, DEPT_ID, ACCTCD, BDGT_Y, BDGT_M \n");
		sbSelSql.append("FROM ( \n");		
		sbSelSql.append("SELECT D.BDGT_Y||'-'||D.BDGT_M AS BDGT_YM \n");
		sbSelSql.append("     , D.DEPT_NAME \n");
		sbSelSql.append("     , A.ACCTNM6 AS ACCT_NAME \n");
		sbSelSql.append("     , C.PROJECT_NM AS PROJECT_NAME \n");
		sbSelSql.append("     , B.BUDCLS_NM AS BUDCLS_NAME \n");
		sbSelSql.append("     , PL_BUDGET_REMAIND(D.BDGT_Y,D.BDGT_M,D.DEPT_ID,D.ACCTCD,D.PROJECT_ID,D.BUD_CLS) AS REMAINDER \n");
		sbSelSql.append("     , D.OFFER_AMT \n");
		sbSelSql.append("     , D.AMT, 0 \n");
		sbSelSql.append("     , D.BDGT_Y,D.BDGT_M,D.DEPT_ID,D.ACCTCD,D.PROJECT_ID,D.BUD_CLS \n");
		sbSelSql.append("     , PL_BUDGET_USEACCEPT(D.BDGT_Y,D.BDGT_M,D.DEPT_ID,D.ACCTCD,D.PROJECT_ID,D.BUD_CLS,(D.AMT + D.OFFER_AMT)) AS ACCEPTABLE \n");
		sbSelSql.append("  FROM ST_ACCOUNT A, PL_BUDCLS B, PL_PROJECT C \n");
		sbSelSql.append("     ,(SELECT A.BDGT_Y, A.BDGT_M, A.DEPT_ID, A.ACCTCD, A.PROJECT_ID, A.BUD_CLS, A.DEPT_NAME, A.AMT, NVL(B.OFFER_AMT,0) OFFER_AMT \n");
		sbSelSql.append("         FROM \n");
		sbSelSql.append("             (SELECT SUBSTR(A.NEED_DATE,1,4) AS BDGT_Y \n");
		sbSelSql.append("                   , SUBSTR(A.NEED_DATE,5,2) AS BDGT_M \n");
		sbSelSql.append("                   , A.BUDDEPT_ID            AS DEPT_ID \n");
		sbSelSql.append("                   , A.ACCTCD \n");
		sbSelSql.append("                   , NVL(B.PJT_CD,' ')     AS PROJECT_ID \n");
		sbSelSql.append("                   , A.BUD_CLS \n");
		sbSelSql.append("                   , B.TM_NM||' '||B.CC_NM AS DEPT_NAME \n");
		sbSelSql.append("                   , ROUND(SUM(A.MARGIN_PRICE * A.PR_QTY)) AS AMT \n");
		sbSelSql.append("                FROM PO_PR A, SC_DEPT_V B \n");
		sbSelSql.append("               WHERE B.DEPT_ID = A.BUDDEPT_ID \n");
		sbSelSql.append("                 AND A.PR_NUM  = '" + strPrNum + "' \n");
		sbSelSql.append("               GROUP BY SUBSTR(A.NEED_DATE,1,4), SUBSTR(A.NEED_DATE,5,2), A.BUDDEPT_ID, A.ACCTCD, NVL(B.PJT_CD,' '), A.BUD_CLS, B.TM_NM||' '||B.CC_NM) A \n");
		sbSelSql.append("            ,(SELECT SUBSTR(A.NEED_DATE,1,4) AS BDGT_Y \n");
		sbSelSql.append("                   , SUBSTR(A.NEED_DATE,5,2) AS BDGT_M \n");
		sbSelSql.append("                   , A.BUDDEPT_ID            AS DEPT_ID \n");
		sbSelSql.append("                   , A.ACCTCD \n");
		sbSelSql.append("                   , NVL(B.PJT_CD,' ')     AS PROJECT_ID \n");
		sbSelSql.append("                   , A.BUD_CLS \n");
		sbSelSql.append("                   , B.TM_NM||' '||B.CC_NM AS DEPT_NAME \n");
		sbSelSql.append("                   , ROUND(SUM(A.MARGIN_PRICE * A.PR_QTY)) AS OFFER_AMT \n");
		sbSelSql.append("                FROM SC_DEPT_V B \n");
		sbSelSql.append("                   ,(SELECT /*+ INDEX(A PO_PR_I4) */ * FROM PO_PR A \n");
		sbSelSql.append("                      WHERE A.PR_NUM <> '" + strPrNum + "' \n");
		sbSelSql.append("                        AND A.LINE_STATUS = '" + dsPoLineStatus.getString(0,"PRApprove") + "') A \n");
		sbSelSql.append("                   ,(SELECT BUDDEPT_ID, ACCTCD, BUD_CLS FROM PO_PR WHERE PR_NUM = '" + strPrNum + "' GROUP BY BUDDEPT_ID, ACCTCD, BUD_CLS) C \n");
		sbSelSql.append("               WHERE B.DEPT_ID    = A.BUDDEPT_ID \n");
		sbSelSql.append("                 AND A.BUDDEPT_ID = C.BUDDEPT_ID \n");
		sbSelSql.append("                 AND A.ACCTCD     = C.ACCTCD \n");
		sbSelSql.append("                 AND NVL(A.BUD_CLS,' ') = NVL(C.BUD_CLS,' ') \n");
		sbSelSql.append("               GROUP BY SUBSTR(A.NEED_DATE,1,4), SUBSTR(A.NEED_DATE,5,2), A.BUDDEPT_ID, A.ACCTCD, NVL(B.PJT_CD,' '), A.BUD_CLS, B.TM_NM||' '||B.CC_NM) B \n");
		sbSelSql.append("        WHERE A.BDGT_Y  = B.BDGT_Y(+) \n");
		sbSelSql.append("          AND A.BDGT_M  = B.BDGT_M(+) \n");
		sbSelSql.append("          AND A.DEPT_ID = B.DEPT_ID(+) \n");
		sbSelSql.append("          AND A.PROJECT_ID = B.PROJECT_ID(+) \n");
		sbSelSql.append("          AND A.ACCTCD  = B.ACCTCD(+) \n");
		sbSelSql.append("          AND A.BUD_CLS = B.BUD_CLS(+) \n");
		sbSelSql.append("       ) D \n");
		sbSelSql.append(" WHERE A.ACCTCD       = D.ACCTCD \n");
		sbSelSql.append("   AND B.ACCTCD(+)    = D.ACCTCD \n");
		sbSelSql.append("   AND B.BUD_CLS(+)   = D.BUD_CLS \n");
		sbSelSql.append("   AND C.PROJECT_ID(+)= D.PROJECT_ID \n");
		sbSelSql.append("   AND C.CONST_YN(+)  = '1' \n");
		sbSelSql.append("  ) \n");
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString()); 			
		
		ds_budget = this.makeDataSet(rs,"ds_budget");
		
	   	out_dl.add(ds_budget);
		
		rs.close();
		stmt.close();	
		
		if(ds_budget.getRowCount() > 0)
		{
			conn.rollback();
	   		this.setResultMessage(0, "OK",out_vl);	
	   		proc_output(response,out,out_vl,out_dl);
	   		return;
		}
		
		conn.rollback();
		
	   	this.setResultMessage(0, "OK",out_vl);
	   	
	} catch(Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);	
	    this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception e) {}
			}
			if(pstmt1 != null) {
				try {
					pstmt1.close();
				}catch(Exception e) {}
			}
			if(pstmt2 != null) {
				try {
					pstmt2.close();
				}catch(Exception e) {}
			}
			if(pstmt3 != null) {
				try {
					pstmt3.close();
				}catch(Exception e) {}
			}
			if(pstmt4 != null) {
				try {
					pstmt4.close();
				}catch(Exception e) {}
			}
			if(pstmt5 != null) {
				try {
					pstmt5.close();
				}catch(Exception e) {}
			}
			if(pstmt6 != null) {
				try {
					pstmt6.close();
				}catch(Exception e) {}
			}
			if(pstmt7 != null) {
				try {
					pstmt7.close();
				}catch(Exception e) {}
			}
			if(pstmt8 != null) {
				try {
					pstmt8.close();
				}catch(Exception e) {}
			}
			if(pstmt9 != null) {
				try {
					pstmt9.close();
				}catch(Exception e) {}
			}
			if(pstmt10 != null) {
				try {
					pstmt10.close();
				}catch(Exception e) {}
			}
			if(pstmt11 != null) {
				try {
					pstmt11.close();
				}catch(Exception e) {}
			}
			if(pstmt12 != null) {
				try {
					pstmt12.close();
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
			//jsp log 서비스 닫기 
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}			
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%>	