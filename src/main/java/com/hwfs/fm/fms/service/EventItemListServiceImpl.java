package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.EventItemListDAO;

/**
* 행사상품을 조회하는 Service Implementation
* 
* @ClassName EventItemListServiceImpl.java
* @Description EventItemListServiceImpl Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2021.07.30   	DEV02        최초생성
* </pre>
* @author [PJT]주문채널통합 : DEV02
* @since 2021.07.30
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/

@Service("/fm/fms/eventItemListService")
public class EventItemListServiceImpl extends DefaultServiceImpl implements EventItemListService {
	
	
	/** eventItemListDAO Bean 생성 */
	@Resource(name = "/fm/fms/eventItemListDAO")
	private EventItemListDAO eventItemListDAO;
	

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/**
	 * 행사상품을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectEventItemList(Map<String, Object> mapParam) throws Exception {
		return eventItemListDAO.selectEventItemList(mapParam);
	}
}
