<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@ page language="java" import="com.sz.core.ServiceManagerFactory" %>
<%@ page language="java" import="com.sz.service.ui.HttpFileManager" %>
<%@ page language="java" import="org.apache.commons.io.FileUtils" %>
<%@ page language="java" import="java.io.File" %>

<%
	Statement stmt = null;

	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		DataSet ds_RecipeCD = in_dl.get("ds_RecipeCD");
		DataSet ds_Recipe = in_dl.get("ds_Recipe");
		
		HttpFileManager file = (HttpFileManager) ServiceManagerFactory.getServiceObject("HttpFileManagerService");
		
		if(ds_Recipe != null) {
			String PHOTO_PATH	    = nullToBlank(ds_Recipe.getString(0, "PHOTO_PATH"));
			String SPHOTO_PATH	    = nullToBlank(ds_Recipe.getString(0, "SPHOTO_PATH"));
			String RECIPE_CD	    = nullToBlank(ds_RecipeCD.getString(0, "RECIPE_CD"));
			String DIR_FROM         = file.getRealDirPath("FSR_NEW_RECIPE_MST");
			String DIR_TO           = file.getRealDirPath("FSR_STD_RECIPE_MST");
			
			String newFileName = RECIPE_CD + PHOTO_PATH.substring(PHOTO_PATH.indexOf("."), PHOTO_PATH.length());
			//System.out.println("============================== PHOTO_PATH : " + PHOTO_PATH);
			//System.out.println("============================== SPHOTO_PATH : " + SPHOTO_PATH);
			//System.out.println("============================== RECIPE_CD : " + RECIPE_CD);
			//System.out.println("============================== DIR_FROM : " + DIR_FROM + "/" + SPHOTO_PATH);
			//System.out.println("============================== DIR_TO : " + DIR_TO + "/" + PHOTO_PATH);
			//System.out.println("============================== newFileName : " + newFileName);
			FileUtils.copyFile(new File(DIR_FROM + "/" + SPHOTO_PATH), new File(DIR_TO + "/" + newFileName));
			
			//sql문 버퍼생성                                                                                                                                                                                       
			StringBuffer sbSql = new StringBuffer();
			
			// 사진경로 수정
			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE FSR_STD_RECIPE_MST				     \n");
			sbSql.append("   SET SPHOTO_PATH = '" + newFileName + "' \n");
			sbSql.append(" WHERE RECIPE_CD = '"   + RECIPE_CD   + "' \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}

		//트랜잭션 성공
		conn.commit();
		
		out_dl.add(ds_Recipe);
		this.setResultMessage(0, "OK",out_vl);  
	
	} catch(Exception ex) {
		ex.printStackTrace();
		
		//트랜잭션 실패
		conn.rollback();
		
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