package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식자재영업 표준단가 생성하는 SalePriceAutoCreate DAO
 * 
 * @ClassName SalePriceAutoCreateDAO.java
 * @Description SalePriceAutoCreateDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.31
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/salePriceAutoCreateDAO")
public class SalePriceAutoCreateDAO extends DefaultDAO {
	
	/**
	 * 식자재영업 표준단가 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceAutoCreateDAO.selectList", mapParam);
	}

	/**
	 * 식자재영업 납품업체 거래처를 조회한다.(팝업)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCust(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceAutoCreateDAO.selectCust", mapParam);
	}

	
	/**
	 * 단가이력을 조회한다.(팝업)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHist(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceAutoCreateDAO.selectHist", mapParam);
	}
	
	
	/**
	 * 구매단가정보 건수를 체크한다.
	 * 단가생성할 업장에 대한 단가구매정보 여부 체크 후 실제 생성함
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public int selectPriceCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fms.salePriceAutoCreateDAO.selectPriceCnt", mapParam);
	}

	
	/**
	 * 판매단가자동생성시 max contract id 조회
	 * update 내에 함수 사용시 오류 발생하므로 함수결과를 받아와 다음 쿼리문에 주입
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public RecordSet selectContractId(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceAutoCreateDAO.selectContractId", mapParam);
	}
	
	
	/**
	 * 식자재영업 표준단가(을)를 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceAutoCreateDAO.insert", mapParam);
	}
	
	/**
	 * 식자재영업 표준단가(을) 정보의 계약종료일(CONTRACT_END)를 UPDATE한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceAutoCreateDAO.updateDate", mapParam);
	}
	public int updateDateNon(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceAutoCreateDAO.updateDateNon", mapParam);
	}
	public int updateDate3(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceAutoCreateDAO.updateDate3", mapParam);
	}
	

	/**
	 * 업장별 단가생성 작업결과를 UPDATE한다(성공시에만 처리한다)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMsg(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceAutoCreateDAO.updateMsg", mapParam);
	}
	
	
}
