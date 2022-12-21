package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmf.dao.SaleSumYearDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 월별매출집계 Service Implementation
 * 
 * @ClassName SaleSumYearServiceImpl.java
 * @Description SaleSumYearServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.10.19     유선미	  최초생성
 * </pre>
 * @author 유선미
 * @since 2017.10.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmf/saleSumYearService")
public class SaleSumYearServiceImpl extends DefaultServiceImpl implements SaleSumYearService {
	
	/** SaleSumYearDAO Bean 생성 */
	@Resource(name = "/fm/fmf/saleSumYearDAO")
	private SaleSumYearDAO saleSumYearDAO;
	

	/**
	 * 월별매출집계 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return saleSumYearDAO.selectList(mapParam);
	}
}
