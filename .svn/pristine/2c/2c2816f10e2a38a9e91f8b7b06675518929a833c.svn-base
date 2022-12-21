package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.SystemChangeDAO;

 /**
 * 권한에 따른 시스템을 표시하는 SystemChange Service Implementation
 *
 * @ClassName SystemChangeServiceImpl.java
 * @Description SystemChangeServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.15
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/systemChangeService")
public class SystemChangeServiceImpl extends DefaultServiceImpl implements SystemChangeService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SystemChangeDAO Bean 생성 */
	@Resource(name = "/sc/cmn/systemChangeDAO")
	private SystemChangeDAO systemChangeDAO;


	/**
	 * 권한에 따른 시스템 목록을 조회한다.
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
	public RecordSet selectList() throws Exception {

		if (super.propertiesService.getBoolean("authority.apply")) return systemChangeDAO.selectAuthList();
		else return systemChangeDAO.selectList();
	}
}
