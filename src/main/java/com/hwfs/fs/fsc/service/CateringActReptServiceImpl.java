package com.hwfs.fs.fsc.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsc.dao.CateringActReptDAO;

 /**
 * 케터링 실적보고(행사실적)하는 CateringActRept Service Implementation
 * 
 * @ClassName CateringActReptServiceImpl.java
 * @Description CateringActReptServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17    yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsc/cateringActReptService")
public class CateringActReptServiceImpl extends DefaultServiceImpl implements CateringActReptService {

	/** CateringActReptDAO Bean 생성 */
	@Resource(name = "/fs/fsc/cateringActReptDAO")
	private CateringActReptDAO cateringActReptDAO;
	

	/**
	 * 케터링 실적보고(행사실적) 목록을 조회한다.
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
	public RecordSet selectCeleList(Map<String, Object> mapParam) throws Exception {
		return cateringActReptDAO.selectCeleList(mapParam);
	}
	
	/**
	 * 케터링 실적보고(조리인력 지원실적)  목록을 조회한다.
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
	public RecordSet selectCookHumanList(Map<String, Object> mapParam) throws Exception {
		return cateringActReptDAO.selectCookHumanList(mapParam);
	}


}
