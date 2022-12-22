package com.hwfs.ei.isa.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.sc.cmn.defaults.DefaultIrisDAO;

 /**
 * FsspIrisDAO에 대한 설명 작성
 * @ClassName FsspIrisDAO.java
 * @Description FsspIrisDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 12. 11.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 12. 11.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ei/isa/fsspIrisDAO")
public class FsspIrisDAO extends DefaultIrisDAO {
	
	
	/**
	 * 사업장 조회
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectBrch(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspIrisDAO.selectBrch", parameter);
	}

	/**
	 * 영업장 조회
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectLoc(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspIrisDAO.selectLoc", parameter);
	}
	
	public RecordSet selectReceiptTitle(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspIrisDAO.selectReceiptTitle", parameter);
	}

	/**
	 * 매출계정
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectSellType(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspIrisDAO.selectSellType", parameter);
	}

	/**
	 * 매출형태
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectCmisYn(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspIrisDAO.selectCmisYn", parameter);
	}

	/**
	 * FO 매출유형
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectDrctCmisCd(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspIrisDAO.selectDrctCmisCd", parameter);
	}
	
	/**
	 * 상품종복체크
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectExistsGoods(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("ei.isa.fsspIrisDAO.selectExistsGoods", parameter);
	}
	
	/**
	 * 특판상품(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertGoods(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspIrisDAO.insertGoods", mapParam);
	}
	
	/**
	 * 특판상품(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateGoods(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspIrisDAO.updateGoods", mapParam);
	}

	/**
	 * 상품가격 중복체크
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectExistsPrice(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("ei.isa.fsspIrisDAO.selectExistsPrice", parameter);
	}
	
	/**
	 * 특판상품(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertPrice(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspIrisDAO.insertPrice", mapParam);
	}
	
	/**
	 * 특판상품(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updatePrice(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspIrisDAO.updatePrice", mapParam);
	}

	/**
	 * 사업자번호에 해당하는 거래처가 있는지 확인한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectCustomer(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("ei.isa.fsspIrisDAO.selectCustomer", parameter);
	}
	
	/**
	 * POS 번호
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectPos(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspIrisDAO.selectPos", parameter);
	}
	
	/**
	 * VAN 정보 
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectVanInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("ei.isa.fsspIrisDAO.selectVanInfo", parameter);
	}
	
	public int insertTranLog(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspIrisDAO.insertTranLog", mapParam);
	}
	
	public int deleteTranLog(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspIrisDAO.deleteTranLog", mapParam);
	}
	
	public int insertRegiLog(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspIrisDAO.insertRegiLog", mapParam);
	}
	
	public Record selectExistsRegiLog(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("ei.isa.fsspIrisDAO.selectExistsRegiLog", mapParam);
	}
	
	public int updateRegiLog(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspIrisDAO.updateRegiLog", mapParam);
	}
}
