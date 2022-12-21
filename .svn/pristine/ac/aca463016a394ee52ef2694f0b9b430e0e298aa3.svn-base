package com.hwfs.ls.cmn.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

/**
* 회사명과 직인을 출력한다.
* html에서 고정적인 위치에 Footer출력이 불가하여 별도 구현
*
* @ClassName PdfPageEvent.java
* @Description PdfPageEvent Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015. 5. 12.   jshoon        최초생성
* </pre>
* @author FC종합전산구축 : LIMS jshoon
* @since 2015. 5. 12.
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public class PdfPageEvent extends PdfPageEventHelper {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    BaseFont objBaseFont = null;
    Image imagex = null;
    Font objFont = null; // 출력일자
    Font objFont1 = null; // 회사명

    String prnDate = "";
    String prnCompany = "";
    String fontPath = "";
    String imgPath = "";
    int pagenumber = 0;

     /**
     * PdfPageEvent 생성자
     *
     * @param realPath
     * @param prnDate
     * @param prnCompany
     * @throws Exception
     */
    public PdfPageEvent(String realPath, String prnDate, String prnCompany) throws Exception {
        this.fontPath = realPath + "malgun.ttf";
        this.imgPath = realPath + "hanwha.png";
        this.prnDate = prnDate;
        this.prnCompany = prnCompany;

        objBaseFont = BaseFont.createFont(this.fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        objFont = new Font(objBaseFont, 12); // 출력년월
        objFont1 = new Font(objBaseFont, 20); // 회사명

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
     * @see com.itextpdf.text.pdf.PdfPageEventHelper#onChapter(com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document, float, com.itextpdf.text.Paragraph)
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
     * @see com.itextpdf.text.pdf.PdfPageEventHelper#onStartPage(com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
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
     * @see com.itextpdf.text.pdf.PdfPageEventHelper#onEndPage(com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
    */
    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        int pageNumber = writer.getPageNumber();

        // 마지막 페이지에 회사명과 직인을 찍는다.
        if (pagenumber == pageNumber) {
            // 출력일자
            ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Paragraph(this.prnDate, objFont),
                    document.left() + 280, document.bottom() + 80, 0);

            // 회사명
            ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Paragraph(this.prnCompany, objFont1),
                    document.left() + 250, document.bottom() + 37, 0);

            // 회사직인출력
            imagex.setAbsolutePosition(document.left() + 400, document.bottom() + 10);
            imagex.scaleToFit(77, 73);
            try {
                document.add(imagex);
            } catch (DocumentException e) {
                logger.error("PdfPageEvent onEndPage Image Error!", e);
            }
        }
    }

}
