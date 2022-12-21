package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.srm.dao.InternalUsePrcStatusDAO;

 /**
 * 내부이용 처리 내역을 관리하는 InternalUsePrcStatus Service Implementation
 * 
 * @ClassName InternalUsePrcStatusServiceImpl.java
 * @Description InternalUsePrcStatusServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.30    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/srm/internalUsePrcStatusService")
public class InternalUsePrcStatusServiceImpl extends DefaultServiceImpl implements InternalUsePrcStatusService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** InternalUsePrcStatusDAO Bean 생성 */
	@Resource(name = "/sm/srm/internalUsePrcStatusDAO")
	private InternalUsePrcStatusDAO internalUsePrcStatusDAO;
	

	/**
	 * 내부이용 처리 내역 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return internalUsePrcStatusDAO.selectList(mapParam);
	}

}
