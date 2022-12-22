package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;
import java.util.Map;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsl.dao.CardPopupDAO;

 /**
 * 카드사팝업하는 CardPopup Service Implementation
 * 
 * @ClassName CardPopupServiceImpl.java
 * @Description CardPopupServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.28    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.05.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsl/cardPopupService")
public class CardPopupServiceImpl extends DefaultServiceImpl implements CardPopupService {
	
	/** CardPopupDAO Bean 생성 */
	@Resource(name = "/fs/fsl/cardPopupDAO")
	private CardPopupDAO cardPopupDAO;
	

	/**
	 * 카드사팝업 목록을 조회한다.
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
		return cardPopupDAO.selectList(mapParam);
	}
	
	public RecordSet selectMealList(Map<String, Object> mapParam) throws Exception {
		return cardPopupDAO.selectMealList(mapParam);
	}

}
