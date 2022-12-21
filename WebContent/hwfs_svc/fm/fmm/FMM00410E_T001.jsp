<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		// [�Ĵܺ���]
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
		
		DataSet ds_input  	= in_dl.get("ds_input");
		DataSet ds_list  	= in_dl.get("ds_list");
		DataSet ds_Result  	= in_dl.get("ds_Result");
		DataSet ds_ResultDt = in_dl.get("ds_ResultDt");
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		String v_SaveType 	= in_vl.getString("SaveType");				// 0 : �������� 1:�Ⱓ����
		String v_MenuClass	= in_vl.getString("fa_MENU_CLASS");
		String v_CostType	= in_vl.getString("fa_COST_TYPE");
		String v_MenuType	= in_vl.getString("fa_MENU_TYPE");
		String v_Meal  		= in_vl.getString("fa_MEAL");
		
	
		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();
		
		int nARow,RowCnt,nARow2,nCnt;
		String strUpjang,strHallCD,strMenuCD;
		String v_CopyType,v_Menudate,v_Corner,v_MenuCD,v_Dt;
		
		strUpjang = ds_input.getString(0,"UPJANG");
		strHallCD = ds_input.getString(0,"HALL_CD");
		
		// strCopyGubun : 1 - ����ǥ��, 2 - ��õ�Ĵ� COMBO ����

		if (v_SaveType.equals("1"))	// �Ⱓ������ ��� ����Ʈ�� ��ȸ�Ѵ�.
		{
			
			String strCopyGubun 	= in_vl.getString("strCopyGubun");
			ds_list.clear();
			
			if (strCopyGubun.equals("0"))		// 0 : �����Ĵ�
			{
				String strMeal,strCorner,strFromDt,strToDt;
				
				strMeal 	= ds_input.getString(0,"MEAL1");
				strCorner 	= ds_input.getString(0,"CORNER1");
				strFromDt 	= ds_input.getString(0,"MENU_F_DATE1");
				strToDt 	= ds_input.getString(0,"MENU_T_DATE1");
				
				v_Corner  	= in_vl.getString("CORNER");
				v_Dt		= in_vl.getString("D_DT");
				
				sbSelSql.delete(0, sbSelSql.length());                                                             
				sbSelSql.append("-- �����Ĵ�   �Ⱓ���縮��                                                             			 						\n");
				sbSelSql.append("SELECT UPJANG                                                                			\n");
				sbSelSql.append("       , MENU_CD                                                             			\n");
				sbSelSql.append("       , TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + ",'yyyymmdd') AS MENU_DATE \n");
				sbSelSql.append("       , '" + v_Meal + "' AS MEAL                                                      \n");
				sbSelSql.append("       , '" + v_Corner + "' AS CORNER                                               	\n");
				sbSelSql.append("       , '" + strCopyGubun + "' AS COPY_TYPE                                           \n");
				sbSelSql.append("  FROM FSM_REAL_MENU_MST                                                     			\n");
				sbSelSql.append(" WHERE UPJANG = " + strUpjang + "        --�����                                      						\n");
				sbSelSql.append("   AND HALL_CD = '" + strHallCD + "'      --�Ĵ��ڵ�                                     					\n");
				sbSelSql.append("   AND MENU_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' --�Ⱓ                    		\n");
				sbSelSql.append("   AND MEAL = '" + strMeal + "'      --����                                              						\n");
				sbSelSql.append("   AND CORNER = '" + strCorner + "'    --�ڳ�                                              					\n");
				sbSelSql.append("ORDER BY  MENU_DATE                                                  					\n");

				System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());		
				rs = pstmt.executeQuery(); 
				ds_list = this.makeDataSet(rs,"ds_list");
				
				rs.close();
				pstmt.close();
			}
			else								// 2 : �Ⱓǥ�ؽĴ�
			{
				String strMenuClass,strCostType,strMenuType,strMeal,strCorner,strFromDt,strToDt;
				
				strMenuClass 	= ds_input.getString(0,"MENU_CLASS");
				strCostType 	= ds_input.getString(0,"COST_TYPE");
				strMenuType 	= ds_input.getString(0,"MENU_TYPE");
				strMeal 	= ds_input.getString(0,"MEAL2");
				strCorner 	= ds_input.getString(0,"CORNER2");
				strFromDt 	= ds_input.getString(0,"MENU_F_DATE2");
				strToDt 	= ds_input.getString(0,"MENU_T_DATE2");
				
				v_Corner  	= in_vl.getString("CORNER");
				v_Dt		= in_vl.getString("D_DT");
				
				sbSelSql.delete(0, sbSelSql.length());                                                             
				sbSelSql.append("-- �Ⱓǥ�ؽĴ�     �Ⱓ���縮��                                                          									\n");
				sbSelSql.append("SELECT '' AS UPJANG                                                         			\n");
				sbSelSql.append("       , TERM_MENU_CD AS MENU_CD                                            			\n");
				sbSelSql.append("       , TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + ",'yyyymmdd') AS MENU_DATE	\n");
				sbSelSql.append("       , '" + v_Meal + "' AS MEAL                                                      \n");
				sbSelSql.append("       , '" + v_Corner + "' AS CORNER                                                	\n");
				sbSelSql.append("       , '" + strCopyGubun + "' AS COPY_TYPE                                           \n");
				sbSelSql.append("  FROM FMM_TERM_MENU_MST                                                    			\n");
				sbSelSql.append(" WHERE 1=1									                                           	\n");
				if(strMenuClass != null){
				sbSelSql.append("   AND MENU_CLASS= '" + strMenuClass + "'                                           	\n");
				}
				sbSelSql.append("   AND COST_TYPE = '" + strCostType + "'                                            	\n");
				sbSelSql.append("   AND MENU_TYPE = '" + strMenuType + "'                                           	\n");
				sbSelSql.append("   AND MEAL = '" + strMeal + "'                                                    	\n");
				sbSelSql.append("   AND CORNER = '" + strCorner + "'                                                  	\n");
				sbSelSql.append("   AND MENU_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "'                  	\n");
				sbSelSql.append("ORDER BY  MENU_DATE                                                  					\n");
				
				System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());		
				rs = pstmt.executeQuery(); 
				ds_list = this.makeDataSet(rs,"ds_list");
				
				rs.close();
				pstmt.close();
			}
		}
		
		RowCnt = ds_list.getRowCount();
		nARow = 0;
		nARow2 = 0;
		
		for ( int i = 0 ; i < RowCnt ; i++ )
		{	
			v_CopyType 	= ds_list.getString(i,"COPY_TYPE");		
			v_Menudate	= ds_list.getString(i,"MENU_DATE");
			v_Corner  	= ds_list.getString(i,"CORNER");
			strMenuCD	= ds_list.getString(i,"MENU_CD");
				
			// 1.1 ���� ������ ��� ���̺� �Ĵ��� �ִ��� üũ
			//   COUNT(*) <= 0�� ��� INSERT 
			sbSelSql.delete(0, sbSelSql.length());
			sbSelSql.append("SELECT  TERM_MENU_CD          					\n");
			sbSelSql.append("FROM    FMM_TERM_MENU_MST     					\n");
			sbSelSql.append("WHERE   MENU_DATE = '" + v_Menudate + "'		\n");
			sbSelSql.append("AND     MENU_CLASS = '" + v_MenuClass + "'		\n");
			sbSelSql.append("AND     COST_TYPE = '" + v_CostType + "'		\n");
			sbSelSql.append("AND     MENU_TYPE = '" + v_MenuType + "'		\n");
			sbSelSql.append("AND     MEAL = '" + v_Meal + "'				\n");
			sbSelSql.append("AND     CORNER = '" + v_Corner + "'			\n");
			                 
			//System.out.println(sbSelSql.toString());
			pstmt = conn.prepareStatement(sbSelSql.toString());
			rs = pstmt.executeQuery(); 		
			
			if(rs.next())	// �޴��� �ִ°��
			{
				int numSum = Integer.parseInt(v_MenuClass)*10 + Integer.parseInt(v_CostType);
				v_MenuCD		= v_Menudate + '0' +  numSum;
				
				//v_MenuCD = v_Menudate + v_CostType;
				
				rs.close();
				pstmt.close();
			}
			else
			{
				rs.close();
				pstmt.close();
				
				// 1.2 �Ĵ��� ���� ��� �Ĵ� INSERT
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT  '" + v_Menudate + "' || NVL(DECODE(LENGTH(MAX(SUBSTR(TERM_MENU_CD,9,3)+1)),1,'00',2,'0') || MAX(SUBSTR(TERM_MENU_CD,9,3)+1),'001') AS TERM_MENU_CD	\n");
				sbSelSql.append("FROM    FMM_TERM_MENU_MST                                                                                                                       			\n");
				sbSelSql.append("WHERE   SUBSTR(TERM_MENU_CD,0,8) = '" + v_Menudate + "'                                                                                                   	\n");
				
				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery();
				rs.next();
				int numSum = Integer.parseInt(v_MenuClass)*10 + Integer.parseInt(v_CostType);
				v_MenuCD   = v_Menudate + '0' +numSum;
				//v_MenuCD = v_Menudate + v_CostType;
				
				rs.close();
				pstmt.close();
				
				// 2. �Ⱓǥ�ؽĴ� ���� INSERT
				sbInsSql.delete(0, sbInsSql.length());
				sbInsSql.append("INSERT INTO FMM_TERM_MENU_MST 				\n");
				sbInsSql.append("(             								\n");
				sbInsSql.append("	 TERM_MENU_CD              				\n");
				sbInsSql.append("	, MENU_DESC                				\n");
				sbInsSql.append("	, MENU_DATE                				\n");
				sbInsSql.append("	, MENU_CLASS               				\n");
				sbInsSql.append("	, COST_TYPE								\n");
				sbInsSql.append("	, MENU_TYPE								\n");
				sbInsSql.append("	, MEAL                     				\n");
				sbInsSql.append("	, CORNER                   				\n");
				sbInsSql.append("	, START_DATE               				\n");
				sbInsSql.append("	, END_DATE                 				\n");
				sbInsSql.append("	, USE_YN                   				\n");
				sbInsSql.append("	, ATTR01, ATTR02, ATTR03, ATTR04, ATTR05\n");
				sbInsSql.append("	, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10\n");
				sbInsSql.append("	, CUSER                    				\n");
				sbInsSql.append("	, CDATE                    				\n");
				sbInsSql.append("	, UUSER                    				\n");
				sbInsSql.append("	, UDATE                    				\n");
				sbInsSql.append(" ) VALUES (                   				\n");
				sbInsSql.append("	 '" + v_MenuCD + "' --#TERM_MENU_CD#	\n");
				sbInsSql.append("	, '' --#MENU_DESC#              		\n");
				sbInsSql.append("	, '" + v_Menudate + "' --#MENU_DATE#  	\n");
				sbInsSql.append("	, '" + v_MenuClass + "' --#MENU_CLASS#	\n");
				sbInsSql.append("	, '" + v_CostType + "' --#COST_TYPE#  	\n");
				sbInsSql.append("	, '" + v_MenuType + "' --#MENU_TYPE#  	\n");
				sbInsSql.append("	, '" + v_Meal + "' --#MEAL#				\n");
				sbInsSql.append("	, '" + v_Corner + "' --#CORNER#			\n");
				sbInsSql.append("	, '' --#START_DATE#             		\n");
				sbInsSql.append("	, '' --#END_DATE#               		\n");
				sbInsSql.append("	, 'Y' --#USE_YN#                 		\n");
				sbInsSql.append("	, '', '', '', '', ''					\n");
				sbInsSql.append("	, '', '', '', '', ''					\n");
				sbInsSql.append("	, '" + g_EmpNo + "'                   	\n");
				sbInsSql.append("	, SYSDATE                  				\n");
				sbInsSql.append("	, '" + g_EmpNo + "'                   	\n");
				sbInsSql.append("	, SYSDATE                  				\n");
				sbInsSql.append(")      									\n");  
			               
				//System.out.println(sbInsSql.toString());
				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
			}
				
			if (v_CopyType.equals("0"))		// 0 : �����Ĵ�
			{
				// 2.0  ���� ������ ��� ���̺� ���ۼ��� �����ǰ� �ִ��� Ȯ���Ѵ�.
				//   COUNT(*) > 0�� �����󿡼� ���ܵȴ�. 
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT COUNT(*) AS CNT						\n");
				sbSelSql.append("  FROM FMM_TERM_MENU_RECIPE 				\n");
				sbSelSql.append(" WHERE TERM_MENU_CD = '" + v_MenuCD + "' 		\n");
				
				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery(); 
				rs.next();
				nCnt	= rs.getInt("CNT");
				
				rs.close();
				pstmt.close();
				
				if (nCnt > 0 )
				{
					//System.out.println(" v_Menudate : " + v_Menudate + " nARow2 : " + nARow2);
					ds_ResultDt.newRow(nARow2);
					ds_ResultDt.set(nARow2,"MENU_DATE",v_Menudate);
					ds_ResultDt.set(nARow2,"MSG","������ �ۼ��� �Ĵ��� �ֽ��ϴ�.");
					nARow2 = nARow2 + 1;
				}
				else
				{
					// 4. �ߺ�������
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("-- 3. ������ �ߺ�(�����)                                                                                     		\n");
					sbSelSql.append("SELECT                                                                                                             \n");
					sbSelSql.append("      A.MENU_DATE       --������                                                                                	\n");
					sbSelSql.append("      ,A.MENU_CLASS                                                                                            	\n");
					sbSelSql.append("      ,A.COST_TYPE                                                                                             	\n");
					sbSelSql.append("      ,A.MENU_TYPE                                                                                              	\n");
					sbSelSql.append("      ,A.MEAL                                                                                                      \n");
					sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --�ڳʸ�\n");
					sbSelSql.append("      ,B.RECIPE_CD                                                                                                 \n");
					sbSelSql.append("      ,(SELECT RECIPE_NAME FROM FMR_STD_RECIPE_MST WHERE RECIPE_CD = B.RECIPE_CD) RECIPE_NAME                      \n");
					sbSelSql.append("  FROM FMM_TERM_MENU_MST A                                                                                         \n");
					sbSelSql.append("      ,FMM_TERM_MENU_RECIPE B                                                                                      \n");
					sbSelSql.append(" WHERE A.TERM_MENU_CD = B.TERM_MENU_CD                                                                          	\n");
					sbSelSql.append("   AND A.TERM_MENU_CD = '" + v_MenuCD + "' --�� 1������ �ҷ��� MENU_CD                                       		\n");
					sbSelSql.append("   AND EXISTS (                                                                                                    \n");
					sbSelSql.append("                SELECT 1                                                                                           \n");
					sbSelSql.append("                  FROM FSM_REAL_RECIPE_MST C                                                                  		\n");
					sbSelSql.append("                 WHERE C.UPJANG = " + strUpjang + "  -- ����� ����� �����                                  		\n");
					sbSelSql.append("                   AND C.MENU_CD = '" + strMenuCD + "'  -- ����� ���õ� MENU_CD                                   \n");
					sbSelSql.append("                   AND C.RECIPE_CD = B.RECIPE_CD                                                                   \n");
					sbSelSql.append("               )                                                                                                   \n");
					
					//System.out.println(sbSelSql.toString());
					pstmt = conn.prepareStatement(sbSelSql.toString());
					rs = pstmt.executeQuery();
					
					while(rs.next()) 
					{ 
						ds_Result.newRow(nARow);
						ds_Result.set(nARow,"MENU_DATE",rs.getString("MENU_DATE"));
						ds_Result.set(nARow,"CORNER_NAME",rs.getString("CORNER_NAME"));
						ds_Result.set(nARow,"RECIPE_CD",rs.getString("RECIPE_CD"));
						ds_Result.set(nARow,"RECIPE_NAME",rs.getString("RECIPE_NAME"));
						
						nARow = nARow + 1;
					}
					
					rs.close();
					pstmt.close();
					
					//  3. �����Ǻ���	
					sbInsSql.delete(0, sbInsSql.length());
					sbInsSql.append("-- 2. ������ ����(�����)                                                                   	\n");
					sbInsSql.append("INSERT INTO FMM_TERM_MENU_RECIPE(                                                           	\n");
					sbInsSql.append("	 TERM_MENU_CD                                                                            	\n");
					sbInsSql.append("	, RECIPE_CD                                                                              	\n");
					sbInsSql.append("	, DISH_INFO                                                                              	\n");
					sbInsSql.append("    , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05                                                	\n");
					sbInsSql.append("	, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10                                                 	\n");
					sbInsSql.append("	, CUSER                                                                                  	\n");
					sbInsSql.append("	, CDATE                                                                                  	\n");
					sbInsSql.append("	, UUSER                                                                                  	\n");
					sbInsSql.append("	, UDATE                                                                                  	\n");
					sbInsSql.append("	, RECIPE_SEQ                                                                             	\n");
					sbInsSql.append(" )                                                                                          	\n");
					sbInsSql.append("SELECT '" + v_MenuCD + "' TERM_MENU_CD                                                      	\n");
					sbInsSql.append("       , RECIPE_CD                                                                          	\n");
					sbInsSql.append("       , '' DISH_INFO                                                                       	\n");
					sbInsSql.append("       , '' ATTR01, '' ATTR02, '' ATTR03, '' ATTR04, '' ATTR05                              	\n");
					sbInsSql.append("       , '' ATTR06, '' ATTR07, '' ATTR08, '' ATTR09, '' ATTR10                              	\n");
					sbInsSql.append("       , '" + g_EmpNo + "' CUSER                                                            	\n");
					sbInsSql.append("       , SYSDATE CDATE                                                                      	\n");
					sbInsSql.append("       , '" + g_EmpNo + "' UUSER                                                           	\n");
					sbInsSql.append("       , SYSDATE UDATE                                                                      	\n");
					sbInsSql.append("       , RECIPE_SEQ                                                                         	\n");
					sbInsSql.append("  FROM FSM_REAL_RECIPE_MST A                                                             		\n");
					sbInsSql.append(" WHERE UPJANG = " + strUpjang + "                                                           	\n");
					sbInsSql.append("   AND MENU_CD = '" + strMenuCD + "'                                                        	\n");
	                sbInsSql.append("   AND NOT EXISTS (                                                                         	\n");            
	                sbInsSql.append("               SELECT 1                                                                     	\n");             
	                sbInsSql.append("                 FROM FMM_TERM_MENU_RECIPE B                                                	\n");
					sbInsSql.append("                WHERE B.TERM_MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD		\n");	
					sbInsSql.append("                  AND B.RECIPE_CD = A.RECIPE_CD                                             	\n");
					sbInsSql.append("               )                                                                            	\n");
					
					//System.out.println(sbInsSql.toString());
					stmt 		=  conn.createStatement();
					stmt.execute(sbInsSql.toString());
					stmt.close();
				}
			}
			else if (v_CopyType.equals("1"))	// 1 : ����ǥ�ؽĴ�
			{
				// 2.0  ���� ������ ��� ���̺� ���ۼ��� �����ǰ� �ִ��� Ȯ���Ѵ�.
				//   COUNT(*) > 0�� �����󿡼� ���ܵȴ�. 
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT COUNT(*) AS CNT						\n");
				sbSelSql.append("  FROM FMM_TERM_MENU_RECIPE 				\n");
				sbSelSql.append(" WHERE TERM_MENU_CD = '" + v_MenuCD + "' 		\n");
				
				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery(); 
				rs.next();
				nCnt	= rs.getInt("CNT");
				
				rs.close();
				pstmt.close();
				
				if (nCnt > 0 )
				{
					//System.out.println(" v_Menudate : " + v_Menudate + " nARow2 : " + nARow2);
					ds_ResultDt.newRow(nARow2);
					ds_ResultDt.set(nARow2,"MENU_DATE",v_Menudate);
					ds_ResultDt.set(nARow2,"MSG","������ �ۼ��� �Ĵ��� �ֽ��ϴ�.");
					nARow2 = nARow2 + 1;
				}
				else
				{
					// 4. �ߺ�������
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("-- 3. ������ �ߺ�(�����)                                                                                     		\n");
					sbSelSql.append("SELECT                                                                                                             \n");
					sbSelSql.append("      A.MENU_DATE       --������                                                                                   \n");
					sbSelSql.append("      ,A.MENU_CLASS                                                                                                \n");
					sbSelSql.append("      ,A.COST_TYPE                                                                                                 \n");
					sbSelSql.append("      ,A.MENU_TYPE                                                                                                 \n");
					sbSelSql.append("      ,A.MEAL                                                                                                      \n");
					sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --�ڳʸ�\n");
					sbSelSql.append("      ,B.RECIPE_CD                                                                                                 \n");
					sbSelSql.append("      ,(SELECT RECIPE_NAME FROM FMR_STD_RECIPE_MST WHERE RECIPE_CD = B.RECIPE_CD) RECIPE_NAME                      \n");
					sbSelSql.append("  FROM FMM_TERM_MENU_MST A                                                                                         \n");
					sbSelSql.append("      ,FMM_TERM_MENU_RECIPE B                                                                                      \n");
					sbSelSql.append(" WHERE A.TERM_MENU_CD = B.TERM_MENU_CD                                                                             \n");
					sbSelSql.append("   AND A.TERM_MENU_CD = '" + v_MenuCD + "' --�� 1������ �ҷ��� MENU_CD                                         	\n");
					sbSelSql.append("   AND EXISTS (                                                                                                    \n");
					sbSelSql.append("                SELECT 1                                                                                           \n");
					sbSelSql.append("                  FROM FMM_SINGLE_MENU_RECIPE C                                                                    \n");
					sbSelSql.append("                 WHERE C.SINGLE_MENU_CD = '" + strMenuCD + "'  -- ����� ���õ� MENU_CD                  			\n");
					sbSelSql.append("                   AND C.RECIPE_CD = B.RECIPE_CD                                                                   \n");
					sbSelSql.append("               )                                                                                                   \n");
					
					//System.out.println(sbSelSql.toString());
					pstmt = conn.prepareStatement(sbSelSql.toString());
					rs = pstmt.executeQuery();
					
					while(rs.next()) 
					{ 
						ds_Result.newRow(nARow);
						ds_Result.set(nARow,"MENU_DATE",rs.getString("MENU_DATE"));
						ds_Result.set(nARow,"CORNER_NAME",rs.getString("CORNER_NAME"));
						ds_Result.set(nARow,"RECIPE_CD",rs.getString("RECIPE_CD"));
						ds_Result.set(nARow,"RECIPE_NAME",rs.getString("RECIPE_NAME"));
						
						nARow = nARow + 1;
					}
					
					rs.close();
					pstmt.close();
					
					//  3. �����Ǻ���	
					sbInsSql.delete(0, sbInsSql.length());
					sbInsSql.append("-- 2. ������ ����(ǥ��)                                                                \n");
					sbInsSql.append("INSERT INTO FMM_TERM_MENU_RECIPE(                                                      \n");
					sbInsSql.append("	 TERM_MENU_CD                                                                       \n");
					sbInsSql.append("	, RECIPE_CD                                                                         \n");
					sbInsSql.append("	, DISH_INFO                                                                         \n");
					sbInsSql.append("    , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05                                           \n");
					sbInsSql.append("	, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10                                            \n");
					sbInsSql.append("	, CUSER                                                                             \n");
					sbInsSql.append("	, CDATE                                                                             \n");
					sbInsSql.append("	, UUSER                                                                             \n");
					sbInsSql.append("	, UDATE                                                                             \n");
					sbInsSql.append("	, RECIPE_SEQ                                                                        \n");
					sbInsSql.append(" )                                                                                     \n");
					sbInsSql.append("SELECT '" + v_MenuCD + "' TERM_MENU_CD                                                                 \n");
					sbInsSql.append("       , RECIPE_CD                                                                     \n");
					sbInsSql.append("       , '' DISH_INFO                                                                  \n");
					sbInsSql.append("       , '' ATTR01, '' ATTR02, '' ATTR03, '' ATTR04, '' ATTR05                         \n");
					sbInsSql.append("       , '' ATTR06, '' ATTR07, '' ATTR08, '' ATTR09, '' ATTR10                         \n");
					sbInsSql.append("       , '" + g_EmpNo + "' CUSER                                                       \n");
					sbInsSql.append("       , SYSDATE CDATE                                                                 \n");
					sbInsSql.append("       , '" + g_EmpNo + "' UUSER                                                       \n");
					sbInsSql.append("       , SYSDATE UDATE                                                                 \n");
					sbInsSql.append("       , RECIPE_SEQ                                                                    \n");
					sbInsSql.append("  FROM FMM_SINGLE_MENU_RECIPE A                                                        \n");
					sbInsSql.append(" WHERE SINGLE_MENU_CD = '" + strMenuCD + "'  -- ����� ���õ� MENU_CD                  \n");
					sbInsSql.append("   AND NOT EXISTS (                                                                    \n");
	                sbInsSql.append("               SELECT 1                                                                \n");
	                sbInsSql.append("                 FROM FMM_TERM_MENU_RECIPE B                                           \n");
	                sbInsSql.append("                WHERE B.TERM_MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD\n");
					sbInsSql.append("                  AND B.RECIPE_CD = A.RECIPE_CD                                        \n");
					sbInsSql.append("               )                                                                       \n");
					
					//System.out.println(sbInsSql.toString());
					stmt 		=  conn.createStatement();
					stmt.execute(sbInsSql.toString());
					stmt.close();

					// 4. ǥ�ؽĴܷ��������� ���� : 2015-11-09
					sbInsSql.delete(0, sbInsSql.length());
					sbInsSql.append(" --ǥ�ؽĴ� ������ ���� ����							 \n");
					sbInsSql.append(" INSERT INTO FMM_TERM_MENU_RECIPE_ITEM  \n");
					sbInsSql.append(" (																 \n");
					sbInsSql.append("   TERM_MENU_CD										 \n");
					sbInsSql.append(" , RECIPE_CD												 \n");	
					sbInsSql.append(" , ITEM_CODE												 \n");
					sbInsSql.append(" , ITEM_SEQ												 \n");
					sbInsSql.append(" , NEED_QTY												 \n");
					sbInsSql.append(" , EDIBLE_QTY												 \n");
					sbInsSql.append(" , CUT_SPEC												 \n");
					sbInsSql.append(" , USE_YN													 \n");
					sbInsSql.append(" , CUSER														 \n");
					sbInsSql.append(" , CDATE													 \n");
					sbInsSql.append(" )																 \n");
				    sbInsSql.append(" SELECT														 \n");
					sbInsSql.append("  '" + v_MenuCD + "' TERM_MENU_CD 			 \n");		
					sbInsSql.append("       , A.RECIPE_CD                                       \n");
					sbInsSql.append("       , D.ITEM_CODE                                      \n");
					sbInsSql.append("       , D.ITEM_SEQ										 \n");
					sbInsSql.append("       , D.NEED_QTY										 \n");
					sbInsSql.append("       , D.EDIBLE_QTY										 \n");
					sbInsSql.append("       , D.CUT_SPEC										 \n");
					sbInsSql.append("       , D.USE_YN											 \n");
					sbInsSql.append("       , '" + g_EmpNo + "' CUSER                     \n");
					sbInsSql.append("       , SYSDATE CDATE                                 \n");
				    sbInsSql.append("  FROM FMM_SINGLE_MENU_RECIPE A			 \n");
					sbInsSql.append("		  , FMR_STD_RECIPE_MST C					 \n");
					sbInsSql.append("          , FMR_STD_RECIPE_ITEM D					 \n");
					sbInsSql.append(" WHERE A.SINGLE_MENU_CD = '" + strMenuCD + "'  -- ����� ���õ� MENU_CD       \n");
					sbInsSql.append(" AND    A.RECIPE_CD = C.RECIPE_CD				\n");
					sbInsSql.append(" AND    C.RECIPE_CD = D.RECIPE_CD				\n");
					sbInsSql.append(" AND NOT EXISTS (																						\n");
	                sbInsSql.append("               SELECT 1																						\n");
	                sbInsSql.append("                 FROM FMM_TERM_MENU_RECIPE_ITEM B										\n");
	                sbInsSql.append("                WHERE B.TERM_MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD\n");
					sbInsSql.append("                  AND B.RECIPE_CD = D.RECIPE_CD                                        \n");
					sbInsSql.append("                  AND B.ITEM_CODE = D.ITEM_CODE                                        \n");
					sbInsSql.append("               )																						\n");

					//System.out.println(sbInsSql.toString());
					stmt 		=  conn.createStatement();
					stmt.execute(sbInsSql.toString());
					stmt.close();

				}
			}
			else								// 2 : �Ⱓǥ�ؽĴ� : �Ⱓǥ�� �Ĵܿ� ���纰 ������ ����(2015-11-09)
			{
				// 2.0  ���� ������ ��� ���̺� ���ۼ��� �����ǰ� �ִ��� Ȯ���Ѵ�.
				//   COUNT(*) > 0�� �����󿡼� ���ܵȴ�. 
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT COUNT(*) AS CNT						\n");
				sbSelSql.append("  FROM FMM_TERM_MENU_RECIPE 				\n");
				sbSelSql.append(" WHERE TERM_MENU_CD = '" + v_MenuCD + "' 		\n");
				
				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery(); 
				rs.next();
				nCnt	= rs.getInt("CNT");
				
				rs.close();
				pstmt.close();
				
				if (nCnt > 0 )
				{
					//System.out.println(" v_Menudate : " + v_Menudate + " nARow2 : " + nARow2);
					ds_ResultDt.newRow(nARow2);
					ds_ResultDt.set(nARow2,"MENU_DATE",v_Menudate);
					ds_ResultDt.set(nARow2,"MSG","������ �ۼ��� �Ĵ��� �ֽ��ϴ�.");
					nARow2 = nARow2 + 1;
				}
				else
				{
					// 4. �ߺ�������
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("-- 3. ������ �ߺ�(�Ⱓǥ��)                                                                                         \n");
					sbSelSql.append("SELECT                                                                                                              \n");
					sbSelSql.append("      A.MENU_DATE       --������                                                                                    \n");
					sbSelSql.append("      ,A.MENU_CLASS                                                                                                 \n");
					sbSelSql.append("      ,A.COST_TYPE                                                                                                  \n");
					sbSelSql.append("      ,A.MENU_TYPE                                                                                                  \n");
					sbSelSql.append("      ,A.MEAL                                                                                                       \n");
					sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --�ڳʸ� \n");
					sbSelSql.append("      ,B.RECIPE_CD                                                                                                  \n");
					sbSelSql.append("      ,(SELECT RECIPE_NAME FROM FMR_STD_RECIPE_MST WHERE RECIPE_CD = B.RECIPE_CD) RECIPE_NAME                       \n");
					sbSelSql.append("  FROM FMM_TERM_MENU_MST A                                                                                          \n");
					sbSelSql.append("      ,FMM_TERM_MENU_RECIPE B                                                                                       \n");
					sbSelSql.append(" WHERE A.TERM_MENU_CD = B.TERM_MENU_CD                                                                              \n");
					sbSelSql.append("   AND A.TERM_MENU_CD = '" + v_MenuCD + "' --�� 1������ �ҷ��� MENU_CD                                              \n");
					sbSelSql.append("   AND EXISTS (                                                                                                     \n");
					sbSelSql.append("                SELECT 1                                                                                            \n");
					sbSelSql.append("                  FROM FMM_TERM_MENU_RECIPE C                                                                       \n");
					sbSelSql.append("                 WHERE C.TERM_MENU_CD = '" + strMenuCD + "'  -- ����� ���õ� MENU_CD                               \n");
					sbSelSql.append("                   AND C.RECIPE_CD = B.RECIPE_CD                                                                    \n");
					sbSelSql.append("               )                                                                                                    \n");
					
					//System.out.println(sbSelSql.toString());
					pstmt = conn.prepareStatement(sbSelSql.toString());
					rs = pstmt.executeQuery();
					
					while(rs.next()) 
					{ 
						ds_Result.newRow(nARow);
						ds_Result.set(nARow,"MENU_DATE",rs.getString("MENU_DATE"));
						ds_Result.set(nARow,"CORNER_NAME",rs.getString("CORNER_NAME"));
						ds_Result.set(nARow,"RECIPE_CD",rs.getString("RECIPE_CD"));
						ds_Result.set(nARow,"RECIPE_NAME",rs.getString("RECIPE_NAME"));
						
						nARow = nARow + 1;
					}
					
					rs.close();
					pstmt.close();
					
					//  3. �����Ǻ���	
					sbInsSql.delete(0, sbInsSql.length());
					sbInsSql.append("-- 2. ������ ����(�Ⱓǥ��)                                                            \n");
					sbInsSql.append("INSERT INTO FMM_TERM_MENU_RECIPE(                                                      \n");
					sbInsSql.append("	 TERM_MENU_CD                                                                       \n");
					sbInsSql.append("	, RECIPE_CD                                                                         \n");
					sbInsSql.append("	, DISH_INFO                                                                         \n");
					sbInsSql.append("    , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05                                           \n");
					sbInsSql.append("	, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10                                            \n");
					sbInsSql.append("	, CUSER                                                                             \n");
					sbInsSql.append("	, CDATE                                                                             \n");
					sbInsSql.append("	, UUSER                                                                             \n");
					sbInsSql.append("	, UDATE                                                                             \n");
					sbInsSql.append("	, RECIPE_SEQ                                                                        \n");
					sbInsSql.append(" )                                                                                     \n");
					sbInsSql.append("SELECT '" + v_MenuCD + "' TERM_MENU_CD                                                                 \n");
					sbInsSql.append("       , RECIPE_CD                                                                     \n");
					sbInsSql.append("       , '' DISH_INFO                                                                  \n");
					sbInsSql.append("       , '' ATTR01, '' ATTR02, '' ATTR03, '' ATTR04, '' ATTR05                         \n");
					sbInsSql.append("       , '' ATTR06, '' ATTR07, '' ATTR08, '' ATTR09, '' ATTR10                         \n");
					sbInsSql.append("       , '' CUSER                                                                      \n");
					sbInsSql.append("       , SYSDATE CDATE                                                                 \n");
					sbInsSql.append("       , '' UUSER                                                                      \n");
					sbInsSql.append("       , SYSDATE UDATE                                                                 \n");
					sbInsSql.append("       , RECIPE_SEQ                                                                    \n");
					sbInsSql.append("  FROM FMM_TERM_MENU_RECIPE A                                                          \n");
					sbInsSql.append(" WHERE TERM_MENU_CD = '" + strMenuCD + "'  -- ����� ���õ� MENU_CD                    \n");
					sbInsSql.append("   AND NOT EXISTS (                                                                    \n");
	                sbInsSql.append("               SELECT 1                                                                \n");
	                sbInsSql.append("                 FROM FMM_TERM_MENU_RECIPE B                                           \n");
	                sbInsSql.append("                WHERE B.TERM_MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD\n");
					sbInsSql.append("                  AND B.RECIPE_CD = A.RECIPE_CD                                        \n");
					sbInsSql.append("               )                                                                       \n");
					
					//System.out.println(sbInsSql.toString());
					stmt 		=  conn.createStatement();
					stmt.execute(sbInsSql.toString());
					stmt.close();

					// 4. ��õ�Ĵܷ��������� ���� : 2015-11-09
					sbInsSql.delete(0, sbInsSql.length());
					sbInsSql.append(" --��õ�Ĵ� ������ ���� ����							 \n");
					sbInsSql.append(" INSERT INTO FMM_TERM_MENU_RECIPE_ITEM  \n");
					sbInsSql.append(" (																 \n");
					sbInsSql.append("   TERM_MENU_CD										 \n");
					sbInsSql.append(" , RECIPE_CD												 \n");	
					sbInsSql.append(" , ITEM_CODE												 \n");
					sbInsSql.append(" , ITEM_SEQ												 \n");
					sbInsSql.append(" , NEED_QTY												 \n");
					sbInsSql.append(" , EDIBLE_QTY												 \n");
					sbInsSql.append(" , CUT_SPEC												 \n");
					sbInsSql.append(" , USE_YN													 \n");
					sbInsSql.append(" , CUSER														 \n");
					sbInsSql.append(" , CDATE													 \n");
					sbInsSql.append(" )																 \n");
				    sbInsSql.append(" SELECT														 \n");
					sbInsSql.append("  '" + v_MenuCD + "' TERM_MENU_CD 			 \n");		
					sbInsSql.append("       , A.RECIPE_CD                                       \n");
					sbInsSql.append("       , A.ITEM_CODE                                      \n");
					sbInsSql.append("       , A.ITEM_SEQ										 \n");
					sbInsSql.append("       , A.NEED_QTY										 \n");
					sbInsSql.append("       , A.EDIBLE_QTY										 \n");
					sbInsSql.append("       , A.CUT_SPEC										 \n");
					sbInsSql.append("       , A.USE_YN											 \n");
					sbInsSql.append("       , '" + g_EmpNo + "' CUSER                     \n");
					sbInsSql.append("       , SYSDATE CDATE                                  \n");
					sbInsSql.append(" FROM FMM_TERM_MENU_RECIPE_ITEM A		 \n");
					sbInsSql.append(" WHERE TERM_MENU_CD = '" + strMenuCD + "'  -- ����� ���õ� MENU_CD       \n");
					sbInsSql.append(" AND NOT EXISTS (																						\n");
	                sbInsSql.append("               SELECT 1																						\n");
	                sbInsSql.append("                 FROM FMM_TERM_MENU_RECIPE_ITEM B										\n");
	                sbInsSql.append("                WHERE B.TERM_MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD\n");
					sbInsSql.append("                  AND B.RECIPE_CD = A.RECIPE_CD                                        \n");
					sbInsSql.append("                  AND B.ITEM_CODE = A.ITEM_CODE                                        \n");
					sbInsSql.append("               )																						\n");

					//System.out.println(sbInsSql.toString());
					stmt 		=  conn.createStatement();
					stmt.execute(sbInsSql.toString());
					stmt.close();
				    

				}
			}
			
		}
		
		conn.commit();
		out_dl.add(ds_Result);
		out_dl.add(ds_ResultDt);
		this.setResultMessage(0, "OK",out_vl);
	   
	} catch(Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
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
