package com.hwfs.ls.cmn.web;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.cmn.util.PdfPageEvent;
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

public class CreatePdf {

    private static Logger logger = LoggerFactory.getLogger (CreatePdf.class);

    @SuppressWarnings({ "static-access" })
    public static void createPdf(Map<String, String> parameter) throws Exception {
        String repPath = LimsUtil.checkNull(parameter.get("realpath"));
        String realImgPath = LimsUtil.checkNull(parameter.get("realImgPath"));

        String file = realImgPath + "/ls/inspectrpt/sample.pdf";
        String strCss = repPath + "/ls/inspectrpt/inspectRpt.css";
        String htmlFile = repPath + "/ls/inspectrpt/InspectRptNew.html";
        String realpath = repPath + "/ls/inspectrpt/";
        StringBuilder strBuilder = new StringBuilder();

        FileInputStream fis = null;
        BufferedReader br = null;
        String line;
        try {
            fis = new FileInputStream(htmlFile);
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

        String strContent = strBuilder.toString();

        strContent = strContent.replace("{성적서타이틀}", "시 험 성 적 서");
        strContent = strContent.replace("{회사주소}", "한화호텔앤드리조트(주)식품연구센터<br />경기도 평택시 청북면 청북서로 23<br />TEL: 031-650-3430/FAX: 031-650-3437");

        strContent = strContent.replace("{발행번호}", "I-150511007001");
        strContent = strContent.replace("{검체명}", "포레누아");
        strContent = strContent.replace("{접수번호}", "A-150511007001");
        strContent = strContent.replace("{검체유형}", "빵류(케이크)");
        strContent = strContent.replace("{접수일자}", "2015. 08. 28");
        strContent = strContent.replace("{검사목적}", "자가품질검사");
        strContent = strContent.replace("{시험완료일}", "2015. 09. 05");
        strContent = strContent.replace("{의뢰업체명}", "한화호텔앤드리조트(주) 케로로 사업팀");
        strContent = strContent.replace("{제조일자}", "2015. 08. 21");
        strContent = strContent.replace("{의뢰인연락처}", "02) 8888-9999");
        strContent = strContent.replace("{의뢰자명}", "김형태");
        strContent = strContent.replace("{유통기한}", "2015. 09. 06");
        strContent = strContent.replace("{최종판정}", "부적합");
        strContent = strContent.replace("{{책임자}}", "<td style=\"height:20px;font-size:10pt;text-align:left;\">김희선</td>");
        strContent = strContent.replace("{작성일자}", "2015년 09 월 16 일");

        strContent = strContent.replace("{제조업체명}", "식약처");
        strContent = strContent.replace("{제조국가}", "한국");
        strContent = strContent.replace("{제조소재지}", "서울 영등포구 여의도동 국회의사당 11로");

        StringBuffer testResult = new StringBuffer();
        testResult.append("<tr>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>클로스트리디움퍼프린젠스 (CFU/g)</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>n=5, c=2, m=100,000, M=500,0,000</span></p>");
        testResult.append("</td>");
        //testResult.append("<td width=42 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>법적기준</span></p>");
        //testResult.append("</td>");
        testResult.append("<td width=150 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>적합</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=60 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>적합</span></p>");
        testResult.append("</td>");
        testResult.append("</tr>");

        testResult.append("<tr>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>식카린나트륨</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>검출되어서는 아니된다.</span></p>");
        testResult.append("</td>");
        //testResult.append("<td width=42 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>내부기준</span></p>");
        //testResult.append("</td>");
        testResult.append("<td width=150 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>불검출</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=60 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>적합</span></p>");
        testResult.append("</td>");
        testResult.append("</tr>");

        testResult.append("<tr>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>보존료(g/kg)</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>검출되어서는 아니된다.</span></p>");
        testResult.append("</td>");
        //testResult.append("<td width=42 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>법적기준</span></p>");
        //testResult.append("</td>");
        testResult.append("<td width=150 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>불검출</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=60 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>적합</span></p>");
        testResult.append("</td>");
        testResult.append("</tr>");

        testResult.append("<tr>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>세균수</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>n=5, c=2, m=100,000, M=500,000</span></p>");
        testResult.append("</td>");
        //testResult.append("<td width=42 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>내부기준</span></p>");
        //testResult.append("</td>");
        testResult.append("<td width=150 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>325,285,100,190,275</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=60 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>부적합</span></p>");
        testResult.append("</td>");
        testResult.append("</tr>");
        strContent = strContent.replace("{{실험결과}}", testResult.toString());

        //int marginVal = 430 - (4 * 30);
        //int marginVal = 0;
        //strContent = strContent.replace("{marginValue}", "padding-top:"+marginVal+"px;");

        String inspectTxt = "";
        inspectTxt = "1. 상기 판정은 제시된 검사대상물에 한합니다.<br/>2. 이 성적서는 당사의 사전 서면 동의없이 통보, 선전, 홍보, 소송용 등으로 사용될 수 없으며 용도 이외 사용을 금합니다.<br/>3. 검사 항목 및 그에 따른 규격기준 검사방법은 당사 규정에 따릅니다.<br/>";
        strContent = strContent.replace("{성적서비고}", inspectTxt.replaceAll("\\\r\n", "<br/>"));

        StringBuffer testUser = new StringBuffer();
        testUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\">김대현</td>");
        testUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\">&nbsp;&nbsp;</td>");
        testUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\">노정미</td>");
        testUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\">&nbsp;&nbsp;</td>");
        strContent = strContent.replace("{{담당자}}", testUser.toString());

        Document document = null;
        PdfWriter writer = null;
        FileInputStream fiCss = null;
        try {
            fiCss = new FileInputStream(strCss);
            document = new Document(PageSize.A4, 20, 20, 50, 20); // 용지 및 여백 설정
            writer = PdfWriter.getInstance(document, new FileOutputStream(file)); // 바로 다운로드.
            writer.setInitialLeading(12.5f);

            // html에서 고정적인 위치에 Footer출력이 불가하여 별도로 구현한다.
            // 좌표로 출력년월과 회사명, 직인을 출력한다.
            PdfPageEvent event = new PdfPageEvent(realpath,
                                                  LimsUtil.getDate("yyyy년 MM월 dd일"),
                                                  "한화호텔앤드리조트㈜ 식품연구센터");
            writer.setPageEvent(event);

            // Document 오픈
            document.open();
            XMLWorkerHelper helper = XMLWorkerHelper.getInstance();

            // CSS
            CSSResolver cssResolver = new StyleAttrCSSResolver();
            CssFile cssFile = helper.getCSS(fiCss);
            cssResolver.addCss(cssFile);

            // HTML, 폰트 설정
            XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
            fontProvider.register(realpath + "malgun.ttf", "MalgunGothic"); // MalgunGothic은 alias,
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
                    document.close();
                    document = null;
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
            if (writer != null) {
                try {
                    writer.close();
                    writer = null;
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
        }
    }

}
