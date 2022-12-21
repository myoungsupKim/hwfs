package com.hwfs.ls.cmn.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

/**
* Fax 직인을 출력한다.
* html에서 고정적인 위치에 Footer출력이 불가하여 별도 구현
*
* @ClassName FaxPdfPageEvent.java
* @Description FaxPdfPageEvent Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.10. 06.   jshoon        최초생성
* </pre>
* @author FC종합전산구축 : LIMS jshoon
* @since 2015.10. 06.
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public class FaxPdfPageEvent extends PdfPageEventHelper {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    BaseFont objBaseFont = null;
    Image imagex = null;

    String imgPath = "";
    int pagenumber = 0;

    /**
    * FaxPdfPageEvent 생성자
    *
    * @param realPath
    * @param prnDate
    * @param prnCompany
    * @throws Exception
    */
    public FaxPdfPageEvent(String realPath, String logoName) throws Exception {
        this.imgPath = realPath + logoName;

        // 회사직인 출력
        imagex = Image.getInstance(this.imgPath);
    }

    /**
     * onChapter : 문서 시작 작업
     *
     * @param writer
     * @param document
     * @param paragraphPosition
     * @param title
     * @see com.itextpdf.text.pdf.FaxPdfPageEventHelper#onChapter(com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document, float, com.itextpdf.text.Paragraph)
    */
    @Override
    public void onChapter(PdfWriter writer, Document document, float paragraphPosition, Paragraph title) {
        pagenumber = 1;
    }

    /**
     * onStartPage : 각 페이지 시작 작업
     *
     * @param writer
     * @param document
     * @see com.itextpdf.text.pdf.FaxPdfPageEventHelper#onStartPage(com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
    */
    @Override
    public void onStartPage(PdfWriter writer, Document document) {
        pagenumber++;
    }

    /**
     * onEndPage : 각 페이지 마지막 작업
     *
     * @param writer
     * @param document
     * @see com.itextpdf.text.pdf.FaxPdfPageEventHelper#onEndPage(com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
    */
    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        //int pageNumber = writer.getPageNumber();

        // 마지막 페이지에 회사명과 직인을 찍는다.
        if (pagenumber == 1) {
            // 회사직인출력
            imagex.setAbsolutePosition(document.left() + 280, document.bottom() + 405);
            imagex.scaleToFit(50, 50);
            try {
                document.add(imagex);
            } catch (DocumentException e) {
                logger.error("FaxPdfPageEvent onEndPage Image Error!", e);
            }
        }
    }

}
