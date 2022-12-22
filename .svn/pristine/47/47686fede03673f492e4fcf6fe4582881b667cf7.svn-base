package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.ZipSearchDAO;

 /**
 * ZipSearchServiceImpl에 대한 설명 작성
 * @ClassName ZipSearchServiceImpl.java
 * @Description ZipSearchServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 2.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/zipSearchService")
public class ZipSearchServiceImpl extends DefaultServiceImpl implements ZipSearchService {
	@Resource(name="/sc/cmn/zipSearchDAO")
	private ZipSearchDAO zipSearch;
	
	/**
	 * 도로명 주소에 대한 시도 조건 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.service.ZipSearchService#selectSidoList()
	 */
	@Override
	public RecordSet selectSidoList() {
		return zipSearch.selectSidoList();
	}

	/**
	 * 도로명 주소에 대한 시구군 조건 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.ZipSearchService#selectGugunList(java.util.Map)
	 */
	@Override
	public RecordSet selectGugunList(Map<String, Object> parameter) {
		return zipSearch.selectGugunList(parameter);
	}

	/**
	 * 조건에 맞는 도로명 주소를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.ZipSearchService#selectRoadList(java.util.Map)
	 */
	@Override
	public RecordSet selectRoadList(Map<String, Object> parameter) {
		return zipSearch.selectRoadList(parameter);
	}

	/**
	 * 조건에 맞는 지번 주소를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.ZipSearchService#selectJibunList(java.util.Map)
	 */
	@Override
	public RecordSet selectJibunList(Map<String, Object> parameter) {
		return zipSearch.selectJibunList(parameter);
	}

}
