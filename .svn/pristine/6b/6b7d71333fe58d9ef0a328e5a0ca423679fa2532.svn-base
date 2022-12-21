package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.SapHwfcGapMonDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * SAP HWFC 거래처별 잔액비교 SapHwfcGapMon Service Implementation
 * 
 * @ClassName SapHwfcGapMonServiceImpl.java
 * @Description SapHwfcGapMonServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.09.20    김호석        최초생성
 * </pre>
 * @author 
 * @since 2018.09.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2018 by HANWHA System/ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/sapHwfcGapMonService")
public class SapHwfcGapMonServiceImpl extends DefaultServiceImpl implements SapHwfcGapMonService {
	
	/** SapHwfcGapMon Bean 생성 */
	@Resource(name = "/sm/sar/sapHwfcGapMonDAO")
	private SapHwfcGapMonDAO sapHwfcGapMonDAO;
	

	/**
	 * SAP HWFC 거래처별 잔액비교 조회한다.
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
		return sapHwfcGapMonDAO.selectList(mapParam);
	}

	
}
