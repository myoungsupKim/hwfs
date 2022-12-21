<%

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
		DataSet ds_List1    = in_dl.get("ds_List1");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String v_Upjang     = nullToBlank(in_vl.getString("v_Upjang"));
		String v_ItemCode   = nullToBlank(in_vl.getString("v_ItemCode"));

		String sEDATE   = "";
		String sSDATE   = "";
		String sDATE   = "";
			
		//입력 파라메터
		//String strUpjang 		= ds_cond.getRemovedData(0, "UPJANG").toString();
		//String strOtcust        = ds_cond.getRemovedData(0, "OTCUSTCD").toString();		
		//String g_OTCUSTCD    = nullToBlank(in_vl.getString("OTCUSTCD"));	
	
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
	
	//	System.out.println(v_OTCUSTCD +"ddd");	

		//입력,수정
		for ( int i = 0 ; i < ds_List1.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			if (nullToBlank(ds_List1.getString(i, "CHK_YN")).equals("0"))
			{   
				continue;
			}
			else if (nullToBlank(ds_List1.getString(i, "CHK_YN")).equals("1"))
			{   
			    sbSql.append("SELECT SDATE                                    \n");		
	            sbSql.append("  FROM FMW_OTCUST_PRICE                     \n");
			    sbSql.append(" WHERE ITEM_CODE = '" + v_ItemCode + "'     \n");
			    sbSql.append("   AND SDATE = TO_CHAR(TO_DATE( '" + nullToBlank(ds_List1.getString(i, "SDATE")) + "','YYYYMMDD' ), 'YYYYMMDD')       \n");			    
			    sbSql.append("   AND UPJANG = '" + v_Upjang + "'          \n");
out_vl.add("fa_Sql", sbSql.toString());
 				pstmt = conn.prepareStatement(sbSql.toString()); //미리 담아놓는 곳이라네	
				rs = pstmt.executeQuery(); //쿼리실행한다
				if (rs.next())
				{
					sSDATE = rs.getString("SDATE");
					rs.close();
					pstmt.close();
					out_vl.add("sSDATE", sSDATE+"일자에 기존 단가계약정보가  등록되어 있습니다!.");
					proc_output(response,out,out_vl,out_dl);
					return;
				}
 				//if (rs.next()) throw new Exception(i + "단가계약 정보가 기존에 있습니다!");
 				rs.close();
 				pstmt.close();
 				 
 				sbSql.delete(0, sbSql.length());
 		        sbSql.append("SELECT TO_CHAR(TO_DATE('" + nullToBlank(ds_List1.getString(i, "SDATE")) + "','YYYYMMDD')-1,'YYYYMMDD') AS EDATE  \n"); 		        	        
	            sbSql.append("  FROM DUAL                  																						\n");
out_vl.add("fa_Sql", sbSql.toString());
			    pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
  				rs.next();
  				sEDATE = rs.getString("EDATE");
  				rs.close();
				pstmt.close();
  				 
   				sbSql.delete(0, sbSql.length());
  				sbSql.append("UPDATE FMW_OTCUST_PRICE A						\n");
  		        sbSql.append("   SET A.EDATE = '" + sEDATE + "'         	\n");
  		        sbSql.append("     , A.UUSER = '" + g_EmpNo + "'         	\n");
  		        sbSql.append("     , A.UDATE = SYSDATE         				\n");
  		        sbSql.append(" WHERE A.ITEM_CODE = '" + v_ItemCode + "' 	\n");
  		        sbSql.append("   AND A.UPJANG = '" + v_Upjang + "'      	\n");
  		        sbSql.append("   AND A.SDATE = (SELECT /*+ INDEX_DESC(Z FMW_OTCUST_PRICE_PK) */ Z.SDATE FROM FMW_OTCUST_PRICE Z WHERE Z.UPJANG = A.UPJANG AND Z.ITEM_CODE = A.ITEM_CODE AND Z.SDATE < TO_CHAR(TO_DATE('" + nullToBlank(ds_List1.getString(i, "SDATE")) + "','YYYYMMDD'),'YYYYMMDD') AND ROWNUM <= 1)	\n");
out_vl.add("fa_Sql", sbSql.toString());  		         
  		        pstmt = conn.prepareStatement(sbSql.toString());
  		        pstmt.executeUpdate();
				pstmt.close();
				 
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FMW_OTCUST_PRICE \n");
		        sbSql.append("     ( SDATE                 \n");
		        sbSql.append("	   , ITEM_CODE             \n");
		        sbSql.append("     , UPJANG                \n");
		        sbSql.append("     , UNIT_PRICE            \n");
		        sbSql.append("     , USE_YN                \n");
		        sbSql.append("	   , CUSER                 \n");
		        sbSql.append("     , CDATE                 \n");
		        sbSql.append("     , UUSER                 \n");
		        sbSql.append("     , UDATE ) VALUES        \n");
				sbSql.append("     ( TO_CHAR(TO_DATE('" + nullToBlank(ds_List1.getString(i, "SDATE")) + "','YYYYMMDD'),'YYYYMMDD') \n");				
				sbSql.append("     , '" + v_ItemCode + "' 																		  \n");
				sbSql.append("     , '" + v_Upjang + "' 																		  \n");
				sbSql.append("     , '" + nullToBlank(ds_List1.getString(i, "BONG_PRICE")) + "' 						  \n");
				sbSql.append("     , 'Y' 																						  \n");
				sbSql.append("     , '" + g_EmpNo + "' 																			  \n");
				sbSql.append("     , SYSDATE 																					  \n");
				sbSql.append("     , '" + g_EmpNo + "' 																			  \n");
				sbSql.append("     , SYSDATE ) 																					  \n");
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			    pstmt = conn.prepareStatement(sbSql.toString());
			    pstmt.executeUpdate();
			    pstmt.close();
			    
			    sbSql.delete(0, sbSql.length());
			    sbSql.append("SELECT /*+ INDEX_ASC(A FMW_OTCUST_PRICE_PK) */ \n");		
			    sbSql.append("       TO_CHAR(TO_DATE(A.SDATE,'YYYYMMDD')-1,'YYYYMMDD') AS SDATE                                     \n");		
	            sbSql.append("  FROM FMW_OTCUST_PRICE A                     \n");
			    sbSql.append(" WHERE A.ITEM_CODE = '" + v_ItemCode + "'     \n");
			    sbSql.append("   AND A.SDATE > TO_CHAR(TO_DATE( '" + nullToBlank(ds_List1.getString(i, "SDATE")) + "','YYYYMMDD' ), 'YYYYMMDD')       \n");			    
			    sbSql.append("   AND A.UPJANG = '" + v_Upjang + "'          \n");
			    sbSql.append("   AND ROWNUM <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());
 				pstmt = conn.prepareStatement(sbSql.toString()); //미리 담아놓는 곳이라네	
				rs = pstmt.executeQuery(); //쿼리실행한다
				if (rs.next())
				{
					sDATE = rs.getString("SDATE");
					rs.close();
					pstmt.close();
					
				    sbSql.delete(0, sbSql.length());
					sbSql.append("UPDATE FMW_OTCUST_PRICE A						\n");
	  		        sbSql.append("   SET A.EDATE = '" + sDATE + "'           	\n");
	  		        sbSql.append("     , A.UUSER = '" + g_EmpNo + "'         	\n");
	  		        sbSql.append("     , A.UDATE = SYSDATE         				\n");
	  		        sbSql.append(" WHERE A.ITEM_CODE = '" + v_ItemCode + "' 	\n");
	  		        sbSql.append("   AND A.UPJANG = '" + v_Upjang + "'      	\n");
	  		        sbSql.append("   AND A.SDATE = TO_CHAR(TO_DATE( '" + nullToBlank(ds_List1.getString(i, "SDATE")) + "','YYYYMMDD' ), 'YYYYMMDD')	\n");
out_vl.add("fa_Sql", sbSql.toString());
	  			    pstmt = conn.prepareStatement(sbSql.toString());
	  			    pstmt.executeUpdate();
	  			    pstmt.close();
				}		    
		    }     
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
