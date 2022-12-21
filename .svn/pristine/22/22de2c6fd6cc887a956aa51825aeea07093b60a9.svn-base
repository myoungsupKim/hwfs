<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FMW00401P_T001.jsp
■ 프로그램명   : 재고조사상품 추가
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
		//In 데이타
		DataSet ds_Cond  	    = in_dl.get("ds_Cond");
		
		String v_Upjang         = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String v_TransDate      = nullToBlank(ds_Cond.getString(0, "TRANS_DATE"));
		String v_SubinvCode     = nullToBlank(ds_Cond.getString(0, "SUBINV_CODE"));
		String v_ItemName 	    = nullToBlank(ds_Cond.getString(0,"ITEM_NAME"));
		String sPhysicDate      = "";
	
	    //out 데이타
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT A.PHYSIC_DATE						        \n");
		sbSql.append( "  FROM FMW_PHYSICAL_INV A                       \n");
		sbSql.append( " WHERE A.SUBINV_CODE = '" + v_SubinvCode + "'   \n");
		sbSql.append( "   AND A.PHYSIC_DATE > '" + v_TransDate + "' \n");
		sbSql.append( "   AND ROWNUM        <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());					
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			sPhysicDate = rs.getString("PHYSIC_DATE");
		}
		else
		{
			sPhysicDate = "00010101";
		}
		rs.close();
		pstmt.close();

	    //System.out.println("sOnhandMonth:" + sOnhandMonth);
	    sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.ITEM_CODE                                                                 \n");
        sbSql.append("     , A.ITEM_NAME                                                                 \n");
        sbSql.append("     , A.ITEM_SIZE_BONG                                                            \n");
        sbSql.append("     , NVL(A.UNIT_PRICE_BONG, 0) AS UNIT_PRICE                                          \n");
        sbSql.append("     , " + v_TransDate + " AS PHYSIC_DATE                                                             \n");
        sbSql.append("     , " + sPhysicDate + " AS MAX_PHYSIC_DATE                                                         \n");
        sbSql.append("  FROM FMW_ITEM_V A                                                                \n");
        sbSql.append(" WHERE (A.UPJANG = " + v_Upjang + "                                                                \n");
        sbSql.append("        OR A.UPJANG = 0000)                                                        \n");
        sbSql.append("   AND (A.ITEM_CODE LIKE '%"+ v_ItemName +"%'                                                      \n");
        sbSql.append("        OR A.ITEM_NAME LIKE '%"+ v_ItemName +"%')                                                  \n");
        sbSql.append(" ORDER BY A.ITEM_CODE								                                                  \n");
out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);
		//FileLog.println("c:\\ds_stock.txt",ds_stock);			
	   	this.setResultMessage(0, "OK",out_vl);
	   	
	} catch(Exception ex) {
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
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception e) {}
			}
//			if(stmt != null) {
//				try {
//					stmt.close();
//				}catch(Exception e) {}
//			}
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