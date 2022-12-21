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
<%@ page import="com.hwfs.ls.cmn.util.LimsUtil" %>

<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>위생 점검 결과 엑셀 저장</title>
</head>
<body>
<%  
//System.out.println("★★★★★★★★★★FSC00080V_POI_Save.jsp start★★★★★★★★★★");
  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
  String today = formatter.format(new java.util.Date());
  
  String strTitle      = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("TITLE"),"UTF-8"));
  String strTableType  = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("TABLE_TYPE"),"UTF-8"));
  String strFromDt     = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("FROM_DT"),"UTF-8"));
  String strToDt       = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("TO_DT"),"UTF-8"));
  String strFormCd     = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("FORM_CD"),"UTF-8"));
  String strCheckType  = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("CHECK_TYPE"),"UTF-8"));
  String strLrgClassCd = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("LRG_CLASS_CD"),"UTF-8"));
  String strMuCd       = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("MU_CD"),"UTF-8"));
  String strTmCd       = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("TM_CD"),"UTF-8"));
  String strJob        = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("JOB"),"UTF-8"));
  String strSubJob     = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("SUB_JOB"),"UTF-8"));
  String strUpjang     = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("UPJANG"),"UTF-8"));
  String strClassCd    = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("CLASS_CD"),"UTF-8"));
  String strCheckSabun = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("CHECK_SABUN"),"UTF-8"));
  String strCheckSeq   = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("CHECK_SEQ"),"UTF-8"));
  String strImgRoot    = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("IMG_ROOT"),"UTF-8"));

//System.out.println("★★★★★★★★★★strCheckType:"+strCheckType);
//System.out.println("★★★★★★★★★★strCheckSeq:"+strCheckSeq);
  
  String file_name = strTableType + "_" + strFormCd + "_" + strLrgClassCd + "_" + today;
  String ExcelName  = new String(file_name.getBytes(),"UTF-8")+".xls";

  response.setContentType("application/vnd.ms-excel");
  response.setHeader("Content-Disposition", "attachment; filename="+ExcelName);
  response.setHeader("Content-Description", "JSP Generated Data");
  response.setHeader("Pragma", "no-cache");

  StringBuffer sbSql = new StringBuffer();
  sbSql.delete(0, sbSql.length());
  sbSql.append("SELECT * FROM ( \n");
  sbSql.append("SELECT A.MIDDLE_CLASS_CD AS PL_UP_CD \n");
  sbSql.append("     , A.MIDDLE_CLASS_NAME \n");
  sbSql.append("     , A.CLASS_CD AS PL_CD \n");
  sbSql.append("     , A.CLASS_NAME \n");
  sbSql.append("     , C.TABLE_TYPE \n");
  sbSql.append("     , C.FORM_CD \n");
  sbSql.append("     , C.CLASS_CD \n");
  sbSql.append("     , D.JOB_CD \n");
  sbSql.append("     , D.JOB_NAME \n");
  sbSql.append("     , D.SUB_JOB_CD \n");
  sbSql.append("     , D.SUB_JOB_NAME \n");
  sbSql.append("     , B.UPJANG \n");
  sbSql.append("     , (SELECT UPJANGNM FROM MAC_UPJANG_V WHERE B.UPJANG = UPJANG) AS UPJANGNM \n");
  sbSql.append("     , B.CHECK_DATE \n");
  sbSql.append("     , B.CHECK_SABUN \n");
  sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  B.CHECK_SABUN) AS CHECK_SABUN_NM \n");
  sbSql.append("     , B.CHARGE_SABUN \n");
  sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  B.CHARGE_SABUN) AS CHARGE_NM \n");
  sbSql.append("     , C.MARK \n");
  sbSql.append("     , C.EVAL_CONTENTS \n");
  sbSql.append("     , C.INDICATE_PHOTO \n");
  sbSql.append("     , C.SINDICATE_PHOTO \n");
  sbSql.append("     , C.IMPROV_MGMT \n");
  sbSql.append("     , C.IMPROV_PHOTO \n");
  sbSql.append("     , C.SIMPROV_PHOTO \n");
  sbSql.append("     , E.SVR_IMGE \n");
  sbSql.append("     , E.IMPROV_SVR_IMGE \n");
  sbSql.append("     , D.MU_NM \n");
  sbSql.append("     , D.TM_NM \n");
  sbSql.append("     , DENSE_RANK() OVER(ORDER BY D.JOB_CD, D.SUB_JOB_CD, B.UPJANG, B.CHECK_DATE) AS SEQNO \n");
  sbSql.append("  FROM FSC_FORM_DTL A \n");
  sbSql.append("     , FSC_RESULT_MST B \n");
  sbSql.append("     , FSC_RESULT_DTL C \n");
  sbSql.append("     LEFT OUTER JOIN FSC_CHK_IMGE E    \n");
  sbSql.append("       ON E.TABLE_TYPE = C.TABLE_TYPE  \n");
  sbSql.append("      AND E.FORM_CD = C.FORM_CD        \n");
  sbSql.append("      AND E.UPJANG = C.UPJANG          \n");
  sbSql.append("      AND E.CHK_DD = C.CHECK_DATE      \n");
  sbSql.append("      AND E.CLASS_CD = C.CLASS_CD      \n");
  sbSql.append("      AND E.PHOTO_TYPE ='0'            \n");
  sbSql.append("     , ( \n");
  sbSql.append("       SELECT UPJANG, JOB_CD, SUB_JOB_CD, JOB_NAME, SUB_JOB_NAME, MU_NM, TM_NAME AS TM_NM \n");
  sbSql.append("         FROM FSA_UPJANG_V \n");
  sbSql.append("        WHERE 1=1 \n");

  if (!strMuCd.equals("") && !strMuCd.equals("undefined")) {
      sbSql.append("      AND    MU_CD='" + strMuCd + "' \n");
  }
  if (!strTmCd.equals("") && !strTmCd.equals("undefined")) {
      sbSql.append("      AND    TM_CD='" + strTmCd + "' \n");
  }
  if (!strUpjang.equals("") && !strUpjang.equals("undefined")) {
      sbSql.append("      AND    UPJANG=" + strUpjang + " \n");
  }
  if (!strJob.equals("") && !strJob.equals("undefined")) {
      sbSql.append("      AND    JOB_CD='" + strJob + "' \n");
  }
  if (!strSubJob.equals("") && !strSubJob.equals("undefined")) {
      sbSql.append("      AND    SUB_JOB_CD='" + strSubJob + "' \n");
  }
  sbSql.append("       ) D \n");
  sbSql.append(" WHERE A.TABLE_TYPE = C.TABLE_TYPE \n");
  sbSql.append("   AND A.FORM_CD = C.FORM_CD \n");
  sbSql.append("   AND A.CLASS_CD = C.CLASS_CD \n");
  sbSql.append("   AND B.TABLE_TYPE = C.TABLE_TYPE \n");
  sbSql.append("   AND B.FORM_CD = C.FORM_CD \n");
  sbSql.append("   AND B.CHECK_DATE = C.CHECK_DATE \n");
  sbSql.append("   AND B.UPJANG = C.UPJANG \n");
  sbSql.append("   AND B.UPJANG = D.UPJANG \n");
  sbSql.append("   AND B.CONFIRM_YN = 'Y' \n");
  //최대배점이 아니거나 지적건이 있는것
  sbSql.append("   AND (C.MAX_YN = 'N' OR C.INDICATE_CNT > 0) \n");
  sbSql.append("   AND C.CLASS_CD = '" + strClassCd + "' \n");
  sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "' \n");
  sbSql.append("   AND B.CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
  sbSql.append("   AND A.FORM_CD = '" + strFormCd + "' \n");
  sbSql.append("   AND B.CHECK_TYPE IN (" + strCheckType + ") \n");
  sbSql.append("   AND A.LRG_CLASS_CD = '" + strLrgClassCd + "' \n");

  if (strCheckSabun.length() != 0)
      sbSql.append("   AND B.CHECK_SABUN = " + strCheckSabun + " \n");

  sbSql.append(" ORDER BY D.JOB_CD, D.SUB_JOB_CD, B.UPJANG, B.CHECK_DATE \n");
  sbSql.append(" ) \n");
  sbSql.append(" WHERE SEQNO IN (" + strCheckSeq + ") \n");

  //System.out.println("★★★★★★★★★★★★★★FSC00080V_POI_Save.jsp★★★★★★★★★★★★★★");
  //System.out.println(sbSql.toString());
  //System.out.println("★★★★★★★★★★★★★★FSC00080V_POI_Save.jsp★★★★★★★★★★★★★★");

  try {

    pstmt = conn.prepareStatement(sbSql.toString());
    rs = pstmt.executeQuery();
    
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
    //objRow = objSheet.createRow((short)RowCnt);
    //objRow.setHeight ((short) 0x200);
  	//병합(시작행,시작열,마지막행,마지막열)
    //objSheet.addMergedRegion(new Region(RowCnt,(short)0,RowCnt,(short)11));

    //objCell = objRow.createCell((short)0);
    //objCell.setCellValue("1. 위생점검결과");
    //objCell.setCellStyle(styleHd);
    
    //길이 설정
    objSheet.setColumnWidth((short)0,(short)2000);
    objSheet.setColumnWidth((short)1,(short)5000);
    objSheet.setColumnWidth((short)2,(short)5000);
    objSheet.setColumnWidth((short)3,(short)5000);
    objSheet.setColumnWidth((short)4,(short)5000);
    objSheet.setColumnWidth((short)5,(short)3000);
    objSheet.setColumnWidth((short)6,(short)5000);
    objSheet.setColumnWidth((short)7,(short)5000);
    objSheet.setColumnWidth((short)8,(short)2000);
    objSheet.setColumnWidth((short)9,(short)8000);
    objSheet.setColumnWidth((short)10,(short)8000);
    objSheet.setColumnWidth((short)11,(short)8000);
    objSheet.setColumnWidth((short)12,(short)8000);

    //RowCnt ++;
    objRow = objSheet.createRow((short)RowCnt);
    objRow.setHeight ((short) 0x150);
    objCell = objRow.createCell((short)0);
    objCell.setCellValue("NO.");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)1);
    objCell.setCellValue("평가항목");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)2);
    objCell.setCellValue("사업부");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)3);
    objCell.setCellValue("팀");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)4);
    objCell.setCellValue("사업장");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)5);
    objCell.setCellValue("점검일");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)6);
    objCell.setCellValue("점장명");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)7);
    objCell.setCellValue("점검자");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)8);
    objCell.setCellValue("점수");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)9);
    objCell.setCellValue("평가내용");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)10);
    objCell.setCellValue("평가사진");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)11);
    objCell.setCellValue("개선계획");
    objCell.setCellStyle(styleSub);
    objCell = objRow.createCell((short)12);
    objCell.setCellValue("개선사진");
    objCell.setCellStyle(styleSub);

    HSSFPatriarch patriarch = objSheet.createDrawingPatriarch();
	HSSFClientAnchor anchor;
	HSSFPicture picture = null;
    int pictureIndex;
    InputStream fis = null;
    ByteArrayOutputStream bos = null;
    URL url = null;
	
    int noCnt  = 0;
    while(rs.next()) {
    	noCnt++;
    	RowCnt ++;
        objRow = objSheet.createRow((short)RowCnt);
        objRow.setHeight ((short) 0x800);
        objCell = objRow.createCell((short)0);
        objCell.setCellValue(noCnt);
        objCell.setCellStyle(styleBodyC);    	
        objCell = objRow.createCell((short)1);
        objCell.setCellValue(nullToBlank(rs.getString("MIDDLE_CLASS_NAME")));
        objCell.setCellStyle(styleBody);    	
        objCell = objRow.createCell((short)2);
        objCell.setCellValue(nullToBlank(rs.getString("MU_NM")));
        objCell.setCellStyle(styleBody);    	
        objCell = objRow.createCell((short)3);
        objCell.setCellValue(nullToBlank(rs.getString("TM_NM")));
        objCell.setCellStyle(styleBody);    	
        objCell = objRow.createCell((short)4);
        objCell.setCellValue(nullToBlank(rs.getString("UPJANGNM")));
        objCell.setCellStyle(styleBody);    	
        objCell = objRow.createCell((short)5);
        objCell.setCellValue(nullToBlank(rs.getString("CHECK_DATE")));
        objCell.setCellStyle(styleBodyC);    	
        objCell = objRow.createCell((short)6);
        objCell.setCellValue(nullToBlank(rs.getString("CHARGE_NM")));
        objCell.setCellStyle(styleBody);    	
        objCell = objRow.createCell((short)7);
        objCell.setCellValue(nullToBlank(rs.getString("CHECK_SABUN_NM")));
        objCell.setCellStyle(styleBody);    	
        objCell = objRow.createCell((short)8);
        objCell.setCellValue(nullToBlank(rs.getString("MARK")));
        objCell.setCellStyle(styleBodyR);    	
        objCell = objRow.createCell((short)9);
        objCell.setCellValue(nullToBlank(rs.getString("EVAL_CONTENTS")));
        objCell.setCellStyle(styleBody);    	
        objCell = objRow.createCell((short)10);
        if(rs.getString("SVR_IMGE") == null || rs.getString("SVR_IMGE").equals("")) {
            objCell.setCellValue("미등록");        	
            objCell.setCellStyle(styleBodyC);    	    	
        } else {
        	if(rs.getString("SVR_IMGE").indexOf("img_NoImageBig.png") > 0) {
                objCell.setCellValue("미등록");        	
                objCell.setCellStyle(styleBodyC);    	    	
        	} else {
        	    url = new URL(strImgRoot + nullToBlank(rs.getString("SVR_IMGE")));

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

        		anchor=new HSSFClientAnchor(11,11,11,251,(short)10,RowCnt,(short)11,RowCnt);
        		anchor.setAnchorType(2);
        		picture = patriarch.createPicture(anchor, pictureIndex);
        	}
        }
        objCell = objRow.createCell((short)11);
        objCell.setCellValue(nullToBlank(rs.getString("IMPROV_MGMT")));
        objCell.setCellStyle(styleBody);    	
        objCell = objRow.createCell((short)12);
        if(rs.getString("IMPROV_SVR_IMGE") == null || rs.getString("IMPROV_SVR_IMGE").equals("")) {
            objCell.setCellValue("미등록");        	
            objCell.setCellStyle(styleBodyC);    	    	
        } else {
        	if(rs.getString("IMPROV_SVR_IMGE").indexOf("img_NoImageBig.png") > 0) {
                objCell.setCellValue("미등록");        	
                objCell.setCellStyle(styleBodyC);    	    	
        	} else {
        		String strURL = strImgRoot + nullToBlank(rs.getString("IMPROV_SVR_IMGE"));
        	    url = new URL(strURL.replaceAll(" ","%20"));

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

        		anchor=new HSSFClientAnchor(13,13,13,251,(short)12,RowCnt,(short)13,RowCnt);
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
        if (conn != null) {
            try {
                conn.close();
            } catch(Exception e) {}
        }
    }
%>