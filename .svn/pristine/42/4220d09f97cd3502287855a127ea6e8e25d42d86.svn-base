
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
		DataSet ds_list  	= in_dl.get("ds_list");
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();		//sql문 버퍼생성
	
	
		int RowCnt = ds_list.getRowCount();
		
		if (RowCnt > 0)
		{
			// 1. insert
			sbSql.delete(0, sbSql.length());
			sbSql.append("INSERT INTO FSC_RESULT_PHOTO( \n");
			sbSql.append("    TABLE_TYPE \n");
			sbSql.append("  , FORM_CD \n");
			sbSql.append("  , UPJANG \n");
			sbSql.append("  , CHECK_DATE \n");
			sbSql.append("  , CLASS_CD \n");
			sbSql.append("  , SEQ \n");
			sbSql.append("  , PHOTO_TYPE \n");
			sbSql.append("  , PHOTO \n");
			sbSql.append("  , SPHOTO \n");
			
			//=========================================================================================
			// (2013-08-06 추가) 시작
			// 김장욱 2013-08-06 FC 식품연구소 이재우 매니저 
			// 점검결과의 지적항목 사진에 대응하는 개선사항 사진을 1:1로 첨부 할수 있게 변경.
			//=========================================================================================			
			sbSql.append("	,INPT_GUBUN \n");
			sbSql.append("	, MAP_SEQ \n");
			//=========================================================================================
			// (2013-08-06 추가) 끝
			//=========================================================================================			
			sbSql.append("  , CUSER \n");
			sbSql.append("  , CDATE \n");
			sbSql.append("	, UUSER \n");
			sbSql.append("	, UDATE \n");
			sbSql.append(") \n");
			sbSql.append("SELECT \n");
			sbSql.append("       '"		+	nullToBlank(ds_list.getString(0,"TABLE_TYPE"))	+"' \n");
			sbSql.append("     , '"		+	nullToBlank(ds_list.getString(0,"FORM_CD"))		+"' \n");
			sbSql.append("     , '"		+	nullToBlank(ds_list.getString(0,"UPJANG"))		+"' \n");
			sbSql.append("     , '"		+	nullToBlank(ds_list.getString(0,"CHECK_DATE"))	+"' \n");
			sbSql.append("     , '"		+	nullToBlank(ds_list.getString(0,"CLASS_CD"))	+"' \n");
			sbSql.append("     , NVL(MAX(SEQ) + 1,1) \n");
			sbSql.append("     , '"		+	nullToBlank(ds_list.getString(0,"PHOTO_TYPE"))	+"' \n");
			sbSql.append("     , '"		+	nullToBlank(ds_list.getString(0,"PHOTO"))		+"' \n");
			sbSql.append("     , '"		+	nullToBlank(ds_list.getString(0,"SPHOTO"))		+"' \n");
			//=========================================================================================
			// (2013-08-06 추가) 시작
			// 김장욱 2013-08-06 FC 식품연구소 이재우 매니저 
			// 점검결과의 지적항목 사진에 대응하는 개선사항 사진을 1:1로 첨부 할수 있게 변경.
			//=========================================================================================			
			sbSql.append("     , 'IN'  \n");                  // 지적사항
			sbSql.append("     , NVL(MAX(SEQ) + 1, 1) \n");   // 지적사항 사진등록시 SEQ와 동일, 개선사항 등록시 지적사항의 SEQ
			//=========================================================================================
			// (2013-08-06 추가) 끝
			//=========================================================================================			
			sbSql.append("     , '"		+ 	g_EmpNo 												+"' \n");
			sbSql.append("     , SYSDATE \n");
			sbSql.append("     , '" 	+ 	g_EmpNo 				  							    + "' \n");
			sbSql.append("     , SYSDATE \n");
			sbSql.append("  FROM FSC_RESULT_PHOTO \n");
			sbSql.append(" WHERE TABLE_TYPE = '"	+	nullToBlank(ds_list.getString(0,"TABLE_TYPE"))	+"' \n");
			sbSql.append("   AND FORM_CD = '"		+	nullToBlank(ds_list.getString(0,"FORM_CD"))		+"' \n");
			sbSql.append("   AND UPJANG = '"		+	nullToBlank(ds_list.getString(0,"UPJANG"))		+"' \n");
			sbSql.append("   AND CHECK_DATE = '"	+	nullToBlank(ds_list.getString(0,"CHECK_DATE"))	+"' \n");
			sbSql.append("   AND CLASS_CD = '"		+	nullToBlank(ds_list.getString(0,"CLASS_CD"))	+"' \n");
			
			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		conn.commit();
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