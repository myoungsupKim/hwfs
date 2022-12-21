<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 타사매입처 입출고 확정 및 처리(타사매입)
■ 프로그램ID   : FMW00220E_T002.jsp
■ 프로그램명   : 타사매입처 입출고 확정 및 처리(타사매입)
■ 작성일자     : 2011.01.06
■ 작성자       : 문형광
■ 이력관리     : 2011.01.06
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		DataSet ds_List     = in_dl.get("ds_List");
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//입력 파라메터
		String sTRANS_NUM   = "";
		String sTRANS_QTY   = "";
		String sCheckDate      = "";
	
		//FileLog.println("d:\\aaa.txt", ds_List);
		//변수선언
		int sRowStatus;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT CLS_YM \n");
		sbSql.append( "  FROM FMW_CLOSING  \n");
		sbSql.append( " WHERE CLS_YM      >= SUBSTR('"+ nullToBlank(ds_Cond.getString(0, "TRANS_DATE")) +"',1,6) \n");
		sbSql.append( "   AND SUBINV_CODE = '"+ nullToBlank(ds_Cond.getString(0, "SUBINV_CODE")) +"' \n");
		sbSql.append( "   AND CLS_FLAG    = 'Y' \n");
		sbSql.append( "   AND ROWNUM        <= 1 \n");
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
		sbSql.append( "SELECT PHYSIC_DATE						        \n");
		sbSql.append( "  FROM FMW_PHYSICAL_INV                        \n");
		sbSql.append( " WHERE SUBINV_CODE = '" + nullToBlank(ds_Cond.getString(0, "SUBINV_CODE")) + "'   \n");
		sbSql.append( "   AND PHYSIC_DATE >= '"+ nullToBlank(ds_Cond.getString(0, "TRANS_DATE")) +"' \n");
		sbSql.append( "   AND ROWNUM        <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());					
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			sCheckDate = rs.getString("PHYSIC_DATE");
			rs.close();
			pstmt.close();
			out_vl.add("sCheckDate", sCheckDate+" 재고조사가 반영되어  작업이 불가합니다!.");
//this.setResultMessage(0, "OK",out_vl); 자바메시지는 이걸로 날라간다.
			proc_output(response,out,out_vl,out_dl);
			return;		
		}
		else
		{
				rs.close();
				pstmt.close();		 
		}
//System.out.println("================" + ds_List.getRowCount());
		//입력,수정
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			sRowStatus = ds_List.getRowType(i);
//System.out.println("================" + sRowStatus);
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT FMW_UNIT_CHG_FUN('"+ nullToBlank(ds_List.getString(i, "ITEM_CODE")) +"',2,'" + nullToBlank(ds_List.getString(i, "BOX_QTY")) + "','" + nullToBlank(ds_List.getString(i, "BONG_QTY")) + "') AS TRANS_QTY \n");
			sbSql.append("  FROM DUAL \n");
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();

			rs.next();
			sTRANS_QTY = rs.getString("TRANS_QTY");

			rs.close();
			pstmt.close();
			
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{
		        sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT NVL(MAX(SUBSTR(TRANS_NUM,10,16)),0) +1 MAX_TRANS_NUM \n");
				sbSql.append("  FROM FMW_PO_TRANSACTION \n");
				sbSql.append(" WHERE TRANS_DATE = '"+ nullToBlank(ds_Cond.getString(0, "TRANS_DATE")) +"' \n");
				sbSql.append("   AND SUBINV_CODE = '"+ nullToBlank(ds_Cond.getString(0, "SUBINV_CODE")) +"' \n");
out_vl.add("fa_Sql", sbSql.toString());
//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();

				rs.next();
				sTRANS_NUM = rs.getString("MAX_TRANS_NUM");

				rs.close();
				pstmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FMW_PO_TRANSACTION 	\n");
		        sbSql.append("     ( TRANS_ID       			\n");
		        sbSql.append("	   , TRANS_NUM      			\n");
		        sbSql.append("     , TRANS_TYPE     			\n");
		        sbSql.append("     , UPJANG          			\n");
		        sbSql.append("     , TRANS_DATE     			\n");
		        sbSql.append("	   , SUBINV_CODE    			\n");
		        sbSql.append("     , ITEM_CODE      			\n");
		        sbSql.append("     , ITEM_NAME      			\n");
		        sbSql.append("     , TRANS_QTY      			\n");
		        sbSql.append("     , PHYSIC_GUBUN   			\n");
		        sbSql.append("     , TRANS_AMOUNT   			\n");
		        sbSql.append("     , AVG_AMOUNT   			    \n");
		        sbSql.append("     , TRANS_PRICE    			\n");		    
		        sbSql.append("     , AVG_PRICE    	     		\n");
		        sbSql.append("     , REMARK         			\n");
		        sbSql.append("     , USE_YN         			\n");
		        sbSql.append("     , CUSER          			\n");
		        sbSql.append("     , CDATE          			\n");
		        sbSql.append("     , UUSER          			\n");
		        sbSql.append("     , UDATE ) VALUES 			\n");
				sbSql.append("     ( FMW_PO_TRANSACTION_S.NEXTVAL                         								 \n");
				sbSql.append("     , '"+ nullToBlank(ds_Cond.getString(0, "TRANS_DATE"))+'-'+sTRANS_NUM + "'     \n");
				sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "TRANS_TYPE")) + "' 				     \n");
				sbSql.append("     , '" + g_Upjang + "' 				    											 \n");
				sbSql.append("     , '" + nullToBlank(ds_Cond.getString(0, "TRANS_DATE")) + "' 				     \n");
				sbSql.append("     , '" + nullToBlank(ds_Cond.getString(0, "SUBINV_CODE")) + "' 				 \n");
				sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "ITEM_CODE")) + "' 					 \n");
				sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "ITEM_NAME")) + "'					 \n");
				//if (nullToBlank(ds_List.getString(i, "TRANS_TYPE")).equals("I002"))
				//{	
				//	sbSql.append("     , " + sTRANS_QTY + " 												 			 	\n");
				//	sbSql.append("     , 1                                                                 				 	\n");
				//	sbSql.append("     , " + sTRANS_QTY + " * " + nullToBlank(ds_List.getString(i, "TRANS_PRICE")) + "	\n");
				//	sbSql.append("     , " + sTRANS_QTY + " * " + nullToBlank(ds_List.getString(i, "TRANS_PRICE")) + " 	\n");
				//}	
				//else
				//{	
				//	sbSql.append("     , -1 * " + sTRANS_QTY + "  														 	\n");
				//	sbSql.append("     , 1  																				\n");
				//	sbSql.append("     , -1 * " + sTRANS_QTY + " * " + nullToBlank(ds_List.getString(i, "TRANS_PRICE")) + "	\n");
				//	sbSql.append("     , -1 * " + sTRANS_QTY + " * " + nullToBlank(ds_List.getString(i, "TRANS_PRICE")) + "	\n");
				//}
				sbSql.append("     , " + sTRANS_QTY + " 												 			 	\n");
				sbSql.append("     , 1                                                                 				 	\n");
				sbSql.append("     , " + sTRANS_QTY + " * " + nullToBlank(ds_List.getString(i, "TRANS_PRICE")) + "	\n");
				sbSql.append("     , " + sTRANS_QTY + " * " + nullToBlank(ds_List.getString(i, "TRANS_PRICE")) + " 	\n");
				sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "TRANS_PRICE")) + "' 		 		\n");
				sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "TRANS_PRICE")) + "' 		 		\n");
				sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "REMARK")) + "'						\n");
				sbSql.append("     , 'Y' 																				\n");
				sbSql.append("     , '" + g_EmpNo + "' 																	\n");
				sbSql.append("     , SYSDATE 																			\n");
				sbSql.append("     , '" + g_EmpNo + "' 																	\n");
				sbSql.append("     , SYSDATE ) \n");
			}
			else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FMW_PO_TRANSACTION \n");
		        sbSql.append("   SET TRANS_TYPE = '" + nullToBlank(ds_List.getString(i, "TRANS_TYPE")) + "'     \n");
		        sbSql.append("     , TRANS_PRICE = '" + nullToBlank(ds_List.getString(i, "TRANS_PRICE")) + "'   \n");
		        //if (nullToBlank(ds_List.getString(i, "TRANS_TYPE")).equals("I002"))
				//{	
				//	sbSql.append("     , TRANS_QTY = " + sTRANS_QTY + " 													\n");
				//	sbSql.append("     , PHYSIC_GUBUN = 1 																	\n");
				//	sbSql.append("     , TRANS_AMOUNT = '" + nullToBlank(ds_List.getString(i, "TRANS_AMOUNT")) + "' \n");
				//	sbSql.append("     , AVG_AMOUNT = '" + nullToBlank(ds_List.getString(i, "TRANS_AMOUNT")) + "'   \n");
				//}	
				//else
				//{	
				//	sbSql.append("     , TRANS_QTY = -1 * " + sTRANS_QTY + " 												\n");
				//	sbSql.append("     , PHYSIC_GUBUN = 1 																    \n");
				//	sbSql.append("     , TRANS_AMOUNT = -1 * '" + nullToBlank(ds_List.getString(i, "TRANS_AMOUNT")) + "' \n");
				//	sbSql.append("     , AVG_AMOUNT = -1 * '" + nullToBlank(ds_List.getString(i, "TRANS_AMOUNT")) + "'   \n");
				//}
		        sbSql.append("     , TRANS_QTY = " + sTRANS_QTY + " 													\n");
				sbSql.append("     , PHYSIC_GUBUN = 1 																	\n");
				sbSql.append("     , TRANS_AMOUNT = '" + nullToBlank(ds_List.getString(i, "TRANS_AMOUNT")) + "' \n");
				sbSql.append("     , AVG_AMOUNT = '" + nullToBlank(ds_List.getString(i, "TRANS_AMOUNT")) + "'   \n");
		        sbSql.append("     , REMARK = '" + nullToBlank(ds_List.getString(i, "REMARK")) + "'  \n");
		        sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE TRANS_ID = '" + nullToBlank(ds_List.getString(i, "TRANS_ID")) + "' \n");
			}
out_vl.add("fa_Sql", sbSql.toString());
//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}

		//삭제
		for ( int j = 0 ; j < ds_List.getRemovedRowCount() ; j++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FMW_PO_TRANSACTION \n");
			sbSql.append(" WHERE TRANS_ID = " + ds_List.getRemovedData(j, "TRANS_ID").toString() + " \n");
out_vl.add("fa_Sql", sbSql.toString());
//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}
		/**종료**/
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