package com.hwfs.sc.cmn.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.FileUtil;
import com.hwfs.sc.cmn.dto.CardReplyDTO;
import com.hwfs.sc.cmn.dao.CardItfcDAO;
import com.hwfs.sc.cmn.dto.CardApDataDTO;
import com.hwfs.sc.cmn.dto.CardHistDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.VanBrchMapnMgtService;
import com.hwfs.sc.cmn.util.DateUtil;
import com.hwfs.sc.cmn.util.SftpUtil;
import com.hwfs.sc.cmn.util.StringUtil;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.ChannelSftp.LsEntry;

 /**
 * 신용카드 정보를 인터페이스 하는 Service Implementation
 * 
 * @ClassName CardItfcServiceImpl.java
 * @Description CardItfcServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.06    ChAoS        최초생성
 *  2015.01.14    dskang       FC통합영업적용
 * </pre>
 * @author 통합엽업회계(ISA) : ChAoS
 * @since 2015.07.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/cardItfcService")
public class CardItfcServiceImpl extends DefaultServiceImpl implements CardItfcService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CardItfcDAO Bean 생성 */
	@Resource(name = "/sc/cmn/cardItfcDAO")
	private CardItfcDAO cardItfcDAO;
	
	/** CardItfcService Bean 생성 */
	@Resource(name = "/sc/cmn/cardItfcService")
	private CardItfcService cardItfcService;
	
	/** VanBrchMapnMgtService Bean 생성 */
	@Resource(name = "/sc/cmn/vanBrchMapnMgtService")
	private VanBrchMapnMgtService vanBrchMapnMgtService;
	
	/**
	 * 신용카드 거래내역 정보 및 입반송 파일을 SFTP 연결을 통해 다운로드 한다.
	 * <pre>
	 * - SFTP 접속정보(VAN 사별 접속정보 및 계정, 경로)를 사업장으로 조회 후 해당 사업장의 신용카드 
	 * 거래내역 (확장자 C01) 및 입반송(확장자 C03) 파일을 다운로드한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            요청조건 Map
	 * @return List<String>
	 *            파일명 목록
	 * @throws Exception
	 */
	public List<String> downloadCardInfo(Map<String, Object> param) throws Exception {
		
		// 거래내역, 입반송 구분(C01, C03)
		String cardRecvType = (String)param.get("cardRecvType");

		List<String> fileList = new ArrayList<String>();
		
		// SFTP 접속 정보를 조회한다.
		RecordSet rs = vanBrchMapnMgtService.selectVanBrchMapnList(param);
		
		// 거래내역의 경우 해당 사업장의 연결된 모든 VAN 사로부터 데이터를 받아온다.
		if(cardRecvType.equals("C01")) {
			for (int i = 0; i < rs.size(); i++) {
				processDownload(rs.get(i), param, fileList);
			}
		}
		// 입반송의 경우 해당 사업장의 주 VAN 사의 데이터를 받아온다.
		else if(cardRecvType.equals("C03")) {
			processDownload(rs.get(0), param, fileList);
		}

		return fileList;
	}
	
	@SuppressWarnings("unchecked")
	public List<String> processDownload(Record rec, Map<String, Object> param, List<String> fileList) throws Exception {
		
		// 거래내역, 입반송 구분(C01, C03)
		String cardRecvType 	 = (String)param.get("cardRecvType");
		
		// 처리일자
		String occrDtFr			 = (String)param.get("occrDtFr");
		String occrDtTo			 = (String)param.get("occrDtTo");
		
		String sftpIp 			 = rec.getString("sftpIp");					// 아이피
		int sftpPort			 = rec.getInt("sftpPort");             		// 포트
		String sftpId 			 = rec.getString("sftpId");            		// 아이디
		//String sftpPswd 		 = EncUtil.dec(rec.getString("sftpPswd"));	// 비밀번호
		String sftpPswd 		 = rec.getString("sftpPswd");	// 비밀번호
		String sftpDownloadPath  = rec.getString("sftpDownloadPath");		// 다운로드 경로
		String vanCd 			 = rec.getString("vanCd");					// VAN 사 코드
		
		SftpUtil sftpUtil = new SftpUtil();
		
		try {
			logger.debug("sftpIp >>>> " + sftpIp);
			logger.debug("sftpPort >>>> " + sftpPort);
			logger.debug("sftpId >>>> " + sftpId);
			logger.debug("sftpPswd >>>> " + sftpPswd);
			
			// SFTP connection 연결
			ChannelSftp channelSftp = sftpUtil.connect(sftpIp, sftpPort, sftpId, sftpPswd);
			
			logger.debug("channelSftp >>>> " + channelSftp);
			
			// SFTP 기본 폴더의 신용카드 해당 유형(거래내역, 입반송)의 파일 리스트 검색
			List<LsEntry> entries = channelSftp.ls(channelSftp.getHome() + "/" + sftpDownloadPath + "/*." + cardRecvType);
			
			for(LsEntry entry : entries) {
				
				// 파일명 추출
				String fileName = entry.getFilename();
				
				
				
				// 파일 확장자 추출
				int pos = fileName.lastIndexOf('.');
				String ext = fileName.substring(pos + 1);
				
				//logger.debug(fileName + ", " + ext);
				
				// 거래내역 파일일자
				String fileRecptDt  = "";
				
				// 거래내역 데이터일 경우(거래내역 확장자 C01)
				if(ext.equals("C01")) {
					fileRecptDt = fileName.substring(18, 24);
				}
				// 입반송 데이터일 경우(입반송 확장자 C03)
				else if(ext.equals("C03")) {
					// 입반송 파일 생성일자 추출(yyMMdd)
					fileRecptDt = fileName.substring(11, 17);
				}
				
				// 조회그룹 추출
				String srcGrup = fileName.substring(5, 10);
				
				logger.debug("srcGrup1 >>>> " + srcGrup);
				logger.debug("srcGrup2 >>>> " + rec.getString("srcGrup"));
				
				// 요청 사업장의 조회그룹과 같은 조회그룹의 파일만 처리
				if(srcGrup.equals(rec.getString("srcGrup"))) {

					// 처리일자 시작과 처리일자 종료 사이의 날짜들을 구함
					List<String> occrDateList = DateUtil.getBetweenDays(occrDtFr, occrDtTo);
					
					for (int j = 0; j < occrDateList.size(); j++) {
						String occrDate = occrDateList.get(j).substring(2);
						logger.debug("occrDate >>>> " + occrDate);
						logger.debug("fileRecptDt >>>> " + fileRecptDt);
						// 입력받은 처리일자와 파일 거래내역일자가 같은 파일만 다운로드
						if(occrDate.equals(fileRecptDt)) {
							sftpUtil.download(fileName, sftpDownloadPath);
							
							// 다운받은 파일의 파일명을 파일명 뒤에 VAN 사 코드가 붙은 파일명으로 변경한다.
							String filePath = propertiesService.getString("global.filedownload.path");
							
							File downloadFile = new File(filePath + "/" + fileName);
							String renameFile = filePath + "/" + fileName + "." + vanCd;
							
							// 변경할 파일명이 있으면 삭제
							File oldFile = new File(renameFile);
							if(oldFile.exists()) {
								oldFile.delete();
							}
							
							downloadFile.renameTo(new File(renameFile));
							
							// 리턴할 파일명은 VAN사 코드가 붙은 파일명으로 처리
							fileList.add(fileName + "." + vanCd);
						}
					}
				}		
			}
			
		} finally {
			// connection 닫기
			sftpUtil.disconnect();
		}
		
		return fileList;
	}
	
	/**
	 * 신용카드 거래내역 정보 및 입반송 파일을 SFTP 연결을 통해 다운로드 한다. (Batch)
	 * <pre>
	 * - 각 VAN 사별 SFTP 계정으로 접속(KICC 는 4개 계정중 호텔 PLAHH00001 계정으로 접속) 후 SFTP 경로의 
	 * 파일 생성일이 당일자인 신용카드 거래내역 (확장자 C01) 및 입반송(확장자 C03) 파일을 다운로드한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            요청조건 Map
	 * @return List<String>
	 *            파일명 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<String> batchDownloadCardInfo(Map<String, Object> param) throws Exception {
		
		List<String> fileList = new ArrayList<String>();
		
		// VAN 사별 SFTP 접속 정보를 조회한다.
		RecordSet rs = vanBrchMapnMgtService.selectVanSftpConnInfoList(param);
		
		// VAN 사별 SFTP 정보로 접속해서 해당 경로 모든 사업장의 파일들을 다운로드 한다.
		for (int i = 0; i < rs.size(); i++) {
			Record rec = rs.get(i);
			
			String sftpIp 			= rec.getString("sftpIp");
			int sftpPort			= rec.getInt("sftpPort");
			String sftpId 			= rec.getString("sftpId");
			String sftpPswd 		= rec.getString("sftpPswd");
			String sftpDownloadPath = rec.getString("sftpDownloadPath");
			String vanCd			= rec.getString("vanCd");
			
			logger.debug("sftpIp >>>> " + sftpIp);
			logger.debug("sftpPort >>>> " + sftpPort);
			logger.debug("sftpId >>>> " + sftpId);
			logger.debug("sftpPswd >>>> " + sftpPswd);			

			SftpUtil sftpUtil = new SftpUtil();
			
			// SFTP connection 연결
			ChannelSftp channelSftp = sftpUtil.connect(sftpIp, sftpPort, sftpId, sftpPswd);		
			
			logger.debug("channelSftp >>>> " + channelSftp);
			
			// 거래내역, 입반송 구분(C01, C03)
			String cardRecvType = (String)param.get("cardRecvType");
			
			// 처리일자는 당일로 설정
			//String occrDtFr		= DateUtil.getSysDate();
			//String occrDtTo		= DateUtil.getSysDate();
			String occrDtFr			 = (String)param.get("occrDtFr");
			String occrDtTo			 = (String)param.get("occrDtTo");
			
			try {
				// SFTP 기본 폴더의 신용카드 해당 유형(거래내역, 입반송)의 파일 리스트 검색
				List<LsEntry> entries = channelSftp.ls(channelSftp.getHome() + "/" + sftpDownloadPath + "/*." + cardRecvType);
				
				for(LsEntry entry : entries) {
					
					// 파일명 추출
					String fileName = entry.getFilename();
					
					
					
					// 파일 확장자 추출
					int pos = fileName.lastIndexOf('.');
					String ext = fileName.substring(pos + 1);
					
					//logger.debug(fileName + ", " + ext);
					
					// 거래내역 파일일자
					String fileRecptDt  = "";
					
					// 거래내역 데이터일 경우(거래내역 확장자 C01)
					if(ext.equals("C01")) {
						fileRecptDt = fileName.substring(18, 24);
					}
					// 입반송 데이터일 경우(입반송 확장자 C03)
					else if(ext.equals("C03")) {
						// 입반송 파일 생성일자 추출(yyMMdd)
						fileRecptDt = fileName.substring(11, 17);
					}
					
					// 조회그룹 추출
					String srcGrup = fileName.substring(5, 10);
					
					logger.debug("srcGrup1 >>>> " + srcGrup);
					logger.debug("srcGrup2 >>>> " + rec.getString("srcGrup"));
					
					// 요청 사업장의 조회그룹과 같은 조회그룹의 파일만 처리
					if(srcGrup.equals(rec.getString("srcGrup"))) {

						// 처리일자 시작과 처리일자 종료 사이의 날짜들을 구함
						List<String> occrDateList = DateUtil.getBetweenDays(occrDtFr, occrDtTo);
						
						for (int j = 0; j < occrDateList.size(); j++) {
							String occrDate = occrDateList.get(j).substring(2);
							logger.debug("occrDate >>>> " + occrDate);
							logger.debug("fileRecptDt >>>> " + fileRecptDt);
							// 입력받은 처리일자와 파일 거래내역일자가 같은 파일만 다운로드
							if(occrDate.equals(fileRecptDt)) {
								sftpUtil.download(fileName, sftpDownloadPath);
								
								// 다운받은 파일의 파일명을 파일명 뒤에 VAN 사 코드가 붙은 파일명으로 변경한다.
								String filePath = propertiesService.getString("global.filedownload.path");
								
								File downloadFile = new File(filePath + "/" + fileName);
								String renameFile = filePath + "/" + fileName + "." + vanCd;
								
								// 변경할 파일명이 있으면 삭제
								File oldFile = new File(renameFile);
								if(oldFile.exists()) {
									oldFile.delete();
								}
								
								downloadFile.renameTo(new File(renameFile));
								
								// 리턴할 파일명은 VAN사 코드가 붙은 파일명으로 처리
								fileList.add(fileName + "." + vanCd);
							}
						}
					}		
				}
				
			} finally {
				// connection 닫기
				sftpUtil.disconnect();
			}			
			
//			try {
//				
//				List<LsEntry> vec = new ArrayList<LsEntry>();
//				
//				/* 신용카드 기본 폴더의 신용카드 해당 유형(거래내역, 입반송)의 파일 리스트 검색
//				 * VAN 사별 계정별 기본 폴더 및 위치가 상이하여 분기 처리
//				 * FDIK 는 계정이 하나이므로 기본 계정 폴더만 설정
//				 * KICC 는 4개 계정중 FC를 뺀 3개 계정을 사용하므로 해당 계정의 각 폴더별 파일 처리 
//				 */
//				// KICC 계정별 기본 폴더
//				String[] defaultFolder = {"63CITYMH01", "63CITYFOOD", "PLAHH00001"};
//				
//				if(vanCd.equals("KICC")) { 
//					// 각 계정별 폴더의 파일들을 조회하여 하나의 VECTOR에 추가
//					for (int j = 0; j < defaultFolder.length ; j++) {
//						List<LsEntry> entries = channelSftp.ls("/kiccftp/" + defaultFolder[j] + "/" + sftpDownloadPath + "/*." + cardRecvType);
//						
//						for(LsEntry entry : entries) {
//							vec.add(entry);
//						}
//					}
//				} else {
//					vec = channelSftp.ls(channelSftp.getHome() + "/" + sftpDownloadPath + "/*." + cardRecvType);
//				}
//
//				for (LsEntry entry : vec) {
//					// 파일명 추출
//					String fileName = entry.getFilename();
//					
//					// 파일 확장자 추출
//					int pos = fileName.lastIndexOf('.');
//					String ext = fileName.substring(pos + 1);
//					
//					logger.debug(fileName + ", " + ext);
//					
//					// 거래내역 파일일자
//					String fileRecptDt = "";
//					
//					// 거래내역 데이터일 경우(거래내역 확장자 C01)
//					if(ext.equals("C01")) {
//						// 거래내역 파일 생성일자 추출(yyMMdd)
//						fileRecptDt = fileName.substring(18, 24);
//					}
//					// 입반송 데이터일 경우(입반송 확장자 C03)
//					else if(ext.equals("C03")) {
//						// 입반송 파일 생성일자 추출(yyMMdd)
//						fileRecptDt = fileName.substring(11, 17);
//					}
//					
//					// 조회그룹
//					String srcGrup = fileName.substring(5, 10);
//					
//					// 처리일자 시작과 처리일자 종료 사이의 날짜들을 구함
//					List<String> occrDateList = DateUtil.getBetweenDays(occrDtFr, occrDtTo);
//					
//					for (int k = 0; k < occrDateList.size(); k++) {
//						String occrDate = occrDateList.get(k).substring(2);
//						
//						// 입력받은 처리일자와 파일 거래내역일자가 같은 파일만 다운로드
//						if(occrDate.equals(fileRecptDt)) {
//							
//							/* 
//							 * KICC 는 4개 계정중 하나의 FC를 뺀 3개 계정을 사용하므로 해당 계정의 각 폴더별 파일 처리
//							 */
//							if(vanCd.equals("KICC")) {
//								StringBuilder home = new StringBuilder("/kiccftp/");
//								// 조회 그룹 첫번째 문자가 A 인경우는 63CITYMH01
//								if(srcGrup.substring(0, 1).equals("A")) {
//									home.append("63CITYMH01");
//								}
//								// 63 운영사업부(5) 일경우는 63CITYFOOD
//								else if(srcGrup.equals("H0005")) {
//									home.append("63CITYFOOD");
//								}
//								// 조회 그룹 첫번째 문자가 H 이면서 63 운영 사업부가 아닌 경우는 PLAHH00001
//								else if(srcGrup.substring(0, 1).equals("H") && !srcGrup.equals("H0005")) {
//									home.append("PLAHH00001");
//								}
//
//								sftpUtil.download(home.toString(), fileName, sftpDownloadPath, "");
//							} else {
//								sftpUtil.download(fileName, sftpDownloadPath);
//							}
//							
//							// 다운받은 파일의 파일명을 파일명 뒤에 VAN 사 코드가 붙은 파일명으로 변경한다.
//							String filePath = propertiesService.getString("global.filedownload.path");
//							
//							File downloadFile = new File(filePath + "/" + fileName);
//							String renameFile = filePath + "/" + fileName + "." + vanCd;
//							
//							// 변경할 파일명이 있으면 삭제
//							File oldFile = new File(renameFile);
//							if(oldFile.exists()) {
//								oldFile.delete();
//							}
//							
//							downloadFile.renameTo(new File(renameFile));
//							
//							// 리턴할 파일명은 VAN사 코드가 붙은 파일명으로 처리
//							fileList.add(fileName + "." + vanCd);
//						}
//					}
//				
//				}
//			
//			} finally {
//				// connection 닫기
//				sftpUtil.disconnect();
//			}	
			
		}
		
		return fileList;
	}	
	
	/**
	 * 신용카드 거래내역 정보를 저장 한다.
	 * <pre>
	 * - 신용카드 거래내역 정보 파일을 읽어 DB에 저장하고 이력을 기록한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            요청조건 Map
	 * @return Map<String, Object>
	 * 			  실행 결과
	 * @throws Exception
	 */
	public Map<String, Object> processCardApInfo(Map<String, Object> param) throws Exception {

		Map<String, Object> rtn = new HashMap<String, Object>();
		
		List<String> fileList = new ArrayList<String>();
		
		String isBatch = StringUtil.nvl(param.get("isBatch"));
		
		// 배치 여부 구분해서 분기처리(신용카드 거래내역 정보 파일을 다운로드한다.)
		if(isBatch.equals("Y")) {
			fileList = this.batchDownloadCardInfo(param);
		} else {
			fileList = this.downloadCardInfo(param);
		}
		
		if(fileList == null || fileList.size() <= 0) {
			rtn.put("procCode", "N");
			rtn.put("procMsg", "처리할 거래내역 파일이 없습니다.");
			return rtn;
		}
		
		BufferedReader reader = null;
		List<CardApDataDTO> cardApDataList = new ArrayList<CardApDataDTO>();
		
		String fileName		= "";   /* 파일명 */
		String compCd		= ""; 	/* 회사 코드 */
		String sysTypeCd 	= "";	/* 시스템 구분 코드 */
		String brchCd		= ""; 	/* 사업장 코드 */
		
		String sabun 		= StringUtil.nvl(param.get("sabun"));
		
		try {
			Map<String, Object> tempParam = new HashMap<String, Object>();
			tempParam.put("tableName", "SLA_ISA_CARD_AP_DATA_TEMP");	// 거래내역 임시테이블 명
			int tempCnt = cardItfcDAO.isTempTableExist(tempParam);
			
			// 임시테이블이 존재하지 않으면
			if(tempCnt == 0) {
				// 거래내역 임시 테이블을 생성한다.
				cardItfcDAO.apTempTableCreate(tempParam);
			}
			
			for (int i = 0; i < fileList.size(); i++) {
				fileName = fileList.get(i);
				
				File f = new File(propertiesService.getString("global.filedownload.path") + "/" + fileName);
				reader = new BufferedReader(new InputStreamReader(new FileInputStream(f), "EUC-KR"));
				
				// 조회그룹5자리 중 첫자리로 회사코드 및 시스템 구분코드 판단
				String systemFlag = StringUtil.nvl(fileName.substring(5,6));
				
				if(systemFlag.equals("A")) {
					compCd 		= "1000";
					sysTypeCd	= "CAMIS";
				} else if(systemFlag.equals("R")) {
					compCd 		= "1000";
					sysTypeCd 	= "IRIS";
				} else if(systemFlag.equals("H")) {
					compCd		= "3000";
					sysTypeCd 	= "PIIS";
				}
				
				/* 조회그룹 5자리 중 나머지 4자리로 사업장 코드 설정
				 * 호텔(PIIS) 인 경우 사업장 코드 앞의 0을 제거한다. (호텔 사업장 코드는 4자리가 아닌 1, 2, 3 등) 
				 */
				if(sysTypeCd.equals("PIIS")) {
					brchCd = StringUtil.nvl(fileName.substring(6,10)).replaceFirst("^0+(?!$)", "");
				} else {
					brchCd = StringUtil.nvl(fileName.substring(6,10));
				}
				
				// 사번 설정
				sabun = sabun.equals("")?"SYSTEM":sabun;
				
				// 신용카드 거래내역 건수 설정
				int cnt = 0;

				// 신용카드 거래내역 항목 개수 (단말기 구분, 거래내역/취소, 카드 번호 등..)
				int itemCnt = 16;
				
				/* 신용카드 거래내역 포맷의 각 항목별 마지막 자리 인덱스 배열. 한글 존재시 byte 차이로 인해 각 항목 끝자리 변경이 필요
				 * ( 1-10 단말기 ID, 11 거래내역/취소 구분, 12-31 카드 번호, 32-34 카드 발급사 코드, 35	KEY-IN/SWAP 원화/달러 구분
				 * 36-39 카드 유효기간 (yymm), 40-47 거래 일자, 48-53 거래 시간, 54-55 할부 기간, 56-65	거래 금액, 66-73 거래내역 번호
				 * 74-83 가맹점 사업자 번호, 84-97 가맹점 번호, 98-127 가맹점 상호, 128-130 매입 은행 코드, 131-134 지점코드, 135-150 사용자임의영역 )
				 */
				int[] endIndexList = {10, 11, 31, 34, 35, 39, 47, 53, 55, 65, 73, 83, 97, 127, 130, 134, 150};
				
				// 현재 처리중인 항목(단말기, 거래내역/취소 등)의 마지막 자리 인덱스
				int endIndex = endIndexList[0];
				// 현재 처리 중인 전문의 인덱스
				int currIndex = 0;
				// 한글 개수
				int hangulCnt = 0;
				// 거래내역 항목 리스트
				List<String> apList = new ArrayList<String>();
				// 현재 처리중인 거래내역 항목 인덱스
				int apIndex = 0;
				
				// 전문 파싱을 위한 변수
				StringBuilder sb = new StringBuilder();
				int value = 0;
				
				// 전송받은 전문을 처리
				while((value = reader.read()) != -1) {
					// 전송받은 전문을 char 단위로 파싱
					char c = (char)value;
					
					// 현재 파싱한 char 처리
					sb.append(c);
					
					// 현재 파싱한 char 가 한글일 경우
					if(StringUtil.isHangul(c)) {
						// 한글일 경우 자리수 변경이 발생하므로 현재 항목의 마지막 자리 위치를 변경한다.
						endIndex--;
						// 한글 개수 증가
						hangulCnt++;
					}
					
					/* 현재 처리중인 항목이 완료된 경우
					 * EX) 단말기 ID 포맷(1 ~ 10 자리) 처리중 10자리까지 파싱된 경우 단말기 ID 파싱 종료
					 */
					if((endIndex - 1) == currIndex) {
						// 현재 파싱된 데이터를 거래내역 목록에 저장한다.
						String str = StringUtil.trimStr(new String(sb.toString()));
						apList.add(str);
						
						// 현재 처리중인 거래 내역 항목 인덱스 증가
						apIndex++;
						
						// 거래내역 항목의 개수까지 실행 (0 ~ 16)
						if(apIndex <= itemCnt) {
							// 다음 항목 마지막 인덱스를 한글 개수 만큼 마이너스
							endIndex = endIndexList[apIndex] - hangulCnt;
						}
						// 초기화
						sb = new StringBuilder();
					}
					
					// 현재 처리 중인 거래내역의 1 cycle 이 완료된 경우 (전문 Line 당 17개 항목. 파싱 완료 시 1 cycle 종료)  
					if(c == '\n') {
						// 신용카드 거래내역 데이터 DTO 설정
						CardApDataDTO cardApDataDTO = new CardApDataDTO();
				
			        	cardApDataDTO.setTrmlNo(apList.get(0));			// 단말기 ID                                                                                   
			        	cardApDataDTO.setAuthGubun(apList.get(1));      // 거래내역/취소 구분SPACE=거래내역,R=취소                                                                    
			        	cardApDataDTO.setCardNum(apList.get(2));        // 카드 번호                                                                                    
			        	cardApDataDTO.setIssueCode(apList.get(3));      // 카드 발급사 코드                                                                                
			        	cardApDataDTO.setEntryCode(apList.get(4));      // KEY-IN/SWAP 원화/달러 구분 S=SWAP이면서 원화 T=SWAP이면서 달러 K=KEY-IN이면서 원화 U=KEY-IN이면서 달러             
			        	cardApDataDTO.setExpDate(apList.get(5));        // 카드 유효기간 (yymm)                                                                           
			        	cardApDataDTO.setRunDate(apList.get(6));        // 거래 일자                                                                                    
			        	cardApDataDTO.setRunTime(apList.get(7));        // 거래 시간                                                                                    
			        	cardApDataDTO.setRunHal(StringUtil.nvl(apList.get(8), "00"));         // 할부 기간
			        	// 거래 금액은 거래내역/취소 구분이 취소(R) 일땐 -로 설정
			        	if(apList.get(1).equals("R")) {
			        		cardApDataDTO.setAuthAmt(new BigDecimal("-" + apList.get(9)));    // 거래 금액
			        	} else {
			        		cardApDataDTO.setAuthAmt(new BigDecimal(apList.get(9)));    	  // 거래 금액
			        	}                    
			        	cardApDataDTO.setAuthNo(apList.get(10));        // 거래내역 번호                                                                                    
			        	cardApDataDTO.setBusiNo(apList.get(11));        // 가맹점 사업자 번호                                                                               
			        	cardApDataDTO.setMerchNum(apList.get(12));      // 가맹점 번호                                                                                   
			        	cardApDataDTO.setMerchName(apList.get(13));     // 가맹점 상호                                                                                   
			        	cardApDataDTO.setBankCode(apList.get(14));      // 매입 은행 코드                                                                                 
			        	cardApDataDTO.setBankSaup(apList.get(15));      // 지점코드                                                                                     
			        	cardApDataDTO.setAgencyCode(apList.get(16));	// 사용자임의영역                                                                                  	
			        	cardApDataDTO.setCompCd(compCd);				// 회사코드
			        	cardApDataDTO.setSysTypeCd(sysTypeCd);			// 시스템 구분 코드
			        	cardApDataDTO.setBrchCd(brchCd);				// 사업장 코드
			        	cardApDataDTO.setCratId(sabun);					// 생성자
			        	cardApDataDTO.setUpdtId(sabun);					// 수정자
			        	
			        	cardApDataList.add(cardApDataDTO);
			        	
			        	// 건수 증가
			        	cnt++;
			        	
			        	// 파싱 위해 선언된 변수들 초기화
						endIndex = endIndexList[0];
						currIndex = 0;
						hangulCnt = 0;
						
						apList = new ArrayList<String>();
						apIndex = 0;
						sb = new StringBuilder();		        	
			        	
			        	continue;
					}
					
					// 파싱 중인 인덱스 증가
					currIndex++;

				}				
		        
		        reader.close();
		       
		        // 신용카드 거래내역 파일 임시 디렉토리에서 백업 디렉토리로 복사
		        FileUtil.copyFile(f.getPath()
		        		, propertiesService.getString("global.filerepository.path") + "/card/" + DateUtil.getSysMonth() + "/" + fileName);
		        
		        // 신용카드 거래내역 파일 임시 디렉토리에서 삭제
		        FileUtil.deleteFile(f.getPath());
		        
		        // 신용카드 송수신 이력 기록
				CardHistDTO cardHistDTO = new CardHistDTO();
				
				cardHistDTO.setCompCd(compCd);							// 회사 코드
				cardHistDTO.setSysTypeCd(sysTypeCd);					// 시스템 구분 코드
				cardHistDTO.setBrchCd(brchCd);							// 사업장 코드
				cardHistDTO.setRecdType("C01");							// 전문코드(C01 거래내역,C02 청구,C03 입반송)
				cardHistDTO.setRecptDt(fileName.substring(18, 24));		// 처리일자(YYYYMMDD)
				cardHistDTO.setSendRecType("R"); 						// 송수신구분 (S:전송, R:수신)
				cardHistDTO.setCnt(String.valueOf(cnt));				// 건수
				cardHistDTO.setFileNm(fileName);						// 파일명
				cardHistDTO.setErrYn("N");								// 오류여부 (기본 N)
				cardHistDTO.setCratId(sabun);							// 생성자
				cardHistDTO.setUpdtId(sabun);							// 수정자
		        
				//cardItfcService.insertCardHist(cardHistDTO);
			}
			
			cardItfcDAO.insertCardApData(cardApDataList);
			
			// 파싱한 거래내역 전문 데이터를 생성한 임시 테이블에 입력한다.
			cardItfcDAO.insertApTempData(cardApDataList);
			// 임시 테이블의 거래내역 데이터를 거래내역 테이블에 입력 / 수정 한다.
			cardItfcDAO.mergeApDataTemp(tempParam);
			// 생성한 거래내역 임시 테이블의 데이터를 삭제한다.
			cardItfcDAO.deleteApTempData(new HashMap<String, Object>());

		} catch (Exception e) {			
			throw e;
		} finally {
			reader.close();
			// 거래내역 임시 테이블을 삭제한다.
			cardItfcDAO.apTempTableDrop(new HashMap<String, Object>());
		}
		
		rtn.put("procCode", "Y");
		rtn.put("procMsg", "거래내역이 처리되었습니다.");
		
		return rtn;
		
	}
	
	/**
	 * 신용카드 입반송 정보를 저장 한다.
	 * <pre>
	 * - 신용카드 입반송 정보 파일을 읽어 DB에 저장하고 이력을 기록한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            요청조건 Map
	 * @return Map<String, Object>
	 * 			  실행 결과
	 * @throws Exception
	 */
	public Map<String, Object> processCardReplyInfo(Map<String, Object> param) throws Exception {

		Map<String, Object> rtn = new HashMap<String, Object>();
		
		List<String> fileList =  new ArrayList<String>();
		
		String isBatch = StringUtil.nvl(param.get("isBatch"));
		
		// 배치 여부 구분해서 분기처리(신용카드 입반송 정보 파일을 다운로드한다.)
		if(isBatch.equals("Y")) {
			fileList = this.batchDownloadCardInfo(param);
		} else {
			fileList = this.downloadCardInfo(param);	
		}
		
		if(fileList == null || fileList.size() <= 0) {
			rtn.put("procCode", "N");
			rtn.put("procMsg", "처리할 입반송 파일이 없습니다.");
			return rtn;
		}
		
		BufferedReader reader = null;
		
		String fileName		= "";   /* 파일명 */
		String compCd		= ""; 	/* 회사 코드 */
		String sysTypeCd 	= "";	/* 시스템 구분 코드 */
		String brchCd		= ""; 	/* 사업장 코드 */
		
		String sabun 		= StringUtil.nvl(param.get("sabun"));
		
		try {
			Map<String, Object> tempParam = new HashMap<String, Object>();
			tempParam.put("tableName", "SLA_ISA_CARD_REPLY_TEMP");	// 입반송 임시테이블 명
			int tempCnt = cardItfcDAO.isTempTableExist(tempParam);
			
			// 임시테이블이 존재하지 않으면
			if(tempCnt == 0) {
				// 입반송 임시 테이블을 생성한다.
				cardItfcDAO.replyTempTableCreate(tempParam);
			}
			
			for (int i = 0; i < fileList.size(); i++) {
				List<CardReplyDTO> cardReplyList = null;
				
				fileName = fileList.get(i);
				
				File f = new File(propertiesService.getString("global.filedownload.path") + "/" + fileName);
				reader = new BufferedReader(new InputStreamReader(new FileInputStream(f)));
				
				// 조회그룹5자리 중 첫자리로 회사코드 및 시스템 구분코드 판단
				String systemFlag = StringUtil.nvl(fileName.substring(5,6)); 
				if(systemFlag.equals("A")) {
					compCd 		= "1000";
					sysTypeCd	= "CAMIS";
				} else if(systemFlag.equals("R")) {
					compCd 		= "1000";
					sysTypeCd 	= "IRIS";
				} else if(systemFlag.equals("H")) {
					compCd		= "3000";
					sysTypeCd 	= "PIIS";
				}
				
				/* 조회그룹 5자리 중 나머지 4자리로 사업장 코드 설정
				 * 호텔(PIIS) 인 경우 사업장 코드 앞의 0을 제거한다. (호텔 사업장 코드는 4자리가 아닌 1, 2, 3 등) 
				 */
				if(sysTypeCd.equals("PIIS")) {
					brchCd = StringUtil.nvl(fileName.substring(6,10)).replaceFirst("^0+(?!$)", "");
				} else {
					brchCd = StringUtil.nvl(fileName.substring(6,10));
				}
				
				// 사번 설정
				sabun = sabun.equals("")?"SYSTEM":sabun;
				
				String str = "";
				
				// 신용카드 입반송 건수 설정
				int cnt = 0;
				
				// CardReplyDTO 객체 신규 생성
				CardReplyDTO cardReplyDTO = null;
	        	
	        	// 입반송 Start Record
	        	String recordClCd		= "";
	        	String fileWrtDt		= "";
	        	String purchFmBizrNo	= "";
	        	String joShopBizrNo	    = "";
	        	String rcptStaDt	    = "";
	        	String rcptEndDt	    = "";
	        	String payPlanDt	    = "";
	        	String joShopNo		    = "";
	        	String crncyCd		    = "";
	        	String svcClCd		    = "";
	        	String salStaDt		    = "";
	        	String salEndDt		    = "";
	        	String invDt		    = "";
	        	String purchFmCd	    = "";
	        	String finOrgEcd	    = "";
	        	                          
	        	// 입반송 Total Record
	        	String ttRecordClCd		= "";
	        	String ttRcptCnt		= "";
	        	String ttRcptAmt	    = "";
	        	String ttRetCnt		    = "";
	        	String ttRetAmt		    = "";
	        	String ttDfrCnt		    = "";
	        	String ttDfrAmt		    = "";
	        	String ttDfrRelseCnt    = "";
	        	String ttDfrRelseAmt    = "";
	        	String ttTotCnt		    = "";
	        	String ttTotAmt		    = "";
	        	String ttCmmsSamt	    = "";
	        	String ttPayAmt		    = "";
	        	String recdStat		    = "";
	        	
				// 신용카드 입반송 데이터 파싱
		        while((str = reader.readLine()) != null) {
		        	
		        	// 공백라인은 무시
		        	if(str.length() <= 0) {
		        		continue;
		        	}
		        	
		        	// 신용카드 입반송 데이터 DTO 설정
					
					// 필드 구분자에 따라 전문 파싱 유형 분리
					String fieldType = str.substring(0, 2);
					
					// Start Record (52)
					if(fieldType.equals("52")) {
						cardReplyList = new ArrayList<CardReplyDTO>();
						
						recordClCd		= StringUtil.trimStr(str.substring(0, 2));		/* RECORD 구분 52 */
						fileWrtDt		= StringUtil.trimStr(str.substring(2, 10)); 	/* 파일작성일(YYYYMMDD) */
						purchFmBizrNo	= StringUtil.trimStr(str.substring(10, 20)); 	/* 매입카드회사 사업자등록번호 */
						joShopBizrNo	= StringUtil.trimStr(str.substring(20, 30)); 	/* 가맹점 사업자등록번호 */
						rcptStaDt		= StringUtil.trimStr(str.substring(30, 38)); 	/* 접수일자 FROM */
						rcptEndDt		= StringUtil.trimStr(str.substring(38, 46)); 	/* 접수일자 TO */
						payPlanDt		= StringUtil.trimStr(str.substring(46, 54)); 	/* 지급(예정)일자 */
						
						// 가맹점번호는 FDIK의 경우 빈 자리수만큼 앞자리에 0 을 채워서 전송되므로 앞자리 0을 제거
						joShopNo		= StringUtil.trimStr(str.substring(54, 69).replaceFirst("^0+(?!$)", "")); 	/* 가맹점번호 */
						
						crncyCd			= StringUtil.trimStr(str.substring(69, 72)); 	/* 통화코드 410:원화, 840:달러화 */
						svcClCd			= StringUtil.trimStr(str.substring(72, 75)); 	/* 서비스구분 DDC, DSC, EDI */
						salStaDt		= StringUtil.trimStr(str.substring(75, 83)); 	/* 매출일자 FROM */
						salEndDt		= StringUtil.trimStr(str.substring(83, 91)); 	/* 매출일자 TO */
						invDt			= StringUtil.trimStr(str.substring(91, 99)); 	/* 청구일자 */
						//filler		= StringUtil.trimStr(str.substring(91, 194));	// 무의미한 SPACE 공간이라 사용하지 않음
						purchFmCd		= StringUtil.trimStr(str.substring(194, 197)); 	/* 매입사 코드 */
						finOrgEcd		= StringUtil.trimStr(str.substring(197, 200)); 	/* 매입사 영문코드 */
					}
					// Total Record (53)
					else if(fieldType.equals("53")) {
						ttRecordClCd	= StringUtil.trimStr(str.substring(0, 2)); 		/* RECORD 구분 53 입금통지 */
						ttRcptCnt		= StringUtil.trimStr(str.substring(2, 11)); 	/* A1 청구접수건수 */
						ttRcptAmt		= StringUtil.trimStr(str.substring(11, 25)); 	/* B1 청구접수금액 */
						ttRetCnt		= StringUtil.trimStr(str.substring(25, 34)); 	/* A2 반송건수 */
						ttRetAmt		= StringUtil.trimStr(str.substring(34, 48)); 	/* B2 반송금액 */
						ttDfrCnt		= StringUtil.trimStr(str.substring(48, 57)); 	/* A3 보류건수 */
						ttDfrAmt		= StringUtil.trimStr(str.substring(57, 71)); 	/* B3 보류금액 */
						ttDfrRelseCnt	= StringUtil.trimStr(str.substring(71, 80)); 	/* A4 보류해제건수 */
						ttDfrRelseAmt	= StringUtil.trimStr(str.substring(80, 94)); 	/* B4 보류해제금액 */
						ttTotCnt		= StringUtil.trimStr(str.substring(94, 103)); 	/* A5 합계건수 */
						ttTotAmt		= StringUtil.trimStr(str.substring(103, 117)); 	/* B5 합계금액 */
						ttCmmsSamt		= StringUtil.trimStr(str.substring(117, 131)); 	/* E 수수료합계 */
						ttPayAmt		= StringUtil.trimStr(str.substring(131, 145)); 	/* F 입금액 */
						recdStat		= "I"; 											/* 상태 */
						
						for (int j = 0; j < cardReplyList.size(); j++) {

							// Start Record DTO 설정
							cardReplyList.get(j).setRecordClCd(recordClCd);
							cardReplyList.get(j).setFileWrtDt(fileWrtDt);
							cardReplyList.get(j).setPurchFmBizrNo(purchFmBizrNo);
							cardReplyList.get(j).setJoShopBizrNo(joShopBizrNo);
							cardReplyList.get(j).setRcptStaDt(rcptStaDt);
							cardReplyList.get(j).setRcptEndDt(rcptEndDt);
							cardReplyList.get(j).setPayPlanDt(payPlanDt);
							cardReplyList.get(j).setJoShopNo(joShopNo);
							cardReplyList.get(j).setCrncyCd(crncyCd);
							cardReplyList.get(j).setSvcClCd(svcClCd);
							cardReplyList.get(j).setSalStaDt(salStaDt);
							cardReplyList.get(j).setSalEndDt(salEndDt);
							cardReplyList.get(j).setInvDt(invDt);
							cardReplyList.get(j).setPurchFmCd(purchFmCd);
							cardReplyList.get(j).setFinOrgEcd(finOrgEcd);
							
							// Total Record DTO 설정
							cardReplyList.get(j).setTtRecordClCd(ttRecordClCd);
							cardReplyList.get(j).setTtRcptCnt(ttRcptCnt);
							cardReplyList.get(j).setTtRcptAmt(ttRcptAmt);
							cardReplyList.get(j).setTtRetCnt(ttRetCnt);
							cardReplyList.get(j).setTtRetAmt(ttRetAmt);
							cardReplyList.get(j).setTtDfrCnt(ttDfrCnt);
							cardReplyList.get(j).setTtDfrAmt(ttDfrAmt);
							cardReplyList.get(j).setTtDfrRelseCnt(ttDfrRelseCnt);
							cardReplyList.get(j).setTtDfrRelseAmt(ttDfrRelseAmt);
							cardReplyList.get(j).setTtTotCnt(ttTotCnt);
							cardReplyList.get(j).setTtTotAmt(ttTotAmt);
							cardReplyList.get(j).setTtCmmsSamt(ttCmmsSamt);
							cardReplyList.get(j).setTtPayAmt(ttPayAmt);
							cardReplyList.get(j).setRecdStat(recdStat);
							cardReplyList.get(j).setCompCd(compCd);
							cardReplyList.get(j).setSysTypeCd(sysTypeCd);
							cardReplyList.get(j).setBrchCd(brchCd);
							cardReplyList.get(j).setCreateBy(sabun);
							cardReplyList.get(j).setUpdateBy(sabun);
							cardReplyList.get(j).setArNo("");
						}
						
						// 신용카드 입반송 정보 DB 에 입력
						cardItfcDAO.insertCardReply(cardReplyList);
						
						// 파싱한 입반송 전문 데이터를 생성한 임시 테이블에 입력한다.
						cardItfcDAO.insertCardReplyTempData(cardReplyList);
						
					}
					
					// Data Record (60, 61, 62, 63, 64, 65, 66, 67)
					else {
						
						// 1 대 (Start Record, Total Record) N (Data Record) 구조이므로 Data Record 에서 cardReplyDTO 객체 신규 생성
						cardReplyDTO = new CardReplyDTO();
						
						String dtRecordClCd		= StringUtil.trimStr(str.substring(0, 2)); 		/* RECORD 구분 */
						String dtCrncyCd		= StringUtil.trimStr(str.substring(2, 5)); 		/* 통화코드 410:원화, 840:달러화 */
						String dtCrncyIdx		= StringUtil.trimStr(str.substring(5, 6)); 		/* 통화지수 0:원화, 2:달러화 */
						String dtSalDt			= StringUtil.trimStr(str.substring(6, 14)); 	/* 매출(취소)일자 YYYYMMDD */
						String dtRcptDt			= StringUtil.trimStr(str.substring(14, 22)); 	/* 접수일자 */
						String dtCardno			= StringUtil.trimStr(str.substring(22, 42)); 	/* 카드번호 */
						String dtAlotMonthsCnt	= StringUtil.trimStr(str.substring(42, 44)); 	/* 할부기간 일반매출:00, 할부매출:02-36 */
						String dtTotTrxAmt		= StringUtil.trimStr(str.substring(44, 56)); 	/* 신용판매금액 거래금액 */
						
						// RECORD 구분이 취소매출정상(67) 일땐 금액을 -로 처리한다.
						if(dtRecordClCd.equals("67")) {
							dtTotTrxAmt = "-" + dtTotTrxAmt;
						}

						String dtCardfmRetRsnCd	= StringUtil.trimStr(str.substring(56, 60)); 	/* 반송사유코드 */
						String dtKiccRetRsnCd	= StringUtil.trimStr(str.substring(60, 62)); 	/* 반송사유코드 KICC 표준 카드사의 반송코드 */
						String dtUserDefCont1	= StringUtil.trimStr(str.substring(62, 82)); 	/* 점포코드+가맹점임의정보 */
						String dtUserDefCont2	= StringUtil.trimStr(str.substring(82, 102)); 	/* 가맹점사용영역2 */
						String dtAprvNo			= StringUtil.trimStr(str.substring(102, 112)); 	/* 거래내역번호 */
						String dtShopPosNo		= StringUtil.trimStr(str.substring(112, 118)); 	/* 매장(POS)번호 */
						String dtCmmsAmt		= StringUtil.trimStr(str.substring(118, 130)); 	/* 건별수수료 - 매입정상:12자리숫자 매입취소정상:1자리기호(-)+11자리숫자 */
						String dtTid			= StringUtil.trimStr(str.substring(130, 140)); 	/* 단말기번호 */
						String dtChnlUsedField	= StringUtil.trimStr(str.substring(140, 160)); 	/* 추가필드 */
						String dtCardTypCd		= StringUtil.trimStr(str.substring(160, 161)); 	/* 카드구분 */
						
						// Data Record DTO 설정
						cardReplyDTO.setDtRecordClCd(dtRecordClCd);
						cardReplyDTO.setDtCrncyCd(dtCrncyCd);
						cardReplyDTO.setDtCrncyIdx(dtCrncyIdx);
						cardReplyDTO.setDtSalDt(dtSalDt);
						cardReplyDTO.setDtRcptDt(dtRcptDt);
						cardReplyDTO.setDtCardno(dtCardno);
						cardReplyDTO.setDtAlotMonthsCnt(dtAlotMonthsCnt);
						cardReplyDTO.setDtTotTrxAmt(dtTotTrxAmt);
						cardReplyDTO.setDtCardfmRetRsnCd(dtCardfmRetRsnCd);
						cardReplyDTO.setDtKiccRetRsnCd(dtKiccRetRsnCd);
						cardReplyDTO.setDtUserDefCont1(dtUserDefCont1);
						cardReplyDTO.setDtUserDefCont2(dtUserDefCont2);
						cardReplyDTO.setDtAprvNo(dtAprvNo);
						cardReplyDTO.setDtShopPosNo(dtShopPosNo);
						cardReplyDTO.setDtCmmsAmt(dtCmmsAmt);
						cardReplyDTO.setDtTid(dtTid);
						cardReplyDTO.setDtChnlUsedField(dtChnlUsedField);
						cardReplyDTO.setDtCardTypCd(dtCardTypCd);
						
						// 관계번호(점포코드+가맹점임의정보 에서 점포코드 제외한 값)
						String rltnSeq = dtUserDefCont1;
						if(rltnSeq.length() > 0) {
							rltnSeq = rltnSeq.substring(4);
						}
						cardReplyDTO.setRltnSeq(rltnSeq);
						
						// 중복 체크
						boolean dupChk = replyDupChk(cardReplyList, cardReplyDTO);
						
						if(dupChk) {
							continue;
						}
						
						// cardReplyList 객체에 현재 cardReplyDTO 추가
						cardReplyList.add(cardReplyDTO);
						
						// 반송건이면 기존 청구데이터의 반송구분코드에 반송코드를 수정한다.
						if(!dtRecordClCd.equals("60")) {
							HashMap<String, Object> mapParam = new HashMap<String, Object>();
							mapParam.put("compCd", compCd);
							mapParam.put("sysTypeCd", sysTypeCd);
							mapParam.put("brchCd", brchCd);
							mapParam.put("dtRecordClCd", dtRecordClCd);
							mapParam.put("dtSalDt", dtSalDt);
							mapParam.put("rltnSeq", rltnSeq);
							
							//ediApprDataCheckDAO.updateRltnCardApprInfo(mapParam);
						}
						
						// 건수 증가
						cnt++;
					}
		        	
		        }
				
				// DDC(CAMIS) 의 경우 고유 KEY(RLTN_SEQ) 값을 받지 못하므로 청구데이터 기준으로 업데이트
				if(sysTypeCd.equals("CAMIS")) {
					cardItfcDAO.updateCardReplyTemp(new HashMap<String, Object>());
				}
				
				Map<String, Object> reply = new HashMap<String, Object>();
				reply.put("sysTypeCd", sysTypeCd);
				
				// 임시 테이블의 입반송 데이터를 입반송 테이블에 입력 / 수정 한다.
				cardItfcDAO.mergeCardReplyTemp(reply);
				// 생성한 입반송 임시 테이블의 데이터를 삭제한다.
				cardItfcDAO.deleteCardReplyTempData(new HashMap<String, Object>());
				
		        reader.close();
		       
		        // 신용카드 입반송 파일 임시 디렉토리에서 백업 디렉토리로 복사
		        FileUtil.copyFile(f.getPath()
		        		, propertiesService.getString("global.filerepository.path") + "/card/" + DateUtil.getSysMonth() + "/" + fileName);
		        
		        // 신용카드 거래내역 파일 임시 디렉토리에서 삭제
		        FileUtil.deleteFile(f.getPath());
		        
		        // 신용카드 송수신 이력 기록
				CardHistDTO cardHistDTO = new CardHistDTO();
				
				cardHistDTO.setCompCd(compCd);							// 회사 코드
				cardHistDTO.setSysTypeCd(sysTypeCd);					// 시스템 구분 코드
				cardHistDTO.setBrchCd(brchCd);							// 사업장 코드
				cardHistDTO.setRecdType("C03");							// 전문코드(C01 거래내역,C02 청구,C03 입반송)
				cardHistDTO.setRecptDt(fileName.substring(11, 17));		// 처리일자(YYYYMMDD)
				cardHistDTO.setSendRecType("R"); 						// 송수신구분 (S:전송, R:수신)
				cardHistDTO.setCnt(String.valueOf(cnt));				// 건수
				cardHistDTO.setFileNm(fileName);						// 파일명
				cardHistDTO.setErrYn("N");								// 오류여부 (기본 N)
				cardHistDTO.setCratId(sabun);							// 생성자
				cardHistDTO.setUpdtId(sabun);							// 수정자
		        
				//cardItfcService.insertCardHist(cardHistDTO);
			}

		} catch (Exception e) {
			
			// 오류 발생 시 로그 기록
			CardHistDTO cardHistDTO = new CardHistDTO();
			
			cardHistDTO.setCompCd(compCd);							// 회사 코드
			cardHistDTO.setSysTypeCd(sysTypeCd);					// 시스템 구분 코드
			cardHistDTO.setBrchCd(brchCd);							// 사업장 코드
			cardHistDTO.setRecdType("C03");							// 전문코드(C01 거래내역,C02 청구,C03 입반송)
			cardHistDTO.setRecptDt(fileName.substring(11, 17));		// 처리일자(YYYYMMDD)
			cardHistDTO.setSendRecType("R"); 						// 송수신구분 (S:전송, R:수신)
			cardHistDTO.setFileNm(fileName);						// 파일명
			cardHistDTO.setErrYn("Y");								// 오류여부 (기본 N)
			cardHistDTO.setCratId(sabun);							// 생성자
			cardHistDTO.setUpdtId(sabun);							// 수정자
			
			//cardItfcService.insertCardHistNewTx(cardHistDTO);
			
			throw e;
		} finally {
			// BufferedReader 닫기
			reader.close();
			// 입반송 임시 테이블을 삭제한다.
			cardItfcDAO.replyTempTableDrop(new HashMap<String, Object>());
		}
		
		rtn.put("procCode", "Y");
		rtn.put("procMsg", "입반송이 처리되었습니다.");
		
		return rtn;
				
	}
	
	/**
	 * 신용카드 VAN 사와 인터페이스 이력(청구, 거래내역, 입반송) 을 등록한다.
	 * 
	 * @param cardHistDTO
	 *            CardHistDTO 요청조건 Map
	 * @return int
	 *            처리 건수
	 * @throws Exception
	 */	
	public int insertCardHist(CardHistDTO cardHistDTO) throws Exception {
		return cardItfcDAO.insertCardHist(cardHistDTO);
	}
	
	/**
	 * 신용카드 VAN 사와 인터페이스 이력(청구, 거래내역, 입반송) 을 신규 트랜잭션으로 등록한다. (오류 발생시)
	 * 
	 * @param cardHistDTO
	 *            CardHistDTO 요청조건 Map
	 * @return int
	 *            처리 건수
	 * @throws Exception
	 */
	public int insertCardHistNewTx(CardHistDTO cardHistDTO) throws Exception {
		return cardItfcDAO.insertCardHist(cardHistDTO);
	}
	
	/**
	 * VAN 사로 부터 수신한 입반송 데이터 중 중복 여부를 체크한다.
	 * 
	 * @param cardReplyList
	 *            CardReplyDTO 요청조건 Map
	 * @return boolean
	 *            중복 여부
	 * @throws Exception
	 */
	public boolean replyDupChk(List<CardReplyDTO> cardReplyList, CardReplyDTO cardReplyDTO) {
		boolean dupChk = false;
		
		for (int i = 0; i < cardReplyList.size(); i++) {
			
			String dtSalDt 		 = cardReplyList.get(i).getDtSalDt();		// 승인일자
			String rltnSeq 		 = cardReplyList.get(i).getRltnSeq();		// 관계번호
			String dtAprvNo 	 = cardReplyList.get(i).getDtAprvNo();		// 승인번호
			String totTrxAmt 	 = cardReplyList.get(i).getDtTotTrxAmt();	// 승인금액
			String dtRecordClCd  = cardReplyList.get(i).getDtRecordClCd();	// RECORD 구분. 정상, 반송등
			String dtCardno 	 = cardReplyList.get(i).getDtCardno();		// 카드번호
			String dtTid		 = cardReplyList.get(i).getDtTid();			// 단말기
			
			String dtSalDtC 	 = cardReplyDTO.getDtSalDt();				// 승인일자
			String rltnSeqC 	 = cardReplyDTO.getRltnSeq();				// 관계번호
			String dtAprvNoC	 = cardReplyDTO.getDtAprvNo();				// 승인번호
			String totTrxAmtC 	 = cardReplyDTO.getDtTotTrxAmt();			// 승인금액
			String dtRecordClCdC = cardReplyDTO.getDtRecordClCd();			// RECORD 구분. 정상, 반송등
			String dtCardnoC 	 = cardReplyDTO.getDtCardno();				// 카드번호
			String dtTidC		 = cardReplyDTO.getDtTid();					// 단말기
			
			// 중복으로 들어온 데이터를 체크
			if(dtSalDt.equals(dtSalDtC) && rltnSeq.equals(rltnSeqC) && dtAprvNo.equals(dtAprvNoC) 
					&& totTrxAmt.equals(totTrxAmtC) && dtRecordClCd.equals(dtRecordClCdC) && dtCardno.equals(dtCardnoC)
					&& dtTid.equals(dtTidC)) {
				dupChk = true;
			}
			
		}
		
		return dupChk;
	}
}