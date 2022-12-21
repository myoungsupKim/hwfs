<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %>

<%
	Statement stmt           =  null;

	try {	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		//logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String in_case1  	= nullToBlank(in_vl.getString("in_case1"));
		String in_cd  		= nullToBlank(in_vl.getString("in_cd"));
		String in_cdnm  	= nullToBlank(in_vl.getString("in_cdnm"));
		String in_cbotype  	= nullToBlank(in_vl.getString("in_cbotype"));
		
		//System.out.println("in_case1   :"+in_case1+"/");
		//System.out.println("in_cbotype :"+in_cbotype+"/");
		//System.out.println("in_cd      :"+in_cd+"/");
		//System.out.println("in_cdnm    :"+in_cdnm+"/");


		if(conn!=null)
		{
			StringBuffer sbSql = new StringBuffer();
							
			sbSql.delete(0, sbSql.length());
			if(!in_cbotype.equals("non"))
			{
				sbSql.append("SELECT    *   from     							\n");
				sbSql.append("(        											\n");
				sbSql.append("SELECT    A.GROUP_NAME AS GROUP_NAME        	\n");
				sbSql.append("	, B.GROUP_CODE AS GROUP_CODE              	\n");
				sbSql.append("	, '' CODE                          			\n");
				if(in_cbotype.equals("all"))
				{
					sbSql.append("	, '전체' CODE_NAME                			\n");
				}
				else 
				{
					sbSql.append("	, '' CODE_NAME                				\n");
				}
				sbSql.append("	, '' CONTENTS                  				\n");
				sbSql.append("	, 0 SORT_SEQ                  				\n");
				sbSql.append("	, '' SYSTEM_YN                				\n");
				sbSql.append("	, '' SET1                          			\n");
				sbSql.append("	, '' SET2                          			\n");
				sbSql.append("	, '' SET3                          			\n");
				sbSql.append("	, '' SET4                          			\n");
				sbSql.append("	, '' SET5                          			\n");
				sbSql.append("	, '' REMARK                      			\n"); 
				sbSql.append("	, '' USE_YN                      			\n"); 
				sbSql.append("	, '' ATTR01                      			\n"); 
				sbSql.append("	, '' ATTR02                      			\n"); 
				sbSql.append("	, '' ATTR03                      			\n"); 
				sbSql.append("	, '' ATTR04                      			\n"); 
				sbSql.append("	, '' ATTR05                      			\n"); 
				sbSql.append("	, '' ATTR06                      			\n"); 
				sbSql.append("	, '' ATTR07                      			\n"); 
				sbSql.append("	, '' ATTR08                      			\n"); 
				sbSql.append("	, '' ATTR09                      			\n"); 
				sbSql.append("	, '' ATTR10                      			\n"); 
				sbSql.append("	, '' CUSER                        			\n"); 
				sbSql.append("	, SYSDATE AS CDATE                        	\n"); 
				sbSql.append("	, '' UUSER                        			\n"); 
				sbSql.append("	, SYSDATE AS UDATE                        	\n"); 
				sbSql.append(" FROM    SCC_COMMON_GROUP A,                	\n"); 
				sbSql.append("         SCC_COMMON_CODE B                  	\n"); 
				sbSql.append(" WHERE 1 = 1                                	\n"); 
				sbSql.append(" AND A.GROUP_CODE = B.GROUP_CODE            	\n"); 
				sbSql.append(" AND A.GROUP_CODE IN (" + in_case1 + ")	 	\n"); 
				sbSql.append(" AND A.USE_YN = 'Y'                         	\n"); 
				sbSql.append(" AND B.USE_YN = 'Y'                         	\n"); 
				sbSql.append(" AND  (B.CODE LIKE '" + in_cd + "'||'%'     	\n"); 
				sbSql.append("   OR  B.CODE_NAME LIKE '%'||'" + in_cdnm + "'||'%')\n"); 
				sbSql.append("GROUP BY A.GROUP_NAME ,B.GROUP_CODE 			\n"); 
				sbSql.append("UNION ALL \n"); 
			}
			else
			{
				sbSql.append("\n"); 				
			}
			sbSql.append("SELECT    A.GROUP_NAME AS GROUP_NAME        \n");
			sbSql.append("	, B.GROUP_CODE AS GROUP_CODE              \n");
			sbSql.append("	, B.CODE AS CODE                          \n");
			sbSql.append("	, B.CODE_NAME AS CODE_NAME                \n");
			sbSql.append("	, B.CONTENTS AS CONTENTS                  \n");
			sbSql.append("	, B.SORT_SEQ AS SORT_SEQ                  \n");
			sbSql.append("	, B.SYSTEM_YN AS SYSTEM_YN                \n");
			sbSql.append("	, B.SET1 AS SET1                          \n");
			sbSql.append("	, B.SET2 AS SET2                          \n");
			sbSql.append("	, B.SET3 AS SET3                          \n");
			sbSql.append("	, B.SET4 AS SET4                          \n");
			sbSql.append("	, B.SET5 AS SET5                          \n");
			sbSql.append("	, B.REMARK AS REMARK                      \n"); 
			sbSql.append("	, B.USE_YN AS USE_YN                      \n"); 
			sbSql.append("	, B.ATTR01 AS ATTR01                      \n"); 
			sbSql.append("	, B.ATTR02 AS ATTR02                      \n"); 
			sbSql.append("	, B.ATTR03 AS ATTR03                      \n"); 
			sbSql.append("	, B.ATTR04 AS ATTR04                      \n"); 
			sbSql.append("	, B.ATTR05 AS ATTR05                      \n"); 
			sbSql.append("	, B.ATTR06 AS ATTR06                      \n"); 
			sbSql.append("	, B.ATTR07 AS ATTR07                      \n"); 
			sbSql.append("	, B.ATTR08 AS ATTR08                      \n"); 
			sbSql.append("	, B.ATTR09 AS ATTR09                      \n"); 
			sbSql.append("	, B.ATTR10 AS ATTR10                      \n"); 
			sbSql.append("	, B.CUSER AS CUSER                        \n"); 
			sbSql.append("	, B.CDATE AS CDATE                        \n"); 
			sbSql.append("	, B.UUSER AS UUSER                        \n"); 
			sbSql.append("	, B.UDATE AS UDATE                        \n"); 
			sbSql.append(" FROM    SCC_COMMON_GROUP A,                \n"); 
			sbSql.append("         SCC_COMMON_CODE B                  \n"); 
			sbSql.append(" WHERE 1 = 1                                \n"); 
			sbSql.append(" AND A.GROUP_CODE = B.GROUP_CODE            \n"); 
			sbSql.append(" AND A.GROUP_CODE IN (" + in_case1 + ")	  \n"); 
			sbSql.append(" AND A.USE_YN = 'Y'                         \n"); 
			sbSql.append(" AND B.USE_YN = 'Y'                         \n"); 
			sbSql.append(" AND  (B.CODE LIKE '" + in_cd + "'||'%'     \n"); 
			sbSql.append("   OR  B.CODE_NAME LIKE '%'||'" + in_cdnm + "'||'%')\n"); 
			if(!in_cbotype.equals("non"))
			{
				sbSql.append(" )              								\n"); 
				sbSql.append(" ORDER BY GROUP_CODE ,SORT_SEQ               	\n"); 				
			}
			else
			{
				sbSql.append(" ORDER BY GROUP_CODE ,SORT_SEQ               	\n"); 
			}
						
			//System.out.println(sbSql.toString());
			//pstmt = conn.prepareStatement(sbSql.toString());
			//rs = pstmt.executeQuery();
			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sbSql.toString()); 			
			
			DataSet gds_common_code = this.makeDataSet(rs,"gds_common_code");
			out_dl.add(gds_common_code);
			this.setResultMessage(0, "OK",out_vl);
			
//	Log Write 
			//String fileUrl = "C:/tomcat-4.1/webapps/hwfs/hwfs_svc/log/KOO.log";
			//tit.util.FileLog.println(fileUrl, "sql=====>"+sbSql.toString());	
		}
	
	} catch(Exception ex) {
		//jsp 로그남기기
		//logger.debug(ex.getMessage(), ex);	
		ex.printStackTrace();
        this.setResultMessage(-1, ex.getMessage(),out_vl);
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
		//try {
		//	logger.endIndividualLog();
		//} catch( Exception logE) {
		//	logE.printStackTrace();
		//}		
	}
    proc_output(response,out,out_vl,out_dl);
%>