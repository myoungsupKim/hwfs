<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		// [�Ĵܺ���] ����������
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log ���� ����
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//����Ŀ�� ���� false
		conn.setAutoCommit(false);

		DataSet ds_input  	= in_dl.get("ds_input");
		DataSet ds_list  	= in_dl.get("ds_list");
		DataSet ds_result  	= in_dl.get("ds_Result");
		DataSet ds_ResultDt  	= in_dl.get("ds_ResultDt");
		String v_Upjang  	= in_vl.getString("fa_UPJANG");
		String v_Hall  		= in_vl.getString("fa_HALL_CD");
		String v_subInvCode = in_vl.getString("fa_SUBINV_CODE");
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		String v_SaveType 	= in_vl.getString("SaveType");

		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();

		int nCnt,nARow,nARow2,RowCnt;
		String strMsg;
		String strUpjang,strHallCD,strMenuCD,strOriginRecipe,strSubinvCode;
		String v_CopyType,v_Menudate,v_Meal,v_Corner,v_MenuCD,v_Dt,v_costType,v_orgCorner;

		strUpjang 		= ds_input.getString(0,"UPJANG");
		strHallCD 		= ds_input.getString(0,"HALL_CD");
		strSubinvCode	= ds_input.getString(0,"SUBINV_CODE");

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

				v_Meal  	= in_vl.getString("MEAL");
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

				//System.out.println(sbSelSql.toString());
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

				v_Meal  	= in_vl.getString("MEAL");
				v_Corner  	= in_vl.getString("CORNER");
				v_Dt		= in_vl.getString("D_DT");

				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("-- ����޴� �Ⱓ���� ����Ʈ                                                          \n");
				sbSelSql.append("SELECT '' AS UPJANG                                                                  \n");
				sbSelSql.append("     , TERM_MENU_CD AS MENU_CD                                                       \n");
				sbSelSql.append("     , TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + ",'yyyymmdd') AS MENU_DATE \n");
				sbSelSql.append("     , '" + v_Meal + "' AS MEAL                                                      \n");
				sbSelSql.append("     , '" + v_Corner + "' AS CORNER                                                  \n");
				sbSelSql.append("     , '" + strCorner + "' AS ORG_CORNER                                         	  \n");
				sbSelSql.append("     , '" + strCopyGubun + "' AS COPY_TYPE                                           \n");
				sbSelSql.append("     , '" + strCostType + "' AS COST_TYPE                                            \n");
				sbSelSql.append("  FROM FSM_TERM_MENU_MST                                                             \n");
				sbSelSql.append(" WHERE MENU_CLASS= '" + strMenuClass + "'                                            \n");
				sbSelSql.append("   AND COST_TYPE = '" + strCostType + "'                                             \n");
				sbSelSql.append("   AND MENU_TYPE = '" + strMenuType + "'                                             \n");
				sbSelSql.append("   AND MEAL = '" + strMeal + "'                                                      \n");
				sbSelSql.append("   AND CORNER = '" + strCorner + "'                                                  \n");
				sbSelSql.append("   AND MENU_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "'                   \n");
				sbSelSql.append(" ORDER BY MENU_DATE                                                                  \n");

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
			v_Meal  	= ds_list.getString(i,"MEAL");
			v_Corner  	= ds_list.getString(i,"CORNER");
			v_orgCorner	= ds_list.getString(i,"ORG_CORNER");
			strMenuCD	= ds_list.getString(i,"MENU_CD");
			v_costType  = ds_list.getString(i, "COST_TYPE");
			
			if (strUpjang.equals(v_Upjang))
			{
				strOriginRecipe = "03";
			}
			else
			{
				strOriginRecipe = "04";
			}

			if (v_CopyType.equals("0"))		// 0 : �����Ĵ�
			{
				// 1. ��üũ
				// 1.1 �ڱ� ������ ������ �з��� ���Ե��� ���� �Ĵ� ����� �ش� �Ĵ� ���� ���� ����
				// �Ʒ��� SQL ���� �� COUNT(*) > 0 �̸� �ش�Ĵ��� �������� �ʰ� ���� ����
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT COUNT(*) AS CNT																\n");
				sbSelSql.append("  FROM (																			\n");
				sbSelSql.append("        SELECT DISTINCT A.RECIPE_CLASS												\n");
				sbSelSql.append("          FROM FSM_REAL_RECIPE_MST A												\n");
				sbSelSql.append("         WHERE A.UPJANG = " + strUpjang + "										\n");
				sbSelSql.append("           AND A.MENU_CD = '" + strMenuCD + "'										\n");
				sbSelSql.append("        MINUS																		\n");
				sbSelSql.append("        SELECT RECIPE_CLASS														\n");
				sbSelSql.append("          FROM FSA_UPJANG_RECIPE_LINK												\n");
				sbSelSql.append("         WHERE UPJANG = " + v_Upjang + "											\n");
				sbSelSql.append("        )																			\n");

				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery();
				rs.next();
				nCnt	= rs.getInt("CNT");

				rs.close();
				pstmt.close();

				if (nCnt > 0 )
				{
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("SELECT MENU_DATE || ' ' ||																						\n");
					sbSelSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL)  || ' ' ||        \n");
					sbSelSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) || ' [' ||      \n");
					sbSelSql.append("       FSM_REAL_RECIPE_NAME_FUN(A.UPJANG, A.MENU_CD) || ']' AS INFO                                            \n");
					sbSelSql.append("  FROM FSM_REAL_MENU_MST A                                                                                     \n");
					sbSelSql.append(" WHERE A.UPJANG  = " + strUpjang + "                                                                           \n");
					sbSelSql.append("   AND A.MENU_CD = '" + strMenuCD + "'                                                                      	\n");
					pstmt = conn.prepareStatement(sbSelSql.toString());
					rs = pstmt.executeQuery();
					rs.next();

					strMsg = "�Ʒ� �Ĵ��� �ش���忡�� ����� �� ���� �����Ǻз��� ���ԵǾ� �ֽ��ϴ�.\n";
					strMsg = strMsg + " - " + rs.getString("INFO");
					//System.out.println(strMsg);

					rs.close();
					pstmt.close();

					this.setResultMessage(-1, strMsg ,out_vl);
					proc_output(response,out,out_vl,out_dl);
					return;
				}

				// 1.2 ���� ������ ��� ���̺� ����,�Ĵ�,�޴�����,����,�ڳʷ� ��ȸ�ؼ� ���� ���θ� �����Ѵ�.
				//   COUNT(*) <= 0�� ��� ������ �����Ѵ�.
				if(v_Hall.subSequence(0, 3).equals("005")) {
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("SELECT MENU_CD 							\n");
					sbSelSql.append("  FROM FSM_REAL_MENU_MST 					\n");
					sbSelSql.append(" WHERE UPJANG = " + v_Upjang + " 			\n");
					sbSelSql.append("   AND HALL_CD = '" + v_Hall + "' 			\n");
					sbSelSql.append("   AND MENU_DATE = '" + v_Menudate + "' 	\n");
					sbSelSql.append("   AND MEAL = '" + v_Meal + "' 			\n");
					sbSelSql.append("   AND CORNER = '" + v_Corner + "' 		\n");
				} else {
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("SELECT MENU_CD 							\n");
					sbSelSql.append("  FROM FSM_REAL_MENU_MST 					\n");
					sbSelSql.append(" WHERE UPJANG = " + v_Upjang + " 			\n");
					sbSelSql.append("   AND HALL_CD = '" + v_Hall + "' 			\n");
					sbSelSql.append("   AND MENU_DATE = '" + v_Menudate + "' 	\n");
					sbSelSql.append("   AND MEAL = '" + v_Meal + "' 			\n");
					sbSelSql.append("   AND CORNER = '" + v_Corner + "' 		\n");
					sbSelSql.append("   AND EXPECT_MEAL_QTY > 0 \n");
				}

				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery();

				if(rs.next())	// �޴��� �ִ°��
				{
					v_MenuCD = rs.getString("MENU_CD");

					rs.close();
					pstmt.close();

					// 2.0  ���� ������ ��� ���̺� ���ۼ��� �����ǰ� �ִ��� Ȯ���Ѵ�.
					//   COUNT(*) > 0�� �����󿡼� ���ܵȴ�.
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("SELECT COUNT(*) AS CNT						\n");
					sbSelSql.append("  FROM FSM_REAL_RECIPE_MST 				\n");
					sbSelSql.append(" WHERE UPJANG = " + v_Upjang + " 			\n");
					sbSelSql.append("   AND MENU_CD = '" + v_MenuCD + "' 		\n");

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
						ds_ResultDt.set(nARow2,"MEAL",v_Meal);
						ds_ResultDt.set(nARow2,"CORNER",v_Corner);
						ds_ResultDt.set(nARow2,"MSG","������ �ۼ��� �Ĵ��� �ֽ��ϴ�.");
						nARow2 = nARow2 + 1;
					}
					else
					{

						//  2.2 ���������� ����
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("-- 2.2 ������ ���� ����  																										\n");
						sbInsSql.append("INSERT INTO FSM_REAL_RECIPE_ITEM                                                                                           \n");
						sbInsSql.append("            (UPJANG, MENU_CD, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC                               \n");
						sbInsSql.append("            ,ORDER_YN, PR_ID, PR_NUM, PR_QTY, NEED_DATE, UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE, ATTR10                     \n");
						sbInsSql.append("            ,CUSER, CDATE, UUSER, UDATE)                                                                                   \n");
						sbInsSql.append("SELECT " + v_Upjang + " UPJANG -- �ϴ��� ����� �����                                                                   										\n");
						sbInsSql.append("      ,'" + v_MenuCD + "' MENU_CD -- �� 1������ �ҷ��� MENU_CD                                                         			\n");
						sbInsSql.append("      ,A.RECIPE_CD                                                                                                         \n");
						sbInsSql.append("      ,A.ITEM_CODE                                                                                                         \n");
						sbInsSql.append("      ,NVL(A.ITEM_SEQ,0) ITEM_SEQ                                                                                          \n");
						sbInsSql.append("      ,A.NEED_QTY                                                                                                          \n");
						sbInsSql.append("      ,A.EDIBLE_QTY                                                                                                        \n");
						sbInsSql.append("      ,A.CUT_SPEC                                                                                                          \n");
						sbInsSql.append("      ,'N' ORDER_YN                                                                                                        \n");
						sbInsSql.append("      ,0 PR_ID                                                                                                             \n");
						sbInsSql.append("      ,'' PR_NUM                                                                                                           \n");
						sbInsSql.append("      ,0 PR_QTY                                                                                                            \n");
						sbInsSql.append("      ,FSM_ITEM_NEED_DATE_FUN(" + v_Upjang + ", '" + v_Hall + "','" + v_Meal + "','" + v_Corner + "','" + v_Menudate + "' ) AS NEED_DATE \n");
						sbInsSql.append("      ,NVL(B.CONTRACT_PRICE,0) UNIT_PRICE                                                                                  \n");
						sbInsSql.append("      ,NVL(B.MARGIN_RATE,0) MARGIN_RATE                                                                                    \n");
						sbInsSql.append("      ,NVL(B.ITEM_PRICE,0) MARGIN_PRICE                                                                                    \n");
						sbInsSql.append("      ,ATTR10  -- �׷췹�������翩��                                                                                       \n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                                                           		\n");
						sbInsSql.append("      ,SYSDATE CDATE                                                                                                       \n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                                                           		\n");
						sbInsSql.append("      ,SYSDATE UDATE                                                                                                       \n");
						sbInsSql.append("  FROM FSM_REAL_RECIPE_ITEM A                                                                                              \n");
						sbInsSql.append("      ,( \n");
						sbInsSql.append("       SELECT A.ITEM_CODE, \n");
						sbInsSql.append("              A.CONTRACT_PRICE, \n");
						sbInsSql.append("              A.MARGIN_RATE, \n");
						sbInsSql.append("              DECODE(A.MARGIN_RATE, 0, A.CONTRACT_PRICE, DECODE(E.OUTVAT_FLAG, 'Y' , ( ROUND( (A.CONTRACT_PRICE * DECODE(D.TAX_CODE, '100' , 1.1, 1) * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) , ( ROUND( (A.CONTRACT_PRICE * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) ) ) AS ITEM_PRICE \n");
						sbInsSql.append("         FROM HLDC_ST_UPJANG B, \n");
						sbInsSql.append("              HLDC_PO_SUBINVENTORY E, \n");
						sbInsSql.append("              HLDC_PO_CONTRACT_F A, \n");
						sbInsSql.append("              HLDC_PO_ITEM_MST D \n");
						sbInsSql.append("        WHERE A.ITEM_CODE = D.ITEM_CODE \n");
						sbInsSql.append("          AND A.USE_YN = 'Y' \n");
						sbInsSql.append("          AND A.CONTRACT_PRICE > 0 \n");
						sbInsSql.append("          AND A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
						sbInsSql.append("          AND B.UPJANG = E.UPJANG \n");
						sbInsSql.append("          AND B.UPJANG = " + v_Upjang + "  --[�����ڵ�] \n");
						sbInsSql.append("          AND E.SUBINV_CODE = '" + v_subInvCode + "'  --[â���ڵ�] FSM_REAL_MENU_MST.SUBINV_CODE ���(�켱����), FSA_HALL_MST.SUBINV_CODE ��� \n");
						sbInsSql.append("          AND '" + v_Menudate + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999')  --[�޴�����] \n");
						sbInsSql.append("       ) B \n");
						sbInsSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                                                                        \n");
						sbInsSql.append("   AND A.UPJANG = " + strUpjang + "                                                                                        \n");
						sbInsSql.append("   AND A.MENU_CD = '" + strMenuCD + "'                                                                                  	\n");
						sbInsSql.append("   AND NOT EXISTS (                                                                                                        \n");
						sbInsSql.append("               SELECT 1                                                                                                    \n");
						sbInsSql.append("                 FROM FSM_REAL_RECIPE_MST C                                                                                \n");
						sbInsSql.append("                WHERE C.UPJANG = " + v_Upjang + "  -- �ϴ��� ����� �����                                               				 				\n");
						sbInsSql.append("                  AND C.MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD   											\n");
						sbInsSql.append("                  AND C.RECIPE_CD = A.RECIPE_CD																			\n");
						sbInsSql.append("               )																											\n");

						//System.out.println(sbInsSql.toString());
						stmt 		=  conn.createStatement();
						stmt.execute(sbInsSql.toString());
						stmt.close();

						// 2.3 ������ ������ ����
						// 2.3.1 �������ε�
						sbSelSql.delete(0, sbSelSql.length());
						sbSelSql.append("SELECT                                                                                                                     \n");
						sbSelSql.append("       " + v_Upjang + " UPJANG -- �ϴ��� ����� �����                                                                    										\n");
						sbSelSql.append("      ,'" + v_MenuCD + "' MENU_CD -- �� 1������ �ҷ��� MENU_CD                                                         			\n");
						sbSelSql.append("      ,A.RECIPE_CD                                                                                                         \n");
						sbSelSql.append("      ,A.CUISINE_SEQ                                                                                                       \n");
						sbSelSql.append("      ,A.CUISINE_DESC                                                                                                      \n");
						sbSelSql.append("      ,'' PHOTO_PATH --���������� ������ �� ������ ���ϸ��� ����Ǿ�� �Ѵ�.                                               \n");
						sbSelSql.append("      ,'' SPHOTO_PATH --���������� ������ �� ������ ���ϸ��� ����Ǿ�� �Ѵ�.                                              \n");
						sbSelSql.append("      ,'" + g_EmpNo + "'                                                                                           		\n");
						sbSelSql.append("      ,SYSDATE CDATE                                                                                                       \n");
						sbSelSql.append("      ,'" + g_EmpNo + "'                                                                                           		\n");
						sbSelSql.append("      ,SYSDATE UDATE                                                                                                       \n");
						sbSelSql.append("  FROM FSM_REAL_RECIPE_CUISINE A                                                                                           \n");
						sbSelSql.append(" WHERE A.UPJANG = " + strUpjang + "                                                                                        \n");
						sbSelSql.append("   AND A.MENU_CD = '" + strMenuCD + "'                                                                                  	\n");
						sbSelSql.append("   AND NOT EXISTS (                                                                                                        \n");
						sbSelSql.append("               SELECT 1                                                                                                    \n");
						sbSelSql.append("                 FROM FSM_REAL_RECIPE_MST B                                                                                \n");
						sbSelSql.append("                WHERE B.UPJANG = " + v_Upjang + "  -- �ϴ��� ����� �����                                                								\n");
						sbSelSql.append("                  AND B.MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD                                     			\n");
						sbSelSql.append("                  AND B.RECIPE_CD = A.RECIPE_CD                                                                            \n");
						sbSelSql.append("               )                                                                                                           \n");

						//System.out.println(sbSelSql.toString());
						//pstmt = conn.prepareStatement(sbSelSql.toString());
						//rs = pstmt.executeQuery();

						// 2.3.2 ������ ������
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("-- 2.3 ������ ������ ���� 																										\n");
						sbInsSql.append("INSERT INTO FSM_REAL_RECIPE_CUISINE                                                                                        \n");
						sbInsSql.append("           (UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH                                 \n");
						sbInsSql.append("            ,CUSER, CDATE, UUSER, UDATE)                                                                                   \n");
						sbInsSql.append(sbSelSql.toString());

						//System.out.println(sbInsSql.toString());
						stmt 		=  conn.createStatement();
						stmt.execute(sbInsSql.toString());
						stmt.close();

						//  2.4 �ߺ�������
						sbSelSql.delete(0, sbSelSql.length());
						sbSelSql.append("-- 2.4 �ߺ������ǿ� ���ؼ��� �Ʒ� SQL�� �̿��Ͽ� �˾�â�� ����ش�.                                                        				\n");
						sbSelSql.append("SELECT                                                                                                                     \n");
						sbSelSql.append("      A.MENU_DATE       --������                                                                                           												\n");
						sbSelSql.append("      ,(SELECT HALL_NAME FROM FSA_HALL_MST WHERE UPJANG = A.UPJANG AND HALL_CD = A.HALL_CD)  AS HALL_NAME       --�Ĵ�     	\n");
						sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL) MEAL_NAME --���ϸ�            		\n");
						sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --�ڳʸ�        		\n");
						sbSelSql.append("      ,B.RECIPE_CD                                                                                                         \n");
						sbSelSql.append("      ,B.RECIPE_NAME                                                                                                       \n");
						sbSelSql.append("  FROM FSM_REAL_MENU_MST A                                                                                                 \n");
						sbSelSql.append("      ,FSM_REAL_RECIPE_MST B                                                                                               \n");
						sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                 \n");
						sbSelSql.append("   AND A.MENU_CD = B.MENU_CD                                                                                               \n");
						sbSelSql.append("   AND A.UPJANG = " + v_Upjang + " --�ϴ��� ����� �����                                                                  										\n");
						sbSelSql.append("   AND A.MENU_CD = '" + v_MenuCD + "' --�� 1������ �ҷ��� MENU_CD                                                         		\n");
						sbSelSql.append("   AND EXISTS (                                                                                                            \n");
						sbSelSql.append("               SELECT 1                                                                                                    \n");
						sbSelSql.append("                 FROM FSM_REAL_RECIPE_MST C                                                                                \n");
						sbSelSql.append("                WHERE C.UPJANG = " + strUpjang + "  -- ����� ����� �����                                                								\n");
						sbSelSql.append("                  AND C.MENU_CD = '" + strMenuCD + "'  -- ����� ���õ� MENU_CD                                     			\n");
						sbSelSql.append("                  AND C.RECIPE_CD = B.RECIPE_CD                                                                            \n");
						sbSelSql.append("               )                                                                                                           \n");

						//System.out.println(sbSelSql.toString());
						pstmt = conn.prepareStatement(sbSelSql.toString());
						rs = pstmt.executeQuery();

						while(rs.next())
						{
							ds_result.newRow(nARow);
							ds_result.set(nARow,"MENU_DATE",rs.getString("MENU_DATE"));
							ds_result.set(nARow,"HALL_NAME",rs.getString("HALL_NAME"));
							ds_result.set(nARow,"MEAL_NAME",rs.getString("MEAL_NAME"));
							ds_result.set(nARow,"CORNER_NAME",rs.getString("CORNER_NAME"));
							ds_result.set(nARow,"RECIPE_CD",rs.getString("RECIPE_CD"));
							ds_result.set(nARow,"RECIPE_NAME",rs.getString("RECIPE_NAME"));

							nARow = nARow + 1;
						}

						rs.close();
						pstmt.close();

						//  2.1 �����Ǻ���
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("-- 2.1 ������ ������ ���� : ���� �������ڵ�� ��ϵ� �����͸� ������ �����ǿ� ���ؼ��� ������ ����												\n");
						sbInsSql.append("INSERT INTO FSM_REAL_RECIPE_MST																							\n");
						sbInsSql.append("SELECT " + v_Upjang + " -- �ϴ��� ����� �����																					\n");
						sbInsSql.append("      ,'" + v_MenuCD + "' -- �� 1������ �ҷ��� MENU_CD																			\n");
						sbInsSql.append("      ,RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2					\n");
						sbInsSql.append("      ,COOK_TOOL1, COOK_TOOL2, MAJOR_DISH_INFO, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER		\n");
						sbInsSql.append("      ,SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM	\n");
						sbInsSql.append("      ,SALE_PRICE, COST_RATE, COOK_1MAN_QTY, COOK_TIME, EXPECT_SALE_QTY, REAL_SALE_QTY, CORE_TEMPER_YN, GOODS_FEATURE		\n");
						sbInsSql.append("      ,PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, PREFER					\n");
						sbInsSql.append("      ,'" + strOriginRecipe + "' AS ORIGIN_RECIPE -- ����� ������ ������ �ϴ��� ����� ������� ������ ��� '03', Ʋ�� ��� '04'		\n");
						sbInsSql.append("      ,ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10                                      \n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                                                					\n");
						sbInsSql.append("      ,SYSDATE CDATE                                                                                                       \n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                                                          			\n");
						sbInsSql.append("      ,SYSDATE UDATE                                                                                                       \n");
						sbInsSql.append("      ,SPHOTO_PATH, PHF, RECIPE_SEQ                                                                                        \n");
						sbInsSql.append("  FROM FSM_REAL_RECIPE_MST A                                                                                               \n");
						sbInsSql.append(" WHERE UPJANG = " + strUpjang + "																							\n");
						sbInsSql.append("   AND MENU_CD = '" + strMenuCD + "'                                                                                    	\n");
						sbInsSql.append("   AND NOT EXISTS (                                                                                                        \n");
						sbInsSql.append("               SELECT 1                                                                                                    \n");
						sbInsSql.append("                 FROM FSM_REAL_RECIPE_MST B                                                                                \n");
						sbInsSql.append("                WHERE B.UPJANG = " + v_Upjang + "  -- �ϴ��� ����� �����                                               								\n");
						sbInsSql.append("                  AND B.MENU_CD = '" + v_MenuCD + "'   -- �� 1������ �ҷ��� MENU_CD                                    			\n");
						sbInsSql.append("                  AND B.RECIPE_CD = A.RECIPE_CD                                                                            \n");
						sbInsSql.append("               ) 																											\n");

						//System.out.println(sbInsSql.toString());
						stmt 		=  conn.createStatement();
						stmt.execute(sbInsSql.toString());
						stmt.close();
					}
				}
				else
				{
					rs.close();
					pstmt.close();

					ds_ResultDt.newRow(nARow2);
					ds_ResultDt.set(nARow2,"MENU_DATE",v_Menudate);
					ds_ResultDt.set(nARow2,"MEAL",v_Meal);
					ds_ResultDt.set(nARow2,"CORNER",v_Corner);
					ds_ResultDt.set(nARow2,"MSG","�ļ������� �� �ֽʽÿ�.");
					nARow2 = nARow2 + 1;
				}
			}
			else if (v_CopyType.equals("1"))	// 1 : ����ǥ�ؽĴ�
			{
				// 1. ��üũ
				// 1.1 �ڱ� ������ ������ �з��� ���Ե��� ���� �Ĵ� ����� �ش� �Ĵ� ���� ���� ����
				// �Ʒ��� SQL ���� �� COUNT(*) > 0 �̸� �ش�Ĵ��� �������� �ʰ� ���� ����
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT COUNT(*) AS CNT                        				\n");
				sbSelSql.append("  FROM (                                					\n");
				sbSelSql.append("        SELECT DISTINCT B.RECIPE_CLASS  					\n");
				sbSelSql.append("          FROM FSM_SINGLE_MENU_RECIPE A 					\n");
				sbSelSql.append("              ,FSR_STD_RECIPE_MST B     					\n");
				sbSelSql.append("         WHERE A.RECIPE_CD = B.RECIPE_CD					\n");
				sbSelSql.append("           AND A.SINGLE_MENU_CD = '" + strMenuCD + "'		\n");
				sbSelSql.append("        MINUS                           					\n");
				sbSelSql.append("        SELECT RECIPE_CLASS             					\n");
				sbSelSql.append("          FROM FSA_UPJANG_RECIPE_LINK   					\n");
				sbSelSql.append("         WHERE UPJANG = " + strUpjang + "          		\n");
				sbSelSql.append("        )                         							\n");


				System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery();
				rs.next();
				nCnt	= rs.getInt("CNT");

				rs.close();
				pstmt.close();

				if (nCnt > 0 )
				{
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("SELECT MENU_NAME AS INFO          				\n");
					sbSelSql.append("  FROM FSM_SINGLE_MENU_MST 					\n");
					sbSelSql.append(" WHERE SINGLE_MENU_CD = '" + strMenuCD + "' 	\n");
					pstmt = conn.prepareStatement(sbSelSql.toString());
					rs = pstmt.executeQuery();
					rs.next();

					strMsg = "�Ʒ� �Ĵ��� �ش���忡�� ����� �� ���� �����Ǻз��� ���ԵǾ� �ֽ��ϴ�.\n";
					strMsg = strMsg + " - " + rs.getString("INFO");
					//System.out.println(strMsg);

					rs.close();
					pstmt.close();

					this.setResultMessage(-1, strMsg ,out_vl);
					proc_output(response,out,out_vl,out_dl);
					return;
				}

				// 1.2 ���� ������ ��� ���̺� ����,�Ĵ�,�޴�����,����,�ڳʷ� ��ȸ�ؼ� ���� ���θ� �����Ѵ�.
				//   COUNT(*) <= 0�� ��� ������ �����Ѵ�.
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT MENU_CD \n");
				sbSelSql.append("  FROM FSM_REAL_MENU_MST \n");
				sbSelSql.append(" WHERE UPJANG = " + v_Upjang + " \n");
				sbSelSql.append("   AND HALL_CD = '" + v_Hall + "' \n");
				sbSelSql.append("   AND MENU_DATE = '" + v_Menudate + "' \n");
				sbSelSql.append("   AND MEAL = '" + v_Meal + "' \n");
				sbSelSql.append("   AND CORNER = '" + v_Corner + "' \n");
				sbSelSql.append("   AND EXPECT_MEAL_QTY > 0 \n");

				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery();

				if(rs.next())	// �޴��� �ִ°��
				{
					v_MenuCD = rs.getString("MENU_CD");

					rs.close();
					pstmt.close();

					// 2.0  ���� ������ ��� ���̺� ���ۼ��� �����ǰ� �ִ��� Ȯ���Ѵ�.
					//   COUNT(*) > 0�� �����󿡼� ���ܵȴ�.
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("SELECT COUNT(*) AS CNT						\n");
					sbSelSql.append("  FROM FSM_REAL_RECIPE_MST 				\n");
					sbSelSql.append(" WHERE UPJANG = " + v_Upjang + " 			\n");
					sbSelSql.append("   AND MENU_CD = '" + v_MenuCD + "' 		\n");

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
						ds_ResultDt.set(nARow2,"MEAL",v_Meal);
						ds_ResultDt.set(nARow2,"CORNER",v_Corner);
						ds_ResultDt.set(nARow2,"MSG","������ �ۼ��� �Ĵ��� �ֽ��ϴ�.");
						nARow2 = nARow2 + 1;
					}
					else
					{
						//  2.2 ���������� ����
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("-- 2.2 ������ ���� ����  																						\n");
						sbInsSql.append("INSERT INTO FSM_REAL_RECIPE_ITEM                                                                       	\n");
						sbInsSql.append("            (UPJANG, MENU_CD, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC           	\n");
						sbInsSql.append("            ,ORDER_YN, PR_ID, PR_NUM, PR_QTY, NEED_DATE, UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE, ATTR10         	\n");
						sbInsSql.append("            ,CUSER, CDATE, UUSER, UDATE)                                                               	\n");
						sbInsSql.append("SELECT " + v_Upjang + " UPJANG -- �ϴ��� ����� �����                                                     								\n");
						sbInsSql.append("      ,'" + v_MenuCD + "' MENU_CD -- �� 1������ �ҷ��� MENU_CD                                 					\n");
						sbInsSql.append("      ,A.RECIPE_CD                                                                                     	\n");
						sbInsSql.append("      ,A.ITEM_CODE                                                                                     	\n");
						sbInsSql.append("      ,NVL(A.ITEM_SEQ,0) ITEM_SEQ                                                                      	\n");
						sbInsSql.append("      ,A.NEED_QTY                                                                                      	\n");
						sbInsSql.append("      ,A.EDIBLE_QTY                                                                                    	\n");
						sbInsSql.append("      ,A.CUT_SPEC                                                                                      	\n");
						sbInsSql.append("      ,'N' ORDER_YN                                                                                    	\n");
						sbInsSql.append("      ,0 PR_ID                                                                                         	\n");
						sbInsSql.append("      ,'' PR_NUM                                                                                       	\n");
						sbInsSql.append("      ,0 PR_QTY                                                                                        	\n");
						sbInsSql.append("      ,FSM_ITEM_NEED_DATE_FUN(" + v_Upjang + ", '" + v_Hall + "','" + v_Meal + "','" + v_Corner + "','" + v_Menudate + "' ) AS NEED_DATE \n");
						sbInsSql.append("      ,NVL(B.CONTRACT_PRICE,0) UNIT_PRICE                                                              	\n");
						sbInsSql.append("      ,NVL(B.MARGIN_RATE,0) MARGIN_RATE                                                                	\n");
						sbInsSql.append("      ,NVL(B.ITEM_PRICE,0) MARGIN_PRICE                                                                	\n");
						sbInsSql.append("      ,ATTR10                                                                	\n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                                   				\n");
						sbInsSql.append("      ,SYSDATE CDATE                                                                                   	\n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                                      				\n");
						sbInsSql.append("      ,SYSDATE UDATE                                                                                   	\n");
						sbInsSql.append("  FROM                                                                                                 	\n");
						sbInsSql.append("       (                                                                                               	\n");
						sbInsSql.append("       SELECT C.RECIPE_CD, C.ITEM_CODE, C.ITEM_SEQ, C.ATTR10                                                     	\n");
						sbInsSql.append("             ,ROUND((C.NEED_QTY * A.ITEM_RATE / 100),2) NEED_QTY                                       	\n");
						sbInsSql.append("             ,ROUND(C.NEED_QTY * (A.ITEM_RATE / 100) * (100 - NVL((SELECT DISUSE_RATE FROM FSI_ITEM_NUT WHERE ITEM_CODE=C.ITEM_CODE),0)) / 100,2) AS EDIBLE_QTY, C.CUT_SPEC                                                                  	\n");
						sbInsSql.append("         FROM FSM_SINGLE_MENU_RECIPE A                                                                 	\n");
						sbInsSql.append("             ,FSR_STD_RECIPE_MST B                                                                     	\n");
						sbInsSql.append("             ,FSR_STD_RECIPE_ITEM C                                                                    	\n");
						sbInsSql.append("        WHERE A.RECIPE_CD = B.RECIPE_CD                                                                	\n");
						sbInsSql.append("          AND B.RECIPE_CD = C.RECIPE_CD                                                                	\n");
						sbInsSql.append("          AND A.SINGLE_MENU_CD = '" + strMenuCD + "'                                                       \n");
						sbInsSql.append("       ) A                                                                                         		\n");
						sbInsSql.append("      ,( \n");
						sbInsSql.append("       SELECT A.ITEM_CODE, \n");
						sbInsSql.append("              A.CONTRACT_PRICE, \n");
						sbInsSql.append("              A.MARGIN_RATE, \n");
						sbInsSql.append("              DECODE(A.MARGIN_RATE, 0, A.CONTRACT_PRICE, DECODE(E.OUTVAT_FLAG, 'Y' , ( ROUND( (A.CONTRACT_PRICE * DECODE(D.TAX_CODE, '100' , 1.1, 1) * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) , ( ROUND( (A.CONTRACT_PRICE * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) ) ) AS ITEM_PRICE \n");
						sbInsSql.append("         FROM HLDC_ST_UPJANG B, \n");
						sbInsSql.append("              HLDC_PO_SUBINVENTORY E, \n");
						sbInsSql.append("              HLDC_PO_CONTRACT_F A, \n");
						sbInsSql.append("              HLDC_PO_ITEM_MST D \n");
						sbInsSql.append("        WHERE A.ITEM_CODE = D.ITEM_CODE \n");
						sbInsSql.append("          AND A.USE_YN = 'Y' \n");
						sbInsSql.append("          AND A.CONTRACT_PRICE > 0 \n");
						sbInsSql.append("          AND A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
						sbInsSql.append("          AND B.UPJANG = E.UPJANG \n");
						sbInsSql.append("          AND B.UPJANG = " + v_Upjang + "  --[�����ڵ�] \n");
						sbInsSql.append("          AND E.SUBINV_CODE = '" + v_subInvCode + "'  --[â���ڵ�] FSM_REAL_MENU_MST.SUBINV_CODE ���(�켱����), FSA_HALL_MST.SUBINV_CODE ��� \n");
						sbInsSql.append("          AND '" + v_Menudate + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999')  --[�޴�����] \n");
						sbInsSql.append("       ) B \n");
						sbInsSql.append("       WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                                   				\n");
	                    sbInsSql.append("         AND NOT EXISTS (                                                                   				\n");
	                    sbInsSql.append("                     SELECT 1                                                               				\n");
	                    sbInsSql.append("                       FROM FSM_REAL_RECIPE_MST C                                           				\n");
	                    sbInsSql.append("                      WHERE C.UPJANG = " + v_Upjang + "  -- �ϴ��� ����� �����                      						\n");
	                    sbInsSql.append("                        AND C.MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD						\n");
	                    sbInsSql.append("                        AND C.RECIPE_CD = A.RECIPE_CD                                       				\n");
	                    sbInsSql.append("                     )                                                                      				\n");

	    				//System.out.println(sbInsSql.toString());
	    				stmt 		=  conn.createStatement();
	    				stmt.execute(sbInsSql.toString());
	    				stmt.close();

						// 2.3 ������ ������ ����
						// 2.3.1 �������ε�
						sbSelSql.delete(0, sbSelSql.length());
						sbSelSql.append("SELECT                                                                                       			\n");
						sbSelSql.append("       " + v_Upjang + " UPJANG -- �ϴ��� ����� �����                                                								\n");
						sbSelSql.append("      ,'" + v_MenuCD + "' MENU_CD -- �� 1������ �ҷ��� MENU_CD                        						\n");
						sbSelSql.append("      ,A.RECIPE_CD                                                                           			\n");
						sbSelSql.append("      ,B.CUISINE_SEQ                                                                         			\n");
						sbSelSql.append("      ,B.CUISINE_DESC                                                                        			\n");
						sbSelSql.append("      ,'' PHOTO_PATH --���������� ������ �� ������ ���ϸ��� ����Ǿ�� �Ѵ�. \n");
						sbSelSql.append("      ,'' SPHOTO_PATH --���������� ������ �� ������ ���ϸ��� ����Ǿ�� �Ѵ�.\n");
						sbSelSql.append("      ,'" + g_EmpNo + "'                                                    							\n");
						sbSelSql.append("      ,SYSDATE CDATE                                                                         			\n");
						sbSelSql.append("      ,'" + g_EmpNo + "'                                                           					\n");
						sbSelSql.append("      ,SYSDATE UDATE                                                                         			\n");
						sbSelSql.append("  FROM FSM_SINGLE_MENU_RECIPE A                                                              			\n");
						sbSelSql.append("      ,FSR_STD_RECIPE_CUISINE B                                                              			\n");
						sbSelSql.append(" WHERE A.RECIPE_CD = B.RECIPE_CD                                                          				\n");
						sbSelSql.append("   AND A.SINGLE_MENU_CD = '" + strMenuCD + "'                                                       	\n");
						sbSelSql.append("   AND NOT EXISTS (                                                                          			\n");
						sbSelSql.append("               SELECT 1                                                                      			\n");
						sbSelSql.append("                 FROM FSM_REAL_RECIPE_MST C                                                 			\n");
						sbSelSql.append("                WHERE C.UPJANG = " + v_Upjang + "  -- �ϴ��� ����� �����                          						\n");
						sbSelSql.append("                  AND C.MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD       					\n");
						sbSelSql.append("                  AND C.RECIPE_CD = A.RECIPE_CD                                              			\n");
						sbSelSql.append("               )                                                                             			\n");

						//System.out.println(sbSelSql.toString());
						//pstmt = conn.prepareStatement(sbSelSql.toString());
						//rs = pstmt.executeQuery();

						// 2.3.2 ������ ������
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("-- 2.3 ������ ������ ���� 																					\n");
						sbInsSql.append("INSERT INTO FSM_REAL_RECIPE_CUISINE                                                          			\n");
						sbInsSql.append("           (UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH   			\n");
						sbInsSql.append("            ,CUSER, CDATE, UUSER, UDATE)                                                     			\n");
						sbInsSql.append(sbSelSql.toString());

						//System.out.println(sbInsSql.toString());
						stmt 		=  conn.createStatement();
						stmt.execute(sbInsSql.toString());
						stmt.close();

						// 2.4 �ߺ�������
						sbSelSql.delete(0, sbSelSql.length());
						sbSelSql.append("-- 2.4 �ߺ������ǿ� ���ؼ��� �Ʒ� SQL�� �̿��Ͽ� �˾�â�� ����ش�.                                                        				\n");
						sbSelSql.append("SELECT                                                                                                                     \n");
						sbSelSql.append("      A.MENU_DATE       --������                                                                                           												\n");
						sbSelSql.append("      ,(SELECT HALL_NAME FROM FSA_HALL_MST WHERE UPJANG = A.UPJANG AND HALL_CD = A.HALL_CD)  AS HALL_NAME       --�Ĵ�     	\n");
						sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL) MEAL_NAME --���ϸ�            		\n");
						sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --�ڳʸ�        		\n");
						sbSelSql.append("      ,B.RECIPE_CD                                                                                                         \n");
						sbSelSql.append("      ,B.RECIPE_NAME                                                                                                       \n");
						sbSelSql.append("  FROM FSM_REAL_MENU_MST A                                                                                                 \n");
						sbSelSql.append("      ,FSM_REAL_RECIPE_MST B                                                                                               \n");
						sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                 \n");
						sbSelSql.append("   AND A.MENU_CD = B.MENU_CD                                                                                               \n");
						sbSelSql.append("   AND A.UPJANG = " + v_Upjang + " --�ϴ��� ����� �����                                                                  										\n");
						sbSelSql.append("   AND A.MENU_CD = '" + v_MenuCD + "' --�� 1������ �ҷ��� MENU_CD                                                         		\n");
						sbSelSql.append("   AND EXISTS (                                                                                                            \n");
						sbSelSql.append("               SELECT 1                                                                                                    \n");
						sbSelSql.append("                 FROM FSM_SINGLE_MENU_RECIPE C                                                                                \n");
						sbSelSql.append("                WHERE C.SINGLE_MENU_CD = '" + strMenuCD + "'  -- ����� ���õ� MENU_CD                                     			\n");
						sbSelSql.append("                  AND C.RECIPE_CD = B.RECIPE_CD                                                                            \n");
						sbSelSql.append("               )                                                                                                           \n");

						//System.out.println(sbSelSql.toString());
						pstmt = conn.prepareStatement(sbSelSql.toString());
						rs = pstmt.executeQuery();

						while(rs.next())
						{
							ds_result.newRow();
							ds_result.set(nARow,"MENU_DATE",rs.getString("MENU_DATE"));
							ds_result.set(nARow,"HALL_NAME",rs.getString("HALL_NAME"));
							ds_result.set(nARow,"MEAL_NAME",rs.getString("MEAL_NAME"));
							ds_result.set(nARow,"CORNER_NAME",rs.getString("CORNER_NAME"));
							ds_result.set(nARow,"RECIPE_CD",rs.getString("RECIPE_CD"));
							ds_result.set(nARow,"RECIPE_NAME",rs.getString("RECIPE_NAME"));

							nARow = nARow + 1;
						}
						rs.close();
						pstmt.close();

						//  2.1 �����Ǻ���
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("-- 2.1 ������ ������ ���� : ���� �������ڵ�� ��ϵ� �����͸� ������ �����ǿ� ���ؼ��� ������ ����														\n");
						sbInsSql.append("INSERT INTO FSM_REAL_RECIPE_MST                                                                                                	\n");
						sbInsSql.append("SELECT " + v_Upjang + " -- �ϴ��� ����� �����                                                                                   				 								\n");
						sbInsSql.append("      ,'" + v_MenuCD + "' -- �� 1������ �ҷ��� MENU_CD                                                                     				\n");
						sbInsSql.append("      ,B.RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2                     	\n");
						sbInsSql.append("      ,COOK_TOOL1, COOK_TOOL2                                                                                                  	\n");
						sbInsSql.append("      ,A.DISH_INFO MAJOR_DISH_INFO                                                                                             	\n");
						sbInsSql.append("      ,RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER                                                    	\n");
						sbInsSql.append("      ,SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM        	\n");
						sbInsSql.append("      ,SALE_PRICE, COST_RATE, 0 COOK_1MAN_QTY, '' COOK_TIME, 0 EXPECT_SALE_QTY, 0 REAL_SALE_QTY, CORE_TEMPER_YN, GOODS_FEATURE 	\n");
						sbInsSql.append("      ,PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, '' PREFER                        \n");
						sbInsSql.append("      ,'01' ORIGIN_RECIPE                                                                                                          \n");
						sbInsSql.append("      ,B.ATTR01, B.ATTR02, B.ATTR03, B.ATTR04, B.ATTR05, B.ATTR06, B.ATTR07, B.ATTR08, B.ATTR09, B.ATTR10                          \n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                                                             				\n");
						sbInsSql.append("      ,SYSDATE CDATE                                                                                                               \n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                                                                			\n");
						sbInsSql.append("      ,SYSDATE UDATE                                                                                                               \n");
						sbInsSql.append("      ,SPHOTO_PATH, PHF, 0 RECIPE_SEQ                                                                                          	\n");
						sbInsSql.append("  FROM FSM_SINGLE_MENU_RECIPE A                                                                                                 	\n");
						sbInsSql.append("      ,FSR_STD_RECIPE_MST B                                                                                                        \n");
						sbInsSql.append(" WHERE A.RECIPE_CD = B.RECIPE_CD                                                                                                   \n");
						sbInsSql.append("   AND A.SINGLE_MENU_CD = '" + strMenuCD + "'                                                                                      \n");
						sbInsSql.append("   AND NOT EXISTS (                                                                                                               	\n");
						sbInsSql.append("               SELECT 1                                                                                                        	\n");
						sbInsSql.append("                 FROM FSM_REAL_RECIPE_MST C                                                                                        \n");
						sbInsSql.append("                WHERE C.UPJANG = " + v_Upjang + "   -- �ϴ��� ����� �����                                                        									\n");
	                    sbInsSql.append("                  AND C.MENU_CD = '" + v_MenuCD + "'   -- �� 1������ �ҷ��� MENU_CD                           							\n");
	                    sbInsSql.append("                  AND C.RECIPE_CD = A.RECIPE_CD                                                                   					\n");
	                    sbInsSql.append("                                )                                                                                                  \n");

	    				//System.out.println(sbInsSql.toString());
	    				stmt 		=  conn.createStatement();
	    				stmt.execute(sbInsSql.toString());
	    				stmt.close();
					}
				}
				else
				{
					rs.close();
					pstmt.close();

					ds_ResultDt.newRow(nARow2);
					ds_ResultDt.set(nARow2,"MENU_DATE",v_Menudate);
					ds_ResultDt.set(nARow2,"MEAL",v_Meal);
					ds_ResultDt.set(nARow2,"CORNER",v_Corner);
					ds_ResultDt.set(nARow2,"MSG","�ļ������� �� �ֽʽÿ�.");
					nARow2 = nARow2 + 1;
				}
			}
			else		// 2 : ����Ĵ�
			{
				// 1. ��üũ
				// 1.1 �ڱ� ������ ������ �з��� ���Ե��� ���� �Ĵ� ����� �ش� �Ĵ� ���� ���� ����
				// �Ʒ��� SQL ���� �� COUNT(*) > 0 �̸� �ش�Ĵ��� �������� �ʰ� ���� ����
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT COUNT(*) AS CNT                              \n");
				sbSelSql.append("  FROM (                                            \n");
				sbSelSql.append("        SELECT DISTINCT B.RECIPE_CLASS              \n");
				sbSelSql.append("          FROM FSM_TERM_MENU_RECIPE A               \n");
				sbSelSql.append("             , FSR_STD_RECIPE_MST B                 \n");
				sbSelSql.append("         WHERE A.RECIPE_CD = B.RECIPE_CD            \n");
				sbSelSql.append("           AND A.TERM_MENU_CD = '" + strMenuCD + "' \n");
				sbSelSql.append("         MINUS                                      \n");
				sbSelSql.append("        SELECT RECIPE_CLASS                         \n");
				sbSelSql.append("          FROM FSA_UPJANG_RECIPE_LINK               \n");
				sbSelSql.append("         WHERE UPJANG = " + strUpjang + "           \n");
				sbSelSql.append("       )                                            \n");

				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery();
				rs.next();
				nCnt	= rs.getInt("CNT");

				rs.close();
				pstmt.close();

				if( nCnt > 0 )
				{
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("SELECT MENU_DATE || '�� ' ||                                                                    			\n");
					sbSelSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL)  || ' ' || 	\n");
					sbSelSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) || ' [' || 	\n");
					sbSelSql.append("       FSM_TERM_RECIPE_NAME_FUN(A.TERM_MENU_CD) || ']' INFO                                              	\n");
					sbSelSql.append("  FROM FSM_TERM_MENU_MST A                                                                              	\n");
					sbSelSql.append(" WHERE TERM_MENU_CD = '" + strMenuCD + "'                                                             		\n");

					pstmt = conn.prepareStatement(sbSelSql.toString());
					rs = pstmt.executeQuery();
					rs.next();

					strMsg = "�Ʒ� �Ĵ��� �ش���忡�� ����� �� ���� �����Ǻз��� ���ԵǾ� �ֽ��ϴ�.\n";
					strMsg = strMsg + " - " + rs.getString("INFO");
					//System.out.println(strMsg);

					rs.close();
					pstmt.close();

					this.setResultMessage(-1, strMsg ,out_vl);
					proc_output(response,out,out_vl,out_dl);
					return;
				}

				// 1.2 ���� ������ ��� ���̺� ����,�Ĵ�,�޴�����,����,�ڳʷ� ��ȸ�ؼ� ���� ���θ� �����Ѵ�.
				//   COUNT(*) <= 0�� ��� ������ �����Ѵ�.
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT MENU_CD \n");
				sbSelSql.append("  FROM FSM_REAL_MENU_MST \n");
				sbSelSql.append(" WHERE UPJANG = " + v_Upjang + " \n");
				sbSelSql.append("   AND HALL_CD = '" + v_Hall + "' \n");
				sbSelSql.append("   AND MENU_DATE = '" + v_Menudate + "' \n");
				sbSelSql.append("   AND MEAL = '" + v_Meal + "' \n");
				sbSelSql.append("   AND CORNER = '" + v_Corner + "' \n");
				sbSelSql.append("   AND EXPECT_MEAL_QTY > 0 \n");

				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery();

				if(rs.next())	// �޴��� �ִ°��
				{
					v_MenuCD = rs.getString("MENU_CD");

					rs.close();
					pstmt.close();

					// 2.0  ���� ������ ��� ���̺� ���ۼ��� �����ǰ� �ִ��� Ȯ���Ѵ�.
					//   COUNT(*) > 0�� �����󿡼� ���ܵȴ�.
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("SELECT COUNT(*) AS CNT						\n");
					sbSelSql.append("  FROM FSM_REAL_RECIPE_MST 				\n");
					sbSelSql.append(" WHERE UPJANG = " + v_Upjang + " 			\n");
					sbSelSql.append("   AND MENU_CD = '" + v_MenuCD + "' 		\n");

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
						ds_ResultDt.newRow();
						ds_ResultDt.set(nARow2,"MENU_DATE",v_Menudate);
						ds_ResultDt.set(nARow2,"MEAL",v_Meal);
						ds_ResultDt.set(nARow2,"CORNER",v_Corner);
						ds_ResultDt.set(nARow2,"MSG","������ �ۼ��� �Ĵ��� �ֽ��ϴ�.");
						nARow2 = nARow2 + 1;
					}
					else
					{
						// ����Ĵ��� �������� ����
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("UPDATE FSM_REAL_MENU_MST                 \n");
						sbInsSql.append("   SET ATTR01 = '" + v_costType + "'     \n");
						sbInsSql.append("     , ATTR02 = '" + v_orgCorner + "'    \n");
						sbInsSql.append(" WHERE UPJANG = " + v_Upjang + "         \n");
						sbInsSql.append("   AND MENU_CD = '" + v_MenuCD + "'      \n");
						sbInsSql.append("   AND MENU_DATE = '" + v_Menudate + "'  \n");
						sbInsSql.append("   AND HALL_CD = '" + v_Hall + "'        \n");
						sbInsSql.append("   AND MEAL = '" + v_Meal + "'           \n");
						sbInsSql.append("   AND CORNER = '" + v_Corner + "'       \n");
						sbInsSql.append("   AND EXPECT_MEAL_QTY > 0               \n");

	    				stmt 		=  conn.createStatement();
	    				stmt.execute(sbInsSql.toString());
	    				stmt.close();

						//  2.2 ���������� ����
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("-- 2.2 ������ ���� ����  																				\n");
						sbInsSql.append("INSERT INTO FSM_REAL_RECIPE_ITEM                                                                	\n");
						sbInsSql.append("            (UPJANG, MENU_CD, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC    	\n");
						sbInsSql.append("            ,ORDER_YN, PR_ID, PR_NUM, PR_QTY, NEED_DATE, UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE, ATTR10  	\n");
						sbInsSql.append("            ,ATTR02,CUSER, CDATE, UUSER, UDATE)                                                    	\n");
						sbInsSql.append("SELECT " + v_Upjang + " UPJANG -- �ϴ��� ����� �����                                            	\n");
						sbInsSql.append("      ,'" + v_MenuCD + "' MENU_CD -- �� 1������ �ҷ��� MENU_CD                              		\n");
						sbInsSql.append("      ,A.RECIPE_CD                                                                              	\n");
						sbInsSql.append("      ,A.ITEM_CODE                                                                              	\n");
						sbInsSql.append("      ,NVL(A.ITEM_SEQ,0) ITEM_SEQ                                                               	\n");
						sbInsSql.append("      ,A.NEED_QTY                                                                               	\n");
						sbInsSql.append("      ,A.EDIBLE_QTY                                                                             	\n");
						sbInsSql.append("      ,A.CUT_SPEC                                                                               	\n");
						sbInsSql.append("      ,'N' ORDER_YN                                                                             	\n");
						sbInsSql.append("      ,0 PR_ID                                                                                  	\n");
						sbInsSql.append("      ,'' PR_NUM                                                                                	\n");
						sbInsSql.append("      ,0 PR_QTY                                                                                 	\n");
						sbInsSql.append("      ,FSM_ITEM_NEED_DATE_FUN(" + v_Upjang + ", '" + v_Hall + "','" + v_Meal + "','" + v_Corner + "','" + v_Menudate + "' ) AS NEED_DATE \n");
						sbInsSql.append("      ,NVL(B.CONTRACT_PRICE,0) UNIT_PRICE                                                       	\n");
						sbInsSql.append("      ,NVL(B.MARGIN_RATE,0) MARGIN_RATE                                                         	\n");
						sbInsSql.append("      ,NVL(B.ITEM_PRICE,0) MARGIN_PRICE                                                         	\n");
						sbInsSql.append("      ,ATTR10                                                                                   	\n");
						sbInsSql.append("      ,REP_ITEM_YN AS ATTR02                                                                     	\n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                              				\n");
						sbInsSql.append("      ,SYSDATE CDATE                                                                          		\n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                             				\n");
						sbInsSql.append("      ,SYSDATE UDATE                                                                            	\n");
						sbInsSql.append("  FROM                                                                                          	\n");
						sbInsSql.append("       (                                                                                        	\n");
						sbInsSql.append("       SELECT C.RECIPE_CD, C.ITEM_CODE, C.ITEM_SEQ, C.ATTR10                                             	\n");
						sbInsSql.append("             ,C.NEED_QTY                                                                         	\n");
						sbInsSql.append("             ,ROUND(C.NEED_QTY * (100 - NVL((SELECT DISUSE_RATE FROM FSI_ITEM_NUT WHERE ITEM_CODE=C.ITEM_CODE),0)) / 100,2) AS EDIBLE_QTY, C.CUT_SPEC                                        	\n");
						sbInsSql.append("             ,NVL((SELECT REP_ITEM_YN                                                              \n");
						sbInsSql.append("                     FROM FSM_TERM_MENU_ITEM D                                                     \n");
						sbInsSql.append("                    WHERE D.TERM_MENU_CD = A.TERM_MENU_CD                                          \n");
						sbInsSql.append("                      AND D.RECIPE_CD = A.RECIPE_CD                                                \n");
						sbInsSql.append("                      AND D.ITEM_CODE = c.ITEM_CODE), 0) AS REP_ITEM_YN                            \n");
						sbInsSql.append("         FROM FSM_TERM_MENU_RECIPE A                                                            	\n");
						sbInsSql.append("             ,FSR_STD_RECIPE_MST B                                                              	\n");
						sbInsSql.append("             ,FSR_STD_RECIPE_ITEM C                                                             	\n");
						sbInsSql.append("        WHERE A.RECIPE_CD = B.RECIPE_CD                                                         	\n");
						sbInsSql.append("          AND B.RECIPE_CD = C.RECIPE_CD                                                         	\n");
						sbInsSql.append("          AND A.TERM_MENU_CD = '" + strMenuCD + "'                                              	\n");
						sbInsSql.append("       ) A                                                                                      	\n");
						sbInsSql.append("      ,( \n");
						sbInsSql.append("       SELECT A.ITEM_CODE, \n");
						sbInsSql.append("              A.CONTRACT_PRICE, \n");
						sbInsSql.append("              A.MARGIN_RATE, \n");
						sbInsSql.append("              DECODE(A.MARGIN_RATE, 0, A.CONTRACT_PRICE, DECODE(E.OUTVAT_FLAG, 'Y' , ( ROUND( (A.CONTRACT_PRICE * DECODE(D.TAX_CODE, '100' , 1.1, 1) * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) , ( ROUND( (A.CONTRACT_PRICE * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) ) ) AS ITEM_PRICE \n");
						sbInsSql.append("         FROM HLDC_ST_UPJANG B, \n");
						sbInsSql.append("              HLDC_PO_SUBINVENTORY E, \n");
						sbInsSql.append("              HLDC_PO_CONTRACT_F A, \n");
						sbInsSql.append("              HLDC_PO_ITEM_MST D \n");
						sbInsSql.append("        WHERE A.ITEM_CODE = D.ITEM_CODE \n");
						sbInsSql.append("          AND A.USE_YN = 'Y' \n");
						sbInsSql.append("          AND A.CONTRACT_PRICE > 0 \n");
						sbInsSql.append("          AND A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
						sbInsSql.append("          AND B.UPJANG = E.UPJANG \n");
						sbInsSql.append("          AND B.UPJANG = " + v_Upjang + "  --[�����ڵ�] \n");
						sbInsSql.append("          AND E.SUBINV_CODE = '" + v_subInvCode + "'  --[â���ڵ�] FSM_REAL_MENU_MST.SUBINV_CODE ���(�켱����), FSA_HALL_MST.SUBINV_CODE ��� \n");
						sbInsSql.append("          AND '" + v_Menudate + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999')  --[�޴�����] \n");
						sbInsSql.append("       ) B \n");
	                    sbInsSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                                             	\n");
	                    sbInsSql.append("   AND NOT EXISTS (                                                                             	\n");
	                    sbInsSql.append("               SELECT 1                                                                         	\n");
	                    sbInsSql.append("                 FROM FSM_REAL_RECIPE_MST C                                                     	\n");
	                    sbInsSql.append("                WHERE C.UPJANG = " + v_Upjang + "  -- �ϴ��� ����� �����                                				\n");
	                    sbInsSql.append("                  AND C.MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD          			\n");
	                    sbInsSql.append("                  AND C.RECIPE_CD = A.RECIPE_CD                                                 	\n");
	                    sbInsSql.append("               )                                                                                	\n");

	    				//System.out.println(sbInsSql.toString());
	    				stmt 		=  conn.createStatement();
	    				stmt.execute(sbInsSql.toString());
	    				stmt.close();

						// 2.3 ������ ������ ����
						// 2.3.1 �������ε�
						sbSelSql.delete(0, sbSelSql.length());
						sbSelSql.append("SELECT                                                                                	\n");
						sbSelSql.append("       " + v_Upjang + " UPJANG -- �ϴ��� ����� �����                                             				\n");
						sbSelSql.append("      ,'" + v_MenuCD + "' MENU_CD -- �� 1������ �ҷ��� MENU_CD                    			\n");
						sbSelSql.append("      ,A.RECIPE_CD                                                                    	\n");
						sbSelSql.append("      ,B.CUISINE_SEQ                                                                  	\n");
						sbSelSql.append("      ,B.CUISINE_DESC                                                                 	\n");
						sbSelSql.append("      ,'' PHOTO_PATH --���������� ������ �� ������ ���ϸ��� ����Ǿ�� �Ѵ�. \n");
						sbSelSql.append("      ,'' SPHOTO_PATH --���������� ������ �� ������ ���ϸ��� ����Ǿ�� �Ѵ�.\n");
						sbSelSql.append("      ,'" + g_EmpNo + "'                                                   			\n");
						sbSelSql.append("      ,SYSDATE CDATE                                                                  	\n");
						sbSelSql.append("      ,'" + g_EmpNo + "'                                                     			\n");
						sbSelSql.append("      ,SYSDATE UDATE                                                                  	\n");
						sbSelSql.append("  FROM FSM_TERM_MENU_RECIPE A                                                         	\n");
						sbSelSql.append("      ,FSR_STD_RECIPE_CUISINE B                                                       	\n");
						sbSelSql.append(" WHERE A.RECIPE_CD = B.RECIPE_CD                                                      	\n");
						sbSelSql.append("   AND A.TERM_MENU_CD =  '" + strMenuCD + "'                                       	\n");
						sbSelSql.append("   AND NOT EXISTS (                                                                   	\n");
						sbSelSql.append("               SELECT 1                                                               	\n");
						sbSelSql.append("                 FROM FSM_REAL_RECIPE_MST C                                           	\n");
						sbSelSql.append("                WHERE C.UPJANG = " + v_Upjang + "  -- �ϴ��� ����� �����                       		\n");
						sbSelSql.append("                  AND C.MENU_CD = '" + v_MenuCD + "'  -- �� 1������ �ҷ��� MENU_CD			\n");
						sbSelSql.append("                  AND C.RECIPE_CD = A.RECIPE_CD                                       	\n");
						sbSelSql.append("               )                                                                      	\n");

						//System.out.println(sbSelSql.toString());
						//pstmt = conn.prepareStatement(sbSelSql.toString());
						//rs = pstmt.executeQuery();

						// 2.3.2 ������ ������
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("-- 2.3 ������ ������ ���� 																					\n");
						sbInsSql.append("INSERT INTO FSM_REAL_RECIPE_CUISINE                                                          			\n");
						sbInsSql.append("           (UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH   			\n");
						sbInsSql.append("            ,CUSER, CDATE, UUSER, UDATE)                                                     			\n");
						sbInsSql.append(sbSelSql.toString());

						//System.out.println(sbInsSql.toString());
						stmt 		=  conn.createStatement();
						stmt.execute(sbInsSql.toString());
						stmt.close();

						// 2.4 �ߺ�������
						sbSelSql.delete(0, sbSelSql.length());
						sbSelSql.append("-- 2.4 �ߺ������ǿ� ���ؼ��� �Ʒ� SQL�� �̿��Ͽ� �˾�â�� ����ش�.                                                        				\n");
						sbSelSql.append("SELECT                                                                                                                     \n");
						sbSelSql.append("      A.MENU_DATE       --������                                                                                           												\n");
						sbSelSql.append("      ,(SELECT HALL_NAME FROM FSA_HALL_MST WHERE UPJANG = A.UPJANG AND HALL_CD = A.HALL_CD)  AS HALL_NAME       --�Ĵ�     	\n");
						sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL) MEAL_NAME --���ϸ�            		\n");
						sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --�ڳʸ�        		\n");
						sbSelSql.append("      ,B.RECIPE_CD                                                                                                         \n");
						sbSelSql.append("      ,B.RECIPE_NAME                                                                                                       \n");
						sbSelSql.append("  FROM FSM_REAL_MENU_MST A                                                                                                 \n");
						sbSelSql.append("      ,FSM_REAL_RECIPE_MST B                                                                                               \n");
						sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                 \n");
						sbSelSql.append("   AND A.MENU_CD = B.MENU_CD                                                                                               \n");
						sbSelSql.append("   AND A.UPJANG = " + v_Upjang + " --�ϴ��� ����� �����                                                                  										\n");
						sbSelSql.append("   AND A.MENU_CD = '" + v_MenuCD + "' --�� 1������ �ҷ��� MENU_CD                                                         		\n");
						sbSelSql.append("   AND EXISTS (                                                                                                            \n");
						sbSelSql.append("               SELECT 1                                                                                                    \n");
						sbSelSql.append("                 FROM FSM_TERM_MENU_RECIPE C                                                                                \n");
						sbSelSql.append("                WHERE C.TERM_MENU_CD = '" + strMenuCD + "'  -- ����� ���õ� MENU_CD                                     			\n");
						sbSelSql.append("                  AND C.RECIPE_CD = B.RECIPE_CD                                                                            \n");
						sbSelSql.append("               )                                                                                                           \n");

						//System.out.println(sbSelSql.toString());
						pstmt = conn.prepareStatement(sbSelSql.toString());
						rs = pstmt.executeQuery();

						while(rs.next())
						{
							ds_result.newRow(nARow);
							ds_result.set(nARow,"MENU_DATE",rs.getString("MENU_DATE"));
							ds_result.set(nARow,"HALL_NAME",rs.getString("HALL_NAME"));
							ds_result.set(nARow,"MEAL_NAME",rs.getString("MEAL_NAME"));
							ds_result.set(nARow,"CORNER_NAME",rs.getString("CORNER_NAME"));
							ds_result.set(nARow,"RECIPE_CD",rs.getString("RECIPE_CD"));
							ds_result.set(nARow,"RECIPE_NAME",rs.getString("RECIPE_NAME"));

							nARow = nARow + 1;
						}

						rs.close();
						pstmt.close();

						//  2.1 �����Ǻ���
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("-- 2.1 ������ ������ ���� : ���� �������ڵ�� ��ϵ� �����͸� ������ �����ǿ� ���ؼ��� ������ ����														\n");
						sbInsSql.append("INSERT INTO FSM_REAL_RECIPE_MST                                                                                               		\n");
						sbInsSql.append("SELECT " + v_Upjang + " -- �ϴ��� ����� �����                                                                                           				 							\n");
						sbInsSql.append("      ,'" + v_MenuCD + "' -- �� 1������ �ҷ��� MENU_CD                                                                    				\n");
						sbInsSql.append("      ,B.RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2                    		\n");
						sbInsSql.append("      ,COOK_TOOL1, COOK_TOOL2                                                                                                 		\n");
						sbInsSql.append("      ,A.DISH_INFO MAJOR_DISH_INFO                                                                                            		\n");
						sbInsSql.append("      ,RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER                                                   		\n");
						sbInsSql.append("      ,SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM       		\n");
						sbInsSql.append("      ,SALE_PRICE, COST_RATE, 0 COOK_1MAN_QTY, '' COOK_TIME, 0 EXPECT_SALE_QTY, 0 REAL_SALE_QTY, CORE_TEMPER_YN, GOODS_FEATURE		\n");
						sbInsSql.append("      ,PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, '' PREFER                      	\n");
						sbInsSql.append("      ,'01' ORIGIN_RECIPE                                                                                                        	\n");
						sbInsSql.append("      ,B.ATTR01, A.ATTR02 AS ATTR02, B.ATTR03, B.ATTR04, B.ATTR05, B.ATTR06, B.ATTR07, B.ATTR08, B.ATTR09, B.ATTR10                        	\n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                                                  							\n");
						sbInsSql.append("      ,SYSDATE CDATE                                                                                                             	\n");
						sbInsSql.append("      ,'" + g_EmpNo + "'                                                                                             				\n");
						sbInsSql.append("      ,SYSDATE UDATE                                                                                                             	\n");
						sbInsSql.append("      ,SPHOTO_PATH, PHF, 0 RECIPE_SEQ                                                                                         		\n");
						sbInsSql.append("  FROM FSM_TERM_MENU_RECIPE A                                                                                                 		\n");
						sbInsSql.append("      ,FSR_STD_RECIPE_MST B                                                                                                      	\n");
						sbInsSql.append(" WHERE A.RECIPE_CD = B.RECIPE_CD                                                                                                 	\n");
						sbInsSql.append("   AND A.TERM_MENU_CD = '" + strMenuCD + "'                                                                                     	\n");
						sbInsSql.append("   AND NOT EXISTS (                                                                                                             	\n");
						sbInsSql.append("               SELECT 1                                                                                                       		\n");
						sbInsSql.append("                 FROM FSM_REAL_RECIPE_MST C                                                                                      	\n");
						sbInsSql.append("                WHERE C.UPJANG = " + v_Upjang + "   -- �ϴ��� ����� �����                                                                								\n");
	                    sbInsSql.append("                  AND C.MENU_CD = '" + v_MenuCD + "'   -- �� 1������ �ҷ��� MENU_CD                                       				\n");
	                    sbInsSql.append("                  AND C.RECIPE_CD = A.RECIPE_CD                                                                               		\n");
	                    sbInsSql.append("               )                                                                                                                 	\n");

	    				//System.out.println(sbInsSql.toString());
	    				stmt 		=  conn.createStatement();
	    				stmt.execute(sbInsSql.toString());
	    				stmt.close();
					}
				}
				else
				{
					rs.close();
					pstmt.close();

					ds_ResultDt.newRow(nARow2);
					ds_ResultDt.set(nARow2,"MENU_DATE",v_Menudate);
					ds_ResultDt.set(nARow2,"MEAL",v_Meal);
					ds_ResultDt.set(nARow2,"CORNER",v_Corner);
					ds_ResultDt.set(nARow2,"MSG","�ļ������� �� �ֽʽÿ�.");
					nARow2 = nARow2 + 1;
				}
			}

		}

		conn.commit();
		out_dl.add(ds_result);
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