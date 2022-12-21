<%@page import="org.apache.axis.components.logger.LogFactory"%>
<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>
<%
  /**
   * 협력업체위생관리 점검결과 상신
   * - 서버 scriptlet 이용 (비표준)
   * @ClassName FSC00310E_Pop.jsp
   * @Description FSC00310E_Pop JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2018.05.11.   김명섭        최초생성
   *
   * @author FC정보기획팀
   * @since 2018.05.11.
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

	PreparedStatement pstmt3= null;
	ResultSet rs3 = null;

    String strFormCd    = LimsUtil.checkNull(request.getParameter("FORM_CD"));
    String strCustcd    = LimsUtil.checkNull(request.getParameter("CUSTCD"));          // 협력업체
    String strChkDd     = LimsUtil.checkNull(request.getParameter("CHK_DD"));
    String strTableType = LimsUtil.checkNull(request.getParameter("TABLE_TYPE"));
    String strImgRoot   = LimsUtil.checkNull(request.getParameter("IMG_ROOT"));
    String strSubCompOrgNm = LimsUtil.checkNull(request.getParameter("SUB_COMP_NM"));
    String strSubCompNm   = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("SUB_COMP_NM"),"UTF-8"));

    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strFormCd = " + strFormCd);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCustcd = " + strCustcd);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strChkDd = " + strChkDd);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strTableType = " + strTableType);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strImgRoot = " + strImgRoot);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strSubCompNm = " + strSubCompNm);
 
    int i = 0;
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

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function ExlSave() 
{
	var frm = document.SaveForm;
	frm.action = "FSC00310E_POI_Save.jsp";
	frm.submit();
}
</script>

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
        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>1. 심사구분</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=1 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 250" border=1>
                    <COL style="WIDTH: 250" border=1>
                    <COL style="WIDTH: 260" border=1>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center" border=1>평가일자</TH>
                        <TH style="TEXT-ALIGN: center" border=1>소속/평가자</TH>
                        <TH style="TEXT-ALIGN: center" border=1>평가구분</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center" border=1><%=nullToBlank(rs.getString("CHK_DD"))%></TD>
                    	<TD style="TEXT-ALIGN: center" border=1><%=nullToBlank(rs.getString("TM_NM"))%> / <%=nullToBlank(rs.getString("INSPECTOR_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center" border=1><%=nullToBlank(rs.getString("CHK_CLASS_NM"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center" border=1>거래구분</TH>
                        <TH style="TEXT-ALIGN: center" border=1>식품의유형</TH>
                        <TH style="TEXT-ALIGN: center" border=1>유형구분</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center" border=1><%=nullToBlank(rs.getString("DEAL_CLASS"))%></TD>
                    	<TD style="TEXT-ALIGN: center" border=1><%=nullToBlank(rs.getString("FOOD_CLASS_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center" border=1><%=nullToBlank(rs.getString("FOOD_TYPE_CLASS"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center" border=1>경유센터</TH>
                        <TH style="TEXT-ALIGN: center" border=1 COLSPAN=2>납품처</TH>
                    </TR>
                    <TR>
                        <TD style="TEXT-ALIGN: center" border=1><%=nullToBlank(rs.getString("PASS_CENTER"))%></TD>
                    	<TD style="TEXT-ALIGN: center" border=1 COLSPAN=2><%=nullToBlank(rs.getString("DELIVERY_PLCE"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>2. 업체현황</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=1 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 30%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH>업체명</TH>
                        <TD><%=nullToBlank(rs.getString("VD_NM"))%> <%=nullToBlank(rs.getString("SUB_COMP_NM"))%></TD>
                        <TH>주요 납품품목</TH>
                        <TD><%=nullToBlank(rs.getString("ATTR01"))%></TD>
                    </TR>
                    <TR>
                        <TH>인증현황/인증일자</TH>
                        <TD><%=nullToBlank(rs.getString("ATTR02"))%></TD>
                        <TH>주요 납품처</TH>
                        <TD><%=nullToBlank(rs.getString("ATTR03"))%></TD>
                    </TR>
                    <TR>
                        <TH>영업의종류</TH>
                        <TD><%=nullToBlank(rs.getString("ATTR04"))%></TD>
                        <TH>대표자</TH>
                        <TD><%=nullToBlank(rs.getString("REP_NM"))%></TD>
                    </TR>
                    <TR>
                    	<TH>총 매출액(년)</TH>
                    	<TD><%=nullToBlank(rs.getString("ATTR05"))%></TD>
                    	<TH>매출점유율(%)</TH>
                    	<TD><%=nullToBlank(rs.getString("ATTR06"))%></TD>
                    </TR>
                    <TR>
                        <TH>연락처/메일</TH>
                        <TD><%=nullToBlank(rs.getString("ATTR07"))%></TD>
                        <TH>소재지</TH>
                        <TD><%=nullToBlank(rs.getString("ATTR08"))%></TD>
                    </TR>
                    <TR>
                        <TH>사용용수</TH>
                        <TD><%=nullToBlank(rs.getString("ATTR09"))%></TD>
                        <TH>정수처리시설</TH>
                        <TD><%=nullToBlank(rs.getString("ATTR10"))%></TD>
                    </TR>
                    <TR>
                        <TH>담당MD</TH>
                        <TD><%=nullToBlank(rs.getString("ATTR11"))%></TD>
                        <TH>심사시간/수검자</TH>
                        <TD><%=nullToBlank(rs.getString("CHK_START_TIME"))%> ~ <%=nullToBlank(rs.getString("CHK_END_TIME"))%> / <%=nullToBlank(rs.getString("ATTR12"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>3. 심사결과</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=1 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 30%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">구분</TH>
                        <TH style="TEXT-ALIGN: center">평가점수</TH>
                        <TH style="TEXT-ALIGN: center">위생등급</TH>
                        <TH style="TEXT-ALIGN: center">심사판정</TH>
                        <TH style="TEXT-ALIGN: center">거래유무</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">비고</TH>
                    </TR>
                    <TR>
                    	<TH>금번평가</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("SCORE"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("GRADE_CD"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHK_RESULT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("DEAL_YN"))%></TD>
                    	<TD><%=nullToBlank(rs.getString("ATTR13"))%></TD>
                    </TR>
                    <TR>
                    	<TH>전기평가(<%=nullToBlank(rs.getString("PREV_CHK_DD"))%>)</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("PREV_SCORE"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("PREV_GRADE_CD"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("PREV_CHK_RESULT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("PREV_DEAL_YN"))%></TD>
                    	<TD><%=nullToBlank(rs.getString("ATTR14"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>4. 총평</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1 list">
			<TABLE style="TABLE-LAYOUT: fixed" border=1 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 33%">
                    <COL style="WIDTH: 33%">
                    <COL style="WIDTH: 34%">
                </COLGROUP>
	            <TBODY>
	                <TR>
	                    <TD COLSPAN=3 height="100px" style="TEXT-ALIGN: left; vertical-align: top;"><%=nullToBlank(rs.getString("REMARK")).replace("\r\n", "<br/>")%>&nbsp;</TD>
	                </TR>
	            </TBODY>
	        </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>5. 세부 Category별 평가결과</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=1 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 28%">
                    <COL style="WIDTH: 12%">
                    <COL style="WIDTH: 12%">
                    <COL style="WIDTH: 12%">
                    <COL style="WIDTH: 12%">
                    <COL style="WIDTH: 12%">
                    <COL style="WIDTH: 12%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">구분</TH>
                        <TH style="TEXT-ALIGN: center">가중치</TH>
                        <TH style="TEXT-ALIGN: center">총점</TH>
                        <TH style="TEXT-ALIGN: center">평가총점</TH>
                        <TH style="TEXT-ALIGN: center">평가점수</TH>
                        <TH style="TEXT-ALIGN: center">백분율</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">반영점수</TH>
                    </TR>
                    <%
                    	while(rs1.next()) {
                    %>
                    <TR>
                        <TH><%=nullToBlank(rs1.getString("CLASS_NM"))%></TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("WGT_RATE"))%></TD>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("CHK_IDCTR"))%></TD>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("CHK_IDCTR_NA"))%></TD>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("CHK_SCORE_NA"))%></TD>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("RATIO"))%></TD>
                        <TD style="TEXT-ALIGN: right"><%=nullToBlank(rs1.getString("FINAL_SCORE"))%></TD>
                    </TR>
                    <%
                    	}
                    %>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>6. 사진첨부</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=1 cellSpacing=0>
                <COLGROUP>
                	<COL style="WIDTH: 5%">
                    <COL style="WIDTH: 35%">
                    <COL style="WIDTH: 35%">
                    <COL style="WIDTH: 25%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">No</TH>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">사진</TH>
                    </TR>
                    <%
    	                int noCnt  = 0;
                    	while(rs3.next()) {
                    		noCnt++;
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center"><%=noCnt%></TD>
                        <TD><%=nullToBlank(rs3.getString("CLASS_NM"))%></TD>
                        <TD><%=nullToBlank(rs3.getString("CHK_CONTENTS"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        <%
                        	if(rs3.getString("SVR_IMGE") == null || rs3.getString("SVR_IMGE").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                    			if(rs3.getString("SVR_IMGE").indexOf("img_NoImageBig.png") > 0) {
                        %>
                                    미등록
                        <%
                    			} else {
                        %>
                        	<div style="width: 100px; height: 100px; line-height: 100px; text-align: center">
                        	<img src="<%=strImgRoot%><%=rs3.getString("SVR_IMGE")%>" style="width: 100px; height: 100px; vertical-align: middle"/>
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
                </TBODY>
            </TABLE>
        </DIV>
    </DIV>
</DIV>
<form name="SaveForm">
	<input type="hidden" id="FORM_CD" name="FORM_CD" value=<%=strFormCd %>>
	<input type="hidden" id="CUSTCD" name="CUSTCD" value=<%=strCustcd %>>
	<input type="hidden" id="CHK_DD" name="CHK_DD" value=<%=strChkDd %>>
	<input type="hidden" id="TABLE_TYPE" name="TABLE_TYPE" value=<%=strTableType %>>
	<input type="hidden" id="IMG_ROOT" name="IMG_ROOT" value=<%=strImgRoot %>>
	<input type="hidden" id="SUB_COMP_NM" name="SUB_COMP_NM" value=<%=strSubCompOrgNm %>>
	<input type="submit" id=btnCall name=btnCall value="" onclick="ExlSave();" />
</form>
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
