<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URL" %>
<%@ page import="org.apache.poi.poifs.dev.*" %>
<%@ page import="org.apache.poi.hssf.record.*" %>
<%@ page import="org.apache.poi.hssf.model.*" %>
<%@ page import="org.apache.poi.hssf.usermodel.*" %>
<%@ page import="org.apache.poi.ss.usermodel.*" %>
<%@ page import="org.apache.poi.hssf.util.*" %>
<%@ page import="org.apache.poi.poifs.filesystem.*" %>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem.*" %>
<%@ page import="org.apache.poi.poifs.eventfilesystem.*" %>

<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>협력업체위생관리 평가결과 엑셀 저장</title>
</head>
<body>
<%  
  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
  String today = formatter.format(new java.util.Date());
  String file_name = request.getParameter("CUSTCD")+"_"+request.getParameter("CHK_DD")+"_"+today;
  String ExcelName  = new String(file_name.getBytes(),"UTF-8")+".xls";

  response.setContentType("application/vnd.ms-excel");
  response.setHeader("Content-Disposition", "attachment; filename="+ExcelName);
  response.setHeader("Content-Description", "JSP Generated Data");
  response.setHeader("Pragma", "no-cache");

  PreparedStatement pstmt1= null;
  ResultSet rs1 = null;
 
  PreparedStatement pstmt2= null;
  ResultSet rs2 = null;

  PreparedStatement pstmt3= null;
  ResultSet rs3 = null;

  String strFormCd    = request.getParameter("FORM_CD");
  String strCustcd    = request.getParameter("CUSTCD");          // 협력업체
  String strChkDd     = request.getParameter("CHK_DD");
  String strTableType = request.getParameter("TABLE_TYPE");
  String strImgRoot   = request.getParameter("IMG_ROOT");
  String strSubCompNm = java.net.URLDecoder.decode(request.getParameter("SUB_COMP_NM"),"UTF-8");

  //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strFormCd = " + strFormCd);
  //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCustcd = " + strCustcd);
  //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strChkDd = " + strChkDd);
  //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strTableType = " + strTableType);
  //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strImgRoot = " + strImgRoot);
  //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strSubCompNm = " + strSubCompNm);
  
  StringBuffer sbSql = new StringBuffer();
  sbSql.append("SELECT TO_CHAR(TO_DATE(A.CHK_DD, 'YYYYMMDD'), 'YYYY-MM-DD') AS CHK_DD -- 점검일자                                                                   \n");
  sbSql.append("     , (SELECT TM_NM FROM HLDC_SC_DEPT_V WHERE TM_CD = A.TM_CD AND ROWNUM = 1) AS TM_NM -- 소속                                                     \n");
  sbSql.append("     , D.NM_KOR AS INSPECTOR_NM -- 점검자                                                                                                           \n");
  sbSql.append("     , C.CODE_NAME AS CHK_CLASS_NM  -- 점검구분                                                                                                     \n");
  sbSql.append("     , A.DEAL_CLASS  -- 거래구분                                                                                                                    \n");
  sbSql.append("     , (SELECT MGRP_NM                                                                                                                              \n");
  sbSql.append("          FROM LCM_SPECM_TYPE_MGRP                                                                                                                  \n");
  sbSql.append("         WHERE MGRP_CD = A.FOOD_TYPE_MGRP                                                                                                           \n");
  sbSql.append("           AND SPECM_TYPE = A.SPECM_TYPE) || '>' ||  -- 식품의유형(대)                                                                                     \n");
  sbSql.append("       (SELECT MCALSS_NM                                                                                                                            \n");
  sbSql.append("          FROM LCM_SPECM_TYPE_MCALSS                                                                                                                \n");
  sbSql.append("         WHERE MCALSS_CD = A.FOOD_TYPE_MCALSS                                                                                                       \n");
  sbSql.append("           AND SPECM_TYPE = A.SPECM_TYPE) || '>' ||  -- 식품의유형(중)                                                                                     \n");
  sbSql.append("       (SELECT SCLASS_NM                                                                                                                            \n");
  sbSql.append("          FROM LCM_SPECM_TYPE_SCLASS                                                                                                                \n");
  sbSql.append("         WHERE SCLASS_CD = A.FOOD_TYPE_SCLASS                                                                                                       \n");
  sbSql.append("           AND SPECM_TYPE = A.SPECM_TYPE) AS FOOD_CLASS_NM  -- 식품의유형                                                                                  \n");
  sbSql.append("     , NVL(FSC_COMMA_NAME_FUN(NVL(A.FOOD_TYPE_CLASS, ''), 'PICK_STATUS'), ' ') AS FOOD_TYPE_CLASS -- 유형구분                                       \n");
  sbSql.append("     , FSC_COMMA_NAME_FUN(NVL(A.PASS_CENTER, ''), 'FS0116') AS PASS_CENTER  -- 경유센터                                                             \n");
  sbSql.append("     , FSC_COMMA_NAME_FUN(NVL(A.DELIVERY_PLCE, ''), 'FS0115') AS DELIVERY_PLCE  -- 납품처                                                           \n");
  sbSql.append("     , F.VD_NM  -- 업체명                                                                                                                           \n");
  sbSql.append("     , F.REP_NM -- 대표자                                                                                                                           \n");
  sbSql.append("     , F.ADDR -- 소재지                                                                                                                             \n");
  sbSql.append("     , SUBSTR(A.CHK_START_TIME, 0, 2) || ':' || SUBSTR(A.CHK_START_TIME, 3, 2) AS CHK_START_TIME -- 심사시간 시작                                                                                 \n");
  sbSql.append("     , SUBSTR(A.CHK_END_TIME, 0, 2) || ':' || SUBSTR(A.CHK_END_TIME, 3, 2) AS CHK_END_TIME -- 심사시간 종료                                                                                     \n");
  sbSql.append("     , ROUND(A.SCORE, 1) AS SCORE      -- 평가점수                                                                                                  \n");
  sbSql.append("     , A.GRADE_CD   -- 위생등급                                                                                                                     \n");
  sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0117' AND CODE = A.CHK_RESULT) AS CHK_RESULT  -- 심사판정                       \n");
  sbSql.append("     , DECODE(A.CHK_RESULT, 1, '거래가능', '거래불가') AS DEAL_YN  -- 거래유무                                                                      \n");
  sbSql.append("     , TO_CHAR(TO_DATE(Z.CHK_DD, 'YYYYMMDD'), 'YYYY-MM-DD') AS PREV_CHK_DD -- 전기평가일                                                            \n");
  sbSql.append("     , ROUND(Z.SCORE, 1) AS PREV_SCORE  -- 전기평가점수                                                                                             \n");
  sbSql.append("     , Z.GRADE_CD AS PREV_GRADE_CD  -- 전기평가등급                                                                                                 \n");
  sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0117' AND CODE = Z.CHK_RESULT) AS PREV_CHK_RESULT  -- 전기심사판정              \n");
  sbSql.append("     , DECODE(NVL(Z.CHK_RESULT, ''), '', '', DECODE(Z.CHK_RESULT, 1, '거래가능', '거래불가')) AS PREV_DEAL_YN  -- 거래유무                          \n");
  sbSql.append("     , A.REMARK  -- 총평                                                                                                                            \n");
  sbSql.append("     , A.ATTR01  -- 주요납품품목                                                                                                                    \n");
  sbSql.append("     , A.ATTR02  -- 인증현황/인증일자                                                                                                               \n");
  sbSql.append("     , A.ATTR03  -- 주요납품처                                                                                                                      \n");
  sbSql.append("     , A.ATTR04  -- 영업의종류                                                                                                                      \n");
  sbSql.append("     , A.ATTR05  -- 총 매출액(년)                                                                                                                   \n");
  sbSql.append("     , A.ATTR06  -- 매출점유율(%)                                                                                                                   \n");
  sbSql.append("     , A.ATTR07  -- 연락처/메일                                                                                                                     \n");
  sbSql.append("     , A.ATTR08  -- 소재지                                                                                                                          \n");
  sbSql.append("     , A.ATTR09  -- 사용용수                                                                                                                        \n");
  sbSql.append("     , A.ATTR10  -- 정수처리시설                                                                                                                    \n");
  sbSql.append("     , A.ATTR11  -- 담당MD                                                                                                                          \n");
  sbSql.append("     , A.ATTR12  -- 수검자                                                                                                                          \n");
  sbSql.append("     , A.ATTR13  -- 금번평가 비고                                                                                                                   \n");
  sbSql.append("     , A.ATTR14  -- 전기평가 비고                                                                                                                   \n");
  sbSql.append("     , A.SUB_COMP_NM  -- 하위공장명                                                                                                                 \n");
  sbSql.append("  FROM FSC_CONTRT_RESULT A                                                                                                                          \n");
  sbSql.append("     , (SELECT *                                                                                                                                    \n");
  sbSql.append("          FROM FSC_CONTRT_RESULT                                                                                                                    \n");
  sbSql.append("         WHERE CUSTCD = '" + strCustcd + "'                                                                                                         \n");
  sbSql.append("           AND CHK_DD < '" + strChkDd + "'                                                                                                          \n");
  sbSql.append("           AND SUB_COMP_NM = '" + strSubCompNm + "'                                                                                        \n");
  sbSql.append("           AND ROWNUM = 1                                                                                                                           \n");
  sbSql.append("         ORDER BY CHK_DD DESC) Z                                                                                                                    \n");
  sbSql.append("     , FSC_CONTRT_FORM B                                                                                                                            \n");
  sbSql.append("     , SCC_COMMON_CODE C                                                                                                                            \n");
  sbSql.append("     , SCC_COMMON_CODE E                                                                                                                            \n");
  sbSql.append("     , HLDC_HR_PERSONAL D                                                                                                                           \n");
  sbSql.append("     , HLDC_PO_VENDOR_AUDIT F                                                                                                                       \n");
  sbSql.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                                                                                  \n");
  sbSql.append("   AND A.FORM_CD = B.FORM_CD                                                                                                                        \n");
  sbSql.append("   AND A.CUSTCD = F.VD_SN                                                                                                                           \n");
  sbSql.append("   AND A.TABLE_TYPE = Z.TABLE_TYPE(+)                                                                                                               \n");
  sbSql.append("   AND A.FORM_CD = Z.FORM_CD(+)                                                                                                                     \n");
  sbSql.append("   AND A.CUSTCD = Z.CUSTCD(+)                                                                                                                       \n");
  sbSql.append("   AND C.GROUP_CODE = 'FS0106'                                                                                                                      \n");
  sbSql.append("   AND A.CHK_CLASS = C.CODE                                                                                                                         \n");
  sbSql.append("   AND E.GROUP_CODE = 'FS0117'                                                                                                                      \n");
  sbSql.append("   AND A.CHK_RESULT = E.CODE                                                                                                                        \n");
  sbSql.append("   AND A.INSPECTOR = D.SABUN                                                                                                                        \n");
  sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                                                                                        \n");
  sbSql.append("   AND TO_CHAR(A.CUSTCD) = '" + strCustcd + "'                                                                                                               \n");
  sbSql.append("   AND A.FORM_CD = '" + strFormCd + "'                                                                                                              \n");
  sbSql.append("   AND A.CHK_DD = '" + strChkDd + "'                                                                                                                \n");
  sbSql.append("   AND A.SUB_COMP_NM = '" + strSubCompNm + "'                                                                                              \n");

  StringBuffer sbSql1 = new StringBuffer();
  sbSql1.append("SELECT CLASS_NM                             \n");
  sbSql1.append("     , WGT_RATE                             \n");
  sbSql1.append("     , CHK_IDCTR                            \n");
  sbSql1.append("     , CHK_IDCTR_NA                         \n");
  sbSql1.append("     , CHK_SCORE_NA                         \n");
  sbSql1.append("     , NOT_FIT_CNT                          \n");
  sbSql1.append("     , NOT_FIT_RESULT_CNT                   \n");
  sbSql1.append("     , RATIO                                \n");
  sbSql1.append("     , FINAL_SCORE                          \n");
  sbSql1.append("     , NOT_FIT_RESULT                       \n");
  sbSql1.append("  FROM FSC_CHK_RESULT_SUM_V                 \n");
  sbSql1.append(" WHERE TABLE_TYPE = '" + strTableType + "'  \n");
  sbSql1.append("   AND FORM_CD = '" + strFormCd + "'        \n");
  sbSql1.append("   AND CUSTCD = '" + strCustcd + "'         \n");
  sbSql1.append("   AND CHK_DD = '" + strChkDd + "'          \n");
  sbSql1.append("   AND SUB_COMP_NM = '" + strSubCompNm + "' \n");
  sbSql1.append(" ORDER BY CLASS_CD                          \n");

  StringBuffer sbSql2 = new StringBuffer();
  sbSql2.append("SELECT CHK_CONTENTS                         \n");
  sbSql2.append("  FROM FSC_CONTRT_RESULT_DTL                \n");
  sbSql2.append(" WHERE TABLE_TYPE = '" + strTableType + "'  \n");
  sbSql2.append("   AND FORM_CD = '" + strFormCd + "'        \n");
  sbSql2.append("   AND CUSTCD = '" + strCustcd + "'         \n");
  sbSql2.append("   AND CHK_DD = '" + strChkDd + "'          \n");
  sbSql2.append("   AND SUB_COMP_NM = '" + strSubCompNm + "' \n");
  sbSql2.append("   AND CHK_CONTENTS IS NOT NULL             \n");

  StringBuffer sbSql3 = new StringBuffer();
  sbSql3.append("SELECT C.CLASS_CD                                                                      \n");
  sbSql3.append("     , C.CLASS_NM                                                                      \n");
  sbSql3.append("     , A.CHK_CONTENTS                                                                  \n");
  sbSql3.append("     , A.CHK_SCORE                                                                     \n");
  sbSql3.append("     , B.SVR_IMGE                                                                      \n");
  sbSql3.append("     , B.IMPROV_SVR_IMGE                                                               \n");
  sbSql3.append("     , A.IMPROV_MRMT_CONTENTS                                                          \n");
  sbSql3.append("  FROM FSC_CONTRT_RESULT_DTL A                                                           \n");
  sbSql3.append("     , FSC_CONTRT_CHK_IMGE B                                                             \n");
  sbSql3.append("     , FSC_CONTRT_FORM_DTL C                                                             \n");
  sbSql3.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                     \n");
  sbSql3.append("   AND A.FORM_CD = B.FORM_CD                                                           \n");
  sbSql3.append("   AND A.CUSTCD = B.CUSTCD                                                             \n");
  sbSql3.append("   AND A.CLASS_CD = B.CLASS_CD                                                         \n");
  sbSql3.append("   AND A.CHK_DD = B.CHK_DD                                                             \n");
  sbSql3.append("   AND A.SUB_COMP_NM = B.SUB_COMP_NM                                                   \n");
  sbSql3.append("   AND A.TABLE_TYPE = C.TABLE_TYPE                                                     \n");
  sbSql3.append("   AND A.FORM_CD = C.FORM_CD                                                           \n");
  sbSql3.append("   AND A.CLASS_CD = C.CLASS_CD                                                         \n");
  sbSql3.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                           \n");
  sbSql3.append("   AND A.FORM_CD = '" + strFormCd + "'                                                 \n");
  sbSql3.append("   AND A.CUSTCD = '" + strCustcd + "'                                                  \n");
  sbSql3.append("   AND A.CHK_DD = '" + strChkDd + "'                                                   \n");
  sbSql3.append("   AND A.SUB_COMP_NM = '" + strSubCompNm + "'                                 \n");
  sbSql3.append("   AND A.CHK_CONTENTS IS NOT NULL                                                      \n");
  sbSql3.append(" ORDER BY C.CLASS_CD                                                                   \n");

  try {

    pstmt = conn.prepareStatement(sbSql.toString());
    rs = pstmt.executeQuery();
    rs.next();

    pstmt1 = conn.prepareStatement(sbSql1.toString());
    rs1 = pstmt1.executeQuery();

    pstmt2 = conn.prepareStatement(sbSql2.toString());
    rs2 = pstmt2.executeQuery();

    pstmt3 = conn.prepareStatement(sbSql3.toString());
    rs3 = pstmt3.executeQuery();
    
    int RowCnt = 0;

  	//엑셀 처리 시작
    HSSFWorkbook objWorkBook = new HSSFWorkbook();      //워크북 생성
    HSSFSheet objSheet = objWorkBook.createSheet();     //워크시트 생성
    HSSFRow objRow = null;        //로우 생성
    HSSFCell objCell = null;       //셀 생성

    //-----------------------------------------------------------------
    //스타일 설정
    //스타일 객체 생성
    HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
    HSSFCellStyle styleSub = objWorkBook.createCellStyle();   //부제목 스타일
    HSSFCellStyle styleBody = objWorkBook.createCellStyle();   //내용 스타일(Left)
    HSSFCellStyle styleBodyR = objWorkBook.createCellStyle();   //내용 스타일(Right)
    HSSFCellStyle styleBodyC = objWorkBook.createCellStyle();   //내용 스타일(Center)
    HSSFCellStyle styleBodyB = objWorkBook.createCellStyle();   //내용 스타일(Left Bold)
    HSSFCellStyle styleBodyRB = objWorkBook.createCellStyle();   //내용 스타일(Right Bold)
    HSSFCellStyle styleBodyCB = objWorkBook.createCellStyle();   //내용 스타일(Center Bold)
    HSSFCellStyle styleBodyBH = objWorkBook.createCellStyle();   //내용 스타일(Left Bold)
    HSSFCellStyle styleBodyRBH = objWorkBook.createCellStyle();   //내용 스타일(Right Bold)
    HSSFCellStyle styleBodyCBH = objWorkBook.createCellStyle();   //내용 스타일(Center Bold)

    //제목 폰트
    HSSFFont font = objWorkBook.createFont();
    font.setFontHeightInPoints((short)12);
    font.setBoldweight((short)0x2bc);
    font.setColor(HSSFColor.BLUE_GREY.index);

    //부제목 폰트
    HSSFFont font2 = objWorkBook.createFont();
    font2.setFontHeightInPoints((short)11);
    font2.setBoldweight((short)0x2bc);

    //내용 폰트
    HSSFFont font3 = objWorkBook.createFont();
    font3.setFontHeightInPoints((short)10);
    font3.setColor(HSSFColor.GREY_80_PERCENT.index);

    //내용 폰트(Bold)
    HSSFFont font4 = objWorkBook.createFont();
    font4.setFontHeightInPoints((short)10);
    font4.setBoldweight((short)0x2bc);
    font4.setColor(HSSFColor.GREY_80_PERCENT.index);

    //내용 폰트(Bold)
    HSSFFont font5 = objWorkBook.createFont();
    font5.setFontHeightInPoints((short)12);
    font5.setBoldweight((short)0x2bc);
    font5.setColor(HSSFColor.DARK_RED.index);
    
    //제목 스타일에 폰트 적용, 정렬
    styleHd.setFont(font);
    styleHd.setAlignment((short)0x1);
    styleHd.setVerticalAlignment ((short)0x1);

    //부제목 스타일 설정
    styleSub.setFont(font2);
    styleSub.setBorderBottom((short)0x1);
    styleSub.setBottomBorderColor(HSSFColor.BLACK.index);
    styleSub.setBorderLeft((short)0x1);
    styleSub.setLeftBorderColor(HSSFColor.BLACK.index);
    styleSub.setBorderRight((short)0x1);
    styleSub.setRightBorderColor(HSSFColor.BLACK.index);
    styleSub.setBorderTop((short)0x1);
    styleSub.setTopBorderColor(HSSFColor.BLACK.index);
    styleSub.setAlignment ((short)0x2);
    styleSub.setVerticalAlignment ((short)0x1);
    styleSub.setWrapText(true);

    //내용 스타일 설정(Alignment Left)
    styleBody.setFont(font3);
    styleBody.setBorderBottom((short)0x1);
    styleBody.setBottomBorderColor(HSSFColor.BLACK.index);
    styleBody.setBorderLeft((short)0x1);
    styleBody.setLeftBorderColor(HSSFColor.BLACK.index);
    styleBody.setBorderRight((short)0x1);
    styleBody.setRightBorderColor(HSSFColor.BLACK.index);
    styleBody.setBorderTop((short)0x1);
    styleBody.setTopBorderColor(HSSFColor.BLACK.index);
    styleBody.setAlignment ((short)0x1);
    styleBody.setVerticalAlignment ((short)0x1);
    styleBody.setWrapText(true);

    //내용 스타일 설정(Alignment Right)
    styleBodyR.setFont(font3);
    styleBodyR.setBorderBottom((short)0x1);
    styleBodyR.setBottomBorderColor(HSSFColor.BLACK.index);
    styleBodyR.setBorderLeft((short)0x1);
    styleBodyR.setLeftBorderColor(HSSFColor.BLACK.index);
    styleBodyR.setBorderRight((short)0x1);
    styleBodyR.setRightBorderColor(HSSFColor.BLACK.index);
    styleBodyR.setBorderTop((short)0x1);
    styleBodyR.setTopBorderColor(HSSFColor.BLACK.index);
    styleBodyR.setAlignment ((short)0x3);
    styleBodyR.setVerticalAlignment ((short)0x1);
    styleBodyR.setWrapText(true);

    //내용 스타일 설정(Alignment Center)
    styleBodyC.setFont(font3);
    styleBodyC.setBorderBottom((short)0x1);
    styleBodyC.setBottomBorderColor(HSSFColor.BLACK.index);
    styleBodyC.setBorderLeft((short)0x1);
    styleBodyC.setLeftBorderColor(HSSFColor.BLACK.index);
    styleBodyC.setBorderRight((short)0x1);
    styleBodyC.setRightBorderColor(HSSFColor.BLACK.index);
    styleBodyC.setBorderTop((short)0x1);
    styleBodyC.setTopBorderColor(HSSFColor.BLACK.index);
    styleBodyC.setAlignment ((short)0x2);
    styleBodyC.setVerticalAlignment ((short)0x1);
    styleBodyC.setWrapText(true);
  
    //내용 스타일 설정(Alignment Left, Bold)
    styleBodyB.setFont(font4);
    styleBodyB.setBorderBottom((short)0x1);
    styleBodyB.setBottomBorderColor(HSSFColor.BLACK.index);
    styleBodyB.setBorderLeft((short)0x1);
    styleBodyB.setLeftBorderColor(HSSFColor.BLACK.index);
    styleBodyB.setBorderRight((short)0x1);
    styleBodyB.setRightBorderColor(HSSFColor.BLACK.index);
    styleBodyB.setBorderTop((short)0x1);
    styleBodyB.setTopBorderColor(HSSFColor.BLACK.index);
    styleBodyB.setAlignment ((short)0x1);
    styleBodyB.setVerticalAlignment ((short)0x1);
    styleBodyB.setWrapText(true);

    //내용 스타일 설정(Alignment Right, Bold)
    styleBodyRB.setFont(font4);
    styleBodyRB.setBorderBottom((short)0x1);
    styleBodyRB.setBottomBorderColor(HSSFColor.BLACK.index);
    styleBodyRB.setBorderLeft((short)0x1);
    styleBodyRB.setLeftBorderColor(HSSFColor.BLACK.index);
    styleBodyRB.setBorderRight((short)0x1);
    styleBodyRB.setRightBorderColor(HSSFColor.BLACK.index);
    styleBodyRB.setBorderTop((short)0x1);
    styleBodyRB.setTopBorderColor(HSSFColor.BLACK.index);
    styleBodyRB.setAlignment ((short)0x3);
    styleBodyRB.setVerticalAlignment ((short)0x1);
    styleBodyRB.setWrapText(true);

    //내용 스타일 설정(Alignment Center, Bold)
    styleBodyCB.setFont(font4);
    styleBodyCB.setBorderBottom((short)0x1);
    styleBodyCB.setBottomBorderColor(HSSFColor.BLACK.index);
    styleBodyCB.setBorderLeft((short)0x1);
    styleBodyCB.setLeftBorderColor(HSSFColor.BLACK.index);
    styleBodyCB.setBorderRight((short)0x1);
    styleBodyCB.setRightBorderColor(HSSFColor.BLACK.index);
    styleBodyCB.setBorderTop((short)0x1);
    styleBodyCB.setTopBorderColor(HSSFColor.BLACK.index);
    styleBodyCB.setAlignment ((short)0x2);
    styleBodyCB.setVerticalAlignment ((short)0x1);
    styleBodyCB.setWrapText(true);
    
    //내용 스타일 설정(Alignment Left, Bold)
    styleBodyBH.setFont(font5);
    styleBodyBH.setBorderBottom((short)0x1);
    styleBodyBH.setBottomBorderColor(HSSFColor.BLACK.index);
    styleBodyBH.setBorderLeft((short)0x1);
    styleBodyBH.setLeftBorderColor(HSSFColor.BLACK.index);
    styleBodyBH.setBorderRight((short)0x1);
    styleBodyBH.setRightBorderColor(HSSFColor.BLACK.index);
    styleBodyBH.setBorderTop((short)0x1);
    styleBodyBH.setTopBorderColor(HSSFColor.BLACK.index);
    styleBodyBH.setAlignment ((short)0x1);
    styleBodyBH.setVerticalAlignment ((short)0x1);
    styleBodyBH.setWrapText(true);

    //내용 스타일 설정(Alignment Right, Bold)
    styleBodyRBH.setFont(font5);
    styleBodyRBH.setBorderBottom((short)0x1);
    styleBodyRBH.setBottomBorderColor(HSSFColor.BLACK.index);
    styleBodyRBH.setBorderLeft((short)0x1);
    styleBodyRBH.setLeftBorderColor(HSSFColor.BLACK.index);
    styleBodyRBH.setBorderRight((short)0x1);
    styleBodyRBH.setRightBorderColor(HSSFColor.BLACK.index);
    styleBodyRBH.setBorderTop((short)0x1);
    styleBodyRBH.setTopBorderColor(HSSFColor.BLACK.index);
    styleBodyRBH.setAlignment ((short)0x3);
    styleBodyRBH.setVerticalAlignment ((short)0x1);
    styleBodyRBH.setWrapText(true);

    //내용 스타일 설정(Alignment Center, Bold)
    styleBodyCBH.setFont(font5);
    styleBodyCBH.setBorderBottom((short)0x1);
    styleBodyCBH.setBottomBorderColor(HSSFColor.BLACK.index);
    styleBodyCBH.setBorderLeft((short)0x1);
    styleBodyCBH.setLeftBorderColor(HSSFColor.BLACK.index);
    styleBodyCBH.setBorderRight((short)0x1);
    styleBodyCBH.setRightBorderColor(HSSFColor.BLACK.index);
    styleBodyCBH.setBorderTop((short)0x1);
    styleBodyCBH.setTopBorderColor(HSSFColor.BLACK.index);
    styleBodyCBH.setAlignment ((short)0x2);
    styleBodyCBH.setVerticalAlignment ((short)0x1);
    styleBodyCBH.setWrapText(true);
    
  	//1행
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x200);
  	//병합(시작행,시작열,마지막행,마지막열)
    objSheet.addMergedRegion(new Region(RowCnt,(short)0,RowCnt,(short)2));

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("1. 심사구분");
    objCell.setCellStyle(styleHd);
    
    //길이 설정
    objSheet.setColumnWidth((short)0,(short)8000);
    objSheet.setColumnWidth((short)1,(short)8000);
    objSheet.setColumnWidth((short)2,(short)8000);

  	//3행
  	RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("평가일자");
    objCell.setCellStyle(styleSub);

    objCell = objRow.createCell((short)1);
    objCell.setCellValue("소속/평가자");
    objCell.setCellStyle(styleSub);

    objCell = objRow.createCell((short)2);
    objCell.setCellValue("평가구분");
    objCell.setCellStyle(styleSub);

  	//4행
  	RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);

    objCell = objRow.createCell((short)0);
    objCell.setCellValue(nullToBlank(rs.getString("CHK_DD")));
    objCell.setCellStyle(styleBodyC);

    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("TM_NM")) + " / " + nullToBlank(rs.getString("INSPECTOR_NM")));
    objCell.setCellStyle(styleBodyC);

    objCell = objRow.createCell((short)2);
    objCell.setCellValue(nullToBlank(rs.getString("CHK_CLASS_NM")));
    objCell.setCellStyle(styleBodyC);

  	//5행
  	RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("거래구분");
    objCell.setCellStyle(styleSub);

    objCell = objRow.createCell((short)1);
    objCell.setCellValue("식품의유형");
    objCell.setCellStyle(styleSub);

    objCell = objRow.createCell((short)2);
    objCell.setCellValue("유형구분");
    objCell.setCellStyle(styleSub);

  	//6행
  	RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);

    objCell = objRow.createCell((short)0);
    objCell.setCellValue(nullToBlank(rs.getString("DEAL_CLASS")));
    objCell.setCellStyle(styleBodyC);

    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("FOOD_CLASS_NM")));
    objCell.setCellStyle(styleBodyC);

    objCell = objRow.createCell((short)2);
    objCell.setCellValue(nullToBlank(rs.getString("FOOD_TYPE_CLASS")));
    objCell.setCellStyle(styleBodyC);

  	//7행
  	RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
  	//병합(시작행,시작열,마지막행,마지막열)
    objSheet.addMergedRegion(new Region(RowCnt,(short)1,RowCnt,(short)2));

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("경유센터");
    objCell.setCellStyle(styleSub);

    objCell = objRow.createCell((short)1);
    objCell.setCellValue("납품처");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)2);
    objCell.setCellStyle(styleSub);
    
  	//8행
  	RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
  	//병합(시작행,시작열,마지막행,마지막열)
    objSheet.addMergedRegion(new Region(RowCnt,(short)1,RowCnt,(short)2));

    objCell = objRow.createCell((short)0);
    objCell.setCellValue(nullToBlank(rs.getString("PASS_CENTER")));
    objCell.setCellStyle(styleBodyC);

    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("DELIVERY_PLCE")));
    objCell.setCellStyle(styleBodyC);
    objCell = objRow.createCell((short)2);
    objCell.setCellStyle(styleBodyC);

  	//9행
  	RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x90);
    
  	//10행
  	RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x200);
  	//병합(시작행,시작열,마지막행,마지막열)
    objSheet.addMergedRegion(new Region(RowCnt,(short)0,RowCnt,(short)3));

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("2. 업체현황");
    objCell.setCellStyle(styleHd);
  	
    //길이 설정
    objSheet.setColumnWidth((short)0,(short)8000);
    objSheet.setColumnWidth((short)1,(short)8000);
    objSheet.setColumnWidth((short)2,(short)8000);
    objSheet.setColumnWidth((short)3,(short)8000);

    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("업체명");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("VD_NM")) + " " + nullToBlank(rs.getString("SUB_COMP_NM")));
    objCell.setCellStyle(styleBody);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("주요 납품품목");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR01")));
    objCell.setCellStyle(styleBody);

    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("인증현황/인증일자");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR02")));
    objCell.setCellStyle(styleBody);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("주요 납품처");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR03")));
    objCell.setCellStyle(styleBody);

    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("영업의종류");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR04")));
    objCell.setCellStyle(styleBody);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("대표자");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue(nullToBlank(rs.getString("REP_NM")));
    objCell.setCellStyle(styleBody);

    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("총 매출액(년)");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR05")));
    objCell.setCellStyle(styleBody);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("매출점유율(%)");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR06")));
    objCell.setCellStyle(styleBody);

    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("연락처/메일");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR07")));
    objCell.setCellStyle(styleBody);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("소재지");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR08")));
    objCell.setCellStyle(styleBody);

    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("사용용수");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR09")));
    objCell.setCellStyle(styleBody);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("정수처리시설");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR10")));
    objCell.setCellStyle(styleBody);

    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("담당MD");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR11")));
    objCell.setCellStyle(styleBody);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("심사시간/수검자");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue(nullToBlank(rs.getString("CHK_START_TIME")) + " ~ " + nullToBlank(rs.getString("CHK_END_TIME")) + " / " + nullToBlank(rs.getString("ATTR12")));
    objCell.setCellStyle(styleBody);
    
  	RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x90);
    
    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x200);
  	//병합(시작행,시작열,마지막행,마지막열)
    objSheet.addMergedRegion(new Region(RowCnt,(short)0,RowCnt,(short)5));

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("3. 심사결과");
    objCell.setCellStyle(styleHd);
  	
    //길이 설정
    objSheet.setColumnWidth((short)0,(short)8000);
    objSheet.setColumnWidth((short)1,(short)8000);
    objSheet.setColumnWidth((short)2,(short)8000);
    objSheet.setColumnWidth((short)3,(short)8000);
    objSheet.setColumnWidth((short)4,(short)8000);
    objSheet.setColumnWidth((short)5,(short)8000);

    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("구분");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue("평가점수");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("위생등급");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue("심사판정");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)4);
    objCell.setCellValue("거래유무");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)5);
    objCell.setCellValue("비고");
    objCell.setCellStyle(styleSub);
    
    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("금번평가");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("SCORE")));
    objCell.setCellStyle(styleBodyCBH);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue(nullToBlank(rs.getString("GRADE_CD")));
    objCell.setCellStyle(styleBodyCBH);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue(nullToBlank(rs.getString("CHK_RESULT")));
    objCell.setCellStyle(styleBodyCBH);
    objCell = objRow.createCell((short)4);
    objCell.setCellValue(nullToBlank(rs.getString("DEAL_YN")));
    objCell.setCellStyle(styleBodyCBH);
    objCell = objRow.createCell((short)5);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR13")));
    objCell.setCellStyle(styleBodyBH);

    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("전기평가(" + nullToBlank(rs.getString("PREV_CHK_DD")) + ")");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue(nullToBlank(rs.getString("PREV_SCORE")));
    objCell.setCellStyle(styleBodyC);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue(nullToBlank(rs.getString("PREV_GRADE_CD")));
    objCell.setCellStyle(styleBodyC);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue(nullToBlank(rs.getString("PREV_CHK_RESULT")));
    objCell.setCellStyle(styleBodyC);
    objCell = objRow.createCell((short)4);
    objCell.setCellValue(nullToBlank(rs.getString("PREV_DEAL_YN")));
    objCell.setCellStyle(styleBodyC);
    objCell = objRow.createCell((short)5);
    objCell.setCellValue(nullToBlank(rs.getString("ATTR14")));
    objCell.setCellStyle(styleBody);
    
    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x90);
    
    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x200);
  	//병합(시작행,시작열,마지막행,마지막열)
    objSheet.addMergedRegion(new Region(RowCnt,(short)0,RowCnt,(short)2));

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("4. 총평");
    objCell.setCellStyle(styleHd);
    
    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x500);
  	//병합(시작행,시작열,마지막행,마지막열)
    objSheet.addMergedRegion(new Region(RowCnt,(short)0,RowCnt,(short)2));
    objCell = objRow.createCell((short)0);
    objCell.setCellValue(nullToBlank(rs.getString("REMARK")));
    objCell.setCellStyle(styleBody);
    objCell = objRow.createCell((short)1);
    objCell.setCellStyle(styleBody);
    objCell = objRow.createCell((short)2);
    objCell.setCellStyle(styleBody);
    
    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x90);
    
    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x200);
  	//병합(시작행,시작열,마지막행,마지막열)
    objSheet.addMergedRegion(new Region(RowCnt,(short)0,RowCnt,(short)6));

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("5. 세부 Category별 평가결과");
    objCell.setCellStyle(styleHd);
    
    //길이 설정
    objSheet.setColumnWidth((short)0,(short)8000);
    objSheet.setColumnWidth((short)1,(short)8000);
    objSheet.setColumnWidth((short)2,(short)8000);
    objSheet.setColumnWidth((short)3,(short)8000);
    objSheet.setColumnWidth((short)4,(short)8000);
    objSheet.setColumnWidth((short)5,(short)8000);
    objSheet.setColumnWidth((short)6,(short)8000);

    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("구분");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue("가중치");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("총점");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue("평가총점");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)4);
    objCell.setCellValue("평가점수");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)5);
    objCell.setCellValue("백분율");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)6);
    objCell.setCellValue("반영점수");
    objCell.setCellStyle(styleSub);
    
    while(rs1.next()) {
    	RowCnt ++;
        objRow = objSheet.createRow((short)RowCnt);
        objRow.setHeight ((short) 0x150);
        objCell = objRow.createCell((short)0);
        objCell.setCellValue(nullToBlank(rs1.getString("CLASS_NM")));
        objCell.setCellStyle(styleBodyCB);    	
        objCell = objRow.createCell((short)1);
        objCell.setCellValue(nullToBlank(rs1.getString("WGT_RATE")));
        objCell.setCellStyle(styleBodyC);    	
        objCell = objRow.createCell((short)2);
        objCell.setCellValue(nullToBlank(rs1.getString("CHK_IDCTR")));
        objCell.setCellStyle(styleBodyC);    	
        objCell = objRow.createCell((short)3);
        objCell.setCellValue(nullToBlank(rs1.getString("CHK_IDCTR_NA")));
        objCell.setCellStyle(styleBodyC);    	
        objCell = objRow.createCell((short)4);
        objCell.setCellValue(nullToBlank(rs1.getString("CHK_SCORE_NA")));
        objCell.setCellStyle(styleBodyC);    	
        objCell = objRow.createCell((short)5);
        objCell.setCellValue(nullToBlank(rs1.getString("RATIO")));
        objCell.setCellStyle(styleBodyC);    	
        objCell = objRow.createCell((short)6);
        objCell.setCellValue(nullToBlank(rs1.getString("FINAL_SCORE")));
        objCell.setCellStyle(styleBodyR);    	
    }
    
    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x90);
    
    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x200);
  	//병합(시작행,시작열,마지막행,마지막열)
    objSheet.addMergedRegion(new Region(RowCnt,(short)0,RowCnt,(short)3));

    objCell = objRow.createCell((short)0);
    objCell.setCellValue("6. 사진첨부");
    objCell.setCellStyle(styleHd);
    
    //길이 설정
    objSheet.setColumnWidth((short)0,(short)8000);
    objSheet.setColumnWidth((short)1,(short)8000);
    objSheet.setColumnWidth((short)2,(short)8000);
    objSheet.setColumnWidth((short)3,(short)8000);
    
    RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("NO");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue("소분류");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("평가내용");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue("사진");
    objCell.setCellStyle(styleSub);

    HSSFPatriarch patriarch = objSheet.createDrawingPatriarch();
	HSSFClientAnchor anchor;
	HSSFPicture picture = null;
    int pictureIndex;
    InputStream fis = null;
    ByteArrayOutputStream bos = null;
    URL url = null;
	
    int noCnt  = 0;
    while(rs3.next()) {
    	noCnt++;
    	RowCnt ++;
        objRow = objSheet.createRow((short)RowCnt);
        objRow.setHeight ((short) 0x800);
        objCell = objRow.createCell((short)0);
        objCell.setCellValue(noCnt);
        objCell.setCellStyle(styleBodyC);    	
        objCell = objRow.createCell((short)1);
        objCell.setCellValue(nullToBlank(rs3.getString("CLASS_NM")));
        objCell.setCellStyle(styleBody);    	
        objCell = objRow.createCell((short)2);
        objCell.setCellValue(nullToBlank(rs3.getString("CHK_CONTENTS")));
        objCell.setCellStyle(styleBody);    	
        objCell = objRow.createCell((short)3);
        if(rs3.getString("SVR_IMGE") == null || rs3.getString("SVR_IMGE").equals("")) {
            objCell.setCellValue("미등록");        	
            objCell.setCellStyle(styleBodyC);    	    	
        } else {
        	if(rs3.getString("SVR_IMGE").indexOf("img_NoImageBig.png") > 0) {
                objCell.setCellValue("미등록");        	
                objCell.setCellStyle(styleBodyC);    	    	
        	} else {
        	    url = new URL(strImgRoot + nullToBlank(rs3.getString("SVR_IMGE")));

        	    try {
        	    	fis = url.openStream();
       	         	bos = new ByteArrayOutputStream();
       	         	int value = 0;
       	         	while ( (value = fis.read()) != -1) {
       	         		bos.write(value);
       	         	}
       	         	pictureIndex = objWorkBook.addPicture( bos.toByteArray(), Workbook.PICTURE_TYPE_JPEG  );
        	    } finally {
        	        if (fis != null) fis.close();
        	        if (bos != null) bos.close();
        	    }

        		anchor=new HSSFClientAnchor(4,4,4,251,(short)3,RowCnt,(short)4,RowCnt);
        		anchor.setAnchorType(2);
        		picture = patriarch.createPicture(anchor, pictureIndex);
        	}
        }
    }
    
    OutputStream fileOut = null;
    
    out.clear();

    out = pageContext.pushBody();

    fileOut = response.getOutputStream(); 
    objWorkBook.write(fileOut);
    
    fileOut.close();
    
%>

</body>
</html>

<%
		pstmt.close();
		rs.close();

		pstmt1.close();
		rs1.close();

		pstmt2.close();
		rs2.close();

		pstmt3.close();
		rs3.close();

    } catch(Exception ex) {
        ex.printStackTrace();
        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch(Exception e) {}
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch(Exception e) {}
        }
        if (rs1 != null) {
            try {
                rs1.close();
            } catch(Exception e) {}
        }
        if (pstmt1 != null) {
            try {
                pstmt1.close();
            } catch(Exception e) {}
        }
        if (rs2 != null) {
            try {
                rs2.close();
            } catch(Exception e) {}
        }
        if (pstmt2 != null) {
            try {
                pstmt2.close();
            } catch(Exception e) {}
        }
        if (rs3 != null) {
            try {
                rs3.close();
            } catch(Exception e) {}
        }
        if (pstmt3 != null) {
            try {
                pstmt3.close();
            } catch(Exception e) {}
        }
        if (conn != null) {
            try {
                conn.close();
            } catch(Exception e) {}
        }
    }
%>