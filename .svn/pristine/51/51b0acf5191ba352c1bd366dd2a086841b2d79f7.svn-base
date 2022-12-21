<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 실적관리
■ 프로그램ID   : FSV00460E_T001.jsp
■ 프로그램명   : B&B매출조회(조회)
■ 작성일자     : 2013-08-07
■ 작성자       : 박용대
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		String v_TrDateF    = nullToBlank(ds_Cond.getString(0, "TRANS_DATE_F"));
		String v_TrDateT    = nullToBlank(ds_Cond.getString(0, "TRANS_DATE_T"));
		
		//IRIS DB연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();
		stmt =  conn.createStatement();
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 확정단가조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("\n\n");
		
		/*
        sbSql.append(" SELECT             POS_NO                                                \n");
        sbSql.append("                  , LOC_NAME                                              \n");
        sbSql.append("                  , SALE_DATE                                             \n");
        sbSql.append("                  , BAR_CD                                                \n");
        sbSql.append("                  , LOC_CD                                                \n");
        sbSql.append("                  , ITEM_NAME_SHRT                                        \n");
        sbSql.append("                  , QTY                                                   \n");
        sbSql.append("                  , UNIT_PRIC                                             \n");
        sbSql.append("                  , SALE_AMT                                              \n");
        sbSql.append("  FROM (                                                                  \n");
        sbSql.append("         SELECT  A.POS_NO                                               POS_NO \n");
        sbSql.append("                , '설악쏘라노' || (SELECT LOC_NAME                        \n");
        sbSql.append("                     FROM SC_LOC_MAST                                     \n");
        sbSql.append("                    WHERE BRCH_CD = A.BRCH_CD                             \n");
        sbSql.append("                      AND LOC_CD = A.LOC_CD  )                           LOC_NAME \n");
        sbSql.append("                , A.SALE_DATE                                            SALE_DATE \n");
        sbSql.append("                , A.ITEM_CD                                              BAR_CD \n");
        sbSql.append("                , A.LOC_CD                                               LOC_CD \n");
        sbSql.append("                , B.ITEM_NAME_SHRT                                       ITEM_NAME_SHRT \n");
        sbSql.append("                , SUM(DECODE(A.TRAN_DIV,'N',1,-1) * SALE_QTY)            QTY \n");
        sbSql.append("                , A.UNIT_PRIC                                            UNIT_PRIC \n");
        sbSql.append("                , SUM(DECODE(A.TRAN_DIV,'N',1,-1) * A.TOT_SALE_AMT)      SALE_AMT \n");
        sbSql.append("            FROM  UPOS_BD_POSJ_TRAN_ITEM A                                \n");
        sbSql.append("                , UPOS_BD_MST_LOC_ITEM B                                  \n");
        sbSql.append("           WHERE  A.SALE_DATE  BETWEEN '"+v_TrDateF+"' AND '"+v_TrDateT+"'          \n");
        sbSql.append("             AND A.BAR_CD = B.BAR_CD                                      \n");
        sbSql.append("             AND A.BRCH_CD = '0100'                                       \n");
        sbSql.append("             AND B.LOC_CD ='0109'  --                                     \n");
        sbSql.append("             AND A.BRCH_CD = B.BRCH_CD                                    \n");
      //  sbSql.append("             AND B.CRNR_CD = '001' --빈즈앤배리즈 CORNER                  \n");
        sbSql.append("             AND B.CMIS_YN = '02'                                         \n");
        sbSql.append("             AND A.POS_SALE_DIV ='T'                                      \n");
        sbSql.append("            GROUP BY A.BRCH_CD                                            \n");
        sbSql.append("                   , A.SALE_DATE                                          \n");
        sbSql.append("                   , A.POS_NO                                             \n");
        sbSql.append("                   , A.LOC_CD                                             \n");
        sbSql.append("                   , A.ITEM_CD                                            \n");
        sbSql.append("                   , DECODE(A.TRAN_DIV,'N','10','R','30','')              \n");
        sbSql.append("                   , A.UNIT_PRIC                                          \n");
        sbSql.append("                   , B.ITEM_NAME_SHRT                                     \n");
        sbSql.append("           UNION ALL                                                      \n");
        sbSql.append("           SELECT   POS_NO                                  POS_NO        \n");
        sbSql.append("                  , LOC_NAME                                LOC_NAME      \n");
        sbSql.append("                  , SALE_DATE                               SALE_DATE     \n");
        sbSql.append("                  , BAR_CD                                  BAR_CD        \n");
        sbSql.append("                  , LOC_CD                                  LOC_CD        \n");
        sbSql.append("                  , ITEM_NAME_SHRT                          ITEM_NAME_SHRT \n");
        sbSql.append("                  , SALE_QTY                                QTY           \n");
        sbSql.append("                  , UNIT_PRIC                               UNIT_PRICE    \n");
        sbSql.append("                  , TOT_SALE_AMT                            SALE_AMT      \n");
        sbSql.append("              FROM UPOS_BD_POSJ_BNB_ITEM                                  \n");
        sbSql.append("              WHERE SALE_DATE BETWEEN '"+v_TrDateF+"'                          \n");
        sbSql.append("                                  AND '"+v_TrDateT+"'                          \n");
        sbSql.append("             )                                                            \n");
        */
        
        //2014-09-03
        sbSql.append("SELECT             POS_NO                                                 \n");
        sbSql.append("                  , LOC_NAME                                              \n");
        sbSql.append("                  , SALE_DATE                                             \n");
        sbSql.append("                  , BAR_CD                                                \n");
        sbSql.append("                  , LOC_CD                                                \n");
        sbSql.append("                  , ITEM_NAME_SHRT                                        \n");
        sbSql.append("                  , QTY                                                   \n");
        sbSql.append("                  , UNIT_PRIC                                             \n");
        sbSql.append("                  , SALE_AMT                                              \n");
        sbSql.append("  FROM (                                                                  \n");
        sbSql.append("         SELECT  A.POS_NO                                               POS_NO \n");
        sbSql.append("                , '설악쏘라노' || (SELECT LOC_NAME                        \n");
        sbSql.append("                     FROM SC_LOC_MAST                                     \n");
        sbSql.append("                    WHERE BRCH_CD = A.BRCH_CD                             \n");
        sbSql.append("                      AND LOC_CD = A.LOC_CD  )                           LOC_NAME \n");
        sbSql.append("                , A.SALE_DATE                                            SALE_DATE \n");
        sbSql.append("                , A.ITEM_CD                                              BAR_CD \n");
        sbSql.append("                , A.LOC_CD                                               LOC_CD \n");
        sbSql.append("                , A.ITEM_NAME_SHRT                                       ITEM_NAME_SHRT \n");
        sbSql.append("                , SUM(DECODE(A.TRAN_DIV,'N',1,-1) * SALE_QTY)            QTY \n");
        sbSql.append("                , A.UNIT_PRIC                                            UNIT_PRIC \n");
        sbSql.append("                , SUM(DECODE(A.TRAN_DIV,'N',1,-1) * A.STOT_SALE_AMT)      SALE_AMT \n");
        sbSql.append("            FROM  UPOS_BD_POSJ_TRAN_ITEM A                                \n");
        sbSql.append("           WHERE  A.SALE_DATE  BETWEEN '"+v_TrDateF+"' AND '"+v_TrDateT+"'          \n");
        sbSql.append("             AND A.BRCH_CD = '0100'                                       \n");
        sbSql.append("             AND A.LOC_CD ='0109'  --                                     \n");
        sbSql.append("             and A.SALE_QTY <> 0                                          \n");
        sbSql.append("            GROUP BY A.BRCH_CD                                            \n");
        sbSql.append("                   , A.SALE_DATE                                          \n");
        sbSql.append("                   , A.POS_NO                                             \n");
        sbSql.append("                   , A.LOC_CD                                             \n");
        sbSql.append("                   , A.ITEM_CD                                            \n");
        sbSql.append("                   , A.UNIT_PRIC                                          \n");
        sbSql.append("                   , A.ITEM_NAME_SHRT                                     \n");
        sbSql.append("           UNION ALL                                                      \n");
        sbSql.append("           SELECT   POS_NO                                  POS_NO        \n");
        sbSql.append("                  , LOC_NAME                                LOC_NAME      \n");
        sbSql.append("                  , SALE_DATE                               SALE_DATE     \n");
        sbSql.append("                  , BAR_CD                                  BAR_CD        \n");
        sbSql.append("                  , LOC_CD                                  LOC_CD        \n");
        sbSql.append("                  , ITEM_NAME_SHRT                          ITEM_NAME_SHRT \n");
        sbSql.append("                  , SALE_QTY                                QTY           \n");
        sbSql.append("                  , UNIT_PRIC                               UNIT_PRICE    \n");
        sbSql.append("                  , TOT_SALE_AMT                            SALE_AMT      \n");
        sbSql.append("              FROM UPOS_BD_POSJ_BNB_ITEM                                  \n");
        sbSql.append("              WHERE SALE_DATE BETWEEN '"+v_TrDateF+"'                          \n");
        sbSql.append("                                  AND '"+v_TrDateT+"'                          \n");
        sbSql.append("             )                                                            \n");
        sbSql.append("\n\n");
        
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");                                                                                                                                                          
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_list);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);  
		
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