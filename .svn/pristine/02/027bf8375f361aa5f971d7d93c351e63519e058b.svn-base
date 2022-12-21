package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.CardReceiveCalendarMgntDAO;

 /**
 * 카드 입금 일정표하는 CardReceiveCalendarMgnt Service Implementation
 * 
 * @ClassName CardReceiveCalendarMgntServiceImpl.java
 * @Description CardReceiveCalendarMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/cardReceiveCalendarMgntService")
public class CardReceiveCalendarMgntServiceImpl extends DefaultServiceImpl implements CardReceiveCalendarMgntService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CardReceiveCalendarMgntDAO Bean 생성 */
	@Resource(name = "/sm/sar/cardReceiveCalendarMgntDAO")
	private CardReceiveCalendarMgntDAO cardReceiveCalendarMgntDAO;
	

	/**
	 * 카드 입금 일정표 목록을 조회한다.
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
		return cardReceiveCalendarMgntDAO.selectList(mapParam);
	}

	/**
	 * 카드 입금 일정표 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Merge 처리
			
			insRowCnt += cardReceiveCalendarMgntDAO.insert(rowData);

		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
