package com.hwfs.fm.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;

/**
* FM 공통 Service Implementation
* 
* @ClassName FmCommonServiceImpl.java
* @Description FmCommonServiceImpl Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2021.07.07   DEV02        최초생성
* </pre>
* @author [PJT]주문채널통합 : DEV02
* @since 2021.07.07
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/

@Service("/fm/fms/fmCommonService")
public class FmCommonServiceImpl extends DefaultServiceImpl implements FmCommonService {
	
	
	/** FmCommonDAO Bean 생성 */
	@Resource(name = "/fm/cmn/fmCommonDAO")
	private com.hwfs.fm.cmn.dao.FmCommonDAO fmCommonDAO;
	

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/**
	 * 자재 중분류를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectItemClassM(Map<String, Object> mapParam) throws Exception {
		if(mapParam != null) mapParam.put("classType", "M");
		return fmCommonDAO.selectItemClass(mapParam);
	}
	
	/**
	 * 자재 소분류를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectItemClassS(Map<String, Object> mapParam) throws Exception {
		if(mapParam != null) mapParam.put("classType", "S");
		return fmCommonDAO.selectItemClass(mapParam);
	}
	
	/**
	 * 자재 세분류를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectItemClassD(Map<String, Object> mapParam) throws Exception {
		if(mapParam != null) mapParam.put("classType", "D");
		return fmCommonDAO.selectItemClass(mapParam);
	}
}
