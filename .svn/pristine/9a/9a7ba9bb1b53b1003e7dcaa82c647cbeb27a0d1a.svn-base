package com.hwfs.sc.cmn.service;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.CardHistDTO;

 /**
 * 신용카드 정보를 인터페이스 하는 Service Interface
 * 
 * @ClassName CardItfcService.java
 * @Description CardItfcService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.06    ChAoS        최초생성
 *  2015.01.14    dskang       FC통합영업적용
 *  
 * </pre>
 * @author 통합엽업회계(ISA) : ChAoS
 * @since 2015.07.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CardItfcService {

	/**
	 * 신용카드 거래내역정보 및 입반송 파일을 SFTP 연결을 통해 다운로드 한다.
	 * <pre>
	 * - sftpTyp(63문화, 63식음, 외식, 플라자호텔) 에 따라 해당 SFTP 경로의 신용카드 
	 * 거래내역정보(확장자 C01) 및 입반송(확장자 C03) 을 다운로드한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            요청조건 Map
	 * @return List<String>
	 *            파일명 목록
	 * @throws Exception
	 */
	public List<String> downloadCardInfo(Map<String, Object> param) throws Exception;
	
	/**
	 * 신용카드 거래내역 정보 및 입반송 파일을 SFTP 연결을 통해 다운로드 한다. (Batch)
	 * <pre>
	 * - SFTP 접속정보(VAN 사별 접속정보 및 계정, 경로)를 접속유형으로 조회 후 해당 SFTP 경로의 신용카드 
	 * 거래내역 정보(확장자 C01) 및 입반송(확장자 C03) 을 다운로드한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            요청조건 Map
	 * @return List<String>
	 *            파일명 목록
	 * @throws Exception
	 */
	public List<String> batchDownloadCardInfo(Map<String, Object> param) throws Exception;	
	
	/**
	 * 신용카드 거래내역 정보를 저장 한다.
	 * <pre>
	 * - 신용카드 거래내역 정보 파일을 읽어 DB에 저장하고 이력을 기록한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            Map<String, Object> 요청조건 Map
	 * @return Map<String, Object>
	 * 			  실행 결과
	 * @throws Exception
	 */
	public Map<String, Object> processCardApInfo(Map<String, Object> param) throws Exception;
	
	/**
	 * 신용카드 입반송 정보를 저장 한다.
	 * <pre>
	 * - 신용카드 입반송 정보 파일을 읽어 DB에 저장하고 이력을 기록한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            Map<String, Object> 요청조건 Map
	 * @return Map<String, Object>
	 * 			  실행 결과
	 * @throws Exception
	 */	
	public Map<String, Object> processCardReplyInfo(Map<String, Object> param) throws Exception;
	
	/**
	 * 신용카드 VAN 사와 인터페이스 이력(청구, 거래내역, 입반송) 을 등록한다.
	 * 
	 * @param cardHistList
	 *            CardHistDTO 요청조건 Map
	 * @return int
	 *            처리 건수
	 * @throws Exception
	 */
	public int insertCardHist(CardHistDTO cardHistDTO) throws Exception;	
	
	/**
	 * 신용카드 VAN 사와 인터페이스 이력(청구, 거래내역, 입반송) 을 신규 트랜잭션으로 등록한다. (오류 발생시)
	 * 
	 * @param cardHistDTO
	 *            CardHistDTO 요청조건 Map
	 * @return int
	 *            처리 건수
	 * @throws Exception
	 */
	public int insertCardHistNewTx(CardHistDTO cardHistDTO) throws Exception;
}
