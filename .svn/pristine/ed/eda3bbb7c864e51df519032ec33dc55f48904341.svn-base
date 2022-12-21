<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//입력 데이타                                                                                                                                                                                         
		DataSet ds_condi = in_dl.get("ds_condi");

		String SEARCH_TYPE = nullToBlank(ds_condi.getString(0, "SEARCH_TYPE"));	//창고 & 부서구분
		String SEARCH_CODE = nullToBlank(ds_condi.getString(0, "SEARCH_CODE"));	//창고코드 & 부서코드
		String START_DT    = nullToBlank(ds_condi.getString(0, "START_DT"));	//시작일자
		String END_DT      = nullToBlank(ds_condi.getString(0, "END_DT"));		//종료일자
		String CUSTCD      = nullToBlank(ds_condi.getString(0, "CUSTCD"));		//거래처코드
		String CHK1        = nullToBlank(ds_condi.getString(0, "CHK1"));		//
		String CHK2        = nullToBlank(ds_condi.getString(0, "CHK2"));
		String CHK3        = nullToBlank(ds_condi.getString(0, "CHK3"));
		String strIPo      = nullToBlank(ds_condi.getString(0, "I_PO"));
		String strITrans   = nullToBlank(ds_condi.getString(0, "I_TRANS"));
		String TRANS_DATE  = in_vl.getString("p_trans_date"); 

		stmt = conn.createStatement();

		//out 데이타                                                                                                                                                                                        
		DataSet ds_out;

		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());
		
			// 구매검수내역
			sbSql.append("/* fs/fsp/FSP00200V_T002.jsp	*/														\n");
			sbSql.append("SELECT /*+ push_pred(F) */															\n");
			sbSql.append(" 		 A.ITEM_CODE																	\n");
			sbSql.append("     , A.ITEM_NAME																	\n");
			sbSql.append("     , A.TRANS_DATE																	\n");
			sbSql.append("     , A.TRANS_UPJANG																	\n");
			sbSql.append("     , A.SUBINV_CODE																	\n");
			sbSql.append("     , A.CUSTCD   																	\n");
			sbSql.append("     , A.ITEM_SIZE																	\n");
			sbSql.append("     , A.TRANS_UOM																	\n");
			//sbSql.append("     , CASE WHEN A.TRANS_MPRICE < 5 THEN A.TRANS_MPRICE ELSE ROUND(A.TRANS_MPRICE, -1) END AS TRANS_MPRICE																	\n");
			//20191113 문재현대리 요청 소수점 첫째자리 반올림으로 수정
			sbSql.append("     , CASE WHEN A.TRANS_MPRICE < 5 THEN A.TRANS_MPRICE ELSE ROUND(A.TRANS_MPRICE, 1) END AS TRANS_MPRICE																	\n");
			sbSql.append("     , A.TRANS_QTY																	\n");
			//sbSql.append("     , CASE WHEN A.TRANS_MPRICE < 5 THEN ROUND(A.TRANS_MPRICE * TRANS_QTY, -1)  ELSE ROUND(A.TRANS_MPRICE, -1) * TRANS_QTY END AS TRANS_MAMOUNT																\n");
			sbSql.append("     , CASE WHEN A.TRANS_MPRICE < 5 THEN ROUND(A.TRANS_MPRICE * TRANS_QTY, 1)  ELSE ROUND(A.TRANS_MPRICE, 1) * TRANS_QTY END AS TRANS_MAMOUNT																\n");
			sbSql.append("     , NVL(TRIM(A.SUBINV_CODE||' '||B.SUBINV_NAME), D.MU_NM||' '||D.CC_NM) AS CC_NM	\n");
			sbSql.append("     , A.TAX_CODE																		\n");
			sbSql.append("     , A.ACCTCD||' '||E.ACCTNM4||' '||E.ACCTNM6 AS ACCTNM								\n");
			sbSql.append("     , F.VD_NM ||'('||F.BIZ_REG_NO ||')' AS CUSTNM									\n");
			sbSql.append("     , DECODE(A.TRANS_TYPE,'I_PO','구매','센터') AS TRANS_GUBUN						    \n");
			sbSql.append("     , G.GRP_CD AS EPRO_FILE_GRP						    \n");
			sbSql.append("  FROM HLDC_PO_TRANSACTION A															\n");
			sbSql.append("     , HLDC_PO_SUBINVENTORY B															\n");
			sbSql.append("     , HLDC_SC_DEPT_V D																\n");
			sbSql.append("     , ST_ACCOUNT E																	\n");
			
			/*sbSql.append("     , VO_FC_VENDOR F																	\n");*/
			sbSql.append("          , (SELECT VDGL.VD_NM_LOC AS VD_NM																	\n");
			sbSql.append("                  , VDGL.BIZ_REG_NO AS BIZ_REG_NO                                                             \n");
			sbSql.append("                  , VDGL.VD_CD AS VD_CD                                                                       \n");
			sbSql.append("               FROM EPROCUSR.ESMVDGL VDGL                                                                     \n");
			sbSql.append("                 INNER JOIN EPROCUSR.ESMVDOG VDOG                                                             \n");
			sbSql.append("                     ON VDGL.SYS_ID = VDOG.SYS_ID                                                             \n");
			sbSql.append("                     AND VDGL.VD_SN = VDOG.VD_SN                                                              \n");
			sbSql.append("                WHERE VDGL.SYS_ID = '100'                                                                     \n");
			sbSql.append("                AND VDOG.OPER_ORG_SN = '414'                                                                  \n");
			sbSql.append("                 AND VDOG.TRADSTS = 'Y'                                                                       \n");
			sbSql.append("     --            AND VDOG.REG_TYP = 'C'                                                                     \n");
			sbSql.append("                 AND VDOG.STS <> 'D'                                                                          \n");
			sbSql.append("                 AND VDGL.CARD_VD_YN = 'N'                                                                    \n");
			sbSql.append("             UNION                                                                                            \n");
			sbSql.append("             SELECT  VD_NM_LOC AS VD_NM                                                                       \n");
			sbSql.append("                     ,BIZ_REG_NO AS BIZ_RE_NO                                                                 \n");
			sbSql.append("                     ,VD_CD AS VD_CD                                                                          \n");
			sbSql.append("                 FROM EPROCUSR.ESMVDGL VDGL WHERE VD_STS = 'D' AND CARD_VD_YN = 'N'                           \n");
			sbSql.append("          ) F                                                                                                 \n");
			sbSql.append("          ,EPROCUSR.ESPPODT_ESAATTH G                                                                                                 \n");
			
			
			sbSql.append(" WHERE A.TRANS_DEPT_ID = D.DEPT_ID													\n");
			sbSql.append("   AND A.SUBINV_CODE   = B.SUBINV_CODE(+)												\n");
			sbSql.append("   AND A.ACCTCD        = E.ACCTCD														\n");
			sbSql.append("   AND A.PO_NO		 = G.PO_NO(+)													\n");
			sbSql.append("   AND A.PO_LNO		 = G.PO_LNO(+)													\n");
			sbSql.append("   AND A.CUSTCD        = F.VD_CD 														\n");
			sbSql.append("   AND D.BU_CD         = E.BU_CD														\n");
			sbSql.append("   AND A.TRANS_TYPE    BETWEEN 'I001'     AND 'I002'									\n");
			sbSql.append("   AND A.SOURCE_TYPE   = 'PO'															\n");
			//sbSql.append("   AND A.TRANS_DATE    =	'" + TRANS_DATE + "'										\n");
			sbSql.append("   AND A.TRANS_DATE    =	:transDate										\n");
			if(SEARCH_TYPE.equals("S")){	// 창고
				//sbSql.append("   AND A.SUBINV_CODE   = '" + SEARCH_CODE + "'									\n");
				sbSql.append("   AND A.SUBINV_CODE   = :searchCode									\n");
			}
			else	// 부서
			{
				//sbSql.append("   AND A.TRANS_DEPT_ID = '" + SEARCH_CODE + "'									\n");
				sbSql.append("   AND A.TRANS_DEPT_ID = :searchCode									\n");
				if (CHK2.equals("1"))
					sbSql.append("   AND A.SUBINV_CODE IS NULL \n");
			}
			// 거래처코드가 null이 아닐경우
			if(!CUSTCD.equals(""))
				//sbSql.append("   AND A.CUSTCD        = '" + CUSTCD + "'										\n");
				sbSql.append("   AND A.CUSTCD        = :custcd										\n");
			sbSql.append("  ORDER BY A.ITEM_CODE															\n");
			
		//pstmt = conn.prepareStatement(sbSql.toString());
		npstmt = new NamedParameterStatement(conn, sbSql.toString());
		npstmt.setString("transDate", TRANS_DATE);
		npstmt.setString("searchCode", SEARCH_CODE);
		if(!CUSTCD.equals("")) {
			npstmt.setString("custcd", CUSTCD);
		}
		rs = npstmt.executeQuery();
		ds_out = this.makeDataSet(rs, "ds_out");
		npstmt.close();
		rs.close();
		
		/**종료**/
		out_dl.add(ds_out);
		this.setResultMessage(0, "OK", out_vl);

	} catch (Exception ex) {
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(), out_vl);
	} finally {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
			}
		}
		if (npstmt != null) {
            try {
                npstmt.close();
            } catch (Exception e) {
            }
        }
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
			}
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>