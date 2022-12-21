<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
   
   * @ClassName CarMasterGwDraft.jsp
   * @Description CarMasterGwDraft.jsp
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2019.03.06.   kihoon        최초 생성
   * @author FC종합전산구축 : kihoon
   * @since 2019.03.06.
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
        <DIV class=clear></DIV>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%"/>
                    <COL/>
                    <COL style="WIDTH: 15%"/>
                    <COL/>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH>팀</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.tmNm}"/></TD>
                        <TH>업장</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.upjangnm}"/></TD>
                    </TR>
                    <TR>
                        <TH>사번</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.mgmtSabun}"/></TD>
                        <TH>성명</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.nmKor}"/></TD>
                    </TR>
                    <TR>
                        <TH>요청일자</TH>
                        <fmt:parseDate var="reqDate" value="${gwDraftMaster.reqDate}" pattern="yyyy-MM-dd"/>
                        <TD style="TEXT-ALIGN: center"><fmt:formatDate value="${gwDraftMaster.reqDate}" pattern="yyyy-MM-dd"/></TD>
                        <TH>구분</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.gubun}"/></TD>
                    </TR>
                    <TR>
                        <TH>차량번호</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.carNumber}" /></TD>
                        <TH>차량명</TH>
                        <TD style="TEXT-ALIGN: center"><c:out value="${gwDraftMaster.carClass}"/></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>  
        <DIV class=clear></DIV>
        <DIV>
		1. 필수첨부문서 <br>
			&nbsp; - 차량등록증<br>
			&nbsp; - 차량보험가입증서<br>
			&nbsp; - 운전면허증<br> 
			&nbsp;&nbsp; (만료일자가 유효한 증빙서류 첨부)<br>
			<br>
		2. 필수첨부문서의 만료(유효)일자가 경과할 경우 해당 증빙서류에 대하여 갱신한 첨부파일로 재상신하시기바랍니다.<br> 
		</DIV>
        <DIV class=clear></DIV>
    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>