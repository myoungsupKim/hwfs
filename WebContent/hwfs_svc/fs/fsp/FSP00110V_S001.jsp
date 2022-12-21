<%-----------------------------------------------------------
 - Project	   : 한화 FS System
 - MenuID	   : 메뉴관리 >	구매관리 > 입고관리	> 입고예정현황조회
 - ViewPage	   : FSP00110V.xml 
 - Description : 입고예정현황 조회
 - Author	   : 손	창 덕
 - History	   : 1)	2008. 03. 18 - 최초작성.
 -				 2)	2017.03.25	kihoon	[CH201703_00631] 구매 첨부파일 다운로드
 ------------------------------------------------------------%>

<%@	page contentType="text/html; charset=EUC-KR"%>
<%@	include	file="../../sc/main/common.jsp"%>
<%
	try	{
		PlatformRequest	platformRequest	= this.proc_input(request);
		in_vl =	platformRequest.getData().getVariableList();
		in_dl =	platformRequest.getData().getDataSetList();

		// IN Valiables
		String sEmpNo =	in_vl.getString("g_EmpNo");
		String sDeptId = in_vl.getString("g_DeptId");

		// IN DataSet
		DataSet	ds_condi = in_dl.get("ds_condi");

		// 변수	설정
		String TYPE	= nullToBlank(ds_condi.getString(0,	"TYPE"));
		String TYPE_CODE = nullToBlank(ds_condi.getString(0, "TYPE_CODE"));
		String FROM_DATE = nullToBlank(ds_condi.getString(0, "FROM_DATE"));
		String TO_DATE = nullToBlank(ds_condi.getString(0, "TO_DATE"));
		String ORDER_NUM = nullToBlank(ds_condi.getString(0, "ORDER_NUM"));
		Integer UPJANG = ds_condi.getInt(0, "UPJANG");

		StringBuffer sbQuery = new StringBuffer();
		sbQuery.setLength(0);
		
		//2016.08.05 최학진 속도 개선 변경 변경_ID : CH201608_00099
		sbQuery.append("\n		 SELECT 																															");
		if (TYPE.equals("S")) {
			sbQuery.append("\n		 D.SUBINV_NAME AS SUBINV_NAME, --검수처																									");
		} else if (TYPE.equals("D")) {
			sbQuery.append("\n		 D.CC_NM AS	SUBINV_NAME, --	검수처																										");
		}
		sbQuery.append("\n		 		 B.VD_NM  AS CUSTNM, --	거래처																												                                                                                																													");
		sbQuery.append("\n		 		 DT.GR_REQ_DATE AS NEED_DATE, --입고예정일																													                                                                																													");
		sbQuery.append("\n		 		 DT.ITEM_CD AS ITEM_CODE, --자재코드																														                                                                																													");
		sbQuery.append("\n		 		 E.ITEM_NM AS ITEM_NAME,  --자재명																														                                                                    																													");
		sbQuery.append("\n		 		 E.SPEC AS ITEM_SIZE, --규격																															                                                                    																													");
		sbQuery.append("\n		 		 E.PURC_UNIT_CD AS PO_UOM,	  --구매단위																														                                                            																													");
		sbQuery.append("\n		 		 NVL((SELECT X.DTL_CD_NM FROM EPROCUSR.ESACDDL X WHERE X.SYS_ID = '100' AND X.LANG_CD = 'ko_KR' AND X.GRP_CD = 'MT305' AND X.STS <> 'D' AND X.DTL_CD = E.PURC_STOR_CD),'실온')	AS KEEPING_TYPE	,	--보관방법																																	");																	
		sbQuery.append("\n		 		 DECODE(NVL(C.PR_QTY, 0), 0, DT.ITEM_QTY, C.PR_QTY) AS	PR_QTY,	   --신청량                                                                                                                                                 																													");
		sbQuery.append("\n		 		 CASE WHEN DT.PO_COMP_YN='Y' OR DT.GR_COMP_YN='Y' THEN NVL(DT.ITEM_QTY,0) - NVL(DT.GR_QTY,0) -- 입고완료                                                                                                                    																													");
		sbQuery.append("\n		              ELSE 0                                                                                                                                                                                                                																													");
		sbQuery.append("\n		            END AS CNL_QTY,	--취소량																										                                                                                        																													");
		if (TYPE.equals("S") &&	TYPE_CODE.substring(0, 1).equals("C")) {
			sbQuery.append("\n		 CASE DT.PROC_TYP_CD WHEN 'VC' THEN DT.ITEM_QTY ELSE 0 END  AS DIRECT_DELI_QTY,	 --직송량																											");
		} else {
			sbQuery.append("\n		 0 AS DIRECT_DELI_QTY,	--직송량																											");
		}
		sbQuery.append("\n		 		 CASE DT.PROC_TYP_CD WHEN 'VC' THEN NVL(DT.GR_QTY,0) ELSE NVL(DT.GR_QTY_WMS,0) END AS DELIVERED_QTY ,	 --기입고량																																																								");	
		sbQuery.append("\n		 		 NVL((SELECT 'Y'																															                                                                                																													");
		sbQuery.append("\n		 				FROM PO_CLAIM_LIST F																												                                                                                																													");
		sbQuery.append("\n		 			   WHERE DT.LEGCY_REQ_LNO = F.PO_ID																												                                                                        																													");
		sbQuery.append("\n		 				 AND DT.LEGCY_REQ_NO =	F.PO_NUM																											                                                                        																													");
		sbQuery.append("\n		 				 AND F.REQ_KIND	= 'C0204'	 /*상태:교환익일입고*/																						                                                                            																													");
		sbQuery.append("\n		 				 AND F.PRCS_STATUS IN ('01','05','09')	  /*상태:처리완료*/),'') AS FLAG,                                                                                                                                           																													");
		sbQuery.append("\n		 		 DECODE(NVL(E.IMG_ATT_NO,'N'), 'N', 'N', 'Y') AS IMG_YN ,																																	                                																													");
		sbQuery.append("\n		          (SELECT Y.ATT_FILE_PATH||Y.ATT_FILE_NM  FROM EPROCUSR.ESAATTH Y                                                                                                                                                           																													");
		sbQuery.append("\n		             WHERE Y.SYS_ID = '100'                                                                                                                                                                                                 																													");
		sbQuery.append("\n		               AND NVL(Y.FILE_PRPT_CD, 'FP002') = 'FP002'                                                                                                                                                                           																													");
		sbQuery.append("\n		               AND Y.ATT_SEQ IN (SELECT MIN(Z.ATT_SEQ)                                                                                                                                                                              																													");
		sbQuery.append("\n		                                   FROM EPROCUSR.ESAATTH Z                                                                                                                                                                          																													");
		sbQuery.append("\n		                                  WHERE Z.GRP_CD = Y.GRP_CD                                                                                                                                                                         																													");
		sbQuery.append("\n		                                    AND Z.SYS_ID = '100'                                                                                                                                                                            																													");
		sbQuery.append("\n		                                    AND NVL(Z.FILE_PRPT_CD, 'FP002') = 'FP002'                                                                                                                                                      																													");
		sbQuery.append("\n		                                 )                                                                                                                                                                                                  																													");
		sbQuery.append("\n		               AND Y.STS <> 'D'                                                                                                                                                                                                     																													");
		sbQuery.append("\n		               AND E.IMG_ATT_NO = Y.GRP_CD) AS IMG_PATH,                                                                                                                                                                            																													");
		sbQuery.append("\n		 		 FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(DT.WH_CNTR_CD, HD.VD_CD,	DT.ITEM_CD, DT.GR_REQ_DATE), 'N',(SELECT ATTR_VAL                                                                                                           																													");
		sbQuery.append("\n		                                                                                                                  FROM EPROCUSR.ESMMTSP K                                                                                           																													");
		sbQuery.append("\n		                                                                                                                 WHERE K.SYS_ID  = '100'                                                                                            																													");
		sbQuery.append("\n		                                                                                                                   AND K.ATTR_CD = 'P1251'                                                                                          																													");
		sbQuery.append("\n		                                                                                                                   AND K.STS    <> 'D' AND K.ITEM_CD = DT.ITEM_CD )                                                                 																													");
		sbQuery.append("\n		                                                                                                           ,	(SELECT  ATTR_VAL                                                                                                   																													");
		sbQuery.append("\n		                                                                                                          FROM EPROCUSR.ESMMTSP Q                                                                                                   																													");
		sbQuery.append("\n		                                                                                                         WHERE Q.SYS_ID  = '100'                                                                                                    																													");
		sbQuery.append("\n		                                                                                                           AND Q.ATTR_CD = 'P10001'  -- 가공상태 UNIT_CD_VAL                                                                        																													");
		sbQuery.append("\n		                                                                                                           AND Q.STS    <> 'D' AND Q.ITEM_CD = DT.ITEM_CD)                                                                          																													");
		sbQuery.append("\n		                                                                                                                                                                                                                                    																													");
		sbQuery.append("\n		                             ) AS	FEATURE_NAME,                                                                                                                                                                                    																													");
		sbQuery.append("\n		                             G.GRP_CD AS EPRO_FILE_GRP                                                                                                                                                                                    																													");
		sbQuery.append("\n		   FROM EPROCUSR.ESPPODT DT                                                                                                                                                                                                         																													");
		sbQuery.append("\n		      INNER JOIN  EPROCUSR.ESPPRDT PRDT   -- PR 상세(품목)                                                                                                                                                                          																													");
		sbQuery.append("\n		         ON DT.SYS_ID = PRDT.SYS_ID                                                                                                                                                                                                 																													");
		sbQuery.append("\n		         AND DT.COMP_CD = PRDT.COMP_CD                                                                                                                                                                                              																													");
		sbQuery.append("\n		         AND DT.PR_NO = PRDT.PR_NO                                                                                                                                                                                                  																													");
		sbQuery.append("\n		         AND DT.PR_LNO = PRDT.PR_LNO                                                                                                                                                                                                																													");
		sbQuery.append("\n		      INNER JOIN EPROCUSR.ESPPOHD HD                                                                                                                                                                                                																													");
		sbQuery.append("\n		         ON DT.SYS_ID = HD.SYS_ID                                                                                                                                                                                                   																													");
		sbQuery.append("\n		         AND DT.COMP_CD = HD.COMP_CD                                                                                                                                                                                                																													");
		sbQuery.append("\n		         AND DT.PO_NO = HD.PO_NO                                                                                                                                                                                                    																													");
		sbQuery.append("\n		      LEFT OUTER JOIN VO_FC_VENDOR B                                                                                                                                                                                                																													");
		sbQuery.append("\n		         ON HD.VD_CD = B.VD_CD                                                                                                                                                                                                      																													");
		sbQuery.append("\n		      LEFT OUTER JOIN SO_PR C                                                                                                                                                                                                       																													");
		sbQuery.append("\n		         ON DT.LEGCY_REQ_NO = C.PR_NUM                                                                                                                                                                                              																													");
		sbQuery.append("\n		         AND DT.LEGCY_REQ_LNO = C.PR_ID                                                                                                                                                                                             																													");
		
		sbQuery.append("\n		      LEFT OUTER JOIN EPROCUSR.ESPPODT_ESAATTH G                                                                                                                                                                                                       																													");
		sbQuery.append("\n		         ON  DT.SYS_ID = G.SYS_ID                                                                                                                                                                                              																													");
		sbQuery.append("\n		         AND DT.COMP_CD = G.COMP_CD                                                                                                                                          	                                                    																													");
		sbQuery.append("\n		         AND DT.PO_NO = G.PO_NO                                                                                                                                                                                             																													");
		sbQuery.append("\n		         AND DT.PO_LNO = G.PO_LNO                                                                                                                                                                                             																													");
		
		
		
		if (TYPE.equals("S")) {
			sbQuery.append("\n		      INNER JOIN HLDC_PO_SUBINVENTORY D                                                                                                                                                                                             																													");
			sbQuery.append("\n		         ON DT.WH_CD = D.SUBINV_CODE                                                                                                                                                                                                																													");
		} else if (TYPE.equals("D")) {
			sbQuery.append("\n		      INNER JOIN HLDC_SC_DEPT_V D                                                                                                                                                                                             																													");
			sbQuery.append("\n		         ON DT.CC_CD = D.DEPT_ID                                                                                                                                                                                                																													");
			sbQuery.append("\n		         AND DT.WH_CD IS NULL                                                                                                                                                                                                																													");
		}
		sbQuery.append("\n		      INNER JOIN EPROCUSR.ESMMTGL E                                                                                                                                                                                                 																													");
		sbQuery.append("\n		         ON DT.ITEM_CD = E.ITEM_CD                                                                                                                                                                                                  																													");
		sbQuery.append("\n		  WHERE 1=1                                                                                                                                                                                                                         																													");
		sbQuery.append("\n		    AND DT.SYS_ID = '100'                                                                                                                                                                                                           																													");
		sbQuery.append("\n		    AND DT.COMP_CD = 'HFC'                                                                                                                                                                                                          																													");
		if (TYPE.equals("S")) {
			sbQuery.append("\n		      AND DT.WH_CD = '" + TYPE_CODE +"'                                                                                                                                                                                             																													");
		} else if (TYPE.equals("D")) {
			sbQuery.append("\n		      AND DT.CC_CD = '" + TYPE_CODE +"'                                                                                                                                                                                             																													");
		}
		sbQuery.append("\n		    AND DT.SHOP_CD = " + UPJANG  );
		sbQuery.append("\n		    AND DT.GR_REQ_DATE BETWEEN '"	+ FROM_DATE	+ "' AND '"	+ TO_DATE +	"'                                                                                                                                                                          																													");
		sbQuery.append("\n		    AND NVL( DECODE(DT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC')),'PC') IN('DL','GC','IV', 'PC')                                                                                                                            																													");
		sbQuery.append("\n		    ORDER BY	DT.SHOP_CD, VD_NM	                                                                                                                                                                                                																													");
		
		/* 2016.08.05 최학진 속도개선 으로 전부 주석처리 
		sbQuery.append("\nSELECT																																			");
		if (TYPE.equals("S")) {
			sbQuery.append("\n		 D.SUBINV_NAME AS SUBINV_NAME, --검수처																									");
		} else if (TYPE.equals("D")) {
			sbQuery.append("\n		 D.CC_NM AS	SUBINV_NAME, --	검수처																										");
		}
		//sbQuery.append("\n	   A.ORDER_NUM,	--발주번호																		");
		sbQuery.append("\n		 B.VD_NM  AS CUSTNM, --	거래처																												");
		sbQuery.append("\n		 A.NEED_DATE, --입고예정일																													");
		sbQuery.append("\n		 A.ITEM_CODE, --자재코드																														");
		sbQuery.append("\n		 A.ITEM_NAME, --자재명																														");
		sbQuery.append("\n		 A.ITEM_SIZE, --규격																															");
		sbQuery.append("\n		 A.PO_UOM ,	  --구매단위																														");
		sbQuery.append("\n		 NVL(E.KEEPING_TYPE,'실온')	AS KEEPING_TYPE	,	--보관방법																					");
		sbQuery.append("\n		 DECODE(NVL(C.PR_QTY, 0), 0, A.PO_QTY, C.PR_QTY) AS	PR_QTY,	   --신청량																		");
		//sbQuery.append("\n	   (A.CENTER_DELI_QTY +	A.DIRECT_DELI_QTY) AS ORDER_QTY,  --발주량								");
		sbQuery.append("\n		 A.UNDELIVERED_QTY AS CNL_QTY,	--취소량																										");
		if (TYPE.equals("S") &&	TYPE_CODE.substring(0, 1).equals("C")) {
			sbQuery.append("\n		 A.DIRECT_DELI_QTY,	 --직송량																											");
		} else {
			sbQuery.append("\n		 0 AS DIRECT_DELI_QTY,	--직송량																											");
		}
		sbQuery.append("\n		 A.DELIVERED_QTY ,	 --기입고량																												");
		sbQuery.append("\n		 NVL((SELECT 'Y'																															");
		sbQuery.append("\n				FROM PO_CLAIM_LIST F																												");
		sbQuery.append("\n			   WHERE A.PO_ID = F.PO_ID																												");
		sbQuery.append("\n				 AND A.PO_NUM =	F.PO_NUM																											");
		sbQuery.append("\n				 AND F.REQ_KIND	= 'C0204'	 //상태:교환익일입고																						");
		sbQuery.append("\n				 AND F.PRCS_STATUS IN ('01','05','09')	  ),'') AS FLAG, //상태:처리완료																");
		sbQuery.append("\n		 E.IMG_YN ,																																	");
		sbQuery.append("\n		 E.IMG_PATH	,																																");
		sbQuery.append("\n		 FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(A.CENTER_CODE, A.CUSTCD,	A.ITEM_CODE, A.NEED_DATE), E.PB_YN,	E.ECO_ITEM,	E.MANUF_CD ) AS	FEATURE_NAME");
		sbQuery.append("\n	FROM HLDC_PO_PO	A,																																");
		sbQuery.append("\n		 VO_FC_VENDOR B,																															");
		sbQuery.append("\n		 SO_PR C,																																	");
		if (TYPE.equals("S")) {
			sbQuery.append("\n		 HLDC_PO_SUBINVENTORY D																													");
		} else if (TYPE.equals("D")) {
			sbQuery.append("\n		 HLDC_SC_DEPT_V	D																														");
		}
		sbQuery.append("\n	   , HLDC_PO_ITEM_MST E																															");
		sbQuery.append("\n WHERE A.CUSTCD =	B.VD_CD(+)																															");
		sbQuery.append("\n	 AND A.PO_ID  =	C.PR_ID(+)																														");
		sbQuery.append("\n	 AND A.PO_NUM =	C.PR_NUM(+)																														");
		if (TYPE.equals("S")) {
			sbQuery.append("\n	 AND A.SUBINV_CODE = D.SUBINV_CODE																											");
			sbQuery.append("\n	 AND A.SUBINV_CODE = '"	+ TYPE_CODE	+ "'");
		} else if (TYPE.equals("D")) {
			sbQuery.append("\n	 AND A.RC_DEPT_ID =	D.DEPT_ID																												");
			sbQuery.append("\n	 AND A.SUBINV_CODE IS NULL																													");
			sbQuery.append("\n	 AND A.RC_DEPT_ID =	'" + TYPE_CODE + "'																										");
		}
		sbQuery.append("\n	 AND A.ITEM_CODE= E.ITEM_CODE																													");
		sbQuery.append("\n	 AND A.NEED_DATE BETWEEN '"	+ FROM_DATE	+ "' AND '"	+ TO_DATE +	"'																				");
		//sbQuery.append("\n   AND ABS(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY)	> 0														");
		sbQuery.append("\n	 AND A.LINE_STATUS IN('DL','GC','IV', 'PC')");
		sbQuery.append("\n ORDER BY	A.RC_UPJANG, VD_NM																														");
		*/
		pstmt =	conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();

		DataSet	ds_out = this.makeDataSet(rs, "ds_out");
		out_dl.add(ds_out);

		this.setResultMessage(0, "OK", out_vl);
	} catch	(Exception ex) {
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(), out_vl);
	} finally {
		if (rs != null)	{
			try	{
				rs.close();
			} catch	(Exception e) {
			}
		}
		if (pstmt != null) {
			try	{
				pstmt.close();
			} catch	(Exception e) {
			}
		}
		if (conn !=	null) {
			try	{
				conn.close();
			} catch	(Exception e) {
			}
		}
		proc_output(response, out, out_vl, out_dl);
	}
%>