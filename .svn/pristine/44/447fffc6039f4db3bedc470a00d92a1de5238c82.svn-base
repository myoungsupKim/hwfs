<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 재고조사
■ 프로그램ID   : FMW00400E_T002.jsp
■ 프로그램명   : 재고조사
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
		DataSet ds_Cond  	    = in_dl.get("ds_Cond");
		
		String v_Upjang         = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String v_TransDate      = nullToBlank(ds_Cond.getString(0, "TRANS_DATE"));
		String v_SubinvCode     = nullToBlank(ds_Cond.getString(0, "SUBINV_CODE"));
		String g_EmpNo          = nullToBlank(in_vl.getString("g_EmpNo"));
		String sTransQty        = "";
		String sDPhysicId       = "";
		String sIPhysicId       = "";
		String sTransNum        = "";
		String sCheckDate       = "";
	    //out 데이타
		StringBuffer sbSql = new StringBuffer();
	    
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT CLS_YM \n");
		sbSql.append( "  FROM FMW_CLOSING  \n");
		sbSql.append( " WHERE CLS_YM      >= SUBSTR('"+ v_TransDate +"',1,6) \n");
		sbSql.append( "   AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSql.append( "   AND CLS_FLAG    = 'Y' \n");
		sbSql.append( "   AND ROWNUM      <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());					
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			sCheckDate = rs.getString("CLS_YM");
			rs.close();
			pstmt.close();
			out_vl.add("sCheckDate", sCheckDate+"월 마감이 되어 작업이 불가합니다!.");
//this.setResultMessage(0, "OK",out_vl);
			proc_output(response,out,out_vl,out_dl);
			return;
		}
		else
		{
				rs.close();
				pstmt.close();		 
		}
	    
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT PHYSIC_ID						      \n");
		sbSql.append( "  FROM FMW_PHYSICAL_INV 					  \n");
		sbSql.append( " WHERE PHYSIC_DATE = '" + v_TransDate + "' \n");
		sbSql.append( "   AND SUBINV_CODE = '" + v_SubinvCode + "'\n");
out_vl.add("fa_Sql", sbSql.toString());					
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		if (rs.next())
		{
			sDPhysicId = rs.getString("PHYSIC_ID");			
			rs.close();
		    pstmt.close();
		    
			sbSql.delete(0, sbSql.length());
			sbSql.append( "DELETE FROM FMW_PHYSICAL_INV               \n");
			sbSql.append( " WHERE PHYSIC_DATE = '" + v_TransDate + "' \n");
			sbSql.append( "   AND SUBINV_CODE = '" + v_SubinvCode + "'\n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		
			sbSql.delete(0, sbSql.length());
			sbSql.append( "DELETE FROM FMW_PO_TRANSACTION        \n");
			sbSql.append( " WHERE SUBINV_CODE = '" + v_SubinvCode + "'\n");
			sbSql.append( "   AND TRANS_DATE = '" + v_TransDate + "'\n");
			sbSql.append( "   AND TRANS_TYPE LIKE 'P%' \n");
//			sbSql.append( " WHERE ORG_NUM = " + sDPhysicId + " \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}
		else
		{	
			rs.close();
			pstmt.close();
		}

		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT NVL(MAX(SUBSTR(TRANS_NUM,10,16)),0) +1 MAX_TRANS_NUM \n");
		sbSql.append("  FROM FMW_PO_TRANSACTION \n");
		sbSql.append(" WHERE TRANS_DATE = '"+ v_TransDate +"' \n");
		sbSql.append("   AND SUBINV_CODE = '"+ v_SubinvCode +"' \n");
out_vl.add("fa_Sql", sbSql.toString());		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		sTransNum = rs.getString("MAX_TRANS_NUM");
		rs.close();
		pstmt.close();

		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
        {
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT FMW_PHYSICAL_INV_S.NEXTVAL AS PHYSIC_ID   \n");
	        sbSql.append("  FROM DUAL                                      \n");        
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();
			sIPhysicId = rs.getString("PHYSIC_ID");	
			rs.close();
			pstmt.close();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("INSERT INTO FMW_PHYSICAL_INV      \n");
	        sbSql.append("     ( PHYSIC_ID                  \n");
	        sbSql.append("     , PHYSIC_DATE                \n");
	        sbSql.append("     , SUBINV_CODE                \n");
	        sbSql.append("     , ITEM_CODE                  \n");
	        sbSql.append("     , ONHAND_QTY                 \n");
	        sbSql.append("     , UNIT_PRICE                 \n");
	        sbSql.append("     , PHYSIC_QTY                 \n");
	        sbSql.append("     , CLOSE_DATE                 \n");
	        sbSql.append("     , USE_YN                     \n");
	        sbSql.append("     , CUSER                      \n");
	        sbSql.append("     , CDATE                      \n");
	        sbSql.append("     , UUSER                      \n");
	        sbSql.append("     , UDATE            		    \n");
	        sbSql.append("     ) VALUES                     \n");
	        sbSql.append("     ( " + sIPhysicId + " 																																																\n");
	        sbSql.append("     , '" + v_TransDate + "'                          																																									\n");
	        sbSql.append("     , '" + v_SubinvCode + "'                          																																									\n");
	        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "ITEM_CODE")) + "'     																																				\n");
	        sbSql.append("     , (" + nullToBlank(ds_List.getString(i, "BOX_QTY")) + ")*" + nullToBlank(ds_List.getString(i, "ITEM_SIZE_BONG")) + "+(" + nullToBlank(ds_List.getString(i, "BONG_QTY")) + ")  				\n");
	        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "UNIT_PRICE")) + "'    																																				\n");
	        sbSql.append("     , (" + nullToBlank(ds_List.getString(i, "PHYSIC_BOX_QTY")) + ")*" + nullToBlank(ds_List.getString(i, "ITEM_SIZE_BONG")) + "+(" + nullToBlank(ds_List.getString(i, "PHYSIC_BONG_QTY")) + ")   \n");
	        sbSql.append("     , SYSDATE                              																																										    	\n");
	        sbSql.append("     , 'Y'         																																						              									\n");
	        sbSql.append("     , '" + g_EmpNo + "'                          																																										\n");
	        sbSql.append("     , SYSDATE                   																																															\n");
	        sbSql.append("     , '" + g_EmpNo + "'                          																																										\n");
	        sbSql.append("     , SYSDATE                  																																															\n");
	        sbSql.append("     )                  																																																	\n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append( "SELECT FMW_UNIT_CHG_FUN('" + nullToBlank(ds_List.getString(i, "ITEM_CODE")) + "',2," + nullToBlank(ds_List.getString(i, "LOSS_BOX_QTY")) + "," + nullToBlank(ds_List.getString(i, "LOSS_BONG_QTY")) + ") AS TRANS_QTY \n");
			sbSql.append( "  FROM DUAL \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();
			sTransQty = rs.getString("TRANS_QTY");
			rs.close();
			pstmt.close();

			if ( !sTransQty.equals("0"))
			{ 
				sbSql.delete(0, sbSql.length());
		    	sbSql.append("INSERT INTO FMW_PO_TRANSACTION     \n");
		        sbSql.append("     ( TRANS_ID                    \n");
		        sbSql.append("     , TRANS_NUM                   \n");
		        sbSql.append("     , TRANS_TYPE                  \n");
		        sbSql.append("     , ORG_NUM                     \n");
		        sbSql.append("     , TRANS_DATE                  \n");
		        sbSql.append("     , SUBINV_CODE                 \n");
		        sbSql.append("     , ITEM_CODE                   \n");
		        sbSql.append("     , ITEM_NAME                   \n");
		        sbSql.append("     , TRANS_QTY                   \n");
		        sbSql.append("     , TRANS_PRICE                 \n");
		        sbSql.append("     , TRANS_AMOUNT                \n");
		        sbSql.append("     , AVG_PRICE                   \n");
		        sbSql.append("     , AVG_AMOUNT                  \n");
		        sbSql.append("     , PHYSIC_GUBUN                \n");
		        sbSql.append("     , USE_YN                      \n");
		        sbSql.append("     , CUSER                       \n");
		        sbSql.append("     , CDATE                       \n");
		        sbSql.append("     , UUSER                       \n");
		        sbSql.append("     , UDATE                       \n");
		        sbSql.append("     ) VALUES                      \n");
		        sbSql.append("     ( FMW_PO_TRANSACTION_S.NEXTVAL												           			\n");
		        sbSql.append("     , '"+ v_TransDate+'-'+sTransNum + "'                            									\n");
			    if(Float.parseFloat(sTransQty) < 0)
			    {		        
			        sbSql.append("     , 'P001'                            																\n");
			    }
			    else if(Float.parseFloat(sTransQty) > 0)
			    {
			    	sbSql.append("     , 'P002'                            																\n");		    	
			    }
			    sbSql.append("     , " + sIPhysicId + "                            													\n");
			    sbSql.append("     , '" + v_TransDate + "'                            												\n");
		        sbSql.append("     , '" + v_SubinvCode + "'       																	\n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "ITEM_CODE")) + "'	                            \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "ITEM_NAME")) + "'   	                        \n");
		        sbSql.append("     , " + sTransQty + "                           													\n");
		        sbSql.append("     , " + nullToBlank(ds_List.getString(i, "UNIT_PRICE")) + "                            	\n");
		        sbSql.append("     , " + sTransQty + "*" + nullToBlank(ds_List.getString(i, "UNIT_PRICE")) + "            	\n");
		        sbSql.append("     , " + nullToBlank(ds_List.getString(i, "UNIT_PRICE")) + "                            	\n");
		        sbSql.append("     , " + sTransQty + "*" + nullToBlank(ds_List.getString(i, "UNIT_PRICE")) + "            	\n");
		        sbSql.append("     , -1                          																	\n");
		        sbSql.append("     , 'Y'                         																	\n");
		        sbSql.append("     , '" + g_EmpNo + "'                            													\n");
		        sbSql.append("     , SYSDATE                     																	\n");
		        sbSql.append("     , '" + g_EmpNo + "'                           													\n");		        
		        sbSql.append("     , SYSDATE                     																	\n");
		        sbSql.append("     )                          																		\n");
out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
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