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

        strContent = strContent.replace("{??????????????????}", "??? ??? ??? ??? ???");
        strContent = strContent.replace("{????????????}", "???????????????????????????(???)??????????????????<br />????????? ????????? ????????? ???????????? 23<br />TEL: 031-650-3430/FAX: 031-650-3437");

        strContent = strContent.replace("{????????????}", "I-150511007001");
        strContent = strContent.replace("{?????????}", "????????????");
        strContent = strContent.replace("{????????????}", "A-150511007001");
        strContent = strContent.replace("{????????????}", "??????(?????????)");
        strContent = strContent.replace("{????????????}", "2015. 08. 28");
        strContent = strContent.replace("{????????????}", "??????????????????");
        strContent = strContent.replace("{???????????????}", "2015. 09. 05");
        strContent = strContent.replace("{???????????????}", "???????????????????????????(???) ????????? ?????????");
        strContent = strContent.replace("{????????????}", "2015. 08. 21");
        strContent = strContent.replace("{??????????????????}", "02) 8888-9999");
        strContent = strContent.replace("{????????????}", "?????????");
        strContent = strContent.replace("{????????????}", "2015. 09. 06");
        strContent = strContent.replace("{????????????}", "?????????");
        strContent = strContent.replace("{{?????????}}", "<td style=\"height:20px;font-size:10pt;text-align:left;\">?????????</td>");
        strContent = strContent.replace("{????????????}", "2015??? 09 ??? 16 ???");

        strContent = strContent.replace("{???????????????}", "?????????");
        strContent = strContent.replace("{????????????}", "??????");
        strContent = strContent.replace("{???????????????}", "?????? ???????????? ???????????? ??????????????? 11???");

        StringBuffer testResult = new StringBuffer();
        testResult.append("<tr>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>???????????????????????????????????? (CFU/g)</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>n=5, c=2, m=100,000, M=500,0,000</span></p>");
        testResult.append("</td>");
        //testResult.append("<td width=42 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>????????????</span></p>");
        //testResult.append("</td>");
        testResult.append("<td width=150 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>??????</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=60 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>??????</span></p>");
        testResult.append("</td>");
        testResult.append("</tr>");

        testResult.append("<tr>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>??????????????????</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>?????????????????? ????????????.</span></p>");
        testResult.append("</td>");
        //testResult.append("<td width=42 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>????????????</span></p>");
        //testResult.append("</td>");
        testResult.append("<td width=150 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>?????????</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=60 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>??????</span></p>");
        testResult.append("</td>");
        testResult.append("</tr>");

        testResult.append("<tr>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>?????????(g/kg)</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>?????????????????? ????????????.</span></p>");
        testResult.append("</td>");
        //testResult.append("<td width=42 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>????????????</span></p>");
        //testResult.append("</td>");
        testResult.append("<td width=150 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>?????????</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=60 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>??????</span></p>");
        testResult.append("</td>");
        testResult.append("</tr>");

        testResult.append("<tr>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>?????????</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>n=5, c=2, m=100,000, M=500,000</span></p>");
        testResult.append("</td>");
        //testResult.append("<td width=42 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>????????????</span></p>");
        //testResult.append("</td>");
        testResult.append("<td width=150 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>325,285,100,190,275</span></p>");
        testResult.append("</td>");
        testResult.append("<td width=60 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>?????????</span></p>");
        testResult.append("</td>");
        testResult.append("</tr>");
        strContent = strContent.replace("{{????????????}}", testResult.toString());

        //int marginVal = 430 - (4 * 30);
        //int marginVal = 0;
        //strContent = strContent.replace("{marginValue}", "padding-top:"+marginVal+"px;");

        String inspectTxt = "";
        inspectTxt = "1. ?????? ????????? ????????? ?????????????????? ????????????.<br/>2. ??? ???????????? ????????? ?????? ?????? ???????????? ??????, ??????, ??????, ????????? ????????? ????????? ??? ????????? ?????? ?????? ????????? ????????????.<br/>3. ?????? ?????? ??? ?????? ?????? ???????????? ??????????????? ?????? ????????? ????????????.<br/>";
        strContent = strContent.replace("{???????????????}", inspectTxt.replaceAll("\\\r\n", "<br/>"));

        StringBuffer testUser = new StringBuffer();
        testUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\">?????????</td>");
        testUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\">&nbsp;&nbsp;</td>");
        testUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\">?????????</td>");
        testUser.append("<td style=\"height:20px;font-size:10pt;text-align:left;\">&nbsp;&nbsp;</td>");
        strContent = strContent.replace("{{?????????}}", testUser.toString());

        Document document = null;
        PdfWriter writer = null;
        FileInputStream fiCss = null;
        try {
            fiCss = new FileInputStream(strCss);
            document = new Document(PageSize.A4, 20, 20, 50, 20); // ?????? ??? ?????? ??????
            writer = PdfWriter.getInstance(document, new FileOutputStream(file)); // ?????? ????????????.
            writer.setInitialLeading(12.5f);

            // html?????? ???????????? ????????? Footer????????? ???????????? ????????? ????????????.
            // ????????? ??????????????? ?????????, ????????? ????????????.
            PdfPageEvent event = new PdfPageEvent(realpath,
                                                  LimsUtil.getDate("yyyy??? MM??? dd???"),
                                                  "?????????????????????????????? ??????????????????");
            writer.setPageEvent(event);

            // Document ??????
            document.open();
            XMLWorkerHelper helper = XMLWorkerHelper.getInstance();

            // CSS
            CSSResolver cssResolver = new StyleAttrCSSResolver();
            CssFile cssFile = helper.getCSS(fiCss);
            cssResolver.addCss(cssFile);

            // HTML, ?????? ??????
            XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
            fontProvider.register(realpath + "malgun.ttf", "MalgunGothic"); // MalgunGothic??? alias,
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
