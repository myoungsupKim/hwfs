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
   *  2019.02.10.   김호석        최초 생성
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
                , com.hwfs.cmn.service.PropertiesService
    			, hone.core.util.record.*
    			, com.hwfs.ls.cmn.util.LimsUtil"%>
<%
    ServletContext sc = pageContext.getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

    //propertiesService Bean을 얻는다.
    PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");
    
    String muNm 	= LimsUtil.checkNull(request.getAttribute("muNm"));
    String ccNm     = LimsUtil.checkNull(request.getAttribute("ccNm"));
    String tDate    = LimsUtil.checkNull(request.getAttribute("tDate"));
    String advGubun    = LimsUtil.checkNull(request.getAttribute("advGubun"));		
    String transType    = LimsUtil.checkNull(request.getAttribute("transType"));		
    String amt     = LimsUtil.checkNull(request.getAttribute("amt"));
    String fromCust = LimsUtil.checkNull(request.getAttribute("fromCust"));
    String toCust = LimsUtil.checkNull(request.getAttribute("toCust"));   
    String fromCc = LimsUtil.checkNull(request.getAttribute("fromCc"));   
    String toCc   = LimsUtil.checkNull(request.getAttribute("toCc"));		
    String remark    = LimsUtil.checkNull(request.getAttribute("remark"));		
    String gwDraftSendUser    = LimsUtil.checkNull(request.getAttribute("gwDraftSendUser"));	
    String sabun    = LimsUtil.checkNull(request.getAttribute("sabun"));	
    String gwDraftTitle    = LimsUtil.checkNull(request.getAttribute("gwDraftTitle"));	
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
            <H2>품 의</H2>
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
                        <TD><%=gwDraftTitle %></TD>
                    </TR>
                    <TR>
                        <TH style="text-align:center;">기&nbsp;안&nbsp;자</TH>
                        <TD><%=gwDraftSendUser %></TD>
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
        선수금 이관을 아래와 같이 요청드리오니 처리하여 주시기 바랍니다.<br>
        </DIV>
        <br>
        <DIV style="TEXT-ALIGN:center;">
        -&nbsp;&nbsp;아&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;래&nbsp;&nbsp;-
        </DIV>
        <br>
        <DIV class=clear></DIV>
		 <DIV><B>※ 선수금 이관 ※</B></DIV>
        
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
	                <!-- 
	                  	//사업부, 발생CC, 회계일자, 선수금유형, 대체유형
						//대체금액, From고객사, To고객사
						//적요
					--> 
	                <TBODY id=tbdArea>
	                    
	                    <TR>
	                        <TH style="text-align:center;">사업부</TH>
	                        <TD><%=muNm %> </TD>
	                        <TH style="text-align:center;">발생CC</TH>
	                        <TD><%=ccNm %> </TD>
	                        <TH style="text-align:center;">이&nbsp;관&nbsp;일&nbsp;자</TH>
	                        <TD><%=tDate %> </TD>
	                    </TR>
	                    <TR>
	                        <TH style="text-align:center;">선수금&nbsp;유형</TH>
	                        <TD><%=advGubun %> </TD>
	                        <TH style="text-align:center;">이&nbsp;관&nbsp;유&nbsp;형</TH>
	                        <TD><%=transType %> </TD>
	                        <TH style="text-align:center;">이&nbsp;관&nbsp;금&nbsp;액</TH>
	                        <TD><%=amt %>원 </TD>
	                    </TR>
	                    <%
						
                		if(transType.equals("고객사이관"))
                		{
                   		 %>
	                    <TR>
	                        <TH style="text-align:center;">From&nbsp;거래처</TH>
	                        <TD colspan="5"><%=fromCust %></TD>
	                    </TR>
	                    <TR>
	                        <TH style="text-align:center;">To&nbsp;거래처</TH>
	                        <TD colspan="5"><%=toCust %> </TD>
	                    </TR>
	                    <%
                		} else {
	                    %>
	                    <TR>
	                        <TH style="text-align:center;">From&nbsp;CC</TH>
	                        <TD colspan="5"><%=fromCc %></TD>
	                    </TR>
	                    <TR>
	                        <TH style="text-align:center;">To&nbsp;CC</TH>
	                        <TD colspan="5"><%=toCc %> </TD>
	                    </TR>
	                    
	                    <%
                		}
	                    %>
	                    <TR>
	                        <TH style="text-align:center;">적요</TH>
	                        <TD colspan="5"><%=remark %> </TD>
	                    </TR>
	                </TBODY>
	            </TABLE>
	        </DIV>
	        <DIV><B>※ 선수금이관 원안품의 첨부 필수!! (미 첨부시 처리불가)</B></DIV>
	        
		<!-- 
		<DIV><B>※ 결재라인<BR>
		- 2백만원 이하(팀장/일반결재-사업기획팀장/협조결재-회계팀/협조결재)<BR>
        - 2백만원 초과(팀장/일반결재-본부장/일반결재-사업기획팀장/협조결재-사업부장/일반결재-회계팀/협조결재)<BR>
        </B></DIV>
         -->         
        <DIV class=clear></DIV>
        <DIV class=clear></DIV>
    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>
