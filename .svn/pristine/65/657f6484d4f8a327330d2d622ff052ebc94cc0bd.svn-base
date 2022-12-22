<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/협력업체위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00312P_T002.jsp                                                                                                                                                                    
■ 프로그램명   : 정검결과등록 - 사진리스트조회                                                                                                                                               
■ 작성일자     : 2015-02-09                                                                                                                                                                            
■ 작성자       : 김민수                                                                                                                                                                                
■ 이력관리     : 2015-02-09                                                                                                                                                                            
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
                                                                                                                                                                    
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ page language="java" import="java.util.*,java.io.*" %>
<%@ page language="java" import="java.util.*,java.net.*" %>
<%@ include file = "../../sc/main/common.jsp" %>       
                                                                                                                                                 
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();  
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	                                                                                                                                                                                                        
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input    = in_dl.get("ds_input");                                                                                                                                                  
		String TABLE_TYPE 	= nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
		String FORM_CD 		= nullToBlank(ds_input.getString(0, "FORM_CD"));
		String UPJANG 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String CHK_DD 	    = nullToBlank(ds_input.getString(0, "CHK_DD"));
		String CLASS_CD	    = nullToBlank(ds_input.getString(0, "CLASS_CD"));
                                                                                                                                                                                                        
		//out 데이타                                                                                                                                                                                        
		DataSet ds_imgeList = new DataSet("output");                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// 사진리스트조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT SRLNUM							    \n");
		sbSql.append("     , TABLE_TYPE                         \n");
		sbSql.append("     , FORM_CD                            \n");
		sbSql.append("     , UPJANG                             \n");
		sbSql.append("     , CHK_DD                             \n");
		sbSql.append("     , CLASS_CD                           \n");
		sbSql.append("     , ORGNL_IMGE                         \n");
		sbSql.append("     , SVR_IMGE                           \n");
		sbSql.append("     , FILE_SIZE                          \n");
		sbSql.append("     , IMPROV_ORGNL_IMGE                  \n");
		sbSql.append("     , IMPROV_SVR_IMGE                    \n");
		sbSql.append("     , IMPROV_FILE_SIZE                   \n");
		sbSql.append("     , CUSER                              \n");
		sbSql.append("     , CDATE                              \n");
		sbSql.append("     , UUSER                              \n");
		sbSql.append("     , UDATE                              \n");
		sbSql.append("     , PHOTO_TYPE                         \n");
		sbSql.append("     , DECODE(IMPROV_SVR_IMGE,'','미등록','등록') AS IMPROV_YN \n");
		sbSql.append("     , SVR_IMGE AS PRE_VIEW               \n");		
		sbSql.append("     , '' AS FILE_PATH                    \n");
		sbSql.append("     , IMPROV_SVR_IMGE AS IMPROV_PRE_VIEW \n");		
		sbSql.append("     , '' AS IMPROV_FILE_PATH             \n");
		sbSql.append("     , '0' AS CHK                         \n");
		sbSql.append("  FROM FSC_SAFE_CHK_IMGE                \n");
		sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "'  \n");
		sbSql.append("   AND FORM_CD    = '" + FORM_CD + "'     \n");
		sbSql.append("   AND UPJANG     = '" + UPJANG + "'      \n");		
		sbSql.append("   AND CHK_DD     = '" + CHK_DD + "'      \n");
		sbSql.append("   AND CLASS_CD   = '" + CLASS_CD + "'    \n");
		sbSql.append(" ORDER BY CDATE DESC                      \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_imgeList = this.makeDataSet(rs, "ds_imgeList");                                                                                                                                                          

/* 		System.out.println("==================>>>> " + ds_imgeList.canChangeStructureWithData());
		ds_imgeList.setChangeStructureWithData(true);
		System.out.println("==================>>>> " + ds_imgeList.canChangeStructureWithData());
		ds_imgeList.addColumn("PRE_VIEW", DataTypes.BLOB  ,255);
		
		InputStream resultInStream = null;
		for(int i=0; i<ds_imgeList.getRowCount(); i++) {
			URL url = new URL("http://127.0.0.1:8080/upload/fs/fsc/photo/" + ds_imgeList.getString(i, "SVR_IMGE"));
			resultInStream = url.openStream();
			byte[] buffer = new byte[4096];
			int bytes_read;
			ByteArrayOutputStream ImageData = new ByteArrayOutputStream();
	
			while((bytes_read=resultInStream.read(buffer)) != -1)
			{
			    ImageData.write(buffer,0,bytes_read);
			}
			
			ds_imgeList.set(i, "PRE_VIEW", ImageData.toByteArray());
		}
		
		resultInStream.close(); */
		rs.close();
		pstmt.close();
		
		/**종료**/
		out_dl.add(ds_imgeList);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);                                                                                                                                                             
                                                                                                                                                                                                        
	}                                                                                                                                                                                                     
	catch(Exception ex)                                                                                                                                                                                   
	{                                                                                                                                                                                                     
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