<%@page import="org.apache.axis.components.logger.LogFactory"%>
<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>
<%
  /**
   * 위생점검결과
   * - 서버 scriptlet 이용 (비표준)
   * @ClassName FSC00080V_Pop.jsp
   * @Description FSC00080V_Pop JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2019.01.23.   김명섭        최초생성
   *
   * @author FC정보기획팀
   * @since 2019.01.23.
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

	String strTitle      = LimsUtil.checkNull(java.net.URLDecoder.decode(request.getParameter("TITLE"),"UTF-8"));
    String strTableType  = LimsUtil.checkNull(request.getParameter("TABLE_TYPE"));
    String strFromDt     = LimsUtil.checkNull(request.getParameter("FROM_DT"));
    String strToDt       = LimsUtil.checkNull(request.getParameter("TO_DT"));
    String strFormCd     = LimsUtil.checkNull(request.getParameter("FORM_CD"));
    String strCheckType  = LimsUtil.checkNull(request.getParameter("CHECK_TYPE"));
    String strLrgClassCd = LimsUtil.checkNull(request.getParameter("LRG_CLASS_CD"));
    String strMuCd       = LimsUtil.checkNull(request.getParameter("MU_CD"));
    String strTmCd       = LimsUtil.checkNull(request.getParameter("TM_CD"));
    String strJob        = LimsUtil.checkNull(request.getParameter("JOB"));
    String strSubJob     = LimsUtil.checkNull(request.getParameter("SUB_JOB"));
    String strUpjang     = LimsUtil.checkNull(request.getParameter("UPJANG"));
    String strClassCd    = LimsUtil.checkNull(request.getParameter("CLASS_CD"));
    String strCheckSabun = LimsUtil.checkNull(request.getParameter("CHECK_SABUN"));
    String strCheckSeq   = LimsUtil.checkNull(request.getParameter("CHECK_SEQ"));
    String strImgRoot    = LimsUtil.checkNull(request.getParameter("IMG_ROOT"));

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

    //System.out.println("★★★★★★★★★★★★★★FSC00080V_Pop.jsp★★★★★★★★★★★★★★★★");
    //System.out.println(sbSql.toString());
    //System.out.println("★★★★★★★★★★★★★★FSC00080V_Pop.jsp★★★★★★★★★★★★★★★★");

    try {

      pstmt = conn.prepareStatement(sbSql.toString());
      rs = pstmt.executeQuery();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function ExlSave() 
{
	var frm = document.SaveForm;
	frm.action = "FSC00080V_POI_Save.jsp";
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



#subContents .contents h4 div.maintitle {float:center;padding-top:3px;}
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
        <!--  <H4><DIV class=maintitle><SPAN><%=nullToBlank(strTitle)%></SPAN></DIV></H4> -->
        <!--  <H3><DIV class=title><SPAN>1. 위생점검결과</SPAN></DIV></H3> -->
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=1 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 5%" border=1>
                    <COL style="WIDTH: 5%" border=1>
                    <COL style="WIDTH: 5%" border=1>
                    <COL style="WIDTH: 5%" border=1>
                    <COL style="WIDTH: 10%" border=1>
                    <COL style="WIDTH: 5%" border=1>
                    <COL style="WIDTH: 5%" border=1>
                    <COL style="WIDTH: 5%" border=1>
                    <COL style="WIDTH: 5%" border=1>
                    <COL style="WIDTH: 15%" border=1>
                    <COL style="WIDTH: 10%" border=1>
                    <COL style="WIDTH: 15%" border=1>
                    <COL style="WIDTH: 10%" border=1>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center" border=1>No.</TH>
                        <TH style="TEXT-ALIGN: center" border=1>평가항목</TH>
                        <TH style="TEXT-ALIGN: center" border=1>사업부</TH>
                        <TH style="TEXT-ALIGN: center" border=1>팀</TH>
                        <TH style="TEXT-ALIGN: center" border=1>사업장</TH>
                        <TH style="TEXT-ALIGN: center" border=1>점검일</TH>
                        <TH style="TEXT-ALIGN: center" border=1>점장명</TH>
                        <TH style="TEXT-ALIGN: center" border=1>점검자</TH>
                        <TH style="TEXT-ALIGN: center" border=1>점수</TH>
                        <TH style="TEXT-ALIGN: center" border=1>평가내용</TH>
                        <TH style="TEXT-ALIGN: center" border=1>평가사진</TH>
                        <TH style="TEXT-ALIGN: center" border=1>개선계획</TH>
                        <TH style="TEXT-ALIGN: center" border=1>개선사진</TH>
                    </TR>
                    <%
    	                int noCnt  = 0;
                    	while(rs.next()) {
                    		noCnt++;
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center"><%=noCnt%></TD>
                        <TD><%=nullToBlank(rs.getString("MIDDLE_CLASS_NAME"))%></TD>
                        <TD><%=nullToBlank(rs.getString("MU_NM"))%></TD>
                        <TD><%=nullToBlank(rs.getString("TM_NM"))%></TD>
                        <TD><%=nullToBlank(rs.getString("UPJANGNM"))%></TD>
                        <TD><%=nullToBlank(rs.getString("CHECK_DATE"))%></TD>
                        <TD><%=nullToBlank(rs.getString("CHARGE_NM"))%></TD>
                        <TD><%=nullToBlank(rs.getString("CHECK_SABUN_NM"))%></TD>
                        <TD style="TEXT-ALIGN: right"><%=nullToBlank(rs.getString("MARK"))%></TD>
                        <TD><%=nullToBlank(rs.getString("EVAL_CONTENTS"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        <%
                        	if(rs.getString("SVR_IMGE") == null || rs.getString("SVR_IMGE").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                    			if(rs.getString("SVR_IMGE").indexOf("img_NoImageBig.png") > 0) {
                        %>
                                    미등록
                        <%
                    			} else {
                        %>
                        	<div style="width: 100px; height: 100px; line-height: 100px; text-align: center">
                        	<img src="<%=strImgRoot%><%=rs.getString("SVR_IMGE")%>" style="width: 100px; height: 100px; vertical-align: middle"/>
                        	</div>
                        <%
                    			}
                    		}
                        %>
                        </TD>
                        <TD><%=nullToBlank(rs.getString("IMPROV_MGMT"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        <%
                        	if(rs.getString("IMPROV_SVR_IMGE") == null || rs.getString("IMPROV_SVR_IMGE").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                    			if(rs.getString("IMPROV_SVR_IMGE").indexOf("img_NoImageBig.png") > 0) {
                        %>
                                    미등록
                        <%
                    			} else {
                        %>
                        	<div style="width: 100px; height: 100px; line-height: 100px; text-align: center">
                        	<img src="<%=strImgRoot%><%=rs.getString("IMPROV_SVR_IMGE")%>" style="width: 100px; height: 100px; vertical-align: middle"/>
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
	<input type="hidden" id="TITLE" name="TITLE" value=<%=java.net.URLEncoder.encode(strTitle,"UTF-8") %>>
	<input type="hidden" id="TABLE_TYPE" name="TABLE_TYPE" value=<%=java.net.URLEncoder.encode(strTableType,"UTF-8") %>>
	<input type="hidden" id="FROM_DT" name="FROM_DT" value=<%=java.net.URLEncoder.encode(strFromDt,"UTF-8") %>>
	<input type="hidden" id="TO_DT" name="TO_DT" value=<%=java.net.URLEncoder.encode(strToDt,"UTF-8") %>>
	<input type="hidden" id="FORM_CD" name="FORM_CD" value=<%=java.net.URLEncoder.encode(strFormCd,"UTF-8") %>>
	<input type="hidden" id="CHECK_TYPE" name="CHECK_TYPE" value=<%=java.net.URLEncoder.encode(strCheckType,"UTF-8") %>>
	<input type="hidden" id="LRG_CLASS_CD" name="LRG_CLASS_CD" value=<%=java.net.URLEncoder.encode(strLrgClassCd,"UTF-8") %>>
	<input type="hidden" id="MU_CD" name="MU_CD" value=<%=java.net.URLEncoder.encode(strMuCd,"UTF-8") %>>
	<input type="hidden" id="TM_CD" name="TM_CD" value=<%=java.net.URLEncoder.encode(strTmCd,"UTF-8") %>>
	<input type="hidden" id="JOB" name="JOB" value=<%=java.net.URLEncoder.encode(strJob,"UTF-8") %>>
	<input type="hidden" id="SUB_JOB" name="SUB_JOB" value=<%=java.net.URLEncoder.encode(strSubJob,"UTF-8") %>>
	<input type="hidden" id="UPJANG" name="UPJANG" value=<%=java.net.URLEncoder.encode(strUpjang,"UTF-8") %>>
	<input type="hidden" id="CLASS_CD" name="CLASS_CD" value=<%=java.net.URLEncoder.encode(strClassCd,"UTF-8") %>>
	<input type="hidden" id="CHECK_SABUN" name="CHECK_SABUN" value=<%=java.net.URLEncoder.encode(strCheckSabun,"UTF-8") %>>
	<input type="hidden" id="CHECK_SEQ" name="CHECK_SEQ" value=<%=java.net.URLEncoder.encode(strCheckSeq,"UTF-8") %>>
	<input type="hidden" id="IMG_ROOT" name="IMG_ROOT" value=<%=java.net.URLEncoder.encode(strImgRoot,"UTF-8") %>>
	<input type="submit" id=btnCall name=btnCall value="" onclick="ExlSave();" />
</form>
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
