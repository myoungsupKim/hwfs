<%@ page contentType="text/html; charset=EUC-KR" %>

<%@ include file = "../../sc/main/common.jsp" %>

<%

	Statement stmt             =  null;
	
	try {
	
		PlatformRequest platformRequest = this.proc_input(request);  
	
		in_vl = platformRequest.getData().getVariableList();
	
		in_dl = platformRequest.getData().getDataSetList();
	
		
	
		//jsp log 서비스 시작 
	
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false

		conn.setAutoCommit(false);

		//입력 데이타            
		//DataSet ds_Master  	= in_dl.get("ds_Master");

		DataSet ds_list  	= in_dl.get("ds_list");

		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성		

		int RowCnt;

		int i;
		
		// 2.Detail

		RowCnt = ds_list.getRowCount();
		
		//System.out.println("-----------------------------------------------RowCnt : " + RowCnt);
		
		for ( i = 0 ; i < RowCnt ; i++ ){

			sbSql.delete(0, sbSql.length());
			
			sbSql.append("DELETE FSC_RESULT_PHOTO \n");
			
			sbSql.append(" WHERE TABLE_TYPE = '" + nullToBlank(ds_list.getString(i, "TABLE_TYPE")) +"' \n");
			
			sbSql.append("   AND INPT_GUBUN = 'IM'                                                             \n");

			sbSql.append("   AND FORM_CD    = '" + nullToBlank(ds_list.getString(i, "FORM_CD"))	   +"' \n");
			
			sbSql.append("   AND UPJANG     = " + nullToBlank(ds_list.getString(i, "MST_UPJANG")) +" \n");
			
			sbSql.append("   AND CHECK_DATE = '" + nullToBlank(ds_list.getString(i, "CHECK_DATE")) +"' \n");
			
			sbSql.append("   AND CLASS_CD   = '" + nullToBlank(ds_list.getString(i, "CLASS_CD"))   +"' \n");
			
			sbSql.append("   AND SEQ        = '" + nullToBlank(ds_list.getString(i, "IM_SEQ"))     +"' \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();			

		}
		conn.commit();
	   	this.setResultMessage(0, "OK", out_vl);
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

			

			//jsp log 서비스 닫기 

			try {

				logger.endIndividualLog();

			} catch( Exception logE) {

				logE.printStackTrace();

			}

		}

	  proc_output(response,out,out_vl,out_dl);
%>	