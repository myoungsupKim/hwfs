package com.hwfs.ei.cmn.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 통합회계에서 공통으로 호출하는 FsspCommon DAO
 * 
 * @ClassName FsspCommonDAO.java
 * @Description FsspCommonDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.23   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김재섭
 * @since 2015.11.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ei/cmn/fsspCommonDAO")
public class FsspCommonDAO extends DefaultDAO {
	
	/**
	 * 특판 시즌정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSeason(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.cmn.fsspCommonDAO.selectSeason", parameter);
	}
	
	/**
	 * 공통코드를 조회한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectCommonCode(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.cmn.fsspCommonDAO.selectCommonCode", parameter);
	}
	
	/**
	 * 상품분류3에 대한 값을 조회한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectItemClass3(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.cmn.fsspCommonDAO.selectItemClass3", parameter);
	}

	/**
	 * 상품분류4에 대한 값을 조회한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectItemClass4(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.cmn.fsspCommonDAO.selectItemClass4", parameter);
	}
	
	/**
	 * PO Code를 조회한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectPoCode(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.cmn.fsspCommonDAO.selectPoCode", parameter);
	}
	
	/**
	 * 부문(BU)를 조회한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectBu(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ei.cmn.fsspCommonDAO.selectBu", parameter);
	}
	
	/**
	 * 사업장에 상품 생성여부 확인
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectCreateBrchItem(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("ei.cmn.fsspCommonDAO.selectCreateBrchItem", parameter);
	}
	
	/**
	 * 영업장에 상품 생성여부 확인
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectCreateLocItem(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("ei.cmn.fsspCommonDAO.selectCreateLocItem", parameter);
	}
}
