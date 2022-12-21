<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ page import="java.net.*" %>
<%@ include file = "../main/common.jsp" %>
<%
	PlatformRequest platformRequest = this.proc_input(request);  
	in_vl = platformRequest.getData().getVariableList();
	in_dl = platformRequest.getData().getDataSetList();
	
	logger.startIndividualLog(in_vl.getString("titLogId"));		
	
	String v_path  	= in_vl.getString("PATH");
	DataSet ds_list = in_dl.get("ds_openPage");
	
	String v_url   = request.getRequestURL().toString();
	String v_uri   = request.getRequestURI().toString();
	
	String v_userId = in_vl.getString("USER_ID");
	String v_prdId = ds_list.getString(0, "prgId");
	String v_openTime = ds_list.getString(0, "openTime");
	
	if ( v_url.indexOf("localhost") != -1 ) {
		v_url   = "http://172.16.1.121:8091";	// for test
	}
	
	String v_target = v_url.replace(v_uri, "")+"/"+v_path;
	String date = "";			
		
	try{
		System.out.println(v_target);
		URLConnection connection = new URL(v_target).openConnection();
		Date lastModified = new Date(connection.getHeaderField("Last-Modified"));
		date = new SimpleDateFormat("yyyyMMdd HHmmss").format(lastModified);
		System.out.println(date);
		out_vl.add("lstModDt", date);
	} catch(IOException e) {
		out_vl.add("lstModDt", "ERROR");
	} 	
	
	try {
		String trimDate = date.replaceAll("\\p{Z}", "");
		System.out.println(v_openTime + "||" + trimDate);
		
		Long scrn = new Long(v_openTime);
		Long sver = new Long(trimDate);
		
		if ( scrn.compareTo(sver) < 0 ) {

			StringBuffer sbSql = new StringBuffer();
			
			sbSql.append(" /*+ SCC_FILE_CHKEK_T002.JSP */ 					\n");
			sbSql.append(" INSERT INTO SCC_RESOURCE_CHECK_HIST ( 			\n");
			sbSql.append(" 	USER_ID                                 		\n");
			sbSql.append("   ,PRG_ID                                		\n");
			sbSql.append("   ,OPEN_TIME                             		\n");
			sbSql.append("   ,RESOURCE_TIME                             	\n");
			sbSql.append("   ,SESSION_ID                            		\n");
			sbSql.append("   ,CONN_IP                               		\n");
			sbSql.append("   ,CDATE                                 		\n");
			sbSql.append(" ) VALUES (                               		\n");
			sbSql.append(" 	:USER_ID                                		\n");
			sbSql.append("   ,:PRG_ID                               		\n");
			sbSql.append("   ,TO_DATE(:OPEN_TIME, 'YYYYMMDDHH24MISS')		\n");
			sbSql.append("   ,TO_DATE(:RESOURCE_TIME, 'YYYYMMDDHH24MISS')	\n");
			sbSql.append("   ,:SESSION_ID                           		\n");
			sbSql.append("   ,:CONN_IP                              		\n");
			sbSql.append("   ,SYSDATE                               		\n");
			sbSql.append(" )                                        		\n");
			
			npstmt = new NamedParameterStatement(conn, sbSql.toString());
			npstmt.setString("USER_ID", v_userId);
			npstmt.setString("PRG_ID", v_prdId);
			npstmt.setString("OPEN_TIME", v_openTime);
			npstmt.setString("RESOURCE_TIME", date.toString());
			npstmt.setString("SESSION_ID", request.getSession().getId().toString());
			npstmt.setString("CONN_IP", request.getRemoteAddr().toString());
			
			rs = npstmt.executeQuery(); 
			npstmt.close();
			rs.close();
			
			sbSql.setLength(0);
			 
			conn.commit();
		}
		this.setResultMessage(0, "OK",out_vl);  
		
	} catch (Exception ex) {
		
		logger.debug(ex.getMessage(), ex);		
		this.setResultMessage(-1, ex.toString(),out_vl);
		
	} finally {
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {}
		}
		
		if (npstmt != null) {
            try {
                npstmt.close();
            } catch (Exception e) {
            }
        }
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}
	
	
    proc_output(response,out,out_vl,out_dl);
%>