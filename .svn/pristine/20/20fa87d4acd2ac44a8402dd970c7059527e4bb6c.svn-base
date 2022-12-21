package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmf.dao.BrandBuySaleSumDAO;

 /**
 * 매출현황(브랜드) 일자별집계 조회하는 BrandBuySaleSum Service Implementation
 * 
 * @ClassName BrandBuySaleSumServiceImpl.java
 * @Description BrandBuySaleSumServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.09.12   DEV02        최초생성
 * 
 * </pre>
 * @author [PJT]주문채널통합 : DEV02
 * @since 2021.09.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmf/brandBuySaleSumService")
public class BrandBuySaleSumServiceImpl extends DefaultServiceImpl implements BrandBuySaleSumService {
	
	/** BuySaleSumDAO Bean 생성 */
	@Resource(name = "/fm/fmf/brandBuySaleSumDAO")
	private BrandBuySaleSumDAO brandBuySaleSumDAO;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 매출현황(브랜드) 일자별집계 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return brandBuySaleSumDAO.selectList(mapParam);
	}
	
	/**
	 * 매출현황(브랜드) 브랜드유통 관리부서 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectBrandTm(Map<String, Object> mapParam) throws Exception {
		return brandBuySaleSumDAO.selectBrandTm(mapParam);
	}
}
