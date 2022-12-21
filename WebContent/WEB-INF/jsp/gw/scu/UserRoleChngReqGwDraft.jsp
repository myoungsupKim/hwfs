<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
   * 시스템 권한변경 요청 그룹웨어 연동을 위해 본문을 생성하는 JSP
   * 김재섭 요청으로 김민수 개발
   * - jstl tag를 이용 (표준)
   * @ClassName UserRoleChngReqGwDraft.jsp
   * @Description UserRoleChngReqGwDraft JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.06.30.   김재섭        최초 생성
   *
   * @author FC종합전산구축 : AA kksoo
   * @since 2015.06.30.
   * @version 1.0
   * @see
   * <pre>
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   * </pre>
   */
%>
<%@ page import= "java.io.*
                , java.util.*
                , org.springframework.web.context.*
                , org.springframework.web.context.support.WebApplicationContextUtils
                , com.hwfs.cmn.service.PropertiesService"%>
<%
    ServletContext sc = pageContext.getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

    //propertiesService Bean을 얻는다.
    PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");
%>

<!-- fn:replace 의 \n <br> 변환하기위한 세팅 -->
<jsp:scriptlet>
pageContext.setAttribute("newline", "\n");
</jsp:scriptlet>


<LINK rel=stylesheet type=text/css href="<%=propertiesService.getString("gw.server.css","")%>">
<DIV id=subContents>
    <DIV class=contents>
        <!-- 본문 제목 표시 -->
        <c:if test="${gwDraftTitle != ''}">
        <DIV style="TEXT-ALIGN: center;">
            <H2><c:out value="${gwDraftTitle}"/></H2>
        </DIV>
        </c:if>

        <DIV class=clear></DIV>
        <DIV>
        현재 사용중인 시스템에 대하여 아래와 같이 권한변경을 요청합니다.<br>
        </DIV>
        <DIV class=clear></DIV>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%"/>
                    <COL />
                    <COL style="WIDTH: 15%"/>
                    <COL />
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH>시스템</TH>
                        <TD style="TEXT-ALIGN: center" colspan="3"><c:out value="${gwDraftMaster.sysName}"/></TD>
                    </TR>
                    <TR>
                        <TH>팀</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.tmNm}"/></TD>
                        <TH>압장</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.upjangnm}"/></TD>
                    </TR>
                    <TR>
                        <TH>사번</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.sabun}"/></TD>
                        <TH>성명</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.nmKor}"/></TD>
                    </TR>
                    <TR>
                        <TH>요청일자</TH>
                        <fmt:parseDate var="reqDate" value="${gwDraftMaster.reqDate}" pattern="yyyy-MM-dd"/>
                        <TD style="TEXT-ALIGN: center"><fmt:formatDate value="${reqDate}" pattern="yyyy-MM-dd"/></TD>
                        <TH>요청사유</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.reason}"/></TD>
                    </TR>
                    <TR>
                        <TH>요청사항(담당업무)</TH>
                        <TD colspan=3><c:out value="${fn:replace(gwDraftMaster.chgContents, newline, '<br />')}" escapeXml="false"/></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>