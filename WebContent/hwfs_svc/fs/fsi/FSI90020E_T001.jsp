<%@page import="com.sz.service.sqlmap.SqlMapFactoryHelper"%>
<%@page import="com.sz.service.sqlmap.SqlRequest"%>
<%@page import="com.sz.ui.xplatform.DataSetUtility"%>
<%@page import="com.sz.util.AppDataUtility"%>
<%@page import="com.sz.service.sqlmap.SqlExecutor"%>
<%@page import="com.sz.*"%> 

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;

	try {
		
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));	
		
		String g_EmpNo 		      = in_vl.getString("g_EmpNo");
		DataSet ds_cond           = in_dl.get("ds_cond");
		DataSet ds_sourceItemList = in_dl.get("ds_sourceItemList");	// ���� �� ����
		DataSet ds_targetItemList = in_dl.get("ds_targetItemList"); // ���� �� ����
		DataSet ds_recipeList     = in_dl.get("ds_recipeList");     // ������ ������
		
		conn.setAutoCommit(false);
	
		int sourceItemCnt = ds_sourceItemList.getRowCount();
		int targetItemCnt = ds_targetItemList.getRowCount();
		int recipeCnt     = ds_recipeList.getRowCount();
		int idx = 1;
		
		//sql�� ���ۻ��� 
		StringBuffer sbSql = new StringBuffer();
		//System.out.println("������ : " + ds_targetItemList.getString(0, "ITEM_CODE"));
		
		// �����ڵ�
		String UPJANG = nullToBlank(ds_cond.getString(0, "UPJANG"));
		
		// ���� �� �����ڵ�
		String TARGET_ITEM_CODE       = nullToBlank(ds_targetItemList.getString(0, "ITEM_CODE"));
		String TARGET_ITEM_NAME       = nullToBlank(ds_targetItemList.getString(0, "ITEM_NAME"));
		String TARGET_ITEM_SIZE       = nullToBlank(ds_targetItemList.getString(0, "ITEM_SIZE"));
		String TARGET_KG_CONVERT_RATE = nullToBlank(ds_targetItemList.getString(0, "KG_CONVERT_RATE"));
		String TARGET_ITEM_PRICE      = nullToBlank(ds_targetItemList.getString(0, "ITEM_PRICE"));
		String TARGET_G_ITEM_PRICE    = nullToBlank(ds_targetItemList.getString(0, "G_ITEM_PRICE"));
		
		TARGET_ITEM_NAME = TARGET_ITEM_NAME.replaceAll("'", "''");
		TARGET_ITEM_SIZE = TARGET_ITEM_SIZE.replaceAll("'", "''");
		
		// ���� �� ���簡 1�� �̻��� ��� ��ü �����Ǹ� ������� ����ó�� �Ѵ�.
		if (sourceItemCnt > 1) {
			for(int i=0; i<sourceItemCnt; i++) {
				
				String SOURCE_ITEM_CODE       = nullToBlank(ds_sourceItemList.getString(i, "ITEM_CODE"));
				String SOURCE_ITEM_NAME       = nullToBlank(ds_sourceItemList.getString(i, "ITEM_NAME"));
				String SOURCE_ITEM_SIZE       = nullToBlank(ds_sourceItemList.getString(i, "ITEM_SIZE"));
				String SOURCE_KG_CONVERT_RATE = nullToBlank(ds_sourceItemList.getString(i, "KG_CONVERT_RATE"));
				String SOURCE_ITEM_PRICE      = nullToBlank(ds_sourceItemList.getString(i, "ITEM_PRICE"));
				String SOURCE_G_ITEM_PRICE    = nullToBlank(ds_sourceItemList.getString(i, "G_ITEM_PRICE"));
				
				SOURCE_ITEM_NAME = SOURCE_ITEM_NAME.replaceAll("'", "''");
				SOURCE_ITEM_SIZE = SOURCE_ITEM_SIZE.replaceAll("'", "''");
				
				//System.out.println("������ : " + SOURCE_ITEM_CODE);

				// ���� ����
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSR_UPJANG_RECIPE_ITEM                                              \n");
				sbSql.append("   SET ITEM_CODE = ?                             \n");
				sbSql.append("     , ATTR06    = 2                                                       \n");
				sbSql.append("     , UUSER     = ?                                       \n");
				sbSql.append("     , UDATE     = SYSDATE                                                 \n");
				sbSql.append(" WHERE ITEM_CODE = ?                              \n");
				sbSql.append("   AND UPJANG    = ?                                       \n");
				sbSql.append("   AND RECIPE_CD NOT IN (SELECT RECIPE_CD                                  \n");
				sbSql.append("                           FROM FSR_UPJANG_RECIPE_ITEM                     \n");
				sbSql.append("                          WHERE ITEM_CODE = ?     \n");
				sbSql.append("                            AND UPJANG = ?                  \n");				
				sbSql.append("                        )                                                  \n");
				
				//���� ���ε�������� ���� �ӵ����� 20180921 ��ȣ��
				idx = 1;
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setString(idx++, TARGET_ITEM_CODE);
				pstmt.setString(idx++, g_EmpNo);		
				pstmt.setString(idx++, SOURCE_ITEM_CODE);
				pstmt.setString(idx++, UPJANG);
				pstmt.setString(idx++, TARGET_ITEM_CODE);
				pstmt.setString(idx++, UPJANG);
						
				rs = pstmt.executeQuery();
				rs.close();
				pstmt.close();
				
				//stmt = conn.createStatement();
				//stmt.execute(sbSql.toString());
				//stmt.close();
				
				// �α� ����
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSI_CHG_LOG                                          \n"); 
				sbSql.append("SET    B_ITEM_NAME       = ?				 \n");
				sbSql.append(",      B_ITEM_SIZE       = ?				 \n");
				sbSql.append(",      B_KG_CONVERT_RATE = ?				 \n");
				sbSql.append(",      B_ITEM_PRICE      = ?				 \n");
				sbSql.append(",      B_G_ITEM_PRICE    = ?				 \n");
				sbSql.append(",      A_ITEM_NAME       = ?				 \n");
				sbSql.append(",      A_ITEM_SIZE       = ?				 \n");
				sbSql.append(",      A_KG_CONVERT_RATE = ?				 \n");
				sbSql.append(",      A_ITEM_PRICE      = ?				 \n");
				sbSql.append(",      A_G_ITEM_PRICE    = ?				 \n");
				sbSql.append("WHERE  WORK_TYPE   = 'U'				                      \n");
				sbSql.append("AND    CHG_DATE    = TO_CHAR(SYSDATE,'YYYYMMDD')            \n");
				sbSql.append("AND    UPJANG      = ?                      \n");
				sbSql.append("AND    B_ITEM_CODE = ?             \n");
				sbSql.append("AND    A_ITEM_CODE = ?             \n");
				sbSql.append("AND    SABUN       = ?                      \n");
				
				//���� ���ε�������� ���� �ӵ����� 20180921 ��ȣ��
				idx = 1;
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setString(idx++, SOURCE_ITEM_NAME);
				pstmt.setString(idx++, SOURCE_ITEM_SIZE);		
				pstmt.setString(idx++, SOURCE_KG_CONVERT_RATE);
				pstmt.setString(idx++, SOURCE_ITEM_PRICE);
				pstmt.setString(idx++, SOURCE_G_ITEM_PRICE);
				pstmt.setString(idx++, TARGET_ITEM_NAME);
				pstmt.setString(idx++, TARGET_ITEM_SIZE);
				pstmt.setString(idx++, TARGET_KG_CONVERT_RATE);
				pstmt.setString(idx++, TARGET_ITEM_PRICE);
				pstmt.setString(idx++, TARGET_G_ITEM_PRICE);
				pstmt.setString(idx++, UPJANG);
				pstmt.setString(idx++, SOURCE_ITEM_CODE);
				pstmt.setString(idx++, TARGET_ITEM_CODE);
				pstmt.setString(idx++, g_EmpNo);
						
				rs = pstmt.executeQuery();
				rs.close();
				pstmt.close();
				
				//stmt = conn.createStatement();
				//stmt.execute(sbSql.toString());
				//stmt.close();
			}
			
		// ���� �� ���簡 1���� ��� ���õ� �����Ǹ� ������� ����ó�� �Ѵ�.
		} else {
			String SOURCE_ITEM_CODE       = nullToBlank(ds_sourceItemList.getString(0, "ITEM_CODE"));
			String SOURCE_ITEM_NAME       = nullToBlank(ds_sourceItemList.getString(0, "ITEM_NAME"));
			String SOURCE_ITEM_SIZE       = nullToBlank(ds_sourceItemList.getString(0, "ITEM_SIZE"));
			String SOURCE_KG_CONVERT_RATE = nullToBlank(ds_sourceItemList.getString(0, "KG_CONVERT_RATE"));
			String SOURCE_ITEM_PRICE      = nullToBlank(ds_sourceItemList.getString(0, "ITEM_PRICE"));
			String SOURCE_G_ITEM_PRICE    = nullToBlank(ds_sourceItemList.getString(0, "G_ITEM_PRICE"));
			
			SOURCE_ITEM_NAME = SOURCE_ITEM_NAME.replaceAll("'", "''");
			SOURCE_ITEM_SIZE = SOURCE_ITEM_SIZE.replaceAll("'", "''");
			
			for(int i=0; i<recipeCnt; i++) {
				String RECIPE_CD = nullToBlank(ds_recipeList.getString(i, "RECIPE_CD"));
				String RECIPE_CLASS = nullToBlank(ds_recipeList.getString(i, "RECIPE_CLASS"));
				String HALL_CLASS = nullToBlank(ds_recipeList.getString(i, "HALL_CLASS"));
				//System.out.println("������ ������ : " + RECIPE_CD);

				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSR_UPJANG_RECIPE_ITEM                                                    \n");
				sbSql.append("   SET ITEM_CODE = ?                                				     \n");
				sbSql.append("     , ATTR06    = 2                                                             \n");
				sbSql.append("     , UUSER     = ?                                		             \n");
				sbSql.append("     , UDATE     = SYSDATE                                                       \n");
				sbSql.append(" WHERE ITEM_CODE = ?                                  				 \n");
				sbSql.append("   AND UPJANG    = ?                                    		         \n");
				sbSql.append("   AND RECIPE_CD = ?                                  		         \n");
				sbSql.append("   AND RECIPE_CD NOT IN (SELECT RECIPE_CD                                        \n");
				sbSql.append("                           FROM FSR_UPJANG_RECIPE_ITEM                           \n");
				sbSql.append("                          WHERE ITEM_CODE = ?          				 \n");
				sbSql.append("                            AND UPJANG = ?                 		     \n");
				sbSql.append("                            AND SUBSTR(RECIPE_CD, 1, 1) = ?			 \n");
				sbSql.append("                            AND HALL_CLASS = ?		                 \n");
				sbSql.append("                        )                                                        \n");

				System.out.println(sbSql.toString());
				
				//���� ���ε�������� ���� �ӵ����� 20180921 ��ȣ��
				idx = 1;
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setString(idx++, TARGET_ITEM_CODE);
				pstmt.setString(idx++, g_EmpNo);		
				pstmt.setString(idx++, SOURCE_ITEM_CODE);
				pstmt.setString(idx++, UPJANG);
				pstmt.setString(idx++, RECIPE_CD);
				pstmt.setString(idx++, TARGET_ITEM_CODE);
				pstmt.setString(idx++, UPJANG);
				pstmt.setString(idx++, RECIPE_CLASS);
				pstmt.setString(idx++, HALL_CLASS);
						
				rs = pstmt.executeQuery();
				rs.close();
				pstmt.close();
				
				// �α� ����
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSI_CHG_LOG                                          \n");
				sbSql.append("SET    B_ITEM_NAME       = ?				 \n");
				sbSql.append(",      B_ITEM_SIZE       = ?				 \n");
				sbSql.append(",      B_KG_CONVERT_RATE = ?				 \n");
				sbSql.append(",      B_ITEM_PRICE      = ?				 \n");
				sbSql.append(",      B_G_ITEM_PRICE    = ?				 \n");
				sbSql.append(",      A_ITEM_NAME       = ?				 \n");
				sbSql.append(",      A_ITEM_SIZE       = ?				 \n");
				sbSql.append(",      A_KG_CONVERT_RATE = ?				 \n");
				sbSql.append(",      A_ITEM_PRICE      = ?				 \n");
				sbSql.append(",      A_G_ITEM_PRICE    = ?				 \n");
				sbSql.append("WHERE  WORK_TYPE   = 'U'				                      \n");
				sbSql.append("AND    CHG_DATE    = TO_CHAR(SYSDATE,'YYYYMMDD')            \n");
				sbSql.append("AND    UPJANG      = ?                      \n");
				sbSql.append("AND    B_ITEM_CODE = ?          			  \n");
				sbSql.append("AND    A_ITEM_CODE = ?           			  \n");
				sbSql.append("AND    SABUN       = ?                      \n");

				//���� ���ε�������� ���� �ӵ����� 20180921 ��ȣ��
				idx = 1;
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setString(idx++, SOURCE_ITEM_NAME);
				pstmt.setString(idx++, SOURCE_ITEM_SIZE);		
				pstmt.setString(idx++, SOURCE_KG_CONVERT_RATE);
				pstmt.setString(idx++, SOURCE_ITEM_PRICE);
				pstmt.setString(idx++, SOURCE_G_ITEM_PRICE);
				pstmt.setString(idx++, TARGET_ITEM_NAME);
				pstmt.setString(idx++, TARGET_ITEM_SIZE);
				pstmt.setString(idx++, TARGET_KG_CONVERT_RATE);
				pstmt.setString(idx++, TARGET_ITEM_PRICE);
				pstmt.setString(idx++, TARGET_G_ITEM_PRICE);
				pstmt.setString(idx++, UPJANG);
				pstmt.setString(idx++, SOURCE_ITEM_CODE);
				pstmt.setString(idx++, TARGET_ITEM_CODE);
				pstmt.setString(idx++, g_EmpNo);
						
				rs = pstmt.executeQuery();
				rs.close();
				pstmt.close();
				
			}
		}
		
		conn.commit();
		
		this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
		
		//jsp �α׳����
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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}				
	}
	proc_output(response,out,out_vl,out_dl);
%>		