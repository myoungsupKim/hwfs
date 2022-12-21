<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 도소매관리/판매내역 일괄처리
//■ 프로그램ID   : FMW00200E_T001.jsp
//■ 프로그램명   : 판매내역 일괄처리
//■ 작성일자     : 2010.01.04
//■ 작성자       : 맹수영
//■ 이력관리     :  
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%

	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		 
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);		
		
		//입력 데이타
		DataSet ds_in     = in_dl.get("ds_cond1");
			
		//입력 파라메터

		String v_HALL_CODE     = nullToBlank(in_vl.getString("HALL_CODE"));	
		String v_DATE          = nullToBlank(in_vl.getString("DATE"));
		String v_TRANS_TYPE    = nullToBlank(in_vl.getString("TRANS_TYPE"));
		String v_SUBINV_CODE   = nullToBlank(in_vl.getString("SUBINV_CODE"));
		String v_TRANS_ID      = nullToBlank(in_vl.getString("TRANS_ID"));	
		String v_GUBUN         = nullToBlank(in_vl.getString("FIX_GUBUN"));	
		String v_UPJANG        = nullToBlank(in_vl.getString("UPJANG"));	
		String g_EmpNo         =  nullToBlank(in_vl.getString("g_EmpNo"));
		//System.out.println(v_GUBUN + "SSSS");
		//변수선언
		int sRowStatus;
		String sTRANS_NUM;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		
		//전표번호 MAX 값 가져오기 
		sbSql.delete(0, sbSql.length());

		sbSql.append("SELECT NVL(MAX(TO_NUMBER(SUBSTR(TRANS_NUM,10,16))),0) +1 MAX_TRANS_NUM   \n");
		sbSql.append("  FROM FMW_PO_TRANSACTION \n");
		sbSql.append("  WHERE TRANS_DATE = '"+ v_DATE +"' \n");
		sbSql.append("    AND SUBINV_CODE = '"+ v_SUBINV_CODE +"' \n");

        out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		rs.next();

		String sMAX_TRANS_NUM = rs.getString("MAX_TRANS_NUM");

		rs.close();
		pstmt.close();
		//전표번호 MAX 값 가져오기
		
		
	
        //단가 구하기
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT A.ITEM_CODE \n");
		sbSql.append( "     , A.ITEM_NAME \n");			
		sbSql.append( "     , A.ITEM_SIZE_BONG \n");
  	    sbSql.append( "     , ROUND(DECODE(SUM(B.UNIT_QTY),0,0,SUM(UNIT_AMOUNT) / SUM(B.UNIT_QTY))) AS TRANS_PRICE \n");
		//sbSql.append( "     , ROUND(DECODE(SUM(B.UNIT_QTY),0,0,SUM(UNIT_AMOUNT) / SUM(B.UNIT_QTY)) * SUM(B.TRANS_QTY)) AS TRANS_AMOUNT \n");
		sbSql.append( "  FROM FMW_ITEM_V A, FMS_SUBINVENTORY F \n");
		sbSql.append( "     ,( \n");
		//sbSql.append( "       SELECT C.SUBINV_CODE \n");
		//sbSql.append( "            , C.ITEM_CODE \n");
		//sbSql.append( "            , C.ONHAND_QTY AS TRANS_QTY \n");
		//sbSql.append( "            , ABS(C.UNIT_AMOUNT) AS UNIT_AMOUNT  \n");
		//sbSql.append( "            , ABS(C.ONHAND_QTY) AS UNIT_QTY  \n");
		//sbSql.append( "         FROM FMW_ONHAND_MONTH C \n");
		//sbSql.append( "        WHERE C.ONHAND_YM   = (SELECT MAX(ONHAND_YM) FROM FMW_ONHAND_MONTH WHERE SUBINV_CODE = '"+ v_SUBINV_CODE +"') \n");
		//sbSql.append( "          AND C.SUBINV_CODE = '"+ v_SUBINV_CODE +"' \n");
		//sbSql.append( "      UNION ALL \n");
		sbSql.append( "       SELECT D.SUBINV_CODE \n");
		sbSql.append( "            , D.ITEM_CODE \n");
		sbSql.append( "            , 0 AS TRANS_QTY \n");
		sbSql.append( "            , SUM(ABS(D.TRANS_AMOUNT))AS UNIT_AMOUNT \n");
		sbSql.append( "            , SUM(ABS(D.TRANS_QTY)) AS UNIT_QTY \n");
		sbSql.append( "         FROM FMW_PO_TRANSACTION D \n");
		sbSql.append( "        WHERE D.TRANS_DATE BETWEEN '20000101' AND '"+ v_DATE +"' \n");
		sbSql.append( "          AND D.SUBINV_CODE = '"+ v_SUBINV_CODE +"' \n");
		sbSql.append( "          AND D.TRANS_TYPE LIKE 'I%' \n");
		sbSql.append( "        GROUP BY D.SUBINV_CODE, D.ITEM_CODE \n");
		sbSql.append( "      UNION ALL \n");
		sbSql.append( "       SELECT E.SUBINV_CODE \n");
		sbSql.append( "            , E.ITEM_CODE \n");
		sbSql.append( "            , SUM(E.TRANS_QTY * E.PHYSIC_GUBUN) AS TRANS_QTY \n");
		sbSql.append( "            , 0 AS UNIT_AMOUNT \n");
		sbSql.append( "            , 0 AS UNIT_QTY \n");
		sbSql.append( "         FROM FMW_PO_TRANSACTION E \n");
		sbSql.append( "        WHERE E.TRANS_DATE BETWEEN  '20000101' AND '"+ v_DATE +"' \n");
		sbSql.append( "          AND E.SUBINV_CODE ='"+ v_SUBINV_CODE +"' \n");
		sbSql.append( "        GROUP BY E.SUBINV_CODE, E.ITEM_CODE \n");
		sbSql.append( "      ) B \n");
		sbSql.append( " WHERE B.SUBINV_CODE = F.SUBINV_CODE \n");
		sbSql.append( "   AND A.ITEM_CODE = B.ITEM_CODE                                             \n");
		sbSql.append( " GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE_BONG                         \n");
		sbSql.append( "HAVING SUM(B.TRANS_QTY) <> 0                                                 \n");	

        out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		rs.next();
		
		String sTRANS_PRICE = rs.getString("TRANS_PRICE");
		//String sTRANS_AMOUNT = rs.getString("TRANS_AMOUNT");
				
		rs.close();
		pstmt.close();
		//단가 구하기
		
 		for ( int i = 0 ; i < ds_in.getRowCount() ; i++ )
		{
  			
 		sRowStatus = ds_in.getRowType(i);
 		
		//구분 영구/임시 구분으로 영구면 테이블 INSERT 아니면 그냥 넘어가기

		sbSql.delete(0, sbSql.length());

		sbSql.append("SELECT COUNT(*) COUNT \n");
		sbSql.append("  FROM FMW_FIXED_SALE_PRICE \n");
		sbSql.append("  WHERE HALL_CODE = '"+ v_HALL_CODE +"' \n");
		sbSql.append("    AND ITEM_CODE = '" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "'\n");

        out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		rs.next();

		String sCOUNT = rs.getString("COUNT");	
		//System.out.println("ㅇㅇㅇㅇ");
		//System.out.println(v_GUBUN);
        if( v_GUBUN.equals("2"))
        {
    		if (! sCOUNT.equals("0")){
				sbSql.delete(0, sbSql.length());		
				sbSql.append("UPDATE FMW_FIXED_SALE_PRICE \n");
				sbSql.append("   SET SALE_PRICE = " + nullToBlank(ds_in.getString(i, "PRICE_BONG")) + " \n");
				sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE HALL_CODE = '" + v_HALL_CODE + "' \n");	
				sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "'\n");

	    		out_vl.add("fa_Sql", sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();    		
   		
     			sbSql.delete(0, sbSql.length());
    			sbSql.append("INSERT INTO FMW_SALE_PRICE_HIS 	(			\n");                   
    			sbSql.append("     SEQ, ITEM_CODE       	\n");        
    			sbSql.append("    ,SDATE	\n");
    			sbSql.append("    ,SALE_PRICE	\n");    
    			sbSql.append("    ,CUSER, CDATE 	\n"); 
    			sbSql.append(" )	\n");  
    			sbSql.append(" VALUES (	\n");			
    			sbSql.append("    FMW_SALE_PRICE_HIS_S.NEXTVAL, '" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "'	\n");
    			sbSql.append("    ,TO_CHAR(SYSDATE,'YYYYMMDD')	\n");
    			sbSql.append("    ," + nullToZero(ds_in.getString(i, "PRICE_BONG")) + "	\n");
    			sbSql.append("	, '" + g_EmpNo + "' \n");
    			sbSql.append("	, SYSDATE \n");
    			sbSql.append(" )	\n");   		
    		}
    		else
    		{ 
     			sbSql.delete(0, sbSql.length());
    			sbSql.append("INSERT INTO FMW_FIXED_SALE_PRICE 	(			\n");                   
    			sbSql.append("     HALL_CODE       	\n");        
    			sbSql.append("    ,ITEM_CODE	\n");
    			sbSql.append("    ,SALE_PRICE	\n");     
    			sbSql.append("    ,USE_YN ,CUSER, CDATE)	\n");  
    			sbSql.append(" VALUES (	\n");			
    			sbSql.append("    '" + v_HALL_CODE +"'	\n");
    			sbSql.append("    ,'" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "' 	\n");
    			sbSql.append("    ," + nullToZero(ds_in.getString(i, "PRICE_BONG")) + "	\n");		
    			sbSql.append("    ,'Y'	\n");
    			sbSql.append("	, '" + g_EmpNo + "' \n");
    			sbSql.append("	, SYSDATE \n");   			
    			sbSql.append(" )	\n");   
    			
	    		out_vl.add("fa_Sql", sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();    		
   		
     			sbSql.delete(0, sbSql.length());
    			sbSql.append("INSERT INTO FMW_SALE_PRICE_HIS 	(			\n");                   
    			sbSql.append("     SEQ, ITEM_CODE       	\n");        
    			sbSql.append("    ,SDATE	\n");
    			sbSql.append("    ,SALE_PRICE,CUSER, CDATE	\n");     
    			sbSql.append(" )	\n");  
    			sbSql.append(" VALUES (	\n");			
    			sbSql.append("    FMW_SALE_PRICE_HIS_S.NEXTVAL, '" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "'	\n");
    			sbSql.append("    ,TO_CHAR(SYSDATE,'YYYYMMDD')	\n");
    			sbSql.append("    ," + nullToZero(ds_in.getString(i, "PRICE_BONG")) + "	\n");	
    			sbSql.append("	, '" + g_EmpNo + "' \n");
    			sbSql.append("	, SYSDATE \n");    			
    			sbSql.append(" )	\n");   	    			
    		}
    		
    		out_vl.add("fa_Sql", sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();    		
    		
        }
        //구분 영구/임시 구분으로 영구면 테이블 INSERT 아니면 그냥 넘어가기

 		
		if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
		{
			continue;
		}
		else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
		{ 		
 		sbSql.delete(0, sbSql.length());
		sbSql.append("INSERT INTO FMW_PO_TRANSACTION 	(			\n");                   
		sbSql.append("     TRANS_ID       	\n");        
		sbSql.append("    ,TRANS_NUM	\n");
		sbSql.append("    ,TRANS_TYPE	\n"); //매출이든 반품이든 기준은 출고로 (다만, 반품이면 수량이 - )
     	sbSql.append("    ,TRANS_DATE	\n");
     	sbSql.append("    ,UPJANG	\n");
		sbSql.append("    ,SUBINV_CODE	\n");
		sbSql.append("    ,HALL_CODE      	\n");        
		sbSql.append("    ,ITEM_CODE	\n");
		sbSql.append("    ,ITEM_NAME	\n");
		sbSql.append("    ,TRANS_QTY	\n");		
		sbSql.append("    ,TRANS_PRICE	\n");
		sbSql.append("    ,AVG_PRICE	\n");	
		sbSql.append("    ,SALE_PRICE	\n");
		sbSql.append("    ,TRANS_AMOUNT 	\n");	
		sbSql.append("    ,AVG_AMOUNT	\n");		
		sbSql.append("    ,SALE_AMOUNT       	\n");        
		sbSql.append("    ,USE_YN, PHYSIC_GUBUN	,CUSER, CDATE\n");
		sbSql.append(" ) \n");
		sbSql.append(" VALUES (	\n");			
		sbSql.append("    FMW_PO_TRANSACTION_S.NEXTVAL	\n");
		sbSql.append("    , '"+ v_DATE +"'||'-'||'"+ sMAX_TRANS_NUM +"' 	\n");
		//sbSql.append("    ,'" + v_TRANS_TYPE + "'	\n");	
		if (v_TRANS_TYPE.equals("O001"))
		{		
			sbSql.append("    ,'O001'	\n"); //매출코드
		} else if (v_TRANS_TYPE.equals("O002"))
		{
			sbSql.append("    ,'O002'	\n");	//반품코드
		}
		
		sbSql.append("    ,'" + v_DATE + "'	\n");
		sbSql.append("    ,'" + v_UPJANG + "'	\n");
		sbSql.append("    ,'" + v_SUBINV_CODE + "'	\n");
		sbSql.append("    ,'" + v_HALL_CODE + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(i, "ITEM_NAME")) + "'	\n");
		
		//매출이면 + , 반품이면 - 수량 입력
		if (v_TRANS_TYPE.equals("O001")) 
		{
			//sbSql.append("    ," + nullToZero(ds_in.getString(i, "AMOUNT_BONG")) + "	\n");	
			sbSql.append(" ,FMW_UNIT_CHG_FUN('" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "','2'," + nullToZero(ds_in.getString(i, "AMOUNT_BOX")) + "," + nullToZero(ds_in.getString(i, "AMOUNT_BONG")) + ")	\n");
		} else if (v_TRANS_TYPE.equals("O002"))
		{
			sbSql.append(" ,-1 * FMW_UNIT_CHG_FUN('" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "','2'," + nullToZero(ds_in.getString(i, "AMOUNT_BOX")) + "," + nullToZero(ds_in.getString(i, "AMOUNT_BONG")) + ")	\n");	
		}

		sbSql.append("    ," + sTRANS_PRICE + "	\n");
		sbSql.append("    ," + sTRANS_PRICE + "	\n");
		
		sbSql.append("    ," + nullToZero(ds_in.getString(i, "PRICE_BONG")) + "	\n");
		
		sbSql.append("    ,(" + sTRANS_PRICE + " * FMW_UNIT_CHG_FUN('" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "','2'," + nullToZero(ds_in.getString(i, "AMOUNT_BOX")) + "," + nullToZero(ds_in.getString(i, "AMOUNT_BONG")) + "))	\n");
		sbSql.append("    ,(" + sTRANS_PRICE + " * FMW_UNIT_CHG_FUN('" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "','2'," + nullToZero(ds_in.getString(i, "AMOUNT_BOX")) + "," + nullToZero(ds_in.getString(i, "AMOUNT_BONG")) + "))	\n");		
		
		//매출이면 판매 합계 금액을 반품이면 -금액을 입력
		if (v_TRANS_TYPE.equals("O001"))
		{
			sbSql.append("    ," + nullToZero(ds_in.getString(i, "SUM")) + "	\n");		
		} else if (v_TRANS_TYPE.equals("O002"))
		{
			sbSql.append("    ,-1 * " + nullToZero(ds_in.getString(i, "SUM")) + "	\n");	
		}
		
		sbSql.append("    ,'Y', '-1'	\n");
		sbSql.append("	, '" + g_EmpNo + "' \n");
		sbSql.append("	, SYSDATE \n"); 		
		sbSql.append(" ) \n");
	
		
		}
		else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
		{
		sbSql.delete(0, sbSql.length());		
		sbSql.append("UPDATE FMW_PO_TRANSACTION \n");
		sbSql.append("   SET TRANS_QTY = FMW_UNIT_CHG_FUN('" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "','2'," + nullToZero(ds_in.getString(i, "AMOUNT_BOX")) + "," + nullToZero(ds_in.getString(i, "AMOUNT_BONG")) + ") \n");
		sbSql.append("     , TRANS_PRICE = " + sTRANS_PRICE + " \n");
		sbSql.append("     , AVG_PRICE = " + sTRANS_PRICE + "\n");
		sbSql.append("     , SALE_PRICE = " + nullToZero(ds_in.getString(i, "PRICE_BONG")) + " \n");
		sbSql.append("     , TRANS_AMOUNT = (" + sTRANS_PRICE + " * FMW_UNIT_CHG_FUN('" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "','2'," + nullToZero(ds_in.getString(i, "AMOUNT_BOX")) + "," + nullToZero(ds_in.getString(i, "AMOUNT_BONG")) + ")) \n");
		sbSql.append("     , AVG_AMOUNT = (" + sTRANS_PRICE + " * FMW_UNIT_CHG_FUN('" + nullToBlank(ds_in.getString(i, "ITEM_CODE")) + "','2'," + nullToZero(ds_in.getString(i, "AMOUNT_BOX")) + "," + nullToZero(ds_in.getString(i, "AMOUNT_BONG")) + ")) \n");
		sbSql.append("     , SALE_AMOUNT = " + nullToZero(ds_in.getString(i, "SUM")) + " \n");
		sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
		sbSql.append("     , UDATE = SYSDATE \n");
		sbSql.append(" WHERE TRANS_ID = '" + nullToBlank(ds_in.getString(i, "TRANS_ID")) + "' \n");
		}
 			
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeQuery();
		
		
		pstmt.close();	
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
