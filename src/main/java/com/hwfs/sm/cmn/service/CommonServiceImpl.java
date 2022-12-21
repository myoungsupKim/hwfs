package com.hwfs.sm.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.cmn.dao.CommonDAO;

 /**
 * 공통 Common Service Implementation
 * 
 * @ClassName CommonServiceImpl.java
 * @Description CommonServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.12    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/cmn/commonService")
public class CommonServiceImpl extends DefaultServiceImpl implements CommonService {
	
	/** CommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/commonDAO")
	private CommonDAO commonDAO;

	/**
	 * 영업유형코드(Combo)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectComCode(Map<String, Object> mapParam) throws Exception {
		return commonDAO.selectComCode(mapParam);
	}
	
	/**
	 * 사업부(Combo)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectMuCd(Map<String, Object> mapParam) throws Exception {
		return commonDAO.selectMuCd(mapParam);
	}

	/**
	 * 영업유형코드(Combo)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectTypeCd(Map<String, Object> mapParam) throws Exception {
		return commonDAO.selectTypeCd(mapParam);
	}
	
	/**
	 * 전표유형에 해당하는 시스템코드Combo 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectSysClassBySlipType(Map<String, Object> mapParam) throws Exception {
		return commonDAO.selectSysClassBySlipType(mapParam);
	}

	/**
	 * 사업부에 해당하는 시스템코드Combo 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectSysClassByMuCd(Map<String, Object> mapParam) throws Exception {
		return commonDAO.selectSysClassByMuCd(mapParam);
	}
	
	/**
	 * 사업부에 해당하는 전표유형Combo 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectSlipTypeByMuCd(Map<String, Object> mapParam) throws Exception {
		return commonDAO.selectSlipTypeByMuCd(mapParam);
	}
	
	/**
	 * 용역 시급정보(Combo)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectDutyAmt(Map<String, Object> mapParam) throws Exception {
		return commonDAO.selectDutyAmt(mapParam);
	}

	/**
	 * 보유계좌정보를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectAcntCd(Map<String, Object> mapParam) throws Exception {
		return commonDAO.selectAcntCd(mapParam);
	}
	
	/**
	 * 회사코드(BU_CD)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectBuCd(Map<String, Object> mapParam) throws Exception {
		return commonDAO.selectBuCd(mapParam);
	}
	
	/**
	 * 사업부를 조회한다.(영업회계 공통)
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet getMuCd(Map<String, Object> mapParam) throws Exception {
		return commonDAO.getMuCd(mapParam);
	}

	/**
	 * 팀을 조회한다.(영업회계 공통)
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet getTmCd(Map<String, Object> mapParam) throws Exception {
		return commonDAO.getTmCd(mapParam);
	}
	
	/**
	 * CC를 조회한다.(영업회계 공통)
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet getCcCd(Map<String, Object> mapParam) throws Exception {
		return commonDAO.getCcCd(mapParam);
	}
	
	/**
	 * 업장을 조회한다.(영업회계 공통)
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet getUpjangCd(Map<String, Object> mapParam) throws Exception {
		return commonDAO.getUpjangCd(mapParam);
	}

	/**
	 * 영업현금 잔액 체크
	 * @return String 조회결과
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String getCashAltYn(DataSetMap list) throws Exception {
		String sCashAltYn	= "Y";
		int applyAmt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			applyAmt = Integer.parseInt(rowData.get("receiveAmt").toString());
			if("Y".equals(sCashAltYn) && applyAmt > 0){
				sCashAltYn = commonDAO.getCashAltYn(rowData);
			}
		}
		return sCashAltYn;
	}
	
	/**
	 * 채권(입금) 잔액 체크
	 * @return String 조회결과
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String getArReceiveYn(DataSetMap list) throws Exception {
		String arReceiveYn	= "Y";
		int applyAmt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			applyAmt = Integer.parseInt(rowData.get("receiveAmt").toString());
			if("Y".equals(arReceiveYn) && applyAmt != 0){
				arReceiveYn = commonDAO.getArReceiveYn(rowData);
			}
		}
		return arReceiveYn;
	}
}
