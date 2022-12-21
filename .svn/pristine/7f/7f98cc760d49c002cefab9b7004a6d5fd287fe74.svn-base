package com.hwfs.sc.cmn.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import hone.core.util.record.RecordSet;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.util.FtpUtil;
import com.hwfs.sc.cmn.dao.SendCreditInfoDAO;
import com.hwfs.sc.cmn.dto.EmailDTO;

/**
 * MakeExcelFileServiceImpl에 대한 설명 작성
 * 
 * @ClassName MakeExcelFileServiceImpl.java
 * @Description MakeExcelFileServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 12. 2.   901X5L        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 901X5L
 * @since 2016. 12. 2.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/makeCreditExcelFileService")
public class MakeCreditExcelFileServiceImpl extends DefaultServiceImpl
		implements MakeCreditExcelFileService {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** SendCreditInfoDAO Bean 생성 */
	@Resource(name = "/sc/cmn/sendCreditInfoDAO")
	private SendCreditInfoDAO sendCreditInfoDAO;

	/** EmailSendService Bean 생성 */
	@Resource(name = "/sc/cmn/emailSendService")
	private EmailSendService emailSendService;

	public int makeCreditExcelFile() throws Exception {

		Map<String, Object> parameter1 = new HashMap<String, Object>();
		Map<String, Object> parameter2 = new HashMap<String, Object>();

		// Workbook 생성
		Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전 (파일 생성 성능 고려)
		// Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

		// Sheet 생성
		Sheet sheet1 = xlsWb.createSheet("여신잔액조회");

		// 컬럼 너비 설정
		sheet1.setColumnWidth(0, 3000);		// 담당자
		sheet1.setColumnWidth(1, 3000);		// 업장코드
		sheet1.setColumnWidth(2, 10000);	// 업장명
		for (int z = 3; z <= 13; z++) {
			if ( z == 4 ) {
				sheet1.setColumnWidth(z, 4000);	// 임시여신한도초과액
			} else {
				sheet1.setColumnWidth(z, 3800);
			}
		}
		sheet1.setColumnWidth(14, 4000);	// 통제구분
		sheet1.setColumnWidth(15, 10000);	// 통제기간
		CellStyle cellStyleHeader = xlsWb.createCellStyle();
		cellStyleHeader.setWrapText(true);

		// Cell 색깔, 무늬 채우기(header)
		cellStyleHeader.setFillForegroundColor(IndexedColors.DARK_TEAL.index);
		cellStyleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);
		cellStyleHeader.setBorderBottom(CellStyle.BORDER_THIN);
		cellStyleHeader.setAlignment(CellStyle.ALIGN_CENTER); // 가운데 정렬
		cellStyleHeader.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		Font font = xlsWb.createFont();
		font.setBoldweight(Font.BOLDWEIGHT_BOLD); // 글씨 bold
		font.setColor(HSSFColor.WHITE.index);
		cellStyleHeader.setFont(font);

		// Cell 색깔, 무늬 채우기(body)
		CellStyle cellStyleBody = xlsWb.createCellStyle();
		cellStyleBody.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		cellStyleBody.setFillPattern(CellStyle.SOLID_FOREGROUND);
		cellStyleBody.setIndention((short)2);
		
		// Cell 색깔, 무늬 채우기(body)
		CellStyle cellStyleBody2 = xlsWb.createCellStyle();
		cellStyleBody2.setIndention((short)2);
				
		
		// 숫자 콤마처리
		CellStyle cellStyleNumber1 = xlsWb.createCellStyle();
		DataFormat format1 = xlsWb.createDataFormat();
		cellStyleNumber1.setDataFormat(format1.getFormat(("#,##0")));
		
		CellStyle cellStyleNumber2 = xlsWb.createCellStyle();
		DataFormat format2 = xlsWb.createDataFormat();
		cellStyleNumber2.setDataFormat(format2.getFormat(("#,##0")));
		cellStyleNumber2.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		cellStyleNumber2.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		Row rowHead = null;
		rowHead = sheet1.createRow(0);

		RecordSet rs = sendCreditInfoDAO.selectCreditInfo(parameter1);

		for (int h = 0; h < rs.getColumnCount(); h++) {
			Cell cell = rowHead.createCell(h);
			cell.setCellStyle(cellStyleHeader);
			cell.setCellValue(rs.getMetadata().getKey(h).toString());
		}

		rowHead.setHeight((short) 450);

		if (rs.size() > 0) {
			for (int i = 0; i < rs.size(); i++) {
				HSSFRow rowHssfRow = (HSSFRow) sheet1.createRow(i + 1);
				rowHssfRow.setHeight((short) 350);
				for (int colIndex = 0; colIndex < rs.getColumnCount(); colIndex++) {
					Object value = rs.getValue(i, colIndex);
					final HSSFCell cell = rowHssfRow.createCell(colIndex);
					if ( i%2 == 0 ) {
						cell.setCellStyle(cellStyleBody);
					} else {
						cell.setCellStyle(cellStyleBody2);
					}
					
					if (value == null) {
						cell.setCellValue("");
					} else {
						if (value instanceof Calendar) {
							cell.setCellValue((Calendar) value);
						} else if (value instanceof Date) {
							cell.setCellValue((Date) value);
						} else if (value instanceof String) {
							cell.setCellValue((String) value);
						} else if (value instanceof Boolean) {
							cell.setCellValue((Boolean) value);
						} else if (value instanceof Double) {
							cell.setCellValue((Double) value);
						} else if (value instanceof BigDecimal) {
							if ( colIndex != 1 ) {	// 사업장코드
								if ( i%2 == 0 ) {
									cell.setCellStyle(cellStyleNumber2);
								} else {
									cell.setCellStyle(cellStyleNumber1);
								}
								
								cell.setCellValue(((BigDecimal) value).doubleValue());
							} else {
								cell.setCellValue(((BigDecimal) value).doubleValue());
							}
						}
					}
				}
			}

			sheet1.createFreezePane(0, 1);
		} else {
			throw new BizException("영업사원 발송용 여신잔액 조회 내용이 없습니다.");
		}

		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd_HHmmss");
		String fileName = "여신잔액조회_" + formatter.format(new java.util.Date());
		
		String mode = super.propertiesService.getString("run.mode");
		String sourceFile = "";
		
		if ( "localhost".equals(mode) ) {
			sourceFile = "C:\\HWFS_DEV\\workspace\\" + fileName;
		} else {
			sourceFile = propertiesService.getString("global.filerepository.path") + "/cmn/credit/" + fileName;
		}
		
		try {
			File xlsFile = new File(sourceFile + ".xls");
			FileOutputStream fileOut = new FileOutputStream(xlsFile);
			xlsWb.write(fileOut);
			fileOut.flush();
			fileOut.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (Exception e) {
			logger.error("************makeExcelFile Exception : ", e);
		}

		//업로드 파일 리스트를 만든다.
		List<String> putList = new ArrayList<String>();
		putList.add(sourceFile+".xls");
		
		try {
			//파일을 업로드 한다.
			int putCnt =FtpUtil.putList(propertiesService.getString("ems.ftp.hostName"),
										propertiesService.getInt("ems.ftp.port"), 
										propertiesService.getString("ems.ftp.userName"),
										propertiesService.getString("ems.ftp.userPwd"),
										putList, 
										propertiesService.getString("ems.ftp.email.homeDir")+ "/hwfs/cmn");
		} catch ( Exception e) {
			logger.error("################### FTP ERROR ###################", e);
			e.printStackTrace();
		}
		
		// 메일 수신 영업사원 리스트
		RecordSet rs2 = sendCreditInfoDAO.selectPartSalesList(parameter2);
				
		SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		SimpleDateFormat formatter3 = new SimpleDateFormat("yyyy년 MM월 dd일 E요일 HH시 mm분 기준", Locale.KOREAN);
		String today = formatter2.format(new java.util.Date());
		String timestemp = formatter3.format(new java.util.Date());
		
		String buffer = "<html><head><meta name=\"viewport\"content=\"width=device-width,initial-scale=1\"/><style type=\"text/css\">@import url(http://fonts.googleapis.com/css?family=Droid+Sans);img{max-width:600px;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic}a{text-decoration:none;border:0;outline:none;color:#bbbbbb}td,h1,h2,h3{font-family:Helvetica,Arial,sans-serif;font-weight:400}td{text-align:center}body{-webkit-font-smoothing:antialiased;-webkit-text-size-adjust:none;width:100%;height:100%;color:#37302d;background:#ffffff;font-size:16px}table{border-collapse:collapse!important}.headline{color:#ffffff;font-size:30px}.force-full-width{width:100%!important}.force-width-80{width:80%!important}</style></head><body class=\"body\"style=\"padding:0;margin:0;display:block;background:#ffffff;-webkit-text-size-adjust:none\"bgcolor=\"#ffffff\"><table align=\"center\"cellpadding=\"0\"cellspacing=\"0\"class=\"force-full-width\"height=\"100%\"><tr><td align=\"center\"valign=\"top\"bgcolor=\"#ffffff\"width=\"100%\"><center><table style=\"margin:0 auto;\"cellpadding=\"0\"cellspacing=\"0\"width=\"600\"class=\"w320\"><tr><td align=\"center\"valign=\"top\"><br><br><br><table style=\"margin:0 auto;\"cellpadding=\"0\"cellspacing=\"0\"class=\"force-full-width\"bgcolor=\"#4dbfbf\"><tr><td><br><img src=\"https://www.filepicker.io/api/file/carctJpuT0exMaN8WUYQ\"width=\"240\"height=\"240\"></td></tr><tr><td class=\"headline\">여신잔액조회 메일이 도착했습니다.</td></tr><tr><td><center><table style=\"margin:0 auto;\"cellpadding=\"0\"cellspacing=\"0\"width=\"80%\"><tr><td style=\"color:#187272;\"><br>" + timestemp + "<br><p align=\"left\"><font size=2>- 업장별 최근 <u>일주일 발주금액의 평균금액</u>이 잔여여신금액 보다 적은 업장리스트<br>- 상기 조건에 부합하는 업장이 존재할 경우만 메일 발송</u></font><br><br></td></tr></table></center></td></tr></table></td></tr></table></center></td></tr></table></body></html>";

		List<EmailDTO> emailList = new ArrayList<EmailDTO>();
		
		/**
		for (int j = 0; j < rs2.size(); j++) {
			EmailDTO emailDTO = new EmailDTO();
			emailDTO.setToEmail(rs2.get(j).get("mail").toString());
			emailDTO.setToName(rs2.get(j).get("nmKor").toString());
			emailDTO.setSubject("[" + today + "] 여신잔액 조회");
			emailDTO.setMapContent(buffer);
			emailDTO.setFromEmail(propertiesService.getString("return@hanwha.com");
			emailDTO.setFromName(propertiesService.getString("한화푸디스트");
			emailDTO.setAttach1(propertiesService.getString("ems.ftp.rootDir")
				 + propertiesService.getString("ems.ftp.email.homeDir")+ "/hwfs/cmn/" +fileName+ ".xls");
			emailDTO.setAttachNm1(fileName + ".xls");
			emailList.add(emailDTO);
		}
		**/
		
		//String[] mail = {"kihoon.yang@hanwha.com", "lionfrnd@hanwha.com", "sunnykjh@hanwha.com"};
		//String[] name = {"양기훈", "박용대", "김진희"};
		
		String[] mail = {"kihoon.yang@hanwha.com"};
		String[] name = {"양기훈"};
		
			for ( int j=0; j<mail.length; j++ ) {
				// FOR TEST		
				EmailDTO emailDTO = new EmailDTO();
				emailDTO.setToEmail(mail[j]);
				emailDTO.setToName(name[j]);
				emailDTO.setSubject("[" + today + "] 여신잔액 조회");
				
				emailDTO.setMapContent(buffer);
				emailDTO.setFromEmail("return@hanwha.com");
				emailDTO.setFromName("한화푸디스트");
				emailDTO.setAttach1(
						propertiesService.getString("ems.ftp.rootDir")
						 + propertiesService.getString("ems.ftp.email.homeDir")+ "/hwfs/cmn/" +fileName+ ".xls");
				emailDTO.setAttachNm1(fileName + ".xls");
				emailList.add(emailDTO);
		}		
		
		//logger.info(propertiesService.getString("ems.ftp.rootDir") + propertiesService.getString("ems.ftp.email.homeDir")+ "/hwfs/cmn/" +fileName+ ".xls");
		
		int processCnt = emailSendService.saveEmail(emailList);

		return processCnt;
	}
	
}
