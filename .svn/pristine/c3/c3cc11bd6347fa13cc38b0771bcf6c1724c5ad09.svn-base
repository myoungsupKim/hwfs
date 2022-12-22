<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	try	{
			PlatformRequest platformRequest = this.proc_input(request);
			in_vl = platformRequest.getData().getVariableList();
			in_dl = platformRequest.getData().getDataSetList();

			// jsp log 서비스 시작
			logger.startIndividualLog(in_vl.getString("titLogId"));

			DataSet ds_cond  = in_dl.get("ds_cond");
			String TM_CD     = nullToBlank(ds_cond.getString(0, "TM_CD"));
			String UPJANG_CD = nullToBlank(ds_cond.getString(0, "UPJANG_CD"));
			String FR_MONTH  = nullToBlank(ds_cond.getString(0, "FR_MONTH"));
			String COST_TYPE = nullToBlank(ds_cond.getString(0, "COST_TYPE"));
			String AN_TARGET = nullToBlank(ds_cond.getString(0, "AN_TARGET"));
			String BIZ_CLASS = nullToBlank(ds_cond.getString(0, "BIZ_CLASS"));
			String LY_MONTH  = "";

			StringBuffer sbSql = new StringBuffer();
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT TO_CHAR(ADD_MONTHS('" + FR_MONTH +"'||'01', -12), 'YYYYMM') AS LY_MONTH FROM DUAL  \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();

			LY_MONTH = rs.getString("LY_MONTH");

			rs.close();
			pstmt.close();

			int nMonth = Integer.parseInt(FR_MONTH.substring(4, 6));

			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT TM_CD \n");
			sbSql.append("     , TM_NM TM_NAME \n");
			sbSql.append("     , UPJANG \n");
			sbSql.append("     , UPJANGNM UPJANG_NAME \n");
			sbSql.append("     , ACCT_CD \n");
			sbSql.append("     , ACCT_NM \n");
			sbSql.append("     , L_ACCT_CLASS \n");
			sbSql.append("     , M_ACCT_CLASS \n");
			sbSql.append("     , S_ACCT_CLASS \n");
			sbSql.append("     , SEQ \n");
			sbSql.append("     , CC_CD \n");
			sbSql.append("     , NVL(P_TYPE_A, 0) AS SIMU_SALE_AMT  -- 계획 매출액 \n");
			sbSql.append("     , NVL(R_TYPE_A, 0) AS SALE_AMT_A -- 실적 매출액 \n");
			sbSql.append("     , NVL(R_TYPE_AA, 0) AS SALE_AMT_B -- 전년 매출액 \n");
			sbSql.append("     , DECODE( NVL(P_TYPE_A, 0), 0, 0, ROUND((R_TYPE_A / P_TYPE_A) * 100)) AS SALE_RATE_A \n");
			sbSql.append("     , DECODE( NVL(R_TYPE_AA, 0), 0, 0, ROUND((NVL(P_TYPE_A, 0) / R_TYPE_AA) * 100)) AS SALE_RATE_B \n");
			sbSql.append("     , NVL(ADD_P_TYPE_A, 0) AS ADD_SIMU_SALE_AMT  -- 계획 매출액 \n");
			sbSql.append("     , NVL(ADD_R_TYPE_A, 0) AS ADD_SALE_AMT_A -- 실적 매출액 \n");
			sbSql.append("     , NVL(ADD_R_TYPE_AA, 0) AS ADD_SALE_AMT_B -- 전년 매출액 \n");
			sbSql.append("     , DECODE( NVL(ADD_P_TYPE_A, 0), 0, 0, ROUND((ADD_R_TYPE_A / ADD_P_TYPE_A) * 100)) AS ADD_SALE_RATE_A \n");
			sbSql.append("     , DECODE( NVL(ADD_R_TYPE_AA, 0), 0, 0, ROUND((NVL(ADD_P_TYPE_A, 0) / ADD_R_TYPE_AA) * 100)) AS ADD_SALE_RATE_B \n");
			sbSql.append("  FROM ( \n");
			sbSql.append("        SELECT TM_CD \n");
			sbSql.append("             , TM_NM \n");
			sbSql.append("             , UPJANG \n");
			sbSql.append("             , UPJANGNM \n");
			sbSql.append("             , B.ACCT_CD \n");
			sbSql.append("             , B.ACCT_NM \n");
			sbSql.append("             , B.L_ACCT_CLASS \n");
			sbSql.append("             , B.M_ACCT_CLASS \n");
			sbSql.append("             , B.S_ACCT_CLASS \n");
			sbSql.append("             , B.SEQ \n");
			sbSql.append("             , MAX(DECODE(CC_CD, NULL, CC_CD, CC_CD)) CC_CD \n");
			sbSql.append("             , MAX(DECODE(ACCT_TYPE, 'TYPE_A', P_MM_AMT, 0)) P_TYPE_A -- 계획 매출액 \n");
			sbSql.append("             , MAX(DECODE(ACCT_TYPE, 'TYPE_A', R_MM_AMT_A, 0)) R_TYPE_A -- 실적 매출액 \n");
			sbSql.append("             , MAX(DECODE(ACCT_TYPE, 'TYPE_A', R_MM_AMT_B, 0)) R_TYPE_AA -- 전년 매출액 \n");
			sbSql.append("             , MAX(DECODE(ACCT_TYPE, 'TYPE_A', ADD_P_MM_AMT, 0)) ADD_P_TYPE_A -- 누계 계획 매출액 \n");
			sbSql.append("             , MAX(DECODE(ACCT_TYPE, 'TYPE_A', ADD_R_MM_AMT_A, 0)) ADD_R_TYPE_A -- 누계 실적 매출액 \n");
			sbSql.append("             , MAX(DECODE(ACCT_TYPE, 'TYPE_A', ADD_R_MM_AMT_B, 0)) ADD_R_TYPE_AA -- 누계 전년 매출액 \n");
			sbSql.append("          FROM ( \n");
			sbSql.append("                SELECT TM_CD \n");
			sbSql.append("                     , TM_NM \n");
			sbSql.append("                     , UPJANG \n");
			sbSql.append("                     , UPJANGNM \n");
			sbSql.append("                     , CC_CD \n");
			sbSql.append("                     , ACCT_TYPE \n");
			sbSql.append("                     , ACCT_CD \n");

			if( COST_TYPE.equals("M") ) // 관리
			{

				sbSql.append("                     , CASE WHEN SUBSTR(ACCT_CD, 1, 5) = '42203'\n");
				sbSql.append("                            THEN NVL(ROUND(SUM(P_MM_AMT) * NVL((SUM(R_MM_MR_A) / 100), 1) / 1000), 0)\n");
				sbSql.append("                            ELSE ROUND(SUM(P_MM_AMT) / 1000)\n");
				sbSql.append("                        END AS P_MM_AMT\n");
				sbSql.append("                     , CASE WHEN SUBSTR(ACCT_CD, 1, 5) = '42203'\n");  
				sbSql.append("                            THEN NVL(ROUND(SUM(R_MM_AMT_A) * NVL((SUM(R_MM_MR_A) / 100), 1) / 1000), 0) \n");  
				sbSql.append("                            ELSE ROUND(SUM(R_MM_AMT_A) / 1000) \n");
				sbSql.append("                        END AS R_MM_AMT_A\n");
				sbSql.append("                     , CASE WHEN SUBSTR(ACCT_CD, 1, 5) = '42203' \n");  
				sbSql.append("                            THEN NVL(ROUND(SUM(R_MM_AMT_B) * NVL((SUM(R_MM_MR_B) / 100), 1) / 1000), 0) \n");  
				sbSql.append("                            ELSE ROUND(SUM(R_MM_AMT_B) / 1000) \n");
				sbSql.append("                        END AS R_MM_AMT_B \n");
			}
			else if( COST_TYPE.equals("U") ) // 재무
			{
				sbSql.append("                     , ROUND(SUM(P_MM_AMT) / 1000) AS P_MM_AMT \n");
				sbSql.append("                     , ROUND(SUM(R_MM_AMT_A) / 1000) AS R_MM_AMT_A \n");
				sbSql.append("                     , ROUND(SUM(R_MM_AMT_B) / 1000) AS R_MM_AMT_B \n");
			}
			sbSql.append("                     , SUM(ADD_P_MM_AMT) AS ADD_P_MM_AMT \n");
			sbSql.append("                     , SUM(ADD_R_MM_AMT_A) AS ADD_R_MM_AMT_A \n");
			sbSql.append("                     , SUM(ADD_R_MM_AMT_B) AS ADD_R_MM_AMT_B \n");
			sbSql.append("                  FROM ( \n");
			sbSql.append("                        SELECT V.TM_CD \n");
			sbSql.append("                             , V.TM_NAME AS TM_NM \n");
			sbSql.append("                             , V.UPJANG \n");
			sbSql.append("                             , A.CC_NM AS UPJANGNM \n");
			sbSql.append("                             , A.CC_CD \n");
			sbSql.append("                             , ( CASE WHEN SUBSTR(A.ACCT_CD, 1, 2) = '41'  THEN 'TYPE_A' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 2) = '42'  THEN 'TYPE_B' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 3) = '431' THEN 'TYPE_C' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 3) = '432' THEN 'TYPE_D' \n");
			sbSql.append("                                 ELSE 'ETC' \n");
			sbSql.append("                                  END \n");
			sbSql.append("                               ) ACCT_TYPE \n");
			sbSql.append("                             , A.ACCT_CD \n");
			sbSql.append("                             , NVL(B.MM_AMT_" + FR_MONTH.substring(4, 6) + ", 0) AS P_MM_AMT  -- 조회월 계획 \n");
			sbSql.append("                             , NVL(A.MM_AMT_" + FR_MONTH.substring(4, 6) + ", 0) AS R_MM_AMT_A  -- 조회월 실적 \n");
			sbSql.append("                             , NVL(C.MM_MARGIN_RATE_" + FR_MONTH.substring(4, 6) + ", 0) AS R_MM_MR_A  -- 조회월 출하율 \n");
			sbSql.append("                             , 0 AS R_MM_AMT_B \n");
			sbSql.append("                             , 0 AS R_MM_MR_B \n");
			sbSql.append("                             , 0 AS ADD_P_MM_AMT \n");
			sbSql.append("                             , 0 AS ADD_R_MM_AMT_A \n");
			sbSql.append("                             , 0 AS ADD_R_MM_AMT_B \n");
			sbSql.append("                          FROM MAP_UPJANG_PL A -- SAP 실적 \n");
			sbSql.append("                             , MAP_BIZ_PLAN B -- 사업계획 \n");
			sbSql.append("                             , (SELECT A.* \n");
			sbSql.append("                                  FROM MAP_MARGIN_RATE_MGMT A \n");
			sbSql.append("                                     , MAC_UPJANG_V B \n");
			sbSql.append("                                 WHERE A.UPJANG(+) = B.UPJANG \n");
			sbSql.append("                                   AND B.UPJANG = " + UPJANG_CD + " \n");
			sbSql.append("                                   AND A.YY = SUBSTR('" + FR_MONTH + "', 1, 4) \n");
			sbSql.append("                                   AND A.CLASS = 'P') C \n");
			sbSql.append("                             , MAC_UPJANG_V V \n");
			sbSql.append("                         WHERE 1 = 1 \n");
			sbSql.append("                           AND A.CC_CD = B.CC_CD(+) \n");
			sbSql.append("                           AND A.FISCAL_YEAR = B.YY(+) \n");
			sbSql.append("                           AND A.ACCT_CD = B.ACCT_CD(+) \n");
			sbSql.append("                           AND V.UPJANG = C.UPJANG(+) \n");
			sbSql.append("                           AND B.BIZ_CLASS(+) = '" + BIZ_CLASS + "' \n");
			sbSql.append("                           AND A.CC_CD = V.CC_CD(+) \n");
			sbSql.append("                           AND A.PL_CLASS = 'KS' \n");
			sbSql.append("                           AND A.FISCAL_YEAR = SUBSTR('" + FR_MONTH + "', 1, 4) \n");
			sbSql.append("                           AND V.UPJANG = " + UPJANG_CD + " \n");
			sbSql.append("                         UNION ALL \n");
			sbSql.append("                        SELECT V.TM_CD \n");
			sbSql.append("                             , V.TM_NAME AS TM_NM \n");
			sbSql.append("                             , V.UPJANG \n");
			sbSql.append("                             , A.CC_NM AS UPJANGNM \n");
			sbSql.append("                             , A.CC_CD \n");
			sbSql.append("                             , ( CASE WHEN SUBSTR(A.ACCT_CD, 1, 2) = '41'  THEN 'TYPE_A' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 2) = '42'  THEN 'TYPE_B' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 3) = '431' THEN 'TYPE_C' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 3) = '432' THEN 'TYPE_D' \n");
			sbSql.append("                                  ELSE 'ETC' \n");
			sbSql.append("                                   END \n");
			sbSql.append("                               ) ACCT_TYPE \n");
			sbSql.append("                             , A.ACCT_CD \n");
			sbSql.append("                             , 0 AS P_MM_AMT  -- 조회월 계획 \n");
			sbSql.append("                             , 0 AS R_MM_AMT_A  -- 조회월 실적 \n");
			sbSql.append("                             , 0 AS R_MM_MR_A  -- 조회월 출하율 \n");
			sbSql.append("                             , NVL(A.MM_AMT_" + LY_MONTH.substring(4, 6) + ", 0) AS R_MM_AMT_B  -- 전년 실적 \n");
			sbSql.append("                             , NVL(C.MM_MARGIN_RATE_" + LY_MONTH.substring(4, 6) + ", 0) AS R_MM_MR_B  -- 전년 출하율 \n");
			sbSql.append("                             , 0 AS ADD_P_MM_AMT \n");
			sbSql.append("                             , 0 AS ADD_R_MM_AMT_A \n");
			sbSql.append("                             , 0 AS ADD_R_MM_AMT_B \n");
			sbSql.append("                          FROM MAP_UPJANG_PL A -- SAP 실적 \n");
			sbSql.append("                             , MAP_BIZ_PLAN B -- 사업계획 \n");
			sbSql.append("                             , (SELECT A.* \n");
			sbSql.append("                                  FROM MAP_MARGIN_RATE_MGMT A \n");
			sbSql.append("                                     , MAC_UPJANG_V B \n");
			sbSql.append("                                 WHERE A.UPJANG(+) = B.UPJANG \n");
			sbSql.append("                                   AND B.UPJANG = " + UPJANG_CD + " \n");
			sbSql.append("                                   AND A.YY = SUBSTR('" + LY_MONTH + "', 1, 4) \n");
			sbSql.append("                                   AND A.CLASS = 'P') C \n");
			sbSql.append("                             , MAC_UPJANG_V V \n");
			sbSql.append("                         WHERE 1 = 1 \n");
			sbSql.append("                           AND A.CC_CD = B.CC_CD(+) \n");
			sbSql.append("                           AND A.FISCAL_YEAR = B.YY(+) \n");
			sbSql.append("                           AND A.ACCT_CD = B.ACCT_CD(+) \n");
			sbSql.append("                           AND V.UPJANG = C.UPJANG(+) \n");
			sbSql.append("                           AND B.BIZ_CLASS(+) = '" + BIZ_CLASS + "' \n");
			sbSql.append("                           AND A.CC_CD = V.CC_CD(+) \n");
			sbSql.append("                           AND A.PL_CLASS = 'KS' \n");
			sbSql.append("                           AND A.FISCAL_YEAR = SUBSTR('" + LY_MONTH + "', 1, 4) \n");
			sbSql.append("                           AND V.UPJANG = " + UPJANG_CD + " \n");
			sbSql.append("                         UNION ALL \n");
			sbSql.append("                        SELECT V.TM_CD \n");
			sbSql.append("                             , V.TM_NAME AS TM_NM \n");
			sbSql.append("                             , V.UPJANG \n");
			sbSql.append("                             , A.CC_NM AS UPJANGNM \n");
			sbSql.append("                             , A.CC_CD \n");
			sbSql.append("                             , ( CASE WHEN SUBSTR(A.ACCT_CD, 1, 2) = '41'  THEN 'TYPE_A' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 2) = '42'  THEN 'TYPE_B' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 3) = '431' THEN 'TYPE_C' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 3) = '432' THEN 'TYPE_D' \n");
			sbSql.append("                                 ELSE 'ETC' \n");
			sbSql.append("                                  END \n");
			sbSql.append("                               ) ACCT_TYPE \n");
			sbSql.append("                             , A.ACCT_CD \n");
			sbSql.append("                             , 0 AS P_MM_AMT \n");
			sbSql.append("                             , 0 AS R_MM_AMT_A \n");
			sbSql.append("                             , 0 AS R_MM_MR_A \n");
			sbSql.append("                             , 0 AS R_MM_AMT_B \n");
			sbSql.append("                             , 0 AS R_MM_MR_B \n");
			// 관리
			if( COST_TYPE.equals("M") )
			{
				sbSql.append("                             , ( \n");
				for( int i = 1; i <= nMonth; i++ )
				{
					if( i == 1 )
					{
						if( i < 10 )
						{
							sbSql.append("                                  CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(B.MM_AMT_0" + i + " * NVL((C.MM_MARGIN_RATE_0" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(B.MM_AMT_0" + i + " / 1000) \n");
							sbSql.append("                                   END \n");
						}
						else
						{
							sbSql.append("                                  CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(B.MM_AMT_" + i + " * NVL((C.MM_MARGIN_RATE_" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(B.MM_AMT_" + i + " / 1000) \n");
							sbSql.append("                                   END \n");							
						}
					}
					else
					{
						if( i < 10 )
						{
							sbSql.append("                                + CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(B.MM_AMT_0" + i + " * NVL((C.MM_MARGIN_RATE_0" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(B.MM_AMT_0" + i + " / 1000) \n");
							sbSql.append("                                   END \n");
						}
						else
						{
							sbSql.append("                                + CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(B.MM_AMT_" + i + " * NVL((C.MM_MARGIN_RATE_" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(B.MM_AMT_" + i + " / 1000) \n");
							sbSql.append("                                   END \n");	
						}
					}
				}
				sbSql.append("                               ) AS ADD_P_MM_AMT -- 누계 계획비 \n");

				sbSql.append("                             , ( \n");
				for( int i = 1; i <= nMonth; i++ )
				{
					if( i == 1 )
					{
						if( i < 10 )
						{
							sbSql.append("                                  CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(A.MM_AMT_0" + i + " * NVL((C.MM_MARGIN_RATE_0" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(A.MM_AMT_0" + i + " / 1000) \n");
							sbSql.append("                                   END \n");
						}
						else
						{
							sbSql.append("                                  CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(A.MM_AMT_" + i + " * NVL((C.MM_MARGIN_RATE_" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(A.MM_AMT_" + i + " / 1000) \n");
							sbSql.append("                                   END \n");							
						}
					}
					else
					{
						if( i < 10 )
						{
							sbSql.append("                                + CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(A.MM_AMT_0" + i + " * NVL((C.MM_MARGIN_RATE_0" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(A.MM_AMT_0" + i + " / 1000) \n");
							sbSql.append("                                   END \n");
						}
						else
						{
							sbSql.append("                                + CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(A.MM_AMT_" + i + " * NVL((C.MM_MARGIN_RATE_" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(A.MM_AMT_" + i + " / 1000) \n");
							sbSql.append("                                   END \n");	
						}
					}
				}
				sbSql.append("                               ) AS ADD_R_MM_AMT_A  -- 누계 실적비 \n");
			}
			// 재무
			else if( COST_TYPE.equals("U") )
			{
				sbSql.append("                             , ( \n");
				for( int i = 1; i <= nMonth; i++ )
				{
					if( i == 1 )
					{
						if( i < 10 )
							sbSql.append("                                  ROUND(B.MM_AMT_0" + i + " / 1000) \n");
						else
							sbSql.append("                                  ROUND(B.MM_AMT_" + i + " / 1000) \n");
					}
					else
					{
						if( i < 10 )
							sbSql.append("                                + ROUND(B.MM_AMT_0" + i + " / 1000) \n");
						else
							sbSql.append("                                + ROUND(B.MM_AMT_" + i + " / 1000) \n");
					}
				}
				sbSql.append("                               ) AS ADD_P_MM_AMT -- 누계 계획비 \n");
				sbSql.append("                             , ( \n");
				for( int i = 1; i <= nMonth; i++ )
				{
					if( i == 1 )
					{
						if( i < 10 )
							sbSql.append("                                  ROUND(A.MM_AMT_0" + i + " / 1000) \n");
						else
							sbSql.append("                                  ROUND(A.MM_AMT_" + i + " / 1000) \n");
					}
					else
					{
						if( i < 10 )
							sbSql.append("                                + ROUND(A.MM_AMT_0" + i + " / 1000) \n");
						else
							sbSql.append("                                + ROUND(A.MM_AMT_" + i + " / 1000) \n");
					}
				}
				sbSql.append("                               ) AS ADD_R_MM_AMT_A -- 누계 실적비 \n");
			}
			sbSql.append("                             , 0 AS ADD_R_MM_AMT_B  -- 전년 실적 \n"); 
			sbSql.append("                          FROM MAP_UPJANG_PL A -- SAP 실적 \n");
			sbSql.append("                             , MAP_BIZ_PLAN B -- 사업계획 \n");
			sbSql.append("                             , (SELECT A.* \n");
			sbSql.append("                                  FROM MAP_MARGIN_RATE_MGMT A \n");
			sbSql.append("                                     , MAC_UPJANG_V B \n");
			sbSql.append("                                 WHERE A.UPJANG(+) = B.UPJANG \n");
			sbSql.append("                                   AND B.UPJANG = " + UPJANG_CD + " \n");
			sbSql.append("                                   AND A.YY = SUBSTR('" + FR_MONTH + "', 1, 4) \n");
			sbSql.append("                                   AND A.CLASS = 'P') C \n");
			sbSql.append("                             , MAC_UPJANG_V V \n");
			sbSql.append("                         WHERE 1 = 1 \n");
			sbSql.append("                           AND A.CC_CD = B.CC_CD(+) \n");
			sbSql.append("                           AND A.FISCAL_YEAR = B.YY(+) \n");
			sbSql.append("                           AND A.ACCT_CD = B.ACCT_CD(+) \n");
			sbSql.append("                           AND V.UPJANG = C.UPJANG(+) \n");
			sbSql.append("                           AND B.BIZ_CLASS(+) = '" + BIZ_CLASS + "' \n");
			sbSql.append("                           AND A.CC_CD = V.CC_CD(+) \n");
			sbSql.append("                           AND A.PL_CLASS = 'KS' \n");
			sbSql.append("                           AND A.FISCAL_YEAR = SUBSTR('" + FR_MONTH + "', 1, 4) \n");
			sbSql.append("                           AND V.UPJANG = " + UPJANG_CD + " \n");
			sbSql.append("                         UNION ALL \n");
			sbSql.append("                        SELECT V.TM_CD \n");
			sbSql.append("                             , V.TM_NAME AS TM_NM \n");
			sbSql.append("                             , V.UPJANG \n");
			sbSql.append("                             , A.CC_NM AS UPJANGNM \n");
			sbSql.append("                             , A.CC_CD \n");
			sbSql.append("                             , ( CASE WHEN SUBSTR(A.ACCT_CD, 1, 2) = '41'  THEN 'TYPE_A' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 2) = '42'  THEN 'TYPE_B' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 3) = '431' THEN 'TYPE_C' \n");
			sbSql.append("                                      WHEN SUBSTR(A.ACCT_CD, 1, 3) = '432' THEN 'TYPE_D' \n");
			sbSql.append("                                 ELSE 'ETC' \n");
			sbSql.append("                                  END \n");
			sbSql.append("                               ) ACCT_TYPE \n");
			sbSql.append("                             , A.ACCT_CD \n");
			sbSql.append("                             , 0 AS P_MM_AMT \n");
			sbSql.append("                             , 0 AS R_MM_AMT_A \n");
			sbSql.append("                             , 0 AS R_MM_MR_A \n");
			sbSql.append("                             , 0 AS R_MM_AMT_B \n");
			sbSql.append("                             , 0 AS R_MM_MR_B \n");
			sbSql.append("                             , 0 AS ADD_P_MM_AMT -- 누계 계획비 \n");
			sbSql.append("                             , 0 AS ADD_R_MM_AMT_A  -- 누계 실적 \n");
			// 관리
			if( COST_TYPE.equals("M") )
			{
				sbSql.append("                             , ( \n");
				for( int i = 1; i <= nMonth; i++ )
				{
					if( i == 1 )
					{
						if( i < 10 )
						{
							sbSql.append("                                  CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(A.MM_AMT_0" + i + " * NVL((C.MM_MARGIN_RATE_0" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(A.MM_AMT_0" + i + " / 1000) \n");
							sbSql.append("                                   END \n");
						}
						else
						{
							sbSql.append("                                  CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(A.MM_AMT_" + i + " * NVL((C.MM_MARGIN_RATE_" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(A.MM_AMT_" + i + " / 1000) \n");
							sbSql.append("                                   END \n");							
						}
					}
					else
					{
						if( i < 10 )
						{
							sbSql.append("                                + CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(A.MM_AMT_0" + i + " * NVL((C.MM_MARGIN_RATE_0" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(A.MM_AMT_0" + i + " / 1000) \n");
							sbSql.append("                                   END \n");
						}
						else
						{
							sbSql.append("                                + CASE WHEN SUBSTR(A.ACCT_CD, 1, 5) = '42203' \n");
							sbSql.append("                                       THEN NVL(ROUND(A.MM_AMT_" + i + " * NVL((C.MM_MARGIN_RATE_" + i + " / 100), 1) / 1000), 0) \n");
							sbSql.append("                                       ELSE ROUND(A.MM_AMT_" + i + " / 1000) \n");
							sbSql.append("                                   END \n");	
						}
					}
				}
				sbSql.append("                               ) AS ADD_R_MM_AMT_B -- 누계 전년 실적비 \n");
			}
			// 재무
			else if( COST_TYPE.equals("U") )
			{
				sbSql.append("                             , ( \n");
				for( int i = 1; i <= nMonth; i++ )
				{
					if( i == 1 )
					{
						if( i < 10 )
							sbSql.append("                                  ROUND(B.MM_AMT_0" + i + " / 1000) \n");
						else
							sbSql.append("                                  ROUND(B.MM_AMT_" + i + " / 1000) \n");
					}
					else
					{
						if( i < 10 )
							sbSql.append("                                + ROUND(B.MM_AMT_0" + i + " / 1000) \n");
						else
							sbSql.append("                                + ROUND(B.MM_AMT_" + i + " / 1000) \n");
					}
				}
				sbSql.append("                               ) AS ADD_R_MM_AMT_B -- 누계 계획비 \n");
			}
			sbSql.append("                          FROM MAP_UPJANG_PL A -- SAP 실적 \n");
			sbSql.append("                             , MAP_BIZ_PLAN B -- 사업계획 \n");
			sbSql.append("                             , (SELECT A.* \n");
			sbSql.append("                                  FROM MAP_MARGIN_RATE_MGMT A \n");
			sbSql.append("                                     , MAC_UPJANG_V B \n");
			sbSql.append("                                 WHERE A.UPJANG(+) = B.UPJANG \n");
			sbSql.append("                                   AND B.UPJANG = " + UPJANG_CD + " \n");
			sbSql.append("                                   AND A.YY = SUBSTR('" + LY_MONTH + "', 1, 4) \n");
			sbSql.append("                                   AND A.CLASS = 'P') C \n");
			sbSql.append("                             , MAC_UPJANG_V V \n");
			sbSql.append("                         WHERE 1 = 1 \n");
			sbSql.append("                           AND A.CC_CD = B.CC_CD(+) \n");
			sbSql.append("                           AND A.FISCAL_YEAR = B.YY(+) \n");
			sbSql.append("                           AND A.ACCT_CD = B.ACCT_CD(+) \n");
			sbSql.append("                           AND V.UPJANG = C.UPJANG(+) \n");
			sbSql.append("                           AND B.BIZ_CLASS(+) = '" + BIZ_CLASS + "' \n");
			sbSql.append("                           AND A.CC_CD = V.CC_CD(+) \n");
			sbSql.append("                           AND A.PL_CLASS = 'KS' \n");
			sbSql.append("                           AND A.FISCAL_YEAR = SUBSTR('" + LY_MONTH + "', 1, 4) \n");
			sbSql.append("                           AND V.UPJANG = " + UPJANG_CD + " \n");
			sbSql.append("                       ) \n");
			sbSql.append("                 GROUP BY TM_CD, TM_NM, UPJANG, UPJANGNM, CC_CD, ACCT_TYPE, ACCT_CD \n");
			sbSql.append("               ) A \n");
			sbSql.append("             , ( SELECT SEQ \n");
			sbSql.append("                      , ACCTNM1 AS L_ACCT_CLASS \n");
			sbSql.append("                      , ACCTNM2 AS M_ACCT_CLASS \n");
			sbSql.append("                      , ACCTNM3 AS S_ACCT_CLASS \n");
			sbSql.append("                      , ACCTNM4 AS ACCT_NM \n");
			sbSql.append("                      , ACCTCD AS ACCT_CD \n");
			sbSql.append("                   FROM MAS_ST_ACCOUNT \n");
			sbSql.append("               ) B  --계정맵핑 \n");
			sbSql.append("         WHERE A.ACCT_CD(+) = B.ACCT_CD \n");
			sbSql.append("         GROUP BY TM_CD, TM_NM, UPJANG, UPJANGNM, B.L_ACCT_CLASS, B.M_ACCT_CLASS, B.S_ACCT_CLASS, B.ACCT_CD, B.ACCT_NM, SEQ \n");
			sbSql.append("       ) \n");
			sbSql.append(" ORDER BY SEQ \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();

			DataSet ds_list = this.makeDataSet(rs, "ds_list");
			out_dl.add(ds_list);

		   	this.setResultMessage(0, "OK", out_vl);
	}
	catch( Exception ex )
	{
		// jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(), out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try {
				rs.close();
			} catch( Exception e ) {}
		}
		if( pstmt != null )
		{
			try {
				pstmt.close();
			} catch( Exception e ) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			} catch( Exception e ) {}
		}

		// jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>