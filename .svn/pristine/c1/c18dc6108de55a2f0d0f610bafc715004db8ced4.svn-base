package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.UpjangChangeDAO;

/**
 * 업장을 변경하는 UpjangChange Service Implementation
 *
 * @ClassName UpjangChangeServiceImpl.java
 * @Description UpjangChangeServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.13    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.13
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/upjangChangeService")
public class UpjangChangeServiceImpl extends DefaultServiceImpl implements
		UpjangChangeService {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangChangeDAO Bean 생성 */
	@Resource(name = "/sc/cmn/upjangChangeDAO")
	private UpjangChangeDAO upjangChangeDAO;

	/**
	 * 업장변경 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return upjangChangeDAO.selectList(mapParam);
	}
}
