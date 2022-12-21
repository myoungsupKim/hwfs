<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 월마감
■ 프로그램ID   : FMW00600E_T002.jsp
■ 프로그램명   : 월마감
■ 작성일자     : 2011.01.20
■ 작성자       : 문형광
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt              =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));	
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		//In 데이타
		DataSet ds_List  	    = in_dl.get("ds_List");
		
		if (ds_List.getRowCount() == 0)
		{
			return;
		}	
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			String v_SubinvCode     = nullToBlank(ds_List.getString(i, "SUBINV_CODE"));
			String v_Date           = nullToBlank(ds_List.getString(i, "CLS_YM"));
			String v_Flag           = nullToBlank(ds_List.getString(i, "CLS_FLAG"));
			String g_EmpNo          = nullToBlank(in_vl.getString("g_EmpNo"));		
			String sPhysicDate      = "";
			String sOnhandMonth     = "000101";
			String sClsYm         = "";
			String sClsYmRe         = "";
				
		    //out 데이타		
			StringBuffer sbSql = new StringBuffer();
		    
		    if (v_Flag.equals("Y"))
		    {
		    	return;	
		    }
		    else		
		    {
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT PHYSIC_DATE                                         \n");
		        sbSql.append("  FROM FMW_PHYSICAL_INV                                    \n");
		        sbSql.append(" WHERE SUBINV_CODE = '" + v_SubinvCode + "'                \n");
		        sbSql.append("   AND PHYSIC_DATE > TO_CHAR(LAST_DAY(TO_DATE('" + v_Date + "'||'01', 'YYYYMMDD')), 'YYYYMMDD') \n");
		        sbSql.append("   AND ROWNUM <= 1                                         \n");
out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					sPhysicDate = rs.getString("PHYSIC_DATE");
					rs.close();
					pstmt.close();
					out_vl.add("sPhysicDate", sPhysicDate+ "일자 재고조사를 취소하셔야 처리가 가능합니다!.");
					return;
				}
				else
				{
					rs.close();
				    pstmt.close();
				}
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT CLS_YM         						\n");
		        sbSql.append("  FROM FMW_CLOSING    					  	\n");
		        sbSql.append(" WHERE SUBINV_CODE = '" + v_SubinvCode + "' 	\n");
		        sbSql.append("   AND CLS_YM >= '" + v_Date + "'      	\n");
		        sbSql.append("   AND CLS_FLAG = 'Y' 						\n");
		        sbSql.append("   AND ROWNUM <= 1    						\n");
out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();		
				if (rs.next())
				{
					sPhysicDate = rs.getString("CLS_YM");
					rs.close();
					pstmt.close();
					out_vl.add("sPhysicDate", sPhysicDate+ "월 마감을 취소하셔야 처리가 가능합니다!.");
					return;
				}
				else
				{
					rs.close();
				    pstmt.close();
				}
		
				sbSql.delete(0, sbSql.length());
				sbSql.append( "SELECT A.CLS_YM \n");
				sbSql.append( "  FROM FMW_CLOSING A \n");
				sbSql.append( " WHERE A.CLS_YM      < '" + v_Date + "'  \n");
				sbSql.append( "   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
				sbSql.append( "   AND A.CLS_FLAG    = 'Y' \n");
				sbSql.append( "   AND ROWNUM        <= 1 \n");
		out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				if(rs.next())
				{
					sOnhandMonth = rs.getString("CLS_YM");
				}
				else
				{
					sOnhandMonth = "000101";
				}		
				rs.close();
				pstmt.close();
		//System.out.println("sOnhandMonth:" + sOnhandMonth);
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FMW_ONHAND_MONTH_SUB   \n");
		        sbSql.append("     ( ONHAND_YM                   \n");
		        sbSql.append("     , SUBINV_CODE                 \n");
		        sbSql.append("     , ITEM_CODE                   \n");
		        sbSql.append("     , UNIT_PRICE                  \n");
		        sbSql.append("     , ONHAND_QTY                  \n");
		        sbSql.append("     , UNIT_AMOUNT                 \n");
		        sbSql.append("     )                             \n");
				sbSql.append("SELECT '" + v_Date + "' AS ONHAND_YM \n");	
				sbSql.append("     , '" + v_SubinvCode + "' AS SUBINV_CODE \n");
				sbSql.append("     , A.ITEM_CODE \n");
				sbSql.append("     , ROUND(DECODE(SUM(B.UNIT_QTY),0,0,SUM(UNIT_AMOUNT) / SUM(B.UNIT_QTY))) AS UNIT_PRICE \n");
				sbSql.append("     , SUM(B.TRANS_QTY) AS ONHAND_QTY \n");
				sbSql.append("     , ROUND(DECODE(SUM(B.UNIT_QTY),0,0,SUM(UNIT_AMOUNT) / SUM(B.UNIT_QTY)) * SUM(B.TRANS_QTY)) AS UNIT_AMOUNT \n");
				sbSql.append("  FROM FMW_ITEM_V A, FMS_SUBINVENTORY F \n");
				sbSql.append("     ,( \n");
				sbSql.append("       SELECT D.SUBINV_CODE \n");
				sbSql.append("            , D.ITEM_CODE \n");
				sbSql.append("            , 0 AS TRANS_QTY \n");
				sbSql.append("            , SUM(ABS(D.TRANS_AMOUNT))AS UNIT_AMOUNT \n");
				sbSql.append("            , SUM(ABS(D.TRANS_QTY)) AS UNIT_QTY \n");
				sbSql.append("         FROM FMW_PO_TRANSACTION D \n");
				sbSql.append("        WHERE D.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND TO_CHAR(LAST_DAY(TO_DATE('" + v_Date + "'||'01', 'YYYYMMDD')), 'YYYYMMDD') \n");
				sbSql.append("          AND D.SUBINV_CODE = '" + v_SubinvCode + "' \n");
				sbSql.append("          AND D.TRANS_TYPE LIKE 'I%' \n");
				sbSql.append("        GROUP BY D.SUBINV_CODE, D.ITEM_CODE \n");
				sbSql.append("      UNION ALL \n");
				sbSql.append("       SELECT E.SUBINV_CODE \n");
				sbSql.append("            , E.ITEM_CODE \n");
				sbSql.append("            , SUM(E.TRANS_QTY * E.PHYSIC_GUBUN) AS TRANS_QTY \n");
				sbSql.append("            , 0 AS UNIT_AMOUNT \n");
				sbSql.append("            , 0 AS UNIT_QTY \n");
				sbSql.append("         FROM FMW_PO_TRANSACTION E \n");
				sbSql.append("        WHERE E.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND TO_CHAR(LAST_DAY(TO_DATE('" + v_Date + "'||'01', 'YYYYMMDD')), 'YYYYMMDD') \n");
				sbSql.append("          AND E.SUBINV_CODE = '" + v_SubinvCode + "' \n");
				sbSql.append("        GROUP BY E.SUBINV_CODE, E.ITEM_CODE \n");
				sbSql.append("      ) B \n");
				sbSql.append(" WHERE B.SUBINV_CODE = F.SUBINV_CODE \n");
				sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE                                             \n");
				sbSql.append(" GROUP BY A.ITEM_CODE                         							   \n");
		out_vl.add("fa_Sql", sbSql.toString());	
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
				
				sbSql.delete(0, sbSql.length());
		        sbSql.append("  UPDATE FMW_PO_TRANSACTION A                                                                    													\n");
		        sbSql.append("     SET (A.AVG_PRICE, A.AVG_AMOUNT)                                                           													\n");
		        sbSql.append("       = (SELECT B.UNIT_PRICE                                                                  													\n");
		        sbSql.append("               , ROUND(B.UNIT_PRICE * A.TRANS_QTY)                                             													\n");
		        sbSql.append("            FROM FMW_ONHAND_MONTH_SUB B                                                       	 												\n");
		        sbSql.append("           WHERE B.SUBINV_CODE = A.SUBINV_CODE                                                 													\n");
		        sbSql.append("             AND B.ITEM_CODE   = A.ITEM_CODE                                                   													\n");
		        sbSql.append("             AND B.ONHAND_YM = '" + v_Date + "'                                                                 									\n");
		        sbSql.append("             AND B.SUBINV_CODE = '" + v_SubinvCode + "'                                                             								\n");
		        sbSql.append("         )                                                                                     													\n");
		        sbSql.append("       , A.UDATE = SYSDATE                                                               													\n");
		        sbSql.append("       , A.UUSER   = '" + g_EmpNo + "'                                                                      									\n");
		        sbSql.append("   WHERE A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND TO_CHAR(LAST_DAY(TO_DATE('" + v_Date + "'||'01', 'YYYYMMDD')), 'YYYYMMDD') 	\n");
		        sbSql.append("     AND A.SUBINV_CODE = '" + v_SubinvCode + "'                                                                      								\n");
		        sbSql.append("     AND A.TRANS_TYPE BETWEEN 'O001' AND 'P002'                                                													\n");
		out_vl.add("fa_Sql", sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();	
				
				sbSql.delete(0, sbSql.length());
				sbSql.append( "SELECT /*+ INDEX_DESC(A FMW_CLOSING_PK) */               \n");
				sbSql.append( "       A.CLS_YM							                \n");
				sbSql.append( "  FROM FMW_CLOSING A 									\n");
				sbSql.append( " WHERE A.SUBINV_CODE = '" + v_SubinvCode + "' 			\n");
				sbSql.append( "   AND A.CLS_FLAG    = 'Y' 								\n");
				sbSql.append( "   AND ROWNUM        = 1 								\n");
		out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				if(rs.next())
				{
					sClsYm = rs.getString("CLS_YM");
				}
				else
				{
					sClsYm = "201012";
				}		
				rs.close();
				pstmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT MONTHS_BETWEEN(TO_DATE('"+v_Date+"', 'YYYYMM'), TO_DATE('"+sClsYm+"', 'YYYYMM')) AS CLS_YM \n");
		        sbSql.append("  FROM DUAL    					  	\n");
		out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				
				if (rs.next())
				{
					sClsYmRe = rs.getString("CLS_YM");
					rs.close();
					pstmt.close();
				}
				else
				{
					sClsYmRe = "1";
					rs.close();
				    pstmt.close();
				}
//System.out.println(Integer.parseInt(sClsYmRe));		
				for ( int j = 1 ; j < Integer.parseInt(sClsYmRe) + 1 ; j++ )
				{
					sbSql.delete(0, sbSql.length());
					sbSql.append("INSERT INTO FMW_CLOSING    	     			\n");
			        sbSql.append("     ( CLS_YM  	                 			\n");
			        sbSql.append("     , SUBINV_CODE                 			\n");
			        sbSql.append("     , CLS_FLAG                   			\n");
			        sbSql.append("     , CLS_SABUN                  			\n");
			        sbSql.append("     , CLS_TIME                    			\n");
			        sbSql.append("     , CUSER                       										\n");
			        sbSql.append("     , CDATE                       										\n");
			        sbSql.append("     , UUSER                       										\n");
			        sbSql.append("     , UDATE                       										\n");
			        sbSql.append("     ) VALUES                       										\n");
			        sbSql.append("     ( TO_CHAR(ADD_MONTHS(TO_DATE('" + sClsYm + "'||'01', 'YYYYMMDD')," + j + "),'YYYYMM') \n");
			        sbSql.append("     , '" + v_SubinvCode + "' 							\n");
			        sbSql.append("     , 'Y'		 							\n");
			        sbSql.append("     , '" + g_EmpNo + "' 						\n");
			        sbSql.append("     , SYSDATE 							    \n");
			        sbSql.append("     , '" + g_EmpNo + "' 							\n");
			        sbSql.append("     , SYSDATE    							\n");
			        sbSql.append("     , '" + g_EmpNo + "'   									\n");
			        sbSql.append("     , SYSDATE )    							\n");
		out_vl.add("fa_Sql", sbSql.toString());	
				    pstmt = conn.prepareStatement(sbSql.toString());
					pstmt.executeUpdate();
					pstmt.close();       
				}
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("DELETE FROM FMW_ONHAND_MONTH_SUB	     		\n");
		        sbSql.append(" WHERE ONHAND_YM = '" + v_Date + "' 		\n");
		        sbSql.append("   AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
		out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
				//conn.commit();
		    }
		}		
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
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