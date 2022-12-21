package com.hwfs.ls.cmn.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

 /**
 * 시험성적서를 PDF파일로 생성한다.
 *
 * @ClassName CreateInspectIssuePdf.java
 * @Description CreateInspectIssuePdf Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 17.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 17.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CreateInspectIssuePdf {

    private static Logger logger = LoggerFactory.getLogger (CreateInspectIssuePdf.class);

    @SuppressWarnings({ "unchecked", "static-access" })
    public static void createPdf(Map<String, Object> paramMap) throws Exception {

        StringBuilder strBuilder = new StringBuilder();

        FileInputStream fis = null;
        BufferedReader br = null;
        String line;
        try {
            fis = new FileInputStream(LimsUtil.checkNull(paramMap.get("htmlFile")));
            br = new BufferedReader(new InputStreamReader(fis, "UTF-8"));

            while ((line = br.readLine()) != null) {
                strBuilder.append(line);
            }
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                    fis = null;
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
            if (br != null) {
                try {
                    br.close();
                    br = null;
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
        }

        // HFC_BS_AD_150120 회의록 참조
        // 3. 성적서 출럭 시 자가품질검사는 성적서의 판정항목에 적.부 여부를 표시하지 않고 최종판정항목에는 “위와 같음”으로 표시 한다.
        // 2015.04.30 김대현M : 품질관리가 위와같이 동작한다고 함. 2015.05.04 수정
        boolean isSelfTest = true;
        String publishNum = "";
        String insptRptNm = "";
        String strContent = strBuilder.toString();
        Map<String, Object> specmMap = (Map<String, Object>) paramMap.get("specmList");

        // 검사목적에 따른 타이틀 변경
        isSelfTest = ("101".equals(LimsUtil.checkNull(specmMap.get("insptPurp1")))?true:false);
        insptRptNm = LimsUtil.checkNull(specmMap.get("insptRptNm"));
        strContent = strContent.replace("{성적서타이틀}", insptRptNm);
        /*if (isSelfTest) {	// 101:자가품질검사, 102:품질관리
            strContent = strContent.replace("{성적서타이틀}", "시험성적서");
        } else {
            strContent = strContent.replace("{성적서타이틀}", "품질관리검사결과");
        }*/
        strContent = strContent.replace("{회사주소}", LimsUtil.checkNull(specmMap.get("insptRptCompanyaddr")).replaceAll("∮","<br />"));
        // 미발행/재발행 여부 표시
        if (LimsUtil.checkNull(specmMap.get("publishCnt"), 0) > 1) {
            publishNum = LimsUtil.checkNull(specmMap.get("publishNum")) + "(재발행)";
        } else if (LimsUtil.checkNull(specmMap.get("publishCnt"), 0) == 0) {
            publishNum = "(미발행)";
        } else {
            publishNum = LimsUtil.checkNull(specmMap.get("publishNum"));
        }

        strContent = strContent.replace("{발행번호}", publishNum);
        strContent = strContent.replace("{검체명}", LimsUtil.checkNull(specmMap.get("specmNm")));
        strContent = strContent.replace("{접수번호}", LimsUtil.checkNull(specmMap.get("acceptNum")));
        strContent = strContent.replace("{검체유형}", LimsUtil.checkNull(specmMap.get("sclassNm")));
        strContent = strContent.replace("{접수일자}", LimsUtil.formatDate(LimsUtil.checkNull(specmMap.get("acceptdd")), "yyyy. MM. dd"));
        strContent = strContent.replace("{검사목적}", LimsUtil.checkNull(specmMap.get("insptPurp1Nm")));
        strContent = strContent.replace("{시험완료일}", LimsUtil.formatDate(LimsUtil.checkNull(specmMap.get("completeDd")), "yyyy. MM. dd"));
        strContent = strContent.replace("{의뢰업체명}", LimsUtil.checkNull(specmMap.get("upjangNm")));
        strContent = strContent.replace("{제조일자}", LimsUtil.formatDate(LimsUtil.checkNull(specmMap.get("mfgdd")), "yyyy. MM. dd"));
        //strContent = strContent.replace("{의뢰인연락처}", LimsUtil.checkNull(specmMap.get("reqUserTelno")));
        strContent = strContent.replace("{의뢰자명}", LimsUtil.checkNull(specmMap.get("reqUserNm")));

        strContent = strContent.replace("{제조업체명}", LimsUtil.checkNull(specmMap.get("mfgwon")));
        strContent = strContent.replace("{제조국가}", LimsUtil.checkNull(specmMap.get("mfgNation")));
        //strContent = strContent.replace("{제조소재지}", LimsUtil.checkNull(specmMap.get("mfgLocation")));

        String strDtrlimtMts = "";
        String strDtrlimtDd = "";
        // 2015.09.11 최준열G 요청
//        if (!"".equals(LimsUtil.checkNull(specmMap.get("dtrlimtMts")))) {
//            strDtrlimtMts = " " + LimsUtil.checkNull(specmMap.get("dtrlimtMts")) + "개월";
//        }
//        if (!"".equals(LimsUtil.checkNull(specmMap.get("dtrlimtDd")))) {
//            strDtrlimtDd = " " + LimsUtil.checkNull(specmMap.get("dtrlimtDd")) + "일";
//        }
        strContent = strContent.replace("{유통기한}", LimsUtil.formatDate(LimsUtil.checkNull(specmMap.get("dtrlimt")), "yyyy. MM. dd") + strDtrlimtMts + strDtrlimtDd);

        String strinspectRptIssue = LimsUtil.checkNull(specmMap.get("inspectRptIssue"));
        
        StringBuffer testResult = new StringBuffer();
        RecordSet testResultList = (RecordSet) paramMap.get("testResultList");
/* 2018.06.04 김명섭 LIMS개선(판정일자추가) */
/*
        for (Record tr : testResultList) {
            testResult.append("<tr>");
            testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("articleNm"))+"</span></p>");
            testResult.append("</td>");
            testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("basisStand"))+"</span></p>");
            testResult.append("</td>");
            //testResult.append("<td width=42 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("insptClsfNm"))+"</span></p>");
            //testResult.append("</td>");
            testResult.append("<td width=150 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("result"))+"</span></p>");
            testResult.append("</td>");
            testResult.append("<td width=60 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+(isSelfTest?LimsUtil.checkNull(tr.get("lastDecisionNm")):"")+"</span></p>");
            testResult.append("</td>");
            testResult.append("</tr>");
        }
*/
        if ("S".equals(strinspectRptIssue)) {
	        for (Record tr : testResultList) {
	            testResult.append("<tr>");
	            testResult.append("<td width=320 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("articleNm"))+"</span></p>");
	            testResult.append("</td>");
	            testResult.append("<td width=240 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("basisStand"))+"</span></p>");
	            testResult.append("</td>");
	            testResult.append("<td width=90 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("result"))+"</span></p>");
	            testResult.append("</td>");
	            //2019.12.05 김중한 판정 항목 추가
	            testResult.append("<td width=90 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("lastDecisionNm"))+"</span></p>");
	            testResult.append("</td>");
	            testResult.append("<td width=100 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("judgdd"))+"</span></p>");
	            testResult.append("</td>");
	            testResult.append("</tr>");
	        }
        } else {
	        for (Record tr : testResultList) {
	            testResult.append("<tr>");
	            testResult.append("<td width=360 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("articleNm"))+"</span></p>");
	            testResult.append("</td>");
	            testResult.append("<td width=270 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("basisStand"))+"</span></p>");
	            testResult.append("</td>");
	            testResult.append("<td width=100 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("result"))+"</span></p>");
	            testResult.append("</td>");
	            testResult.append("<td width=100 style=\"height:20px;font-size:10pt;text-align:center;border-top:none;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("judgdd"))+"</span></p>");
	            testResult.append("</td>");
	            testResult.append("</tr>");
	        }        	
        }

        strContent = strContent.replace("{{실험결과}}", testResult.toString());
        strContent = strContent.replace("{최종판정}", (!isSelfTest?"위와 같음":LimsUtil.checkNull(testResultList.get(0).get("totLastDecisionNm"))));

        String inspectTxt = "";
        if (!testResultList.isEmpty()) {
            if ("".equals(LimsUtil.checkNull(testResultList.get(0).get("remark")))) {
                inspectTxt = "1. 상기 판정은 제시된 검사대상물에 한합니다.<br/>2. 이 성적서는 당사의 사전 서면 동의없이 통보, 선전, 홍보, 소송용 등으로 사용될 수 없으며 용도 이외 사용을 금합니다.<br/>3. 검사 항목 및 그에 따른 규격기준 검사방법은 당사 규정에 따릅니다.<br/>";
            } else {
                inspectTxt = LimsUtil.checkNull(testResultList.get(0).get("remark"));
            }
        } else {
            inspectTxt = "1. 상기 판정은 제시된 검사대상물에 한합니다.<br/>2. 이 성적서는 당사의 사전 서면 동의없이 통보, 선전, 홍보, 소송용 등으로 사용될 수 없으며 용도 이외 사용을 금합니다.<br/>3. 검사 항목 및 그에 따른 규격기준 검사방법은 당사 규정에 따릅니다.<br/>";
        }
        strContent = strContent.replace("{성적서비고}", inspectTxt.replaceAll("\\\r\n", "<br/>"));

logger.debug("##_createPdf linkPath:"+LimsUtil.checkNull(paramMap.get("linkPath")));
        String linkPath = LimsUtil.checkNull(paramMap.get("linkPath"));
        StringBuffer testUser = new StringBuffer();
        RecordSet testUserList = (RecordSet) paramMap.get("testUserList");
        for (Record tu : testUserList) {
            testUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\">"+LimsUtil.checkNull(tu.get("userNm"))+"</td>");
            testUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\"><img src=\""+linkPath+LimsUtil.checkNull(tu.get("svrFilenm"))+"\" width=\"30\" height=\"30\" />&nbsp;&nbsp;</td>");
        }
        strContent = strContent.replace("{{담당자}}", testUser.toString());

        StringBuffer testTechUser = new StringBuffer();
        RecordSet testTechUserList = (RecordSet) paramMap.get("testTechUserList");
        for (Record tu : testTechUserList) {
            testTechUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\">"+LimsUtil.checkNull(tu.get("userNm"))+"</td>");
            testTechUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\"><img src=\""+linkPath+LimsUtil.checkNull(tu.get("svrFilenm"))+"\" width=\"30\" height=\"30\" />&nbsp;&nbsp;</td>");
        }
        strContent = strContent.replace("{{책임자}}", testTechUser.toString());

        //****************************************************
        // 별도의 PdfPageEvent Class를 구현하여 고정 좌표로 출력한다.
        //****************************************************
        /*int marginVal = 430 - (testResultList.size() * 40);
        //int marginVal = 20;
        strContent = strContent.replace("{marginValue}", "padding-top:"+marginVal+"px;");
        //strContent = strContent.replace("{marginValue}", "padding-top:300px;");
        strContent = strContent.replace("{작성일자}", LimsUtil.getDate("yyyy년 MM월 dd일"));
        strContent = strContent.replace("{성적서출력회사명}", LimsUtil.checkNull(specmMap.get("insptRptCompany")));

        // 2015.04.30 한화 직인 추가
        String linkPathHanwha = LimsUtil.checkNull(paramMap.get("linkPathHanwha"));
        strContent = strContent.replace("{한화직인}", linkPathHanwha + "hanwha.jpg");*/


        //****************************************************
        // itext lib 사용해서 PDF 생성
        //****************************************************

        Document document = null;
        PdfWriter writer = null;
        FileInputStream fiCss = null;
        try {
logger.debug("##_initialize");
            fiCss = new FileInputStream(LimsUtil.checkNull(paramMap.get("strCss")));
            //document = new Document(PageSize.A4, 20, 20, 50, 20); // 용지 및 여백 설정
            document = new Document(PageSize.A4, 20, 20, 20, 20); // 용지 및 여백 설정
            writer = PdfWriter.getInstance(document, new FileOutputStream(LimsUtil.checkNull(paramMap.get("createFile")))); // 바로 다운로드.
            writer.setInitialLeading(12.5f);

            // html에서 고정적인 위치에 Footer출력이 불가하여 별도로 구현한다.
            // 좌표로 출력일자와 회사명, 직인을 출력한다.
            PdfPageEvent event = new PdfPageEvent(LimsUtil.checkNull(paramMap.get("realpath")),
                                                  LimsUtil.getDate("yyyy년 MM월 dd일"),
                                                  LimsUtil.checkNull(specmMap.get("insptRptCompany")));
            writer.setPageEvent(event);

            // Document 오픈
            document.open();
            XMLWorkerHelper helper = XMLWorkerHelper.getInstance();

            // CSS
            CSSResolver cssResolver = new StyleAttrCSSResolver();
            CssFile cssFile = helper.getCSS(fiCss);
            cssResolver.addCss(cssFile);

            // HTML, 폰트 설정
logger.debug("##_start fontSetting");
            XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
            fontProvider.register(LimsUtil.checkNull(paramMap.get("realpath")) + "malgun.ttf", "MalgunGothic"); // MalgunGothic은 alias,
            CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);

            HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
            htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

            // Pipelines
            PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
            HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
            CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);

            XMLWorker worker = new XMLWorker(css, true);
            XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));

            StringReader strReader = new StringReader(strContent);
logger.debug("##_strContent="+strContent);
logger.debug("##_start xmlParser");
            xmlParser.parse(strReader);
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            if (fiCss != null) {
                try {
                    fiCss.close();
                    fiCss = null;
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
            if (document != null) {
                try {
logger.debug("##_start document.close");                	
                    document.close();
                    document = null;
logger.debug("##_end document.close");
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
            if (writer != null) {
                try {
logger.debug("##_start writer.flush");                	
                	writer.flush();
                    writer.close();
                    writer = null;
logger.debug("##_end writer.flush");
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
        }
    }

}
