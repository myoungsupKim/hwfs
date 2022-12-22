package com.hwfs.sc.scz.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scz.dao.SapInterfaceRetrieveDAO;

 /**
 * SAP 인터페이스 내역을 조회하는 SapInterfaceRetrieve Service Implementation
 * 
 * @ClassName SapInterfaceRetrieveServiceImpl.java
 * @Description SapInterfaceRetrieveServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.02    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.09.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scz/sapInterfaceRetrieveService")
public class SapInterfaceRetrieveServiceImpl extends DefaultServiceImpl implements SapInterfaceRetrieveService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SapInterfaceRetrieveDAO Bean 생성 */
	@Resource(name = "/sc/scz/sapInterfaceRetrieveDAO")
	private SapInterfaceRetrieveDAO sapInterfaceRetrieveDAO;
	

	/**
	 * 계정코드 마지막 수신일자 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectAcctMstLastDate() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return sapInterfaceRetrieveDAO.selectAcctMstLastDate(mapParam);
	}
	
	/**
	 * 계정코드 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectAcctMst(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectAcctMst(mapParam);
	}

	/**
	 * 전표 마지막 송신일자 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSlipLastDate() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return sapInterfaceRetrieveDAO.selectSlipLastDate(mapParam);
	}

	/**
	 * 전표유형 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSlipType() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return sapInterfaceRetrieveDAO.selectSlipType(mapParam);
	}

	/**
	 * 전표마스터 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSlipMst(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectSlipMst(mapParam);
	}

	/**
	 * 전표디테일 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSlipDtl(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectSlipDtl(mapParam);
	}

	/**
	 * 전표상태 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSlipStatus(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectSlipStatus(mapParam);
	}

	/**
	 * 전표취소 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSlipCancel(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectSlipCancel(mapParam);
	}

	/**
	 * 거래처 마지막 요청일자
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCustLastDate() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return sapInterfaceRetrieveDAO.selectCustLastDate(mapParam);
	}
	
	/**
	 * 거래처 요청 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCustRequest(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectCustRequest(mapParam);
	}

	/**
	 * 거래처 요청결과 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCustResponse(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectCustResponse(mapParam);
	}

	/**
	 * 조직 마지막 수신일자
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCcLastDate() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return sapInterfaceRetrieveDAO.selectCcLastDate(mapParam);
	}
	
	/**
	 * 조직 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCc(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectCc(mapParam);
	}

	public RecordSet selectCcLog(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectCcLog(mapParam);
	}

	/**
	 * 세금계산서 마지막 송신일자
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTaxShetLastDate() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return sapInterfaceRetrieveDAO.selectTaxShetLastDate(mapParam);
	}
	
	/**
	 * 세금계산서 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTaxShetHdr(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectTaxShetHdr(mapParam);
	}
	
	/**
	 * 세금계산서 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTaxShetItem(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectTaxShetItem(mapParam);
	}
	
	/**
	 * 세금계산서 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTaxShetPublish(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectTaxShetPublish(mapParam);
	}
	
	/**
	 * 세금계산서 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTaxShetAttach(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectTaxShetAttach(mapParam);
	}
	
	/**
	 * 세금계산서 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTaxShetPublishStatus(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectTaxShetPublishStatus(mapParam);
	}
	
	/**
	 * 세금계산서 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTaxShetStatus(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectTaxShetStatus(mapParam);
	}
	
	/**
	 * 세금계산서 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTaxShetNtsStatus(Map<String, Object> mapParam) throws Exception {
		return sapInterfaceRetrieveDAO.selectTaxShetNtsStatus(mapParam);
	}






}
