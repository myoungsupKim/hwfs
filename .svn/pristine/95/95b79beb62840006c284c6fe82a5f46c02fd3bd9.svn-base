<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 레시피관리 > 본사 표준레시피 관리, 업장 레시피 관리
 - ViewPage    : FMM00010E.xml, FMM00030E.xml > FMM00012P.xml 공통 사용 
 - Description : 레시피 영양성분 팝업 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 04. 22 - 최초작성.
 -               2) 2008. 05. 22 - 본사 표준레시피 조회의 경우 자재대체 FUNCTION 이용하여 조회
 ------------------------------------------------------------%>
<%@page import="com.sz.util.AppDataUtility,  com.ifis.sc.scc.CommonUtil"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		// IN DataSet
		DataSet ds_Nut = in_dl.get("ds_Nut");
		
		// 변수 설정
		String sGubun       = ds_Nut.getString(0, "GUBUN"       ); // 0 : 한화(본부)표준레시피, 1 : 본사표준레시피, 2 : 업장레시피
		int    iUpjang      = ds_Nut.getInt(0, "UPJANG");
		String sSubinvClass = ds_Nut.getString(0, "SUBINV_CLASS");
		String sRecipeCd    = ds_Nut.getString(0, "RECIPE_CD"   );
		
		DataSet ds_out;
		
		StringBuffer sbQuery = new StringBuffer();
		sbQuery.setLength(0);
		
		if( sGubun.equals("0") ) {
			sbQuery.append("\nSELECT A.RECIPE_CD, A.RECIPE_NAME, ");
			sbQuery.append("\n       B.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.ORIGIN_TYPE, ");
			sbQuery.append("\n       C.DISUSE_RATE, B.NEED_QTY, B.ITEM_SEQ, ");
			sbQuery.append("\n       ROUND( NVL(C.CAL,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CAL, ");
			sbQuery.append("\n	     ROUND( NVL(C.WATER,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) WATER, ");
			sbQuery.append("\n       ROUND( NVL(C.PROT,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) PROT, ");
			sbQuery.append("\n       ROUND( NVL(C.FAT,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) FAT, ");
			sbQuery.append("\n       ROUND( NVL(C.CARBO,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CARBO, ");
			sbQuery.append("\n       ROUND( NVL(C.FIBER,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) FIBER, ");
			sbQuery.append("\n       ROUND( NVL(C.ASH,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) ASH, ");
			sbQuery.append("\n       ROUND( NVL(C.CA,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CA, ");
			sbQuery.append("\n       ROUND( NVL(C.P,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) P, ");
			sbQuery.append("\n       ROUND( NVL(C.FE,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) FE, ");
			sbQuery.append("\n       ROUND( NVL(C.NA,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) NA, ");
			sbQuery.append("\n       ROUND( NVL(C.K,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) K, ");
			sbQuery.append("\n       ROUND( NVL(C.VITA_A,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) VITA_A, ");
			sbQuery.append("\n       ROUND( NVL(C.RETIN,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) RETIN, ");
			sbQuery.append("\n       ROUND( NVL(C.B_CAROT,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) B_CAROT, ");
			sbQuery.append("\n       ROUND( NVL(C.THIA,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) THIA, ");
			sbQuery.append("\n       ROUND( NVL(C.RIBO,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) RIBO, ");
			sbQuery.append("\n       ROUND( NVL(C.NIACIN,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) NIACIN, ");
			sbQuery.append("\n       ROUND( NVL(C.VITA_C,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) VITA_C, ");
			sbQuery.append("\n       ROUND( NVL(C.CHOLE,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CHOLE ");
			sbQuery.append("\n  FROM FMR_STD_RECIPE_MST A, ");
			sbQuery.append("\n      (SELECT A.RECIPE_CD, A.ITEM_CODE, B.ITEM_NAME, A.NEED_QTY, A.ITEM_SEQ, B.ITEM_SIZE, B.ORIGIN_TYPE, ");
			sbQuery.append("\n              DECODE(B.OTCUSTCD,'0000',B.ITEM_CODE, ");
			sbQuery.append("\n                DECODE((SELECT 1 FROM FMP_ITEM_NUT Z WHERE Z.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n                                                AND Z.ITEM_CODE = B.ITEM_CODE AND ROWNUM = 1),1,B.ITEM_CODE,B.ORI_ITEM_CODE)) AS ORI_ITEM_CODE ");
			sbQuery.append("\n         FROM (SELECT RECIPE_CD, FMM_CHGITEM_FUN(" + iUpjang + ", ITEM_CODE) AS ITEM_CODE, NEED_QTY, ITEM_SEQ FROM FMR_STD_RECIPE_ITEM WHERE RECIPE_CD = '" + sRecipeCd + "') A ");
			sbQuery.append("\n            , FMS_ITEM_V B ");
			sbQuery.append("\n        WHERE A.RECIPE_CD = '" + sRecipeCd + "' ");
			sbQuery.append("\n		  AND A.ITEM_CODE = B.ITEM_CODE ");
			sbQuery.append("\n      ) B ");
			sbQuery.append("\n     ,(SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
			sbQuery.append("\n         FROM FMP_ITEM_NUT A ");
			sbQuery.append("\n        WHERE A.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n          AND A.USE_YN = 'Y' ");
			sbQuery.append("\n        UNION ALL ");
			sbQuery.append("\n       SELECT A.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
			sbQuery.append("\n         FROM FSI_ITEM_NUT A ");
			sbQuery.append("\n            ,(SELECT ITEM_CODE ");
			sbQuery.append("\n                FROM FSI_ITEM_NUT ");
			sbQuery.append("\n               MINUS ");
			sbQuery.append("\n              SELECT ITEM_CODE ");
			sbQuery.append("\n                FROM FMP_ITEM_NUT ");
			sbQuery.append("\n               WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n                 AND USE_YN = 'Y') B ");
			sbQuery.append("\n        WHERE A.ITEM_CODE = B.ITEM_CODE ");
			sbQuery.append("\n      ) C ");
			sbQuery.append("\n WHERE A.RECIPE_CD = '" + sRecipeCd + "' ");
			sbQuery.append("\n   AND A.RECIPE_CD = B.RECIPE_CD ");
			sbQuery.append("\n   AND B.ORI_ITEM_CODE = C.ITEM_CODE(+) ");
			sbQuery.append("\nORDER BY A.RECIPE_CD, B.ITEM_SEQ ");
		} else if( sGubun.equals("1") ) {
			sbQuery.append("\nSELECT A.RECIPE_CD, A.RECIPE_NAME, ");
			sbQuery.append("\n       B.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.ORIGIN_TYPE, ");
			sbQuery.append("\n       C.DISUSE_RATE, B.NEED_QTY, B.ITEM_SEQ, ");
			sbQuery.append("\n       ROUND( NVL(C.CAL,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CAL, ");
			sbQuery.append("\n	     ROUND( NVL(C.WATER,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) WATER, ");
			sbQuery.append("\n       ROUND( NVL(C.PROT,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) PROT, ");
			sbQuery.append("\n       ROUND( NVL(C.FAT,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) FAT, ");
			sbQuery.append("\n       ROUND( NVL(C.CARBO,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CARBO, ");
			sbQuery.append("\n       ROUND( NVL(C.FIBER,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) FIBER, ");
			sbQuery.append("\n       ROUND( NVL(C.ASH,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) ASH, ");
			sbQuery.append("\n       ROUND( NVL(C.CA,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CA, ");
			sbQuery.append("\n       ROUND( NVL(C.P,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) P, ");
			sbQuery.append("\n       ROUND( NVL(C.FE,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) FE, ");
			sbQuery.append("\n       ROUND( NVL(C.NA,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) NA, ");
			sbQuery.append("\n       ROUND( NVL(C.K,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) K, ");
			sbQuery.append("\n       ROUND( NVL(C.VITA_A,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) VITA_A, ");
			sbQuery.append("\n       ROUND( NVL(C.RETIN,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) RETIN, ");
			sbQuery.append("\n       ROUND( NVL(C.B_CAROT,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) B_CAROT, ");
			sbQuery.append("\n       ROUND( NVL(C.THIA,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) THIA, ");
			sbQuery.append("\n       ROUND( NVL(C.RIBO,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) RIBO, ");
			sbQuery.append("\n       ROUND( NVL(C.NIACIN,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) NIACIN, ");
			sbQuery.append("\n       ROUND( NVL(C.VITA_C,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) VITA_C, ");
			sbQuery.append("\n       ROUND( NVL(C.CHOLE,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CHOLE ");
			sbQuery.append("\n  FROM FMM_STD_RECIPE_MST A, ");
			sbQuery.append("\n      (SELECT A.UPJANG, A.RECIPE_CD ");
			sbQuery.append("\n            , A.ITEM_CODE, B.ITEM_NAME, A.NEED_QTY, A.ITEM_SEQ, B.ITEM_SIZE, B.ORIGIN_TYPE ");
			sbQuery.append("\n            , DECODE(B.OTCUSTCD,'0000',B.ITEM_CODE, ");
			sbQuery.append("\n                DECODE((SELECT 1 FROM FMP_ITEM_NUT Z WHERE Z.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n                                                AND Z.ITEM_CODE = B.ITEM_CODE AND ROWNUM = 1),1,B.ITEM_CODE,B.ORI_ITEM_CODE)) AS ORI_ITEM_CODE ");
			sbQuery.append("\n         FROM FMM_STD_RECIPE_ITEM A ");
			sbQuery.append("\n            , FMS_ITEM_V B ");
			sbQuery.append("\n        WHERE A.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n          AND A.RECIPE_CD = '" + sRecipeCd + "' ");
			sbQuery.append("\n		  AND A.ITEM_CODE = B.ITEM_CODE ");
			sbQuery.append("\n      ) B ");
			sbQuery.append("\n     ,(SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
			sbQuery.append("\n         FROM FMP_ITEM_NUT A ");
			sbQuery.append("\n        WHERE A.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n          AND A.USE_YN = 'Y' ");
			sbQuery.append("\n        UNION ALL ");
			sbQuery.append("\n       SELECT A.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
			sbQuery.append("\n         FROM FSI_ITEM_NUT A ");
			sbQuery.append("\n            ,(SELECT ITEM_CODE ");
			sbQuery.append("\n                FROM FSI_ITEM_NUT ");
			sbQuery.append("\n               MINUS ");
			sbQuery.append("\n              SELECT ITEM_CODE ");
			sbQuery.append("\n                FROM FMP_ITEM_NUT ");
			sbQuery.append("\n               WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n                 AND USE_YN = 'Y') B ");
			sbQuery.append("\n        WHERE A.ITEM_CODE = B.ITEM_CODE ");
			sbQuery.append("\n      ) C ");
			sbQuery.append("\n WHERE A.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n   AND A.RECIPE_CD = '" + sRecipeCd + "' ");
			sbQuery.append("\n   AND A.UPJANG = B.UPJANG ");
			sbQuery.append("\n   AND A.RECIPE_CD = B.RECIPE_CD ");
			sbQuery.append("\n   AND B.ORI_ITEM_CODE = C.ITEM_CODE(+) ");
			sbQuery.append("\nORDER BY A.RECIPE_CD, B.ITEM_SEQ ");

		} else if( sGubun.equals("2") ) { // 업장레시피관리에서만 사용
			sbQuery.append("\nSELECT A.RECIPE_CD, A.RECIPE_NAME, ");
			sbQuery.append("\n       B.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.ORIGIN_TYPE, ");
			sbQuery.append("\n       C.DISUSE_RATE, B.NEED_QTY, B.ITEM_SEQ, ");
			sbQuery.append("\n       ROUND( NVL(C.CAL,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CAL, ");
			sbQuery.append("\n	     ROUND( NVL(C.WATER,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) WATER, ");
			sbQuery.append("\n       ROUND( NVL(C.PROT,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) PROT, ");
			sbQuery.append("\n       ROUND( NVL(C.FAT,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) FAT, ");
			sbQuery.append("\n       ROUND( NVL(C.CARBO,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CARBO, ");
			sbQuery.append("\n       ROUND( NVL(C.FIBER,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) FIBER, ");
			sbQuery.append("\n       ROUND( NVL(C.ASH,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) ASH, ");
			sbQuery.append("\n       ROUND( NVL(C.CA,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CA, ");
			sbQuery.append("\n       ROUND( NVL(C.P,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) P, ");
			sbQuery.append("\n       ROUND( NVL(C.FE,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) FE, ");
			sbQuery.append("\n       ROUND( NVL(C.NA,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) NA, ");
			sbQuery.append("\n       ROUND( NVL(C.K,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) K, ");
			sbQuery.append("\n       ROUND( NVL(C.VITA_A,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) VITA_A, ");
			sbQuery.append("\n       ROUND( NVL(C.RETIN,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) RETIN, ");
			sbQuery.append("\n       ROUND( NVL(C.B_CAROT,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) B_CAROT, ");
			sbQuery.append("\n       ROUND( NVL(C.THIA,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) THIA, ");
			sbQuery.append("\n       ROUND( NVL(C.RIBO,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) RIBO, ");
			sbQuery.append("\n       ROUND( NVL(C.NIACIN,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) NIACIN, ");
			sbQuery.append("\n       ROUND( NVL(C.VITA_C,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) VITA_C, ");
			sbQuery.append("\n       ROUND( NVL(C.CHOLE,0) * DECODE( NVL(C.DISUSE_RATE,0), 0, B.NEED_QTY, ROUND(B.NEED_QTY*(100-C.DISUSE_RATE)/100,2) ) / 100,2) CHOLE ");
			sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_MST A, ");
			sbQuery.append("\n      (SELECT A.UPJANG, A.SUBINV_CLASS, A.RECIPE_CD ");
			sbQuery.append("\n            , A.ITEM_CODE, B.ITEM_NAME, A.NEED_QTY, A.ITEM_SEQ, B.ITEM_SIZE, B.ORIGIN_TYPE ");
			sbQuery.append("\n            , DECODE(B.OTCUSTCD,'0000',B.ITEM_CODE, ");
			sbQuery.append("\n                DECODE((SELECT 1 FROM FMP_ITEM_NUT Z WHERE Z.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n                                                AND Z.ITEM_CODE = B.ITEM_CODE AND ROWNUM = 1),1,B.ITEM_CODE,B.ORI_ITEM_CODE)) AS ORI_ITEM_CODE ");
			sbQuery.append("\n         FROM FMM_UPJANG_RECIPE_ITEM A ");
			sbQuery.append("\n            , FMS_ITEM_V B ");
			sbQuery.append("\n        WHERE A.ITEM_CODE = B.ITEM_CODE ");
			sbQuery.append("\n          AND A.UPJANG = " + iUpjang );
			sbQuery.append("\n          AND A.SUBINV_CLASS = '" + sSubinvClass + "' ");
			sbQuery.append("\n          AND A.RECIPE_CD = '" + sRecipeCd + "' ");
			sbQuery.append("\n      ) B ");
			sbQuery.append("\n     ,(SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
			sbQuery.append("\n         FROM FMP_ITEM_NUT A ");
			sbQuery.append("\n        WHERE A.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n          AND A.USE_YN = 'Y' ");
			sbQuery.append("\n        UNION ALL ");
			sbQuery.append("\n       SELECT A.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
			sbQuery.append("\n         FROM FSI_ITEM_NUT A ");
			sbQuery.append("\n            ,(SELECT ITEM_CODE ");
			sbQuery.append("\n                FROM FSI_ITEM_NUT ");
			sbQuery.append("\n               MINUS ");
			sbQuery.append("\n              SELECT ITEM_CODE ");
			sbQuery.append("\n                FROM FMP_ITEM_NUT ");
			sbQuery.append("\n               WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + iUpjang + ") ");
			sbQuery.append("\n                 AND USE_YN = 'Y') B ");
			sbQuery.append("\n        WHERE A.ITEM_CODE = B.ITEM_CODE ");
			sbQuery.append("\n      ) C ");
			sbQuery.append("\n WHERE A.UPJANG = " + iUpjang );
			sbQuery.append("\n   AND A.SUBINV_CLASS = '" + sSubinvClass + "' ");
			sbQuery.append("\n   AND A.RECIPE_CD = '" + sRecipeCd + "' ");
			sbQuery.append("\n   AND A.UPJANG = B.UPJANG ");
			sbQuery.append("\n   AND A.SUBINV_CLASS = B.SUBINV_CLASS ");
			sbQuery.append("\n   AND A.RECIPE_CD = B.RECIPE_CD ");
			sbQuery.append("\n   AND B.ORI_ITEM_CODE = C.ITEM_CODE(+) ");
			sbQuery.append("\nORDER BY A.RECIPE_CD, B.ITEM_SEQ ");
		} else {
			throw new Exception("올바르지 않은 구분자 값입니다.");
		}
		
		pstmt = conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();
		
		DataSet ds_NutList = this.makeDataSet(rs, "ds_NutList");
		out_dl.add(ds_NutList);
		rs.close();
		pstmt.close();		
	   	this.setResultMessage(0, "OK", out_vl);
	} catch(Exception ex) {
		//ex.printStackTrace();
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
		proc_output(response, out, out_vl, out_dl);
	}
%>