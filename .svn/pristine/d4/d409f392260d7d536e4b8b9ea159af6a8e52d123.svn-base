package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.MenuMgntInqDAO;

 /**
 * 할인 전 후 재료비율비교를 관리하는 MenuMgntInq Implementation
 * 
 * @ClassName MenuMgntInqServiceImpl.java
 * @Description MenuMgntInqServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.11    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백승현
 * @since 2016.08.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Service("/rc/rrm/menuMgntInqService")
public class MenuMgntInqServiceImpl extends DefaultServiceImpl implements MenuMgntInqService
{
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MenuMgntInqDAO Bean 생성 */
	@Resource(name = "/rc/rrm/menuMgntInqDAO")
	private MenuMgntInqDAO menuMgntInqDAO;
	
	/**
	 * 할인 전 후 재료비율비교 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
			return menuMgntInqDAO.selectList(mapParam);
	}
}