<%@page import="org.apache.axis.components.logger.LogFactory"%>
<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>
<%
  /**
   * 외부기관 점검결과 조회
   * - 서버 scriptlet 이용 (비표준)
   * @ClassName FSC91040P.jsp
   * @Description FSC91040P JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2019.08.07.   김명섭        최초생성
   *
   * @author FC정보기획팀
   * @since 2019.08.07.
   * @version 1.0
   * @see
   * <pre>
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   * </pre>
   */
%>
<%@ page import="java.io.*
    , java.util.*
    , org.springframework.web.context.*
    , org.springframework.web.context.support.WebApplicationContextUtils
    , com.hwfs.ls.cmn.util.LimsUtil"%>

<%

	PreparedStatement pstmt1= null;
	ResultSet rs1 = null;

	PreparedStatement pstmt2= null;
	ResultSet rs2 = null;

    String strUpjang    = LimsUtil.checkNull(request.getParameter("UPJANG"));
    String strVisitDt   = LimsUtil.checkNull(request.getParameter("VISIT_DT"));
    String strSeqNo     = LimsUtil.checkNull(request.getParameter("SEQNO"));
    String strImgRoot   = LimsUtil.checkNull(request.getParameter("IMG_ROOT"));
 
    int i = 0;
    
    // 1. 사업장,방문기관정보
    StringBuffer sbSql = new StringBuffer();
    sbSql.append("SELECT UPJANG,                                                                                                \n");
    sbSql.append("       (SELECT UPJANGNM FROM ST_UPJANG WHERE A.UPJANG = UPJANG) AS UPJANG_NM,                                 \n");
    sbSql.append("       TO_CHAR(TO_DATE(VISIT_DT,'YYYYMMDD'),'YYYY-MM-DD') AS VISIT_DT,                                                                                              \n");
    sbSql.append("       SEQNO,                                                                                                 \n");
    sbSql.append("       TM_CD,                                                                                                 \n");
    sbSql.append("       (SELECT TM_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS TM_NM,                      \n");
    sbSql.append("       TEAM_MST_SABUN,                                                                                        \n");
    sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.TEAM_MST_SABUN) TEAM_MST_SABUN_NM,            \n");
    sbSql.append("       SUBTEAM_MST_SABUN,                                                                                     \n");
    sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.SUBTEAM_MST_SABUN) SUBTEAM_MST_SABUN_NM,      \n");
    sbSql.append("       CHARGE_SABUN,                                                                                          \n");
    sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.CHARGE_SABUN) CHARGE_SABUN_NM,                \n");
    sbSql.append("       PERMISSION_TYPE,                                                                                       \n");
    sbSql.append("       SCC_CODE_NM('MA0004',A.PERMISSION_TYPE) AS PERMISSION_TYPE_NM,                                         \n");
    sbSql.append("       AGENCY_TYPE,                                                                                           \n");
    sbSql.append("       SCC_CODE_NM('FS9110',A.AGENCY_TYPE) AS AGENCY_TYPE_NM,                                                 \n");
    sbSql.append("       CHECK_TYPE,                                                                                            \n");
    sbSql.append("       SCC_CODE_NM('FS9120',A.CHECK_TYPE) AS CHECK_TYPE_NM,                                                   \n");
    sbSql.append("       AGENCY_NM,                                                                                             \n");
    sbSql.append("       VISIT_NM,                                                                                              \n");
    sbSql.append("       CONFIRM_YN,                                                                                            \n");
    sbSql.append("       EXPOSE_YN,                                                                                             \n");
    sbSql.append("       PICK_CHECK_YN,                                                                                         \n");
    sbSql.append("       CHECK_CONTENTS,                                                                                        \n");
    sbSql.append("       ETC_CONTENTS,                                                                                          \n");
    sbSql.append("       SIGN_INSTANCE_ID,                                                                                      \n");
    sbSql.append("       CASE WHEN A.SIGN_INSTANCE_ID IS NOT NULL THEN NVL(SCC_SIGN_STATUS_FUN(A.SIGN_INSTANCE_ID), 'DRAFT') END AS SIGN_PROGRESS_STATUS,  \n");
    sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.UUSER) UUSER                                  \n");
    sbSql.append("  FROM FSC_TEST_EXTERNAL_MST A                                                                                \n");
    sbSql.append(" WHERE A.UPJANG = '" + strUpjang + "' \n");
    sbSql.append("   AND A.VISIT_DT = '" + strVisitDt + "' \n");
    sbSql.append("   AND A.SEQNO = " + strSeqNo + " \n");

    // 2. 수검사항
    StringBuffer sbSql1 = new StringBuffer();
    sbSql1.append("SELECT A.UPJANG,                                                                                                \n");
    sbSql1.append("       TO_CHAR(TO_DATE(A.VISIT_DT,'YYYYMMDD'),'YYYY-MM-DD') AS VISIT_DT,                                                                                              \n");
    sbSql1.append("       A.SEQNO,                                                                                                 \n");
    sbSql1.append("       A.CHECKSEQ,                                                                                                 \n");
    sbSql1.append("       A.CHECKGB,                                                                                                 \n");
    sbSql1.append("       SCC_CODE_NM('FS9130',A.CHECKGB) AS CHECKGBNM,                                         \n");
    sbSql1.append("       A.CHECKDTL,                                                                                                 \n");
    sbSql1.append("       SCC_CODE_NM('FS9140',A.CHECKDTL) AS CHECKDTLNM,                                         \n");
    sbSql1.append("       A.CHECK_CONTENTS,                                                                                                 \n");
    sbSql1.append("       A.IMPRV_CONTENTS,                                                                                                 \n");
    sbSql1.append("       TO_CHAR(TO_DATE(A.IMPRV_DT,'YYYYMMDD'),'YYYY-MM-DD') AS IMPRV_DT,                                                                                                 \n");
    sbSql1.append("       A.MAIN_AGENT,                                                                                                 \n");
    sbSql1.append("       SCC_CODE_NM('FS9150',A.MAIN_AGENT) AS MAIN_AGENTNM,                                         \n");
    sbSql1.append("       B.IMGESEQ,                                                                                                 \n");
//     sbSql1.append("       --DECODE(B.SVR_IMGE,NULL,NULL,REPLACE(utl_encode.text_encode(B.SVR_IMGE),'=','%')) AS SPHOTO,                 \n");
//     sbSql1.append("       --DECODE(B.IMPROV_SVR_IMGE,NULL,NULL,REPLACE(utl_encode.text_encode(B.IMPROV_SVR_IMGE),'=','%')) AS ISPHOTO,   \n");
    sbSql1.append("       DECODE(B.SVR_IMGE,NULL,NULL,B.SVR_IMGE) AS SPHOTO,                 \n");
    sbSql1.append("       DECODE(B.IMPROV_SVR_IMGE,NULL,NULL,B.IMPROV_SVR_IMGE) AS ISPHOTO,   \n");
    sbSql1.append("       DECODE(B.IMGESEQ,NULL,2,(SELECT COUNT(*) FROM FSC_TEST_EXTERNAL_IMGE WHERE UPJANG = A.UPJANG AND VISIT_DT = A.VISIT_DT AND SEQNO = A.SEQNO AND CHECKSEQ = A.CHECKSEQ)+1) AS ROWSPAN   \n");
    sbSql1.append("  FROM FSC_TEST_EXTERNAL_DTL A, FSC_TEST_EXTERNAL_IMGE B                                                                                \n");
    sbSql1.append(" WHERE A.UPJANG = '" + strUpjang + "' \n");
    sbSql1.append("   AND A.VISIT_DT = '" + strVisitDt + "' \n");
    sbSql1.append("   AND A.SEQNO = " + strSeqNo + " \n");
    sbSql1.append("   AND A.UPJANG = B.UPJANG(+)         \n");
    sbSql1.append("   AND A.VISIT_DT = B.VISIT_DT(+)     \n");
    sbSql1.append("   AND A.SEQNO = B.SEQNO(+)           \n");
    sbSql1.append("   AND A.CHECKSEQ = B.CHECKSEQ(+)     \n");
    sbSql1.append(" ORDER BY A.VISIT_DT DESC, A.SEQNO, A.CHECKSEQ, B.IMGESEQ \n");

    // 3. 수거검사내역
    StringBuffer sbSql2 = new StringBuffer();
    sbSql2.append("SELECT UPJANG,                                                                                                \n");
    sbSql2.append("       VISIT_DT,                                                                                              \n");
    sbSql2.append("       SEQNO,                                                                                                 \n");
    sbSql2.append("       CHECKSEQ,                                                                                                 \n");
    sbSql2.append("       CHECKGB,                                                                                                 \n");
    sbSql2.append("       SCC_CODE_NM('FS9160',A.CHECKGB) AS CHECKGBNM,                                         \n");
    sbSql2.append("       PUMMOK,                                                                                                 \n");
    sbSql2.append("       STATUS,                                                                                                 \n");
    sbSql2.append("       MOVEGB,                                                                                                 \n");
    sbSql2.append("       SCC_CODE_NM('FS9170',A.MOVEGB) AS MOVEGBNM                                          \n");
    sbSql2.append("  FROM FSC_TEST_EXTERNAL_DTL_PICK A                                                                                \n");
    sbSql2.append(" WHERE A.UPJANG = '" + strUpjang + "' \n");
    sbSql2.append("   AND A.VISIT_DT = '" + strVisitDt + "' \n");
    sbSql2.append("   AND A.SEQNO = " + strSeqNo + " \n");
    sbSql2.append(" ORDER BY A.VISIT_DT DESC, A.SEQNO, A.CHECKSEQ \n");

    try {

      pstmt = conn.prepareStatement(sbSql.toString());
      rs = pstmt.executeQuery();
      rs.next();

      pstmt1 = conn.prepareStatement(sbSql1.toString());
      rs1 = pstmt1.executeQuery();

      pstmt2 = conn.prepareStatement(sbSql2.toString());
      rs2 = pstmt2.executeQuery();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#subContents .none{display:none}
#subContents .acc_sub_head {display:none}
#subContents .button_basic {display:none}
#subContents th span {display:none}


#subContents .contents { position:relative; margin:0px; padding: 0px; }
#subContents .contents h3 { position:relative; font-size:12px; color:#000; margin-bottom:-1px; height:25px; border:0px solid #84a0c4; repeat-x left 50%; }
#subContents .contents h3 span { display:block; margin-left:0px; padding-top:3px; color:#053A8F; }
#subContents .contents h3 .print { position:absolute; top:4px; right:6px; }



#subContents .contents h3 div.title {float:left;padding-top:3px;}
#subContents .contents h3 div.btngrp {float:right;padding-top:2px;padding-right:5px;}
#subContents .contents h3 div.btngrp div {padding-top:0px;display:'';}

#subContents div.hgtSplit5{height:5px;}
#subContents div.hgtSplit10{height:10px;}
#subContents div.hgtSplit15{height:15px;}
#subContents div.hgtSplit20{height:20px;}

.floatLeft { float:left !important; }
.floatRight { float:right !important; }
.textLeft { text-align:left !important; }
.textCenter { text-align:center !important; }
.textRight { text-align:right !important; }

.clear {clear:both;}

/* acc_table_basic
---------------------------------------------------------*/
.acc_table_basic { position:relative; margin-bottom:10px; width:800px; border-top:1px solid #9ea2a8; font-size:12px; font-family: Tahoma,'굴림', 'Dotum';}
.acc_table_basic table { 
    width:800px;
    border-spacing:0px !important; 
    box-shadow: 0px 3px 0px rgba(0, 0, 0, 0.04); 
    -webkit-box-shadow:0px 3px 0px rgba(0, 0, 0, 0.04); 
    -moz-box-shadow:0px 3px 0px rgba(0, 0, 0, 0.04); 
    border-collapse:collapse; empty-cell:show;
}
.acc_table_basic table caption { display:none; }
.acc_table_basic table th { font-weight:normal; line-height:20px; text-align:left; color:#333; padding:3px 6px 2px 8px; border:1px solid #9EA2A8;
    font-size:12px; font-family: Tahoma,'굴림', 'Dotum';  
    border-top:none; border-top:none; border-right:none;
    background : #e3e3e3;
    background: -ms-linear-gradient(#f8f8f8, #e3e3e3); 
    background: -webkit-gradient(linear, left top, left bottom, from(#f8f8f8), to(#e3e3e3));  
    background: -moz-linear-gradient(top,  #f8f8f8,  #e3e3e3);
    *background : #e3e3e3; /* IE7 and below */
    _background : #e3e3e3; /* IE6 */    
    
    }
.acc_table_basic table th:last-child {
    border-right:1px solid #9EA2A8;
}
.acc_table_basic table th span { color:#b13c5c; font-weight:bold; }
.acc_table_basic table th.lbnone { border-left:none; }
.acc_table_basic table td { line-height:19px; padding:3px 6px 2px 6px; word-break:break-all; border:1px solid #9ea2a8; border-top:none; background-color:#fff; }


.acc_table_basic.style1 table th.lbnone { border-left:none; }
.acc_table_basic.style1 table td.lbnone { border-left:none; }
.acc_table_basic.style1 table th.tbnone { border-top:none; }
.acc_table_basic.style1 table th.rbnone { border-right:none; }
.acc_table_basic.style1 table td.rbnone { border-right:none; }
.acc_table_basic.style1 table th.bbnone { border-bottom:none; }


.acc_table_basic.style1 table td { color:#000; line-height:19px; padding:3px 6px 3px 6px; word-break:break-all; border:1px solid #9ea2a8; border-top:none; background-color:#fff; 
    font-size:12px; font-family: Tahoma,'굴림', 'Dotum';
}

.acc_table_basic.list table th 
{ 
    text-align:center; 
}
</style>
</head>
<body>
<DIV id=subContents>
    <DIV class=contents>
        <DIV style="TEXT-ALIGN: center; margin-top:20px;">
            <SPAN STYLE="font-size:20px;"><b><%=nullToBlank(rs.getString("UPJANG_NM"))%> - 외부기관 점검결과 보고서</b></SPAN>
        </DIV>
        <H3><DIV class=title><SPAN>1. 사업장 정보</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 20%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">운영부서</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TM_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">팀장/본부장</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TEAM_MST_SABUN_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">본부팀장</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("SUBTEAM_MST_SABUN_NM"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">점장명</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHARGE_SABUN_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">인허가형태</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("PERMISSION_TYPE_NM"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>2. 방문기관 정보</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 20%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">방문기관</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("AGENCY_TYPE_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">점검유형</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_TYPE_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">방문일자</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("VISIT_DT"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">기관명</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("AGENCY_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">방문자</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("VISIT_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">확인서청구여부</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CONFIRM_YN"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">행정처분적발여부</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("EXPOSE_YN"))%></TD>
                        <TH style="TEXT-ALIGN: center">내용</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_CONTENTS"))%></TD>
                        <TH style="TEXT-ALIGN: center">수거검사여부</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("PICK_CHECK_YN"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>3. 수검사항</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 5%">
                    <COL style="WIDTH: 5%">
                    <COL style="WIDTH: 37%">
                    <COL style="WIDTH: 38%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 5%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">구분</TH>
                        <TH style="TEXT-ALIGN: center">항목</TH>
                        <TH style="TEXT-ALIGN: center">점검세부내용</TH>
                        <TH style="TEXT-ALIGN: center">개선조치계획</TH>
                        <TH style="TEXT-ALIGN: center">개선일자</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">주체</TH>
                    </TR>
                    <%
                    	int nCnt = 0;
                        String tCHECKSEQ = "";
                    	String CHECKSEQ = "";
                    	while(rs1.next()) {
                    		nCnt++;
                    		CHECKSEQ = nullToBlank(rs1.getString("CHECKSEQ"));
                    %>
                    <%
                		if(!tCHECKSEQ.equals(CHECKSEQ))
                		{
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: Center; HEIGHT:120px" rowspan="<%=nullToBlank(rs1.getString("ROWSPAN"))%>"><%=nullToBlank(rs1.getString("CHECKGBNM"))%></TD>
                    	<TD style="TEXT-ALIGN: Center; HEIGHT:120px" rowspan="<%=nullToBlank(rs1.getString("ROWSPAN"))%>"><%=nullToBlank(rs1.getString("CHECKDTLNM"))%></TD>
                    	<TD style="TEXT-ALIGN: left; HEIGHT:120px"><%=nullToBlank(rs1.getString("CHECK_CONTENTS"))%></TD>
                    	<TD style="TEXT-ALIGN: left; HEIGHT:120px"><%=nullToBlank(rs1.getString("IMPRV_CONTENTS"))%></TD>
                    	<TD style="TEXT-ALIGN: Center; HEIGHT:120px" rowspan="<%=nullToBlank(rs1.getString("ROWSPAN"))%>"><%=nullToBlank(rs1.getString("IMPRV_DT"))%></TD>
                    	<TD style="TEXT-ALIGN: Center; HEIGHT:120px" rowspan="<%=nullToBlank(rs1.getString("ROWSPAN"))%>"><%=nullToBlank(rs1.getString("MAIN_AGENTNM"))%></TD>
                    </TR>
 
                     <TR>
                    	<TD style="TEXT-ALIGN: center; HEIGHT:120px">
                        <%
                        	if(rs1.getString("SPHOTO") == null || rs1.getString("SPHOTO").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                    			if(rs1.getString("SPHOTO").indexOf("img_NoImageBig.png") > 0) {
                        %>
                                    미등록
                        <%
                    			} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=nullToBlank(rs1.getString("SPHOTO"))%>" style="width: 100%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    			}
                    		}
                        %>
                    	</TD>
                    	<TD style="TEXT-ALIGN: center; HEIGHT:120px">
                        <%
                        	if(rs1.getString("ISPHOTO") == null || rs1.getString("ISPHOTO").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                    			if(rs1.getString("ISPHOTO").indexOf("img_NoImageBig.png") > 0) {
                        %>
                                    미등록
                        <%
                    			} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=nullToBlank(rs1.getString("ISPHOTO"))%>" style="width: 100%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    			}
                    		}
                        %>
                    	</TD>
                    </TR>
 
                    <%
                		} else {
                    %>
                    <TR>
                    	<TD style="TEXT-ALIGN: center; HEIGHT:120px">
                        <%
                        	if(rs1.getString("SPHOTO") == null || rs1.getString("SPHOTO").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                    			if(rs1.getString("SPHOTO").indexOf("img_NoImageBig.png") > 0) {
                        %>
                                    미등록
                        <%
                    			} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=nullToBlank(rs1.getString("SPHOTO"))%>" style="width: 100%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    			}
                    		}
                        %>
                    	</TD>
                    	<TD style="TEXT-ALIGN: center; HEIGHT:120px">
                        <%
                        	if(rs1.getString("ISPHOTO") == null || rs1.getString("ISPHOTO").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                    			if(rs1.getString("ISPHOTO").indexOf("img_NoImageBig.png") > 0) {
                        %>
                                    미등록
                        <%
                    			} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=nullToBlank(rs1.getString("ISPHOTO"))%>" style="width: 100%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    			}
                    		}
                        %>
                    	</TD>
                    </TR>
                    <%
                		}
                    %>
                    <%
                		if(!tCHECKSEQ.equals(CHECKSEQ))
                		{
                    %>
                    <%
		               		tCHECKSEQ = nullToBlank(rs1.getString("CHECKSEQ"));
                		}
                    %>
                    <%
                    	}
                		if(nCnt == 0)
                		{
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center" colspan="6">등록된 내용이 없습니다.</TD>
                    </TR>
                    <%
                    	}
                    %>
                </TBODY>
            </TABLE>
        </DIV>
		<DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>4. 수거검사내역</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                	<COL style="WIDTH: 10%">
                    <COL style="WIDTH: 35%">
                    <COL style="WIDTH: 35%">
                    <COL style="WIDTH: 15%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                     	<TH style="TEXT-ALIGN: center">구분</TH>
                        <TH style="TEXT-ALIGN: center">수거품목</TH>
                        <TH style="TEXT-ALIGN: center">수거상태</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">시료이동방법</TH>
                    </TR>
                    <%
                    	nCnt = 0;
                    	while(rs2.next()) {
                    		nCnt++;
                    %>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("CHECKGBNM"))%></TD>
                    	<TD style="TEXT-ALIGN: Left"><%=nullToBlank(rs2.getString("PUMMOK"))%></TD>
                    	<TD style="TEXT-ALIGN: Left"><%=nullToBlank(rs2.getString("STATUS"))%></TD>
                    	<TD style="TEXT-ALIGN: Left"><%=nullToBlank(rs2.getString("MOVEGBNM"))%></TD>
                    </TR>
                    <%
                    	}
                		if(nCnt == 0)
                		{
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center" colspan="4">등록된 내용이 없습니다.</TD>
                    </TR>
                    <%
                    	}
                    %>
                </TBODY>
            </TABLE>
        </DIV>
		<DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>5. 기타 특이사항</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                	<COL style="WIDTH: 100%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                    	<TD style="TEXT-ALIGN: Left"><%=nullToBlank(rs.getString("ETC_CONTENTS"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
    </DIV>
</DIV>
</body>
</html>
<%
		pstmt.close();
		rs.close();

		pstmt1.close();
		rs1.close();

		pstmt2.close();
		rs2.close();

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
        if (conn != null) {
            try {
                conn.close();
            } catch(Exception e) {}
        }
    }
%>
