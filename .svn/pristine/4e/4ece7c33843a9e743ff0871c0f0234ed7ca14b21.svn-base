package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.srm.dao.SapSlipNonUpoadListDAO;

/**
 * SAP 미발행 전표현황을 조회하는 SapSlipNonUpoadList Service Implementation
 * 
 * @ClassName SapSlipNonUpoadListServiceImpl.java
 * @Description SapSlipNonUpoadListServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.10    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.09.10
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/srm/sapSlipNonUpoadListService")
public class SapSlipNonUpoadListServiceImpl extends DefaultServiceImpl
		implements SapSlipNonUpoadListService {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SapSlipNonUpoadListDAO Bean 생성 */
	@Resource(name = "/sm/srm/sapSlipNonUpoadListDAO")
	private SapSlipNonUpoadListDAO sapSlipNonUpoadListDAO;

	/**
	 * SAP 미발행 전표 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return sapSlipNonUpoadListDAO.selectList(mapParam);
	}

}
