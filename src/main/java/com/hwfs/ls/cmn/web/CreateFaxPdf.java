package com.hwfs.ls.cmn.web;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.util.List;
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

public class CreateFaxPdf {

    private static Logger logger = LoggerFactory.getLogger (CreateFaxPdf.class);

    /**
     * 출고증 fax 출력
     *
     * @param paramMap
     * @throws Exception
     */
    @SuppressWarnings({ "static-access", "unchecked" })
    public static void createFaxPdf(Map<String, Object> paramMap) throws Exception {
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

        String strContent = strBuilder.toString();

        String transTitle = (LimsUtil.checkNull(paramMap.get("transTitle")).equals("1")?"출 고 요 청 서":"이 체 요 청 서");
        strContent = strContent.replace("{출고관리번호}", LimsUtil.checkNull(paramMap.get("releaseNum")));
        strContent = strContent.replace("{출고요청서}", transTitle);
        strContent = strContent.replace("{수신}", LimsUtil.checkNull(paramMap.get("vdNmLoc")) + " (FAX : " + LimsUtil.phoneFormat(LimsUtil.checkNull(paramMap.get("faxNo"))) + ")");
        strContent = strContent.replace("{참조}", LimsUtil.checkNull(paramMap.get("chamJo")));
        strContent = strContent.replace("{발신}", LimsUtil.checkNull(paramMap.get("sendInfo")));
        strContent = strContent.replace("{출고일자}", LimsUtil.checkNull(paramMap.get("releaseDate")));
        strContent = strContent.replace("{출고처}", LimsUtil.checkNull(paramMap.get("custNm")));

        double totBeforeInventory = 0;
        double totReleaseQuantity = 0;
        double totCurrInventory = 0;
        StringBuffer result = new StringBuffer();
        List<Map<String, Object>> resultList = (List<Map<String, Object>>) paramMap.get("releaseList");
        int rsCnt = 1;
        for (Map<String, Object> tr : resultList) {
            result.append("<tr>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+(rsCnt++)+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("itemCd"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("itemNm"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(LimsUtil.checkNull(tr.get("realWgt"), 0.00), "###,##0.00")+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("unit"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(LimsUtil.checkNull(tr.get("beforeInventory"), 0.00), "###,##0.##")+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(LimsUtil.checkNull(tr.get("releaseQuantity"), 0.00), "###,##0.##")+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(LimsUtil.checkNull(tr.get("currInventory"), 0.00), "###,##0.##")+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("currentWhDeliverDate"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("firstDeliverDate"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("estNo"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("blNum"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("remark"))+"</span></p></td>");
            result.append("</tr>");

            totBeforeInventory += LimsUtil.checkNull(tr.get("beforeInventory"), 0.00);
            totReleaseQuantity += LimsUtil.checkNull(tr.get("releaseQuantity"), 0.00);
            totCurrInventory += LimsUtil.checkNull(tr.get("currInventory"), 0.00);
        }
        strContent = strContent.replace("{{출고내용}}", result.toString());

        result.setLength(0);
        result.append("<tr>");
        result.append("<td colspan=5 style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>합&nbsp;&nbsp;&nbsp;&nbsp;계</span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(totBeforeInventory, "###,##0.##")+"</span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(totReleaseQuantity, "###,##0.##")+"</span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(totCurrInventory, "###,##0.##")+"</span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("</tr>");
        strContent = strContent.replace("{{합계}}", result.toString());

        String linkPathHanwha = LimsUtil.checkNull(paramMap.get("linkPathHanwha"));
        //strContent = strContent.replace("{회사직인}", linkPathHanwha + "CompanyLogo.png");
        strContent = strContent.replace("{회사직인}", linkPathHanwha + LimsUtil.checkNull(paramMap.get("comLogo")));

        Document document = null;
        PdfWriter writer = null;
        FileInputStream fiCss = null;
        try {
            fiCss = new FileInputStream(LimsUtil.checkNull(paramMap.get("strCss")));
            document = new Document(PageSize.A4.rotate(), 20, 20, 50, 20); // 용지 및 여백 설정
            writer = PdfWriter.getInstance(document, new FileOutputStream(LimsUtil.checkNull(paramMap.get("createFile")))); // 바로 다운로드.
            writer.setInitialLeading(12.5f);

            // Document 오픈
            document.open();
            XMLWorkerHelper helper = XMLWorkerHelper.getInstance();

            // CSS
            CSSResolver cssResolver = new StyleAttrCSSResolver();
            CssFile cssFile = helper.getCSS(fiCss);
            cssResolver.addCss(cssFile);

            // HTML, 폰트 설정
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

    /**
     * 거래명세서 fax 출력
     *
     * @param paramMap
     * @throws Exception
     */
    @SuppressWarnings({ "static-access", "unchecked" })
    public static void dealReqDocPublishCreateFaxPdf(Map<String, Object> paramMap) throws Exception {
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

        String strContent = strBuilder.toString();

        Map<String, Object> resultCust = (Map<String, Object>) paramMap.get("custInfo");
        strContent = strContent.replace("{공급자사업자번호}", LimsUtil.checkNull(resultCust.get("cominfoA")));
        strContent = strContent.replace("{공급자상호}", LimsUtil.checkNull(resultCust.get("cominfoB")));
        strContent = strContent.replace("{공급자성명}", LimsUtil.checkNull(resultCust.get("cominfoC")));
        strContent = strContent.replace("{공급자주소}", LimsUtil.checkNull(resultCust.get("cominfoD")));
        strContent = strContent.replace("{사업자번호}", LimsUtil.checkNull(resultCust.get("saupno")));
        strContent = strContent.replace("{상호}", LimsUtil.checkNull(resultCust.get("salsplceNm")));
        strContent = strContent.replace("{성명}", LimsUtil.checkNull(resultCust.get("cPerName")));
        strContent = strContent.replace("{주소}", LimsUtil.checkNull(resultCust.get("addr")));

        double tot1 = 0;
        double tot2 = 0;
        double tot3 = 0;
        double tot4 = 0;
        double tot5 = 0;
        StringBuffer result = new StringBuffer();
        List<Map<String, Object>> resultList = (List<Map<String, Object>>) paramMap.get("releaseList");
        for (Map<String, Object> tr : resultList) {
            result.append("<tr>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("releaseDate"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("itemNm"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("originNat"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("itemSize"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("unit"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(LimsUtil.checkNull(tr.get("realWgt"), 0.00), "###,##0.00")+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(LimsUtil.checkNull(tr.get("releaseQuantity"), 0.00), "###,##0.##")+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(LimsUtil.checkNull(tr.get("saleUprice"), 0.00), "###,##0.##")+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(LimsUtil.checkNull(tr.get("saleAmt"), 0.00), "###,##0.##")+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(LimsUtil.checkNull(tr.get("seAmt"), 0.00), "###,##0.##")+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(LimsUtil.checkNull(tr.get("tot"), 0.00), "###,##0.##")+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("blNum"))+"</span></p></td>");
            result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("incomeDtrDsctNum"))+"</span></p></td>");
            result.append("</tr>");

            tot1 += LimsUtil.checkNull(tr.get("realWgt"), 0.00);
            tot2 += LimsUtil.checkNull(tr.get("releaseQuantity"), 0.00);
            tot3 += LimsUtil.checkNull(tr.get("saleAmt"), 0.00);
            tot4 += LimsUtil.checkNull(tr.get("seAmt"), 0.00);
            tot5 += LimsUtil.checkNull(tr.get("tot"), 0.00);
        }
        strContent = strContent.replace("{{거래명세서}}", result.toString());

        result.setLength(0);
        result.append("<tr>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>합&nbsp;&nbsp;&nbsp;&nbsp;계</span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(tot1, "###,##0.##")+"</span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(tot2, "###,##0.##")+"</span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(tot3, "###,##0.##")+"</span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(tot4, "###,##0.##")+"</span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.getCommaNumber(tot5, "###,##0.##")+"</span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("<td style=\"height:20px;font-size:9pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span></span></p></td>");
        result.append("</tr>");
        strContent = strContent.replace("{{합계}}", result.toString());
        strContent = strContent.replace("{가상계좌}", LimsUtil.checkNull(resultCust.get("bankAcctNo")));

        //String linkPathHanwha = LimsUtil.checkNull(paramMap.get("linkPathHanwha"));
        //strContent = strContent.replace("{회사직인}", linkPathHanwha + "CompanyJikin.png");

        Document document = null;
        PdfWriter writer = null;
        FileInputStream fiCss = null;
        try {
            fiCss = new FileInputStream(LimsUtil.checkNull(paramMap.get("strCss")));
            document = new Document(PageSize.A4.rotate(), 20, 20, 50, 20); // 용지 및 여백 설정
            writer = PdfWriter.getInstance(document, new FileOutputStream(LimsUtil.checkNull(paramMap.get("createFile")))); // 바로 다운로드.
            writer.setInitialLeading(12.5f);

            // html에서 고정적인 위치에 Footer출력이 불가하여 별도로 구현한다.
            // 좌표로 출력일자와 회사명, 직인을 출력한다.
            FaxPdfPageEvent event = new FaxPdfPageEvent(LimsUtil.checkNull(paramMap.get("realpath")),LimsUtil.checkNull(resultCust.get("comLogo")));
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

            //System.out.println(strContent);
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
