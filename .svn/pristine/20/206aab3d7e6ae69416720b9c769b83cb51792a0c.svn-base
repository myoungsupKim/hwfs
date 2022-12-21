package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 우편번호 검색에 대한 설명 작성
 * @ClassName ZipSearchDAO.java
 * @Description ZipSearchDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 2.   김재섭      최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/zipSearchDAO")
public class ZipSearchDAO extends DefaultDAO {
	
	/**
	 * 도로명 주소 검색 조건에 대한 시도 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @return
	 */
	public RecordSet selectSidoList() {
		Map<String, Object> parameter = new HashMap<String, Object>();
		return queryForRecordSet("sc.cmn.zipSearchDAO.selectSidoList", parameter);
	}
	
	/**
	 * 도로명 주소 검색 조건에 대한 시구군 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectGugunList(Map<String, Object> parameter) {
		return queryForRecordSet("sc.cmn.zipSearchDAO.selectGugunList", parameter);
	}
	
	/**
	 * 조건에 맞는 도로명 주소를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRoadList(Map<String, Object> parameter) {
		return queryForRecordSet("sc.cmn.zipSearchDAO.selectRoadList", parameter);
	}
	
	/**
	 * 조건에 맞는 도로명 주소를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectJibunList(Map<String, Object> parameter) {
		return queryForRecordSet("sc.cmn.zipSearchDAO.selectJibunList", parameter);
	}
}
