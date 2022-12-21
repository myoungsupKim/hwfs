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
        <DIV style="TEXT-ALIGN: center;">
            <H2>처리협조</H2>
        </DIV>
        <DIV class="acc_table_basic style1">
        	<TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 20%;"/>
                    <COL style="WIDTH: 80%"/>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="text-align:center;">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</TH>
                        <TD><c:out value="${gwDraftTitle.title}"/></TD>
                    </TR>
                    <TR>
                        <TH style="text-align:center;">기&nbsp;안&nbsp;자</TH>
                        <TD><c:out value="${gwDraftSendUser.approvalUser}"/></TD>
                    </TR>
                    <TR>
                        <TH style="text-align:center;">수&nbsp;신&nbsp;처</TH>
                        <TD>수신처 별도</TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <br>
        <DIV>
        거래처 등록/변경을 아래와 같이 요청드리오니 처리하여 주시기 바랍니다.<br>
        </DIV>
        <br>
        <DIV style="TEXT-ALIGN:center;">
        -&nbsp;&nbsp;아&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;래&nbsp;&nbsp;-
        </DIV>
        <br>
        <DIV class=clear></DIV>
		<c:if test="${gwDraftTitle.cntNew != '0'}">
        <DIV><B>※ 신규거래처 ※</B></DIV>
        </c:if>       
        <c:forEach var="result" items="${gwDraftNewCust}" varStatus="status">
	        <DIV class="acc_table_basic style1">
	        	<TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
	                <COLGROUP>
	                    <COL style="WIDTH: 12%;"/>
	                    <COL />
	                    <COL style="WIDTH: 12%;"/>
	                    <COL />
	                    <COL style="WIDTH: 12%;"/>
	                    <COL />
	                </COLGROUP>
	                <TBODY id=tbdArea>
	                    <TR>
	                        <TH style="text-align:center;">거&nbsp;래&nbsp;처&nbsp;명</TH>
	                        <TD colspan="3"><c:out value="${result.custNm}"/></TD>
	                        <TH style="text-align:center;">대표자</TH>
	                        <TD><c:out value="${result.ceoHangulName}"/></TD>
	                    </TR>
	                    <TR>
	                        <TH style="text-align:center;">사업자번호</TH>
	                        <TD><c:out value="${result.bsnNo}"/></TD>
	                        <TH style="text-align:center;">업&nbsp;&nbsp;&nbsp;태</TH>
	                        <TD><c:out value="${result.bizType}"/></TD>
	                        <TH style="text-align:center;">종&nbsp;&nbsp;&nbsp;목</TH>
	                        <TD><c:out value="${result.bizCat}"/></TD>
	                    </TR>
	                    <TR>
	                        <TH style="text-align:center;">거래처구분</TH>
	                        <TD><c:out value="${result.custClass}"/></TD>
	                        <TH style="text-align:center;">소재지</TH>
	                        <TD colspan="3"><c:out value="${result.addr}"/></TD>
	                    </TR>
	                </TBODY>
	            </TABLE>
	        </DIV>
		</c:forEach>
		<c:if test="${gwDraftTitle.cntChange != '0'}">
        <DIV><B>※ 거래처변경 ※</B></DIV>
        </c:if>       
        <c:forEach var="result" items="${gwDraftChangeCust}" varStatus="status">
	        <DIV class="acc_table_basic style1">
	        	<TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
	                <COLGROUP>
	                    <COL style="WIDTH: 12%;"/>
	                    <COL />
	                    <COL style="WIDTH: 12%;"/>
	                    <COL />
	                    <COL style="WIDTH: 12%;"/>
	                    <COL />
	                </COLGROUP>
	                <TBODY id=tbdArea>
	                    <TR>
	                        <TH style="text-align:center;">거&nbsp;래&nbsp;처&nbsp;명</TH>
	                        <TD colspan="3"><c:out value="${result.custNm}"/></TD>
	                        <TH style="text-align:center;">대표자</TH>
	                        <TD><c:out value="${result.ceoHangulName}"/></TD>
	                    </TR>
	                    <TR>
	                        <TH style="text-align:center;">사업자번호</TH>
	                        <TD><c:out value="${result.bsnNo}"/></TD>
	                        <TH style="text-align:center;">업&nbsp;&nbsp;&nbsp;태</TH>
	                        <TD><c:out value="${result.bizType}"/></TD>
	                        <TH style="text-align:center;">종&nbsp;&nbsp;&nbsp;목</TH>
	                        <TD><c:out value="${result.bizCat}"/></TD>
	                    </TR>
	                    <TR>
	                        <TH style="text-align:center;">거래처구분</TH>
	                        <TD><c:out value="${result.custClass}"/></TD>
	                        <TH style="text-align:center;">소재지</TH>
	                        <TD colspan="3"><c:out value="${result.addr}"/></TD>
	                    </TR>
	                    <TR>
	                        <TH style="text-align:center;">변경사유</TH>
	                        <TD colspan="5"><c:out value="${result.requestReason}"/></TD>
	                    </TR>
	                </TBODY>
	            </TABLE>
	        </DIV>
		</c:forEach>
        <DIV class=clear></DIV>
        <DIV class=clear></DIV>
    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>
